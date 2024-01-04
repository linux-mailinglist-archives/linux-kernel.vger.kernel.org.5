Return-Path: <linux-kernel+bounces-16436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B00823E92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63B2B2406B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7153208BD;
	Thu,  4 Jan 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRgXoMHy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFD208BC;
	Thu,  4 Jan 2024 09:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E564C433CB;
	Thu,  4 Jan 2024 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704360315;
	bh=MjMCefKdqw2bgvWvD1Fvsb+XGHLRcKB5hEV9zuVQb8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRgXoMHyFJaOT9jyJ79jVQ2dWimht7fYvXC16p0V59hPD4zMKyueFnCakjFAPcaTw
	 K0NS3L1wsRVJSzA/AmKnN//geecPw9EwLLdbZuvTc0ofFXEO9B9ZnIfRgmNHH58cIL
	 FLDzR8WQeWApErCFuxxQI/PoHcfq833G4hobsNhk=
Date: Thu, 4 Jan 2024 10:25:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/75] 5.10.206-rc1 review
Message-ID: <2024010402-commerce-variably-ef86@gregkh>
References: <20240103164842.953224409@linuxfoundation.org>
 <eb17f8c6-3967-4a39-aaa3-0252950c9084@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb17f8c6-3967-4a39-aaa3-0252950c9084@linaro.org>

