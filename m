Return-Path: <linux-kernel+bounces-23809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533882B201
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88581F21E67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBCD4CE0A;
	Thu, 11 Jan 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a8FjhmeW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264844CDE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sR5kHhCjagV8uFMXl3/LAFaeai/wqgvLhgx2A6zTtjM=; b=a8FjhmeWa6TJk6IBOqdChOdsYT
	I9GmztgxE+FHG6rrPOmwl8E6jduXfoiTjhUSh7R98ZmFvu2a2F3r+sHl29XtJTO1bQqm3FttR9PTD
	sE3bNiXz3mvA9lkxkFK9cWB7EfVkQV38ZZscJapxiARKVTDlYtvR/GQHYC2Xh/G4X6KJPuMPUocDv
	YjzW2LChvj6egeHtHLieE0rpYyzCVHI984BwY+6myf1MrvOu7hyUhzuZvWhVPN+KA9B+WbuJV1zwe
	7/RCKlTRMuE575YJqpPhiTgRBaE1Q5v//sjCWHX1y5uU5vq3T0ZSPNd+vqQfaPYyLIJk+wkE1NzJr
	dHc2rihQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNxCp-00ECOD-8R; Thu, 11 Jan 2024 15:42:55 +0000
Date: Thu, 11 Jan 2024 15:42:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
	mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v5 4/7] mm: Separate move/undo doing on folio list from
 migrate_pages_batch()
Message-ID: <ZaAMf5JX2D3N7Epi@casper.infradead.org>
References: <20240111060757.13563-1-byungchul@sk.com>
 <20240111060757.13563-5-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111060757.13563-5-byungchul@sk.com>

On Thu, Jan 11, 2024 at 03:07:54PM +0900, Byungchul Park wrote:
> +static void migrate_folios_move(struct list_head *src_folios,
> +		struct list_head *dst_folios,
> +		free_folio_t put_new_folio, unsigned long private,
> +		enum migrate_mode mode, int reason,
> +		struct list_head *ret_folios,
> +		struct migrate_pages_stats *stats,
> +		int *retry, int *thp_retry, int *nr_failed,
> +		int *nr_retry_pages)
> +{
> +	struct folio *folio, *folio2, *dst, *dst2;
> +	bool is_thp;
> +	int nr_pages;
> +	int rc;
> +
> +	dst = list_first_entry(dst_folios, struct folio, lru);
> +	dst2 = list_next_entry(dst, lru);
> +	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
> +		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);

You don't need to call folio_test_large() first.  folio_order() includes
a call to test_large() so it can return 0.

> +		nr_pages = folio_nr_pages(folio);

.. or since you're calculating this anyway,

		is_thp = nr_pages >= HPAGE_PMD_NR
perhaps


