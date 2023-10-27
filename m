Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5351D7D940B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjJ0JoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJ0JoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:44:04 -0400
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25475CE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:44:01 -0700 (PDT)
Message-ID: <4cb0c4ac-530b-4f91-b5e7-70786f42ca49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698399839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5obFc8PvkqxKdFIIr8905Hujj8BHkrYXzCRPtK0eD+0=;
        b=NPI2zohiCzfgMgLU6qF5qplPGrJKC3oemqiyQgQ8ljwJuCmvpvdiFBPWYY4bQl5imOjjiR
        fknNI0fji+5kSybuIeDCNS6bTbzUglMKDcOMyajGyZpG5sf1oeCFXAkYCwuMfeOViUZPC9
        f9dRCOfplRSSBZ8lPBVOxNQS6+UEjao=
Date:   Fri, 27 Oct 2023 17:43:24 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/5] slub: Introduce on_partial()
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <202310271308.9076b4c0-oliver.sang@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <202310271308.9076b4c0-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/27 13:26, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_mm/slub.c:#___add_partial" on:
> 
> commit: 0805463ab860a2dde667bd4423a30efbf650b34b ("[RFC PATCH 1/5] slub: Introduce on_partial()")
> url: https://github.com/intel-lab-lkp/linux/commits/chengming-zhou-linux-dev/slub-Introduce-on_partial/20231017-234739
> base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
> patch link: https://lore.kernel.org/all/20231017154439.3036608-2-chengming.zhou@linux.dev/
> patch subject: [RFC PATCH 1/5] slub: Introduce on_partial()
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +--------------------------------------------+------------+------------+
> |                                            | e050a704f3 | 0805463ab8 |
> +--------------------------------------------+------------+------------+
> | WARNING:at_mm/slub.c:#___add_partial       | 0          | 16         |
> | RIP:___add_partial                         | 0          | 16         |
> +--------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310271308.9076b4c0-oliver.sang@intel.com
> 
> 
> [    2.344426][    T0] ------------[ cut here ]------------
> [ 2.345095][ T0] WARNING: CPU: 0 PID: 0 at mm/slub.c:2132 ___add_partial (mm/slub.c:2132) 

The latest version "RFC v3" should have not this problem, since it changes to
use page flag "workingset" bit, instead of the mapcount, which has to be
initialized from -1 to 0 in allocate_slab().

Here, the problem is that the boot cache is not from allocate_slab().

RFC v3: https://lore.kernel.org/all/20231024093345.3676493-1-chengming.zhou@linux.dev/

Thanks!

