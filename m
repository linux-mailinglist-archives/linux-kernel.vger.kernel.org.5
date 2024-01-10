Return-Path: <linux-kernel+bounces-22811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871C82A331
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1370928AC81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C074F5F2;
	Wed, 10 Jan 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rXs0OUXY"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC734F5E9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Jan 2024 16:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704921561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=HI8A04KTA/X8cjMZs3tJddTAJlEEniaOSwHSAydbK/0=;
	b=rXs0OUXYYLiHdHawQZouyW/TkworJnwUjlQLRZDUHklrD4/BunlroYySbOstKS2dzOm9Up
	aOxBtIm0uMIsLO1sAB3C3vCtKUMm5LOqc3m690fCk5e80HkoNAFdtxal50rdxClgRQ49/n
	07u19Y/2Xh3zzw06TtQuPyJfQ1aZe/c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	Will Drewry <wad@chromium.org>, Suren Baghdasaryan <surenb@google.com>
Subject: [GIT PULL] header cleanups for 6.8
Message-ID: <ualbkbj75ulsbwbjuphntw7ztb45r2q7iysvxvklmyv5ndnvh7@zxr56mv33vyv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, here's some header cleanups, as discussed.

Nothing drastic has changed since it was mailed out, wanted to give this
plenty of soak time in -next.

There were two merge conflicts in arch headers in next; they looked
pretty trivial. But now I'm wondering - do we have standard
tools/process for recording what the merge conflict and resolution were?
I'm sure we must.

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/header_cleanup-2024-01-10

for you to fetch changes up to 1e2f2d31997a9496f99e2b43255d6a48b06fbcc2:

  Kill sched.h dependency on rcupdate.h (2023-12-27 11:50:20 -0500)

----------------------------------------------------------------
header cleanups for 6.8

The goal is to get sched.h down to a type only header, so the main thing
happening in this patchset is splitting out various _types.h headers and
dependency fixups, as well as moving some things out of sched.h to
better locations.

This is prep work for the memory allocation profiling patchset which
adds new sched.h interdepencencies.

Testing - it's been in -next, and fixes from pretty much all
architectures have percolated in - nothing major.

----------------------------------------------------------------
Kent Overstreet (49):
      drivers/gpu/drm/i915/i915_memcpy.c: fix missing includes
      media: vidtv: fix missing include
      x86: fix missing includes/forward declarations
      m68k: Fix missing include
      microblaze: add missing forward declaration
      task_stack.h: add missing include
      nsproxy.h: add missing include
      kernel/fork.c: add missing include
      kmsan: add missing types.h dependency
      time_namespace.h: fix missing include
      PM: fix missing rculist.h dependency
      torture: add missing dependency on hrtimer.h
      nodemask: Split out include/linux/nodemask_types.h
      prandom: Remove unused include
      timekeeping: Kill percpu.h dependency
      arm64: Fix circular header dependency
      kernel/numa.c: Move logging out of numa.h
      sched.h: Move (spin|rwlock)_needbreak() to spinlock.h
      ktime.h: move ktime_t to types.h
      hrtimers: Split out hrtimer_types.h
      locking/mutex: split out mutex_types.h
      posix-cpu-timers: Split out posix-timers_types.h
      locking/seqlock: Split out seqlock_types.h
      pid: Split out pid_types.h
      sched.h: move pid helpers to pid.h
      plist: Split out plist_types.h
      rslib: kill bogus dependency on list.h
      timerqueue: Split out timerqueue_types.h
      signal: Kill bogus dependency on list.h
      timers: Split out timer_types.h
      workqueue: Split out workqueue_types.h
      shm: Slim down dependencies
      ipc: Kill bogus dependency on spinlock.h
      Split out irqflags_types.h
      mm_types_task.h: Trim dependencies
      syscall_user_dispatch.h: split out *_types.h
      x86/signal: kill dependency on time.h
      uapi/linux/resource.h: fix include
      refcount: Split out refcount_types.h
      seccomp: Split out seccomp_types.h
      uidgid: Split out uidgid_types.h
      sem: Split out sem_types.h
      lockdep: move held_lock to lockdep_types.h
      restart_block: Trim includes
      rseq: Split out rseq.h from sched.h
      preempt.h: Kill dependency on list.h
      Kill unnecessary kernel.h include
      kill unnecessary thread_info.h include
      Kill sched.h dependency on rcupdate.h

