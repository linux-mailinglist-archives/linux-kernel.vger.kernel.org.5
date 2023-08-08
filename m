Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD3773BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjHHPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHHPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A22108
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmSBpqcN+o2n+gw9mmK7jDuFBXWX38vx5ZF2JwCHqmc=;
        b=jCwxTak/1GuznYTh0bYNX4jEHdYbUcaNRsFusm/YL55Im7rmfNMfLdbUkeY8+6jVw2Zndx
        8Qj7rQ34fsFbvhDWJbR9ONVU6s0XRux49MbvA1Ckcvpk9k05ylMziLF5SVTkMTINeaMsn5
        5R/l435bdUG9gk9U6r3j6EXZFWNWApQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-pezPgYSOPYylvfYtE9KgUQ-1; Tue, 08 Aug 2023 06:39:45 -0400
X-MC-Unique: pezPgYSOPYylvfYtE9KgUQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe4f5ffe2aso1006183e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 03:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691491184; x=1692095984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmSBpqcN+o2n+gw9mmK7jDuFBXWX38vx5ZF2JwCHqmc=;
        b=iKR026CAsaUovGBPXQvjhUGzvlkqS3a49oCmAtVIDtW1NvNxO+b3YHbI5e1cpzVXbY
         2/2qiE/kDjmZ+e17QSPrh2f/zGZEHCDyi0+ycBOOWYyoWbRCGaXMW2EbnP+AZziDDZh/
         WsKFmD7DVO3p4RlqtF98e5GPSwlCaNFP0gFET3f7+HGnTWD18oh1jaCg8DWrPM5dEVwj
         QODm00b9x8TCagFL1/EaldxaU+Blsxytipr7OHG1ocR3DYXS2tn+2HYFnxju64cFAupO
         8ECUGN7bofnZHNUinsuNsB4CDaZ/sM7n9K/nzEUhQcLqfGtrjMoSrpX+C6G3ceJW4hVt
         49hA==
X-Gm-Message-State: ABy/qLblPFvzvqtpTcAwRT4+RHyj5jpE4q0jhgwwUIgHfpyGCZF+j1Xi
        f40EBVBTz/hLklyx18hkBprA8KGhRlxCsk6wgVfGHRqiR7kFEh46b0Ay1qnOkzNikTcdWQ2WwZ0
        zCr8TbiqH9VvIC1SXx6ZO+Vzb3pEzmDxeK23XG2I7
X-Received: by 2002:a2e:bc84:0:b0:2b9:a156:6239 with SMTP id h4-20020a2ebc84000000b002b9a1566239mr17731445ljf.1.1691491184081;
        Tue, 08 Aug 2023 03:39:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFiSXtFv8QdQytFsbRz17mpsSTg0VicYrv55WcHiHOdbHT2SOqsdi4qzZFv4EPpEyrlupnw1hsy1f9AHmIdFSY=
X-Received: by 2002:a2e:bc84:0:b0:2b9:a156:6239 with SMTP id
 h4-20020a2ebc84000000b002b9a1566239mr17731433ljf.1.1691491183689; Tue, 08 Aug
 2023 03:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local>
 <CACO55tvZD5U4J8DawFTRVnV-dLYLngfhuqO29_sWNEGofKfnBg@mail.gmail.com> <20230807150521.GGZNEIMQ9rsyCmkpoA@fat_crate.local>
