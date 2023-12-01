Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911788006D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378048AbjLAJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbjLAJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8DA0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:08 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K3IVUmMnVyMFnaQe84pfrxjuLGE+LEm/Cn/XOYK/p3Y=;
        b=plHHORr3Q1hbSuagkaKych2odMhPvHr0sAgShvz+SDRnCi1+a+ha7oezfqEGj0w1iwwFzm
        rBFmtjtcS8YYCqJmzOHfwXdvhsHc+A5lx5JghmsTmG61JxBRAhKQmZXF0DJndAzNqH36XG
        fWJTpUfCds/QcWfmk9bDO4tYnvbpl/TFauSH31M3Ch54W+3FsItZPxz8k/9H6DitUEgJpJ
        TR2MB28ELLLUvYRHWFeAyzAknGCMbwDRh8mFXteYvyIETs+8z5bqee7UvmujZkQyzMWS0j
        tkxSN0nPq3iuVoEcw8cn7V520Qh7iCBLYJfToSrQYkkARvkOozS4yTSz5kfLog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K3IVUmMnVyMFnaQe84pfrxjuLGE+LEm/Cn/XOYK/p3Y=;
        b=VO1Lr5BWRKLv//lZJ7pRl0pWQ8HqXyPjKU7GaUbzvI3tcapmXNxk00RP82uDRTRrOddR9I
        8i/MHuWesDXasJBQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v9 00/32] timers: Move from a push remote at enqueue to a pull at expiry model
Date:   Fri,  1 Dec 2023 10:26:22 +0100
Message-Id: <20231201092654.34614-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the queue grew because of some additional cleanup patches and splitting
already existing patches to make review easier. Several minor things had to
be reworked. For all people who did testing, I would be really happy if you
could test v9 as well!

The queue contains three parts:

- Patches 1 - 12: Cleanups and minor fixes

- Patches 13 - 16: timer base idle marking rework with two preparatory
  changes. See the section below for more details.

- Patches 17 - 32: Updated timer pull model on top of timer idle rework


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




Anna-Maria Behnsen (29):
  tick-sched: Fix function names in comments
  tick/sched: Cleanup confusing variables
  tick-sched: Warn when next tick seems to be in the past
  tracing/timers: Enhance timer_start tracepoint
  tracing/timers: Add tracepoint for tracking timer base is_idle flag
  timers: Do not IPI for deferrable timers
  timers: Move store of next event into __next_timer_interrupt()
  timers: Clarify check in forward_timer_base()
  timers: Split out forward timer base functionality
  timers: Use already existing function for forwarding timer base
  timers: Fix nextevt calculation when no timers are pending
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

Thomas Gleixner (1):
  timers: Rework idle logic

 include/linux/cpuhotplug.h             |    1 +
 include/linux/timer.h                  |   16 +-
 include/trace/events/timer.h           |   40 +-
 include/trace/events/timer_migration.h |  297 +++++
 kernel/time/Makefile                   |    3 +
 kernel/time/tick-internal.h            |   14 +
 kernel/time/tick-sched.c               |   89 +-
 kernel/time/timer.c                    |  562 ++++++--
 kernel/time/timer_migration.c          | 1662 ++++++++++++++++++++++++
 kernel/time/timer_migration.h          |  144 ++
 kernel/workqueue.c                     |    2 +-
 11 files changed, 2680 insertions(+), 150 deletions(-)
 create mode 100644 include/trace/events/timer_migration.h
 create mode 100644 kernel/time/timer_migration.c
 create mode 100644 kernel/time/timer_migration.h

-- 
2.39.2

