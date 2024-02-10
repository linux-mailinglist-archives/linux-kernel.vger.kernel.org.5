Return-Path: <linux-kernel+bounces-60178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40F850112
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C661F2A940
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FCA28;
	Sat, 10 Feb 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOjQouMt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3A365
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524619; cv=none; b=XtFIZCu2nLaQZh4cvE5Ry0/LG2FUnhNvvQXe2cChAb+TPmht+nqIUFtuS91nkRYAz/9njNwSji7K1NfkHm1VzvMPbM6s1IPQ6FfGwztdivQJIdzK5+ew2KsBS/B1UMWQ8u5Ylxok0v3XOry5VSyuMD7sRXo2sOklaBscKa5OLM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524619; c=relaxed/simple;
	bh=vT6pceY5FwfrwD/otpewURN85d7YkaAvyBFynPoyY1c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HNAPwdVzH9cvfBQKhtLfX2XU/3+dQHi1PvfeJVpJ1faRGf1vCQjXPMz/ei8rcbE9sSce3Pt/pEFoCvQmWKyfKX7Cg0naaIFr/S0QFO2nncevDKFHVB8nqrJEp8d7bZiTK3iqopcB4FqFSrV21RZ50AK7pW43dutr22F1rVsHWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOjQouMt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74897c041so2141678276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707524616; x=1708129416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qcsz5yHj12g5NwTwJahjLXYHuW0vPJbg08cutrYM58=;
        b=dOjQouMtiVIgIooRi8FOiE33uupzLJtwSLWRxc66flvPp4O8XE9FJupk4t0qF8PrL+
         RhNw30QqAq5ON015iLHFLZPyPCZ2PWHgIjJ1xpSPP2j9UZQzrrufJBWRPOOGMjRW+uk8
         QdrW+pvFmJFPyfNrunCev7i14sYC7yXRt1T1Rfm1lcUXhxQDkfDGPimspxsOtw485wUB
         WlgkIAo5SNBUU0FSEKQ9pnqztoubttY9bZzZiY5xtmzEpKm7a6akORXwXC0HvCHYdXqe
         wjOLLtPZ3g3cHN73+ZXJK3UPXFwSekrBSK7RbWOkfx0sfVPDAmP0JaLffM3BCgJ2/Cza
         PpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524616; x=1708129416;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qcsz5yHj12g5NwTwJahjLXYHuW0vPJbg08cutrYM58=;
        b=ancUiwaj5QSqjOelrnVkc/cJufa+eNUQ5COis3ZBOrR0zB5YeGpGMHFQ8nTdXgTZWl
         m4n1d7U8aFX50Oax4tyJnkraIdAbj9jYQvp2xsWGxasCMcVoWY2jP559E1cVQc7bZ6yp
         YWUK/3fVf67h1opRPieALjxa8Fs9EAKX/3zUpc1U/QcdZxF8gHcfvz+HIO59vCZxrpaQ
         LVwoanpt7B72LO788VS9kEytyUq0awdfV7H6YHhpuQXnLKIO2kdWyhzN3acZRljCF4Sd
         +Xz6E+rty4FaXSwonk+EuBN+PifrpuWLpNYTr7zZYLxWSghdGjK9YmIRjoiJMM2Vdh5p
         vHJQ==
X-Gm-Message-State: AOJu0Yx/3dWlcLXf1iJf+jlUxAjSWZNEKLja400BaYyMKEuH31qrovfi
	K0P+7DbTAD6GCGuZSmZhCzI28tDf5OGV3/qqApnvZRBgo31aPG6VuMu+U9xk362T2/gIFPNVZyi
	QpsFLfPRKhXmjLqgv+B1ZBApv4I3SFL251HE+dS8GhjRtVhceSq2/AOQv7sUbgODP4erUPBjrBo
	QwExcfzcDzhVBloy9Wx0pHO5tNY7XdsPq9yPBamvFHALvF
X-Google-Smtp-Source: AGHT+IE0RAEDeuiZ0IkaEm2k8kB7+9CvNlUKRQKJIOO7MRgw+bCGYzypP2c6uZ6n21sdne/wB6DgW+QR7HmY
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:e8d:b0:dc6:dc0a:1ff0 with SMTP id
 dg13-20020a0569020e8d00b00dc6dc0a1ff0mr19618ybb.12.1707524615577; Fri, 09 Feb
 2024 16:23:35 -0800 (PST)
