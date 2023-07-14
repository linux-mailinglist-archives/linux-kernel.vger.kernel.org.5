Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD8752FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjGNDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjGNDM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EBA2D69
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75DF61A0D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B624C433C8;
        Fri, 14 Jul 2023 03:12:53 +0000 (UTC)
Date:   Thu, 13 Jul 2023 23:12:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Taketo Kabe <kkabe@vega.pgw.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference, address:
 00000004
Message-ID: <20230713231250.35488431@rorschach.local.home>
In-Reply-To: <5f8d4aa5-3b23-8965-57e3-a28bd9aa8e87@gmail.com>
References: <5f8d4aa5-3b23-8965-57e3-a28bd9aa8e87@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 09:50:17 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> 
> See Bugzilla for the full thread and attached patches that fixes
> this regression.
> 
> Later, when bisecting, the reporter got better kernel trace:
> 
> > [  469.825305] BUG: kernel NULL pointer dereference, address: 00000004
> > [  469.830502] #PF: supervisor read access in kernel mode
> > [  469.830502] #PF: error_code(0x0000) - not-present page
> > [  469.830502] *pde = 00000000
> > [  469.830502] Oops: 0000 [#1] PREEMPT SMP
> > [  469.830502] CPU: 0 PID: 365 Comm: systemd-udevd Not tainted 5.14.0-221.el9.v1.i586 #1

This is a 5.14 kernel right?

> > [  469.830502] Hardware name: System Manufacturer System Name/ALADDIN5, BIOS 0626 07/15/95
> > [  469.830502] EIP: _raw_spin_lock_irqsave+0x1f/0x40
> > [  469.830502] Code: cc cc cc cc cc cc cc 3e cc cc cc 3e 55 89 c1 89 55 89 c1 89 5b fa 64 ff 5b fa 64 ff c2 31 d2 be c2 31 d2 be 89 d0 3e 0f 89 d0 <3e> 0f 89 d8 5b 5e 89 d8 5b 5e 26 00 90 89 26 00 90 89 b7 15 75 ff
> > [  469.830502] EAX: 00000000 EBX: 00000246 ECX: 00000004 EDX: 00000000
> > [  469.830502] ESI: 00000001 EDI: c3e71c40 EBP: c3e71c34 ESP: c3e71c2c
> > [  469.830502] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> > [  469.830502] CR0: 80050033 CR2: 00000004 CR3: 057fa000 CR4: 00000010
> > [  469.830502] Call Trace:
> > [  469.830502]  kthread_flush_worker+0x52/0xa0
> > [  469.830502]  ? kthread_should_park+0x40/0x40
> > [  469.830502]  drm_crtc_vblank_off+0x1d7/0x230 [drm]
> > [  469.830502]  radeon_crtc_dpms+0x197/0x1b0 [radeon]
> > [  469.830502]  radeon_crtc_disable+0x16/0xa0 [radeon]
> > [  469.830502]  __drm_helper_disable_unused_functions+0x74/0xc0 [drm_kms_helper]
> > [  469.830502]  drm_helper_disable_unused_functions+0x3c/0x50 [drm_kms_helper]
> > [  469.830502]  radeon_fbdev_init+0xb0/0x130 [radeon]
> > [  469.830502]  radeon_modeset_init+0x25d/0x320 [radeon]
> > [  469.830502]  radeon_driver_load_kms+0xc4/0x240 [radeon]
> > [  469.830502]  drm_dev_register+0xb4/0x1a0 [drm]
> > [  469.830502]  radeon_pci_probe+0xc0/0x100 [radeon]
> > [  469.830502]  pci_device_probe+0xbc/0x150
> > [  469.830502]  really_probe+0xb7/0x350
> > [  469.830502]  __driver_probe_device+0x109/0x1e0
> > [  469.830502]  driver_probe_device+0x1f/0x90
> > [  469.830502]  __driver_attach+0x8a/0x1b0
> > [  469.830502]  ? __device_attach_driver+0x100/0x100
> > [  469.830502]  bus_for_each_dev+0x58/0x90
> > [  469.830502]  driver_attach+0x19/0x20
> > [  469.830502]  ? __device_attach_driver+0x100/0x100
> > [  469.830502]  bus_add_driver+0x12f/0x1d0
> > [  469.830502]  driver_register+0x79/0xd0
> > [  469.830502]  ? 0xf7dde000
> > [  469.830502]  __pci_register_driver+0x52/0x60
> > [  469.830502]  radeon_module_init+0x5c/0x1000 [radeon]
> > [  469.830502]  do_one_initcall+0x3e/0x1c0
> > [  469.830502]  ? __vunmap+0x20b/0x2a0
> > [  469.830502]  ? __vunmap+0x20b/0x2a0
> > [  469.830502]  ? kmem_cache_alloc_trace+0x38/0x440
> > [  469.830502]  do_init_module+0x52/0x260
> > [  469.830502]  load_module+0x930/0x9b0
> > [  469.830502]  __ia32_sys_init_module+0x15d/0x180
> > [  469.830502]  do_int80_syscall_32+0x2e/0x80
> > [  469.830502]  entry_INT80_32+0xf0/0xf0
> > [  469.830502] EIP: 0xb79e7e4e
> > [  469.830502] Code: 0f 83 d6 06 00 00 c3 66 90 66 90 90 57 56 53 8b 7c 24 20 8b 74 24 1c 8b 54 24 18 8b 4c 24 14 8b 5c 24 10 b8 80 00 00 00 cd 80 <5b> 5e 5f 3d 01 f0 ff ff 0f 83 a4 06 00 00 c3 66 90 90 53 8b 54 24
> > [  469.830502] EAX: ffffffda EBX: b5526010 ECX: 0020d79c EDX: b7c26274
> > [  469.830502] ESI: b7c20295 EDI: b7c2ddd8 EBP: 018af7c0 ESP: bfd2f810
> > [  469.830502] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> > [  469.830502] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib radeon(+) nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 gpu_sched drm_buddy i2c_algo_bit drm_display_helper cec drm_ttm_helper ppdev ttm rfkill ip_set nf_tables libcrc32c nfnetlink drm_kms_helper pcspkr syscopyarea e100 sysfillrect parport_pc sysimgblt mii fb_sys_fops parport qrtr drm fuse ext4 mbcache jbd2 sd_mod t10_pi sr_mod crc64_rocksoft_generic cdrom crc64_rocksoft crc64 sg ata_generic pata_ali libata serio_raw
> > [  469.830502] CR2: 0000000000000004
> > [  469.830502] ---[ end trace 30555bd5ee4bee23 ]---
> > [  469.830502] EIP: _raw_spin_lock_irqsave+0x1f/0x40
> > [  469.830502] Code: cc cc cc cc cc cc cc 3e cc cc cc 3e 55 89 c1 89 55 89 c1 89 5b fa 64 ff 5b fa 64 ff c2 31 d2 be c2 31 d2 be 89 d0 3e 0f 89 d0 <3e> 0f 89 d8 5b 5e 89 d8 5b 5e 26 00 90 89 26 00 90 89 b7 15 75 ff
> > [  469.830502] EAX: 00000000 EBX: 00000246 ECX: 00000004 EDX: 00000000
> > [  469.830502] ESI: 00000001 EDI: c3e71c40 EBP: c3e71c34 ESP: c3e71c2c
> > [  469.830502] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> > [  469.830502] CR0: 80050033 CR2: 00000004 CR3: 057fa000 CR4: 00000010
> > [  469.830502] Kernel panic - not syncing: Fatal exception
> > [  469.830502] Kernel Offset: disabled
> > [  469.830502] ---[ end Kernel panic - not syncing: Fatal exception ]---  
> 
> Anyway, I'm adding it to regzbot to ensure it doesn't fall through cracks
> unnoticed:
> 
> #regzbot introduced: b39181f7c6907d https://bugzilla.kernel.org/show_bug.cgi?id=217669
> #regzbot title: FTRACE_MCOUNT_MAX_OFFSET causes kernel NULL pointer dereference and virtual console (tty1) freeze

That commit was added in 5.19.

So I'm confused about why it's mentioned. Was it backported?

-- Steve

> #regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/2615
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217669
> 

