Return-Path: <linux-kernel+bounces-140117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BB8A0B98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC792821BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461201411C7;
	Thu, 11 Apr 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i17jxYgi"
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5013CF91
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825338; cv=none; b=JU0jzrQI985wu6RvNZgCG53aHbGUI3B7mxDo8mkwJWdXxrqtD/7ceeBBbxkhWZmv7aEjorIsNocrIeSOjK7pQGR8Bb8w5nS8cfl6ef7Fw+UTM57kySXsvCw7u5M0qZ5zblXKlXsYFTduLDwNNbpEoxKgF4UgXh1aRPwGQX90aY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825338; c=relaxed/simple;
	bh=cNPRPzzPVIDEkBwqkDKIFXus6AFvCENmDLAccMS4uAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ9TW6ELdG0EV/FRT6CVLplTIjQwQ3AXZLBtbzMFD8io/q7skrTj4pz7MsR7GOL0JMjwBq6KOsgkikUZEVyuk0u966X74KMkWMe/X517xDNfYEYe4ylRxpia+jEPITr1B5rOt0zq6sRtSCy5xmRZyG+avCeR/5lqhoq8H8thXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i17jxYgi; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VFYJX5SKszfQ0;
	Thu, 11 Apr 2024 10:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712825324;
	bh=cNPRPzzPVIDEkBwqkDKIFXus6AFvCENmDLAccMS4uAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i17jxYgiDmpIBmaZ0Q/RxQ7R6ebnNas2za13pzpMglfSs2pVLPZT2pGdEgZEbyqkv
	 4yzMGKyGbTLgS0WvyRjDN73J5/kcFyzBUx+b+oh1WIe4M/QfOixhtRfavO/JU4HEkV
	 UUJGSD6oxNdqTCeGFAYpwpwQFe7kZFuwFpx3b81c=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VFYJW5HTZz146B;
	Thu, 11 Apr 2024 10:48:43 +0200 (CEST)
Date: Thu, 11 Apr 2024 10:48:43 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: David Gow <davidgow@google.com>
Cc: Will Deacon <will@kernel.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, keescook@chromium.org, rmoar@google.com, 
	lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com, 
	anders.roxell@linaro.org, dan.carpenter@linaro.org, arnd@arndb.de, linux@roeck-us.net, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
Message-ID: <20240411.eogh8Ainuema@digikod.net>
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck>
 <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Apr 11, 2024 at 12:25:40PM +0800, David Gow wrote:
