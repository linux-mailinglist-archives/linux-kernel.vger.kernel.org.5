Return-Path: <linux-kernel+bounces-26097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55A82DB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029181C21B89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E31775E;
	Mon, 15 Jan 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlrbNIyM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ePDnipz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767F17735
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HL8/FIrmak+PbgDcxh0XefuJmF2bYuW9UqqPFeIrMP8=;
	b=AlrbNIyMB+XttPoxGJq1+UgJDq31jjd81BVzR4LWHehavqbVQaqMHU0+PRexuUUIv5BaYa
	FARbSJHSPct3jP1cA+E+hDV2wyKeWWJVzq79bXbgklVjJm35LxfJu5Fy0xkl0cQztZ/GoJ
	uxBvrqGqOe76bDwcLIWH5vno2HQPUQWTwPmiCDo4y2G33XxCw4K4tDJ941cGs7rUSPBn1a
	w+nxfBczTRNFUMYz1htrN47QlHo0p3tyhSxxMvfPH9BCnaTfcwhZWB7lCcbU0jF7IJ11iT
	riqTKp58P7Do/n4sjur/17POcUcF5dea3v83dkTZd7XsZJPehUvdp02djEpXWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HL8/FIrmak+PbgDcxh0XefuJmF2bYuW9UqqPFeIrMP8=;
	b=7ePDnipzXAYHOaGmIbZXlm93xRCdacqTBZu9lJwQJbvj6WUerqH0sBopz+rd4NBVhfRdrZ
	cHGY2CvowbntV4Bg==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v10 00/20] timers: Move from a push remote at enqueue to a pull at expiry model
Date: Mon, 15 Jan 2024 15:37:23 +0100
Message-Id: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

the cleanup patches are already applied and so the contains only two parts:

- Patches 1 - 4: timer base idle marking rework with two preparatory
  changes. See the section below for more details.

- Patches 5 - 20: Updated timer pull model on top of timer idle rework


The queue is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel timers/pushpull


Move marking timer bases as idle into tick_nohz_stop_tick()
-----------------------------------------------------------

The idle marking of timer bases is done in get_next_timer_interrupt()
whenever possible. The timer bases are idle, even if the tick will not be
stopped. This lead to an IPI when a new first timer is enqueued remote. To
prevent this, setting timer_base->in_idle flag is postponed to
tick_nohz_stop_tick().

Furthermore this synchronizes the states of timer base is_idle and
tick_stopped. With the timer pull model in place, also the idle state in
the hierarchy of a CPU is synchronized with the other idle related states.


Timer pull model
----------------

Placing timers at enqueue time on a target CPU based on dubious heuristics
does not make any sense:

 1) Most timer wheel timers are canceled or rearmed before they expire.

 2) The heuristics to predict which CPU will be busy when the timer expires
    are wrong by definition.

So placing the timers at enqueue wastes precious cycles.

The proper solution to this problem is to always queue the timers on the
local CPU and allow the non pinned timers to be pulled onto a busy CPU at
expiry time.

Therefore split the timer storage into local pinned and global timers:
Local pinned timers are always expired on the CPU on which they have been
queued. Global timers can be expired on any CPU.

As long as a CPU is busy it expires both local and global timers. When a
CPU goes idle it arms for the first expiring local timer. If the first
expiring pinned (local) timer is before the first expiring movable timer,
then no action is required because the CPU will wake up before the first
movable timer expires. If the first expiring movable timer is before the
first expiring pinned (local) timer, then this timer is queued into a idle
timerqueue and eventually expired by some other active CPU.

To avoid global locking the timerqueues are implemented as a hierarchy. The
lowest level of the hierarchy holds the CPUs. The CPUs are associated to
groups of 8, which are separated per node. If more than one CPU group
exist, then a second level in the hierarchy collects the groups. Depending
on the size of the system more than 2 levels are required. Each group has a
"migrator" which checks the timerqueue during the tick for remote timers to
be expired.

