Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0817A5415
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIRU1y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIRU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:27:48 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE448112
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:27:33 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ab7fb1173cso7942372b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068853; x=1695673653;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M8DgNVh9V3BVMm81EIMvElW6V2BJjhI+rjYaLP1roA=;
        b=rI1ujFgmKmBAlTe8AflbvQ09nfysIT7GXq3LiyJ3gpidyX8awF/Qn253TseoMRKFmc
         b4mih00PyixFOd9ZsD5NrltmJEbZq23fTmuacbxL4bo/xsiibMYd+i+xBCFjcfycHz76
         CF/og6jMd3kHhQzINBfdR+bTdv2vT2SskDcoO69R0MfQogW/Ia/sON5Iq9pB3zbsVBeW
         woKWLj1YsYmecEpLI+UJAxqBVG95WsRujrOI0xGW4vCmFly+cHYu1qbIdopi9rsh6raD
         tgvzJEH0JXwJoZwa0FcLP5wPLoY7YGtSeOvrlNDCx8y2eJIlbr1xpwxWI9f+AhsZi06t
         EpuQ==
X-Gm-Message-State: AOJu0YzUkccvDRgzvxFPVwqIr4bcMKnr+l5KiRVoyjyxB17b0bzTYB9F
        /X+FSaRZc5FuC3mjZF3acs+mZtSR7jKeDmJq1qJ5wZELo3lv
X-Google-Smtp-Source: AGHT+IGSMjGFQwZFfMkJR4TmsMry6W0QcG/OeIn5NWLF70DB2iGgBaRbRgwjOkyUopmPa5rD7J3dQvAzcUvPRI8clpID6iAbx8ml
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1521:b0:3a7:5314:e576 with SMTP id
 u33-20020a056808152100b003a75314e576mr4533246oiw.4.1695068853042; Mon, 18 Sep
 2023 13:27:33 -0700 (PDT)
Date:   Mon, 18 Sep 2023 13:27:32 -0700
In-Reply-To: <xjg3ozpednanoykpepnnnhvxlqwiwice3qrgrokmrhdutk426q@qxyryc3tygbl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db07740605a7f865@google.com>
Subject: Re: [syzbot] [input?] INFO: task hung in __input_unregister_device (5)
From:   syzbot <syzbot+78e2288f58b881ed3c45@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ricardo@marliere.net, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in sys_openat

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-....
 } 2685 jiffies s: 937 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 0 to CPUs 1:
lowmem_reserve[]: 0 2814 6738 6738
NMI backtrace for cpu 1
CPU: 1 PID: 2385 Comm: udevd Not tainted 6.6.0-rc2-next-20230918-syzkaller-g7fc7222d9680 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:424
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 18 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 e8 25 ac 14 ff eb a4 e8 7e ac 14 ff eb e1 66
RSP: 0018:ffffc900001983a8 EFLAGS: 00000002
RAX: 0000000000000020 RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82858b85 RDI: ffffffff8c15b0a0
RBP: ffffffff8c15b060 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 205d314320202020 R12: 0000000000000000
R13: 0000000000000020 R14: ffffffff82858b20 R15: 0000000000000000
FS:  00007f32d1a12c80(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557178da8 CR3: 000000010d711000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:122 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
 serial8250_console_write+0xd29/0x1060 drivers/tty/serial/8250/8250_port.c:3449
 console_emit_next_record kernel/printk/printk.c:2910 [inline]
 console_flush_all+0x4eb/0xfb0 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 show_free_areas+0x1257/0x2140 mm/show_mem.c:350
 __show_mem+0x34/0x140 mm/show_mem.c:406
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
 call_timer_fn+0x193/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20a/0x94b kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:write_comp_data+0x3c/0x90 kernel/kcov.c:236
Code: 01 00 00 49 89 f8 65 48 8b 14 25 00 ab 03 00 a9 00 01 ff 00 74 0e 85 f6 74 59 8b 82 34 15 00 00 85 c0 74 4f 8b 82 10 15 00 00 <83> f8 03 75 44 48 8b 82 18 15 00 00 8b 92 14 15 00 00 48 8b 38 48
RSP: 0018:ffffc900005df948 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff88811a524eb0 RCX: ffffffff81c38634
RDX: ffff88811555ba00 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff8881063cce80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881063cceb0 R14: ffff8881016578d8 R15: ffffc900005dfc40
 kernfs_dop_revalidate+0x104/0x5a0 fs/kernfs/dir.c:1141
 d_revalidate fs/namei.c:861 [inline]
 d_revalidate fs/namei.c:858 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1654
 walk_component+0x5b/0x5a0 fs/namei.c:1997
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2328
 link_path_walk fs/namei.c:2253 [inline]
 path_openat+0x231/0x29c0 fs/namei.c:3773
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f32d1b3d9a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffddeb937a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f32d1b3d9a4
RDX: 0000000000080000 RSI: 00007ffddeb938d8 RDI: 00000000ffffff9c
RBP: 00007ffddeb938d8 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000561f3ccb1b42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249728kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5424kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 226*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249728kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51762 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:66095
 mapped:6906 shmem:167 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536646 free_pcp:2271 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:668kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249728kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5396kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 226*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249728kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51762 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:66123
 mapped:6906 shmem:167 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2307 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:668kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5520kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51762 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:66123
 mapped:6906 shmem:167 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2296 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:680kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5496kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51765 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:66134
 mapped:6906 shmem:170 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2282 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:680kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6288kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51765 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:65943
 mapped:6906 shmem:170 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2484 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:680kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6248kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51765 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:65943
 mapped:6906 shmem:170 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2470 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:680kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6168kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51768 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:65963
 mapped:6906 shmem:173 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2459 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:692kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6148kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51768 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:65989
 mapped:6906 shmem:173 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2436 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:692kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6032kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51768 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:65989
 mapped:6906 shmem:173 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2424 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:692kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6008kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51768 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:97 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:19 writeback:0
 slab_reclaimable:4677 slab_unreclaimable:66018
 mapped:6906 shmem:173 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536586 free_pcp:2401 free_cma:0
Node 0 active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:76kB writeback:0kB shmem:692kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249488kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:388kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:76kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5912kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 766*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249488kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51771 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66024
 mapped:6906 shmem:176 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536523 free_pcp:2457 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:704kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249236kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6140kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249236kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51771 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66024
 mapped:6906 shmem:176 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536523 free_pcp:2443 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:704kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3249236kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6060kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 211*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3249236kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51771 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66056
 mapped:6906 shmem:176 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2482 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:704kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6240kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51771 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66056
 mapped:6906 shmem:176 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2467 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:704kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6160kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51775 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66081
 mapped:6906 shmem:180 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2460 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:720kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6152kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51775 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66081
 mapped:6906 shmem:180 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2438 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:720kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6040kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51775 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66108
 mapped:6906 shmem:180 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2425 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:720kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6012kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51775 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66136
 mapped:6906 shmem:180 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2403 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:720kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5900kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51779 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66142
 mapped:6906 shmem:184 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2392 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:736kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5880kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51779 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:66142
 mapped:6906 shmem:184 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2377 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:736kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:5812kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51779 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:65925
 mapped:6906 shmem:184 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2612 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:736kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6744kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51779 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:65929
 mapped:6906 shmem:186 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2606 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:744kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6736kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51781 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:65929
 mapped:6906 shmem:186 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2591 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:744kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6656kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51781 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:65957
 mapped:6906 shmem:186 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536463 free_pcp:2572 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:744kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248996kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6600kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 196*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248996kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51781 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:111 inactive_anon:9444 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:65957
 mapped:6906 shmem:186 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536403 free_pcp:2617 free_cma:0
Node 0 active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:744kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248756kB boost:0kB min:6108kB low:10124kB high:14140kB reserved_highatomic:0KB active_anon:444kB inactive_anon:37776kB active_file:33248kB inactive_file:173132kB unevictable:0kB writepending:28kB present:5242880kB managed:4018384kB mlocked:0kB bounce:0kB free_pcp:6760kB local_pcp:2016kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (M) 0*8kB 1*16kB (M) 2*32kB (M) 2*64kB (M) 2*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 1*2048kB (M) 702*4096kB (M) = 2881496kB
Node 0 Normal: 703*4kB (UME) 973*8kB (UM) 181*16kB (UM) 18*32kB (UME) 10*64kB (UM) 2*128kB (UM) 0*256kB 2*512kB (UE) 1*1024kB (M) 2*2048kB (UM) 788*4096kB (M) = 3248756kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
51785 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367319 pages reserved
Mem-Info:
active_anon:125 inactive_anon:9445 isolated_anon:0
 active_file:8312 inactive_file:43283 isolated_file:0
 unevictable:0 dirty:0 writeback:7
 slab_reclaimable:4677 slab_unreclaimable:65981
 mapped:6906 shmem:190 pagetables:484
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1536403 free_pcp:2597 free_cma:0
Node 0 active_anon:500kB inactive_anon:37780kB active_file:33248kB inactive_file:173132kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:27624kB dirty:0kB writeback:28kB shmem:760kB writeback_tmp:0kB kernel_stack:4572kB pagetables:1936kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2814 6738 6738
Node 0 DMA32 free:2881496kB boost:0kB min:4380kB low:7260kB high:10140kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2885184kB mlocked:0kB bounce:0kB free_pcp:3688kB local_pcp:2728kB free_cma:0kB
lowmem_reserve[]: 0 0 3924 3924
Node 0 Normal free:3248756kB boost:0kB min:6108kB low:10

Tested on:

commit:         7fc7222d Add linux-next specific files for 20230918
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20230918
console output: https://syzkaller.appspot.com/x/log.txt?x=15d2c528680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf7477d42462473a
dashboard link: https://syzkaller.appspot.com/bug?extid=78e2288f58b881ed3c45
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
