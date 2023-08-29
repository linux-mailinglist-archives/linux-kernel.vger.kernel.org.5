Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94178C685
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjH2NzJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjH2Nyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:54:36 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861DD2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:54:30 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-56c379a8250so3528413a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693317270; x=1693922070;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68Sk2Hj4zdMwTTLE11C79tkg5Jl4/ndRCXPOkh9xWes=;
        b=ZXqZPchUytyXDs7KlZfXl+L+Qfxc3kFl9I/8cHccG5HV8VYZVaPiXCnHBIq74Ub3Ry
         1hfz+c9nRGpBvyWNgUlrfXEQifZrpbemJxTeo4sbFMs/1mKzNNSSDxq0EHoUvq7VLqho
         z3RzqCIYrEWZT4xKMVczzp6WIMkcQPefph61+X1kyTMA/e1aPE6HeS67wVg3voBQda9u
         gfjXTJ45imjLpYIukG8xvqVw+8SKkneTU3CIDIUyXFXJmP4iosxEM5HfDrzWCbrtcxzT
         hnn0RhpxCpEfckhnBJTslENpA38r+ZDKvVUxQCGjMWNI1Eb/IaDXI/pa2TmG/r5nLJoz
         c6Vw==
X-Gm-Message-State: AOJu0Yx3WntjO8hjvoHUNGrgkFIu7b9zErvCZvr7nnXgn/jEX7/gOdrX
        JCMIdN90kws12LDSeQgjp49EiVWGL0RQOqbmu+1kAw42fvGR
X-Google-Smtp-Source: AGHT+IGnOt8GICs6zqVZg187puwbfuTCU707P7ZpJd/oXlmG+8u0ePLh3pQSfIb+E1kWiLW+8pJ4yxjXvPSNFJU/h4gjRZ8XMGQ9
MIME-Version: 1.0
X-Received: by 2002:a63:9553:0:b0:565:5e77:d112 with SMTP id
 t19-20020a639553000000b005655e77d112mr5150541pgn.3.1693317270306; Tue, 29 Aug
 2023 06:54:30 -0700 (PDT)
Date:   Tue, 29 Aug 2023 06:54:30 -0700
In-Reply-To: <20230829131909.4306-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006388d30604102663@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in tcp_setsockopt
From:   syzbot <syzbot+1a11c39caf29450eac9f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in smp_call_function

Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10529 jiffies, g=14213, q=569 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10516 (4294963831-4294953315), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10516 jiffies! g14213 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:28320 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1613
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1812
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
0*64kB 
NMI backtrace for cpu 0
CPU: 0 PID: 2799 Comm: kworker/u4:8 Not tainted 6.5.0-syzkaller-01207-g1c59d383390f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x31/0x70 kernel/kcov.c:207
Code: 6d 4a 7d 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 00 ba 03 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 04 16 00 00 <85> c0 74 2b 8b 82 e0 15 00 00 83 f8 02 75 20 48 8b 8a e8 15 00 00
RSP: 0018:ffffc90000006f38 EFLAGS: 00000006
RAX: 0000000000000000 RBX: ffffffff8a6d598c RCX: 0000000000000100
RDX: ffff888028c18000 RSI: ffffffff8a25a4f8 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000001516a8 R12: ffffc90000007040
R13: ffffffff8a6d598b R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffc2078e90 CR3: 000000000c776000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 format_decode+0x2b8/0xba0 lib/vsprintf.c:2557
 vsnprintf+0x13d/0x1870 lib/vsprintf.c:2769
 sprintf+0xcd/0x100 lib/vsprintf.c:3021
 print_time kernel/printk/printk.c:1327 [inline]
 info_print_prefix+0x258/0x350 kernel/printk/printk.c:1353
 record_print_text+0x143/0x410 kernel/printk/printk.c:1402
 printk_get_next_message+0x2ca/0x7c0 kernel/printk/printk.c:2809
 console_emit_next_record kernel/printk/printk.c:2844 [inline]
 console_flush_all+0x39e/0xf50 kernel/printk/printk.c:2933
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1c5/0x640 kernel/printk/printk.c:2307
 vprintk+0x89/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 __show_free_areas+0x16d8/0x21b0 mm/show_mem.c:384
 __show_mem+0x34/0x150 mm/show_mem.c:409
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
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:csd_lock_wait kernel/smp.c:300 [inline]
RIP: 0010:smp_call_function_many_cond+0x4db/0x1570 kernel/smp.c:844
Code: 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 fc 4c 89 fd 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 9c 62 0b 00 f3 90 41 0f b6 04 24 <40> 38 c5 7c 08 84 c0 0f 85 3c 0e 00 00 8b 43 08 31 ff 83 e0 01 41
RSP: 0018:ffffc9000b67f938 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b99417c0 RCX: 0000000000000000
RDX: ffff888028c18000 RSI: ffffffff817b0cf4 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffed10173282f9
R13: 0000000000000001 R14: ffff8880b983d600 R15: ffff8880b99417c8
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1012
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1998 [inline]
 text_poke_bp_batch+0x250/0x780 arch/x86/kernel/alternative.c:2208
 text_poke_flush arch/x86/kernel/alternative.c:2399 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2396 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2406
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32e/0x410 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b5/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:831 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:823
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11968 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27156kB local_pcp:17808kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11967 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27152kB local_pcp:9348kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:17804kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:17804kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:17804kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:17804kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11966 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27148kB local_pcp:17804kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11961 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27128kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11961 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27128kB local_pcp:17784kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11961 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27128kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11961 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27128kB local_pcp:17784kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11961 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27128kB local_pcp:9344kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:12kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:8128kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_file:0
 unevictable:768 dirty:0 writeback:2
 slab_reclaimable:20894 slab_unreclaimable:97667
 mapped:6996 shmem:1274 pagetables:611
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1414124 free_pcp:11961 free_cma:0
Node 0 active_anon:43124kB inactive_anon:2032kB active_file:0kB inactive_file:207540kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:27984kB dirty:0kB writeback:8kB shmem:3560kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:10992kB pagetables:2444kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:1728276kB boost:0kB min:35408kB low:44260kB high:53112kB reserved_highatomic:0KB active_anon:43084kB inactive_anon:2028kB active_file:0kB inactive_file:206472kB unevictable:1536kB writepending:8kB present:3129332kB managed:2680460kB mlocked:0kB bounce:0kB free_pcp:27128kB local_pcp:17784kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:4kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:40kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:12kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3912856kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:76kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117620kB mlocked:0kB bounce:0kB free_pcp:20704kB local_pcp:12576kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 573*4kB (UME) 1158*8kB (UME) 493*16kB (UE) 1*32kB (U) 2*64kB (E) 3*128kB (UME) 3*256kB (UME) 3*512kB (ME) 2*1024kB (ME) 2*2048kB (ME) 415*4096kB (M) = 1728276kB
Node 0 Normal: 1*4kB (M) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
Node 1 Normal: 192*4kB (UME) 49*8kB (UME) 23*16kB (UME) 57*32kB (UME) 26*64kB (UME) 6*128kB (UME) 2*256kB (ME) 2*512kB (ME) 2*1024kB (UE) 2*2048kB (UE) 952*4096kB (M) = 3912856kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
53178 total pagecache pages
0 pages in swap cache
Free swap  = 124996kB
Total swap = 124996kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393409 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:10781 inactive_anon:508 isolated_anon:0
 active_file:0 inactive_file:51904 isolated_

Tested on:

commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=138a248fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9678e210dd5e4a5f
dashboard link: https://syzkaller.appspot.com/bug?extid=1a11c39caf29450eac9f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1655c0c0680000

