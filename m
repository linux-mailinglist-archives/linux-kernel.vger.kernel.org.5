Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB087B7B12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbjJDJGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbjJDJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE0CBF0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:05:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5187153B;
        Wed,  4 Oct 2023 02:06:22 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08FB3F59C;
        Wed,  4 Oct 2023 02:05:42 -0700 (PDT)
From:   Hongyan Xia <Hongyan.Xia2@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>
Subject: [RFC PATCH 6/6] sched/uclamp: Simplify uclamp_eff_value()
Date:   Wed,  4 Oct 2023 10:04:54 +0100
Message-Id: <6006f27e2cae8c5f8b00987aa04ee29317aabcc1.1696345700.git.Hongyan.Xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696345700.git.Hongyan.Xia2@arm.com>
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyan Xia <hongyan.xia2@arm.com>

The commit

sched: Remove all uclamp bucket logic

removes uclamp_{inc/dec}() functions, so now p->uclamp contains the
correct values all the time after a update_uclamp_active() call, and
there's no need to toggle the boolean `active` after an update. As a
result, this function is fairly simple now and can live as a static
inline function.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/core.c  | 13 ++++---------
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c5bf01e7df28..737921a9dd91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1483,21 +1483,15 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
-{
-	if (!uclamp_is_used() || !p->uclamp[clamp_id].active)
-		return uclamp_none(clamp_id);
-
-	return p->uclamp[clamp_id].value;
-}
-
 static inline void
 uclamp_update_active_nolock(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
+		p->uclamp[clamp_id].active = 1;
+	}
 }
 
 static inline void
@@ -1759,6 +1753,7 @@ static void uclamp_fork(struct task_struct *p)
 		for_each_clamp_id(clamp_id) {
 			uclamp_se_set(&p->uclamp_req[clamp_id],
 				      uclamp_none(clamp_id), false);
+			p->uclamp[clamp_id].active = 0;
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 30dee8eb2ed9..896626afbedc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2986,8 +2986,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
-
 /*
  * When uclamp is compiled in, the aggregation at rq level is 'turned off'
  * by default in the fast path and only gets turned on once userspace performs
@@ -3001,6 +2999,18 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+static inline unsigned long uclamp_eff_value(struct task_struct *p,
+					     enum uclamp_id clamp_id)
+{
+	if (uclamp_is_used() && p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].value;
+
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+
+	return SCHED_CAPACITY_SCALE;
+}
+
 static inline unsigned long root_cfs_util(struct rq *rq)
 {
 	return READ_ONCE(rq->root_cfs_util_uclamp);
-- 
2.34.1

