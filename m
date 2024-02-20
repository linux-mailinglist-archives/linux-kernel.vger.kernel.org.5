Return-Path: <linux-kernel+bounces-72395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F311785B2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1991F25404
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429D58AAB;
	Tue, 20 Feb 2024 06:16:49 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86158101
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409809; cv=none; b=lzkOkWIBZI7WQGfaMrin/dUeVWXCvvqbBTXEx+ypaumPIDI+CSFGvIi3WE1IWhopn2fmiWhWb/xTKz9O+XdFwhbN+5f2Hyzk/F9Q19DyldfViGYx5YcuYmGqEnWFDT015pXr1ORnUcunoIG/yQ1qnjBdAhxZWw2g+qHWBMvr6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409809; c=relaxed/simple;
	bh=JUNp8NBGM/NdaEf4VeQTlcoAJK/EmXkAJZRb5fSNQkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZReTZENon22i8Y8i6X1sHrWhcEOqU3Luv7G1Meh30X8ALV983bjlxz7g/A0zS+lNlrAbRMvPV/FPVhMNhNmw9W7fcvkXpSOmuZQ/a8i+uGdP9rUoOE/MtbIKwBFWofRn22kMCPA4IBPh+D9HRLx0XK+yrR5HVbsKF5RORC6m6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41K6FrW0094999;
	Tue, 20 Feb 2024 14:15:53 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tf8K41mTxz2K25V6;
	Tue, 20 Feb 2024 14:15:20 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 20 Feb 2024 14:15:51 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 1/2] sched: introduce helper function to calculate distribution over sched class
Date: Tue, 20 Feb 2024 14:15:41 +0800
Message-ID: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41K6FrW0094999

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As RT, DL, IRQ time could be deemed as lost time of CFS's task, some
timing value want to know the distribution of how these spread
approximately by using utilization account value (nivcsw is not enough
sometimes). This commit would like to introduce a helper function to
achieve this goal.

eg.
Effective part of A = Total_time * cpu_util_cfs / cpu_util

Timing value A
(should be a process last for several TICKs or statistics of a repeadted
process)

Timing start
|
|
preempted by RT, DL or IRQ
|\
| This period time is nonvoluntary CPU give up, need to know how long
|/
sched in again
|
|
|
Timing end

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..99cf09c47f72 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2318,6 +2318,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu);
+unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long val);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..217e2220fdc1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7494,6 +7494,26 @@ unsigned long sched_cpu_util(int cpu)
 {
 	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
 }
+
+/*
+ * Calculate the approximate proportion of timing value consumed in cfs.
+ * The user must be aware of this is done by avg_util which is tracked by
+ * the geometric series as decaying the load by y^32 = 0.5 (unit is 1ms).
+ * That is, only the period last for at least several TICKs or the statistics
+ * of repeated timing value are suitable for this helper function.
+ */
+unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long val)
+{
+	unsigned int cpu = task_cpu(tsk);
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long util;
+
+	if (tsk->sched_class != &fair_sched_class)
+		return val;
+	util = cpu_util_rt(rq) + cpu_util_cfs(cpu) + cpu_util_irq(rq) + cpu_util_dl(rq);
+	return min(val, cpu_util_cfs(cpu) * val / util);
+}
+
 #endif /* CONFIG_SMP */
 
 /**
-- 
2.25.1