Date: Fri,  9 Feb 2024 16:23:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240210002328.4126422-1-jstultz@google.com>
Subject: [PATCH v8 0/7] Preparatory changes for Proxy Execution v8
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After sending out v7 of Proxy Execution, I got feedback that the
patch series was getting a bit unwieldy to review, and Qais
suggested I break out just the cleanups/preparatory components of
the patch series and submit them on their own in the hope we can
start to merge the less complex bits and discussion can focus on
the more complicated portions afterwards.

So for the v8 of this series, I=E2=80=99m only submitting those earlier
cleanup/preparatory changes here. However work on the full series
has continued, with some nice progress on the performance front.

If you are interested, the full v8 series, it can be found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v8-6.8-rc=
3
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v8-6.8-rc3

One bit of feedback I got earlier from K Prateek Nayak[1] was
that while the Proxy Execution feature didn=E2=80=99t impact performance
in most benchmarks he tried, it did cause major regressions with
the `perf bench` test, which I isolated down to the patch series
disabling optimistic spinning which has been a long term
performance concern with the change.

I spent some time looking for a way to walk the chain (across
cpus) to see if the runnable owner was actually running, which
would allow us to spin and avoid migrations. However, I realized
that is actually a separate and more difficult problem (ie:
migration avoidance) from simple optimistic spinning (a task
trying to take a mutex where the owner is running). With Proxy
Execution, the main focus is how we effectively boost
*non-running* mutex owners by the blocked tasks. But when the
contended mutex owner is running, we don=E2=80=99t need to do anything
different from the existing optimistic spinning logic.

So I=E2=80=99ve dropped the patches disabling optimistic spinning, and
fixed up some further issues as the change opened some new races
the later Proxy Execution patches weren=E2=80=99t expecting. The results
are looking really good with the perf bench test, which
previously regressed so badly, now seeing very close results
(within 1.5%) with and without Proxy Execution. This alleviates
a major concern I had with the series.

Re-enabling optimistic spinning does open a question about if we
should allow the optimistic spinning=E2=80=99s lock-stealing (instead of
lock-handoff) when the runnable mutex owner is running as a proxy
for a more important task. Ideally we probably want to hand it
back up the chain which has donated the time (to avoid migrating
the chain to the stealer=E2=80=99s cpu), so I have a patch I=E2=80=99m test=
ing
that special cases that situation, but so far in my testing I=E2=80=99m
not seeing any large increase in latencies from the potential
unfairness of lock-stealing. But I=E2=80=99ll be doing more investigation
on this.

New in v8:
---------
* Re-ordered patch set to only submit cleanup & preparatory
  changes, leaving more complicated changes for a future
  submission (suggested by Qais Yousef)

* Lots of spelling fixups and minor changes suggested by Randy
  Dunlap and Metin Kaya

* Cover letter was getting long winded by including boilerplate
  sections, so please see earlier versions of the patch series or
  this LWN article [2] for an overview of the functionality.

* Re-enabled mutex optimistic spinning to resolve a major
  performance regression in earlier versions of the series

* Fixups for races discovered with optimistic spinning=20

* Included trace events patch from Metin to better help us
  analyze the costs of proxying.

* Extended sched_football to use rtmtuexes when
  !CONFIG_SCHED_PROXY_EXEC

* Tweaked sched_football to bail if spawned players don=E2=80=99t check
  in within 30s

* Chased down a bug uncovered by sched_football that was
  preventing unconstrained RT tasks from being put on the
  pushable list, causing improper task starvation and
  sched_football failures.

Performance:
---------
With the optimistic spinning re-enabled, the biggest concern I
had wrt performance is much relieved. However, there is still the
potential extra overhead of doing rq migrations/return migrations
for the proxy case. The big hypothesis of this series is that the
overall benefit from unblocking important tasks will well
outweigh any extra cost, but if folks see anything of concern,
I=E2=80=99d love to hear about it.

