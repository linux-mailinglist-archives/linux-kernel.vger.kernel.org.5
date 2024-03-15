Return-Path: <linux-kernel+bounces-104175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77F87CA36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3325CB2273D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7417581;
	Fri, 15 Mar 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDMT0/9U"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1617555
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492395; cv=none; b=Hi7cL+e6mHdcdWWVbVXVHM3EvVbcIL5TrDmBXK71ipAWX+IPziJzHoCmniGFJfLsMpLQ1983KNilFM7/YBVrXnT02cDEvdKnVJHKGBrhwyN/PObrl/MN01hRvNZQwRfQOTx5EPMlvxXd6gWUGMc1m/BGRxuL18UEEQbRFmG867w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492395; c=relaxed/simple;
	bh=HQWoXy2zl52Rs5VYt0a2sm98N3ZHCmAPNtENx3yf2kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh56eDaXH5u30GVCuxB+uj7GpF0MYjlgopePJGhBE/360QPEnbCfC5SIrGlRhwt/9LDjQNNH0cJrJLzbDd6cD8Ui6iXPJCyEZoypfd0zPmYXwcqf6mwec5SN5691/uEXr3XrDWfvX1MGzoh9iQggQL4VJYzuoGwZ1EDqtQFV0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDMT0/9U; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7de12bcec8bso856262241.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710492392; x=1711097192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yns1vOt24BA/xyIkQadDD594v6dr/yXOSU3+VyMFSoo=;
        b=GDMT0/9UezEyhuwm0vuPv4nLuBlvftx2/zaGXP4Oe3u8T5qCtlE87fka+AyM24IxTn
         +cW8lnxZpBOvBDw4+/z+StVFtqdl2Vyff6ZTOegQy3NNeSCGnk7IPqyclTp05KP/vHCT
         XsucPLMJRlniND9RRcIPLm5tO2+Po10kVKATIFH0glwQCJqnQ9ON9qs5tdtQPM2WASH7
         Q+60VE2PgXsdZDclEG6Q5DzrGAsw+3V0DBQ8877IQhfHFjA0jQcrPcJ7nBW+NckXVKqz
         I2y9DoxQsy8d7KdB+E3/WktEBu39p/QnEomwbatVLTDpgggRRsZUWtEBwlMd13YiLY1l
         wxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710492392; x=1711097192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yns1vOt24BA/xyIkQadDD594v6dr/yXOSU3+VyMFSoo=;
        b=krU/LaaWyH9ZCBD8eu56q+JTnA9++lPgEoLd58kSRLrQcONocGg/uEaTRVTDxbO2LX
         z0rUID60duU82Ys0u9A3uEF7vbL60/XQsgHD0L+DBvCOuofzAbWHz8l6fVViB3tSvdMV
         gRGuVyY3G93lzuD1vdkhfc8d7G4ADX0PAkQVRz7LOUsmpJJ5rXBFiQ/sDzYaXbRv1c6T
         1ubdXcNPVQ51L2dqRvgiwNgztRfwMDDHtLfrhgxARm/JiAVzCnq6hhG8T4o2+/9Pah8l
         NUeaxJYq9lwvP/HTNpBVW1ydUQRKkyD226T5uokAzpsCGtiokJZQRHpHfxby3eJFSvVj
         lh/A==
X-Forwarded-Encrypted: i=1; AJvYcCUwGjwssnawwq/KFELJ7f7Zhcrtuxd2QyPxN5ykB9Z4lQasr7LKLkXIx98gk/OTnPV3jR7SN3zvkne3qWMyh5Bg+mCh0r+4F0HMT4+W
X-Gm-Message-State: AOJu0YxelddxXMhaG+DeZ69kFNdhvj44pBBT27xRVbo/+eDy9G4/cWrr
	rznpmlQxrgtq01qGxSA+NA2LQVJj1ThWTkYvRRzCORr9d7Y3VpQcw/7+UKFFvl7rM4IJIZmw+K2
	Cb+wbYTfJhFmusrZwDwEaHe9ciNs=
X-Google-Smtp-Source: AGHT+IGchSgz0yaVThLdBrhKFjUeUGbp4jB/K86ZCto5s63G5RGWY7hEUwnlgS6GpWmAXrH0GLqbu3WKiuwbiz6D7u0=
X-Received: by 2002:a05:6102:1349:b0:475:48c9:c4ed with SMTP id
 j9-20020a056102134900b0047548c9c4edmr4533644vsl.29.1710492392070; Fri, 15 Mar
 2024 01:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141516.31747-1-liuhailong@oppo.com> <20240315081803.2223-1-liuhailong@oppo.com>
