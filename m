Return-Path: <linux-kernel+bounces-95171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFC874A36
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E0A1C22489
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2182D99;
	Thu,  7 Mar 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GLqpHd6n"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DB82D79
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801900; cv=none; b=P+8x3ktlEsLu8qKCxJarILq7gWzQqxJRgfoK/81z7x4NqSN1o2ZLW70DplxCGGVwHwh3bL4R9N3iHeU4BCizwOe/V5tZN3XxWYWKIH8KBwL5asXDJ97VxgZ+6jG31ecPhHrSn3/x89aZzREx5Kb3RczVuQe3LFTAJz95T+b+hcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801900; c=relaxed/simple;
	bh=s2MB/R/nTq13/oozOCczwY5h5OYN+RIkBQqfAFc50Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+j7GQq7MZpXzW84BJi3vT6BNAFaQqFcc4p93l9sfQDd+A3StYZ5IhL1T3GL07H/zQ13qOBFBOJ5uHrjRHAF2T1cNxu4KL+J3JRsd1AJ8xG2kl4My2smmFewEXsX2o1tBPG/mjwP8dTZFvuJxrqrewMqX+zAIMKPAoO3xUmsDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GLqpHd6n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4278WR7R014571;
	Thu, 7 Mar 2024 08:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+RdrEFT30hTLA6pq1jACWkgLormlPbcUJcdbJhsk3nI=;
 b=GLqpHd6nKxk3CsC42ERqXXed+pqajK3CUYWkcyOBilNOYV/BNxd7/C3UiRkP6DKda0VB
 9axsNVs8FTbMxr1DNy+thfU5xoU39dkUbiuRUG9zSsdYsgq3lBxMf5lWO9ppiK5ow5ET
 T20Rgx1bnP6Qjz9fN1bykYyBNJYkxoeg8bCb59AS57XD0wFI4axxS30MdVvWKpV49Pnc
 CM+xCx+QWrLlEl0tRiRYd/UQcql/VeM9h2WpRXJk+Ui7D45Z9HgBSIZqw+57CAvvdklg
 HjhRNB6j1qrfIIXglXBuQTP1K/qy+PLVAH0PRJGH9zsdweiTfje458i8X5Jrg5Yfb2oJ 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5m8edd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:49 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4278Wq4J015524;
	Thu, 7 Mar 2024 08:57:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5m8ed5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42770sjJ006077;
	Thu, 7 Mar 2024 08:57:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetcqg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4278vg5M37814702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 08:57:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94EB72004F;
	Thu,  7 Mar 2024 08:57:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1500820067;
	Thu,  7 Mar 2024 08:57:40 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 08:57:39 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v6 2/3] sched/fair: Use helper function to access rd->overutilized
Date: Thu,  7 Mar 2024 14:27:24 +0530
Message-Id: <20240307085725.444486-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240307085725.444486-1-sshegde@linux.ibm.com>
References: <20240307085725.444486-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LywlDgF0Xet-9ENt04oHdeUBzBXf-rDv
X-Proofpoint-GUID: v1bn10qxCKHop9EdY0Nqj931DyTN0kAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxlogscore=894
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070064

Overutilized field is accessed directly in multiple places.
So it could use a helper function. That way one might be more
informed that it needs to be used only in case of EAS.

No change in functionality intended.

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5aa6e918598c..87e08a252f94 100644
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
@@ -7980,7 +7989,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || READ_ONCE(rd->overutilized))
+	if (!pd || is_rd_overutilized(rd))
 		goto unlock;

 	/*
@@ -10863,7 +10872,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;

-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
 			goto out_balanced;
 	}

--
2.39.3