> [    2.346072][    T0] Modules linked in:
> [    2.346555][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc5-00008-g0805463ab860 #1 e88a4d31ac7553ddd9cc4ecfa6b6cbc9ab8c98ab
> [    2.348039][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 2.349271][ T0] RIP: 0010:___add_partial (mm/slub.c:2132) 
> [ 2.349920][ T0] Code: 05 52 3f fb 05 53 48 89 f3 85 c0 75 0a 83 4b 30 01 5b e9 28 3c 06 03 48 83 c7 18 be ff ff ff ff e8 6a ec 02 03 85 c0 75 e4 90 <0f> 0b 90 83 4b 30 01 5b e9 08 3c 06 03 0f 1f 84 00 00 00 00 00 f6
> All code
> ========
>    0:	05 52 3f fb 05       	add    $0x5fb3f52,%eax
>    5:	53                   	push   %rbx
>    6:	48 89 f3             	mov    %rsi,%rbx
>    9:	85 c0                	test   %eax,%eax
>    b:	75 0a                	jne    0x17
>    d:	83 4b 30 01          	orl    $0x1,0x30(%rbx)
>   11:	5b                   	pop    %rbx
>   12:	e9 28 3c 06 03       	jmp    0x3063c3f
>   17:	48 83 c7 18          	add    $0x18,%rdi
>   1b:	be ff ff ff ff       	mov    $0xffffffff,%esi
>   20:	e8 6a ec 02 03       	call   0x302ec8f
>   25:	85 c0                	test   %eax,%eax
>   27:	75 e4                	jne    0xd
>   29:	90                   	nop
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	90                   	nop
>   2d:	83 4b 30 01          	orl    $0x1,0x30(%rbx)
>   31:	5b                   	pop    %rbx
>   32:	e9 08 3c 06 03       	jmp    0x3063c3f
>   37:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>   3e:	00 
>   3f:	f6                   	.byte 0xf6
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	90                   	nop
>    3:	83 4b 30 01          	orl    $0x1,0x30(%rbx)
>    7:	5b                   	pop    %rbx
>    8:	e9 08 3c 06 03       	jmp    0x3063c15
>    d:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>   14:	00 
>   15:	f6                   	.byte 0xf6
> [    2.352308][    T0] RSP: 0000:ffffffff86407dd8 EFLAGS: 00010046
> [    2.353078][    T0] RAX: 0000000000000000 RBX: ffffea0004001000 RCX: 0000000000000001
> [    2.354058][    T0] RDX: 0000000000000000 RSI: ffffffff84e8e940 RDI: ffffffff855b1ca0
> [    2.355041][    T0] RBP: ffff888100040000 R08: 0000000000000002 R09: 0000000000000000
> [    2.355978][    T0] R10: ffffffff86f35083 R11: ffffffff819fd2f1 R12: 0000000000000000
> [    2.356822][    T0] R13: ffff888100040048 R14: 0000000000000015 R15: ffffffff886073e0
> [    2.357702][    T0] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
> [    2.358674][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.359469][    T0] CR2: ffff88843ffff000 CR3: 00000000064dc000 CR4: 00000000000000b0
> [    2.360402][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.361328][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.362305][    T0] Call Trace:
> [    2.362722][    T0]  <TASK>
> [ 2.363087][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
> [ 2.365499][ T0] ? __warn (kernel/panic.c:673) 
> [ 2.366034][ T0] ? ___add_partial (mm/slub.c:2132) 
> [ 2.366627][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> [ 2.367200][ T0] ? handle_bug (arch/x86/kernel/traps.c:237) 
> [ 2.367743][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
> [ 2.368309][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
> [ 2.368930][ T0] ? kasan_set_track (mm/kasan/common.c:52) 
> [ 2.369529][ T0] ? ___add_partial (mm/slub.c:2132) 
> [ 2.370121][ T0] ? ___add_partial (mm/slub.c:2132 (discriminator 1)) 
> [ 2.370706][ T0] early_kmem_cache_node_alloc (include/linux/list.h:169 mm/slub.c:2156 mm/slub.c:4308) 
> [ 2.371471][ T0] kmem_cache_open (mm/slub.c:4340 mm/slub.c:4578) 
> [ 2.372060][ T0] __kmem_cache_create (mm/slub.c:5140) 
> [ 2.372688][ T0] create_boot_cache (mm/slab_common.c:654) 
> [ 2.373317][ T0] kmem_cache_init (mm/slub.c:5075) 
> [ 2.373936][ T0] mm_core_init (mm/mm_init.c:2786) 
> [ 2.374519][ T0] start_kernel (init/main.c:929) 
> [ 2.375103][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:544) 
> [ 2.375763][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:486 (discriminator 17)) 
> [ 2.376353][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433) 
> [    2.377096][    T0]  </TASK>
> [    2.377447][    T0] irq event stamp: 0
> [ 2.377916][ T0] hardirqs last enabled at (0): 0x0 
> [ 2.378794][ T0] hardirqs last disabled at (0): 0x0 
> [ 2.379684][ T0] softirqs last enabled at (0): 0x0 
> [ 2.380551][ T0] softirqs last disabled at (0): 0x0 
> [    2.381441][    T0] ---[ end trace 0000000000000000 ]---
> [    2.384117][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231027/202310271308.9076b4c0-oliver.sang@intel.com
> 
> 
> 
