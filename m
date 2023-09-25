Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1737AD6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjIYLX0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIYLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:23:24 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294CC6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:23:13 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae377d74b1so6880302b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640993; x=1696245793;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm3/JHtkkZfmRhjXe1MX1nI/BO8OmW8iisRhYQ/Xx2g=;
        b=kI3KWNYbG+A2vKac5nqJHhfCRRcCaRdIYM18irnUAeu1YJ/8+xO78nRuS+OSv8QPxm
         CgqvwfhFkkKccJPy5jFhlQS0bZVX81F7C5LvHB3DlSULu1GJe6D6MIOX9ap2+YLxoaWt
         ljXruGU/NunYkhaXOwtjH/MNSCefwWiLQFOvJJ7Pg+3yTXw6uMOBNQXzz6Tw+VNP7C7M
         q+qL4OwM+bGjv+yV8dLtnjkwwyK3QjzRYuaXTlGZIebUpGFJeaXZw4HLLddyM1DS4/M2
         vqXN2lfmS9/i8V92O0ZJUIeXRQ9HONop2xA38u2VraUDtI4cvEe84t519ZI+V19C7lAl
         6IGg==
X-Gm-Message-State: AOJu0Yy2WaBwt1hV+zQnIMYNNv6VeEj2yxpVzpkEUQ7jZHrkYa72hbap
        oZms2u6erUoQxh2e9CBj9xG3EC3esRjDa/r5u3YS8mt4t1vT
X-Google-Smtp-Source: AGHT+IEy96xoYwA1CTD4BHjTkCs4LsCHNn0bfAv1jqz8bSInmzSQ+b7bO5A7/p/whvUBO3blNUa5CjCDq3PZkORJcSvJOVeV8lvd
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3087:b0:3ad:eae0:3317 with SMTP id
 bl7-20020a056808308700b003adeae03317mr3792604oib.5.1695640992760; Mon, 25 Sep
 2023 04:23:12 -0700 (PDT)
Date:   Mon, 25 Sep 2023 04:23:12 -0700
In-Reply-To: <20230925110258.1024-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a480406062d2f8f@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-....
 } 3076 jiffies s: 5117 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
Node 0 active_anon:43180kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10776kB pagetables:2324kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:43144kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12452kB local_pcp:8152kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:7136kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10795 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98313
 mapped:7045 shmem:1272 pagetables:581
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:6940 free_cma:0
Node 0 active_anon:43180kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10776kB pagetables:2324kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:43144kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12452kB local_pcp:4300kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:8160kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10795 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98313
 mapped:7045 shmem:1272 pagetables:581
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:6940 free_cma:0
Node 0 active_anon:43180kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10776kB pagetables:2324kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:43144kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12452kB local_pcp:8152kB free_cma:0kB
NMI backtrace for cpu 0
CPU: 0 PID: 6059 Comm: syz-executor.4 Not tainted 6.6.0-rc3-syzkaller-g6465e260f487 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:io_serial_in+0x87/0xa0 drivers/tty/serial/8250/8250_port.c:418
Code: d1 eb fc 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 16 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 e8 bc 86 41 fd eb a6 e8 15 87 41 fd eb e3
RSP: 0000:ffffc900000072d0 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff849bf500 RDI: ffffffff92560d40
RBP: ffffffff92560d00 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 205d304320202020 R12: 0000000000000000
R13: 0000000000000020 R14: fffffbfff24ac1fa R15: dffffc0000000000
FS:  0000555556b1a480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f18fc2d7693 CR3: 0000000028e0a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:117 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:139 [inline]
 wait_for_lsr+0xd7/0x180 drivers/tty/serial/8250/8250_port.c:2086
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3371 [inline]
 serial8250_console_write+0xce5/0x1060 drivers/tty/serial/8250/8250_port.c:3449
 console_emit_next_record kernel/printk/printk.c:2910 [inline]
 console_flush_all+0x4eb/0xfb0 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 show_free_areas+0x1260/0x21b0 mm/show_mem.c:308
 __show_mem+0x34/0x150 mm/show_mem.c:409
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xea/0x140 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcc8/0x17c0 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x382/0x4c0 drivers/input/input.c:132
 input_pass_values.part.0+0x52f/0x7a0 drivers/input/input.c:161
 input_pass_values drivers/input/input.c:148 [inline]
 input_event_dispose+0x5ee/0x770 drivers/input/input.c:378
 input_handle_event+0x11c/0xd80 drivers/input/input.c:406
 input_repeat_key+0x251/0x340 drivers/input/input.c:2263
 call_timer_fn+0x19e/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:percpu_counter_add_batch+0xe6/0x1f0 lib/percpu_counter.c:103
