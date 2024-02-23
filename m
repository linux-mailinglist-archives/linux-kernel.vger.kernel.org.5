Return-Path: <linux-kernel+bounces-78575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7486153D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9002868E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841597F7FB;
	Fri, 23 Feb 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BkyRro5G"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D85FEE5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700908; cv=none; b=iIpP+7fBhy3bv7sGmweyEGWDheZHydTVtL94ksP2sML+RqFfGPm4aaK0zlkHYseIzYPOaxt1kU6Y56BR3wAcvCmMPPJnX0oN854VwfyNynKbMYMqup1xHGOs+z+cXgkxrFbWgcjh5GBwo3PpEmVs+PplZQpVM7PMF8oukKDRgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700908; c=relaxed/simple;
	bh=Qh9iMx88MnURYVFfeyq46dQMYFOJYb0EQPZ+OBw+WzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q15kt27mTcZH7sDx5Ub2MbVGrCIofrBUPZudQ3Bo446kwnv9FzOXMMcdpWihterojf56qsolQhetEHaaqQ9xNw9WxG0vNjG/MVNz1fUfEq7VVI0LQlWhhohzMpypW4Loo3P3gr+s0knEy6PHPeVtSbXlx+87/m0StLvUGX50jXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BkyRro5G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NF1J3w016142;
	Fri, 23 Feb 2024 15:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d58RgvIKA7XgjpVurnVrNffyQNbJgN7Zr1ki8kjLqmw=;
 b=BkyRro5G2aV0Sq/xgbOOZVE5RjDtD0KUIS5V06mtSo63IB5yXTvvLJVAeC+5K1/GXZuB
 TI7sseXDGhsetxzaXbpTKnoDYM+hOOXVRRvdcZdNXKT6jvIFNZbqFjGaHwRlMIS98s/h
 44h1/cf3gRwroKN2xFc/QhEWWHRD+HDAbdzrrufOLPdUNDGWMnZ8kgDSI2ZFpXXJimHY
 m3qfqhHIYcuE/MASuC3CwEMJlXKboz7c1kzxb7qSpW9n+Gd9arVyaJhKCJv1lBo8593H
 WfasNVc1aF3wp6/qN0iBI1sMn1K7eNEpDPCS0gv72FDoL2YoHl1MlAPbI7L/QKuhyeoA fA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wew9j8r9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:48 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NF1vix021470;
	Fri, 23 Feb 2024 15:07:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wew9j8r96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NE3Pf0003606;
	Fri, 23 Feb 2024 15:07:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u6c52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NF7fgI43778548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:07:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519B72004B;
	Fri, 23 Feb 2024 15:07:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98BAC20040;
	Fri, 23 Feb 2024 15:07:38 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.125.115])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:07:38 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH 2/2] sched/fair: Use helper function to access rd->overutilized
Date: Fri, 23 Feb 2024 20:37:07 +0530
Message-Id: <20240223150707.410417-3-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rJiHL_I9qOBGp4ncxnbQ_Q8z3mISCqwj
X-Proofpoint-GUID: 7VBKvJ4J9Q3RwjXybdxeKwT9cLnf8_6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=786 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230110

Overutilized field is accessed directly in multiple places.
So it could use a helper function. That way one might be more
informed that it needs to be used only in case of EAS.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9529d9ef2c5b..29a3481c55c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6670,6 +6670,15 @@ static inline bool cpu_overutilized(int cpu)
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }

+/*
+ * Ensure that caller can do EAS. overutilized value
+ * make sense only if EAS is enabled
+ */
+static inline int is_rd_overutilized(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overutilized);
+}
+
 static inline void update_rd_overutilized_status(struct root_domain *rd,
 						 int status)
 {
@@ -6686,7 +6695,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 * if energy aware scheduler is being used
 	 */
 	if (sched_energy_enabled()) {
-		if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 			update_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 	}
 }
@@ -6694,6 +6703,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 static inline void check_update_overutilized_status(struct rq *rq) { }
 static inline void update_rd_overutilized_status(struct root_domain *rd,
 						 bool status) { }
+static inline int is_rd_overutilized(struct root_domain *rd) { }
 #endif

 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -7969,7 +7979,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || READ_ONCE(rd->overutilized))
+	if (!pd || is_rd_overutilized(rd))
 		goto unlock;

 	/*
@@ -10873,7 +10883,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;

-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
 			goto out_balanced;
 	}

--
2.39.3


