Return-Path: <linux-kernel+bounces-109013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E249388135D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AC41C22641
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882B47F6A;
	Wed, 20 Mar 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8Ehzo7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A3848E;
	Wed, 20 Mar 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945174; cv=none; b=RFvxteSegr+WCtWrgw9zfoHTRwTVvGLPQjrE6jadwM8CDUdCdhlbMEAwPbZQ+w1SwBcRSSmlWUNuAeLHbflX7wVn/8sUGy65euFYTY8CuGT7n1H9hO3bXi/bDOG0hfyC6HDnecqxYbLPEtaF1ncmtnO5YLHAIBB7431FVHGNJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945174; c=relaxed/simple;
	bh=3JQ9oCUa5g8iZh84z/dzwbM73ILVKpXL8PoHZSM9gvk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VdHwoIcSxPY12RRCh1Oa24NpqjEmHPfWweAstenry7s1iGE3Ad6fQwjClC5FHXFecZ2FhrnbzEUhwbMgV0745Rr3xCwter0FTnr5vCdc0AVJOMC2Z8Gi+2/cZaamd98syb3xqop62dGLLcHEeBgShW+hPJcdJTS2NqDdytIabUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Ehzo7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EA6C433F1;
	Wed, 20 Mar 2024 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945173;
	bh=3JQ9oCUa5g8iZh84z/dzwbM73ILVKpXL8PoHZSM9gvk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=c8Ehzo7BsszXKbeF3LNKpF6Noap1iL3xRmv2MnDQjRhbF+toiBF9BaRxOKKcRFkXv
	 1xpyj1S8yy1sD+lkm5SiEcx19yx+IjzXO+t9hL1CRkMljzLPJyBjsVbGvfUx7WhMR1
	 m2MDFZ/x2Onu4npbOlbJFMfArm6DCgIbWWkSc/McJA1zkI6zwc9u/ixbwcBNbdd9ng
	 19PafV4b/09z9cPu7fgQ3sUWEAGVT/JrML6OOBeKdWw5zXWWNbfl4JaDtcDagSSpHu
	 gDunFaw3IdNDYmKRg97fk3tsPmo2Lv8y8OelQS/imOBg5D4jy02kJAxC8daTuudfBW
	 JQBttvHSEW84w==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,  kuba@kernel.org,
  keescook@chromium.org,  linux-wireless@vger.kernel.org (open
 list:NETWORKING DRIVERS (WIRELESS)),  ath11k@lists.infradead.org (open
 list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
  linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] wifi: ath11k: allocate dummy net_device dynamically
References: <20240319185735.1268980-1-leitao@debian.org>
Date: Wed, 20 Mar 2024 16:32:49 +0200
In-Reply-To: <20240319185735.1268980-1-leitao@debian.org> (Breno Leitao's
	message of "Tue, 19 Mar 2024 11:57:33 -0700")
Message-ID: <871q85as8e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
>
> Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at ath11k_ahb_config_ext_irq() for ahb, and
> ath11k_pcic_ext_irq_config() for pcic.
>
>  The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
> case, and ath11k_pcic_free_ext_irq() for the pcic case.
>
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

This crashes on my nuc x86 test box with WCN6855 hw2.0 when running
rmmod, stacktrace below. I used tag ath-202403201010 from my ath.git
tree as the baseline. Sorry that I'm not able to debug this further
right now.

[  116.584290] rmmod ath11k_pci
[  117.274127] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  117.274175] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[  117.274210] CPU: 1 PID: 1467 Comm: rmmod Not tainted 6.8.0-wt-ath+ #1338
[  117.274259] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  117.274290] RIP: 0010:memcmp (lib/string.c:666) 
[ 117.274335] Code: 24 0f 85 1a ff ff ff 49 83 ed 08 48 83 c3 08 49 83 c4 08 49 83 fd 07 0f 86 fb fe ff ff 48 89 d8 48 89 de 48 c1 e8 03 83 e6 07 <42> 0f b6 14 30 48 8d 43 07 48 89 c1 48 c1 e9 03 40 38 f2 40 0f 9e
All code
========
   0:	24 0f                	and    $0xf,%al
   2:	85 1a                	test   %ebx,(%rdx)
   4:	ff                   	(bad)
   5:	ff                   	(bad)
   6:	ff 49 83             	decl   -0x7d(%rcx)
   9:	ed                   	in     (%dx),%eax
   a:	08 48 83             	or     %cl,-0x7d(%rax)
   d:	c3                   	ret
   e:	08 49 83             	or     %cl,-0x7d(%rcx)
  11:	c4                   	(bad)
  12:	08 49 83             	or     %cl,-0x7d(%rcx)
  15:	fd                   	std
  16:	07                   	(bad)
  17:	0f 86 fb fe ff ff    	jbe    0xffffffffffffff18
  1d:	48 89 d8             	mov    %rbx,%rax
  20:	48 89 de             	mov    %rbx,%rsi
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e6 07             	and    $0x7,%esi
  2a:*	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx		<-- trapping instruction
  2f:	48 8d 43 07          	lea    0x7(%rbx),%rax
  33:	48 89 c1             	mov    %rax,%rcx
  36:	48 c1 e9 03          	shr    $0x3,%rcx
  3a:	40 38 f2             	cmp    %sil,%dl
  3d:	40                   	rex
  3e:	0f                   	.byte 0xf
  3f:	9e                   	sahf

