Return-Path: <linux-kernel+bounces-66264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F16855979
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07511F2C986
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889A611B;
	Thu, 15 Feb 2024 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMvmvr86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD228E6;
	Thu, 15 Feb 2024 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967252; cv=none; b=tV3wLQJsvNPtGj+EzqrfgAAtdFs/C/VxdBUd1WO9kp5QVq4foTAxaqNMy5cm5qETFYinK05gunI1/D+7JIzazLxiuLehoELvjkYBGvlI/G/hg0u7/0l06RHbjaYNB9ERCmZQDEaitXx+F3W7Xxqd00d/zBmhbG37BAysKlPtObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967252; c=relaxed/simple;
	bh=aOwBPQLHmMyghx8zgmDsrX80jV2Bhqd4FSw6xi59xx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0BdBv4mTTMCEmVmFAviHKq+pAB4s8S/heIhpjRBjq33SZ7uKeppfzuoi8AE5XsEHzd6o681ecxodUhkBnNTszJ3o2tWQAUpOtBde5GZGwZ2wT2jI8eFaBfJKv08s+vnEkvmrrON8tkBLHm0of6ofjPUo/c8Q7rp79PSKiMHMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMvmvr86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC82C433F1;
	Thu, 15 Feb 2024 03:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707967251;
	bh=aOwBPQLHmMyghx8zgmDsrX80jV2Bhqd4FSw6xi59xx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMvmvr86MvGkQoluNo35aLLrnQaJm3zxKtO4GrDIWNKP852rNZl2FYdDeQlvQRY/3
	 J2+HtDFt+ajxF228y27915/YcTkLvKsBZ8SW5/GSjXKzcQpEh6yRJmwWGJd1El0rvX
	 zcDRFBhOUPP2bdPvMwZdR6+n7txibvdeYF2Ng5k+PE/m0qxxXMQfsEPB14KJ041PBv
	 +Dm5nyQpxF4y5YAEOvTx4MdZZM7A+NJDNX+UQ8djeTtmuj3QkzLaymjPpAG51F84/g
	 lignbjiaBzUDaivE46xYIv7+qktCnMiwpXKuiqdIlTrrFn0s/HASxGOPKHxvNaQ+/8
	 Aqg7hCfqld3iw==
Date: Wed, 14 Feb 2024 20:20:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240215032049.GA3944823@dev-arch.thelio-3990X>
References: <20231010171020.462211-4-david.kaplan@amd.com>
 <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>

On Mon, Feb 12, 2024 at 02:13:39PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the x86/bugs branch of tip:
> 
> Commit-ID:     4461438a8405e800f90e0e40409e5f3d07eed381
> Gitweb:        https://git.kernel.org/tip/4461438a8405e800f90e0e40409e5f3d07eed381
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Wed, 03 Jan 2024 19:36:26 +01:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Mon, 12 Feb 2024 11:42:15 +01:00
> 
> x86/retpoline: Ensure default return thunk isn't used at runtime
> 
> Make sure the default return thunk is not used after all return
> instructions have been patched by the alternatives because the default
> return thunk is insufficient when it comes to mitigating Retbleed or
> SRSO.
> 
> Fix based on an earlier version by David Kaplan <david.kaplan@amd.com>.
> 
>   [ bp: Fix the compilation error of warn_thunk_thunk being an invisible
>         symbol, hoist thunk macro into calling.h ]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20231010171020.462211-4-david.kaplan@amd.com
> Link: https://lore.kernel.org/r/20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local

This warning is now getting triggered for me in some of my builds,
specifically from Alpine Linux's configuration. A minimal reproducer on
top of defconfig:

$ echo 'CONFIG_X86_KERNEL_IBT=n
CONFIG_UNWINDER_ORC=n
CONFIG_UNWINDER_FRAME_POINTER=y' >arch/x86/configs/repro.config

$ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- mrproper defconfig repro.config bzImage

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
    -smp 2 \
    -serial mon:stdio
