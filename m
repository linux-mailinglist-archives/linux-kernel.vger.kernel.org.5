Return-Path: <linux-kernel+bounces-52351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8016849707
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726DA1F21BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E8168D2;
	Mon,  5 Feb 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmPKSKSG"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15A168B1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126733; cv=none; b=gEfubjK659ReYHse4GmIPb3dCAK62xpqAAO8lxs66tmDCNlj7MNeObPTFRDrTb3B3dVlZs4bgLTxNYvmYFRWylzzTHI922834nwAOww8DCPpVj03XXu8K1owTlCe3sWegwc6NavtP6+rkW9hKLWdRX2tk+humLxxsq+LMjNHOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126733; c=relaxed/simple;
	bh=1gRibCZTtK1+s5NCZm0FXVrA0cgk1jLxF/IMDrxTA5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rte2XnKU0c4azApM6V93Jl1D+RcnTMRPHLJAuCCfKUN25pKia3HFoQ5nubM/j4W94lrD0aSHcmGrWzzLTPAp5361x8YITlluCqNYLtaFu18B3qlKG235JhoYPc0XarLoZMWeKvFVX5f9gWXGzUUDkuCk0NGAbT0oVMz5tojU+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmPKSKSG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso3245340a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126731; x=1707731531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVg9hskhux7PEjGeMXb+s3s4PVsJI8bFdR9MvoAyEws=;
        b=BmPKSKSGw2AobV3k/AnPyXpnDdlp2ZRy0UCTRW8yRC60dnaPljO/IvikVF9NQ5DYFb
         TueGdesldhctjrH12RaFC6fdTJQv512K9etaF7KlFF/2C8x0ADVvevnOCY3bv2geDpc9
         BJvx2XTBH3akv6z15dCfPUkyC02YtTpCM2hChqMFduhjGr8QXxWwunXohLAE/xcYhV6g
         u6jDGSvhpMyOKgF2Kip106exxbMPhvUqjVm3gLFV4LPPYVVjFw14Rmh3MwXL6FqqSGVu
         05MIm4FR2erTJK9Pk6+UAABJHdbRKbOCX4eaZfZ9CmZMCRXiAwAFhLe73T/tb+dDoeRn
         RYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126731; x=1707731531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVg9hskhux7PEjGeMXb+s3s4PVsJI8bFdR9MvoAyEws=;
        b=SspmWWoCx6un3t0NhLTAP6WQOjnZiEX2wKk3f8FRnqQSVDRGtarNDkCNllY1k9W8sD
         8dey10phx/cw66r//PD5infBDiN1QoW1Y22t2m49KNq2nZX9jlz+82qIG5pHE3G7zzfO
         gcWVVrxT1NHWlVdEVoeO7U9bPxiHgnCibnXpQZnf1RuB+M4dzbzAVBatxt7LFveUl7rL
         WLsgl06rIzztErSmQb6UuOL+Vm5pAGpxtzJwKiZYnlagBiqzCmJHVdhpqPMjpRXDVgXg
         QOQ46qR2V4jJp1tkSaR2gbXmcfk8ysOduWayXNNT4bd3dBOee4hWbPU+gGJq+PdQ1KrQ
         5Lkw==
X-Gm-Message-State: AOJu0YzociURF+HUvPJGMVri87SWi1WCeeFtmHxij3BWr4pa2oD4IRxz
	x/4VmgvMLG1dtQOcmiyWnK4avdJS2sXwR4/B8R81U1QdDQ01Ekh+
X-Google-Smtp-Source: AGHT+IF0KYsn1e75XuK3ZzHWX/bzYsqDUqLsDtTP/Itf8VwqKIuYJcfA99LoYdl9RtpqpspN9sBA9w==
X-Received: by 2002:a17:903:2344:b0:1d9:9735:ed60 with SMTP id c4-20020a170903234400b001d99735ed60mr5337515plh.34.1707126730684;
        Mon, 05 Feb 2024 01:52:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU7s/j64exoklKubMSmYD/pGjCnwVYO5sbhY1dbDCzGqPgO5JzLrAOLEM/7+DaudPdvXDvg9+DFFqTMjo2a39H0gnn0WXBwfOz2GpuJWW9WJHUHmiwzpbvprLMiILWwdFjZChynunH3w6HC0ZFta0Ew/pHrcEwWHvl9AE4Wu0oTBZNpYZc6IZ2h+sXELotkq2ZJw3SKX8j0qKFu7+FHC7qtN8v0CB1b4lXfM+HnmgOkpaPsswqAFmCMbVo8IgMXQoFneqRi9LUV4P8kp0W15e9SKRmLcAIzwX2zzKEgpHwOrkb1lubNcAQ671JsqOJzZ7Y47EP3/2nSP7yuCj9ntLMd5P6GEfJxon+p1f3gV+VnW7e0+QL7TJHPCi++sxVi05959HA7d5jDmraCCNAweNk7K7qNMZfdT8ji6JHx1uzG+w==
Received: from barry-desktop.hub ([2407:7000:8942:5500:3b9c:8b01:805:3197])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d8ee19ab34sm5970376plw.29.2024.02.05.01.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:52:10 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To: ryan.roberts@arm.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	chrisl@kernel.org,
	surenb@google.com,
	hanchuanhua@oppo.com
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
Date: Mon,  5 Feb 2024 22:51:55 +1300
Message-Id: <20240205095155.7151-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025144546.577640-5-ryan.roberts@arm.com>
References: <20231025144546.577640-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+Chris, Suren and Chuanhua

