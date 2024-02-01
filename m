Return-Path: <linux-kernel+bounces-48210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6984589C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9150B1C26D53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E135F471;
	Thu,  1 Feb 2024 13:12:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04285D48A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793157; cv=none; b=nbDCH1/u8l4RFM9ZyTF0zXfps7VXitYP5aypWjF/Gm3iSxNiiWCHqI2/SEY38x/Sa+lBEe4Oab0lr4SViwC9VdwpcMTb2lLHeWO1ZD7FMKh+aqqz7C6XqZSC1ZuRI2oqnj0aUW0QF2Z9VxtOeJkIENcHTHuwPE7MoZvHqfMJczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793157; c=relaxed/simple;
	bh=qyzq9pirjl2WQPG64jgIbtQm4pn18T/tfWhWUBDLcXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNgaMlQB3LAVvuHRY+D5fJV18eCSinpFyUM6FOkBFSxTSKlFva4ZZF8ouk+ndZj/CyxZevoJG+GwckJIV8QJG5QI6yLtlHxLhbhWsWv+y7534HvJyj3OmzTXMr3VEqOPb8PUc1kkWBdqmr3YuTAOFL4RTGNnzX43T7U4ZCc60Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 108E2176B;
	Thu,  1 Feb 2024 05:13:17 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442993F762;
	Thu,  1 Feb 2024 05:12:32 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org,
	David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>
Subject: [RFC PATCH v2 7/7] sched/uclamp: Simplify uclamp_eff_value()
Date: Thu,  1 Feb 2024 13:12:03 +0000
Message-Id: <215a6377e1aef10460d1aa870fb06774680925c5.1706792708.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706792708.git.hongyan.xia2@arm.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit

sched: Remove all uclamp bucket logic

removes uclamp_rq_{inc/dec}() functions, so now p->uclamp contains the
correct values all the time after a uclamp_update_active() call, and
there's no need to toggle the boolean `active` after an update. As a
result, this function is fairly simple now and can live as a static
inline function.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/core.c  | 13 ++++---------
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a3b36adc4dcc..f5f5f056525c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1499,21 +1499,15 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
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
@@ -1773,6 +1767,7 @@ static void uclamp_fork(struct task_struct *p)
 		for_each_clamp_id(clamp_id) {
 			uclamp_se_set(&p->uclamp_req[clamp_id],
 				      uclamp_none(clamp_id), false);
+			p->uclamp[clamp_id].active = 0;
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 81578410984c..2caefc3344bb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2991,8 +2991,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
-
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
@@ -3022,6 +3020,18 @@ static inline bool uclamp_is_used(void)
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


