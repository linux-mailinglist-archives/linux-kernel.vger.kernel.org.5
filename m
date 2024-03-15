Return-Path: <linux-kernel+bounces-104047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8B887C84A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0846E282BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658ABDF42;
	Fri, 15 Mar 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRf0hc/l"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE02DDA9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477622; cv=none; b=pjT9E/6Lcha2y5Vjp83/kX0Mt/vuWIKW+QKcSXzas/9fjvnFCnYuDyZpkOcT3XoZqHH0W+D1v8tZbx96vOLF47xONd/yhSeUbJ5EZdETa+OP3XzYjfvtcOO7muwQN8BGXwRXM8YMBOSe8inyG+xBBljRKZ3yMBSXS4R9cGEhTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477622; c=relaxed/simple;
	bh=3dw4kv3nugcZVorg+dGsKk8AUoJOLtIANQbd02wBt3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jHMzl0WS5qUs9tAkZFrgCb6gIbhn503vcvhoaaLuvXBAATlNe3Hd3wOUKrPtHFFdWv2w9HcP/mU6v5OS+YR4Og2n+AmdS/3why3LacyTJQZgAzNK8+HnZQIAI4KO1mG7Q/aWqZs5JpVxMGF9BmeryUAIgTDTQOw1Jp68Kw/iMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRf0hc/l; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc3cfa39so25908077b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710477619; x=1711082419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbKP0Y6mUsJJmIGBIqz6+lbeOqoIQSjlgI0yOEiAc8M=;
        b=IRf0hc/lyIhYfnUtXS/9LMT9/Iw/BNL0v/+BWY5DffUg2M4dLF6ZYizZhTgIfoUooB
         bv7Y4ehOFpgQyND+7M1OoS+TozKUbrcb+DYWbpTpIQmDjg92XWgWM8TeqsFuryd0EXLv
         Eg67DGRgfVq5mSOj5EDUwtEyQiKQ3LBXaBEKPo5aODo54Hbg/5oVreGY18mGgIgd1t+c
         Dpaf+Kd567Xo4nKAlF6MxbgmqhfZqP4Qcm3+XUca9fSSg2UKvihikRfRZ4G12SKyzqpZ
         kclkt7ck0AYWpcx4HQU20aTH2l1G9pLT6xRcvi7cj9ovWD3z8VrWUGnNwWj3Jbz6f8CA
         8a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710477619; x=1711082419;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbKP0Y6mUsJJmIGBIqz6+lbeOqoIQSjlgI0yOEiAc8M=;
        b=HGGlZvEWVqy9JsbC+q5T96q4ZBr+p4fC21HLh1iE5ZPzzGD69qA0Mbhk99H3DFn9z/
         Uf32ivpv5/NWFz472cWBd8ok4K0J7dY9mYY9ZJKUZ7XNUPc4ydgHmzEynnacLyhjaWiP
         rDkZpCa7Yl5z0ZBfN8A2kYmU5kBfPV37LWzH4Pc43FNAWQR/B3JI2wcEVKYtWCqlSOf/
         obSYQYPdjrMP4D9XIPyzpRpTMznmHKZOarCuAEB6a8HBJBTCF9y1hjm23KwWNpem7pv/
         ILioRZjkQG4xxeCINtr9S/AW4lzjDu7l3ch9HMqthlC3MijCvPVK+yAzR+ThsFAK3dOB
         yJ2Q==
X-Gm-Message-State: AOJu0YwhFrTz8NQIFcQ3RKK0rIN3E9iMbTSCxM6Q1vdgnTk3OndvUUbh
	kCg7PXhVCns2byBYS89Y5cK4nw9hWHuC2sEJL3HKUESIw9geMv/27u+Ie4R5pMCrMfY2L7Ta0Yr
	OAiupdI3PnU1llGhWLwGdjHsL97lHc6v39uUWXygZIFA5dftvFR11G8OWVtM0n2prw6iBb8mY1Z
	3zlygfKpXb4gu4SVD5D7xXFOPIUPC585bvt329ZymUXyX1
X-Google-Smtp-Source: AGHT+IHdd1lwpiluVuGVbRrghV6qEzZPCztCgpVk1Ar24W5LOEgoRnxyRh5CynnI7t3wIh55th6hwX8VsYII
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:11cc:b0:dc6:dfd9:d431 with SMTP
 id n12-20020a05690211cc00b00dc6dfd9d431mr1100817ybu.1.1710477619235; Thu, 14
 Mar 2024 21:40:19 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:39:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315044007.2778856-1-jstultz@google.com>
Subject: [PATCH v9 0/7] Preparatory changes for Proxy Execution v9
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

