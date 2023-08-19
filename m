Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43924781FFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHTUnT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Aug 2023 16:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjHTUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:43:13 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89B110CFB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:28:41 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1bf60f85d78so9167755ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692484121; x=1693088921;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqAkRVbvrd9Z6IHY/qBNLvP63lSagyjpNqgvpbAm0j4=;
        b=UjPULq9Y3Fb4v84QLbVZFbRSBUI9V8LVw0e6+iiypVcJIrZEwbOnqGfvyrJ3OWcXPk
         dP6POoxwTL90FPGMtGY74cVMAM1a8AItR9JusQwJDSgOF58euQ3dRCF4fYzX+4U+fgio
         CHgLvvlcAcmKY1JhUpnfcgJ/kvnxzmnynVSNIVbsikzGRsVdp/j4OYC5zYfby9LrUcbS
         7twGB/4AVp8SvAQVceRvQ6ZuJwgiQycbqqgOLoTEl9eQ8b4KHHFA/vw1IYxt1Y+fHTWZ
         ITHcacuQCot104vf9Vaw1t8kr7NMrkMYGA0uLodh0HZTvjoN2af0ADSm5fVJ7aq4+QtB
         GgTw==
X-Gm-Message-State: AOJu0YyHbAtTiteKllaQVMMJPaFDjkZUx3VJaEiHiMqBK91SGwXOsy2L
        m99isdAyjnk1VOIieIu8lyTmLxowuESV1t/Ri+ti+GEX52T+
X-Google-Smtp-Source: AGHT+IF2C5FvnEJmAwmdoR4xvFo6vjft7GGG1CuSiNXCRwALq7JMNUEC3GOy8bVuXyVlCs8oXs006a9hxNVeblODMrgIn/OkY8/j
MIME-Version: 1.0
X-Received: by 2002:a17:902:d504:b0:1bb:9e6e:a9f1 with SMTP id
 b4-20020a170902d50400b001bb9e6ea9f1mr1138030plg.13.1692484121259; Sat, 19 Aug
 2023 15:28:41 -0700 (PDT)
