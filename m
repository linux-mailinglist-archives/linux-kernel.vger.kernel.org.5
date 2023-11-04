Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733BB7E0EEE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjKDK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjKDK7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:59:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D67D48
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:59:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57929C433C7;
        Sat,  4 Nov 2023 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699095573;
        bh=Z44CJflOtr1aWOSpGdoxVEyhwROBxLY72GaO/vu6uHU=;
        h=From:To:Cc:Subject:Date:From;
        b=N9sQaMODf/jDs6nHnKQ8YpazdBBlgL10frzc7yy8xtAURNdOu/NsXcDR5+CfJLdcj
         ZFQtFfwbmpmjcSzsPVIiJaHfGri3kL6ffzKBV4VJJU0IPDmq+rHd8kp9lA13JG9MzV
         C5nlqNDfI4U5Of5u02haWFO1T2yT+ECcEDzY6DP5QHVbqm5r4uYDPwSau1Jw2mHxFz
         W17aZWgsPSKcaywLy0b4YY++gtzEAAx9p4zCrJthjFG4+hWEMfxmC8jt0tR10QJ/mm
         wlrOgXsm1QIq+fLyXqHQL75H/ZMJNNehSSAcpqBF9NwwYNqUd7OAFlcyCAt7T91i7c
         YEVEOeijtJoFA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v5 0/7] SCHED_DEADLINE server infrastructure
Date:   Sat,  4 Nov 2023 11:59:17 +0100
Message-Id: <cover.1699095159.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 of Peter's SCHED_DEADLINE server infrastructure
implementation [1].

SCHED_DEADLINE servers can help fixing starvation issues of low priority
tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
cycles. Today we have RT Throttling; DEADLINE servers should be able to
replace and improve that.

In the v1 there was discussion raised about the consequence of using
deadline based servers on the fixed-priority workloads. For a demonstration
here is the baseline of timerlat scheduling latency as-is, with kernel
build background workload:

 # rtla timerlat top -u -d 10m

  --------------------- %< ------------------------
                                     Timer Latency
  0 01:42:24   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #6143559   |        0         0         0        92 |        2         1         3        98 |        4         1         5       100
  1 #6143559   |        1         0         0        97 |        7         1         5       101 |        9         1         7       103
  2 #6143559   |        0         0         0        88 |        3         1         5        95 |        5         1         7        99
  3 #6143559   |        0         0         0        90 |        6         1         5       103 |       10         1         7       126
  4 #6143558   |        1         0         0        81 |        7         1         4        86 |        9         1         7        90
  5 #6143558   |        0         0         0        74 |        3         1         5        79 |        4         1         7        83
  6 #6143558   |        0         0         0        83 |        2         1         5        89 |        3         0         7       108
  7 #6143558   |        0         0         0        85 |        3         1         4       126 |        5         1         6       137
  --------------------- >% ------------------------

And this is the same tests with DL server activating without any delay:
  --------------------- %< ------------------------
  0 00:10:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #579147    |        0         0         0        54 |        2         1        52     61095 |        2         2        56     61102
  1 #578766    |        0         0         0        83 |        2         1        49     55824 |        3         2        53     55831
  2 #578559    |        0         0         1        59 |        2         1        50     55760 |        3         2        54     55770
  3 #578318    |        0         0         0        76 |        2         1        49     55751 |        3         2        54     55760
  4 #578611    |        0         0         0        64 |        2         1        49     55811 |        3         2        53     55820
  5 #578347    |        0         0         1        40 |        2         1        50     56121 |        3         2        55     56133
  6 #578938    |        0         0         1        75 |        2         1        49     55755 |        3         2        53     55764
  7 #578631    |        0         0         1        36 |        3         1        51     55528 |        4         2        55     55541
  --------------------- >% ------------------------

The problem with DL server only implementation is that FIFO tasks might
suffer preemption from NORMAL even when spare CPU cycles are available.
In fact, fair deadline server is enqueued right away when NORMAL tasks
wake up and they are first scheduled by the server, thus potentially
preempting a well behaving FIFO task. This is of course not ideal.

We had discussions about it, and one of the possibilities would be
using a different scheduling algorithm for this. But IMHO that is
an overkill.

Juri and I discussed this and though about delaying the server
activation for the 0-lag time, thus enabling the server only if the
fair scheduler is about to starve.

The patch 6/7 adds the possibility to defer the server start to the
(absolute deadline - runtime) point in time. This is achieved by
enqueuing the dl server throttled, with a next replenishing time
set to activate the server at (absolute deadline - runtime).

