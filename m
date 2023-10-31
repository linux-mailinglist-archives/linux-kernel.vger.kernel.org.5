Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878E17DD83E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbjJaW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbjJaW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:27:10 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AFEF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:27:06 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E91A8400075
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:26:16 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7528013C2B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:26:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7528013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698791176;
        bh=0m2bl44BZA+YhfXzP4MnZHjzMkLKjdT0HSdz+73qDj0=;
        h=Date:To:From:Subject:From;
        b=b847f1dP3KKJ3DmJ39UgqBnocXyGsIZ7jjnxcwq1nwKRCYx1cdqHjR0Aa96C/637P
         Xku+Fjogyz3ylxeqODJ6JMWaZXwmKZ4qklWWhcwzgJYiwP3gboi21P1bjAzQoozHrq
         icftTNGhd3yvkfoNTlrgXkTpjs30tte7efoXWg5s=
Message-ID: <ee92ea59-440e-5f7e-1dc1-f9a77c06d6e2@candelatech.com>
Date:   Tue, 31 Oct 2023 15:26:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: wireless-next (6.6.0-rc5+) lockdep splat related to console_sem,
 hrtimer_bases.lock, n->list_lock.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698791224-IzmGAGp2moML
X-MDID-O: us5;ut7;1698791224;IzmGAGp2moML;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a kernel fully larded up with debugging.  No idea how legit this is...


Oct 31 15:19:37 ct523c-2103 kernel: WARNING: possible circular locking dependency detected
Oct 31 15:19:37 ct523c-2103 kernel: 6.6.0-rc5+ #8 Tainted: G        W
Oct 31 15:19:37 ct523c-2103 kernel: ------------------------------------------------------
Oct 31 15:19:37 ct523c-2103 kernel: pkill/23351 is trying to acquire lock:
Oct 31 15:19:37 ct523c-2103 kernel: ffffffff83836cf8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xc/0x40
Oct 31 15:19:37 ct523c-2103 kernel:
                                     but task is already holding lock:
Oct 31 15:19:37 ct523c-2103 kernel: ffff8881100407d8 (&n->list_lock){-.-.}-{3:3}, at: free_to_partial_list+0x55/0x5b0
Oct 31 15:19:37 ct523c-2103 kernel:
                                     which lock already depends on the new lock.
Oct 31 15:19:37 ct523c-2103 kernel:
                                     the existing dependency chain (in reverse order) is:
Oct 31 15:19:37 ct523c-2103 kernel:
                                     -> #5 (&n->list_lock){-.-.}-{3:3}:
Oct 31 15:19:37 ct523c-2103 kernel:        _raw_spin_lock_irqsave+0x3f/0x60
Oct 31 15:19:37 ct523c-2103 kernel:        get_partial_node.part.0+0x28/0x560
Oct 31 15:19:37 ct523c-2103 kernel:        ___slab_alloc+0xc4e/0x1210
Oct 31 15:19:37 ct523c-2103 kernel:        kmem_cache_alloc+0x2e9/0x310
Oct 31 15:19:37 ct523c-2103 kernel:        fill_pool+0x216/0x330
Oct 31 15:19:37 ct523c-2103 kernel:        debug_object_activate+0x140/0x380
Oct 31 15:19:37 ct523c-2103 kernel:        enqueue_hrtimer+0x1b/0x140
Oct 31 15:19:37 ct523c-2103 kernel:        hrtimer_start_range_ns+0x3bf/0x5e0
Oct 31 15:19:37 ct523c-2103 kernel:        tick_nohz_restart+0xcb/0xd0
Oct 31 15:19:37 ct523c-2103 kernel:        tick_nohz_idle_exit+0xdf/0x160
Oct 31 15:19:37 ct523c-2103 kernel:        do_idle+0x1ec/0x2f0
Oct 31 15:19:37 ct523c-2103 kernel:        cpu_startup_entry+0x2b/0x30
Oct 31 15:19:37 ct523c-2103 kernel:        rest_init+0x100/0x1a0
Oct 31 15:19:37 ct523c-2103 kernel:        arch_call_rest_init+0xa/0x20
Oct 31 15:19:37 ct523c-2103 kernel:        start_kernel+0x37c/0x3f0
Oct 31 15:19:37 ct523c-2103 kernel:        x86_64_start_reservations+0x14/0x30
Oct 31 15:19:37 ct523c-2103 kernel:        x86_64_start_kernel+0x7e/0x80
Oct 31 15:19:37 ct523c-2103 kernel:        secondary_startup_64_no_verify+0x166/0x16b
Oct 31 15:19:37 ct523c-2103 kernel:
                                     -> #4 (hrtimer_bases.lock){-.-.}-{2:2}:
Oct 31 15:19:37 ct523c-2103 kernel:        _raw_spin_lock_irqsave+0x3f/0x60
Oct 31 15:19:37 ct523c-2103 kernel:        hrtimer_start_range_ns+0x70/0x5e0
Oct 31 15:19:37 ct523c-2103 kernel:        __enqueue_rt_entity+0x618/0x650
Oct 31 15:19:37 ct523c-2103 kernel:        enqueue_rt_entity+0x46/0xc0
Oct 31 15:19:37 ct523c-2103 kernel:        enqueue_task_rt+0x5e/0x1d0
Oct 31 15:19:37 ct523c-2103 kernel:        __sched_setscheduler+0xcd2/0x1050
Oct 31 15:19:37 ct523c-2103 kernel:        sched_set_fifo+0xa5/0xf0
Oct 31 15:19:37 ct523c-2103 kernel:        smpboot_thread_fn+0x1f0/0x340
Oct 31 15:19:37 ct523c-2103 kernel:        kthread+0x199/0x1e0
Oct 31 15:19:37 ct523c-2103 kernel:        ret_from_fork+0x28/0x50
Oct 31 15:19:37 ct523c-2103 kernel:        ret_from_fork_asm+0x11/0x20
Oct 31 15:19:37 ct523c-2103 kernel:
                                     -> #3 (&rt_b->rt_runtime_lock){-.-.}-{2:2}:
Oct 31 15:19:37 ct523c-2103 kernel:        _raw_spin_lock+0x27/0x40
Oct 31 15:19:37 ct523c-2103 kernel:        __enqueue_rt_entity+0x332/0x650
Oct 31 15:19:37 ct523c-2103 kernel:        enqueue_rt_entity+0x46/0xc0
Oct 31 15:19:37 ct523c-2103 kernel:        enqueue_task_rt+0x5e/0x1d0
Oct 31 15:19:37 ct523c-2103 kernel:        __sched_setscheduler+0xcd2/0x1050
Oct 31 15:19:37 ct523c-2103 kernel:        sched_set_fifo+0xa5/0xf0
Oct 31 15:19:37 ct523c-2103 kernel:        smpboot_thread_fn+0x1f0/0x340
Oct 31 15:19:37 ct523c-2103 kernel:        kthread+0x199/0x1e0
Oct 31 15:19:37 ct523c-2103 kernel:        ret_from_fork+0x28/0x50
Oct 31 15:19:37 ct523c-2103 kernel:        ret_from_fork_asm+0x11/0x20
Oct 31 15:19:37 ct523c-2103 kernel:
                                     -> #2 (&rq->__lock){-.-.}-{2:2}:
Oct 31 15:19:37 ct523c-2103 kernel:        _raw_spin_lock_nested+0x25/0x30
Oct 31 15:19:37 ct523c-2103 kernel:        raw_spin_rq_lock_nested+0xc/0x20
Oct 31 15:19:37 ct523c-2103 kernel:        task_fork_fair+0x31/0x100
Oct 31 15:19:37 ct523c-2103 kernel:        sched_cgroup_fork+0x298/0x300
Oct 31 15:19:37 ct523c-2103 kernel:        copy_process+0x2213/0x32c0
Oct 31 15:19:37 ct523c-2103 kernel:        kernel_clone+0xf6/0x4b0
Oct 31 15:19:37 ct523c-2103 kernel:        user_mode_thread+0xa1/0xd0
Oct 31 15:19:37 ct523c-2103 kernel:        rest_init+0x19/0x1a0
Oct 31 15:19:37 ct523c-2103 kernel:        arch_call_rest_init+0xa/0x20
Oct 31 15:19:37 ct523c-2103 kernel:        start_kernel+0x37c/0x3f0
Oct 31 15:19:37 ct523c-2103 kernel:        x86_64_start_reservations+0x14/0x30
Oct 31 15:19:37 ct523c-2103 kernel:        x86_64_start_kernel+0x7e/0x80
Oct 31 15:19:37 ct523c-2103 kernel:        secondary_startup_64_no_verify+0x166/0x16b
Oct 31 15:19:37 ct523c-2103 kernel:
                                     -> #1 (&p->pi_lock){-.-.}-{2:2}:
Oct 31 15:19:37 ct523c-2103 kernel:        _raw_spin_lock_irqsave+0x3f/0x60
Oct 31 15:19:37 ct523c-2103 kernel:        try_to_wake_up+0x93/0xd20
Oct 31 15:19:37 ct523c-2103 kernel:        up+0x49/0x60
Oct 31 15:19:37 ct523c-2103 kernel:        console_unlock+0x153/0x170
Oct 31 15:19:37 ct523c-2103 kernel:        vprintk_emit+0xd5/0x310
Oct 31 15:19:37 ct523c-2103 kernel:        _printk+0xae/0xe0
Oct 31 15:19:37 ct523c-2103 kernel:        __dynamic_pr_debug+0x1c4/0x220
Oct 31 15:19:37 ct523c-2103 kernel:        kobject_delayed_cleanup+0x5a/0x140
Oct 31 15:19:37 ct523c-2103 kernel:        process_one_work+0x475/0x920
Oct 31 15:19:37 ct523c-2103 kernel:        worker_thread+0x38a/0x680
Oct 31 15:19:37 ct523c-2103 kernel:        kthread+0x199/0x1e0
Oct 31 15:19:37 ct523c-2103 kernel:        ret_from_fork+0x28/0x50
Oct 31 15:19:37 ct523c-2103 kernel:        ret_from_fork_asm+0x11/0x20
Oct 31 15:19:37 ct523c-2103 kernel:
                                     -> #0 ((console_sem).lock){-.-.}-{2:2}:
Oct 31 15:19:37 ct523c-2103 kernel:        __lock_acquire+0x1de8/0x3210
Oct 31 15:19:37 ct523c-2103 kernel:        lock_acquire+0x15a/0x3b0
Oct 31 15:19:37 ct523c-2103 kernel:        _raw_spin_lock_irqsave+0x3f/0x60
Oct 31 15:19:37 ct523c-2103 kernel:        down_trylock+0xc/0x40
Oct 31 15:19:37 ct523c-2103 kernel:        __down_trylock_console_sem+0x2a/0x90
Oct 31 15:19:37 ct523c-2103 kernel:        console_trylock+0x31/0x80
Oct 31 15:19:37 ct523c-2103 kernel:        vprintk_emit+0xcc/0x310
Oct 31 15:19:37 ct523c-2103 kernel:        _printk+0xae/0xe0
Oct 31 15:19:37 ct523c-2103 kernel:        slab_bug+0x65/0xb0
Oct 31 15:19:37 ct523c-2103 kernel:        check_object+0x140/0x310
Oct 31 15:19:37 ct523c-2103 kernel:        free_to_partial_list+0x1ff/0x5b0
Oct 31 15:19:37 ct523c-2103 kernel:        qlist_free_all+0x6d/0x190
Oct 31 15:19:37 ct523c-2103 kernel:        kasan_quarantine_reduce+0x18a/0x1d0
Oct 31 15:19:37 ct523c-2103 kernel:        __kasan_slab_alloc+0x46/0x70
Oct 31 15:19:37 ct523c-2103 kernel:        kmem_cache_alloc+0x111/0x310
Oct 31 15:19:37 ct523c-2103 kernel:        getname_flags.part.0+0x34/0x240
Oct 31 15:19:37 ct523c-2103 kernel:        do_sys_openat2+0xc6/0x130
Oct 31 15:19:37 ct523c-2103 kernel:        __x64_sys_openat+0xe0/0x130
Oct 31 15:19:37 ct523c-2103 kernel:        do_syscall_64+0x34/0xb0
Oct 31 15:19:37 ct523c-2103 kernel:        entry_SYSCALL_64_after_hwframe+0x46/0xb0
Oct 31 15:19:37 ct523c-2103 kernel:
                                     other info that might help us debug this:
Oct 31 15:19:37 ct523c-2103 kernel: Chain exists of:
                                       (console_sem).lock --> hrtimer_bases.lock --> &n->list_lock
