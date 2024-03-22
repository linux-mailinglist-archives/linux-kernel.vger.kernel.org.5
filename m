Return-Path: <linux-kernel+bounces-111597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC260886E58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6943E1F235AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E4E47F59;
	Fri, 22 Mar 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="awiy4z6j"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2A47A58
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117026; cv=none; b=ppm6t9vfcrgeO7xbrisfSPovzHn5CNkVBNyeoKnkABcXdJyv720nPU+9yMEbpDkjzoLJCI+Th91ecdaiSKjFwPcNGgsYM4+u47eka7Fy4HC7fnfh5M/KvYJzQmRy8kHCPtkWyu6BFHx8dp4P5vpaLpgFwjFG6EVSTGyNmFCL8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117026; c=relaxed/simple;
	bh=eo2bqWYrcUZNSzYAEbyAw9M6T0CNfKBfGrU/lftL2Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYo7PB+YprHGmoNccF7grAz/T5G1GmTbL+G7yuYWl+cn9pXx/6P/QXSX7JOxHVkj03DX5NWmmHrMBpng3IYhxyp004xSqsOhek0FN0MnGbAHiaAGARoHadg3rAYvK5DosXifpR+qfaRiGmUPXjrDgqw6u3ZTt2aXDeUsDLOdCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=awiy4z6j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDE841007491;
	Fri, 22 Mar 2024 14:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fTZi8Hls2BOsqd/YE8ytbGfxvxA6culBdT/x2CsCLEw=;
 b=awiy4z6jd+Gq9XjNWvbg/39r75YYlH+r8VG/Tgb3LUPhSrRCCsOePGvYcv80m7yzO+/U
 HiZzIgkjqUCtPXPo/OeiHztrLLRQ6s8tskNbAKwDChONjJTBIDewhrrXIRkuyJsCDwX/
 ns7EIX6wdRiukP/wF2pbwR6Kl61WX89Tm87DpeIvWOiDFX68SxszXm2XKOYhlsRBTrjK
 zJND8hEXBxBzGSg9YwBN/R0lh7ZNafbKXq6Yl/mUQ/890oJYy9pXobEDnUcX78fJxxIi
 RvUJnLSeahEyk1XcOIFJoCR+t5iFvQqjQjmuVo9ub6v3ro1lRW21PkmYPVZbV5cAx7cY 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x1apa13qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:48 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MEGlf3005590;
	Fri, 22 Mar 2024 14:16:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x1apa13qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42ME424f023115;
	Fri, 22 Mar 2024 14:16:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x0x14p3yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42MEGgF450069894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:16:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB5EC20040;
	Fri, 22 Mar 2024 14:16:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16CA420043;
	Fri, 22 Mar 2024 14:16:41 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.195.40.125])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 14:16:40 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com, qperret@google.com
Subject: [PATCH v2 2/2] sched/fair: Use helper functions to access rd->overload
Date: Fri, 22 Mar 2024 19:46:32 +0530
Message-Id: <20240322141632.28654-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322141632.28654-1-sshegde@linux.ibm.com>
References: <20240322141632.28654-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mnUizvjoLepEwdGRfRqiki8VV0GTTT38
X-Proofpoint-ORIG-GUID: GabXCQp-lcSG7Q6nYnWJMuuiv5cqq3ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=781 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403220101

rd->overload is accessed at multiple places. Instead it could use helper
get/set functions. This would make the code more readable and easy to
maintain.

No change in functionality intended.

Suggested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  |  7 ++++---
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eeebadd7d9ae..cee99c93e6a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10621,8 +10621,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd

 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
-			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
+		if (is_rd_overloaded(env->dst_rq->rd) != (sg_status & SG_OVERLOAD))
+			set_rd_overload_status(env->dst_rq->rd,
+					       sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
@@ -12344,7 +12345,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);

-	if (!READ_ONCE(this_rq->rd->overload) ||
+	if (!is_rd_overloaded(this_rq->rd) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

 		if (sd)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41024c1c49b4..c91eb8811bef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -918,6 +918,16 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 extern void sched_get_rd(struct root_domain *rd);
 extern void sched_put_rd(struct root_domain *rd);

+static inline int is_rd_overloaded(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overload);
+}
+
+static inline void set_rd_overload_status(struct root_domain *rd, int status)
+{
+	WRITE_ONCE(rd->overload, status);
+}
+
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
@@ -2518,8 +2528,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)

 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
-		if (!READ_ONCE(rq->rd->overload))
-			WRITE_ONCE(rq->rd->overload, 1);
+		if (!is_rd_overloaded(rq->rd))
+			set_rd_overload_status(rq->rd, 1);
 	}
 #endif

--
2.39.3