Differently from v4, now the server is enqueued with the runtime
replenished. As the fair scheduler runs without boost, its runtime
is consumed. If the fair server has its runtime before the 0-laxity
time, the a new period is set, and the timer armed for the new
(deadline - runtime).

The patch 7/7 add a per_rq interface for the knobs:
	fair_server_runtime (950 ms)
	fair_server_period  (1s)
	fair_server_defer   (enabled)

With defer enabled on CPUs [0:3], the results get better, having a
behavior similar to the one we have with the rt throttling.

  --------------------- %< ------------------------
                                     Timer Latency                                                                                       
  0 00:10:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #599979    |        0         0         0        64 |        4         1         4        67 |        6         1         5        69
  1 #599979    |        0         0         1        17 |        6         1         5        50 |       10         2         7        71
  2 #599984    |        1         0         1        22 |        4         1         5        78 |        5         2         7       107
  3 #599986    |        0         0         1        72 |        7         1         5        79 |       10         2         7        82
  4 #581580    |        1         0         1        37 |        6         1        38     52797 |       10         2        41     52805
  5 #583270    |        1         0         1        41 |        9         1        36     52617 |       12         2        38     52623
  6 #581240    |        0         0         1        25 |        7         1        39     52870 |       11         2        41     52876
  7 #581208    |        0         0         1        69 |        6         1        39     52917 |        9         2        41     52923
  --------------------- >% ------------------------

Here are some osnoise measurement, with osnoise threads running as FIFO:1 with
different setups (defer enabled):
 - CPU 2 isolated
 - CPU 3 isolated shared with a CFS busy loop task
 - CPU 8 non-isolated
 - CPU 9 non-isolated shared with a CFS busy loop task

  --------------------- %< ------------------------
 ~# pgrep ktimer | while read pid; do chrt -p -f 2 $pid; done # for RT kernel
 ~# sysctl kernel.sched_rt_runtime_us=-1
 ~# tuna  isolate -c 2
 ~# tuna  isolate -c 3
 ~# taskset -c 3 ./f &
 ~# taskset -c 9 ./f &
 ~# osnoise -P f:1 -c 2,3,8,9 -T 1 -d 10m -H 1
                                          Operating System Noise
duration:   0 00:10:00 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  2 #599       599000000          178    99.99997          18            2           0            0          270            0            0
  3 #598       598054434     31351553    94.75774      104442       104442           0            0      2837523            0         1794
  8 #599       599000001       567456    99.90526        3260         2375           2           89       620490            0        13539
  9 #598       598021196     31742537    94.69207       71707        53357           0           90      3411023            0         1762
   --------------------- >% ------------------------

the system runs fine!
	- no crashes (famous last words)
	- FIFO property is kept
	- per cpu interface because it is more flexible - and to detach this from
	  the throttling concept.

Global is broken, but it will > /dev/null.

TODO:
  - Move rt throttling code to RT_GROUP_SCHED for now (then send it to the same
    place as global then).

Changes from V4:
  - Enable the server when nr fair tasks is > 0 (peter)
  - Consume runtime if the zerolax server is not boosted (peterz)
  - Adjust interface to deal with admission control (peterz)
  - Rebased to 6.6
Changes from V3:
  - Add the defer server (Daniel)
  - Add an per rq interface (Daniel with peter's feedback)
  - Add an option not defer the server (for Joel)
  - Typos and 1-liner fixes (Valentin, Luca, Peter)
  - Fair scheduler running on dl server do not account as RT task (Daniel)
  - Changed the condition to enable the server (RT & fair tasks) (Daniel)
Changes from v2:
  - Refactor/rephrase/typos changes
  - Defferable server using throttling
  - The server starts when RT && Fair tasks are enqueued
  - Interface with runtime/period/defer option
Changes from v1:
  - rebased on 6.4-rc1 tip/sched/core

Daniel Bristot de Oliveira (2):
  sched/deadline: Deferrable dl server
  sched/fair: Fair server interface

Peter Zijlstra (5):
  sched: Unify runtime accounting across classes
  sched/deadline: Collect sched_dl_entity initialization
  sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
  sched/deadline: Introduce deadline servers
  sched/fair: Add trivial fair server

 include/linux/sched.h    |  26 +-
 kernel/sched/core.c      |  23 +-
 kernel/sched/deadline.c  | 671 ++++++++++++++++++++++++++++-----------
 kernel/sched/debug.c     | 202 ++++++++++++
 kernel/sched/fair.c      |  87 ++++-
 kernel/sched/rt.c        |  15 +-
 kernel/sched/sched.h     |  56 +++-
 kernel/sched/stop_task.c |  13 +-
 8 files changed, 847 insertions(+), 246 deletions(-)

-- 
2.40.1