Code: e8 bf de 33 fd 48 85 db 75 42 e8 25 e3 33 fd 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 a3 de 33 fd 48 85 db 0f 85 bd 00 00 00 <48> 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 f7 e2 33 fd e8 f2 e2
RSP: 0000:ffffc9000a177af8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888014f38000 RSI: ffffffff8453e402 RDI: 0000000000000007
RBP: ffff888017f63d90 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000f
R13: 0000000000000001 R14: 0000607f4641c7f8 R15: 0000000000000020
 percpu_counter_add include/linux/percpu_counter.h:69 [inline]
 add_mm_counter include/linux/mm.h:2552 [inline]
 set_pte_range+0x3b3/0x9d0 mm/memory.c:4355
 filemap_map_order0_folio mm/filemap.c:3552 [inline]
 filemap_map_pages+0x455/0x1310 mm/filemap.c:3598
 do_fault_around mm/memory.c:4525 [inline]
 do_read_fault mm/memory.c:4558 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault+0x291c/0x3e10 mm/memory.c:5119
 handle_mm_fault+0x478/0xa00 mm/memory.c:5284
 do_user_addr_fault+0x30b/0x1000 arch/x86/mm/fault.c:1364
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1561
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f18fc26f46d
Code: ff 31 c0 c3 44 31 c0 44 29 c0 c3 66 90 48 83 fa 01 7e 5e c4 41 01 ef ff 89 f8 09 f0 c1 e0 14 3d 00 00 00 f8 0f 87 c8 03 00 00 <c5> fe 6f 07 c5 fd 74 0e c5 85 74 d0 c5 ed df c9 c5 fd d7 c9 48 83
RSP: 002b:00007ffde748fd68 EFLAGS: 00010207
RAX: 000000006f300000 RBX: 00007f18fc200000 RCX: 00007f18fbe00000
RDX: 0000000000000007 RSI: 00007f18fc2c82f1 RDI: 00007f18fc2d7693
RBP: 0000000000000000 R08: 00007f18fc200000 R09: 0000000000000001
R10: 00007ffde74a2080 R11: 0000000001531dae R12: 00007f18fbe00058
R13: 000000000000104a R14: 00007f18fbe00000 R15: 00007f18fbe00060
 </TASK>
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:7136kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10770 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98402
 mapped:7045 shmem:1272 pagetables:556
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:6909 free_cma:0
Node 0 active_anon:43080kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10776kB pagetables:2224kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:43044kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12328kB local_pcp:4176kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:8160kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10770 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98402
 mapped:7045 shmem:1272 pagetables:556
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:6907 free_cma:0
Node 0 active_anon:42980kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10776kB pagetables:2224kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42944kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12588kB local_pcp:8152kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:7136kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10745 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98392
 mapped:7045 shmem:1272 pagetables:556
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:6974 free_cma:0
Node 0 active_anon:42980kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10776kB pagetables:2224kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42944kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12588kB local_pcp:4436kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:8160kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10745 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98392
 mapped:7045 shmem:1272 pagetables:556
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:6974 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10748kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42844kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12812kB local_pcp:8152kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:7136kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10720 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98392
 mapped:7045 shmem:1272 pagetables:531
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:7030 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10748kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42844kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:12812kB local_pcp:4660kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:8160kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10720 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98420
 mapped:7045 shmem:1272 pagetables:531
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:7022 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10748kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42844kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:13004kB local_pcp:8152kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:7136kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10720 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98356
 mapped:7045 shmem:1272 pagetables:531
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:7078 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10748kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42844kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:13004kB local_pcp:4852kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:8160kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10720 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98356
 mapped:7045 shmem:1272 pagetables:531
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:7078 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10720kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42844kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:13704kB local_pcp:8152kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:7136kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10720 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98172
 mapped:7045 shmem:1272 pagetables:531
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:7253 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10720kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612
Node 0 DMA32 free:1783712kB boost:0kB min:35396kB low:44244kB high:53092kB reserved_highatomic:0KB active_anon:42844kB inactive_anon:1964kB active_file:0kB inactive_file:206836kB unevictable:1536kB writepending:60kB present:3129332kB managed:2678260kB mlocked:0kB bounce:0kB free_pcp:13704kB local_pcp:5552kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 Normal free:4kB boost:0kB min:8kB low:8kB high:8kB reserved_highatomic:0KB active_anon:36kB inactive_anon:4kB active_file:0kB inactive_file:816kB unevictable:0kB writepending:0kB present:1048576kB managed:872kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3927548kB boost:0kB min:54496kB low:68120kB high:81744kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:4kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:15296kB local_pcp:8160kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 1384*4kB (UME) 946*8kB (UME) 215*16kB (UME) 94*32kB (UME) 43*64kB (UME) 19*128kB (UME) 3*256kB (UM) 2*512kB (ME) 4*1024kB (UME) 2*2048kB (ME) 427*4096kB (M) = 1783712kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 193*4kB (UE) 55*8kB (UE) 38*16kB (UE) 77*32kB (UE) 27*64kB (UME) 5*128kB (UE) 2*256kB (UM) 3*512kB (UME) 1*1024kB (U) 1*2048kB (U) 956*4096kB (M) = 3927548kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53203 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
394100 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10720 inactive_anon:492 isolated_anon:0
 active_file:0 inactive_file:51931 isolated_file:0
 unevictable:768 dirty:16 writeback:0
 slab_reclaimable:9708 slab_unreclaimable:98172
 mapped:7045 shmem:1272 pagetables:531
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1431656 free_pcp:7253 free_cma:0
Node 0 active_anon:42880kB inactive_anon:1968kB active_file:0kB inactive_file:207652kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:28180kB dirty:60kB writeback:0kB shmem:3552kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:10692kB pagetables:2124kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:4kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2611 2612 2612 2612


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1098761e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
