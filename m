Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175A07EC14D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjKOLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjKOLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:33:57 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107C109
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:33:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwSxxJq_1700048021;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwSxxJq_1700048021)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 19:33:50 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sched/core: fix cfs_prio_less
Date:   Wed, 15 Nov 2023 19:33:37 +0800
Message-Id: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update of vruntime snapshot will cause unfair sched, especially when
tasks enqueue/dequeue frequently.

Consider the following case: 
 - Task A1 and A2 share a cookie, and task B has another cookie.
 - A1 is a short task, waking up frequently but running short everytime.
 - A2 and B are long tasks.
 - A1 and B runs on ht0 and A2 runs on ht1.

ht0			ht1		fi_before	fi	update
switch to A1		switch to A2	0		0	1
A1 sleeps
switch to B		A2 force idle	0		1	1
A1 wakes up
switch to A1		switch to A1	1		0	1
A1 sleeps
switch to B		A2 force idle	0		1	1

In this case, cfs_rq->min_vruntime_fi will update every schedule, and
prio of B and A2 will be pulled to the same level, no matter how long A2
and B have run before, which is not fair enough. Extramely, we observed
that the latency of a task became several minutes due to this reason,
which should be 100ms.

To fix this problem, a possible approach is to maintain another vruntime
relative to the core, called core_vruntime, and we compare the priority
of ses using core_vruntime directly, instead of vruntime snapshot. To
achieve this goal, we need to introduce cfs_rq->core, similarity to
rq->core, and record core_min_vruntime in cfs_rq->core.

Cruz Zhao (4):
  sched/core: Introduce core_id
  sched: Introduce cfs_rq->core
  sched: introduce core_vruntime and core_min_vruntime
  fix vruntime snapshot

 include/linux/sched.h |  3 ++
 kernel/sched/core.c   | 37 +++++++---------
 kernel/sched/fair.c   | 98 ++++++++++++++++++++++++++-----------------
 kernel/sched/sched.h  |  5 ++-
 4 files changed, 81 insertions(+), 62 deletions(-)

-- 
2.39.3

