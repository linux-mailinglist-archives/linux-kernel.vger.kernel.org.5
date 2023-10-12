Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62AE7C6B47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377857AbjJLKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjJLKhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE28B7;
        Thu, 12 Oct 2023 03:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC38C433C8;
        Thu, 12 Oct 2023 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697107064;
        bh=L4AL5g6dyXtW2DNZfGETo0SchHr4XAXw5Q+dAuszJNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Agcx2znd/ghRB9gBYwJmxhdMprBTaBqsKiuWsQnXsIWbAH1Oces0xCqZhZz0ToxJn
         sbyUY3FKa+di9mnfpVeTnPLSEp0Z3Qt62BLN8GIJxn3tr5C0RsHFnuOIZ+B0DlJFXp
         Dmeb8RGyjlZEJAyQxZb55kTwYLiAF0PkcHGSmYuc=
Date:   Thu, 12 Oct 2023 12:37:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/test_meminit: fix off-by-one error in test_pages()
Message-ID: <2023101241-old-germinate-7a05@gregkh>
References: <2023101238-greasily-reiterate-aafc@gregkh>
 <CAG_fn=X-dnc06r0Yik24jBaL-f7ZzrUQiUJmMHeN9CaSa3ZveQ@mail.gmail.com>
 <2023101201-grasp-smartly-2085@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023101201-grasp-smartly-2085@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:26:58PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 12, 2023 at 10:40:14AM +0200, Alexander Potapenko wrote:
> > On Thu, Oct 12, 2023 at 10:17 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > In commit efb78fa86e95 ("lib/test_meminit: allocate pages up to order
> > > MAX_ORDER"), the loop for testing pages is set to "<= MAX_ORDER" which
> > > causes crashes in systems when run.  Fix this to "< MAX_ORDER" to fix
> > > the test to work properly.
> > 
> > What are the crashes you are seeing? Are those OOMs?
> 
> They are WARN_ON() triggers.  They are burried in the Android build
> system, let me see if I can uncover them.
> 
> > IIUC it should be valid to allocate with MAX_ORDER.
> 
> "should", but I no longer get runtime warnings with this patch applied,
> so something is wrong :)
> 
> Let me go dig for the logs again...

Here's one, on the 5.4.y tree where this was backported to, with this
patch applied, it does not show up anymore:


[    8.897682] test_stackinit: all tests passed!
[    8.898200] init: Loaded kernel module /lib/modules/5.4.257-android11-2-00544-g5000f4d84d4f/kernel/lib/test_stackinit.ko
[    8.898649] init: Loading module /lib/modules/5.4.257-android11-2-00544-g5000f4d84d4f/kernel/lib/test_meminit.ko with args ""
[    9.015314] ------------[ cut here ]------------
[    9.016359] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:4873 __alloc_pages_nodemask+0x1ad/0x310
[    9.016946] Modules linked in: test_meminit(+) test_stackinit vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock_diag vsock snd_intel8x0 snd_ac97_codec ac97_bus gnss_cmdline gnss_serial dummy_cpufreq hci_vhci rtc_test virtio_net net_failover failover virt_wifi mac80211_hwsim virtio_pmem nd_virtio virtio_blk tpm_vtpm_proxy tpm virtio_console virtio_rng virtio_input virtio_pci virtio_mmio incrementalfs
[    9.018268] CPU: 0 PID: 1 Comm: init Not tainted 5.4.257-android11-2-00544-g5000f4d84d4f-abP63746429 #1
[    9.018707] Hardware name: ChromiumOS crosvm, BIOS 0 
[    9.018956] RIP: 0010:__alloc_pages_nodemask+0x1ad/0x310
[    9.019178] Code: 89 f7 a9 00 00 0c 10 75 2b c6 45 c8 00 4c 39 65 b0 75 3c 48 8d 55 a8 89 7d a4 44 89 fe e8 eb 05 00 00 49 89 c5 e9 71 ff ff ff <0f> 0b 45 31 ed e9 74 ff ff ff 44 89 f1 a9 00 00 08 00 75 17 81 e1
[    9.019922] RSP: 0018:ffffaf3ec000ba28 EFLAGS: 00010246
[    9.020139] RAX: 86b5c88349dacd00 RBX: 0000000000000000 RCX: 0000000000000000
[    9.020496] RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000000cc0
[    9.020843] RBP: ffffaf3ec000ba90 R08: ffffe222c8830000 R09: 0000000000000001
[    9.021184] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    9.021502] R13: 0000000000800000 R14: 0000000000000cc0 R15: ffffaf3ec000baec
[    9.021829] FS:  00007f10e8024ff8(0000) GS:ffff8a5567a00000(0000) knlGS:0000000000000000
[    9.022136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.022295] CR2: 000055f8cc69cfd0 CR3: 0000000223ce0003 CR4: 0000000000360eb0
[    9.022509] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.022890] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.023223] Call Trace:
[    9.023473]  ? show_regs+0x55/0x60
[    9.023731]  ? __warn+0xcb/0x150
[    9.023896]  ? __alloc_pages_nodemask+0x1ad/0x310
[    9.024211]  ? report_bug+0x11e/0x190
[    9.024376]  ? __alloc_pages_nodemask+0x1ad/0x310
[    9.024598]  ? do_invalid_op+0x2f/0xb0
[    9.024823]  ? invalid_op+0x1e/0x30
[    9.024989]  ? __alloc_pages_nodemask+0x1ad/0x310
[    9.025213]  do_alloc_pages_order+0x33/0xd2 [test_meminit]
[    9.025429]  ? __cfi_check+0x60/0x60 [test_meminit]
[    9.025655]  test_pages+0x34/0x9c [test_meminit]
[    9.025869]  init_module+0x2b/0x9a [test_meminit]
[    9.026127]  do_one_initcall+0x12e/0x390
[    9.026363]  do_init_module+0x4a/0x200
[    9.026528]  load_module+0x40b5/0x4560
[    9.026781]  ? kernel_read_file+0x18f/0x1e0
[    9.026958]  ? kernel_read_file_from_fd+0x52/0x80
[    9.027143]  __x64_sys_finit_module+0xcf/0x100
[    9.027423]  ? __x64_sys_rmdir.cfi_jt+0x8/0x8
[    9.027642]  do_syscall_64+0x6d/0xb0
[    9.027802]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[    9.028020] RIP: 0033:0x7f10e789a508
[    9.028181] Code: c0 4c 89 1c 24 c3 e8 97 6c ff ff cc cc cc cc cc cc cc 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 72 09 f7 d8 89 c7 e8 77 55 05 00 c3 cc cc cc cc
[    9.028913] RSP: 002b:00007ffd1d1f4a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    9.029233] RAX: ffffffffffffffda RBX: 00007ffd1d1f4a71 RCX: 00007f10e789a508
[    9.029547] RDX: 0000000000000000 RSI: 00007ffd1d1f4a71 RDI: 0000000000000006
[    9.029880] RBP: 00007f10e82917f0 R08: 00007ffd1d1f4420 R09: 0000000000000050
[    9.030202] R10: 0000000000000010 R11: 0000000000000246 R12: 00007f0ef721d010
[    9.030518] R13: 00007ffd1d1f4a50 R14: 00007ffd1d1f4d50 R15: 0000000000000002
[    9.030836] ---[ end trace afa5c86c1c294dbb ]---
[    9.031252] general protection fault: 0000 [#1] PREEMPT SMP PTI
[    9.031749] CPU: 0 PID: 1 Comm: init Tainted: G        W         5.4.257-android11-2-00544-g5000f4d84d4f-abP63746429 #1
[    9.032074] Hardware name: ChromiumOS crosvm, BIOS 0 
[    9.032229] RIP: 0010:fill_with_garbage_skip+0x2d/0x5e [test_meminit]
[    9.032463] Code: e5 48 63 c6 48 39 d0 72 4e 48 01 d7 89 f0 29 d0 83 f8 04 72 29 29 d6 83 c6 fc c1 ee 02 48 8d 14 b5 04 00 00 00 48 ff c6 31 c9 <c7> 04 0f 9e ba a7 09 48 83 c1 04 48 39 ca 75 f0 29 c8 eb 02 31 f6
[    9.033114] RSP: 0018:ffffaf3ec000ba90 EFLAGS: 00010246
[    9.033376] RAX: 0000000000800000 RBX: 0000000000000000 RCX: 0000000000000000
[    9.033754] RDX: 0000000000800000 RSI: 0000000000200000 RDI: 000701a340000000
[    9.034104] RBP: ffffaf3ec000ba90 R08: ffffe222c8830000 R09: 0000000000000001
[    9.034421] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    9.034752] R13: 0000000000800000 R14: 000000000000000b R15: ffffaf3ec000baec
[    9.035189] FS:  00007f10e8024ff8(0000) GS:ffff8a5567a00000(0000) knlGS:0000000000000000
[    9.035563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.035837] CR2: 000055f8cc69cfd0 CR3: 0000000223ce0003 CR4: 0000000000360eb0
[    9.036191] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.036541] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.036859] Call Trace:
[    9.037000]  ? __die+0xdb/0x120
[    9.037114]  ? die+0x2a/0x50
[    9.037309]  ? do_general_protection+0x17c/0x1f0
[    9.037530]  ? general_protection+0x28/0x30
[    9.037698]  ? fill_with_garbage_skip+0x2d/0x5e [test_meminit]
[    9.038139]  do_alloc_pages_order+0x55/0xd2 [test_meminit]
[    9.038340]  ? __cfi_check+0x60/0x60 [test_meminit]
[    9.038614]  test_pages+0x34/0x9c [test_meminit]
[    9.038835]  init_module+0x2b/0x9a [test_meminit]
[    9.039047]  do_one_initcall+0x12e/0x390
[    9.039185]  do_init_module+0x4a/0x200
[    9.039352]  load_module+0x40b5/0x4560
[    9.039523]  ? kernel_read_file+0x18f/0x1e0
[    9.039703]  ? kernel_read_file_from_fd+0x52/0x80
[    9.039910]  __x64_sys_finit_module+0xcf/0x100
[    9.040130]  ? __x64_sys_rmdir.cfi_jt+0x8/0x8
[    9.040262]  do_syscall_64+0x6d/0xb0
[    9.040437]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[    9.040626] RIP: 0033:0x7f10e789a508
[    9.040779] Code: c0 4c 89 1c 24 c3 e8 97 6c ff ff cc cc cc cc cc cc cc 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 72 09 f7 d8 89 c7 e8 77 55 05 00 c3 cc cc cc cc
[    9.041509] RSP: 002b:00007ffd1d1f4a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    9.041965] RAX: ffffffffffffffda RBX: 00007ffd1d1f4a71 RCX: 00007f10e789a508
[    9.042362] RDX: 0000000000000000 RSI: 00007ffd1d1f4a71 RDI: 0000000000000006
[    9.042724] RBP: 00007f10e82917f0 R08: 00007ffd1d1f4420 R09: 0000000000000050
[    9.043055] R10: 0000000000000010 R11: 0000000000000246 R12: 00007f0ef721d010
[    9.043379] R13: 00007ffd1d1f4a50 R14: 00007ffd1d1f4d50 R15: 0000000000000002
[    9.043977] Modules linked in: test_meminit(+) test_stackinit vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock_diag vsock snd_intel8x0 snd_ac97_codec ac97_bus gnss_cmdline gnss_serial dummy_cpufreq hci_vhci rtc_test virtio_net net_failover failover virt_wifi mac80211_hwsim virtio_pmem nd_virtio virtio_blk tpm_vtpm_proxy tpm virtio_console virtio_rng virtio_input virtio_pci virtio_mmio incrementalfs
[    9.045829] ---[ end trace afa5c86c1c294dbc ]---
[    9.046415] RIP: 0010:fill_with_garbage_skip+0x2d/0x5e [test_meminit]
[    9.046706] Code: e5 48 63 c6 48 39 d0 72 4e 48 01 d7 89 f0 29 d0 83 f8 04 72 29 29 d6 83 c6 fc c1 ee 02 48 8d 14 b5 04 00 00 00 48 ff c6 31 c9 <c7> 04 0f 9e ba a7 09 48 83 c1 04 48 39 ca 75 f0 29 c8 eb 02 31 f6
[    9.047388] RSP: 0018:ffffaf3ec000ba90 EFLAGS: 00010246
[    9.047552] RAX: 0000000000800000 RBX: 0000000000000000 RCX: 0000000000000000
[    9.047798] RDX: 0000000000800000 RSI: 0000000000200000 RDI: 000701a340000000
[    9.048048] RBP: ffffaf3ec000ba90 R08: ffffe222c8830000 R09: 0000000000000001
[    9.048291] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    9.048534] R13: 0000000000800000 R14: 000000000000000b R15: ffffaf3ec000baec
[    9.048780] FS:  00007f10e8024ff8(0000) GS:ffff8a5567a00000(0000) knlGS:0000000000000000
[    9.049025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.049336] CR2: 000055f8cc69cfd0 CR3: 0000000223ce0003 CR4: 0000000000360eb0
[    9.049706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.050054] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.050387] Kernel panic - not syncing: Fatal exception
[    9.052413] Kernel Offset: 0x2b000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


