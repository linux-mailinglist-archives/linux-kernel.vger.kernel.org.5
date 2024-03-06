Return-Path: <linux-kernel+bounces-93755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE6873426
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200181C2082B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19B60DDB;
	Wed,  6 Mar 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IQQdB+SK"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A560DD1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720746; cv=none; b=J6VBbHJKhkxo83lNGXYC4NjbC0WLBsHfGHaQtuNBBbRPeqUcYf3D+F/hz85lzIk+lOAz04YQ4cNGoLsYS7x2RNYl84tYxpwc0Wyj+N39X2kHf03l878Mr+5EATyze3pufffmbcLPTWvBsd4EVCJYLtycYTIMR3iisB/ckfLw/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720746; c=relaxed/simple;
	bh=4EBURAKcVEtzuH44BB1l5zxkTY5Se0NtwxvaQH+CNMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGdUDelTjvTm+cFO5PpOlx22kum8kC5zoFs4SPR2NDTm0JqyX0n6Ds+Lbv/1DYBrXHEA8W8PkzRwBsk4CA8wIt3pMzDmvCKCnkZiUdPwiMALSvyvs5faeirP5ctNhqsj2ETMupBRiT1e6cIRxcN8aaLO2rg3YoRMbcsf/eUOfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IQQdB+SK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4269v86e025889;
	Wed, 6 Mar 2024 10:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=p7FxxulEkaVgT4xCt+jgJQJXvspoIlD5AhWudCKfuuc=;
 b=IQQdB+SKpHHSmP6qChYQ++113kcKQCljNB77XLMJRW2gzYFglrySR+mmhVxatu5KSf4w
 KoQcnDQSSd3dqeRqrPTuc/Te5gzR7bJUfjMd35W7ZlNQqZLn2tfLstPMXBoUk2BMLR6J
 mS2uVufijhDkfPX5FW+Cts1OjhQLkvIF8X+Ngn1Srrc6Ge8TLTi3jUPrUOQO5tlhrGYZ
 L9C+WvDTF+M5Sw0imcloh7yriL4oLsSjDL/61828MlTn1pHThJFN30nN4sj1oOnw/xb8
 +lhyoqNiQzKxOH7evK55lNe4T+7ecXpEnIpjYGofXwoTPtI+OAAdnUbick3IJni8Q7lI gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wppaarqyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:34 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426AOWfQ022751;
	Wed, 6 Mar 2024 10:25:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wppaarqvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4269A1OP025376;
	Wed, 6 Mar 2024 10:25:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyp565-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426APQZx7668244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 10:25:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACDA2004D;
	Wed,  6 Mar 2024 10:25:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A5B32004F;
	Wed,  6 Mar 2024 10:25:23 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.37.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 10:25:22 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v5 2/3] sched/fair: Use helper function to access rd->overutilized
Date: Wed,  6 Mar 2024 15:54:53 +0530
Message-Id: <20240306102454.341014-3-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: XB5eQkQ2Wbn02ntkIIWNCbP0rrKi8ReI
X-Proofpoint-ORIG-GUID: _BZ7cXCquaSCDmVLhXWl04hn3nHI_kEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=853
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060082

Overutilized field is accessed directly in multiple places.
So it could use a helper function. That way one might be more
informed that it needs to be used only in case of EAS.

No change in functionality intended.

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 997e570d9423..e3086c8930ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6675,6 +6675,15 @@ static inline bool cpu_overutilized(int cpu)
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
 static inline void set_rd_overutilized_status(struct root_domain *rd,
 					      unsigned int status)
 {
@@ -6694,7 +6703,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	if (!sched_energy_enabled())
 		return;

-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
@@ -6708,6 +6717,11 @@ static inline void set_rd_overutilized_status(struct root_domain *rd,
 {
 	return 0;
 }
+
+static inline int is_rd_overutilized(struct root_domain *rd)
+{
+	return 0;
+}
 #endif

 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -7989,7 +8003,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || READ_ONCE(rd->overutilized))
+	if (!pd || is_rd_overutilized(rd))
 		goto unlock;

 	/*
@@ -10872,7 +10886,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;

-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
 			goto out_balanced;
 	}

--
2.39.3