Code starting with the faulting instruction
===========================================
   0:	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx
   5:	48 8d 43 07          	lea    0x7(%rbx),%rax
   9:	48 89 c1             	mov    %rax,%rcx
   c:	48 c1 e9 03          	shr    $0x3,%rcx
  10:	40 38 f2             	cmp    %sil,%dl
  13:	40                   	rex
  14:	0f                   	.byte 0xf
  15:	9e                   	sahf
[  117.274385] RSP: 0018:ffffc90004177af0 EFLAGS: 00010246
[  117.274423] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffffffff57f2de9
[  117.274461] RDX: 0000000000000020 RSI: 0000000000000000 RDI: 0000000000000000
[  117.274493] RBP: ffffc90004177b20 R08: 0000000000000001 R09: fffffbfff57f3342
[  117.274529] R10: ffffffffabf99a17 R11: ffffffffaa325926 R12: ffff888112c54bf8
[  117.274568] R13: 0000000000000020 R14: dffffc0000000000 R15: ffff888112c54688
[  117.274603] FS:  00007f1520d33740(0000) GS:ffff888231c00000(0000) knlGS:0000000000000000
[  117.274637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.274672] CR2: 00007f675c010d68 CR3: 000000010a9a0001 CR4: 00000000003706f0
[  117.274707] Call Trace:
[  117.274740]  <TASK>
[  117.274776] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[  117.274841] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
[  117.274891] ? exc_general_protection (arch/x86/kernel/traps.c:701 arch/x86/kernel/traps.c:643) 
[  117.274935] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:564) 
[  117.274983] ? do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[  117.275019] ? memcmp (lib/string.c:666) 
[  117.275050] dev_addr_check (net/core/dev_addr_lists.c:513 (discriminator 1)) 
[  117.275090] dev_addr_flush (net/core/dev_addr_lists.c:535) 
[  117.275127] free_netdev (net/core/dev.c:10976) 
[  117.275164] ath11k_pcic_free_irq (drivers/net/wireless/ath/ath11k/pcic.c:312 (discriminator 2) drivers/net/wireless/ath/ath11k/pcic.c:334 (discriminator 2)) ath11k
[  117.275234] ath11k_pci_remove (drivers/net/wireless/ath/ath11k/pci.c:478 drivers/net/wireless/ath/ath11k/pci.c:987) ath11k_pci
[  117.275273] pci_device_remove (./include/linux/pm_runtime.h:140 drivers/pci/pci-driver.c:477) 
[  117.275309] device_remove (drivers/base/dd.c:570) 
[  117.275338] device_release_driver_internal (drivers/base/dd.c:1274 drivers/base/dd.c:1295) 
[  117.275374] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[  117.275412] driver_detach (drivers/base/dd.c:1359) 
[  117.275448] bus_remove_driver (drivers/base/bus.c:736) 
[  117.275481] driver_unregister (drivers/base/driver.c:275) 
[  117.275518] pci_unregister_driver (./include/linux/spinlock.h:351 drivers/pci/pci-driver.c:85 drivers/pci/pci-driver.c:1472) 
[  117.275553] ? find_module_all (kernel/module/main.c:357 (discriminator 1)) 
[  117.275588] ath11k_pci_exit (drivers/net/wireless/ath/ath11k/pci.c:1069) ath11k_pci
[  117.275625] __do_sys_delete_module (kernel/module/main.c:756) 
[  117.275663] ? module_flags (kernel/module/main.c:700) 
[  117.275697] ? kmem_cache_free (mm/slub.c:4299 (discriminator 3) mm/slub.c:4363 (discriminator 3)) 
[  117.275726] ? __fput (fs/file_table.c:390) 
[  117.275763] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[  117.275802] __x64_sys_delete_module (kernel/module/main.c:698) 
[  117.275890] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[  117.275925] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  117.275954] RIP: 0033:0x7f1520e80c8b
[ 117.275994] Code: 73 01 c3 48 8b 0d 05 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 c1 0c 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	ret
   3:	48 8b 0d 05 c2 0c 00 	mov    0xcc205(%rip),%rcx        # 0xcc20f
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	ret
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	90                   	nop
  1f:	f3 0f 1e fa          	endbr64
  23:	b8 b0 00 00 00       	mov    $0xb0,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d d5 c1 0c 00 	mov    0xcc1d5(%rip),%rcx        # 0xcc20f
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d d5 c1 0c 00 	mov    0xcc1d5(%rip),%rcx        # 0xcc1e5
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  117.276031] RSP: 002b:00007ffe05526498 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  117.276069] RAX: ffffffffffffffda RBX: 00005582d521c7e0 RCX: 00007f1520e80c8b
[  117.276098] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005582d521c848
[  117.276134] RBP: 00007ffe055264f8 R08: 0000000000000000 R09: 0000000000000000
[  117.276174] R10: 00007f1520efcac0 R11: 0000000000000206 R12: 00007ffe055266d0
[  117.276208] R13: 00007ffe05527eb7 R14: 00005582d521b2a0 R15: 00005582d521c7e0
[  117.276245]  </TASK>
[  117.276280] Modules linked in: ath11k_pci(-) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
[  117.276380] ---[ end trace 0000000000000000 ]---
[  117.298338] RIP: 0010:memcmp (lib/string.c:666) 
[ 117.298394] Code: 24 0f 85 1a ff ff ff 49 83 ed 08 48 83 c3 08 49 83 c4 08 49 83 fd 07 0f 86 fb fe ff ff 48 89 d8 48 89 de 48 c1 e8 03 83 e6 07 <42> 0f b6 14 30 48 8d 43 07 48 89 c1 48 c1 e9 03 40 38 f2 40 0f 9e
All code
========
   0:	24 0f                	and    $0xf,%al
   2:	85 1a                	test   %ebx,(%rdx)
   4:	ff                   	(bad)
   5:	ff                   	(bad)
   6:	ff 49 83             	decl   -0x7d(%rcx)
   9:	ed                   	in     (%dx),%eax
   a:	08 48 83             	or     %cl,-0x7d(%rax)
   d:	c3                   	ret
   e:	08 49 83             	or     %cl,-0x7d(%rcx)
  11:	c4                   	(bad)
  12:	08 49 83             	or     %cl,-0x7d(%rcx)
  15:	fd                   	std
  16:	07                   	(bad)
  17:	0f 86 fb fe ff ff    	jbe    0xffffffffffffff18
  1d:	48 89 d8             	mov    %rbx,%rax
  20:	48 89 de             	mov    %rbx,%rsi
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e6 07             	and    $0x7,%esi
  2a:*	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx		<-- trapping instruction
  2f:	48 8d 43 07          	lea    0x7(%rbx),%rax
  33:	48 89 c1             	mov    %rax,%rcx
  36:	48 c1 e9 03          	shr    $0x3,%rcx
  3a:	40 38 f2             	cmp    %sil,%dl
  3d:	40                   	rex
  3e:	0f                   	.byte 0xf
  3f:	9e                   	sahf

