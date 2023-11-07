Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A717E467C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjKGQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjKGQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:58:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A493
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pi14+M8YZTs7ZpFURF2MntpNytBNcRUCua0Q2SosK3w=; b=RqbX9Y7dK12OYwfJn84pkfmpQN
        p4TyalJVGp3A8U43RL03GojXOCIdottKT9RJy/TPkByrl0Ac6nH2JFkp96DTfXIhxNJuUKLY5W81I
        TgzQ6g6An7gQrxB27MdImUr00Pqqx5/wb/bnaemp0/OohgdJ5uiXaa3Mub3X/Pqn6gaEXGo1ew9O9
        H4tz7yN2GCzA+Mn79xY6+rRgnBzYc+a7Ntek49uhET9ZXyJVZAEANwIkUwzq05WWGTB/2bYP+cQgz
        0vi1RTTkA4ReqZrtQ5XoVbc2fMXzh+t20MQHEL45kQDIq4p8gOF1wlnKS9SgFBsY1xMw3JWinIY8v
        8p8CV23w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0PPN-00C9Rr-1O;
        Tue, 07 Nov 2023 16:58:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19B0030049D; Tue,  7 Nov 2023 17:58:33 +0100 (CET)
Date:   Tue, 7 Nov 2023 17:58:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Bai, Shuangpeng" <baisp@psu.edu>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: KASAN slab-use-after-free in __lock_acquire
Message-ID: <20231107165833.GB8262@noisy.programming.kicks-ass.net>
References: <SA0PR02MB7276F5C039350B2CA1532773BFA7A@SA0PR02MB7276.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR02MB7276F5C039350B2CA1532773BFA7A@SA0PR02MB7276.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 07:22:31PM +0000, Bai, Shuangpeng wrote:
> Dear Kernel Maintainers,
> 
> We found a new kernel bug. Please see the details below.
> 
> A slab-use-after-free bug can be triggered when kernel dereferences a task pointer that has been freed in function delayed_put_task_struct before.
> I'm sorry for bothering you if this bug is not related to you. I will appreciate if you help me find the person responsible. Thank you!
> 
> Kenrel commit: 8bc9e6515183935fa0cccaf67455c439afe4982b (recent upstream)
> Kernel config: attachment
> C/Syz reproducer: attachment
> 
> [  314.465397][    C1] ==================================================================
> [ 314.467080][ C1] BUG: KASAN: slab-use-after-free in __lock_acquire (kernel/locking/lockdep.c:5004)
> [  314.469666][    C1] Read of size 8 at addr ffff88801bd9ad08 by task systemd-udevd/8228
> [  314.471271][    C1]
> [  314.471719][    C1] CPU: 1 PID: 8228 Comm: systemd-udevd Not tainted 6.6.0-06824-g8bc9e6515183 #4
> [  314.473512][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  314.475321][    C1] Call Trace:
> [  314.475991][    C1]  <IRQ>
> [ 314.476576][ C1] dump_stack_lvl (lib/dump_stack.c:107)
> [ 314.478518][ C1] print_report (mm/kasan/report.c:365 mm/kasan/report.c:475)
> [ 314.479423][ C1] ? __virt_addr_valid (arch/x86/mm/physaddr.c:66)
> [ 314.480440][ C1] ? __phys_addr (arch/x86/mm/physaddr.c:32 (discriminator 4))
> [ 314.481348][ C1] ? __lock_acquire (kernel/locking/lockdep.c:5004)
> [ 314.482328][ C1] kasan_report (mm/kasan/report.c:590)
> [ 314.483164][ C1] ? __lock_acquire (kernel/locking/lockdep.c:5004)
> [ 314.484185][ C1] __lock_acquire (kernel/locking/lockdep.c:5004)
> [ 314.485199][ C1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4992)
> [ 314.486418][ C1] ? lockdep_unlock (kernel/locking/lockdep.c:157)
> [ 314.487390][ C1] ? __lock_acquire (kernel/locking/lockdep.c:186 kernel/locking/lockdep.c:3872 kernel/locking/lockdep.c:5136)
> [ 314.488411][ C1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718)
> [ 314.489329][ C1] ? try_to_wake_up (kernel/sched/core.c:4049 kernel/sched/core.c:4228)
> [ 314.490296][ C1] ? lock_sync (kernel/locking/lockdep.c:5721)
> [ 314.491182][ C1] ? __lock_acquire (./arch/x86/include/asm/bitops.h:228 ./arch/x86/include/asm/bitops.h:240 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3780 kernel/locking/lockdep.c:3836 kernel/locking/lockdep.c:5136)
> [ 314.492196][ C1] ? _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162)
> [ 314.493263][ C1] ? nilfs_segctor_zeropad_segsum (fs/nilfs2/segment.c:2441)
> [ 314.494511][ C1] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 314.495579][ C1] ? try_to_wake_up (kernel/sched/core.c:4049 kernel/sched/core.c:4228)
> [ 314.496572][ C1] try_to_wake_up (kernel/sched/core.c:4049 kernel/sched/core.c:4228)
> [ 314.497480][ C1] ? sched_ttwu_pending (kernel/sched/core.c:4196)
> [ 314.498493][ C1] ? do_raw_spin_unlock (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 ./include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140)
> [ 314.499518][ C1] ? nilfs_segctor_zeropad_segsum (fs/nilfs2/segment.c:2441)
> [ 314.500737][ C1] call_timer_fn (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/timer.h:127 kernel/time/timer.c:1701)

For some reason the backtrace fails to mention which timer function is
called. Having that would be helpful.
