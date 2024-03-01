Return-Path: <linux-kernel+bounces-88705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160786E59B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118641F2276B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70045259B;
	Fri,  1 Mar 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBrnq3u/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94816FF35
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310686; cv=none; b=MHyr+rkxNehNedOlGdH7wUJH5mhYDQv2SLdmzbjmhGMKBQVFpwZSSGDM0F4KyzsVlkeTc+WrzNJFzkBNr6U9QggIDpo+J8FXNCc8VunSeX0D14GyJHqFMtOnGoBdx/2fnWJdnt+QEMYlSRjbYEDhMqA4gEPfmM2lBx6Jx9pvltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310686; c=relaxed/simple;
	bh=SNYuXbTmJzupC2gIrsJ34h63wKcNA1rrd1mPUAsfBgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0PkZ2mvHhJgsBwArEMqhJ9+yHX4VHPboDhlizdJ5uUVMXI8lw0uQ+9Xn8ZQ/ZQlf+B5MySLYfCoQw2xV3Q1+i3ssyB/gri1oenZNDBWG+2adeyU2p/IVxDfJ69E4owX+7oXxlXWcWL8L9lrmJddRq0SifLO3BR74YXKkIkoY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OBrnq3u/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6HJyOrbro+KIiOc29k/CBAdcOESXYJoi3ToEEVFHbH0=; b=OBrnq3u/cUL6/p4MbminaXQJJH
	hPB9OC8nhsdBHQ0QIXcNQI8cLTXM08WxWJ+J3ivMYXdMKbffQNw9H05JryZ52YtXt+R95cZGYWA7d
	QcsR2RIhRvVPU/Fp2oDBBh/12JAd5O6Kw9Da0AaW1oTw/LYBJqruiOmUUMzmKIuiwv2h2GkR0oDII
	dnoj3dVCaoekKBCPFfWzAIEUnT5ob965mz/MKdPOa9IMOakdeMMesg75xa68bp+/DEbpVvBtvTyj/
	oTEKrd0dH4i0/JbIQFNoUdVtJiojXPF/ov3wF2wMx46w/lN03olbKzXzBzkgINITohOpSSiObggI0
	lYE6DL6A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg5my-0000000BMdT-1XZS;
	Fri, 01 Mar 2024 16:31:12 +0000
Date: Fri, 1 Mar 2024 16:31:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Message-ID: <ZeIC0Bn7N0JlP4TY@casper.infradead.org>
References: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
 <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
 <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>

On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
> I've implemented the batching as David suggested, and I'm pretty confident it's
> correct. The only problem is that during testing I can't provoke the code to
> take the path. I've been pouring through the code but struggling to figure out
> under what situation you would expect the swap entry passed to
> free_swap_and_cache() to still have a cached folio? Does anyone have any idea?
> 
> This is the original (unbatched) function, after my change, which caused David's
> concern that we would end up calling __try_to_reclaim_swap() far too much:
> 
> int free_swap_and_cache(swp_entry_t entry)
> {
> 	struct swap_info_struct *p;
> 	unsigned char count;
> 
> 	if (non_swap_entry(entry))
> 		return 1;
> 
> 	p = _swap_info_get(entry);
> 	if (p) {
> 		count = __swap_entry_free(p, entry);
> 		if (count == SWAP_HAS_CACHE)
> 			__try_to_reclaim_swap(p, swp_offset(entry),
> 					      TTRS_UNMAPPED | TTRS_FULL);
> 	}
> 	return p != NULL;
> }
> 
> The trouble is, whenever its called, count is always 0, so
> __try_to_reclaim_swap() never gets called.
> 
> My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT) over
> it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause this
> function to be called for every PTE, but count is always 0 after
> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
> order-0 as well as PTE- and PMD-mapped 2M THP.

I think you have to page it back in again, then it will have an entry in
the swap cache.  Maybe.  I know little about anon memory ;-)

If that doesn't work, perhaps use tmpfs, and use some memory pressure to
force that to swap?

> I'm guessing the swapcache was already reclaimed as part of MADV_PAGEOUT? I'm
> using a block ram device as my backing store - I think this does synchronous IO
> so perhaps if I have a real block device with async IO I might have more luck?
> Just a guess...
> 
> Or perhaps this code path is a corner case? In which case, perhaps its not worth
> adding the batching optimization after all?
> 
> Thanks,
> Ryan
> 