In-Reply-To: <20230807150521.GGZNEIMQ9rsyCmkpoA@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 8 Aug 2023 12:39:32 +0200
Message-ID: <CACO55tvWuSdwdirj7S3Dk-r4NAw8jC8g5RHKFd62WXi43iQP-w@mail.gmail.com>
Subject: Re: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not
 PMGR AUX interrupts")
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ben Skeggs <bskeggs@redhat.com>, regressions@leemhuis.info,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 5:05=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Mon, Aug 07, 2023 at 01:49:42PM +0200, Karol Herbst wrote:
> > in what way does it stop? Just not progressing? That would be kinda
> > concerning. Mind tracing with what arguments `nvkm_uevent_add` is
> > called with and without that patch?
>
> Well, me dumping those args I guess made the box not freeze before
> catching a #PF over serial. Does that help?
>
> ....
> [    3.410135] Unpacking initramfs...
> [    3.416319] software IO TLB: mapped [mem 0x00000000a877d000-0x00000000=
ac77d000] (64MB)
> [    3.418227] Initialise system trusted keyrings
> [    3.432273] workingset: timestamp_bits=3D56 max_order=3D22 bucket_orde=
r=3D0
> [    3.439006] ntfs: driver 2.1.32 [Flags: R/W].
> [    3.443368] fuse: init (API version 7.38)
> [    3.447601] 9p: Installing v9fs 9p2000 file system support
> [    3.453223] Key type asymmetric registered
> [    3.457332] Asymmetric key parser 'x509' registered
> [    3.462236] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 250)
> [    3.475865] efifb: probing for efifb
> [    3.479458] efifb: framebuffer at 0xf9000000, using 1920k, total 1920k
> [    3.485969] efifb: mode is 800x600x32, linelength=3D3200, pages=3D1
> [    3.491872] efifb: scrolling: redraw
> [    3.495438] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
> [    3.502349] Console: switching to colour frame buffer device 100x37
> [    3.509564] fb0: EFI VGA frame buffer device
> [    3.514013] ACPI: \_PR_.CP00: Found 4 idle states
> [    3.518850] ACPI: \_PR_.CP01: Found 4 idle states
> [    3.523687] ACPI: \_PR_.CP02: Found 4 idle states
> [    3.528515] ACPI: \_PR_.CP03: Found 4 idle states
> [    3.533346] ACPI: \_PR_.CP04: Found 4 idle states
> [    3.538173] ACPI: \_PR_.CP05: Found 4 idle states
> [    3.543003] ACPI: \_PR_.CP06: Found 4 idle states
> [    3.544219] Freeing initrd memory: 8196K
> [    3.547844] ACPI: \_PR_.CP07: Found 4 idle states
> [    3.609542] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    3.616224] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
> [    3.625552] serial 0000:00:16.3: enabling device (0000 -> 0003)
> [    3.633034] 0000:00:16.3: ttyS1 at I/O 0xf0a0 (irq =3D 17, base_baud =
=3D 115200) is a 16550A
> [    3.642451] Linux agpgart interface v0.103
> [    3.647141] ACPI: bus type drm_connector registered
> [    3.653261] Console: switching to colour dummy device 80x25
> [    3.659092] nouveau 0000:03:00.0: vgaarb: deactivate vga console
> [    3.665174] nouveau 0000:03:00.0: NVIDIA GT218 (0a8c00b1)
> [    3.784585] nouveau 0000:03:00.0: bios: version 70.18.83.00.08
> [    3.792244] nouveau 0000:03:00.0: fb: 512 MiB DDR3
> [    3.948786] nouveau 0000:03:00.0: DRM: VRAM: 512 MiB
> [    3.953755] nouveau 0000:03:00.0: DRM: GART: 1048576 MiB
> [    3.959073] nouveau 0000:03:00.0: DRM: TMDS table version 2.0
> [    3.964808] nouveau 0000:03:00.0: DRM: DCB version 4.0
> [    3.969938] nouveau 0000:03:00.0: DRM: DCB outp 00: 02000360 00000000
> [    3.976367] nouveau 0000:03:00.0: DRM: DCB outp 01: 02000362 00020010
> [    3.982792] nouveau 0000:03:00.0: DRM: DCB outp 02: 028003a6 0f220010
> [    3.989223] nouveau 0000:03:00.0: DRM: DCB outp 03: 01011380 00000000
> [    3.995647] nouveau 0000:03:00.0: DRM: DCB outp 04: 08011382 00020010
> [    4.002076] nouveau 0000:03:00.0: DRM: DCB outp 05: 088113c6 0f220010
> [    4.008511] nouveau 0000:03:00.0: DRM: DCB conn 00: 00101064
> [    4.014151] nouveau 0000:03:00.0: DRM: DCB conn 01: 00202165
> [    4.021710] nvkm_uevent_add: uevent: 0xffff888100242100, event: 0xffff=
8881022de1a0, id: 0x0, bits: 0x1, func: 0x0000000000000000
> [    4.033680] nvkm_uevent_add: uevent: 0xffff888100242300, event: 0xffff=
8881022de1a0, id: 0x0, bits: 0x1, func: 0x0000000000000000
> [    4.045429] nouveau 0000:03:00.0: DRM: MM: using COPY for buffer copie=
s
> [    4.052059] stackdepot: allocating hash table of 1048576 entries via k=
vcalloc
> [    4.067191] nvkm_uevent_add: uevent: 0xffff888100242800, event: 0xffff=
888104b3e260, id: 0x0, bits: 0x1, func: 0x0000000000000000
> [    4.078936] nvkm_uevent_add: uevent: 0xffff888100242900, event: 0xffff=
888104b3e260, id: 0x1, bits: 0x1, func: 0x0000000000000000
> [    4.090514] nvkm_uevent_add: uevent: 0xffff888100242a00, event: 0xffff=
888102091f28, id: 0x1, bits: 0x3, func: 0xffffffff8177b700
> [    4.102118] tsc: Refined TSC clocksource calibration: 3591.345 MHz
> [    4.108342] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3=
3c4635c383, max_idle_ns: 440795314831 ns
> [    4.108401] nvkm_uevent_add: uevent: 0xffff8881020b6000, event: 0xffff=
888102091f28, id: 0xf, bits: 0x3, func: 0xffffffff8177b700
> [    4.129864] clocksource: Switched to clocksource tsc
> [    4.131478] [drm] Initialized nouveau 1.3.1 20120801 for 0000:03:00.0 =
on minor 0
> [    4.143806] BUG: kernel NULL pointer dereference, address: 00000000000=
00020