If the last CPU in a group goes idle it reports the first expiring event in
the group up to the next group(s) in the hierarchy. If the last CPU goes
idle it arms its timer for the first system wide expiring timer to ensure
that no timer event is missed.


Testing
~~~~~~~

Enqueue
^^^^^^^

The impact of wasting cycles during enqueue by using the heuristic in
contrast to always queuing the timer on the local CPU was measured with a
micro benchmark. Therefore a timer is enqueued and dequeued in a loop with
1000 repetitions on a isolated CPU. The time the loop takes is measured. A
quarter of the remaining CPUs was kept busy. This measurement was repeated
several times. With the patch queue the average duration was reduced by
approximately 25%.

	145ns	plain v6
	109ns	v6 with patch queue


Furthermore the impact of residence in deep idle states of an idle system
was investigated. The patch queue doesn't downgrade this behavior.

dbench test
^^^^^^^^^^^

A dbench test starting X pairs of client servers are used to create load on
the system. The measurable value is the throughput. The tests were executed
on a zen3 machine. The base is the tip tree branch timers/core which is
based on a v6.6-rc1.

governor menu

NR	timers/core	pull-model	impact
----------------------------------------------
1	353.19 (0.19)	353.45 (0.30)	0.07%
2	700.10 (0.96)	687.00 (0.20)	-1.87%
4	1329.37 (0.63)	1282.91 (0.64)	-3.49%
8	2561.16 (1.28)	2493.56	(1.76)	-2.64%
16	4959.96 (0.80)	4914.59 (0.64)	-0.91%
32	9741.92 (3.44)	8979.83 (1.13)	-7.82%
64	16535.40 (2.84)	16388.47 (4.02)	-0.89%
128	22136.83 (2.42)	23174.50 (1.43)	4.69%
256	39256.77 (4.48)	38994.00 (0.39)	-0.67%
512	36799.03 (1.83)	38091.10 (0.63)	3.51%
1024	32903.03 (0.86)	35370.70 (0.89)	7.50%


governor teo

NR	timers/core	pull-model	impact
----------------------------------------------
1	350.83 (1.27)	352.45 (0.96)	0.46%
2	699.52 (0.85)	690.10 (0.54)	-1.35%
4	1339.53 (1.99)	1294.71 (2.71)	-3.35%
8	2574.10 (0.76)	2495.46 (1.97)	-3.06%
16	4898.50 (1.74)	4783.06 (1.64)	-2.36%
32	9115.50 (4.63)	9037.83 (1.58)	-0.85%
64	16663.90 (3.80)	16042.00 (1.72)	-3.73%
128	25044.93 (1.11)	23250.03 (1.08)	-7.17%
256	38059.53 (1.70)	39658.57 (2.98)	4.20%
512	36369.30 (0.39)	38890.13 (0.36)	6.93%
1024	33956.83 (1.14)	35514.83 (0.29)	4.59%



Ping Pong Oberservation
^^^^^^^^^^^^^^^^^^^^^^^

During testing on a mostly idle machine a ping pong game could be observed:
a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
where the schedule_timeout() was executed to enqueue the timer comes out of
idle and restarts the timer using schedule_timeout() and goes back to idle
again. This is due to the fair scheduler which tries to keep the task on
the CPU which it previously executed on.




Possible Next Steps
~~~~~~~~~~~~~~~~~~~

Simple deferrable timers are no longer required as they can be converted to
global timers. If a CPU goes idle, a formerly deferrable timer will not
prevent the CPU to sleep as long as possible. Only the last migrator CPU
has to take care of them. Deferrable timers with timer pinned flags needs
to be expired on the specified CPU but must not prevent CPU from going
idle. They require their own timer base which is never taken into account
when calculating the next expiry time. This conversation and required
cleanup will be done in a follow up series.


v9..v10: https://lore.kernel.org/r/20231201092654.34614-1-anna-maria@linutronix.de/
  - Address review Feedback of Bigeasy


