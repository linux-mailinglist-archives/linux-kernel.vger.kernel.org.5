Return-Path: <linux-kernel+bounces-93753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDBB873425
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67D1288F56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360560BB0;
	Wed,  6 Mar 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nbIwGipJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F060B98
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720737; cv=none; b=g8QzahUmFasxewq0KKpjbQ3m6J4onxmsswEEj1RFOryTz7U8CAkiazu/01o8NFpyslUQ7zAS0yMzcA4hqId4XMAsYNVVWnHLj4j7sttS6KUquxRLaCG4/g/tbwlWLCLjFcw09UnKFXSIT4IgeLkS4Rnb7U0AXznprgY85iN3Wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720737; c=relaxed/simple;
	bh=4/vNIA/htgQONGmlrPGS3eI+fyeAHEeoypzjMicSu7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAPjj0W+V2d+2sEzJZ6xP6fFwvOj1YG+R2h5YwYV0xTYkZByTmxj0GbymtrE8A9GRtDJtiFvC/IlnOtI2RQpinef0pIJJQkAa9U7oSLUsmJXUQM41Th+Rk1kZwhIPH1cA/RMrzc51GcENKv4qyoWz7huGRhJ5ZEUtGO52lBK6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nbIwGipJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426ACIZp000789;
	Wed, 6 Mar 2024 10:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y2o80FKKjJfp6yq3NWzP6tEPYZqtNr45RKnsJ/iNlDk=;
 b=nbIwGipJHmo+tCfa2sRhjS1MVUEaf90Z1LyYsgTjczHGTAdPN9ZCxh22lHdi1p/q7Kbf
 JRRbXOOCOCZiLTEC/zYoIXJsc3VdUHros34D5GX4lvvv+wHR9/7sknji/bCczMlbJATT
 932lMK0bYLsb7NCaf4e04APwDvpWqlnKYjgaognXKdK727H0FnvaKrkS3O1JEcSn9+s9
 8xKKHQs+bnrW6t+A1VZ4wwcemEmlpNdLGIkQjXLptkEavRgbexPUP/k4MEmQ6ELUQd9D
 qienqe4ZnqN83xpCbYEqZyuAyQVDiTSoFAFiN7Emgg6DCvuRL5H0ID3Sm3f7oTuExvRt Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpphb09jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:26 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426AOTmx000349;
	Wed, 6 Mar 2024 10:25:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpphb09h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426956t5031530;
	Wed, 6 Mar 2024 10:25:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnk5mgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426APJod14222028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 10:25:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AEF02004D;
	Wed,  6 Mar 2024 10:25:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4893220043;
	Wed,  6 Mar 2024 10:25:16 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.37.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 10:25:16 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v5 1/3] sched/fair: Add EAS checks before updating overutilized
Date: Wed,  6 Mar 2024 15:54:52 +0530
Message-Id: <20240306102454.341014-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240306102454.341014-1-sshegde@linux.ibm.com>
References: <20240306102454.341014-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RPy-J3HtsSNkSwq4dvVUV9BzDf-fz07u
X-Proofpoint-ORIG-GUID: 7eMI146XiAL6QmVshCaiYlPvx4ij5aZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060082

Overutilized field of root domain is only used for EAS(energy aware scheduler)
to decide whether to do load balance or not. It is not used if EAS
not possible.

Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
this field. In update_sd_lb_stats it is updated often. This causes cache
contention due to true sharing and burns a lot of cycles. overload and
overutilized are part of the same cacheline. Updating it often invalidates
the cacheline. That causes access  to overload to slow down due to
false sharing. Hence add EAS check before accessing/updating this field.
EAS check is optimized at compile time or it is a static branch.
Hence it shouldn't cost much.

With the patch, both enqueue_task_fair and newidle_balance don't show
up as hot routines in perf profile.

6.8-rc4:
7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
6.78%  s                [kernel.vmlinux]              [k] newidle_balance
+patch:
0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance

Minor change: trace_sched_overutilized_tp expect that second argument to
be bool. So do a int to bool conversion for that.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 62 +++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..997e570d9423 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6663,22 +6663,51 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	unsigned long  rq_util_min, rq_util_max;
+
+	if (!sched_energy_enabled())
+		return false;
+
+	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);

 	/* Return true only if the utilization doesn't fit CPU's capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }

-static inline void update_overutilized_status(struct rq *rq)
+static inline void set_rd_overutilized_status(struct root_domain *rd,
+					      unsigned int status)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
-	}
+	if (!sched_energy_enabled())
+		return;
+
+	WRITE_ONCE(rd->overutilized, status);
+	trace_sched_overutilized_tp(rd, !!status);
+}
+
+static inline void check_update_overutilized_status(struct rq *rq)
+{
+	/*
+	 * overutilized field is used for load balancing decisions only
+	 * if energy aware scheduler is being used
+	 */
+	if (!sched_energy_enabled())
+		return;
+
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
-static inline void update_overutilized_status(struct rq *rq) { }
+static inline void check_update_overutilized_status(struct rq *rq)
+{
+	return 0;
+}
+
+static inline void set_rd_overutilized_status(struct root_domain *rd,
+					      unsigned int status)
+{
+	return 0;
+}
 #endif

 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -6779,7 +6808,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * and the following generally works well enough in practice.
 	 */
 	if (!task_new)
-		update_overutilized_status(rq);
+		check_update_overutilized_status(rq);

 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -10596,19 +10625,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);

 	if (!env->sd->parent) {
-		struct root_domain *rd = env->dst_rq->rd;
-
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd,
+					   sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 	}

 	update_idle_cpu_scan(env, sum_util);
@@ -12609,7 +12633,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);

 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));

 	task_tick_core(rq, curr);
 }
--
2.39.3


