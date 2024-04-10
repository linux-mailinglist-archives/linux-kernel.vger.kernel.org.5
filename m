Return-Path: <linux-kernel+bounces-138866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFF89FBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81CDB297CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D316E87F;
	Wed, 10 Apr 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh7bbOFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBC16D30E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762595; cv=none; b=Or3bQK5QECMVUcKw4ksh6oM2gXlBRERlv7PBLDfotj/n/LiTyXTw9jg65oy3SJbJ3aOjF9tyR2HKyCHo1uPmJM2iC0NkcVXS+L0cSVUlKTb9UqMF0MupeE8pVOMG+5kHI1XS/8LXse6xSY3OXz0hHOWhA9iy3D7PI/zLnqFFmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762595; c=relaxed/simple;
	bh=qong20A2q8VuJFceVdjuzWHoeVW8ztpf3kivweA1hjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeVSUozkFU0w4IrIDP4fSIytBuNIefVTrMjPQQqy/o+j1OL/xFt+zEs2le8sC4Oi/na/dOAzE4ddfLI9YbC8vCIJ8GUWOdiW6lEmZ3csPK6twGQxFP4a9h921CtnW4n2IrDUva7I3Q+8ZQMfZH+HWVtwjoS2Cgb0GqpaPC+ow/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh7bbOFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BCDC433C7;
	Wed, 10 Apr 2024 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712762594;
	bh=qong20A2q8VuJFceVdjuzWHoeVW8ztpf3kivweA1hjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jh7bbOFpXM1Lxz2NQS37GnYcPpzq2E7dOfRc3hgWgcpfX0hPh6bsDDGDdNE9GkYqx
	 RHduVY4RPISLjitQwrS7TtMa30PWDCdHVlWog64NmKwUOwA2zD5OmRAZRQFASNCNTE
	 6c0djUvrpdmeCRkQoTjM8ghqkd+R+psFH6mWWMVgBlkTkpOwemP7iHbBrcE1ajS8AI
	 Vd9hFEv9+p4HKu0HTl9suh5Qv/40oQH5zePwaUxJo2zUNowELSP2QtyplVCvzWcw+w
	 gQS9n3NYIpMBAMcLRUFbxmjeLW3pl7uop3MkQXqoUPdiH9fep7Ot/NSV92uuGEsHoq
	 +JqfuG9oPCE/Q==
Date: Wed, 10 Apr 2024 16:23:08 +0100
From: Will Deacon <will@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, mic@digikod.net,
	keescook@chromium.org, davidgow@google.com, rmoar@google.com
Cc: lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
	anders.roxell@linaro.org, dan.carpenter@linaro.org, arnd@arndb.de,
	linux@roeck-us.net,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
