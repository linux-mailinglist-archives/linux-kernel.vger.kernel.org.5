Return-Path: <linux-kernel+bounces-76211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D485F438
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B26FB278D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270338DDA;
	Thu, 22 Feb 2024 09:23:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD64376FA;
	Thu, 22 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593780; cv=none; b=UpXqGiQ+p7rQMLvGwJFT4aalbBqj2vhsmSFKCfUrwFIXZfJMEOQ5VEVFfTTZvJkZ3qmYLoSLThsX++e699Dc5jPd1gD/aj9ApIMIy2oL5GjKsgZf8yFzOcfyPu2qBwIE4EtZsXgj/WbEiXy/6AVGPTAvCWbLPvcRJy0FHhXz6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593780; c=relaxed/simple;
	bh=Y9MCsGargnZMdYbvCa0RXPzvIXitJU5Yea7omJUm5oc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oz9IU/6AG92nfJdjC59l/b9VIZ2eZKKmCe+0OunesMfdjVCAhbnH7c2QJXg/PIad61OZLsliJj+gjeZ1x+KAfWArWpPb+XQwV0PiQWCaU65i74UY7wdr8Z2S9hGUxNplezvN8yhG01980GrlaaAb6M6R///vrd0L/Ub3iy9aEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41M9MOXf042231;
	Thu, 22 Feb 2024 17:22:24 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TgSMH4w5yz2KL7sp;
	Thu, 22 Feb 2024 17:21:47 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 22 Feb 2024 17:22:22 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Jens Axboe
	<axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv2 1/2] sched: introduce helper function to calculate distribution over sched class
Date: Thu, 22 Feb 2024 17:22:19 +0800
Message-ID: <20240222092220.642294-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41M9MOXf042231

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
change of v2: using two parameter to pass se_prop and rq_prop out
---
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..d6d5914fad10 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2318,6 +2318,9 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu);
+/* Returns task's and cfs_rq's proportion among whole core */
+unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long *se_prop,
+			unsigned long *rq_prop);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..b8c29dff5d37 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7494,6 +7494,41 @@ unsigned long sched_cpu_util(int cpu)
 {
 	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
 }
+
+/*
+ * Calculate the approximate proportion of timing value consumed by the specified
+ * tsk and all cfs tasks of this core.
+ * The user must be aware of this is done by avg_util which is tracked by
+ * the geometric series of decaying the load by y^32 = 0.5 (unit is 1ms).
+ * That is, only the period last for at least several TICKs or the statistics
+ * of repeated timing value are suitable for this helper function.
+ * This function is actually derived from effective_cpu_util but without
+ * limiting the util to the core's capacity.
+ * se_prop and rq_prop is valid only when return value is 1
+ */
+unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long *se_prop,
+			unsigned long *rq_prop)
+{
+	unsigned int cpu = task_cpu(tsk);
+	struct sched_entity *se = &tsk->se;
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long util, irq, max;
+
+	if (tsk->sched_class != &fair_sched_class)
+		return 0;
+
+	max = arch_scale_cpu_capacity(cpu);
+	irq = cpu_util_irq(rq);
+
+	util = cpu_util_rt(rq) + cpu_util_cfs(cpu) + cpu_util_dl(rq);
+	util = scale_irq_capacity(util, irq, max);
+	util += irq;
+
+	*se_prop = se->avg.util_avg * 100 / util;
+	*rq_prop = cpu_util_cfs(cpu) * 100 / util;
+	return 1;
+}
+
 #endif /* CONFIG_SMP */
 
 /**
-- 
2.25.1


