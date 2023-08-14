Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3077BFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjHNS3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjHNS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1976B0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76323617B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFBC433C8;
        Mon, 14 Aug 2023 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037748;
        bh=+J6+5SutFeJ89Mqn0yh0QTcvEeCpscHLLIXn77onoak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJYhJDcHWweEanNZygs/2kY2SdsMcw4aoAHnrgCYSvEr3zV7ORsXkmuao80t7twZC
         y1KiZFOz1zeV7Guj+GmtofcUYR1JethH/nN9rCUbOq27z1SlKjaNZySsV1zhHJ6BAm
         J/Zea96PbyPtX4yUSMtucmy6FVm9Bzi3xjuRas0l5oViyXADMCNa2/zL36uL/4e5yp
         c7AUbRfAoHU+xRglaH3tHqzgeAMAajTNuYekXd8+AR5fLodJ2xNhHo30C+gaqIKZho
         aIgASg1mvJz9DS1qvA9ikfm5uXnsNqyx6R0/lsoDYJWsMcOYpPbcRXkR0Xqygdz+Vg
         Iv0Qqxeu9L+Ag==
Date:   Mon, 14 Aug 2023 21:28:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     syzbot <syzbot+2f508e913916096bf53a@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [syzbot] [mm?] upstream boot error: KASAN: slab-out-of-bounds
 Read in bootstrap
Message-ID: <20230814182806.GO2607694@kernel.org>
References: <0000000000008fe2100602e008a4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008fe2100602e008a4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Vlastimil)

