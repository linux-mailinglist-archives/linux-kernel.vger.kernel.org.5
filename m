Return-Path: <linux-kernel+bounces-7842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB1181AE18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94763287D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1848F48;
	Thu, 21 Dec 2023 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gX/kDnjR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398E8BED
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2zC04biBcA1BX1DOBH2ATIvTR6mxcapHZpr9s+7+ipo=; b=gX/kDnjRM5qvuJs5UqsVh1DEtN
	59jtdoe8/wx6hHnhYxenSkG/dlM4FPFkW8g8HlOfkiMDAez1J303b9KPPZFrna7XzovY1ZmxA0aaB
	E+T/9pBzZXV+fcXMK8foeekpP9JrqktBKFbhROlMJM/lyLd7sAIG76ZeVlPnyrCR5A+z2nLLFQpGN
	Idx3KrYx+CLABup+FV/6m4zupf+qrvqNYbSdVsDDwfb5Th+cAYnxkJsmONyqo418VBrZvhyCqg6TM
	36OVmzIuQB4AkGl7GTBVSoWdQm2KORjrLm7VveF3sf+5U2zAvXVyhoE/wg7wcsHJKPCGOpbhrfmN8
	eS3nt3JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGAr9-004fI2-QE; Thu, 21 Dec 2023 04:40:23 +0000
Date: Thu, 21 Dec 2023 04:40:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 04/40] mm/rmap: introduce and use
 hugetlb_try_dup_anon_rmap()
Message-ID: <ZYPBt6v0JY3QI3QW@casper.infradead.org>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220224504.646757-5-david@redhat.com>

On Wed, Dec 20, 2023 at 11:44:28PM +0100, David Hildenbrand wrote:
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
> hugetlb handling use dedicated hugetlb_* rmap functions.
> 
> Add sanity checks that we end up with the right folios in the right
> functions.
> 
> Note that is_device_private_page() does not apply to hugetlb.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> +static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
> +					  struct folio *folio)

I particularly like it that you introduced this.

> +static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
> +		struct vm_area_struct *vma)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
> +	if (PageAnonExclusive(&folio->page)) {

I wonder if we need a folio_test_hugetlb_anon_exclusive() to make this
a little more ergonomic?

> +		if (unlikely(folio_needs_cow_for_dma(vma, folio)))
> +			return -EBUSY;
> +		ClearPageAnonExclusive(&folio->page);

... and set/clear variants.