[    0.000000] Linux version 6.7.0-01738-g4461438a8405-dirty (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Wed Feb 14 20:14:55 MST 2024
..
[    0.337317] ------------[ cut here ]------------
[    0.338282] Unpatched return thunk in use. This should not happen!
[    0.339292] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2856 __warn_thunk+0x27/0x40
[    0.340284] Modules linked in:
[    0.341021] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-01738-g4461438a8405-dirty #1
[    0.341281] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.342281] RIP: 0010:__warn_thunk+0x27/0x40
[    0.343281] Code: 90 90 90 80 3d 22 20 c3 01 00 74 05 e9 32 a5 eb 00 55 c6 05 13 20 c3 01 01 48 89 e5 90 48 c7 c7 80 80 50 89 e8 6a c4 03 00 90 <0f> 0b 90 90 5d e9 0f a5 eb 00 cc cc cc cc cc cc cc cc cc cc cc cc
[    0.344286] RSP: 0018:ffff8ba9c0013e10 EFLAGS: 00010286
[    0.345281] RAX: 0000000000000000 RBX: ffffffff89afba70 RCX: 0000000000000000
[    0.346281] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
[    0.347282] RBP: ffff8ba9c0013e10 R08: 00000000ffffdfff R09: ffff8ba9c0013c88
[    0.348282] R10: 0000000000000001 R11: ffffffff89856ae0 R12: 0000000000000000
[    0.349282] R13: ffff88c101126ac0 R14: ffff8ba9c0013e78 R15: 0000000000000000
[    0.350285] FS:  0000000000000000(0000) GS:ffff88c11f000000(0000) knlGS:0000000000000000
[    0.351283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.352282] CR2: ffff88c119601000 CR3: 0000000018e2c000 CR4: 0000000000350ef0
[    0.353284] Call Trace:
[    0.354281]  <TASK>
[    0.355281]  ? show_regs+0x60/0x70
[    0.356281]  ? __warn+0x84/0x150
[    0.357281]  ? __warn_thunk+0x27/0x40
[    0.358281]  ? report_bug+0x16d/0x1a0
[    0.359088]  ? console_unlock+0x4f/0xe0
[    0.359281]  ? handle_bug+0x43/0x80
[    0.360228]  ? exc_invalid_op+0x18/0x70
[    0.360281]  ? asm_exc_invalid_op+0x1b/0x20
[    0.361282]  ? ia32_binfmt_init+0x40/0x40
[    0.362283]  ? __warn_thunk+0x27/0x40
[    0.363283]  warn_thunk_thunk+0x16/0x30
[    0.364283]  do_one_initcall+0x59/0x230
[    0.365284]  kernel_init_freeable+0x1a4/0x2e0
[    0.366248]  ? __pfx_kernel_init+0x10/0x10
[    0.366282]  kernel_init+0x15/0x1b0
[    0.367200]  ret_from_fork+0x38/0x60
[    0.367280]  ? __pfx_kernel_init+0x10/0x10
[    0.368175]  ret_from_fork_asm+0x1b/0x30
[    0.368285]  </TASK>
[    0.369280] ---[ end trace 0000000000000000 ]---
..

If there is any more information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

# bad: [2c3b09aac00d7835023bbc4473ee06696be64fa8] Add linux-next specific files for 20240214
# good: [7e90b5c295ec1e47c8ad865429f046970c549a66] Merge tag 'trace-tools-v6.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect start '2c3b09aac00d7835023bbc4473ee06696be64fa8' '7e90b5c295ec1e47c8ad865429f046970c549a66'
# good: [a4f281576352365d7c83d9a2ff46c0430c8d6f1d] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good a4f281576352365d7c83d9a2ff46c0430c8d6f1d
# good: [2b837601fcd12acc492699f9148ca20a41d76b5d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
git bisect good 2b837601fcd12acc492699f9148ca20a41d76b5d
# bad: [4b0fab17a40c71b1202109cca7ab4854722f6fee] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect bad 4b0fab17a40c71b1202109cca7ab4854722f6fee
# bad: [09e1b07412d3a47f343acd2ab2459af3034e028b] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 09e1b07412d3a47f343acd2ab2459af3034e028b
# good: [2208f1364f1de82b19313f36e3e4758487183639] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
git bisect good 2208f1364f1de82b19313f36e3e4758487183639
# good: [fbbf6ba42cd4bbe1675db713d230fccda1183a47] Merge branch into tip/master: 'timers/ptp'
git bisect good fbbf6ba42cd4bbe1675db713d230fccda1183a47
# good: [0da9a7e5c86b003a9b446b30c90eaf96b2e442c2] spi: get rid of some legacy macros
git bisect good 0da9a7e5c86b003a9b446b30c90eaf96b2e442c2
# good: [64ffc035640f3a74205ae57d21fb171a88748b60] Merge branch into tip/master: 'irq/urgent'
git bisect good 64ffc035640f3a74205ae57d21fb171a88748b60
# good: [d1ff85fdf0b8f63a6e042ae7559c630f9b1c50e2] spi: pl022: Use typedef for dma_filter_fn
git bisect good d1ff85fdf0b8f63a6e042ae7559c630f9b1c50e2
# bad: [743a9723b476831c7910e6e15a714a713ab5989f] Merge branch into tip/master: 'x86/bugs'
git bisect bad 743a9723b476831c7910e6e15a714a713ab5989f
# good: [ee4c1592b7e9a5bf89b962d7afd7e9b04c8d16ee] irqchip/gic-v3-its: Remove usage of the deprecated ida_simple_xx() API
git bisect good ee4c1592b7e9a5bf89b962d7afd7e9b04c8d16ee
# good: [850d0fd76557fa4ad2d389a7d380f8a40043f874] Merge branch into tip/master: 'x86/urgent'
git bisect good 850d0fd76557fa4ad2d389a7d380f8a40043f874
# bad: [4461438a8405e800f90e0e40409e5f3d07eed381] x86/retpoline: Ensure default return thunk isn't used at runtime
git bisect bad 4461438a8405e800f90e0e40409e5f3d07eed381
# first bad commit: [4461438a8405e800f90e0e40409e5f3d07eed381] x86/retpoline: Ensure default return thunk isn't used at runtime

