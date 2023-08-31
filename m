Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55E78F3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbjHaU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbjHaU33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:29:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71AA1B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BA65B823BA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A64C433C7;
        Thu, 31 Aug 2023 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513759;
        bh=3DZeqZAK3HrQQiW1eLZwWR+iejBCJjE1OexsfaEhfCg=;
        h=From:To:Cc:Subject:Date:From;
        b=YskJYLVKFQ//RITPKFEk/MLZ8Y2/BrojxzMKKlsuafNwcly+0k6aQFQagjSe5Auo4
         jaiXmlJPu2Z5jcEjPA7kxsAHgd+73lboSSg8ewNnKBkWEOya9NaJoe0odwRbgSgym4
         1Vt42c5DrYiCPc+TFi8Y6mcGm8rCIMsy0sDPkfSjw2xeruSo9s9r3wPEjrxFWVm/ys
         LzB74v83HhUSmyrOIFxFtmdYtKIbu+pWia2oj9aTZYQMjBML9WJ7l8pxKXEQpl3ABF
         ef1WEmDW1CFk43+og8I7cyiufGn2Oelq4KonWvAwVGYxf/S9I+yeuf9YRG8XYOynmB
         EizONw9m9xijA==
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
Subject: [PATCH v4 0/7] SCHED_DEADLINE server infrastructure
Date:   Thu, 31 Aug 2023 22:28:51 +0200
Message-Id: <cover.1693510979.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 of Peter's SCHED_DEADLINE server infrastructure
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
activation for the 0-lag time, thus enabling the server only
if the fair scheduler is about to starve.

The patch 6/7 adds the possibility to defer the server start
to the (absolute deadline - runtime) point in time. This is
achieved by enqueuing the dl server throttled, with a next
replenishing time set to activate the server at
(absolute deadline - runtime).

The patch 7/7 add a per_rq interface for the knobs:
	fair_server_runtime (950 ms)
	fair_server_period  (1s)
	fair_server_defer   (enabled)

With defer enabled on CPUs [0:3], the results get better,
having a behavior similar to the one we have with the rt
throttling.
  --------------------- %< ------------------------
  0 00:10:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  0 #600003    |        0         0         0        34 |        6         1         5        75 |       10         2         7       108
  1 #600003    |        1         0         1        38 |        9         1         6        96 |       14         2         9       144
  2 #600005    |        1         0         1        85 |       10         1         6        94 |       14         2         9       120
  3 #600006    |        0         0         1        72 |        8         1         6       103 |       13         2         9       108
  4 #600005    |        1         0         1        61 |       10         1         6       110 |       14         2         9       126
  5 #578569    |        0         0         0        65 |       13         1        49     55962 |       20         2        54     55974
  6 #578852    |        0         0         0        56 |        5         1        48     55559 |        9         2        53     55568
  7 #578710    |        0         0         0        91 |       10         1        49     55773 |       16         2        53     55786
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
  2 #599       599000000            3    99.99999           2            1           3            0            0            0            0
  3 #598       598001768     31188796    94.78449       53907        53907           0            0      2842602            0         2394
  8 #599       599000000       918224    99.84670        1735           36           0           88       615903            0        37958
  9 #598       598000000     31441197    94.74227       53875        53448           0           88      3417253            0         1364
   --------------------- >% ------------------------

the system runs fine!
	- no crashes (famous last words)
	- FIFO property is kept
	- per cpu interface because it is more flexible - and to detach this from
	  the throttling concept.

Global is broken, but it will > /dev/null.

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

 include/linux/sched.h    |  31 ++-
 kernel/sched/core.c      |  23 +-
 kernel/sched/deadline.c  | 555 ++++++++++++++++++++++++++-------------
 kernel/sched/debug.c     | 177 +++++++++++++
 kernel/sched/fair.c      |  92 ++++++-
 kernel/sched/rt.c        |  21 +-
 kernel/sched/sched.h     |  64 ++++-
 kernel/sched/stop_task.c |  13 +-
 8 files changed, 737 insertions(+), 239 deletions(-)

-- 
2.40.1

