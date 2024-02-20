Return-Path: <linux-kernel+bounces-73275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6889385C059
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D2BB215F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68F762F4;
	Tue, 20 Feb 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DobQbtKS"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCA762D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444348; cv=none; b=WPzNoXOsJNrGWEY5/x4vk/owmTGrHh6LlP+LPeI6QFhSWxFzdm2gsHI9ZY2X1S/9CAGb7cvRNTb/mdSmeWgxqZjf0kftdgwTuV0XBkY0fPQbaG+2YXrP9J0jY4t624CVV0SDpgcCgpgZSL8H+ymPlp63qXTi9IsLMLugyD/1mqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444348; c=relaxed/simple;
	bh=kEfOVC0HOj7x8SZOZ4l9NpOGCg/1VRHsdAbpo1GmIJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzsn5zYX5XQ3EQdQOrnrPZjD0Me0NnKLQ+XtZ64TH84cbILcG36k5M9/6L073w3ue91aYlSMZlP4fTepQnIHAGVPLUKR/uyZ1y+Ma0FUYs6J/+t1q1fGC0c0BUHU3Va805xudpkQSsMXrsN9I9CK9tXKJd4yXBRm1rEX8M0/Sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DobQbtKS; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dc8b280155so3335914a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708444345; x=1709049145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdFor41F3IC1r56a0HLGglXn70d2B2IHDR4s07Fdmrs=;
        b=DobQbtKSk7Pi+4suEf/9G4DsUYT23UZurRig6reRKuNdHS5xXv1Hfl8ycFt4HJjT0j
         jcdg9iMJPWDWeZxRxHLEtKrOqKAQk041yhXq37pCcxDRNMlFzq2WZBvgZewsqQcu2sOf
         Y44jCJ2SgznArxelQ0qXU4qHYlNCOEMyBWa5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444345; x=1709049145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdFor41F3IC1r56a0HLGglXn70d2B2IHDR4s07Fdmrs=;
        b=VFvS5tlvZb/+h+mBCZKUB6FvwdxWle9lXvcL5DF/W3myxkhIxTvbP1cHsmYqeM26fO
         mw8kzXBHwiZK2KksD19aVFzvBRdNi745tDFE0CvTYjQujiqL+VuG2QNTLwndTh6LlxdF
         MAyRyinJ1xCS+VziMTg1lNuRbFD+tCihmeVZCucuWNit3Fr8xqnCrtkurUuuUEXj2RXc
         OXnqYiiEXXEFfEit4KCDUjiKj+Tb8B0ipT5vbHiUCYf2QofTPj1osZTQZFqfSAGgfuO/
         LdXz8XttxpVCBuuryK8P1v2yAlQKB54L7Q48GriS6mgPqXvOTFGO1TrDuXdJegnIEwXS
         kxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYTeBSGSGXiL79FiGjpXLHuZ4BcSGXDfPC+qvuK7x/JgRrCy/vnJlzd3JSh0ld68w/7dJYYPx+w5qfxnVc8HOAOGZ/+nYwwndi1oBE
X-Gm-Message-State: AOJu0YxAVuBfpOAtM6Xj4ELhdPVx6t42BqIHBMrRXIRoal8FxOMoOw/s
	bo/1xPMGUCr3zjJef0bcuw3I7BCEvkTiMnxoX7bNojlAixg61B1Qyt5P1u2zd8DymeH4TRcoLe+
	2O+XKo4zcAJVclOAWveJCXgnW/EcZZsZItSHB
X-Google-Smtp-Source: AGHT+IEWG+l/QRVtfNEh+sJn3QHhpIF8SajAdIrjIPZq0YcYxQ5EHhhZkodoUJbW1yo55UqEMkUo3jXBI9O+TBqnA7c=
X-Received: by 2002:a9d:6b08:0:b0:6e4:34ba:add2 with SMTP id
 g8-20020a9d6b08000000b006e434baadd2mr12014050otp.5.1708444345325; Tue, 20 Feb
 2024 07:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <87jzn0ofdb.wl-tiwai@suse.de> <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