v8..v9: https://lore.kernel.org/r/20231004123454.15691-1-anna-maria@linutronix.de
  - Address review feedback
  - Add more minor cleanup fixes
  - fixes inconsistent idle related states


v7..v8: https://lore.kernel.org/r/20230524070629.6377-1-anna-maria@linutronix.de
  - Address review feedback
  - Move marking timer base idle into tick_nohz_stop_tick()
  - Look ahead function to determine possible sleep lenght


v6..v7:
  - Address review feedback of Frederic and bigeasy
  - Change lock, unlock fetch next timer interrupt logic after remote expiry
  - Move timer_expire_remote() into tick-internal.h
  - Add documentation section about "Required event and timerqueue update
    after remote expiry"
  - Fix fallout of kernel test robot


v5..v6:

  - Address review of Frederic Weisbecker and Peter Zijlstra (spelling,
    locking, race in tmigr_handle_remote_cpu())

  - unconditionally set TIMER_PINNED flag in add_timer_on(); introduce
    add_timer() variants which set/unset TIMER_PINNED flag; drop fixing
    add_timer_on() call sites, as TIMER_PINNED flag is set implicitly;
    Fixing workqueue to use add_timer_global() instead of simply
    add_timer() for unbound work.

  - Drop support for siblings to end up in the same level 0 group (could be
    added again in a better way as an improvement later on)

  - Do not send IPI for new first deferrable timers

v4..v5:
  - address review feedback of Frederic Weisbecker
  - fix issue with group timer update after remote expiry

v3..v4:
  - address review feedback of Frederic Weisbecker
  - address kernel test robot fallout
  - Move patch 16 "add_timer_on(): Make sure callers have TIMER_PINNED
    flag" at the begin of the queue to prevent timers to end up in global
    timer base when they were queued using add_timer_on()
  - Fix some comments and typos

v2..v3: https://lore.kernel.org/r/20170418111102.490432548@linutronix.de/
  - Minimize usage of locks by storing data using atomic_cmpxchg() for
    migrator information and information about active cpus.


Thanks,

	Anna-Maria




Anna-Maria Behnsen (18):
  timers: Restructure get_next_timer_interrupt()
  timers: Split out get next timer interrupt
  timers: Move marking timer bases idle into tick_nohz_stop_tick()
  timers: Optimization for timer_base_try_to_set_idle()
  timers: Introduce add_timer() variants which modify timer flags
  workqueue: Use global variant for add_timer()
  timers: add_timer_on(): Make sure TIMER_PINNED flag is set
  timers: Ease code in run_local_timers()
  timers: Split next timer interrupt logic
  timers: Keep the pinned timers separate from the others
  timers: Retrieve next expiry of pinned/non-pinned timers separately
  timers: Split out "get next timer interrupt" functionality
  timers: Add get next timer interrupt functionality for remote CPUs
  timers: Check if timers base is handled already
  timers: Introduce function to check timer base is_idle flag
  timers: Implement the hierarchical pull model
  timer_migration: Add tracepoints
  timers: Always queue timers on the local CPU

Richard Cochran (linutronix GmbH) (2):
  timers: Restructure internal locking
  tick/sched: Split out jiffies update helper function

 MAINTAINERS                            |    1 +
 include/linux/cpuhotplug.h             |    1 +
 include/linux/timer.h                  |   16 +-
 include/trace/events/timer_migration.h |  297 +++++
 kernel/time/Makefile                   |    3 +
 kernel/time/tick-internal.h            |   14 +
 kernel/time/tick-sched.c               |   65 +-
 kernel/time/timer.c                    |  505 +++++--
 kernel/time/timer_migration.c          | 1693 ++++++++++++++++++++++++
 kernel/time/timer_migration.h          |  147 ++
 kernel/workqueue.c                     |    2 +-
 11 files changed, 2629 insertions(+), 115 deletions(-)
 create mode 100644 include/trace/events/timer_migration.h
 create mode 100644 kernel/time/timer_migration.c
 create mode 100644 kernel/time/timer_migration.h

-- 
2.39.2