On Thu, Jan 04, 2024 at 03:16:15AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 03/01/24 10:54 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.206 release.
> > There are 75 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.206-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We're seeing a kernel warning on:
> * Juno-r2
> * Dragonboard 410c
> * i386
> 
> that looks like this:
> 
> -----8<-----
>   ------------[ cut here ]------------
>   [  968.182348] WARNING: CPU: 2 PID: 16253 at kernel/module.c:261 module_kallsyms_on_each_symbol+0xaf/0xc0
>   [  968.191666] Modules linked in: x86_pkg_temp_thermal fuse ip_tables
>   [  968.197876] CPU: 2 PID: 16253 Comm: ftracetest Not tainted 5.10.206-rc1 #1
>   [  968.204786] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.7 12/07/2021
>   [  968.212208] EIP: module_kallsyms_on_each_symbol+0xaf/0xc0
>   [  968.217632] Code: 68 d9 75 a4 31 c0 8d 65 f4 5b 5e 5f 5d c3 8d 74 26 00 90 ba ff ff ff ff b8 38 36 68 d9 e8 e9 61 df 00 85 c0 0f 85 6f ff ff ff  0b e9 68 ff ff ff 8d b4 26 00 00 00 00 8d 76 00 3e 8d 74 26 00
>   [  968.236389] EAX: 00000000 EBX: 00000001 ECX: ffffffff EDX: 00000001
>   [  968.242700] ESI: c5839d68 EDI: 00025c3b EBP: c5839d54 ESP: c5839d3c
>   [  968.249008] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
>   [  968.255845] CR0: 80050033 CR2: 010d9b70 CR3: 05b30000 CR4: 003506d0
>   [  968.262138] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>   [  968.268413] DR6: fffe0ff0 DR7: 00000400
>   [  968.272278] Call Trace:
>   [  968.274817]  ? show_regs.cold+0x14/0x1a
>   [  968.278679]  ? __warn+0x71/0x100
>   [  968.281954]  ? module_kallsyms_on_each_symbol+0xaf/0xc0
>   [  968.287224]  ? report_bug+0x7e/0xa0
>   [  968.290736]  ? exc_overflow+0x40/0x40
>   [  968.294452]  ? handle_bug+0x2a/0x50
>   [  968.297971]  ? exc_invalid_op+0x1b/0x60
>   [  968.301836]  ? handle_exception+0x140/0x140
>   [  968.306052]  ? module_kallsyms_on_each_symbol+0xaf/0xc0
>   [  968.311310]  ? exc_overflow+0x40/0x40
>   [  968.314999]  ? module_kallsyms_on_each_symbol+0xaf/0xc0
>   [  968.320252]  ? trace_kprobe_run_command+0x20/0x20
>   [  968.324970]  ? trace_kprobe_run_command+0x20/0x20
>   [  968.329720]  kallsyms_on_each_symbol+0xc1/0xd0
>   [  968.334195]  ? trace_kprobe_run_command+0x20/0x20
>   [  968.338939]  trace_kprobe_create+0x5fd/0xb20
>   [  968.343243]  ? alloc_trace_kprobe+0x130/0x130
>   [  968.347628]  create_dyn_event+0x57/0xc0
>   [  968.351495]  ? dyn_event_release+0x140/0x140
>   [  968.355791]  trace_run_command+0x69/0x80
>   [  968.359754]  trace_parse_run_command+0x97/0x130
>   [  968.364339]  ? dyn_event_seq_next+0x20/0x20
>   [  968.368549]  dyn_event_write+0x10/0x20
>   [  968.372328]  ? dyn_event_release+0x140/0x140
>   [  968.376611]  vfs_write+0xe5/0x500
>   [  968.379973]  ? lock_acquire+0x8c/0x230
>   [  968.383752]  ? __might_fault+0x31/0x70
>   [  968.387545]  ? find_held_lock+0x24/0x80
>   [  968.391414]  ksys_write+0x72/0xf0
>   [  968.394759]  __ia32_sys_write+0x15/0x20
>   [  968.398621]  __do_fast_syscall_32+0x54/0xa0
>   [  968.402838]  do_fast_syscall_32+0x29/0x60
>   [  968.406868]  do_SYSENTER_32+0x15/0x20
>   [  968.410547]  entry_SYSENTER_32+0x9f/0xf2
>   [  968.414497] EIP: 0xb7f85549
>   [  968.417309] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80  5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
>   [  968.436081] EAX: ffffffda EBX: 00000001 ECX: 010ccdc0 EDX: 00000018
>   [  968.442371] ESI: b7f6aff4 EDI: 010ccdc0 EBP: 0044c4fc ESP: bfd964c0
>   [  968.448664] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
>   [  968.455478] irq event stamp: 77487
>   [  968.458912] hardirqs last  enabled at (77497): [] console_unlock+0x589/0x5a0
>   [  968.466837] hardirqs last disabled at (77506): [] console_unlock+0x41d/0x5a0
>   [  968.474799] softirqs last  enabled at (77474): [] call_on_stack+0x45/0x50
>   [  968.482480] softirqs last disabled at (77469): [] call_on_stack+0x45/0x50
>   [  968.490183] ---[ end trace 444b2433ce3c8b30 ]---
> ----->8-----
> 
> and this:
> 
> -----8<-----
>   ------------[ cut here ]------------
>   [  418.955406] WARNING: CPU: 1 PID: 10942 at kernel/module.c:261 module_assert_mutex+0x3c/0x50
>   [  418.963777] Modules linked in: tda998x cec drm_kms_helper crct10dif_ce fuse drm dm_mod ip_tables x_tables
>   [  418.973433] CPU: 1 PID: 10942 Comm: ftracetest Not tainted 5.10.206-rc1 #1
>   [  418.980324] Hardware name: ARM Juno development board (r2) (DT)
>   [  418.986261] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>   [  418.992284] pc : module_assert_mutex+0x3c/0x50
>   [  418.996739] lr : module_assert_mutex+0x38/0x50
>   [  419.001192] sp : ffff80001cd03a90
>   [  419.004515] x29: ffff80001cd03a90 x28: 0000000000000018
>   [  419.009853] x27: 0000000000000002 x26: ffff0008324a6f80
>   [  419.015189] x25: 0000000000000006 x24: ffff800012819678
>   [  419.020525] x23: ffff0008324a6608 x22: ffff800010229bd0
>   [  419.025861] x21: ffff800010229bd0 x20: ffff80001cd03c68
>   [  419.031196] x19: 0000000000000000 x18: 0000000000000000
>   [  419.036531] x17: 0000000000000000 x16: 0000000000000000
>   [  419.041867] x15: 0000aaab20142c50 x14: 0000000000000028
>   [  419.047202] x13: 0000000000000002 x12: 0000000000000003
>   [  419.052538] x11: 0000000000000002 x10: 0101010101010101
>   [  419.057873] x9 : ffff80001019b11c x8 : 7f7f7f7f7f7f7f7f
>   [  419.063209] x7 : 625e6b646d71646a x6 : 34001c0a651c383c
>   [  419.068544] x5 : 3c381c650a1c0034 x4 : 0000000000000000
>   [  419.073880] x3 : 7d95b99001c19d7c x2 : ffff80096cfc9000
>   [  419.079215] x1 : 0000000000000000 x0 : 0000000000000000
>   [  419.084551] Call trace:
>   [  419.087005]  module_assert_mutex+0x3c/0x50
>   [  419.091114]  module_kallsyms_on_each_symbol+0x2c/0x100
>   [  419.096267]  kallsyms_on_each_symbol+0xe0/0x120
>   [  419.100812]  trace_kprobe_create+0x4e4/0x9d0
>   [  419.105095]  create_dyn_event+0x80/0xf0
>   [  419.108943]  trace_run_command+0x90/0xac
>   [  419.112877]  trace_parse_run_command+0x120/0x4c0
>   [  419.117506]  dyn_event_write+0x18/0x24
>   [  419.121267]  vfs_write+0xec/0x20c
>   [  419.124592]  ksys_write+0x78/0x110
>   [  419.128004]  __arm64_sys_write+0x24/0x30
>   [  419.131939]  el0_svc_common.constprop.0+0x84/0x1e0
>   [  419.136743]  do_el0_svc+0x2c/0xa4
>   [  419.140069]  el0_svc+0x20/0x30
>   [  419.143132]  el0_sync_handler+0xe8/0x114
>   [  419.147065]  el0_sync+0x180/0x1c0
>   [  419.150387] irq event stamp: 48184
>   [  419.153800] hardirqs last  enabled at (48183): [] exit_to_kernel_mode+0x38/0x180
>   [  419.162781] hardirqs last disabled at (48184): [] el1_dbg+0x24/0x50
>   [  419.170630] softirqs last  enabled at (48168): [] __do_softirq+0x4dc/0x564
>   [  419.179091] softirqs last disabled at (48153): [] __irq_exit_rcu+0x170/0x194
>   [  419.187721] ---[ end trace 2989cd52be73b559 ]---
>   ------------[ cut here ]------------
>   [  419.263431] WARNING: CPU: 2 PID: 10942 at kernel/module.c:261 module_assert_mutex+0x3c/0x50
>   [  419.271801] Modules linked in: tda998x cec drm_kms_helper crct10dif_ce fuse drm dm_mod ip_tables x_tables
>   [  419.281457] CPU: 2 PID: 10942 Comm: ftracetest Tainted: G        W         5.10.206-rc1 #1
>   [  419.289740] Hardware name: ARM Juno development board (r2) (DT)
>   [  419.295676] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>   [  419.301698] pc : module_assert_mutex+0x3c/0x50
>   [  419.306154] lr : module_assert_mutex+0x38/0x50
>   [  419.310607] sp : ffff80001cd03a90
>   [  419.313930] x29: ffff80001cd03a90 x28: 0000000000000018
>   [  419.319267] x27: 0000000000000002 x26: ffff000831f8d500
>   [  419.324603] x25: 0000000000000007 x24: ffff800012819678
>   [  419.329939] x23: ffff000831f8d608 x22: ffff800010229bd0
>   [  419.335275] x21: ffff800010229bd0 x20: ffff80001cd03c68
>   [  419.340610] x19: 0000000000000000 x18: 0000000000000000
>   [  419.345946] x17: 0000000000000000 x16: 0000000000000000
>   [  419.351281] x15: 0000aaab20142c50 x14: 000000000003fffd
>   [  419.356616] x13: 0000000000000038 x12: 0000000000000038
>   [  419.361951] x11: 0000000000000002 x10: 0101010101010101
>   [  419.367287] x9 : ffff80001019b11c x8 : 7f7f7f7f7f7f7f7f
>   [  419.372622] x7 : 625e6b646d71646a x6 : 34001c0a651c383c
>   [  419.377958] x5 : 3c381c650a1c0034 x4 : 0000000000000000
>   [  419.383293] x3 : 7d95b99001c19d7c x2 : ffff80096cfeb000
>   [  419.388628] x1 : 0000000000000000 x0 : 0000000000000000
>   [  419.393964] Call trace:
>   [  419.396419]  module_assert_mutex+0x3c/0x50
>   [  419.400527]  module_kallsyms_on_each_symbol+0x2c/0x100
>   [  419.405679]  kallsyms_on_each_symbol+0xe0/0x120
>   [  419.410225]  trace_kprobe_create+0x4e4/0x9d0
>   [  419.414507]  create_dyn_event+0x80/0xf0
>   [  419.418355]  trace_run_command+0x90/0xac
>   [  419.422289]  trace_parse_run_command+0x120/0x4c0
>   [  419.426918]  dyn_event_write+0x18/0x24
>   [  419.430683]  vfs_write+0xec/0x20c
>   [  419.434007]  ksys_write+0x78/0x110
>   [  419.437419]  __arm64_sys_write+0x24/0x30
>   [  419.441354]  el0_svc_common.constprop.0+0x84/0x1e0
>   [  419.446159]  do_el0_svc+0x2c/0xa4
>   [  419.449486]  el0_svc+0x20/0x30
>   [  419.452549]  el0_sync_handler+0xe8/0x114
>   [  419.456482]  el0_sync+0x180/0x1c0
>   [  419.459805] irq event stamp: 48666
>   [  419.463218] hardirqs last  enabled at (48665): [] exit_to_kernel_mode+0x38/0x180
>   [  419.472199] hardirqs last disabled at (48666): [] el1_dbg+0x24/0x50
>   [  419.480048] softirqs last  enabled at (48664): [] __do_softirq+0x4dc/0x564
>   [  419.488508] softirqs last disabled at (48659): [] __irq_exit_rcu+0x170/0x194
>   [  419.497139] ---[ end trace 2989cd52be73b55a ]---
> ----->8-----
> 
> Test execution:
> 
>   https://lkft.validation.linaro.org/scheduler/job/7142331
> 
> Bisections (Arm64 and x86) point to:
> 
>   commit 47808d93a0cd0bb7358d9ef141e85216a4b86ef4
>   Author: Francis Laniel <flaniel@linux.microsoft.com>
>   Date:   Fri Oct 20 13:42:49 2023 +0300
> 
>       tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
>       commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.
> 
> 
> Reverting made the warning disappear on both Arm64 and i386.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

These patches are just flat out not worth it anymore, we have had more
problems with them over the past few months than I can remember ever
having for any other backport.

Francis, I'm sorry, but I give up here, I'm dropping these from all
queues again, and if you feel they need to get into an older kernel tree
like these, please submit the needed changes to the
device/vendor/whomever trees as they can deal with the fallout, this has
caused too many problems for the LTS kernels...

thanks,

greg k-h

