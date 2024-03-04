Return-Path: <linux-kernel+bounces-90887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F087066D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6321C21275
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71C481DE;
	Mon,  4 Mar 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2GgP9JY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0801481A4;
	Mon,  4 Mar 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568137; cv=none; b=TvxjvUFElWbBX+bRuCZ16odIAIu+61Bene7Za2fk6167xwWpouxFySFL5ApvvXYD9XSwXz8fMz8UE+R7YnX4m8KfihGmSmODRkB2RAcC3xuD669WZscmjuw7SjyDVi+CqeXIhEU6UFtte0qKvWqsvfPT4ryiJdKwNv/stGvrWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568137; c=relaxed/simple;
	bh=6aeG146lJZKJYIn0gNmjq61VFupqwsntOyMazx6QhC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL5pYQE+EyYvFvnqavTiQr+sxtRnRPXte+fjrdf7dk5jAuzzu8yA9AcD5Cg6Xq38akQq4HNpm/WUfu+zatdXHsxKhgH9lh4CxFhDfgQDpwHQv+SGH0HTvGX3tm/kXRivPLpvHL8lBhqT2yqKLgEsv5LhVLk6XxJJwXINMQb4Ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2GgP9JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E0EC433C7;
	Mon,  4 Mar 2024 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709568136;
	bh=6aeG146lJZKJYIn0gNmjq61VFupqwsntOyMazx6QhC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2GgP9JYizNO5RQn3nTDpUL45zlMa6UhKTh0saz8tGnQHZhZVJNw3g9YUKtFZfYX6
	 XwkhDD8BhDOvSyepM63mWwViTfDmjZUPWi/0Yqbcu4ya2IYmBnZ6jE7pHBz84CEwqi
	 mIIVjjegaQGZc0g8+9GYO8W6u3sMLnVhSuEtWOhVZb2JnYCQoMn6oRLzGXDofrhNzu
	 FS+Cr9DakWb2QGk/R/kMoBm7ZWfzyUYAJaz8FmEtY/oSN+Qb738cWincMfo9+y93DQ
	 GWs6MimpPlPkO8O/FfoimO7X+AnErzqIoUFZm/w3NrXm5Msd313vQ5Kr9bh0VW4CJw
	 SiTdPR7pOOsAw==
Date: Mon, 4 Mar 2024 16:02:10 +0000
From: Will Deacon <will@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Christoph Hellwig <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240304160210.GB21077@willie-the-truck>
References: <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304165506.49e3b2d3@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi folks,

On Mon, Mar 04, 2024 at 04:55:06PM +0100, Petr Tesařík wrote:
> On Mon, 4 Mar 2024 13:37:56 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
> > On 04/03/2024 11:00 am, Petr Tesařík wrote:
> > [...]
> > >> Here's my take on tying all the threads together. There are
> > >> four alignment combinations:
> > >>
> > >> 1. alloc_align_mask: zero; min_align_mask: zero

Based on this ^^^ ...

> > >> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
> > >> via swiotlb_map() and swiotlb_tbl_map_single()
> > >>
> > >> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
> > >>
> > >> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
> > >>
> > >> For #1, the returned physical address has no constraints if
> > >> the requested size is less than a page. For page size or
> > >> greater, the discussed historical requirement for page
> > >> alignment applies.

.. and this ^^^ ...


> I believe this patch series is now good as is, except the commit
> message should make it clear that alloc_align_mask and min_align_mask
> can both be zero, but that simply means no alignment constraints.

.. my (possibly incorrect!) reading of the thread so far is that we
should preserve page-aligned allocation in this case if the allocation
size is >= PAGE_SIZE.

Something like the diff below, to replace this final patch?

Will

--->8

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c381a7ed718f..67eac05728c0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -992,6 +992,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
        BUG_ON(!nslots);
        BUG_ON(area_index >= pool->nareas);
 
+       /*
+        * Historically, allocations >= PAGE_SIZE were guaranteed to be
+        * page-aligned in the absence of any other alignment requirements.
+        * Since drivers may be relying on this, preserve the old behaviour.
+        */
+       if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
+               alloc_align_mask = PAGE_SIZE - 1;
+
        /*
         * Ensure that the allocation is at least slot-aligned and update
         * 'iotlb_align_mask' to ignore bits that will be preserved when
@@ -1006,13 +1014,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
         */
        stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
 
-       /*
-        * For allocations of PAGE_SIZE or larger only look for page aligned
-        * allocations.
-        */
-       if (alloc_size >= PAGE_SIZE)
-               stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
-
        spin_lock_irqsave(&area->lock, flags);
        if (unlikely(nslots > pool->area_nslabs - area->used))
                goto not_found;