In-Reply-To: <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Tue, 20 Feb 2024 10:52:14 -0500
Message-ID: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH
 v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Karthikeyan Ramasubramanian <kramasub@chromium.org>, 
	LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>, 
	stable@vger.kernel.org, Curtis Malainey <cujomalainey@chromium.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Takaski, Vlastimil: thanks so much for the engagement! See below.

> On 2/19/24 12:36, Takashi Iwai wrote:
> >
> > Karthikeyan, Sven, and co: could you guys show the stack trace at the
> > stall?  This may give us more clear light.

Here are two typical stack traces at the stall. Note that the timer interru=
pt
is just a software watchdog that fires to generate the stack trace.
This is running the v6.1 kernel.
We should be able to reproduce this on v6.6 as well if need be.

<4>[310289.546429] <TASK>
<4>[310289.546431] asm_sysvec_apic_timer_interrupt+0x16/0x20
<4>[310289.546434] RIP: 0010:super_cache_count+0xc/0xea
<4>[310289.546438] Code: ff ff e8 48 ac e3 ff 4c 89 e0 48 83 c4 20 5b
41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 1f 44 00 00 f6 87 23
fc ff ff 20 <75> 08 31 c0 c3 cc cc cc cc cc 55 48 89 e5 41 57 41 56 41
54 53 49
<4>[310289.546440] RSP: 0018:ffffa64e8aed35c0 EFLAGS: 00000202
<4>[310289.546443] RAX: 0000000000000080 RBX: 0000000000000400 RCX:
0000000000000000
<4>[310289.546445] RDX: ffffffffa6d66bc8 RSI: ffffa64e8aed3610 RDI:
ffff9fd2873dbc30
<4>[310289.546447] RBP: ffffa64e8aed3660 R08: 0000000000000064 R09:
0000000000000000
<4>[310289.546449] R10: ffffffffa6e3b260 R11: ffffffffa5163a52 R12:
ffff9fd2873dbc50
<4>[310289.546451] R13: 0000000000046c00 R14: 0000000000000000 R15:
0000000000000000
<4>[310289.546453] ? super_cache_scan+0x199/0x199
<4>[310289.546457] shrink_slab+0xb3/0x37e
<4>[310289.546460] shrink_node+0x377/0x110e
<4>[310289.546464] ? sysvec_apic_timer_interrupt+0x17/0x80
<4>[310289.546467] ? asm_sysvec_apic_timer_interrupt+0x16/0x20
<4>[310289.546471] try_to_free_pages+0x46e/0x857
<4>[310289.546475] ? psi_task_change+0x7f/0x9c
<4>[310289.546478] __alloc_pages_slowpath+0x4e2/0xe5c
<4>[310289.546482] __alloc_pages+0x225/0x2a2
<4>[310289.546486] __dma_direct_alloc_pages+0xed/0x1cb
<4>[310289.546489] dma_direct_alloc_pages+0x21/0xa3
<4>[310289.546493] dma_alloc_noncontiguous+0xd1/0x144
<4>[310289.546496] snd_dma_noncontig_alloc+0x45/0xe3
<4>[310289.546499] snd_dma_alloc_dir_pages+0x4f/0x81
<4>[310289.546502] hda_cl_stream_prepare+0x66/0x15e
[snd_sof_intel_hda_common (HASH:1255 1)]
<4>[310289.546510] hda_dsp_cl_boot_firmware+0xc4/0x2ca
[snd_sof_intel_hda_common (HASH:1255 1)]
<4>[310289.546518] snd_sof_run_firmware+0xca/0x2d7 [snd_sof (HASH:ecd9 2)]
<4>[310289.546526] ? hda_dsp_resume+0x97/0x1a7
[snd_sof_intel_hda_common (HASH:1255 1)]
<4>[310289.546534] sof_resume+0x155/0x251 [snd_sof (HASH:ecd9 2)]
<4>[310289.546542] ? pci_pm_suspend+0x1e7/0x1e7
<4>[310289.546546] dpm_run_callback+0x3c/0x132
<4>[310289.546549] device_resume+0x1f7/0x282
<4>[310289.546552] ? dpm_watchdog_set+0x54/0x54
<4>[310289.546555] async_resume+0x1f/0x5b
<4>[310289.546558] async_run_entry_fn+0x2b/0xc5
<4>[310289.546561] process_one_work+0x1be/0x381
<4>[310289.546564] worker_thread+0x20b/0x35b
<4>[310289.546568] kthread+0xde/0xf7
<4>[310289.546571] ? pr_cont_work+0x54/0x54
<4>[310289.546574] ? kthread_blkcg+0x32/0x32
<4>[310289.546577] ret_from_fork+0x1f/0x30
<4>[310289.546580] </TASK>

