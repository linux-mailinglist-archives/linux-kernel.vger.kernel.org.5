Return-Path: <linux-kernel+bounces-84594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0386A8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8640B1F271BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278B8250EC;
	Wed, 28 Feb 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q+Ydowm9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F02377D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104612; cv=none; b=gTPmZd3kpcQFP2SG6EXGjuc8GJw05nFifrgeT1MPm9vdrVu/1Oybc10KcUHPZVe9lAW6SdN9KElyWUEOZrN6MVTKNk07mNdQym87kbmC3KmuWDIE9iNKDpguk/zTg6OTyF1a7hbAzLWPlf/UlW82YDmhL86bFtqyDAqe/a2EUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104612; c=relaxed/simple;
	bh=BebgLjYSYYA+H17Gdgp8i9GqMVuiGhasf+VKQ5BMIRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYRXhpxQrm9uLpQWWehK3ZyoIQxJYegXak/4+/35TE5fGcnEU2Cn7bV32XqripZisXRdndTKwgFAe4ersQGW/XLEbl+2wscXdXBg4dz9/kRdWhs6mBFl8LCu23hfGVf3DJ+yGlQ2Qp8W7X+yNFVC/W37ZbnInLBqmcfw9vq+VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q+Ydowm9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S7COHP028224;
	Wed, 28 Feb 2024 07:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PWdLCQhEbn51/HeD1YkV0btAehsiQwm1UgFcby6lwwc=;
 b=Q+Ydowm9NasjFhxWSoIBK8Sdju6NxpJ8zgFqNGuopLvMeT4y6bVqt0YmTLlvtKWERdOa
 geJ7Grida+l7kAQX9eMHsDzUlV5XK1FBavccSwzFa/ImDYXsnghbUf72kVU1k/WFXxFO
 4tKyawKsrCunPPabDbu6NscBHWoNII/CYULMH8CAP2NFAuzP12UifPmRc+wd+jny6G0j
 7SorWx3Mzpup7SOBQwD/XqXOqnWn60shR4sQIgZPpMIzQKmDkEB0IjRjinD+I1L2GiIR
 t6+WCOLGjMBVqCqK1wm6RU364h3xkXjXE/QLqkC0LwnSQTdJ8x5p/YPQHB+bVDRJivwv mg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj07x83fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:41 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41S7DWDA031754;
	Wed, 28 Feb 2024 07:16:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj07x83f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41S70Xna012312;
	Wed, 28 Feb 2024 07:16:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2cb1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41S7GYJo38732226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 07:16:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7863E20043;
	Wed, 28 Feb 2024 07:16:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EAFE2004B;
	Wed, 28 Feb 2024 07:16:31 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.91.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 07:16:30 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH v2 1/2] sched/fair: Add EAS checks before updating overutilized
Date: Wed, 28 Feb 2024 12:46:20 +0530
Message-Id: <20240228071621.602596-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240228071621.602596-1-sshegde@linux.ibm.com>
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gPU0yayHzmepDS08xCe-W3lmiLB2HkAk
X-Proofpoint-ORIG-GUID: -W7qOw9YxCu0j2BK2mx1LexJdOqPTJsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280056

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

Minor change; trace_sched_overutilized_tp expect that second argument to
be bool. So do a int to bool conversion for that.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e30e2bb77a0..3105fb08b87e 100644
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
@@ -10613,13 +10628,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
+		update_rd_overutilized_status(rd, sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
 		struct root_domain *rd = env->dst_rq->rd;

-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		update_rd_overutilized_status(rd, SG_OVERUTILIZED);
 	}

 	update_idle_cpu_scan(env, sum_util);
@@ -12625,7 +12638,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);

 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));

 	task_tick_core(rq, curr);
 }
--
2.39.3


