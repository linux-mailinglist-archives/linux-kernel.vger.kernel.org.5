Return-Path: <linux-kernel+bounces-7488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C224D81A8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C81F2376C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D5495FF;
	Wed, 20 Dec 2023 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SUeOlT8k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B749F69;
	Wed, 20 Dec 2023 22:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BB7C433C8;
	Wed, 20 Dec 2023 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703110296;
	bh=sm3RwEnabihgci1zAS1Niy3ded5Q9O5i+QwJLM3T4p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUeOlT8kEyODlh+nMkRcz8Gnws9xOOdHK/F2sUcbmDICJ1WBWc73DAZP2Y0VphM9v
	 BAZdlkaZ5ee0vOdS/3usEQTz+7o/AylPPT+f0/c7fhkzzejnkBiwruff533QHJb220
	 8SFRU2X+onG4eiPNFU6q7MHJT/4ChiWllMRyr8Bg=
Date: Wed, 20 Dec 2023 14:11:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>,
 "David Hildenbrand" <david@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next:master] [mm]  bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-Id: <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
In-Reply-To: <202312192319.fa8f5709-oliver.sang@intel.com>
References: <202312192319.fa8f5709-oliver.sang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
> 
> commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")

I assume this is a bisection result, so it's quite repeatable?

> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master aa4db8324c4d0e67aa4670356df4e9fae14b4d37]
> 
> in testcase: vm-scalability
> version: vm-scalability-x86_64-1.0-0_20220518
> with following parameters:
> 
> 	runtime: 300
> 	thp_enabled: always
> 	thp_defrag: always
> 	nr_task: 32
> 	nr_ssd: 1
> 	priority: 1
> 	test: swap-w-rand
> 	cpufreq_governor: performance
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> 
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com
> 
> 
> [   61.404380][ T5947] ------------[ cut here ]------------
> [   61.409984][ T5947] kernel BUG at mm/memory.c:3990!
> [   61.415085][ T5947] invalid opcode: 0000 [#1] SMP NOPTI

This is

	BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));