Date:   Sat, 19 Aug 2023 15:28:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5fd3806034e2ad1@google.com>
Subject: [syzbot] [input?] [usb?] [serial?] INFO: rcu detected stall in console_callback
From:   syzbot <syzbot+32af18ae7b894a681f2d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbb9e06d2c64 Merge 6.5-rc6 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1046356fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12ca74309a170dc3
dashboard link: https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172d7763a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e7c603a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8b226772fa1/disk-bbb9e06d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fc8e36b8616/vmlinux-bbb9e06d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b18a2dffe27d/bzImage-bbb9e06d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+32af18ae7b894a681f2d@syzkaller.appspotmail.com

Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=f41c/1/0x4000000000000000 softirq=3538/3539 fqs=1
rcu: 	(detected by 1, t=10511 jiffies, g=2885, q=45 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
lowmem_reserve[]: 0
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.5.0-rc6-syzkaller-00119-gbbb9e06d2c64 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events console_callback
RIP: 0010:arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
RIP: 0010:raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
RIP: 0010:raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
RIP: 0010:atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
RIP: 0010:desc_read+0x2c9/0x370 kernel/printk/printk_ringbuffer.c:534
Code: e4 74 2d e8 19 b9 1b 00 be 08 00 00 00 4c 89 e7 e8 ec 77 66 00 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <75> 78 4d 89 3c 24 e8 ec b8 1b 00 8b 44 24 08 48 83 c4 18 5b 5d 41
RSP: 0018:ffffc90000007090 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 00000001000027c2 RCX: ffffffff813092b4
RDX: 1ffff92000000e48 RSI: 0000000000000008 RDI: ffffc90000007240
RBP: 00000001000027c2 R08: 0000000000000001 R09: fffff52000000e48
R10: ffffc90000007247 R11: 00000000001445a0 R12: ffffc90000007240
R13: 0000000000000000 R14: ffffffff87de1170 R15: 80000001000027c2
FS:  0000000000000000(0000) GS:ffff8881f6600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9fd260e0f0 CR3: 0000000114035000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 desc_read_finalized_seq+0x8a/0x1c0 kernel/printk/printk_ringbuffer.c:1763
 prb_read kernel/printk/printk_ringbuffer.c:1831 [inline]
 _prb_read_valid+0x49e/0x710 kernel/printk/printk_ringbuffer.c:1891
 prb_read_valid+0x79/0xa0 kernel/printk/printk_ringbuffer.c:1940
 printk_get_next_message+0x154/0x7c0 kernel/printk/printk.c:2783
 console_emit_next_record kernel/printk/printk.c:2844 [inline]
 console_flush_all+0x39e/0xf50 kernel/printk/printk.c:2933
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1c5/0x640 kernel/printk/printk.c:2307
 vprintk+0x89/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 __show_free_areas+0x1239/0x2140 mm/show_mem.c:352
 __show_mem+0x34/0x140 mm/show_mem.c:409
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xea/0x140 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcc8/0x17c0 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x382/0x4c0 drivers/input/input.c:132
 input_pass_values.part.0+0x536/0x7a0 drivers/input/input.c:161
 input_pass_values drivers/input/input.c:148 [inline]
 input_event_dispose+0x5ee/0x770 drivers/input/input.c:378
 input_handle_event+0x11c/0xd80 drivers/input/input.c:406
 input_repeat_key+0x251/0x340 drivers/input/input.c:2263
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:console_flush_all+0x9b6/0xf50 kernel/printk/printk.c:2939
Code: 30 c7 22 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 8e 21 1c 00 48 85 db 0f 85 94 03 00 00 e8 f0 25 1c 00 fb 48 8b 44 24 08 <48> 8b 14 24 0f b6 00 83 e2 07 38 d0 7f 08 84 c0 0f 85 9d 04 00 00
RSP: 0018:ffffc9000009fa98 EFLAGS: 00000293
RAX: fffff52000013f7e RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888101e58000 RSI: ffffffff813025d0 RDI: 0000000000000007
RBP: ffffffff88347b00 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 205d314320202020 R12: 0000000000000001
R13: ffffffff88347b58 R14: dffffc0000000000 R15: 0000000000000001
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
 console_callback+0x27d/0x4c0 drivers/tty/vt/vt.c:2964
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.757 msecs
rcu: rcu_preempt kthread starved for 10505 jiffies! g2885 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
 2812 6735
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
 6735
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
  running task     stack:29136 pid:15    ppid:2      flags:0x00004000
lowmem_reserve[]: 0
Call Trace:
 <TASK>
 0 3923
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xc79/0x30a0 kernel/sched/core.c:6710
 3923
Node 0 
Normal free:3438448kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6984kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8208kB local_pcp:4084kB free_cma:0kB
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
lowmem_reserve[]: 0
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
 0 0
 0
Node 0 DMA: 
0*4kB 
0*8kB 
 rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1609
0*16kB 
0*32kB 
0*64kB 
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1808
0*128kB 
0*256kB 
0*512kB 
1*1024kB 
 kthread+0x33a/0x430 kernel/kthread.c:389
(U) 1*2048kB 
(M) 3*4096kB 
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
(M) = 15360kB
Node 0 DMA32: 
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
3*4kB 
 </TASK>
(M) 1*8kB 
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 6.5.0-rc6-syzkaller-00119-gbbb9e06d2c64 #0
(M) 2*16kB 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
(M) 3*32kB 
Workqueue: usb_hub_wq hub_event
(M) 3*64kB 

RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
(M) 3*128kB 
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 c6 41 ec fa 48 89 df e8 9e c0 ec fa f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 15 47 e1 fa 65 8b 05 26 57 c2 79 85 c0 74 12 5b
(M) 2*256kB 
RSP: 0000:ffffc90000188c90 EFLAGS: 00000246
(M) 2*512kB 

RAX: 0000000000000002 RBX: ffff8881096b4218 RCX: 1ffffffff16f69c2
(M) 2*1024kB 
RDX: 0000000000000000 RSI: ffffffff8687a2e0 RDI: ffffffff86a59c00
(M) 2*2048kB 
RBP: 0000000000000246 R08: 0000000000000001 R09: fffffbfff16eef4a
(M) 701*4096kB 
R10: ffffffff8b777a57 R11: 00000000000441b8 R12: ffff8881096b4110
(M) = 2879700kB
R13: 1ffff92000031196 R14: ffffffff845832d0 R15: 0000000000000001
Node 0 Normal: 
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
486*4kB 
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
(UME) 767*8kB 
CR2: 00007f9fd25dfce8 CR3: 0000000109343000 CR4: 00000000003506e0
(UE) 318*16kB 
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
(UME) 4*32kB 
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
(UM) 2*64kB 
Call Trace:
 <IRQ>
(M) 4*128kB 
(UME) 1*256kB 
(U) 6*512kB 
(ME) 3*1024kB 
(ME) 1*2048kB 
(E) 834*4096kB 
(M) = 3438448kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1746 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62980
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583377 free_pcp:2939 free_cma:0
Node 0 active_anon:312kB inactive_anon:6984kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3556kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0
 2812 6735
 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0
 0 3923
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 3923
Node 0 
Normal free:3438448kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6984kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8208kB local_pcp:4084kB free_cma:0kB
lowmem_reserve[]: 0
 0 0
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 0
Node 0 DMA: 
0*4kB 
0*8kB 
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
0*16kB 
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
0*32kB 
0*64kB 
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
0*128kB 
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1109
0*256kB 
 </IRQ>
0*512kB 
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
1*1024kB 
RIP: 0010:console_flush_all+0x9b6/0xf50 kernel/printk/printk.c:2939
(U) 1*2048kB 
Code: 30 c7 22 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 8e 21 1c 00 48 85 db 0f 85 94 03 00 00 e8 f0 25 1c 00 fb 48 8b 44 24 08 <48> 8b 14 24 0f b6 00 83 e2 07 38 d0 7f 08 84 c0 0f 85 9d 04 00 00
(M) 3*4096kB 
RSP: 0000:ffffc900001b7548 EFLAGS: 00000293
(M) = 15360kB

RAX: fffff52000036ed4 RBX: 0000000000000000 RCX: 0000000000000000
Node 0 DMA32: 
RDX: ffff888104a51d00 RSI: ffffffff813025d0 RDI: 0000000000000007
3*4kB 
RBP: ffffffff88347b00 R08: 0000000000000007 R09: 0000000000000000
(M) 1*8kB 
R10: 0000000000000000 R11: 205d314320202020 R12: 0000000000000001
(M) 2*16kB 
R13: ffffffff88347b58 R14: dffffc0000000000 R15: 0000000000000001
(M) 3*32kB 
(M) 3*64kB 
(M) 3*128kB 
(M) 2*256kB 
(M) 2*512kB 
(M) 2*1024kB 
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
(M) 2*2048kB 
(M) 701*4096kB 
 vprintk_emit+0x1c5/0x640 kernel/printk/printk.c:2307
(M) = 2879700kB
 dev_vprintk_emit drivers/base/core.c:4840 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4851
Node 0 Normal: 
486*4kB 
(UME) 767*8kB 
(UE) 318*16kB 
 __dev_printk+0xf5/0x270 drivers/base/core.c:4863
(UME) 4*32kB 
 _dev_info+0xe5/0x120 drivers/base/core.c:4909
(UM) 2*64kB 
(M) 4*128kB 
(UME) 1*256kB 
 hub_port_init+0xcd3/0x3920 drivers/usb/core/hub.c:4870
(U) 6*512kB 
 hub_port_connect drivers/usb/core/hub.c:5369 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2c20/0x4f30 drivers/usb/core/hub.c:5822
(ME) 3*1024kB 
(ME) 1*2048kB 
(E) 834*4096kB 
(M) = 3438448kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
 kthread+0x33a/0x430 kernel/kthread.c:389
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 2812
 6735 6735
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Node 0 
 </TASK>
DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:3484kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4124kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0
 active_file:3416 inactive_file:10225 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:8953 slab_unreclaimable:62916
 mapped:2091 shmem:155 pagetables:347
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1583321 free_pcp:3105 free_cma:0
Node 0 active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:8364kB dirty:0kB writeback:0kB shmem:620kB writeback_tmp:0kB kernel_stack:3584kB pagetables:1388kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:20kB low:32kB high:44kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2812 6735 6735
Node 0 DMA32 free:2879700kB boost:0kB min:4380kB low:7256kB high:10132kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129332kB managed:2883248kB mlocked:0kB bounce:0kB free_pcp:3548kB local_pcp:64kB free_cma:0kB
lowmem_reserve[]: 0 0 3923 3923
Node 0 Normal free:3438224kB boost:0kB min:6112kB low:10128kB high:14144kB reserved_highatomic:0KB active_anon:312kB inactive_anon:6884kB active_file:13664kB inactive_file:40900kB unevictable:0kB writepending:0kB present:5242880kB managed:4018128kB mlocked:0kB bounce:0kB free_pcp:8872kB local_pcp:4748kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 3*4kB (M) 1*8kB (M) 2*16kB (M) 3*32kB (M) 3*64kB (M) 3*128kB (M) 2*256kB (M) 2*512kB (M) 2*1024kB (M) 2*2048kB (M) 701*4096kB (M) = 2879700kB
Node 0 Normal: 486*4kB (UME) 767*8kB (UE) 318*16kB (UME) 3*32kB (M) 3*64kB (UM) 4*128kB (UME) 0*256kB 6*512kB (ME) 3*1024kB (ME) 1*2048kB (E) 834*4096kB (M) = 3438224kB
Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
13796 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
367867 pages reserved
Mem-Info:
active_anon:78 inactive_anon:1721 isolated_anon:0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