In-Reply-To: <20240315081803.2223-1-liuhailong@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Mar 2024 21:46:20 +1300
Message-ID: <CAGsJ_4yMXE_4YuMTczF6u4YYp_TWksi+byszD09E2PT5pK8zfA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not available"
To: liuhailong@oppo.com
Cc: akpm@linux-foundation.org, nathan@kernel.org, ndesaulniers@google.com, 
	trix@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, surenb@google.com, zhaoyang.huang@unisoc.com, 
	quic_charante@quicinc.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:18=E2=80=AFPM <liuhailong@oppo.com> wrote:
>
> From: "Hailong.Liu" <liuhailong@oppo.com>
>
> This reverts
> commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not eli=
gible")
> commit 5da226dbfce3 ("mm: skip CMA pages when they are not available")

Reverting these changes seems inappropriate since the original patches
did improve most cases.
While doing direct reclamation without MOVABLE flags, scanning cma
folio doesn't help at all.

>
> skip_cma may cause system not responding. if cma pages is large in lru_li=
st
> and system is in lowmemory, many tasks would direct reclaim and waste
> cpu time to isolate_lru_pages and return.
>
> Test this patch on android-5.15 8G device
> reproducer:
> - cma_declare_contiguous 3G pages
> - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
>   only.
> - run a memleak process in userspace


I assume that scanning cma folio provides additional opportunities to recla=
im
anonymous memory, even though it is ineffective for allocating NON-MOVABLE
folios. Consequently, we alleviate pressure for future allocations of anony=
mous
folios. Moreover, setting swappiness=3D0 is a rare scenario. Instead of ent=
irely
removing the mechanism, could we detect such corner cases and handle them
differently.

Otherwise, I don't see any chance of this being acknowledged.