and I don't believe that the error path fix
(https://lkml.kernel.org/r/ZXnPtblC6A1IkyAB@casper.infradead.org) will
address this.

Matthew, have you had a chance to consider?

Thanks.

> [   61.420506][ T5947] CPU: 32 PID: 5947 Comm: usemem Tainted: G S                 6.7.0-rc4-00252-gbbcbf2a3f05f #1
> [   61.430881][ T5947] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
> [ 61.442761][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> [ 61.448112][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
> All code
> ========
>    0:	6f                   	outsl  %ds:(%rsi),(%dx)
>    1:	28 31                	sub    %dh,(%rcx)
>    3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
>    9:	4c 89 ff             	mov    %r15,%rdi
>    c:	e8 9b 43 03 00       	call   0x343ac
>   11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
>   18:	00 
>   19:	4c 89 f9             	mov    %r15,%rcx
>   1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
>   23:	00 00 
>   25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	49 8b 45 08          	mov    0x8(%r13),%rax
>   30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>   35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
>   3b:	49 8b 45 08          	mov    0x8(%r13),%rax
>   3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	49 8b 45 08          	mov    0x8(%r13),%rax
>    6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>    b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
>   11:	49 8b 45 08          	mov    0x8(%r13),%rax
>   15:	4c                   	rex.WR
> [   61.468016][ T5947] RSP: 0000:ffa000000bb5fd98 EFLAGS: 00010206
> [   61.474169][ T5947] RAX: ff11000111a47c99 RBX: ffa000000bb5fe08 RCX: 0000002064ac7000
> [   61.482233][ T5947] RDX: 0057ffffc00a106d RSI: 0000000000000043 RDI: ffd400008192b1e8
> [   61.490296][ T5947] RBP: 000000000100c13b R08: 0000000000000000 R09: ffa000000bb5fe08
> [   61.498366][ T5947] R10: 0000000055555554 R11: ff1100018bebbd0c R12: ffd4000044128000
> [   61.506438][ T5947] R13: ff1100205d33d800 R14: ff11000130cd2da8 R15: ffd4000044128000
> [   61.514508][ T5947] FS:  00007f49c900c740(0000) GS:ff11002001000000(0000) knlGS:0000000000000000
> [   61.523534][ T5947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   61.530225][ T5947] CR2: 00007f4966b3b6b8 CR3: 00000010af786004 CR4: 0000000000771ef0
> [   61.538307][ T5947] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   61.546387][ T5947] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   61.554471][ T5947] PKRU: 55555554
> [   61.558137][ T5947] Call Trace:
> [   61.561544][ T5947]  <TASK>
> [ 61.564599][ T5947] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
> [ 61.568429][ T5947] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
> [ 61.572692][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> [ 61.577475][ T5947] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
> [ 61.582172][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> [ 61.586966][ T5947] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
> [ 61.591743][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> [ 61.596515][ T5947] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
> [ 61.601638][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> [ 61.606412][ T5947] ? do_swap_page (mm/memory.c:3971) 
> [ 61.611179][ T5947] __handle_mm_fault (mm/memory.c:5274) 
> [ 61.616203][ T5947] handle_mm_fault (mm/memory.c:5439) 
> [ 61.621051][ T5947] do_user_addr_fault (arch/x86/mm/fault.c:1365) 
> [ 61.626151][ T5947] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
> [ 61.630824][ T5947] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
> [   61.635748][ T5947] RIP: 0033:0x5612d5878ad6
> [ 61.640229][ T5947] Code: 01 00 00 00 e8 1b f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 0a f9 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 21 01 00 00
> All code
> ========
>    0:	01 00                	add    %eax,(%rax)
>    2:	00 00                	add    %al,(%rax)
>    4:	e8 1b f9 ff ff       	call   0xfffffffffffff924
>    9:	89 c7                	mov    %eax,%edi
>    b:	e8 6c ff ff ff       	call   0xffffffffffffff7c
>   10:	bf 00 00 00 00       	mov    $0x0,%edi
>   15:	e8 0a f9 ff ff       	call   0xfffffffffffff924
>   1a:	85 d2                	test   %edx,%edx
>   1c:	74 08                	je     0x26
>   1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
>   22:	48 8b 00             	mov    (%rax),%rax
>   25:	c3                   	ret
>   26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
>   2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
>   2d:	b8 00 00 00 00       	mov    $0x0,%eax
>   32:	c3                   	ret
>   33:	41 54                	push   %r12
>   35:	55                   	push   %rbp
>   36:	53                   	push   %rbx
>   37:	48 85 ff             	test   %rdi,%rdi
>   3a:	0f 84 21 01 00 00    	je     0x161
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 89 30             	mov    %rsi,(%rax)
>    3:	b8 00 00 00 00       	mov    $0x0,%eax
>    8:	c3                   	ret
>    9:	41 54                	push   %r12
>    b:	55                   	push   %rbp
>    c:	53                   	push   %rbx
>    d:	48 85 ff             	test   %rdi,%rdi
>   10:	0f 84 21 01 00 00    	je     0x137
> [   61.660112][ T5947] RSP: 002b:00007ffd09f037d8 EFLAGS: 00010246
> [   61.666250][ T5947] RAX: 00007f4966b3b6b8 RBX: 000000000000358f RCX: 00000005deece66d
> [   61.674295][ T5947] RDX: 0000000000000000 RSI: 000000002fa0f0d7 RDI: 00007f47e9ac3000
> [   61.682347][ T5947] RBP: 000000002fa0f0d7 R08: 00007ffd09f0386c R09: 0000000000000001
> [   61.690401][ T5947] R10: 00007ffd09f037c0 R11: 0000000000000000 R12: 000000000001ac78
> [   61.698449][ T5947] R13: 00007f47e9ac3000 R14: 00007ffd09f0386c R15: 00007ffd09f03970
> [   61.706500][ T5947]  </TASK>
> [   61.709607][ T5947] Modules linked in: kmem xfs loop device_dax nd_pmem dax_pmem nd_btt btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 ahci ipmi_ssif rapl intel_cstate ast libahci mei_me drm_shmem_helper i2c_i801 ioatdma acpi_ipmi libata drm_kms_helper mei intel_uncore joydev i2c_smbus intel_pch_thermal dax_hmem dca wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad drm fuse ip_tables
> [   61.768510][ T5947] ---[ end trace 0000000000000000 ]---
> [   61.786010][ T5947] pstore: backend (erst) writing error (-28)
> [ 61.792055][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> [ 61.797397][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
> All code
> ========
>    0:	6f                   	outsl  %ds:(%rsi),(%dx)
>    1:	28 31                	sub    %dh,(%rcx)
>    3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
>    9:	4c 89 ff             	mov    %r15,%rdi
>    c:	e8 9b 43 03 00       	call   0x343ac
>   11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
>   18:	00 
>   19:	4c 89 f9             	mov    %r15,%rcx
>   1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
>   23:	00 00 
>   25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	49 8b 45 08          	mov    0x8(%r13),%rax
>   30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>   35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
>   3b:	49 8b 45 08          	mov    0x8(%r13),%rax
>   3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	49 8b 45 08          	mov    0x8(%r13),%rax
>    6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>    b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
>   11:	49 8b 45 08          	mov    0x8(%r13),%rax
>   15:	4c                   	rex.WR
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231219/202312192319.fa8f5709-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

