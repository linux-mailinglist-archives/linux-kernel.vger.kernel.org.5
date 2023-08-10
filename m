Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB5776D88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHJBdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB321724
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5FA643A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F65C433C7;
        Thu, 10 Aug 2023 01:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691631216;
        bh=gP6HC777B4X+ZrXpZEtRNpMmXZwrWKbLpJ1cD2Fo2sM=;
        h=Date:From:To:Cc:Subject:From;
        b=fqvkJmTkmVVpyy6qoH14dyU8wVIh+nWssarntB2W50FlLBbcY2K4FgMpk+tPxRp/2
         1yJeBeR9paVVR9ENDu41eFntjyWfG/x/8W7kdVeACSIXXpN8iDfbFHtqRoTcVDiOIr
         JJTnfpOSIzGjscNE+5pRhK5542Ue0bQVl+0zv8wT7mGArn8ndRrFi6u537fc62hJ9b
         hBy2YL0dr1bX0RxgeTof1TO6R+4K5mqc6oXU1r4hL0gwsPZhQGjwSwsvAu6pj4hapW
         2CjPn3OZCwtIlBY7KPuqPWr9Q/DGDm/IZqD7rsKnTGoimdVsAiboWHTNNeA+BvsL7r
         Aw64d9A+T0HkQ==
Date:   Wed, 9 Aug 2023 18:33:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810013334.GA5354@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I updated my AMD 3990X workstation to a version of mainline that
contains the SRSO mitigations and I am now seeing a hang when booting
guest kernels built with clang in QEMU/KVM with an '-smp' value greater
than one (I am just testing 'ARCH=x86_64 defconfig', nothing fancy). The
host's kernel is built with GCC 13.2.0, in case that is relevant. The
issue happens with all versions of clang that the kernel supports
(11.x+). I do not see the issue with guest kernels built with GCC nor do
I see the issue with '-smp 1', so it could be something that clang has
done to the guest kernel that causes this but I figured I would report
it early anyways.

With '-smp 4' (for example), I see

  [    0.102817] smpboot: CPU0: AMD Ryzen Threadripper 3990X 64-Core Processor (family: 0x17, model: 0x31, stepping: 0x0)
  ...
  [    0.109778] smp: Bringing up secondary CPUs ...
  [    0.110559] smpboot: x86: Booting SMP configuration:

then nothing after that, until timeout kills QEMU.