>
> trace the trace_mm_vmscan_lru_isolate which get
> [ 1178.059160] 2825  3405 I UsbFfs-worker   : isolate_lru_pages:1895 tota=
l_scan: 24385 skipped: 24382
> [ 1178.059699] 2825  3405 I UsbFfs-worker   : isolate_lru_pages:1895 tota=
l_scan: 24412 skipped: 24401
> [ 1178.061747] 2825  3405 I UsbFfs-worker   : isolate_lru_pages:1895 tota=
l_scan: 24412 skipped: 24401
> From the log, tasks is waste time to scan lru list and call stack as belo=
w.
>
> Task name: UsbFfs-worker [affinity: 0xff] pid: 3374 cpu: 7 prio: 120 star=
t: ffffff8897a35c80
> state: 0x0[R] exit_state: 0x0 stack base: 0xffffffc01eaa0000
> Last_enqueued_ts:       0.000000000 Last_sleep_ts:       0.000000000
> Stack:
> [<ffffffd32ee7d910>] __switch_to+0x180
> [<ffffffd3302022fc>] __schedule+0x4dc
> [<ffffffd330201e08>] preempt_schedule+0x5c
> [<ffffffd33020a4d0>] _raw_spin_unlock_irq+0x54
> [<ffffffd32f14906c>] shrink_inactive_list+0x1d0
> [<ffffffd32f143998>] shrink_lruvec+0x1bc
> [<ffffffd32f147c0c>] shrink_node_memcgs+0x184
> [<ffffffd32f147414>] shrink_node+0x2d0
> [<ffffffd32f146d38>] shrink_zones+0x14c
> [<ffffffd32f142e84>] do_try_to_free_pages+0xe8
> [<ffffffd32f142b08>] try_to_free_pages+0x2e0
> [<ffffffd32f1a8e44>] __alloc_pages_direct_reclaim+0x84
> [<ffffffd32f1a2d58>] __alloc_pages_slowpath+0x4d0
> [<ffffffd32f1a23bc>] __alloc_pages_nodemask[jt]+0x124
> [<ffffffd32f19a220>] __vmalloc_area_node+0x188
> [<ffffffd32f19a540>] __vmalloc_node+0x148
> [<ffffffd32f19a60c>] vmalloc+0x4c
> [<ffffffd32f910218>] ffs_epfile_io+0x258
> [<ffffffd330033780>] kretprobe_trampoline[jt]+0x0
> [<ffffffd330033780>] kretprobe_trampoline[jt]+0x0
> [<ffffffd32f28129c>] __io_submit_one+0x1c0
> [<ffffffd32f280e38>] io_submit_one+0x88
> [<ffffffd32f280c88>] __do_sys_io_submit+0x178
> [<ffffffd32f27eac0>] __arm64_sys_io_submit+0x20
> [<ffffffd32eeabb74>] el0_svc_common.llvm.9961749221945255377+0xd0
> [<ffffffd32eeaba34>] do_el0_svc+0x28
> [<ffffffd32ff21be8>] el0_svc+0x14
> [<ffffffd32ff21b70>] el0_sync_handler+0x88
> [<ffffffd32ee128b8>] el0_sync+0x1b8
>
> Task name: kthreadd [affinity: 0xff] pid: 2 cpu: 7 prio: 120 start: fffff=
f87808c0000
> state: 0x0[R] exit_state: 0x0 stack base: 0xffffffc008078000
> Last_enqueued_ts:       0.000000000 Last_sleep_ts:       0.000000000
> Stack:
> [<ffffffd32ee7d910>] __switch_to+0x180
> [<ffffffd3302022fc>] __schedule+0x4dc
> [<ffffffd330201e08>] preempt_schedule+0x5c
> [<ffffffd33020a4d0>] _raw_spin_unlock_irq+0x54
> [<ffffffd32f149168>] shrink_inactive_list+0x2cc
> [<ffffffd32f143998>] shrink_lruvec+0x1bc
> [<ffffffd32f147c0c>] shrink_node_memcgs+0x184
> [<ffffffd32f147414>] shrink_node+0x2d0
> [<ffffffd32f146d38>] shrink_zones+0x14c
> [<ffffffd32f142e84>] do_try_to_free_pages+0xe8
> [<ffffffd32f142b08>] try_to_free_pages+0x2e0
> [<ffffffd32f1a8e44>] __alloc_pages_direct_reclaim+0x84
> [<ffffffd32f1a2d58>] __alloc_pages_slowpath+0x4d0
> [<ffffffd32f1a23bc>] __alloc_pages_nodemask[jt]+0x124
> [<ffffffd32f19a220>] __vmalloc_area_node+0x188
> [<ffffffd32f19a044>] __vmalloc_node_range+0x88
> [<ffffffd32f0fb430>] scs_alloc+0x1b8
> [<ffffffd32f0fb62c>] scs_prepare+0x20
> [<ffffffd32ef2ce04>] dup_task_struct+0xd4
> [<ffffffd32ef2a77c>] copy_process+0x144
> [<ffffffd32ef2bae4>] kernel_clone+0xb4
> [<ffffffd32ef2c040>] kernel_thread+0x5c
> [<ffffffd32ef618d0>] kthreadd+0x184
>
> Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
> ---
>  mm/vmscan.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f13394b112e..29306c29309f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2261,25 +2261,6 @@ static __always_inline void update_lru_sizes(struc=
t lruvec *lruvec,
>
>  }
>
> -#ifdef CONFIG_CMA
> -/*
> - * It is waste of effort to scan and reclaim CMA pages if it is not avai=
lable
> - * for current allocation context. Kswapd can not be enrolled as it can =
not
> - * distinguish this scenario by using sc->gfp_mask =3D GFP_KERNEL
> - */
> -static bool skip_cma(struct folio *folio, struct scan_control *sc)
> -{
> -       return !current_is_kswapd() &&
> -                       gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABL=
E &&
> -                       get_pageblock_migratetype(&folio->page) =3D=3D MI=
GRATE_CMA;
> -}
> -#else
> -static bool skip_cma(struct folio *folio, struct scan_control *sc)
> -{
> -       return false;
> -}
> -#endif
> -
>  /*
>   * Isolating page from the lruvec to fill in @dst list by nr_to_scan tim=
es.
>   *
> @@ -2326,8 +2307,7 @@ static unsigned long isolate_lru_folios(unsigned lo=
ng nr_to_scan,
>                 nr_pages =3D folio_nr_pages(folio);
>                 total_scan +=3D nr_pages;
>
> -               if (folio_zonenum(folio) > sc->reclaim_idx ||
> -                               skip_cma(folio, sc)) {
> +               if (folio_zonenum(folio) > sc->reclaim_idx) {
>                         nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>                         move_to =3D &folios_skipped;
>                         goto move;
> @@ -4945,7 +4925,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         }
>
>         /* ineligible */
> -       if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> +       if (zone > sc->reclaim_idx) {
>                 gen =3D folio_inc_gen(lruvec, folio, false);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>                 return true;
> --
> Changes in v2:
> - add reproducer
> - fix build error on v6.6-rc7
>
>

Thanks
Barry

