Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665127CC022
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjJQKGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJQKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:06:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF3B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:06:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9c496c114so146365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697537184; x=1698141984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTR8fbqurbQKvcMn+39/oIqGOWGOBBLMJkn/2ft6SHY=;
        b=h4Qoi2uKtGlLGEUkkLu2m/mk5Zjiz7C52SThwN9Ax2Pq6vsvZk7BQ1tPY2grGNSuyK
         xaIw+s3ndFcscb9Kx9/FqZR5m9MaZS9GMeOlTVExorfrCrh3Dc6yaK9PcB8IRaB1kx23
         1ShhW3TVvvk//CKDVp+XwBi/wBWtTdovXvdAzEHNG91WNdO/Ov2tRsqbKHLv+dFI0a0q
         xdgG0WqvJwoes0OUrCCAFilEGmwAc6x8X9f9noI47UG/FQE7/mxgoqV5ad2MVZHQM0ne
         Wk0FiIPY+L5Og69Wch5DYNySfXSQgTB1BsQo5dpCuw0NYefqE2gUfGvU9POWT19nlS+M
         wsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537184; x=1698141984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTR8fbqurbQKvcMn+39/oIqGOWGOBBLMJkn/2ft6SHY=;
        b=qjIQPjZpU/OnFYRkTemTeyAvZ+u47HaB9IxjrSwhmZsMNn93QH7C8DjP2fzYhE2RAE
         xmCnHjxrIXOwH4mjW3HaW6xzJFq/y4IFr/Sor46RFrWHo/W06my4U7cGop3MqWL5Vm/s
         Hl77tlfm+DImCoozO6JIlIUoaqm5NAkvVqIetJbFmVoX6mZh/6nzehNqnyO5Ki1yDDUc
         UeQi/2Ux64a/Js3PNnjvYIgDelm3pCu1RrLHfVKO4WepYpFeOIva5Hbm4NxMvwBmvTMy
         bTylOtAn5yBaazHNCuMebJ0iPv0GVm2yC7kSXvcbrQ4W0mx5TWORQ8iAotJR+wGC0pVr
         wMgg==
X-Gm-Message-State: AOJu0YwpiSxwfOtA5cfPUxTdRdoKTBcazd85NqwlZh+1Sx57EREeZnjm
        rxhEAoxsc8Jnn8MoM91LOQzfGpGSK3WA9sUKzKsZCA==
X-Google-Smtp-Source: AGHT+IHPd2XANfy/m0kcP7G1zjcaC+VuqEub6x3U3GFPTNipKTlRJk4f7CrjGA5o6J47bJoIaKF0sj0jCQN1XQ62jRg=
X-Received: by 2002:a17:903:251:b0:1ca:8544:33e9 with SMTP id
 j17-20020a170903025100b001ca854433e9mr158090plh.21.1697537183592; Tue, 17 Oct
 2023 03:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e40a2906072e9567@google.com>
In-Reply-To: <000000000000e40a2906072e9567@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 17 Oct 2023 12:06:12 +0200
Message-ID: <CANp29Y61NUOC1CDOzNs_euoFCG-tX1TGFEfro2PuvBEhGqEC3Q@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
To:     syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is currently causing more than 50% daily crashes on syzbot:

https://syzkaller.appspot.com/upstream/graph/crashes

It began to appear after next-20231004. Judging by the diff between
next-20231003 and next-20231004, it looks like quite a few changes to
kernel/sched were merged in between. Could it be caused by any of
those?