On Mon, Aug 14, 2023 at 04:04:59AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3feecb1b8483 Merge tag 'char-misc-6.5-rc6' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=137dddaba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d84c6cf3c2bbdb4d
> dashboard link: https://syzkaller.appspot.com/bug?extid=2f508e913916096bf53a
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3feecb1b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/066a563f6f65/vmlinux-3feecb1b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eb9963107316/Image-3feecb1b.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2f508e913916096bf53a@syzkaller.appspotmail.com
> 
> Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> Linux version 6.5.0-rc5-syzkaller-00349-g3feecb1b8483 (syzkaller@syzkaller) (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
> random: crng init done
> Machine model: linux,dummy-virt
> efi: UEFI not found.
> NUMA: No NUMA configuration found
> NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
> NUMA: NODE_DATA [mem 0xbf9f6000-0xbf9f8fff]
> Zone ranges:
>   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
>   DMA32    empty
>   Normal   empty
>   Device   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> cma: Reserved 32 MiB at 0x00000000bb800000
> psci: probing for conduit method from DT.
> psci: PSCIv1.1 detected in firmware.
> psci: Using standard PSCI v0.2 function IDs
> psci: Trusted OS migration not required
> psci: SMC Calling Convention v1.0
> percpu: Embedded 22 pages/cpu s51016 r8192 d30904 u90112
> Detected PIPT I-cache on CPU0
> CPU features: detected: Address authentication (architected QARMA5 algorithm)
> CPU features: detected: HCRX_EL2 register
> CPU features: detected: Virtualization Host Extensions
> CPU features: detected: Hardware dirty bit management
> CPU features: detected: Memory Tagging Extension
> CPU features: detected: Asymmetric MTE Tag Check Fault
> CPU features: detected: Spectre-v4
> MTE: enabled in synchronous mode at EL1
> alternatives: applying boot alternatives
> kasan: KernelAddressSanitizer initialized (hw-tags, mode=sync, vmalloc=on, stacktrace=on)
> Kernel command line: root=/dev/vda console=ttyAMA0 
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> Fallback order for Node 0: 0 
> Built 1 zonelists, mobility grouping on.  Total pages: 516096
> Policy zone: DMA
> mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> stackdepot: allocating hash table via alloc_large_system_hash
> stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> software IO TLB: area num 2.
> software IO TLB: mapped [mem 0x00000000b6d00000-0x00000000bad00000] (64MB)
> Memory: 1904996K/2097152K available (25152K kernel code, 2446K rwdata, 10084K rodata, 1280K init, 1475K bss, 159388K reserved, 32768K cma-reserved)
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __kasan_slab_alloc+0x7c/0xcc mm/kasan/common.c:331
> Read at addr fcff000002c01008 by task swapper/0
> Pointer tag: [fc], memory tag: [fd]
> 
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rc5-syzkaller-00349-g3feecb1b8483 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:233
>  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:240
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x48/0x60 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0x108/0x618 mm/kasan/report.c:475
>  kasan_report+0x88/0xac mm/kasan/report.c:588
>  report_tag_fault arch/arm64/mm/fault.c:334 [inline]
>  do_tag_recovery arch/arm64/mm/fault.c:346 [inline]
>  __do_kernel_fault+0x180/0x1ec arch/arm64/mm/fault.c:393
>  do_bad_area arch/arm64/mm/fault.c:493 [inline]
>  do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:771
>  do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:847
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
>  el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
>  el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
>  __kasan_slab_alloc+0x7c/0xcc mm/kasan/common.c:331
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook mm/slab.h:762 [inline]
>  slab_alloc_node mm/slub.c:3470 [inline]
>  slab_alloc mm/slub.c:3478 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
>  kmem_cache_alloc+0x144/0x290 mm/slub.c:3494
>  kmem_cache_zalloc include/linux/slab.h:693 [inline]
>  bootstrap+0x2c/0x174 mm/slub.c:4988
>  kmem_cache_init+0x144/0x1c8 mm/slub.c:5051
>  mm_core_init+0x23c/0x2d0 mm/mm_init.c:2787
>  start_kernel+0x220/0x5fc init/main.c:928
>  __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523
> 
> Allocated by task 0:
>  kasan_save_stack+0x3c/0x64 mm/kasan/common.c:45
>  save_stack_info+0x38/0x118 mm/kasan/tags.c:104
>  kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:138
>  __kasan_slab_alloc+0x94/0xcc mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook mm/slab.h:762 [inline]
>  slab_alloc_node mm/slub.c:3470 [inline]
>  slab_alloc mm/slub.c:3478 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
>  kmem_cache_alloc+0x144/0x290 mm/slub.c:3494
>  kmem_cache_zalloc include/linux/slab.h:693 [inline]
>  bootstrap+0x2c/0x174 mm/slub.c:4988
>  kmem_cache_init+0x134/0x1c8 mm/slub.c:5050
>  mm_core_init+0x23c/0x2d0 mm/mm_init.c:2787
>  start_kernel+0x220/0x5fc init/main.c:928
>  __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523
> 
> The buggy address belongs to the object at ffff000002c01000
>  which belongs to the cache kmem_cache of size 208
> The buggy address is located 8 bytes inside of
>  208-byte region [ffff000002c01000, ffff000002c010d0)
> 
> The buggy address belongs to the physical page:
> page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42c01
> flags: 0x1ffc00000000200(slab|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
> page_type: 0xffffffff()
> raw: 01ffc00000000200 fcff000002c01000 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff000002c00e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff000002c00f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff000002c01000: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>                    ^
>  ffff000002c01100: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>  ffff000002c01200: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> ==================================================================
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> rcu: Preemptible hierarchical RCU implementation.
> rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
> 	Trampoline variant of Tasks RCU enabled.
> 	Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> Root IRQ handler: gic_handle_irq
> GIC: Using split EOI/Deactivate mode
> GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> arch_timer: cp15 timer(s) running at 62.50MHz (phys).
> clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
> sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
> kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> Console: colour dummy device 80x25
> Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
> pid_max: default: 32768 minimum: 301
> LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,smack,integrity
> landlock: Up and running.
> Yama: becoming mindful.
> TOMOYO Linux initialized
> Smack:  Initializing.
> Smack:  Netfilter enabled.
> Smack:  IPv6 Netfilter enabled.
> Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
> Detected PIPT I-cache on CPU1
> CPU1: Booted secondary processor 0x0000000001 [0x000f0510]
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

-- 
Sincerely yours,
Mike.