Matthew Wilcox (Oracle) (1):
      wait: Remove uapi header file from main header file

Randy Dunlap (1):
      LoongArch: signal.c: add header file to fix build error

 arch/arm64/include/asm/spectre.h             |   4 +-
 arch/arm64/kernel/ptrace.c                   |   1 +
 arch/loongarch/kernel/signal.c               |   1 +
 arch/m68k/include/asm/processor.h            |   1 +
 arch/microblaze/include/asm/pgtable.h        |   1 +
 arch/parisc/mm/init.c                        |   1 +
 arch/powerpc/kernel/interrupt.c              |   1 +
 arch/powerpc/kvm/book3s_64_vio.c             |   1 +
 arch/s390/kernel/signal.c                    |   1 +
 arch/x86/include/asm/current.h               |   1 +
 arch/x86/include/asm/debugreg.h              |   1 +
 arch/x86/include/asm/fpu/types.h             |   2 +
 arch/x86/include/asm/paravirt.h              |   4 +
 arch/x86/include/asm/paravirt_types.h        |   2 +
 arch/x86/include/asm/percpu.h                |   2 +-
 arch/x86/include/asm/preempt.h               |   1 -
 arch/x86/include/uapi/asm/signal.h           |   1 -
 arch/x86/kernel/fpu/bugs.c                   |   1 +
 arch/x86/kernel/signal.c                     |   1 +
 arch/x86/lib/cache-smp.c                     |   1 +
 arch/x86/um/sysrq_64.c                       |   1 +
 drivers/base/power/runtime.c                 |   1 +
 drivers/gpu/drm/i915/i915_memcpy.c           |   2 +
 drivers/gpu/drm/lima/lima_ctx.c              |   1 +
 drivers/irqchip/irq-gic-v4.c                 |   1 +
 drivers/media/test-drivers/vidtv/vidtv_pes.c |   1 +
 drivers/target/target_core_xcopy.c           |   1 +
 fs/exec.c                                    |   1 +
 include/linux/audit.h                        |   1 +
 include/linux/dma-fence.h                    |   1 +
 include/linux/hrtimer.h                      |  46 +---
 include/linux/hrtimer_types.h                |  50 +++++
 include/linux/ipc.h                          |   2 +-
 include/linux/irqflags.h                     |  14 +-
 include/linux/irqflags_types.h               |  22 ++
 include/linux/kmsan_types.h                  |   2 +
 include/linux/ktime.h                        |   8 +-
 include/linux/lockdep.h                      |  57 -----
 include/linux/lockdep_types.h                |  57 +++++
 include/linux/mm_types_task.h                |   5 +-
 include/linux/mutex.h                        |  52 +----
 include/linux/mutex_types.h                  |  71 ++++++
 include/linux/nodemask.h                     |   2 +-
 include/linux/nodemask_types.h               |  10 +
 include/linux/nsproxy.h                      |   1 +
 include/linux/numa.h                         |  19 +-
 include/linux/pid.h                          | 140 ++++++++++--
 include/linux/pid_types.h                    |  16 ++
 include/linux/plist.h                        |  12 +-
 include/linux/plist_types.h                  |  17 ++
 include/linux/posix-timers.h                 |  69 +-----
 include/linux/posix-timers_types.h           |  80 +++++++
 include/linux/prandom.h                      |   1 -
 include/linux/preempt.h                      |   6 +-
 include/linux/rcupdate_wait.h                |  10 +
 include/linux/refcount.h                     |  13 +-
 include/linux/refcount_types.h               |  19 ++
 include/linux/restart_block.h                |   2 +-
 include/linux/resume_user_mode.h             |   1 +
 include/linux/rhashtable-types.h             |   2 +-
 include/linux/rseq.h                         | 131 +++++++++++
 include/linux/rslib.h                        |   1 -
 include/linux/sched.h                        | 325 +++------------------------
 include/linux/sched/signal.h                 |   1 +
 include/linux/sched/task.h                   |   2 +
 include/linux/sched/task_stack.h             |   1 +
 include/linux/seccomp.h                      |  24 +-
 include/linux/seccomp_types.h                |  35 +++
 include/linux/sem.h                          |  10 +-
 include/linux/sem_types.h                    |  13 ++
 include/linux/seqlock.h                      |  79 +------
 include/linux/seqlock_types.h                |  93 ++++++++
 include/linux/shm.h                          |   4 +-
 include/linux/signal.h                       |   1 +
 include/linux/signal_types.h                 |   2 +-
 include/linux/spinlock.h                     |  31 +++
 include/linux/syscall_user_dispatch.h        |   9 +-
 include/linux/syscall_user_dispatch_types.h  |  22 ++
 include/linux/time_namespace.h               |   3 +
 include/linux/timekeeping.h                  |   1 +
 include/linux/timer.h                        |  16 +-
 include/linux/timer_types.h                  |  23 ++
 include/linux/timerqueue.h                   |  13 +-
 include/linux/timerqueue_types.h             |  17 ++
 include/linux/torture.h                      |   1 +
 include/linux/types.h                        |   3 +
 include/linux/uidgid.h                       |  11 +-
 include/linux/uidgid_types.h                 |  15 ++
 include/linux/wait.h                         |   1 -
 include/linux/workqueue.h                    |  16 +-
 include/linux/workqueue_types.h              |  25 +++
 include/uapi/linux/resource.h                |   2 +-
 init/init_task.c                             |   1 +
 ipc/shm.c                                    |   1 +
 ipc/util.h                                   |   1 +
 kernel/Makefile                              |   1 +
 kernel/async.c                               |   5 +-
 kernel/bpf/hashtab.c                         |   1 +
 kernel/exit.c                                |   4 +-
 kernel/fork.c                                |   2 +
 kernel/futex/core.c                          |   1 +
 kernel/futex/requeue.c                       |   1 +
 kernel/futex/waitwake.c                      |   1 +
 kernel/locking/spinlock_debug.c              |   1 +
 kernel/numa.c                                |  26 +++
 kernel/pid_namespace.c                       |   1 +
 kernel/sched/core.c                          |   1 +
 lib/test_rhashtable.c                        |   1 +
 mm/filemap.c                                 |   1 +
 mm/khugepaged.c                              |   1 +
 mm/shmem.c                                   |   1 +
 mm/swapfile.c                                |   1 +
 net/ipv4/fib_trie.c                          |   1 +
 net/netfilter/ipset/ip_set_bitmap_gen.h      |   2 +
 net/netfilter/ipset/ip_set_hash_gen.h        |   1 +
 net/netfilter/ipvs/ip_vs_conn.c              |   1 +
 net/netfilter/ipvs/ip_vs_est.c               |   1 +
 security/selinux/hooks.c                     |   1 +
 security/smack/smack_lsm.c                   |   1 +
 119 files changed, 1063 insertions(+), 775 deletions(-)
 create mode 100644 include/linux/hrtimer_types.h
 create mode 100644 include/linux/irqflags_types.h
 create mode 100644 include/linux/mutex_types.h
 create mode 100644 include/linux/nodemask_types.h
 create mode 100644 include/linux/pid_types.h
 create mode 100644 include/linux/plist_types.h
 create mode 100644 include/linux/posix-timers_types.h
 create mode 100644 include/linux/refcount_types.h
 create mode 100644 include/linux/rseq.h
 create mode 100644 include/linux/seccomp_types.h
 create mode 100644 include/linux/sem_types.h
 create mode 100644 include/linux/seqlock_types.h
 create mode 100644 include/linux/syscall_user_dispatch_types.h
 create mode 100644 include/linux/timer_types.h
 create mode 100644 include/linux/timerqueue_types.h
 create mode 100644 include/linux/uidgid_types.h
 create mode 100644 include/linux/workqueue_types.h
 create mode 100644 kernel/numa.c