<4>[171032.151834] <TASK>
<4>[171032.151835] asm_sysvec_apic_timer_interrupt+0x16/0x20
<4>[171032.151839] RIP: 0010:_raw_spin_unlock_irq+0x10/0x28
<4>[171032.151842] Code: 2c 70 74 06 c3 cc cc cc cc cc 55 48 89 e5 e8
7e 30 2b ff 5d c3 cc cc cc cc cc 0f 1f 44 00 00 c6 07 00 fb 65 ff 0d
af b1 2c 70 <74> 06 c3 cc cc cc cc cc 55 48 89 e5 e8 56 30 2b ff 5d c3
cc cc cc
<4>[171032.151844] RSP: 0018:ffff942447b334d8 EFLAGS: 00000286
<4>[171032.151847] RAX: 0000000000000031 RBX: 0000000000000001 RCX:
0000000000000034
<4>[171032.151849] RDX: 0000000000000031 RSI: 0000000000000002 RDI:
ffffffff9103b1b0
<4>[171032.151851] RBP: ffff942447b33660 R08: 0000000000000032 R09:
0000000000000010
<4>[171032.151853] R10: ffffffff9103b370 R11: 00000000ffffffff R12:
ffffffff9103b160
<4>[171032.151855] R13: ffffd055000111c8 R14: 0000000000000000 R15:
0000000000000031
<4>[171032.151858] evict_folios+0xf9e/0x1307
<4>[171032.151861] ? asm_sysvec_apic_timer_interrupt+0x16/0x20
<4>[171032.151866] shrink_node+0x2e8/0x110e
<4>[171032.151870] ? common_interrupt+0x1c/0x95
<4>[171032.151872] ? common_interrupt+0x1c/0x95
<4>[171032.151875] ? asm_common_interrupt+0x22/0x40
<4>[171032.151878] ? __compaction_suitable+0x7c/0x9d
<4>[171032.151882] try_to_free_pages+0x46e/0x857
<4>[171032.151885] ? psi_task_change+0x7f/0x9c
<4>[171032.151889] __alloc_pages_slowpath+0x4e2/0xe5c
<4>[171032.151893] __alloc_pages+0x225/0x2a2
<4>[171032.151896] __dma_direct_alloc_pages+0xed/0x1cb
<4>[171032.151900] dma_direct_alloc_pages+0x21/0xa3
<4>[171032.151903] dma_alloc_noncontiguous+0xd1/0x144
<4>[171032.151907] snd_dma_noncontig_alloc+0x45/0xe3
<4>[171032.151910] snd_dma_alloc_dir_pages+0x4f/0x81
<4>[171032.151913] hda_cl_stream_prepare+0x66/0x15e
[snd_sof_intel_hda_common (HASH:7df0 1)]
<4>[171032.151921] hda_dsp_cl_boot_firmware+0xc4/0x2ca
[snd_sof_intel_hda_common (HASH:7df0 1)]
<4>[171032.151929] snd_sof_run_firmware+0xca/0x2d7 [snd_sof (HASH:9f20 2)]
<4>[171032.151937] ? hda_dsp_resume+0x97/0x1a7
[snd_sof_intel_hda_common (HASH:7df0 1)]
<4>[171032.151945] sof_resume+0x155/0x251 [snd_sof (HASH:9f20 2)]
<4>[171032.151953] ? pci_pm_suspend+0x1e7/0x1e7
<4>[171032.151957] dpm_run_callback+0x3c/0x132
<4>[171032.151960] device_resume+0x1f7/0x282
<4>[171032.151962] ? dpm_watchdog_set+0x54/0x54
<4>[171032.151965] async_resume+0x1f/0x5b
<4>[171032.151968] async_run_entry_fn+0x2b/0xc5
<4>[171032.151971] process_one_work+0x1be/0x381
<4>[171032.151975] worker_thread+0x20b/0x35b
<4>[171032.151978] kthread+0xde/0xf7
<4>[171032.151981] ? pr_cont_work+0x54/0x54
<4>[171032.151984] ? kthread_blkcg+0x32/0x32
<4>[171032.151987] ret_from_fork+0x1f/0x30
<4>[171032.151991] </TASK>