With '-smp 2', I can get all the way to userspace but it hangs when
shutting down and I see what appears to be basically the same stack
trace three times (I just included the last one):

  Sent SIGKILL to all processes
  Requesting system poweroff
  [    2.499704] ACPI: PM: Preparing to enter system sleep state S5
  [    2.500470] reboot: Power down
  ...
  [  152.698101] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  [  152.698813] rcu:     0-...0: (9 ticks this GP) idle=556c/1/0x4000000000000000 softirq=333/335 fqs=29392
  [  152.699718] rcu:     (detected by 1, t=147019 jiffies, g=-1003, q=2 ncpus=2)
  [  152.700368] Sending NMI from CPU 1 to CPUs 0:
  [  152.700795] NMI backtrace for cpu 0
  [  152.700799] CPU: 0 PID: 117 Comm: init Not tainted 6.5.0-rc5 #1
  [  152.700800] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
  [  152.700802] RIP: 0010:default_send_IPI_allbutself+0x2a/0x60
  [  152.700806] Code: 83 ff 02 74 35 66 66 2e 0f 1f 84 00 00 00 00 00 f7 04 25 00 c3 5f ff 00 10 00 00 74 0f f3 90 f7 04 25 00 c3 5f ff 00 10 00 00 <75> f1 81 cf 00 00 0c 00 89 3c 25 00 c3 5f ff c3 48 8b 05 d7 2c 61
  [  152.700807] RSP: 0018:ffff99e58027fdb0 EFLAGS: 00000082
  [  152.700808] RAX: ffffffff8426ab50 RBX: 0000000000000000 RCX: 0000000000000001
  [  152.700809] RDX: ffffffffff5fb000 RSI: 00000000000000f8 RDI: 00000000000000f8
  [  152.700810] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff84482120
  [  152.700810] R10: 0000000000000000 R11: ffffffff82c57f50 R12: 000000004321fedc
  [  152.700811] R13: fffffffffee1dead R14: 0000000000000000 R15: 0000000028121969
  [  152.700813] FS:  00007f1eb36696a0(0000) GS:ffff978b9f000000(0000) knlGS:0000000000000000
  [  152.700814] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  152.700815] CR2: 00007f09d4a8a360 CR3: 00000000024c4000 CR4: 0000000000350ef0
  [  152.700817] Call Trace:
  [  152.700819]  <NMI>
  [  152.700820]  ? nmi_cpu_backtrace+0xde/0x110
  [  152.700822]  ? nmi_cpu_backtrace_handler+0x8/0x10
  [  152.700823]  ? nmi_handle+0x69/0x150
  [  152.700824]  ? default_do_nmi+0x43/0x1d0
  [  152.700826]  ? exc_nmi+0xbc/0x130
  [  152.700827]  ? end_repeat_nmi+0x16/0x67
  [  152.700836]  ? default_send_IPI_single+0x30/0x30
  [  152.700838]  ? default_send_IPI_allbutself+0x2a/0x60
  [  152.700839]  ? default_send_IPI_allbutself+0x2a/0x60
  [  152.700840]  ? default_send_IPI_allbutself+0x2a/0x60
  [  152.700840]  </NMI>
  [  152.700841]  <TASK>
  [  152.700841]  native_stop_other_cpus+0x7d/0x1f0
  [  152.700843]  native_machine_shutdown+0x17/0x40
  [  152.700844]  native_machine_power_off+0x24/0x30
  [  152.700846]  __se_sys_reboot+0x221/0x230
  [  152.700848]  do_syscall_64+0x31/0x50
  [  152.700849]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  [  152.700851] RIP: 0033:0x7f1eb35ceffb
  [  152.700853] Code: ff 76 10 48 8b 15 95 ee 07 00 f7 d8 64 89 02 48 83 c8 ff c3 48 63 d7 be 69 19 12 28 b8 a9 00 00 00 48 c7 c7 ad de e1 fe 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 66 ee 07 00 f7 d8 64 89 02 48 83
  [  152.700854] RSP: 002b:00007fff81094238 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
  [  152.700855] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f1eb35ceffb
  [  152.700855] RDX: 000000004321fedc RSI: 0000000028121969 RDI: fffffffffee1dead
  [  152.700856] RBP: 000000004321fedc R08: 8080808080808080 R09: 6b6470ff65656e71
  [  152.700856] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fff81095fc2
  [  152.700857] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [  152.700858]  </TASK>

I tested the other mitigation options for SRSO and it seems the only one
that has problems is safe-ret (I don't think there is a microcode update
for this machine yet, so I did not both trying microcode).

  spec_rstack_overflow=off: No issue
  spec_rstack_overflow=safe-ret: Has issue
  spec_rstack_overflow=ibpb: No issue
  spec_rstack_overflow=ibpb-vmexit: No issue

My QEMU command, in case it is relevant, the rootfs is available at
https://github.com/ClangBuiltLinux/boot-utils/releases/tag/20230707-182910.

$ qemu-system-x86_64 \
    -display none \
    -nodefaults \
    -d unimp,guest_errors \
    -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
    -kernel arch/x86/boot/bzImage \
    -initrd rootfs.cpio \
    -cpu host \
    -enable-kvm \
    -m 512m \
    -smp 4 \
    -serial mon:stdio

If there is any other information I can provide or patches I can test, I
am more than happy to do so. Should you need access to a clang toolchain
for building the guest kernel (if you did not want to bother installing
one from your distro), I have ones available on kernel.org similar to
the GCC ones that should work fine:

https://mirrors.edge.kernel.org/pub/tools/llvm/

Cheers,
Nathan