> On Wed, 10 Apr 2024 at 23:23, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed on Linux next-20240410 tag while running
> > > kunit testing on qemu-arm64 and qemu-x86_64.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Crash log on qemu-arm64:
> > > ----------------
> > > <3>[ 30.465716] BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > > <3>[   30.467097] Write of size 4 at addr 0000000000000008 by task swapper/0/1
> > > <3>[   30.468059]
> > > <3>[   30.468393] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B            N 6.9.0-rc3-next-20240410 #1
> > > <3>[   30.469209] Hardware name: linux,dummy-virt (DT)
> > > <3>[   30.469645] Call trace:
> > > <3>[ 30.469919] dump_backtrace (arch/arm64/kernel/stacktrace.c:319)
> > > <3>[ 30.471622] show_stack (arch/arm64/kernel/stacktrace.c:326)
> > > <3>[ 30.472124] dump_stack_lvl (lib/dump_stack.c:117)
> > > <3>[ 30.472947] print_report (mm/kasan/report.c:493)
> > > <3>[ 30.473755] kasan_report (mm/kasan/report.c:603)
> > > <3>[ 30.474524] kasan_check_range (mm/kasan/generic.c:175 mm/kasan/generic.c:189)
> > > <3>[ 30.475094] __kasan_check_write (mm/kasan/shadow.c:38)
> > > <3>[ 30.475683] _raw_spin_lock_irq (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > > <3>[ 30.476257] wait_for_completion_timeout (kernel/sched/completion.c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:167)
> > > <3>[ 30.476909] kunit_try_catch_run (lib/kunit/try-catch.c:86)
> > > <3>[ 30.477628] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > > <3>[ 30.478311] kunit_run_tests (lib/kunit/test.c:635)
> > > <3>[ 30.478865] __kunit_test_suites_init (lib/kunit/test.c:729 (discriminator 1))
> > > <3>[ 30.479482] kunit_run_all_tests (lib/kunit/executor.c:276 lib/kunit/executor.c:392)
> > > <3>[ 30.480079] kernel_init_freeable (init/main.c:1578)
> > > <3>[ 30.480747] kernel_init (init/main.c:1465)
> > > <3>[ 30.481474] ret_from_fork (arch/arm64/kernel/entry.S:861)
> > > <3>[   30.482080] ==================================================================
> > > <1>[   30.484503] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> > > <1>[   30.485369] Mem abort info:
> > > <1>[   30.485923]   ESR = 0x000000009600006b
> > > <1>[   30.486943]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > <1>[   30.487540]   SET = 0, FnV = 0
> > > <1>[   30.488007]   EA = 0, S1PTW = 0
> > > <1>[   30.488509]   FSC = 0x2b: level -1 translation fault
> > > <1>[   30.489150] Data abort info:
> > > <1>[   30.489610]   ISV = 0, ISS = 0x0000006b, ISS2 = 0x00000000
> > > <1>[   30.490360]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> > > <1>[   30.491057]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > <1>[   30.491822] [0000000000000008] user address but active_mm is swapper
> > > <0>[   30.493008] Internal error: Oops: 000000009600006b [#1] PREEMPT SMP
> > > <4>[   30.494105] Modules linked in:
> > > <4>[   30.496244] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B            N 6.9.0-rc3-next-20240410 #1
> > > <4>[   30.497171] Hardware name: linux,dummy-virt (DT)
> > > <4>[   30.497905] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> > > <4>[ 30.498895] pc : _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > > <4>[ 30.499542] lr : _raw_spin_lock_irq (include/linux/atomic/atomic-arch-fallback.h:2172 (discriminator 1) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 1) include/asm-generic/qspinlock.h:111 (discriminator 1) include/linux/spinlock.h:187 (discriminator 1) include/linux/spinlock_api_smp.h:120 (discriminator 1) kernel/locking/spinlock.c:170 (discriminator 1))
> > >
> > > <trim>
> >
> > It's a shame that you have trimmed the register dump here.
> >
> > > <4>[   30.511022] Call trace:
> > > <4>[ 30.511437] _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > > <4>[ 30.512013] wait_for_completion_timeout (kernel/sched/completion.c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:167)
> > > <4>[ 30.512627] kunit_try_catch_run (lib/kunit/try-catch.c:86)
> > > <4>[ 30.513188] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > > <4>[ 30.513801] kunit_run_tests (lib/kunit/test.c:635)
> >
> > Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was added
> > recently, so adding Mickaël to cc.
> >
> 
> Thanks. This looks like a race condition where the KUnit test kthread
> can terminate before we wait on it.
> 
> Mickaël, does this seem like a correct fix to you?
> ---
> From: David Gow <davidgow@google.com>
> Date: Thu, 11 Apr 2024 12:07:47 +0800
> Subject: [PATCH] kunit: Fix race condition in try-catch completion
> 
> KUnit's try-catch infrastructure now uses vfork_done, which is always
> set to a valid completion when a kthread is crated, but which is set to

s/crated/created/

> NULL once the thread terminates. This creates a race condition, where
> the kthread exits before we can wait on it.
> 
> Keep a copy of vfork_done, which is taken before we wake_up_process()
> and so valid, and wait on that instead.
> 
> Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: David Gow <davidgow@google.com>

Minor suggestions, but it looks good. Thanks!

Acked-by: Mickaël Salaün <mic@digikod.net>


> ---
> lib/kunit/try-catch.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index fa687278ccc9..fc6cd4d7e80f 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch
> *try_catch, void *context)
> {
>        struct kunit *test = try_catch->test;
>        struct task_struct *task_struct;
> +       struct completion *task_done;
>        int exit_code, time_remaining;
> 
>        try_catch->context = context;
> @@ -75,13 +76,14 @@ void kunit_try_catch_run(struct kunit_try_catch
> *try_catch, void *context)
>                return;
>        }
>        get_task_struct(task_struct);
> +       task_done = task_struct->vfork_done;
>        wake_up_process(task_struct);

>        /*
>         * As for a vfork(2), task_struct->vfork_done (pointing to the
>         * underlying kthread->exited) can be used to wait for the end of a
>         * kernel thread.

"kernel thread.  It is set to NULL when the thread ends."

>         */

This block comment can now be moved up where task_done is set.

> -       time_remaining = wait_for_completion_timeout(task_struct->vfork_done,
> +       time_remaining = wait_for_completion_timeout(task_done,
>                                                     kunit_test_timeout());
>        if (time_remaining == 0) {
>                try_catch->try_result = -ETIMEDOUT;
> --



