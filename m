Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3180B386
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjLIJoA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 04:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:43:59 -0500
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB610FC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 01:44:04 -0800 (PST)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3b9eeb0e179so1684236b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 01:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702115043; x=1702719843;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLsN1kmh6eKb+TtylxrawAANBdwE35QlxS13xabXl6k=;
        b=u331JA/xcsNp5S844WtdwcNP1l1fF8muti2FFUFv+ihbOiQRxVZnPPho/tIkuJv5vk
         tVpnfAntmk6ypkV4dAEmmGwwFluP+tvB39AQxhD9yqfHRFQkJP8fDcHxxU0u7xHikYRR
         7Q4VRJ4gagkGqXAuP/a6UlOZwiyRhDmRMEU/unSXdLXsTol7X0BTMk8PSlcu7pL6nPrW
         folQlqNzpZSXFFZUU8sRumaHbET5fpV0R1NRqdzrrFlPnUhE3cw2tOsB2MRp5UwdD7T2
         /429hj3M4txlr9aYi6j/uof6yHvaTaVqJJoKjKUvm00C6cs5tyKJskXssR7Trs17aanX
         w7tg==
X-Gm-Message-State: AOJu0YzMc259Hnf1/7+TGniikRav6LmyjGE07xasxx9XCkB6GCgXOvd/
        /GHw/6zpk0p2hyV1aitIVqY5c6qlnTEiP+JamJiUGSP6bwv5
X-Google-Smtp-Source: AGHT+IEAZwhVg5mRHaG7zdx8iCb2dj9tBi05O58/Uz0+z1gVe8Gp/tO/8J3pqLKKaPWE50GZI0nMXB6EmqL/q3/q3bjGJZp2mhTS
MIME-Version: 1.0
X-Received: by 2002:a05:6808:20a2:b0:3b9:b31d:4034 with SMTP id
 s34-20020a05680820a200b003b9b31d4034mr1353697oiw.0.1702115043546; Sat, 09 Dec
 2023 01:44:03 -0800 (PST)
Date:   Sat, 09 Dec 2023 01:44:03 -0800
In-Reply-To: <3753ec68-b5e3-40f7-8abe-6e4c737fa5f7@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000899a64060c108a26@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

