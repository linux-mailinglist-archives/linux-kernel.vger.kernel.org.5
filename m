Return-Path: <linux-kernel+bounces-103634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE8D87C237
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F4AB226E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084774BEB;
	Thu, 14 Mar 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZSV25oT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5974297
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438482; cv=none; b=sR80CFYnAxQ4AQ4SG+SUjGkX51pgWBUGGTlCt+MHc756BjFlI9MAJhj2DxCATh/VEs+BEQ35kms2J57AVkCIgQUWQM0Ln03qL4oJ7VYb8sTJKOpXDuWpd7Bu/5vwdQNa/libwU99a0SgAsrUzB/l8Qfc52FMMcHKzCWlryo7WAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438482; c=relaxed/simple;
	bh=q1LPenCDNdcBSutkq0Nq6yhy0rl+ccCriK1caPK76QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiIZB/qgofHFmSH8kMCRmQf7KODjN46MKQ7oYfEh0NcTN9HUfTZVbIgtKgvfFl7foqX40AkNxm5+7PsCvk1CBst9MDA5q4qxLFypp1L1BsvkziMouQrftXsdzYfC9QjeM234l4mnLHdLtjVDILqSzlqSyEU2MwL9VoAR6n9HgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oZSV25oT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso9005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710438478; x=1711043278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+JV3A7zu6nIaIvNDYv5nSo/ckyKnBKjeigqrs00bqQ=;
        b=oZSV25oTVsLsoeBrHTH7Ubbt1KQPk/T0pAusGoQ7KdS2fDfVkaQ5pwXGDcDqS6SFFQ
         6Qvh0OdagffHuZ3E32/bP+z1/xRb8Jd8S/wJPqtVfyp3McH53dVz6BSlhWqVJiDdR9GE
         XySeCL/hAEy/fd67FsHWVjWoQjcoIvT8L3GWTjApqJSN829JGRaRdSQFPAHbg6YTEj6o
         BefKGLxEVBN96LS8s4cY+8qdCWXc/tFrCQ+6ihrimNfN11ptXT3jwdeiB2RUNrfOhS3m
         yValG1vXiRlmBh0ihvGchg1tN3U0Rzw2JwbR4TZJ4+ofoQJ+lnMaIP6grTu9QfNAYIrM
         639A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438478; x=1711043278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+JV3A7zu6nIaIvNDYv5nSo/ckyKnBKjeigqrs00bqQ=;
        b=uSO2OMCaSr/2ivJ1XNVKnMGyn1Rc45BiPrnpvOiyzPURO0VJhgqsxIgOCtjK6Qxvx1
         M8zZyfwsOsPKWxy43ClQUroA/ny1A6TmQ2pDxtiAB9z9YTW3BOPmq2DSb27P2tzQJ5Jq
         ZCBqxjHl5wQFpzSF6osEqcUQCzW0Xy2cO2kuUrqjyx68UeOqSS9+QyXyWfrEaFWUbDOA
         pN0Rz4yY+vrixkEI8SCL31vgA0MMEttACikgD5ABIAKG7Xw52es9OI8OLkVPVyZZvY0i
         b+oocfMeFgIWlEst2JTul6QgULjgLTV0DJmViDTNEcn1KB04B8RnuudD+SFo+XNwMFmx
         cA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtIrcEpjRrKDu5qipw/r/1lfaC4RljLrvDClmjOxv9tfffvaLLhJDfJU1kN8Rob+g0QwF3GNT5dUFEKGWvbqCeHabHwX4eD2frrtWS
X-Gm-Message-State: AOJu0Yzav1P7lKAOXSe6qb3abU+E2i9SOdoHIAgXHjJruE7oru7Azpf1
	QU95DANhhIk7UDj1AzZP+ZvswbeNufkyvBm7gLWdH6rRV/DoIrsP9+STnWxWPN+2Y5aKKdmGgh1
	1wM5W/d/UZXw8rMPGHyJ0Qz4xWnjyaB2T3QfU
X-Google-Smtp-Source: AGHT+IFy6M2yyJA6TzxA06WYq5+dmaqNGCrUNNAyVyYq9H61p5PnHUB1XMymcdTXwvLETVxn8dg6XzlydAlcDssbeb0=
X-Received: by 2002:a05:600c:1e03:b0:413:ef8f:751a with SMTP id
 ay3-20020a05600c1e0300b00413ef8f751amr219687wmb.2.1710438478385; Thu, 14 Mar
 2024 10:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141516.31747-1-liuhailong@oppo.com>
In-Reply-To: <20240314141516.31747-1-liuhailong@oppo.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 14 Mar 2024 13:47:20 -0400
Message-ID: <CAOUHufbsqd2s=a_mdMZEu2bXGFLF=+mVidNvJYMHmCH5Je9+Mg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm: skip CMA pages when they are not available"
To: liuhailong@oppo.com
Cc: akpm@linux-foundation.org, nathan@kernel.org, ndesaulniers@google.com, 
	trix@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, surenb@google.com, zhaoyang.huang@unisoc.com, 
	Charan Teja Kalla <quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:15=E2=80=AFAM <liuhailong@oppo.com> wrote:
>
> From: "Hailong.Liu" <liuhailong@oppo.com>
>
> This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.
>
> patch may cause system not responding. if cma pages is large in lru_list
> and system is in lowmemory, many tasks would enter direct reclaim and was=
te
> cpu time to isolate and return. Test this patch on android-5.15 device
> and tasks call stack as below.
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
> without this patch, the tasks will reclaim cma pages and wakeup
> oom-killer or not spin on cpus.
>
> Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
> ---
>  mm/vmscan.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2fe4a11d63f4..197ddf62019f 100644
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

NAK.

+Charan Teja Kalla -- This can cause build errors when CONFIG_LRU_GEN=3Dy.

If you plan to post a v2, please include a reproducer. Thanks.



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
> --
> 2.34.1
>
>