Hi Ryan,

> +	/*
> +	 * __scan_swap_map_try_ssd_cluster() may drop si->lock during discard,
> +	 * so indicate that we are scanning to synchronise with swapoff.
> +	 */
> +	si->flags += SWP_SCANNING;
> +	ret = __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order);
> +	si->flags -= SWP_SCANNING;

nobody is using this scan_base afterwards. it seems a bit weird to
pass a pointer.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  					if (!can_split_folio(folio, NULL))
>  						goto activate_locked;
>  					/*
> -					 * Split folios without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> +					 * Split PMD-mappable folios without a
> +					 * PMD map right away. Chances are some
> +					 * or all of the tail pages can be freed
> +					 * without IO.
>  					 */
> -					if (!folio_entire_mapcount(folio) &&
> +					if (folio_test_pmd_mappable(folio) &&
> +					    !folio_entire_mapcount(folio) &&
>  					    split_folio_to_list(folio,
>  								folio_list))
>  						goto activate_locked;
> --

Chuanhua and I ran this patchset for a couple of days and found a race
between reclamation and split_folio. this might cause applications get
wrong data 0 while swapping-in.

in case one thread(T1) is reclaiming a large folio by some means, still
another thread is calling madvise MADV_PGOUT(T2). and at the same time,
we have two threads T3 and T4 to swap-in in parallel. T1 doesn't split
and T2 does split as below,

static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
                                unsigned long addr, unsigned long end, 
                                struct mm_walk *walk)
{

                /*   
                 * Creating a THP page is expensive so split it only if we
                 * are sure it's worth. Split it if we are only owner.
                 */
                if (folio_test_large(folio)) {
                        int err; 

                        if (folio_estimated_sharers(folio) != 1)
                                break;
                        if (pageout_anon_only_filter && !folio_test_anon(folio))
                                break;
                        if (!folio_trylock(folio))
                                break;
                        folio_get(folio);
                        arch_leave_lazy_mmu_mode();
                        pte_unmap_unlock(start_pte, ptl);
                        start_pte = NULL;
                        err = split_folio(folio);
                        folio_unlock(folio);
                        folio_put(folio);
                        if (err)
                                break;
                        start_pte = pte =
                                pte_offset_map_lock(mm, pmd, addr, &ptl);
                        if (!start_pte)
                                break;
                        arch_enter_lazy_mmu_mode();
                        pte--;
                        addr -= PAGE_SIZE;
                        continue;
                }    

        return 0;
}



if T3 and T4 swap-in same page, and they both do swap_read_folio(). the
first one of T3 and T4 who gets PTL will set pte, and the 2nd one will
check pte_same() and find pte has been changed by another thread, thus
goto out_nomap in do_swap_page.
vm_fault_t do_swap_page(struct vm_fault *vmf)
{
        if (!folio) {
                if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
                    __swap_count(entry) == 1) {
                        /* skip swapcache */
                        folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
                                                vma, vmf->address, false);
                        page = &folio->page;
                        if (folio) {
                                __folio_set_locked(folio);
                                __folio_set_swapbacked(folio);
                         
                                /* To provide entry to swap_read_folio() */
                                folio->swap = entry;
                                swap_read_folio(folio, true, NULL);
                                folio->private = NULL;
                        }
                } else {
                }
        
        
        /*
         * Back out if somebody else already faulted in this pte.
         */
        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
                        &vmf->ptl);
        if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
                goto out_nomap;

        swap_free(entry);
        pte = mk_pte(page, vma->vm_page_prot);

        set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
        return ret;
}


while T1 and T2 is working in parallel, T2 will split folio. this can
run into race with T1's reclamation without splitting. T2 will split
a large folio into a couple of normal pages and reclaim them.

If T3 finishes swap_read_folio and gets PTL earlier than T4, it calls
set_pte and swap_free. this will cause zRAM to free the slot. then
t4 will get zero data in swap_read_folio() as the below zRAM code
will fill zero for freed slots, 

static int zram_read_from_zspool(struct zram *zram, struct page *page,
                                 u32 index)
{
        ...

        handle = zram_get_handle(zram, index);
        if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
                unsigned long value;
                void *mem;

                value = handle ? zram_get_element(zram, index) : 0; 
                mem = kmap_local_page(page);
                zram_fill_page(mem, PAGE_SIZE, value);
                kunmap_local(mem);
                return 0;
        }
}

usually, after t3 frees swap and does set_pte, t4's pte_same becomes
false, it won't set pte again. So filling zero data into freed slot
by zRAM driver is not a problem at all. but the race is that T1 and
T2 might do set swap to ptes twice as t1 doesn't split but t2 splits
(splitted normal folios are also added into reclaim_list), thus, the
corrupted zero data will get a chance to be set into PTE by t4 as t4
reads the new PTE which is set secondly and has the same swap entry
as its orig_pte after T3 has swapped-in and free the swap entry.

we have worked around this problem by preventing T4 from splitting
large folios and letting it goto skip the large folios entirely in
MADV PAGEOUT once we detect a concurrent reclamation for this large
folio.

so my understanding is changing vmscan isn't sufficient to support
large folio swap-out without splitting. we have to adjust madvise
as well. we will have a fix for this problem in
[PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.com/

But i feel this patch should be a part of your swap-out patchset rather
than the swap-in series of Chuanhua and me :-)

Thanks
Barry