T5050] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
[   62.857361][ T5050] hsr_slave_0: entered promiscuous mode
[   62.864126][ T5050] hsr_slave_1: entered promiscuous mode
[   62.979501][ T5050] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   62.996696][ T5050] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   63.006256][ T5050] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   63.015837][ T5050] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   63.041312][ T5050] bridge0: port 2(bridge_slave_1) entered blocking state
[   63.048641][ T5050] bridge0: port 2(bridge_slave_1) entered forwarding state
[   63.056959][ T5050] bridge0: port 1(bridge_slave_0) entered blocking state
[   63.064263][ T5050] bridge0: port 1(bridge_slave_0) entered forwarding state
[   63.119861][ T5050] 8021q: adding VLAN 0 to HW filter on device bond0
[   63.148864][ T1634] bridge0: port 1(bridge_slave_0) entered disabled state
[   63.157999][ T1634] bridge0: port 2(bridge_slave_1) entered disabled state
[  179.731056][    C0] ------------[ cut here ]------------
[  179.737601][    C0] WARNING: CPU: 0 PID: 11 at kernel/rcu/tree_stall.h:990 rcu_check_gp_start_stall+0x2c8/0x450
[  179.748258][    C0] Modules linked in:
[  179.752699][    C0] CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.7.0-rc4-syzkaller-00840-ga3c205d0560f-dirty #0
[  179.763989][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[  179.774762][    C0] Workqueue: events_unbound toggle_allocation_gate
[  179.781293][    C0] RIP: 0010:rcu_check_gp_start_stall+0x2c8/0x450
[  179.787811][    C0] Code: c7 c7 20 03 61 92 be 04 00 00 00 e8 c2 b0 73 00 b8 01 00 00 00 87 05 17 88 e9 10 85 c0 0f 85 1c ff ff ff 48 c7 c0 40 23 93 8d <0f> 0b 49 39 c7 74 47 48 c7 c0 fc cb 00 8f 48 c1 e8 03 42 0f b6 04
[  179.808399][    C0] RSP: 0018:ffffc90000007bd8 EFLAGS: 00010046
[  179.814568][    C0] RAX: ffffffff8d932340 RBX: 00000000ffffcb7c RCX: ffffffff81777afe
[  179.822636][    C0] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff92610320
[  179.830613][    C0] RBP: ffffc90000007e30 R08: 0000000000000003 R09: fffffbfff24c2064
[  179.840847][    C0] R10: dffffc0000000000 R11: fffffbfff24c2064 R12: dffffc0000000000
[  179.849003][    C0] R13: dffffc0000000000 R14: 0000000000000246 R15: ffffffff8d932340
[  179.857082][    C0] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[  179.866546][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  179.873705][    C0] CR2: 00007ffdeb775fe8 CR3: 000000000d730000 CR4: 00000000003506f0
[  179.881843][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  179.890277][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  179.898361][    C0] Call Trace:
[  179.901772][    C0]  <IRQ>
[  179.904649][    C0]  ? __warn+0x162/0x4a0
[  179.909260][    C0]  ? rcu_check_gp_start_stall+0x2c8/0x450
[  179.915024][    C0]  ? report_bug+0x2b3/0x500
[  179.919734][    C0]  ? rcu_check_gp_start_stall+0x2c8/0x450
[  179.925470][    C0]  ? handle_bug+0x3d/0x70
[  179.930252][    C0]  ? exc_invalid_op+0x1a/0x50
[  179.935586][    C0]  ? asm_exc_invalid_op+0x1a/0x20
[  179.940822][    C0]  ? rcu_check_gp_start_stall+0x2ae/0x450
[  179.946630][    C0]  ? rcu_check_gp_start_stall+0x2c8/0x450
[  179.952413][    C0]  ? rcu_check_gp_start_stall+0x2ae/0x450
[  179.958459][    C0]  rcu_core+0x663/0x17a0
[  179.962834][    C0]  ? read_lock_is_recursive+0x20/0x20
[  179.968258][    C0]  ? ktime_get+0x83/0x270
[  179.972813][    C0]  ? rcu_cpu_kthread_park+0x90/0x90
[  179.978055][    C0]  ? kvm_sched_clock_read+0x11/0x20
[  179.983302][    C0]  ? sched_clock+0x4a/0x60
[  179.987843][    C0]  ? mark_lock+0x9a/0x340
[  179.992197][    C0]  ? lockdep_hardirqs_on_prepare+0x43c/0x7a0
[  179.998196][    C0]  ? print_irqtrace_events+0x220/0x220
[  180.003697][    C0]  ? do_raw_spin_unlock+0x13b/0x8b0
[  180.008968][    C0]  __do_softirq+0x2bf/0x93a
[  180.013814][    C0]  ? __irq_exit_rcu+0xf1/0x1b0
[  180.018616][    C0]  ? __lock_text_end+0xc/0xc
[  180.023225][    C0]  ? irqtime_account_irq+0xd4/0x1e0
[  180.028445][    C0]  __irq_exit_rcu+0xf1/0x1b0
[  180.033142][    C0]  ? irq_exit_rcu+0x20/0x20
[  180.037866][    C0]  irq_exit_rcu+0x9/0x20
[  180.042408][    C0]  sysvec_apic_timer_interrupt+0x95/0xb0
[  180.048243][    C0]  </IRQ>
[  180.051182][    C0]  <TASK>
[  180.054123][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  180.060165][    C0] RIP: 0010:__sanitizer_cov_trace_pc+0x36/0x60
[  180.066365][    C0] Code: b0 f0 74 7e 65 8b 15 b1 f0 74 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 fc 15 00 00 00 74 2c 8b 91 d8 15 00 00 <83> fa 02 75 21 48 8b 91 e0 15 00 00 48 8b 32 48 8d 7e 01 8b 89 dc
[  180.086252][    C0] RSP: 0018:ffffc90000107718 EFLAGS: 00000246
[  180.092428][    C0] RAX: ffffffff81833ce4 RBX: 1ffff110173282d5 RCX: ffff888017a43b80
[  180.100441][    C0] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[  180.108510][    C0] RBP: ffffc90000107920 R08: ffffffff81833cb3 R09: 1ffffffff21bac6c
[  180.116949][    C0] R10: dffffc0000000000 R11: fffffbfff21bac6d R12: dffffc0000000000
[  180.125132][    C0] R13: ffff8880b99416a8 R14: ffff8880b983d480 R15: 0000000000000001
[  180.133973][    C0]  ? smp_call_function_many_cond+0x1813/0x2900
[  180.140795][    C0]  ? smp_call_function_many_cond+0x1844/0x2900
[  180.147370][    C0]  smp_call_function_many_cond+0x1844/0x2900
[  180.154212][    C0]  ? text_poke_sync+0x30/0x30
[  180.159289][    C0]  ? text_poke+0xc0/0xc0
[  180.163738][    C0]  ? smp_call_function_many+0x40/0x40
[  180.169302][    C0]  ? __might_sleep+0xc0/0xc0
[  180.174016][    C0]  ? __mutex_trylock_common+0x182/0x2e0
[  180.180065][    C0]  ? __might_sleep+0xc0/0xc0
[  180.185033][    C0]  ? text_poke_sync+0x30/0x30
[  180.189811][    C0]  on_each_cpu_cond_mask+0x3f/0x80
[  180.194980][    C0]  text_poke_bp_batch+0x350/0xb20
[  180.200672][    C0]  ? text_poke_loc_init+0x860/0x860
[  180.206308][    C0]  ? mutex_lock_nested+0x20/0x20
[  180.211647][    C0]  ? arch_jump_label_transform_queue+0x97/0xf0
[  180.218209][    C0]  text_poke_finish+0x30/0x50
[  180.223276][    C0]  arch_jump_label_transform_apply+0x1c/0x30
[  180.229554][    C0]  static_key_enable_cpuslocked+0x132/0x250
[  180.235503][    C0]  static_key_enable+0x1a/0x20
[  180.240314][    C0]  toggle_allocation_gate+0xb5/0x250
[  180.245881][    C0]  ? show_object+0x70/0x70
[  180.250317][    C0]  ? print_irqtrace_events+0x220/0x220
[  180.256155][    C0]  ? process_scheduled_works+0x825/0x1400
[  180.262276][    C0]  process_scheduled_works+0x90f/0x1400
[  180.268186][    C0]  ? assign_work+0x3d0/0x3d0
[  180.273104][    C0]  ? assign_work+0x364/0x3d0
[  180.277830][    C0]  worker_thread+0xa5f/0xff0
[  180.282565][    C0]  kthread+0x2d3/0x370
[  180.286912][    C0]  ? pr_cont_work+0x5e0/0x5e0
[  180.291599][    C0]  ? kthread_blkcg+0xd0/0xd0
[  180.296209][    C0]  ret_from_fork+0x48/0x80
[  180.300811][    C0]  ? kthread_blkcg+0xd0/0xd0
[  180.305778][    C0]  ret_from_fork_asm+0x11/0x20
[  180.310869][    C0]  </TASK>
[  180.314004][    C0] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  180.321584][    C0] CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.7.0-rc4-syzkaller-00840-ga3c205d0560f-dirty #0
[  180.332897][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[  180.343222][    C0] Workqueue: events_unbound toggle_allocation_gate
[  180.349953][    C0] Call Trace:
[  180.353457][    C0]  <IRQ>
[  180.356398][    C0]  dump_stack_lvl+0x1e7/0x2d0
[  180.361313][    C0]  ? tcp_gro_dev_warn+0x260/0x260
[  180.366935][    C0]  ? panic+0x850/0x850
[  180.371612][    C0]  ? _printk+0xd5/0x120
[  180.376277][    C0]  ? vscnprintf+0x5d/0x80
[  180.380716][    C0]  panic+0x349/0x850
[  180.384982][    C0]  ? __warn+0x171/0x4a0
[  180.389284][    C0]  ? __memcpy_flushcache+0x2b0/0x2b0
[  180.394850][    C0]  ? show_trace_log_lvl+0x4e4/0x520
[  180.400541][    C0]  ? ret_from_fork_asm+0x11/0x20
[  180.405614][    C0]  __warn+0x314/0x4a0
[  180.409706][    C0]  ? rcu_check_gp_start_stall+0x2c8/0x450
[  180.415699][    C0]  report_bug+0x2b3/0x500
[  180.420350][    C0]  ? rcu_check_gp_start_stall+0x2c8/0x450
[  180.426187][    C0]  handle_bug+0x3d/0x70
[  180.430438][    C0]  exc_invalid_op+0x1a/0x50
[  180.435077][    C0]  asm_exc_invalid_op+0x1a/0x20
[  180.440048][    C0] RIP: 0010:rcu_check_gp_start_stall+0x2c8/0x450
[  180.446418][    C0] Code: c7 c7 20 03 61 92 be 04 00 00 00 e8 c2 b0 73 00 b8 01 00 00 00 87 05 17 88 e9 10 85 c0 0f 85 1c ff ff ff 48 c7 c0 40 23 93 8d <0f> 0b 49 39 c7 74 47 48 c7 c0 fc cb 00 8f 48 c1 e8 03 42 0f b6 04
[  180.466139][    C0] RSP: 0018:ffffc90000007bd8 EFLAGS: 00010046
[  180.473016][    C0] RAX: ffffffff8d932340 RBX: 00000000ffffcb7c RCX: ffffffff81777afe
[  180.481308][    C0] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff92610320
[  180.489668][    C0] RBP: ffffc90000007e30 R08: 0000000000000003 R09: fffffbfff24c2064
[  180.497745][    C0] R10: dffffc0000000000 R11: fffffbfff24c2064 R12: dffffc0000000000
[  180.506192][    C0] R13: dffffc0000000000 R14: 0000000000000246 R15: ffffffff8d932340
[  180.514479][    C0]  ? rcu_check_gp_start_stall+0x2ae/0x450
[  180.520417][    C0]  ? rcu_check_gp_start_stall+0x2ae/0x450
[  180.526323][    C0]  rcu_core+0x663/0x17a0
[  180.530685][    C0]  ? read_lock_is_recursive+0x20/0x20
[  180.536185][    C0]  ? ktime_get+0x83/0x270
[  180.540680][    C0]  ? rcu_cpu_kthread_park+0x90/0x90
[  180.545998][    C0]  ? kvm_sched_clock_read+0x11/0x20
[  180.551211][    C0]  ? sched_clock+0x4a/0x60
[  180.555991][    C0]  ? mark_lock+0x9a/0x340
[  180.560424][    C0]  ? lockdep_hardirqs_on_prepare+0x43c/0x7a0
[  180.566502][    C0]  ? print_irqtrace_events+0x220/0x220
[  180.572211][    C0]  ? do_raw_spin_unlock+0x13b/0x8b0
[  180.577746][    C0]  __do_softirq+0x2bf/0x93a
[  180.582760][    C0]  ? __irq_exit_rcu+0xf1/0x1b0
[  180.587741][    C0]  ? __lock_text_end+0xc/0xc
[  180.592355][    C0]  ? irqtime_account_irq+0xd4/0x1e0
[  180.597657][    C0]  __irq_exit_rcu+0xf1/0x1b0
[  180.602619][    C0]  ? irq_exit_rcu+0x20/0x20
[  180.607243][    C0]  irq_exit_rcu+0x9/0x20
[  180.612553][    C0]  sysvec_apic_timer_interrupt+0x95/0xb0
[  180.618722][    C0]  </IRQ>
[  180.621714][    C0]  <TASK>
[  180.624742][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  180.631115][    C0] RIP: 0010:__sanitizer_cov_trace_pc+0x36/0x60
[  180.637594][    C0] Code: b0 f0 74 7e 65 8b 15 b1 f0 74 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 fc 15 00 00 00 74 2c 8b 91 d8 15 00 00 <83> fa 02 75 21 48 8b 91 e0 15 00 00 48 8b 32 48 8d 7e 01 8b 89 dc
[  180.657407][    C0] RSP: 0018:ffffc90000107718 EFLAGS: 00000246
[  180.663507][    C0] RAX: ffffffff81833ce4 RBX: 1ffff110173282d5 RCX: ffff888017a43b80
[  180.671669][    C0] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[  180.679908][    C0] RBP: ffffc90000107920 R08: ffffffff81833cb3 R09: 1ffffffff21bac6c
[  180.687996][    C0] R10: dffffc0000000000 R11: fffffbfff21bac6d R12: dffffc0000000000
[  180.696061][    C0] R13: ffff8880b99416a8 R14: ffff8880b983d480 R15: 0000000000000001
[  180.704055][    C0]  ? smp_call_function_many_cond+0x1813/0x2900
[  180.710320][    C0]  ? smp_call_function_many_cond+0x1844/0x2900
[  180.716692][    C0]  smp_call_function_many_cond+0x1844/0x2900
[  180.722873][    C0]  ? text_poke_sync+0x30/0x30
[  180.727835][    C0]  ? text_poke+0xc0/0xc0
[  180.732236][    C0]  ? smp_call_function_many+0x40/0x40
[  180.737749][    C0]  ? __might_sleep+0xc0/0xc0
[  180.742376][    C0]  ? __mutex_trylock_common+0x182/0x2e0
[  180.748112][    C0]  ? __might_sleep+0xc0/0xc0
[  180.752894][    C0]  ? text_poke_sync+0x30/0x30
[  180.757714][    C0]  on_each_cpu_cond_mask+0x3f/0x80
[  180.763241][    C0]  text_poke_bp_batch+0x350/0xb20
[  180.768493][    C0]  ? text_poke_loc_init+0x860/0x860
[  180.773704][    C0]  ? mutex_lock_nested+0x20/0x20
[  180.779139][    C0]  ? arch_jump_label_transform_queue+0x97/0xf0
[  180.785588][    C0]  text_poke_finish+0x30/0x50
[  180.790541][    C0]  arch_jump_label_transform_apply+0x1c/0x30
[  180.797351][    C0]  static_key_enable_cpuslocked+0x132/0x250
[  180.803757][    C0]  static_key_enable+0x1a/0x20
[  180.809346][    C0]  toggle_allocation_gate+0xb5/0x250
[  180.814653][    C0]  ? show_object+0x70/0x70
[  180.819152][    C0]  ? print_irqtrace_events+0x220/0x220
[  180.824746][    C0]  ? process_scheduled_works+0x825/0x1400
[  180.830604][    C0]  process_scheduled_works+0x90f/0x1400
[  180.836209][    C0]  ? assign_work+0x3d0/0x3d0
[  180.840832][    C0]  ? assign_work+0x364/0x3d0
[  180.845529][    C0]  worker_thread+0xa5f/0xff0
[  180.850253][    C0]  kthread+0x2d3/0x370
[  180.854449][    C0]  ? pr_cont_work+0x5e0/0x5e0
[  180.859271][    C0]  ? kthread_blkcg+0xd0/0xd0
[  180.864084][    C0]  ret_from_fork+0x48/0x80
[  180.868617][    C0]  ? kthread_blkcg+0xd0/0xd0
[  180.873223][    C0]  ret_from_fork_asm+0x11/0x20
[  180.878369][    C0]  </TASK>
[  182.025765][    C0] Shutting down cpus with NMI
[  182.030790][    C0] Kernel Offset: disabled
[  182.035896][    C0] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1579409592=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 500bfdc41
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231103-130513'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231103-130513'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231103-130513'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"500bfdc41735bc8d617cbfd4f1ab6b5980c8f1e5\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=12d84132e80000


Tested on:

commit:         a3c205d0 ipv6: do not check fib6_has_expires() in fib6..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=57866e264f623c10
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b2124ce80000