As mentioned last time[1], after previous submissions of the
Proxy Execution series, I got feedback that the patch series was
getting a bit unwieldy to review, and Qais suggested I break out
just the cleanups/preparatory components of the patch series and
submit them on their own in the hope we can start to merge the
less complex bits and discussion can focus on the more
complicated portions afterwards. This so far has not been very
successful, with the submission & RESEND of the v8 preparatory
changes not getting much in the way of review.

Nonetheless, for v9 of this series, I=E2=80=99m again only submitting
those early cleanup/preparatory changes here (which have not
changed since the v8 submissions, but to avoid confusion with the
git branch names, I=E2=80=99m labeling it as v9). In the meantime, I=E2=80=
=99ve
continued to put a lot of effort into the full series, mostly
focused on polishing the series for correctness, and fixing some
hard to trip races.

If you are interested, the full v9 series, it can be found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v9-6.8
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v9-6.8


New in v9:
(In the git tree. Again, none of the preparatory patches
submitted here have changed since v8)
---------
* Change to force mutex lock handoff when we have a blocked donor
  (preserves optimistic spinning elsewhere, but still prioritizes
  donor when present on unlock)

* Do return migration whenever we=E2=80=99re not on the wake_cpu (should
  address placement concerns brought up earlier by Xuewen Yan)

* Closed hole where we might mark a task as BO_RUNNABLE without
  doing return migration

* Much improved handling of balance callbacks when we need to
  pick_again

* Fixes for cases where we put_prev_task() but left a dangling
  pointer to rq_selected() when deactivating a task (as it could
  then be migrated away while we still have a reference to it),
  by selecting idle before deactivating next.

* Fixes for dangling references to rq->curr (which had been
  put_prev_task=E2=80=99ed)  when we drop rq lock for proxy_migration

* Fixes for ttwu / find_proxy_task() races if the lock owner was
  being return migrated, and ttwu hadn=E2=80=99t yet set_task_cpu() and
  activated it, which allowed that task to be scheduled on two
  cpus at the same time.

* Fix for live-lock between activate_blocked_tasks() and
  proxy_enqueue_on_owner() if activated owner went right back to
  sleep (which also simplifies the locking in
  activate_blocked_tasks())

* Cleanups to avoid locked BO_WAKING->BO_RUNNABLE transition in
  try_to_wake_up() if proxy execution isn't enabled

* Fix for psi_dequeue, as proxy changes assumptions around
  voluntary sleeps.

* Numerous typos, comment improvements, and other fixups
  suggested by Metin

* And more!


Performance:
---------
K Prateek Nayak provided some feedback on the v8 series here[2].
Given the potential extra overhead of doing rq migrations/return
migrations/etc for the proxy case, it=E2=80=99s not completely surprising
a few of K Prateek=E2=80=99s test cases saw ~3-5% regressions, but I=E2=80=
=99m
hoping to look into this soon to see if we can reduce those
further. The donor mutex handoff in this revision may help some.


Issues still to address:
---------
* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants.

* CFS load balancing. There was concern that blocked tasks may
  carry forward load (PELT) to the lock owner's CPU, so the CPU
  may look like it is overloaded. Needs investigation.

* The sleeping owner handling (where we deactivate waiting tasks
  and enqueue them onto a list, then reactivate them when the
  owner wakes up) doesn=E2=80=99t feel great. This is in part because
  when we want to activate tasks, we=E2=80=99re already holding a
  task.pi_lock and a rq_lock, just not the locks for the task
  we=E2=80=99re activating, nor the rq we=E2=80=99re enqueuing it onto. So =
there
  has to be a bit of lock juggling to drop and acquire the right
  locks (in the right order). It feels like there=E2=80=99s got to be a
  better way. Also needs some rework to get rid of the recursion.


Credit/Disclaimer:
=E2=80=94--------------------
As mentioned previously, this Proxy Execution series has a long
history: First described in a paper[3] by Watkins, Straub,
Niehaus, then from patches from Peter Zijlstra, extended with
lots of work by Juri Lelli, Valentin Schneider, and Connor
O'Brien. (and thank you to Steven Rostedt for providing
additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

Thanks so much!
-john

[1] https://lore.kernel.org/lkml/20240224001153.2584030-1-jstultz@google.co=
m/
[2] https://lore.kernel.org/lkml/c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.c=
om/
[3] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

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

John Stultz (1):
  sched: Split out __schedule() deactivate task logic into a helper

Juri Lelli (2):
  locking/mutex: Make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (2):
  locking/mutex: Remove wakeups from under mutex::wait_lock
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
2.44.0.291.gc1ea87d7ee-goog