Oct 31 15:19:37 ct523c-2103 kernel:  Possible unsafe locking scenario:
Oct 31 15:19:37 ct523c-2103 kernel:        CPU0                    CPU1
Oct 31 15:19:37 ct523c-2103 kernel:        ----                    ----
Oct 31 15:19:37 ct523c-2103 kernel:   lock(&n->list_lock);
Oct 31 15:19:37 ct523c-2103 kernel:                                lock(hrtimer_bases.lock);
Oct 31 15:19:37 ct523c-2103 kernel:                                lock(&n->list_lock);
Oct 31 15:19:37 ct523c-2103 kernel:   lock((console_sem).lock);
Oct 31 15:19:37 ct523c-2103 kernel:
                                      *** DEADLOCK ***
Oct 31 15:19:37 ct523c-2103 kernel: 2 locks held by pkill/23351:
Oct 31 15:19:37 ct523c-2103 kernel:  #0: ffffffff8392de30 (remove_cache_srcu){.+.+}-{0:0}, at: kasan_quarantine_reduce+0x7d/0x1d0
Oct 31 15:19:37 ct523c-2103 kernel:  #1: ffff8881100407d8 (&n->list_lock){-.-.}-{3:3}, at: free_to_partial_list+0x55/0x5b0
Oct 31 15:19:37 ct523c-2103 kernel:
                                     stack backtrace:
Oct 31 15:19:37 ct523c-2103 kernel: CPU: 0 PID: 23351 Comm: pkill Tainted: G        W          6.6.0-rc5+ #8
Oct 31 15:19:37 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Oct 31 15:19:37 ct523c-2103 kernel: Call Trace:
Oct 31 15:19:37 ct523c-2103 kernel:  <TASK>
Oct 31 15:19:37 ct523c-2103 kernel:  dump_stack_lvl+0x57/0x90
Oct 31 15:19:37 ct523c-2103 kernel:  check_noncircular+0x24b/0x290
Oct 31 15:19:37 ct523c-2103 kernel:  ? print_circular_bug+0x430/0x430
Oct 31 15:19:37 ct523c-2103 kernel:  ? format_decode+0xb2/0x520
Oct 31 15:19:37 ct523c-2103 kernel:  ? fill_ptr_key+0x20/0x20
Oct 31 15:19:37 ct523c-2103 kernel:  ? lockdep_lock+0xa3/0x150
Oct 31 15:19:37 ct523c-2103 kernel:  ? usage_skip+0xa0/0xa0
Oct 31 15:19:37 ct523c-2103 kernel:  ? add_chain_block+0x2cc/0x2f0
Oct 31 15:19:37 ct523c-2103 kernel:  __lock_acquire+0x1de8/0x3210
Oct 31 15:19:37 ct523c-2103 kernel:  ? lockdep_hardirqs_on_prepare+0x200/0x200
Oct 31 15:19:37 ct523c-2103 kernel:  ? prb_final_commit+0x42/0x50
Oct 31 15:19:37 ct523c-2103 kernel:  ? vprintk_store+0x3a9/0x630
Oct 31 15:19:37 ct523c-2103 kernel:  lock_acquire+0x15a/0x3b0
Oct 31 15:19:37 ct523c-2103 kernel:  ? down_trylock+0xc/0x40
Oct 31 15:19:37 ct523c-2103 kernel:  ? lock_sync+0xf0/0xf0
Oct 31 15:19:37 ct523c-2103 kernel:  ? is_bpf_text_address+0x60/0xf0
Oct 31 15:19:37 ct523c-2103 kernel:  ? reacquire_held_locks+0x270/0x270
Oct 31 15:19:37 ct523c-2103 kernel:  _raw_spin_lock_irqsave+0x3f/0x60
Oct 31 15:19:37 ct523c-2103 kernel:  ? down_trylock+0xc/0x40
Oct 31 15:19:37 ct523c-2103 kernel:  down_trylock+0xc/0x40
Oct 31 15:19:37 ct523c-2103 kernel:  ? vprintk_emit+0xcc/0x310
Oct 31 15:19:37 ct523c-2103 kernel:  __down_trylock_console_sem+0x2a/0x90
Oct 31 15:19:37 ct523c-2103 kernel:  console_trylock+0x31/0x80
Oct 31 15:19:37 ct523c-2103 kernel:  vprintk_emit+0xcc/0x310
Oct 31 15:19:37 ct523c-2103 kernel:  ? lockdep_hardirqs_on_prepare+0x200/0x200
Oct 31 15:19:37 ct523c-2103 kernel:  _printk+0xae/0xe0
Oct 31 15:19:37 ct523c-2103 kernel:  ? syslog_print+0x3d0/0x3d0
Oct 31 15:19:37 ct523c-2103 kernel:  ? free_to_partial_list+0x55/0x5b0
Oct 31 15:19:37 ct523c-2103 kernel:  slab_bug+0x65/0xb0
Oct 31 15:19:37 ct523c-2103 kernel:  check_object+0x140/0x310
Oct 31 15:19:37 ct523c-2103 kernel:  free_to_partial_list+0x1ff/0x5b0
Oct 31 15:19:37 ct523c-2103 kernel:  ? qlist_free_all+0x68/0x190
Oct 31 15:19:37 ct523c-2103 kernel:  qlist_free_all+0x6d/0x190
Oct 31 15:19:37 ct523c-2103 kernel:  ? _raw_spin_unlock_irqrestore+0x2b/0x50
Oct 31 15:19:37 ct523c-2103 kernel:  kasan_quarantine_reduce+0x18a/0x1d0
Oct 31 15:19:37 ct523c-2103 kernel:  __kasan_slab_alloc+0x46/0x70
Oct 31 15:19:37 ct523c-2103 kernel:  kmem_cache_alloc+0x111/0x310
Oct 31 15:19:37 ct523c-2103 kernel:  ? mntput_no_expire+0xf0/0x5d0
Oct 31 15:19:37 ct523c-2103 kernel:  ? getname_flags.part.0+0x34/0x240
Oct 31 15:19:37 ct523c-2103 kernel:  ? mark_held_locks+0x24/0x90
Oct 31 15:19:37 ct523c-2103 kernel:  getname_flags.part.0+0x34/0x240
Oct 31 15:19:37 ct523c-2103 kernel:  ? build_open_flags+0x1d9/0x240
Oct 31 15:19:37 ct523c-2103 kernel:  do_sys_openat2+0xc6/0x130
Oct 31 15:19:37 ct523c-2103 kernel:  ? build_open_flags+0x240/0x240
Oct 31 15:19:37 ct523c-2103 kernel:  ? debug_objects_oom+0x220/0x220
Oct 31 15:19:37 ct523c-2103 kernel:  ? lockdep_hardirqs_on_prepare+0x132/0x200
Oct 31 15:19:37 ct523c-2103 kernel:  ? percpu_counter_add_batch+0xd0/0x120
Oct 31 15:19:37 ct523c-2103 kernel:  __x64_sys_openat+0xe0/0x130
Oct 31 15:19:38 ct523c-2103 kernel:  ? __x64_compat_sys_openat+0x130/0x130
Oct 31 15:19:38 ct523c-2103 kernel:  ? __call_rcu_common.constprop.0+0x220/0x480
Oct 31 15:19:38 ct523c-2103 kernel:  ? lockdep_hardirqs_on_prepare+0x132/0x200
Oct 31 15:19:38 ct523c-2103 kernel:  ? syscall_enter_from_user_mode+0x1c/0x50
Oct 31 15:19:38 ct523c-2103 kernel:  do_syscall_64+0x34/0xb0
Oct 31 15:19:38 ct523c-2103 kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
Oct 31 15:19:38 ct523c-2103 kernel: RIP: 0033:0x7fbc6c9018e8
Oct 31 15:19:38 ct523c-2103 kernel: Code: f0 25 00 00 41 00 3d 00 00 41 00 74 45 64 8b 04 25 18 00 00 00 85 c0 75 69 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 
00 0f 05 <48> 3d 00 f0 ff ff 0f 87 8c 00 00 00 48 8b 54 24 28 64 48 2b 14 25
Oct 31 15:19:38 ct523c-2103 kernel: RSP: 002b:00007ffcd6384370 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Oct 31 15:19:38 ct523c-2103 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc6c9018e8
Oct 31 15:19:38 ct523c-2103 kernel: RDX: 0000000000000000 RSI: 00007ffcd6384400 RDI: 00000000ffffff9c
Oct 31 15:19:38 ct523c-2103 kernel: RBP: 00007ffcd6384400 R08: 0000000000000000 R09: 0000000000000073
Oct 31 15:19:38 ct523c-2103 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000562d00eb8ac0
Oct 31 15:19:38 ct523c-2103 kernel: R13: 0000000000000000 R14: 0000000000000020 R15: 000000000001ffc5
Oct 31 15:19:38 ct523c-2103 kernel:  </TASK>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