Code starting with the faulting instruction
===========================================
   0:	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx
   5:	48 8d 43 07          	lea    0x7(%rbx),%rax
   9:	48 89 c1             	mov    %rax,%rcx
   c:	48 c1 e9 03          	shr    $0x3,%rcx
  10:	40 38 f2             	cmp    %sil,%dl
  13:	40                   	rex
  14:	0f                   	.byte 0xf
  15:	9e                   	sahf
[  117.298448] RSP: 0018:ffffc90004177af0 EFLAGS: 00010246
[  117.298504] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffffffff57f2de9
[  117.298554] RDX: 0000000000000020 RSI: 0000000000000000 RDI: 0000000000000000
[  117.298600] RBP: ffffc90004177b20 R08: 0000000000000001 R09: fffffbfff57f3342
[  117.298651] R10: ffffffffabf99a17 R11: ffffffffaa325926 R12: ffff888112c54bf8
[  117.298700] R13: 0000000000000020 R14: dffffc0000000000 R15: ffff888112c54688
[  117.298749] FS:  00007f1520d33740(0000) GS:ffff888231c00000(0000) knlGS:0000000000000000
[  117.298810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.298871] CR2: 00007f675c010d68 CR3: 000000010a9a0001 CR4: 00000000003706f0
[  117.298924] Kernel panic - not syncing: Fatal exception
[  117.299488] Kernel Offset: 0x26600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  117.328105] Rebooting in 10 seconds..


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

