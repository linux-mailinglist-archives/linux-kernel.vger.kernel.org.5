Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B0681345D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573775AbjLNPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjLNPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:14:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC5E0129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:13:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E2BC15;
        Thu, 14 Dec 2023 07:14:01 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 968193F5A1;
        Thu, 14 Dec 2023 07:13:14 -0800 (PST)
Date:   Thu, 14 Dec 2023 15:13:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        heng.su@intel.com, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is WARNING in perf_event_open in
 v6.7-rc5 kernel
Message-ID: <ZXsbiAoAs_GqHGk6@FVFF77S0Q05N.cambridge.arm.com>
References: <ZXpm6gQ/d59jGsuW@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXpm6gQ/d59jGsuW@xpf.sh.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:22:34AM +0800, Pengfei Xu wrote:
> There is WARNING in perf_event_open in v6.7-rc5 kernel.

> Bisected and found related commit:
> "
> 382c27f4ed28 perf: Fix perf_event_validate_size()
> "

I believe this is the same issue that Lucas reported at:

  https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/

... please see the analysis there.

Mark.

> Revert on top of v6.7-rc5, this issue was gone.
> 
>  [   23.133852] ------------[ cut here ]------------
>  [   23.134146] WARNING: CPU: 1 PID: 727 at kernel/events/core.c:1950 __do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.134752] Modules linked in:
>  [   23.134924] CPU: 1 PID: 727 Comm: repro Not tainted 6.7.0-rc5-a39b6ac3781d+ #1
>  [   23.135292] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  [   23.135882] RIP: 0010:__do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.136212] Code: 48 8d b8 a8 00 00 00 e8 5b 99 bb 03 bf 01 00 00 00 41 89 c5 89 c6 e8 fc d9 c9 ff 41 83 ed 01 0f 84 81 ec ff ff e8 fd d7 c9 ff <0f> 0b e9 75 ec ff ff e8 f1 16 29 00 e9 d1 ec ff ff e8 77 17 29 00
>  [   23.137194] RSP: 0018:ffff88800cb27d88 EFLAGS: 00010293
>  [   23.137465] RAX: ffff888010ea8000 RBX: ffff88800d44bd40 RCX: ffffffff8196ccf4
>  [   23.137832] RDX: 0000000000000000 RSI: ffffffff8196cd03 RDI: 0000000000000005
>  [   23.138229] RBP: ffff88800cb27ef8 R08: ffff888010ea8000 R09: fffffbfff11c7a2a
>  [   23.138724] R10: 0000000000000001 R11: ffffffff88e3d14f R12: ffff88800d44bd40
>  [   23.139126] R13: 00000000ffffffff R14: 0000000000000000 R15: 1ffff11001964fbe
>  [   23.139492] FS:  00007fef8c620600(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
>  [   23.139901] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  [   23.140223] CR2: 00000000200000c0 CR3: 000000000d90a000 CR4: 0000000000750ef0
>  [   23.140619] PKRU: 55555554
>  [   23.140778] Call Trace:
>  [   23.140920]  <TASK>
>  [   23.141049]  ? show_regs+0xa2/0xb0
>  [   23.141236]  ? __warn+0xef/0x340
>  [   23.141412]  ? report_bug+0x2f6/0x570
>  [   23.141616]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.141881]  ? report_bug+0x360/0x570
>  [   23.142083]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.142385]  ? handle_bug+0xa4/0x130
>  [   23.142668]  ? exc_invalid_op+0x3a/0x90
>  [   23.142956]  ? asm_exc_invalid_op+0x1f/0x30
>  [   23.143241]  ? __do_sys_perf_event_open+0x2b94/0x2c50
>  [   23.143506]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.143788]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.144089]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
>  [   23.144397]  ? __pfx___do_sys_perf_event_open+0x10/0x10
>  [   23.144697]  ? trace_hardirqs_on+0x26/0x120
>  [   23.144951]  __x64_sys_perf_event_open+0xc7/0x160
>  [   23.145202]  ? syscall_enter_from_user_mode+0x51/0x60
>  [   23.145476]  do_syscall_64+0x42/0xf0
>  [   23.145670]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  [   23.145940] RIP: 0033:0x7fef8c43ee5d
>  [   23.146145] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
>  [   23.147095] RSP: 002b:00007ffe0ede25a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
>  [   23.147633] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef8c43ee5d
>  [   23.148052] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200000c0
>  [   23.148451] RBP: 00007ffe0ede25b0 R08: 0000000000000000 R09: 00007ffe0ede25e0
>  [   23.148860] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe0ede2708
>  [   23.149263] R13: 0000000000401b49 R14: 0000000000403e08 R15: 00007fef8c661000
>  [   23.149654]  </TASK>
>  [   23.149775] irq event stamp: 1131
>  [   23.149961] hardirqs last  enabled at (1139): [<ffffffff81420a0d>] console_unlock+0x22d/0x240
>  [   23.150428] hardirqs last disabled at (1148): [<ffffffff814209f2>] console_unlock+0x212/0x240
>  [   23.151012] softirqs last  enabled at (944): [<ffffffff8556dd60>] __do_softirq+0x4f0/0x791
>  [   23.151445] softirqs last disabled at (935): [<ffffffff81266fb1>] irq_exit_rcu+0xc1/0x110
>  [   23.151884] ---[ end trace 0000000000000000 ]---
> 
> 
> I hope it's helpful.
> 
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
> 
> Best Regards,
> Thanks!