On Sun, Oct 8, 2023 at 8:28=E2=80=AFAM syzbot
<syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D172d36e968000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df532286be4fff=
4b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df78380e4eae53c6=
4125c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/dis=
k-7d730f1b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinu=
x-7d730f1b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/b=
zImage-7d730f1b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com
>
> EEVDF scheduling fail, picking leftmost
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.6.0-rc4-next-20231005-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.0/5232 is trying to acquire lock:
> ffffffff8cab8560 (console_owner){....}-{0:0}, at: console_lock_spinning_e=
nable kernel/printk/printk.c:1855 [inline]
> ffffffff8cab8560 (console_owner){....}-{0:0}, at: console_emit_next_recor=
d kernel/printk/printk.c:2888 [inline]
> ffffffff8cab8560 (console_owner){....}-{0:0}, at: console_flush_all+0x49a=
/0xd50 kernel/printk/printk.c:2960
>
> but task is already holding lock:
> ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0=
x29/0x130 kernel/sched/core.c:558
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #4 (&rq->__lock){-.-.}-{2:2}:
>        _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
>        raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
>        raw_spin_rq_lock kernel/sched/sched.h:1357 [inline]
>        rq_lock kernel/sched/sched.h:1671 [inline]
>        task_fork_fair+0x70/0x240 kernel/sched/fair.c:12399
>        sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4799
>        copy_process+0x4580/0x74b0 kernel/fork.c:2609
>        kernel_clone+0xfd/0x920 kernel/fork.c:2907
>        user_mode_thread+0xb4/0xf0 kernel/fork.c:2985
>        rest_init+0x27/0x2b0 init/main.c:691
>        arch_call_rest_init+0x13/0x30 init/main.c:823
>        start_kernel+0x39f/0x480 init/main.c:1068
>        x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
>        x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
>        secondary_startup_64_no_verify+0x166/0x16b
>
> -> #3 (&p->pi_lock){-.-.}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inli=
ne]
>        _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
>        class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:51=
8 [inline]
>        try_to_wake_up+0xb0/0x15d0 kernel/sched/core.c:4213
>        __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
>        __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
>        tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:69
>        serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.=
c:1842
>        serial8250_handle_irq+0x606/0xbe0 drivers/tty/serial/8250/8250_por=
t.c:1949
>        serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8=
250_port.c:1969
>        serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.=
c:127
>        __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
>        handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>        handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
>        handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:831
>        generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
>        handle_irq arch/x86/kernel/irq.c:238 [inline]
>        __common_interrupt+0xdb/0x240 arch/x86/kernel/irq.c:257
>        common_interrupt+0xa9/0xd0 arch/x86/kernel/irq.c:247
>        asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
>        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 =
[inline]
>        _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:19=
4
>        spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>        uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inlin=
e]
>        serial_port_runtime_resume+0x2ae/0x330 drivers/tty/serial/serial_p=
ort.c:41
>        __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
>        rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
>        rpm_resume+0xdb5/0x1980 drivers/base/power/runtime.c:912
>        pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
>        process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
>        process_scheduled_works kernel/workqueue.c:2703 [inline]
>        worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
>        kthread+0x33c/0x440 kernel/kthread.c:388
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
> -> #2 (&tty->write_wait){-...}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inli=
ne]
>        _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
>        __wake_up_common_lock+0xbb/0x140 kernel/sched/wait.c:137
>        tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:69
>        serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.=
c:1842
>        serial8250_handle_irq+0x606/0xbe0 drivers/tty/serial/8250/8250_por=
t.c:1949
>        serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8=
250_port.c:1969
>        serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.=
c:127
>        __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
>        handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>        handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
>        handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:831
>        generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
>        handle_irq arch/x86/kernel/irq.c:238 [inline]
>        __common_interrupt+0xdb/0x240 arch/x86/kernel/irq.c:257
>        common_interrupt+0xa9/0xd0 arch/x86/kernel/irq.c:247
>        asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
>        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 =
[inline]
>        _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:19=
4
>        spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>        uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inlin=
e]
>        serial_port_runtime_resume+0x2ae/0x330 drivers/tty/serial/serial_p=
ort.c:41
>        __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
>        rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
>        rpm_resume+0xdb5/0x1980 drivers/base/power/runtime.c:912
>        pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
>        process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
>        process_scheduled_works kernel/workqueue.c:2703 [inline]
>        worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
>        kthread+0x33c/0x440 kernel/kthread.c:388
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
> -> #1 (&port_lock_key){-...}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inli=
ne]
>        _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
>        uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
>        serial8250_console_write+0xa7c/0x1060 drivers/tty/serial/8250/8250=
_port.c:3410
>        console_emit_next_record kernel/printk/printk.c:2894 [inline]
>        console_flush_all+0x4d5/0xd50 kernel/printk/printk.c:2960
>        console_unlock+0x10c/0x260 kernel/printk/printk.c:3029
>        vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2304
>        vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
>        _printk+0xc8/0x100 kernel/printk/printk.c:2329
>        register_console+0xb30/0x1210 kernel/printk/printk.c:3535
>        univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.=
c:717
>        console_init+0xba/0x5c0 kernel/printk/printk.c:3681
>        start_kernel+0x25a/0x480 init/main.c:1004
>        x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
>        x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
>        secondary_startup_64_no_verify+0x166/0x16b
>
> -> #0 (console_owner){....}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3868 [inline]
>        __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
>        lock_acquire kernel/locking/lockdep.c:5753 [inline]
>        lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
>        console_lock_spinning_enable kernel/printk/printk.c:1855 [inline]
>        console_emit_next_record kernel/printk/printk.c:2888 [inline]
>        console_flush_all+0x4af/0xd50 kernel/printk/printk.c:2960
>        console_unlock+0x10c/0x260 kernel/printk/printk.c:3029
>        vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2304
>        vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
>        _printk+0xc8/0x100 kernel/printk/printk.c:2329
>        pick_eevdf kernel/sched/fair.c:963 [inline]
>        pick_next_entity kernel/sched/fair.c:5247 [inline]
>        pick_next_task_fair kernel/sched/fair.c:8244 [inline]
>        __pick_next_task_fair+0xe2/0x540 kernel/sched/fair.c:8297
>        __pick_next_task kernel/sched/core.c:6003 [inline]
>        __pick_next_task kernel/sched/core.c:5972 [inline]
>        pick_next_task kernel/sched/core.c:6061 [inline]
>        __schedule+0x38d5/0x5a00 kernel/sched/core.c:6640
>        __schedule_loop kernel/sched/core.c:6753 [inline]
>        schedule+0xe7/0x270 kernel/sched/core.c:6768
>        futex_wait_queue+0xfe/0x1f0 kernel/futex/waitwake.c:369
>        __futex_wait+0x292/0x3c0 kernel/futex/waitwake.c:668
>        futex_wait+0xea/0x380 kernel/futex/waitwake.c:696
>        do_futex+0x227/0x350 kernel/futex/syscalls.c:102
>        __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>        __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>        __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>        do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> other info that might help us debug this:
>
> Chain exists of:
>   console_owner --> &p->pi_lock --> &rq->__lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&rq->__lock);
>                                lock(&p->pi_lock);
>                                lock(&rq->__lock);
>   lock(console_owner);
>
>  *** DEADLOCK ***
>
> 3 locks held by syz-executor.0/5232:
>  #0: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nes=
ted+0x29/0x130 kernel/sched/core.c:558
>  #1: ffffffff8cb989a0 (console_lock){+.+.}-{0:0}, at: console_trylock_spi=
nning kernel/printk/printk.c:1924 [inline]
>  #1: ffffffff8cb989a0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x162/=
0x5f0 kernel/printk/printk.c:2303
>  #2: ffffffff8cb98a10 (console_srcu){....}-{0:0}, at: rcu_lock_acquire in=
clude/linux/rcupdate.h:303 [inline]
>  #2: ffffffff8cb98a10 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmis=
afe include/linux/srcu.h:232 [inline]
>  #2: ffffffff8cb98a10 (console_srcu){....}-{0:0}, at: console_srcu_read_l=
ock kernel/printk/printk.c:286 [inline]
>  #2: ffffffff8cb98a10 (console_srcu){....}-{0:0}, at: console_flush_all+0=
x12a/0xd50 kernel/printk/printk.c:2952
>
> stack backtrace:
> CPU: 1 PID: 5232 Comm: syz-executor.0 Not tainted 6.6.0-rc4-next-20231005=
-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/06/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain kernel/locking/lockdep.c:3868 [inline]
>  __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
>  lock_acquire kernel/locking/lockdep.c:5753 [inline]
>  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
>  console_lock_spinning_enable kernel/printk/printk.c:1855 [inline]
>  console_emit_next_record kernel/printk/printk.c:2888 [inline]
>  console_flush_all+0x4af/0xd50 kernel/printk/printk.c:2960
>  console_unlock+0x10c/0x260 kernel/printk/printk.c:3029
>  vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2304
>  vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
>  _printk+0xc8/0x100 kernel/printk/printk.c:2329
>  pick_eevdf kernel/sched/fair.c:963 [inline]
>  pick_next_entity kernel/sched/fair.c:5247 [inline]
>  pick_next_task_fair kernel/sched/fair.c:8244 [inline]
>  __pick_next_task_fair+0xe2/0x540 kernel/sched/fair.c:8297
>  __pick_next_task kernel/sched/core.c:6003 [inline]
>  __pick_next_task kernel/sched/core.c:5972 [inline]
>  pick_next_task kernel/sched/core.c:6061 [inline]
>  __schedule+0x38d5/0x5a00 kernel/sched/core.c:6640
>  __schedule_loop kernel/sched/core.c:6753 [inline]
>  schedule+0xe7/0x270 kernel/sched/core.c:6768
>  futex_wait_queue+0xfe/0x1f0 kernel/futex/waitwake.c:369
>  __futex_wait+0x292/0x3c0 kernel/futex/waitwake.c:668
>  futex_wait+0xea/0x380 kernel/futex/waitwake.c:696
>  do_futex+0x227/0x350 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex kernel/futex/syscalls.c:160 [inline]
>  __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f7af7e7cae9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7af8af7178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 00007f7af7f9bf88 RCX: 00007f7af7e7cae9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f7af7f9bf88
> RBP: 00007f7af7f9bf80 R08: 00007f7af8af76c0 R09: 00007f7af8af76c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7af7f9bf8c
> R13: 000000000000000b R14: 00007fff1e139c80 R15: 00007fff1e139d68
>  </TASK>
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
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000e40a2906072e9567%40google.com.
