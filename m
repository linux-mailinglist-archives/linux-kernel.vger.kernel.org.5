Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB378181C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbjHSHu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbjHSHuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:50:01 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14A3C04
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:49:59 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-26d269dc983so1878308a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692431399; x=1693036199;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wEEnOooSC1xV/c0WhJ6gFHyt/IJ9MYnUqyv1dlSAJE=;
        b=QW98K4QEoOnHRiSKu3CbPjvY2uI+DzbxMYjQXKQ+NVA399QEvOA/hi2rYI5zRAX/wF
         1qF/frzC8545EE6nRKA8D/+GHhxULQ/4cIcqbiVpDyyka8XrTzXisGhtGb9FjPKIiN8W
         buQrFf1920rcoa3lhY+NIHH0IgZRLCDrGOyEirppPkTR+UBGbHsxTp2ES94r35g/nC7+
         6qFluqc5BG7tcrDs6wrmxDBZCAION0H7R388Enr4lukZuGdAtr6su8GFsix7330wa/KK
         Wu85tEUkJFtLVo6wfM+xHvf4JIZWlZD1uUyQA7MWzT4BbG3N9onNXAXy0v5POu1uwi6C
         5J2Q==
X-Gm-Message-State: AOJu0YxzvPfaDu5MCGh8PYOpfFOSZsaUCBjqD5cxX/5Y766JUftA2Xp8
        Gas9qdULkivMSvAhUG9YnkBo8V5Td1VHcVKSEtxGBBiQnyNS
X-Google-Smtp-Source: AGHT+IGJOUenYHIQW/E2uAsNJvjqIQTlC1dXnFeWoj+ZEVcMlYfzTkRTFl7BGAVvas08d90T2yMtv/tLlDLCsov01yzaEalKOAEk
MIME-Version: 1.0
X-Received: by 2002:a17:903:1246:b0:1b9:e9f3:b4ca with SMTP id
 u6-20020a170903124600b001b9e9f3b4camr628602plh.12.1692431399214; Sat, 19 Aug
 2023 00:49:59 -0700 (PDT)
Date:   Sat, 19 Aug 2023 00:49:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b64f0060341e4bb@google.com>
Subject: [syzbot] [mm?] upstream boot error: KASAN: slab-out-of-bounds Read in deactivate_slab
From:   syzbot <syzbot+b51786cce3a38fa8a4f4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0e8860d2125f Merge tag 'net-6.5-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107fe223a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79190850e19be5d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b51786cce3a38fa8a4f4
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-0e8860d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ed7ac653a71/vmlinux-0e8860d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52eec8c1b61c/Image-0e8860d2.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b51786cce3a38fa8a4f4@syzkaller.appspotmail.com

Booting Linux on physical CPU 0x0000000000 [0x000f0510]
Linux version 6.5.0-rc6-syzkaller-00117-g0e8860d2125f (syzkaller@syzkaller) (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
random: crng init done
Machine model: linux,dummy-virt
efi: UEFI not found.
NUMA: No NUMA configuration found
NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
NUMA: NODE_DATA [mem 0xbf9f6000-0xbf9f8fff]
Zone ranges:
  DMA      [mem 0x0000000040000000-0x00000000bfffffff]
  DMA32    empty
  Normal   empty
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000040000000-0x00000000bfffffff]
Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
cma: Reserved 32 MiB at 0x00000000bb800000
psci: probing for conduit method from DT.
psci: PSCIv1.1 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: Trusted OS migration not required
psci: SMC Calling Convention v1.0
percpu: Embedded 22 pages/cpu s51016 r8192 d30904 u90112
Detected PIPT I-cache on CPU0
CPU features: detected: Address authentication (architected QARMA5 algorithm)
CPU features: detected: HCRX_EL2 register
CPU features: detected: Virtualization Host Extensions
CPU features: detected: Hardware dirty bit management
CPU features: detected: Memory Tagging Extension
CPU features: detected: Asymmetric MTE Tag Check Fault
CPU features: detected: Spectre-v4
MTE: enabled in synchronous mode at EL1
alternatives: applying boot alternatives
kasan: KernelAddressSanitizer initialized (hw-tags, mode=sync, vmalloc=on, stacktrace=on)
Kernel command line: root=/dev/vda console=ttyAMA0 
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 516096
Policy zone: DMA
mem auto-init: stack:all(zero), heap alloc:on, heap free:off
stackdepot: allocating hash table via alloc_large_system_hash
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000b6d00000-0x00000000bad00000] (64MB)
Memory: 1904996K/2097152K available (25152K kernel code, 2446K rwdata, 10084K rodata, 1280K init, 1475K bss, 159388K reserved, 32768K cma-reserved)
==================================================================
BUG: KASAN: slab-out-of-bounds in __ll_sc__cmpxchg_case_acq_32 arch/arm64/include/asm/atomic_ll_sc.h:284 [inline]
BUG: KASAN: slab-out-of-bounds in __cmpxchg_case_acq_32 arch/arm64/include/asm/cmpxchg.h:120 [inline]
BUG: KASAN: slab-out-of-bounds in __cmpxchg_acq arch/arm64/include/asm/cmpxchg.h:169 [inline]
BUG: KASAN: slab-out-of-bounds in raw_atomic_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:2044 [inline]
BUG: KASAN: slab-out-of-bounds in raw_atomic_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:2158 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1296 [inline]
BUG: KASAN: slab-out-of-bounds in queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
BUG: KASAN: slab-out-of-bounds in do_raw_spin_lock include/linux/spinlock.h:187 [inline]
BUG: KASAN: slab-out-of-bounds in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
BUG: KASAN: slab-out-of-bounds in _raw_spin_lock_irqsave+0x5c/0x8c kernel/locking/spinlock.c:162
Read at addr faff000002c00000 by task swapper/0
Pointer tag: [fa], memory tag: [fc]

CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rc6-syzkaller-00117-g0e8860d2125f #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:233
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x48/0x60 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x108/0x618 mm/kasan/report.c:475
 kasan_report+0x88/0xac mm/kasan/report.c:588
 report_tag_fault arch/arm64/mm/fault.c:334 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:346 [inline]
 __do_kernel_fault+0x180/0x1ec arch/arm64/mm/fault.c:393
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:771
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:847
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 __ll_sc__cmpxchg_case_acq_32 arch/arm64/include/asm/atomic_ll_sc.h:284 [inline]
 __cmpxchg_case_acq_32 arch/arm64/include/asm/cmpxchg.h:120 [inline]
 __cmpxchg_acq arch/arm64/include/asm/cmpxchg.h:169 [inline]
 raw_atomic_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:2044 [inline]
 raw_atomic_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:2158 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1296 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock include/linux/spinlock.h:187 [inline]
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x5c/0x8c kernel/locking/spinlock.c:162
 deactivate_slab+0x1f8/0x510 mm/slub.c:2562
 __flush_cpu_slab mm/slub.c:2770 [inline]
 bootstrap+0x8c/0x174 mm/slub.c:4998
 kmem_cache_init+0x144/0x1c8 mm/slub.c:5051
 mm_core_init+0x23c/0x2d0 mm/mm_init.c:2787
 start_kernel+0x220/0x5fc init/main.c:928
 __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523

Allocated by task 0:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:45
 save_stack_info+0x38/0x118 mm/kasan/tags.c:104
 kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:138
 __kasan_slab_alloc+0x94/0xcc mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 early_kmem_cache_node_alloc mm/slub.c:4268 [inline]
 init_kmem_cache_nodes mm/slub.c:4310 [inline]
 kmem_cache_open mm/slub.c:4549 [inline]
 __kmem_cache_create+0x388/0x688 mm/slub.c:5105
 create_boot_cache+0x70/0xb8 mm/slab_common.c:652
 kmem_cache_init+0xec/0x1c8 mm/slub.c:5037
 mm_core_init+0x23c/0x2d0 mm/mm_init.c:2787
 start_kernel+0x220/0x5fc init/main.c:928
 __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523

The buggy address belongs to the object at ffff000002c00000
 which belongs to the cache kmem_cache_node of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff000002c00000, ffff000002c00040)

The buggy address belongs to the physical page:
page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42c00
flags: 0x1ffc00000000200(slab|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
page_type: 0xffffffff()
raw: 01ffc00000000200 ffff800082396ae8 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000002bffe00: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
 ffff000002bfff00: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
>ffff000002c00000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff000002c00100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff000002c00200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
Root IRQ handler: gic_handle_irq
GIC: Using split EOI/Deactivate mode
GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
rcu: srcu_init: Setting srcu_struct sizes based on contention.
arch_timer: cp15 timer(s) running at 62.50MHz (phys).
clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
Console: colour dummy device 80x25
Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,smack,integrity
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
Smack:  Initializing.
Smack:  Netfilter enabled.
Smack:  IPv6 Netfilter enabled.
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Detected PIPT I-cache on CPU1
CPU1: Booted secondary processor 0x0000000001 [0x000f0510]


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