ahh, that would have been good to know :) Mind figuring out what's
exactly NULL inside nvif_object_mthd? Or rather what line
`nvif_object_mthd+0x136` belongs to, then it should be easy to figure
out what's wrong here.

> [    4.144676] #PF: supervisor read access in kernel mode
> [    4.144676] #PF: error_code(0x0000) - not-present page
> [    4.144676] PGD 0 P4D 0
> [    4.144676] Oops: 0000 [#1] PREEMPT SMP PTI
> [    4.144676] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5-dirty =
#1
> [    4.144676] Hardware name: Dell Inc. Precision T3600/0PTTT9, BIOS A13 =
05/11/2014
> [    4.144676] RIP: 0010:nvif_object_mthd+0x136/0x1e0
> [    4.144676] Code: f2 4c 89 ee 48 8d 7c 24 20 66 89 04 24 c6 44 24 18 0=
0 e8 8d 04 4e 00 41 8d 56 20 49 8b 44 24 08 83 fa 17 76 7d 49 39 c4 74 45 <=
48> 8b 78 20 4c 89 64 24 10 48 8b 40 38 c6 44 24 06 ff 31 c9 48 89
> [    4.144676] RSP: 0000:ffffc90000023888 EFLAGS: 00010282
> [    4.144676] RAX: 0000000000000000 RBX: ffff8881003bc000 RCX: 000000000=
0000008
> [    4.144676] RDX: 0000000000000028 RSI: ffffc90000023948 RDI: ffffc9000=
00238a8
> [    4.144676] RBP: ffff8881003bc620 R08: ffff888102170000 R09: ffff88810=
2170000
> [    4.144676] R10: 0000000000000002 R11: 0000000000000001 R12: ffff88810=
03bc620
> [    4.144676] R13: ffffc90000023948 R14: 0000000000000008 R15: 000000000=
0000000
> [    4.144676] FS:  0000000000000000(0000) GS:ffff88843a700000(0000) knlG=
S:0000000000000000
> [    4.144676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.144676] CR2: 0000000000000020 CR3: 000000000641e001 CR4: 000000000=
00606e0
> [    4.144676] Call Trace:
> [    4.144676]  <TASK>
> [    4.144676]  ? __die+0x20/0x70
> [    4.144676]  ? page_fault_oops+0x14c/0x430
> [    4.144676]  ? fixup_exception+0x22/0x340
> [    4.144676]  ? kernelmode_fixup_or_oops+0x84/0x110
> [    4.144676]  ? exc_page_fault+0x66/0x1b0
> [    4.144676]  ? asm_exc_page_fault+0x22/0x30
> [    4.144676]  ? nvif_object_mthd+0x136/0x1e0
> [    4.144676]  ? nvif_object_mthd+0x123/0x1e0
> [    4.144676]  ? rcu_is_watching+0xd/0x40
> [    4.144676]  ? __mutex_lock+0xc9/0x790
> [    4.144676]  ? nouveau_dp_detect+0x67/0x4e0
> [    4.144676]  nvif_conn_hpd_status+0x22/0xd0
> [    4.144676]  nouveau_dp_detect+0x33b/0x4e0
> [    4.144676]  ? rt_mutex_unlock+0xf5/0x110
> [    4.144676]  nouveau_connector_detect+0x10f/0x470
> [    4.144676]  drm_helper_probe_detect+0x81/0xa0
> [    4.144676]  drm_helper_probe_single_connector_modes+0x441/0x510
> [    4.144676]  drm_client_modeset_probe+0x1f8/0xca0
> [    4.144676]  __drm_fb_helper_initial_config_and_unlock+0x34/0x560
> [    4.144676]  ? __mutex_lock+0xc9/0x790
> [    4.144676]  ? drm_client_register+0x22/0xa0
> [    4.144676]  drm_fbdev_generic_client_hotplug+0x66/0xc0
> [    4.144676]  drm_client_register+0x64/0xa0
> [    4.144676]  nouveau_drm_probe+0x20d/0x230
> [    4.144676]  local_pci_probe+0x46/0xa0
> [    4.144676]  pci_device_probe+0xaf/0x200
> [    4.144676]  really_probe+0xc2/0x2d0
> [    4.144676]  __driver_probe_device+0x73/0x120
> [    4.144676]  driver_probe_device+0x1e/0xe0
> [    4.144676]  __driver_attach+0x8a/0x190
> [    4.144676]  ? __pfx___driver_attach+0x10/0x10
> [    4.144676]  bus_for_each_dev+0x6a/0xb0
> [    4.144676]  bus_add_driver+0xeb/0x1f0
> [    4.144676]  driver_register+0x5c/0x120
> [    4.144676]  ? __pfx_nouveau_drm_init+0x10/0x10
> [    4.144676]  do_one_initcall+0x5b/0x280
> [    4.144676]  kernel_init_freeable+0x186/0x2f0
> [    4.144676]  ? __pfx_kernel_init+0x10/0x10
> [    4.144676]  kernel_init+0x16/0x1b0
> [    4.144676]  ret_from_fork+0x30/0x50
> [    4.144676]  ? __pfx_kernel_init+0x10/0x10
> [    4.144676]  ret_from_fork_asm+0x1b/0x30
> [    4.144676]  </TASK>
> [    4.144676] Modules linked in:
> [    4.144676] CR2: 0000000000000020
> [    4.144676] ---[ end trace 0000000000000000 ]---
> [    4.144676] RIP: 0010:nvif_object_mthd+0x136/0x1e0
> [    4.144676] Code: f2 4c 89 ee 48 8d 7c 24 20 66 89 04 24 c6 44 24 18 0=
0 e8 8d 04 4e 00 41 8d 56 20 49 8b 44 24 08 83 fa 17 76 7d 49 39 c4 74 45 <=
48> 8b 78 20 4c 89 64 24 10 48 8b 40 38 c6 44 24 06 ff 31 c9 48 89
> [    4.144676] RSP: 0000:ffffc90000023888 EFLAGS: 00010282
> [    4.144676] RAX: 0000000000000000 RBX: ffff8881003bc000 RCX: 000000000=
0000008
> [    4.144676] RDX: 0000000000000028 RSI: ffffc90000023948 RDI: ffffc9000=
00238a8
> [    4.144676] RBP: ffff8881003bc620 R08: ffff888102170000 R09: ffff88810=
2170000
> [    4.144676] R10: 0000000000000002 R11: 0000000000000001 R12: ffff88810=
03bc620
> [    4.144676] R13: ffffc90000023948 R14: 0000000000000008 R15: 000000000=
0000000
> [    4.144676] FS:  0000000000000000(0000) GS:ffff88843a700000(0000) knlG=
S:0000000000000000
> [    4.144676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.144676] CR2: 0000000000000020 CR3: 000000000641e001 CR4: 000000000=
00606e0
> [    4.144676] note: swapper/0[1] exited with irqs disabled
> [    4.549714] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000009
> [    4.550687] Kernel Offset: disabled
> [    4.550687] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