Message-ID: <20240410152307.GA25111@willie-the-truck>
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410102710.35911-1-naresh.kamboju@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> Following kernel crash noticed on Linux next-20240410 tag while running
> kunit testing on qemu-arm64 and qemu-x86_64.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Crash log on qemu-arm64:
> ----------------
> <3>[ 30.465716] BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
> <3>[   30.467097] Write of size 4 at addr 0000000000000008 by task swapper/0/1
> <3>[   30.468059]
> <3>[   30.468393] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B            N 6.9.0-rc3-next-20240410 #1
> <3>[   30.469209] Hardware name: linux,dummy-virt (DT)
> <3>[   30.469645] Call trace:
> <3>[ 30.469919] dump_backtrace (arch/arm64/kernel/stacktrace.c:319) 
> <3>[ 30.471622] show_stack (arch/arm64/kernel/stacktrace.c:326) 
> <3>[ 30.472124] dump_stack_lvl (lib/dump_stack.c:117) 
> <3>[ 30.472947] print_report (mm/kasan/report.c:493) 
> <3>[ 30.473755] kasan_report (mm/kasan/report.c:603) 
> <3>[ 30.474524] kasan_check_range (mm/kasan/generic.c:175 mm/kasan/generic.c:189) 
> <3>[ 30.475094] __kasan_check_write (mm/kasan/shadow.c:38) 
> <3>[ 30.475683] _raw_spin_lock_irq (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
> <3>[ 30.476257] wait_for_completion_timeout (kernel/sched/completion.c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:167) 
> <3>[ 30.476909] kunit_try_catch_run (lib/kunit/try-catch.c:86) 
> <3>[ 30.477628] kunit_run_case_catch_errors (lib/kunit/test.c:544) 
> <3>[ 30.478311] kunit_run_tests (lib/kunit/test.c:635) 
> <3>[ 30.478865] __kunit_test_suites_init (lib/kunit/test.c:729 (discriminator 1)) 
> <3>[ 30.479482] kunit_run_all_tests (lib/kunit/executor.c:276 lib/kunit/executor.c:392) 
> <3>[ 30.480079] kernel_init_freeable (init/main.c:1578) 
> <3>[ 30.480747] kernel_init (init/main.c:1465) 
> <3>[ 30.481474] ret_from_fork (arch/arm64/kernel/entry.S:861) 
> <3>[   30.482080] ==================================================================
> <1>[   30.484503] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> <1>[   30.485369] Mem abort info:
> <1>[   30.485923]   ESR = 0x000000009600006b
> <1>[   30.486943]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[   30.487540]   SET = 0, FnV = 0
> <1>[   30.488007]   EA = 0, S1PTW = 0
> <1>[   30.488509]   FSC = 0x2b: level -1 translation fault
> <1>[   30.489150] Data abort info:
> <1>[   30.489610]   ISV = 0, ISS = 0x0000006b, ISS2 = 0x00000000
> <1>[   30.490360]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> <1>[   30.491057]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> <1>[   30.491822] [0000000000000008] user address but active_mm is swapper
> <0>[   30.493008] Internal error: Oops: 000000009600006b [#1] PREEMPT SMP
> <4>[   30.494105] Modules linked in:
> <4>[   30.496244] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B            N 6.9.0-rc3-next-20240410 #1
> <4>[   30.497171] Hardware name: linux,dummy-virt (DT)
> <4>[   30.497905] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> <4>[ 30.498895] pc : _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
> <4>[ 30.499542] lr : _raw_spin_lock_irq (include/linux/atomic/atomic-arch-fallback.h:2172 (discriminator 1) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 1) include/asm-generic/qspinlock.h:111 (discriminator 1) include/linux/spinlock.h:187 (discriminator 1) include/linux/spinlock_api_smp.h:120 (discriminator 1) kernel/locking/spinlock.c:170 (discriminator 1)) 
> 
> <trim>

It's a shame that you have trimmed the register dump here.

> <4>[   30.511022] Call trace:
> <4>[ 30.511437] _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
> <4>[ 30.512013] wait_for_completion_timeout (kernel/sched/completion.c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:167) 
> <4>[ 30.512627] kunit_try_catch_run (lib/kunit/try-catch.c:86) 
> <4>[ 30.513188] kunit_run_case_catch_errors (lib/kunit/test.c:544) 
> <4>[ 30.513801] kunit_run_tests (lib/kunit/test.c:635) 

Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was added
recently, so adding Mickaël to cc.

Will

> <4>[ 30.514674] __kunit_test_suites_init (lib/kunit/test.c:729 (discriminator 1)) 
> <4>[ 30.515259] kunit_run_all_tests (lib/kunit/executor.c:276 lib/kunit/executor.c:392) 
> <4>[ 30.515831] kernel_init_freeable (init/main.c:1578) 
> <4>[ 30.516384] kernel_init (init/main.c:1465) 
> <4>[ 30.516900] ret_from_fork (arch/arm64/kernel/entry.S:861) 
> <0>[ 30.518151] Code: 93407c02 d503201f 2a0003e1 52800022 (88e17e62)
> All code
> ========
>    0:	93407c02 	sxtw	x2, w0
>    4:	d503201f 	nop
>    8:	2a0003e1 	mov	w1, w0
>    c:	52800022 	mov	w2, #0x1                   	// #1
>   10:*	88e17e62 	casa	w1, w2, [x19]		<-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	88e17e62 	casa	w1, w2, [x19]
> <4>[   30.519501] ---[ end trace 0000000000000000 ]---
> <6>[   30.520317] note: swapper/0[1] exited with irqs disabled
> <6>[   30.521355] note: swapper/0[1] exited with preempt_count 1
> <0>[   30.523129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> <2>[   30.524397] SMP: stopping secondary CPUs
> <0>[   30.525553] Kernel Offset: 0x25148d400000 from 0xffff800080000000
> <0>[   30.528341] PHYS_OFFSET: 0x40000000
> <0>[   30.529003] CPU features: 0x0,00000006,8f17bd7c,6766773f
> <0>[   30.530313] Memory Limit: none
> <0>[   30.531319] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> Steps to reproduce:
> ---
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2etdCz631GU6PILJzs8reteba8i/reproducer
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240410/testrun/23381881/suite/log-parser-test/tests/
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2etdCz631GU6PILJzs8reteba8i
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2etdDjlx3eRFhhK9cy2UsEHAXTr
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

