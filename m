Return-Path: <linux-kernel+bounces-78574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E286153B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E51F25351
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096081ACC;
	Fri, 23 Feb 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVsWHFzm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7D29AF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700889; cv=none; b=CM3LqP07E3gbLnyYjLXjGfw30ppWhqI+QGXO3B1sNxF/crEPt+8/hmyihTq+9EsPyeB4wtGA/wxcuirDgRcj4sNuKVqis4uYsdY/P1WHA65/ji12faVuSOQ8j80m/TD1lkCtBX3m/He6ENRDuczm0mEadk/3XZg3Ty5K9pr4Q+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700889; c=relaxed/simple;
	bh=Sov6ZXkWtBkWruu+5JsAXVtkAInsivzIlIrWhB/fdK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y35Y/rFAapnNr49StSCCGzqaHh+TbM8is6zeQODsuHk4nVkFvapMvJ2VlrSkK2fH5OvoCg/tuTEEJhEStvqOKV74ruWVFkayMERxDnxgBJN9AK8Y7UWg6GgNY/qnwHIL8nH91wwOLk+BXknSpdt6YdlLvxA2twYKlLUZCk9hYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVsWHFzm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEgamg017903;
	Fri, 23 Feb 2024 15:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+Rgu1HCWPbClxoqHwxH9oS5K5pDAyvJB9bP93pSTws0=;
 b=CVsWHFzmPLOZJvkPXe9Hl+CfNVn2UbWg6fJvAtJpKs74LvLQYD8MKrMAKwQs72JIIOVW
 d2qxS1dZ8Suy8U983rNSTM2NLbSS73fFVorAHA/rFl+XFWrDT8ppkPjXkvhO12dROKuL
 /mi8xkEd9EQ6/iaC5wUWUeZynP3ZhEmrnau6oVeaT8Xus0epof7K3A8cHTjVj23dz38W
 ZWOejM8P7sB9Ua6C/97WTJN8xZDa9PubFA1COLuCm/OtOo5L/UJ+6uq575uiYnjgAtRU
 fry3Yu3pkr3R1ToOF+sohRnxTXZn9Ry3sEMqFrmBWYMrJV6/DGbjgPEntd0gmAa5rUUU BA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wewbyguf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NEhwv4023217;
	Fri, 23 Feb 2024 15:07:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wewbygues-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:43 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NDwuIi003623;
	Fri, 23 Feb 2024 15:07:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u6c4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NF7b2Z64291144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:07:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1260F20043;
	Fri, 23 Feb 2024 15:07:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F17220040;
	Fri, 23 Feb 2024 15:07:34 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.125.115])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:07:34 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH 1/2] sched/fair: Add EAS checks before updating overutilized
Date: Fri, 23 Feb 2024 20:37:06 +0530
Message-Id: <20240223150707.410417-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240223150707.410417-1-sshegde@linux.ibm.com>
References: <20240223150707.410417-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3BYzekx7VTsS-3SEOdnOvJOJyiN99qE1
X-Proofpoint-ORIG-GUID: 9YcPV_8v9UEarWp5xexERSP0NL1KZ_ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230110

Overutilized field of root domain is only used for EAS(energy aware scheduler)
to decide whether to do regular load balance or EAS aware load balance. It
is not used if EAS not possible.

Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
this field. In update_sd_lb_stats it is updated often.
Which causes cache contention due to load/store tearing and burns
a lot of cycles. Hence add EAS check before updating this field.
EAS check is optimized at compile time or it is static branch.
Hence it shouldn't cost much.

With the patch, both enqueue_task_fair and newidle_balance don't show
up as hot routines in perf profile.

6.8-rc4:
7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
6.78%  s                [kernel.vmlinux]              [k] newidle_balance
+patch:
0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance

While here, Fix updating overutilized as either SG_OVERUTILIZED or 0
instead. Current code can make it 0, 1 or 2. This shouldn't alter the
functionality.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e30e2bb77a0..9529d9ef2c5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6670,15 +6670,30 @@ static inline bool cpu_overutilized(int cpu)
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }

-static inline void update_overutilized_status(struct rq *rq)
+static inline void update_rd_overutilized_status(struct root_domain *rd,
+						 int status)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
+	if (sched_energy_enabled()) {
+		WRITE_ONCE(rd->overutilized, status);
+		trace_sched_overutilized_tp(rd, !!status);
+	}
+}
+
+static inline void check_update_overutilized_status(struct rq *rq)
+{
+	/*
+	 * overutilized field is used for load balancing decisions only
+	 * if energy aware scheduler is being used
+	 */
+	if (sched_energy_enabled()) {
+		if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+			update_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 	}
 }
 #else
-static inline void update_overutilized_status(struct rq *rq) { }
+static inline void check_update_overutilized_status(struct rq *rq) { }
+static inline void update_rd_overutilized_status(struct root_domain *rd,
+						 bool status) { }
 #endif

 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -6779,7 +6794,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * and the following generally works well enough in practice.
 	 */
 	if (!task_new)
-		update_overutilized_status(rq);
+		check_update_overutilized_status(rq);

 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -10613,13 +10628,12 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
+		update_rd_overutilized_status(rd,
+				(sg_status & SG_OVERUTILIZED) ? SG_OVERUTILIZED : 0);
 	} else if (sg_status & SG_OVERUTILIZED) {
 		struct root_domain *rd = env->dst_rq->rd;

-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		update_rd_overutilized_status(rd, SG_OVERUTILIZED);
 	}

 	update_idle_cpu_scan(env, sum_util);
@@ -12625,7 +12639,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);

 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));

 	task_tick_core(rq, curr);
 }
--
2.39.3