Issues still to address:
---------
* Enabling optimistic spinning uncovered a few interesting races
  that were much harder to hit in v7. I=E2=80=99ve resolved most of
  these, but there is a case I=E2=80=99ve occasionally seen where the in
  try_to_wakeup(), the blocked_on_state transitions are too lax,
  causing a transition to BO_RUNNABLE when we have not had a
  chance to evaluate for return-migration (allowing tasks to
  potentially run on cpus they shouldn=E2=80=99t). Unfortunately in
  tightening the state handling to be more careful, I=E2=80=99ve run into
  cases where we don=E2=80=99t transition to BO_RUNNABLE, and effectively
  lose the wakeup. I=E2=80=99ve started to suspect the conceptual overlap
  between task->blocked_on_state and task->__state suggests I
  should consider condensing the BO_BLOCKED/BO_WAKING states into
  new task states (ie: TASK_MUTEX_BLOCKED, TASK_PROXY_MIGRATED),
  so we can handle the state transitions more correctly.

* Closer evaluation of pros/cons of doing lock handoff vs
  allowing lock-stealing when proxy tasks release locks.

* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants.

* Xuewen Yan earlier pointed out that we may see task
  mis-placement on EAS systems if we do return migration based
  strictly on cpu allowability. I tried an optimization to always
  try to return migrate to the wake_cpu (which was saved on
  proxy-migration), but this seemed to undo a chunk of the
  benefit I saw in moving return migration back to ttwu, at least
  with my prio-inversion-demo microbenchmark. Need to do some
  broader performance analysis with the variations there.

* It would be nice to find optimization to avoid migrating
  blocked tasks if the runnable lock-owner at the end of the
  blocked_on chain is already running (though this is difficult
  due to the limitations from locking rules needed to traverse
  the blocked on chain across run queues).

* CFS load balancing. There was concern blocked tasks may carry
  forward load (PELT) to the lock owner's CPU, so CPU may look
  like it is overloaded. Needs investigation

* The sleeping owner handling (where we deactivate waiting tasks
  and enqueue them onto a list, then reactivate them when the
  owner wakes up) doesn=E2=80=99t feel great. This is in part because
  when we want to activate tasks, we=E2=80=99re already holding a
  task.pi_lock and a rq_lock, just not the locks for the task
  we=E2=80=99re activating, nor the rq we=E2=80=99re enqueuing it onto. So =
there
  has to be a bit of lock juggling to drop and acquire the right
  locks (in the right order). It feels like there=E2=80=99s got to be a
  better way.

* As discussed at OSPM[3], I=E2=80=99d like to split pick_next_task() up
  into two phases selecting and setting the next tasks, as
  currently pick_next_task() assumes the returned task will be
  run which results in various side-effects in sched class logic
  when it=E2=80=99s run. I tried to take a pass at this earlier, but it=E2=
=80=99s
  hairy and lower on the priority list for now.

Credit/Disclaimer:
=E2=80=94--------------------
As mentioned previously, this Proxy Execution series has a long
history: First described in a paper[4] by Watkins, Straub,
Niehaus, then from patches from Peter Zijlstra, extended with
lots of work by Juri Lelli, Valentin Schneider, and Connor
O'Brien. (and thank you to Steven Rostedt for providing
additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

As always, feedback is always appreciated.

Thanks so much!
-john

[1] https://lore.kernel.org/lkml/c6787831-f659-12cb-4954-fd13a05ed590@amd.c=
om/
[2] https://lwn.net/Articles/934114/
[3] https://youtu.be/QEWqRhVS3lI (video of my OSPM talk)
[4] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com

Connor O'Brien (2):
  sched: Add do_push_task helper
  sched: Consolidate pick_*_task to task_is_pushable helper

John Stultz (2):
  locking/mutex: Remove wakeups from under mutex::wait_lock
  sched: Split out __schedule() deactivate task logic into a helper

Juri Lelli (2):
  locking/mutex: Make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (1):
  sched: Split scheduler and execution contexts

 kernel/locking/mutex.c       |  60 +++++++----------
 kernel/locking/mutex.h       |  25 +++++++
 kernel/locking/rtmutex.c     |  26 +++++---
 kernel/locking/rwbase_rt.c   |   4 +-
 kernel/locking/rwsem.c       |   4 +-
 kernel/locking/spinlock_rt.c |   3 +-
 kernel/locking/ww_mutex.h    |  49 ++++++++------
 kernel/sched/core.c          | 122 +++++++++++++++++++++--------------
 kernel/sched/deadline.c      |  53 ++++++---------
 kernel/sched/fair.c          |  18 +++---
 kernel/sched/rt.c            |  59 +++++++----------
 kernel/sched/sched.h         |  44 ++++++++++++-
 12 files changed, 268 insertions(+), 199 deletions(-)

--=20
2.43.0.687.g38aa6559b0-goog