On Mon, Feb 19, 2024 at 6:40=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Yeah, if the inifinite loop with __GFP_RETRY_MAYFAIL happens in a call to
> __alloc_pages and not in some retry loop around it in an upper layer (I
> tried to check the dma functions but got lost quickly so the exact call
> stack would be useful), we definitely want to know the details. It should=
n't
> happen for costly orders (>3) because the retries are hard limited for th=
ose
> despite apparent progress or reclaim or compaction.

Here are our notes of the indefinite stall we saw on v5.10 with iommu SoCs.
We did not pursue debugging the stall at the time, in favour of a work-arou=
nd
with the gfp flags. Therefore we only have partial confidence in the notes
below. Take them with a block of salt, but they may point in a useful direc=
tion.

1. try to do a "costly" allocation (order > PAGE_ALLOC_COSTLY_ORDER) with
    __GFP_RETRY_MAYFAIL set.

2. page alloc's __alloc_pages_slowpath [1] tries to get a page from
the freelist.
    This fails because there is nothing free of that costly order.

3. page alloc tries to reclaim by calling __alloc_pages_direct_reclaim, whi=
ch
    bails out [2] because a zone is ready to be compacted; it pretends
to have made
    a single page of progress.

4. page alloc tries to compact, but this always bails out early [3]
because __GFP_IO is not set
    (it's not passed by the snd allocator, and even if it were, we are
suspending so the
    __GFP_IO flag would be cleared anyway).

5. page alloc believes reclaim progress was made (because of the
pretense in item 3) and
    so it checks whether it should retry compaction. The compaction
retry logic [4] thinks
    it should try again, because:
    a) reclaim is needed because of the early bail-out in item 4
    b) a zonelist is suitable for compaction

6. goto 2. indefinite stall.

>
> > Also, Vlastimil suggested that tracepoints would be helpful if that's
> > really in the page allocator, too.
> >

We might be able to generate traces by bailing out of the indefinite
stall using a timer,
which should hopefully give us a device that's "alive enough" to read
the traces.

Can you advise which tracepoints you'd like to see? Is trace-cmd [5]
suitable to capture
this?

[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src=
/third_party/kernel/v5.10/mm/page_alloc.c;l=3D4654;drc=3Da16293af64a1f558da=
b9a5dd7fb05fdbc2b7c5c0
[2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src=
/third_party/kernel/v5.10/mm/vmscan.c;drc=3D44452e4236561f6e36ec587805a52b6=
83e2804c9;l=3D6177
[3] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src=
/third_party/kernel/v5.10/mm/compaction.c;l=3D2479;drc=3Dd7b105aa1559e6c287=
f3f372044c21c7400b7784
[4] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src=
/third_party/kernel/v5.10/mm/page_alloc.c;l=3D4171;drc=3Da16293af64a1f558da=
b9a5dd7fb05fdbc2b7c5c0
[5] https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_develop=
ment.md#ftrace-debugging

