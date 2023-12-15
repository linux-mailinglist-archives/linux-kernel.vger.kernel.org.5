Return-Path: <linux-kernel+bounces-388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3C814063
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A3C1F22D90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9FE468C;
	Fri, 15 Dec 2023 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dWiN6hF/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85C1FBC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3DgV6bM9pzxTQgOaG78i0iewW9nAM9YLRB4sGQNnMvs=; b=dWiN6hF/55uDTgyc7XcNN3ykE5
	jOvx1nMdiEtmq9cuqFtv/KpLwgr5gEZhr3ssLp9gMHSTczLIK4GGjEVKvQ3Y1IR8zDIdXezZQ115U
	Ene2NfA7LFDkMFTrhaFG0GkYioYsuxQkH0Ppg2VTwCAzmF8hh/s8966iuRqtDgjZ345ltcNSgZSdy
	ErDLHHKPKITU+0UhaIXx3nEQJbQuzVrDvuvhZBgbGM30DnFh+R+FBa/nP4NZ6KuhuMvOz/6OJz2j0
	B62qSycDc4i7SZoUB56aaDFfkGe6vzBQ2awW3etoTC3iqNWc8KZ/BMN3er0jWlcTP43V/Ih+GB7VZ
	rJXhF3tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDyWr-00Cl0h-Gv; Fri, 15 Dec 2023 03:06:21 +0000
Date: Fri, 15 Dec 2023 03:06:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Message-ID: <ZXvCrfKfgwRwZTLA@casper.infradead.org>
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
 <ZXuJKAInbgtuSU9b@casper.infradead.org>
 <9792a7f5-62cd-45e1-b7d6-406592cc566d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9792a7f5-62cd-45e1-b7d6-406592cc566d@oracle.com>

On Thu, Dec 14, 2023 at 03:59:00PM -0800, Jianfeng Wang wrote:
> On 12/14/23 3:00 PM, Matthew Wilcox wrote:
> > On Thu, Dec 14, 2023 at 02:27:17PM -0800, Jianfeng Wang wrote:
> >> When unmapping VMA pages, pages will be gathered in batch and released by
> >> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
> >> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
> >> which calls lru_add_drain() to drain cached pages in folio_batch before
> >> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
> >> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
> >>
> >> Remove lru_add_drain() prior to gathering and unmapping pages in
> >> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
> >>
> >> Note that the page unmapping process in oom_killer (e.g., in
> >> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
> >> redundant lru_add_drain(). So, this commit makes the code more consistent.
> > 
> > Shouldn't we put this in __tlb_gather_mmu() which already has the
> > CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
> > zap_page_range_single() too.
> > 
> 
> Thanks. It makes sense to me.
> This commit is motivated by a workload that use mmap/unmap heavily.
> While the mmu_gather feature is also used by hugetlb, madvise, mprotect,
> etc., thus I prefer to have another standalone commit (following this one)
> that moves lru_add_drain() to __tlb_gather_mmu() to unify these cases for
> not making redundant lru_add_drain() calls when using mmu_gather.

That's not normally the approach we take.

