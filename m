Return-Path: <linux-kernel+bounces-84595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B086A8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEC289381
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AEF2421C;
	Wed, 28 Feb 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NKKqnHMs"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4423776
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104711; cv=none; b=PlUP6/D1OIllLR6JLOtyU+/6HKNHPZB8hopZxU5gYJeaUWQcdoih80oTOlQrzxdhJOPiRW8Tm3nD0FQCYmSV/OD2EOcnsIfkVTxAilb4EcP+MdOhBpoM5/nkf6XTikTBU6X0kvyWvgtaPIedUKP26Cri3wKhgpJznywY/CHrPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104711; c=relaxed/simple;
	bh=F/EhtAVHW6DXHvOx3AX0RzCvHTSrK4PCHnncT9LCCKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJgG1slGUAlsy8xURG0p0gUwSvIGBhIwNkGVnZWjP/+AMVMgwFDsmVvRcSVfI4xXUaNJTgw+Sd6KBNr/8k1UNOv5oU8Q5JgXcqdUyVjMrefPbaHFp9S6u5jSTsYJ9DLGnmL+5Jh67morId/SYtTRaV19ZOtiNnu1iWBGdkVbCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NKKqnHMs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S7HuFh025811;
	Wed, 28 Feb 2024 07:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ryn+KapU8lTbn8tg4HNJHSFxH7ZQaqM6NRyd9Y3rSAc=;
 b=NKKqnHMsBKwIGImh/XBISG9905wvw5UUtDIlH2XoqGsFvbUT2OYDLKBe+by28dVI9Vu6
 lOksPU1QMiMB+yqvkSVxE2GcjqF3n7dp9GO/xZ/t9lg9qpMwkkyW/eqasRj5+wNt6lwD
 PAZmZR8YYj1uH/HcGQPZR7Mhlo8bahcH3kErCuGI+00R3/CrEP3cbF4ddgGpcCMenKnv
 CDO3xNAVf2inGAV7t6RvUVcSPHr6aLhKJ/H2at4imLn86Z3Tx1/Nfg67mJvVApkxSO7Q
 7KaINPygBx8MnwtvVWPLwsw/XKyZ3VSkbh4ZpsLZwNdEHVU4Xk/pwaBe6Cwyga2WN2zP 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj0ah005q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:18:10 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41S7IAL8027083;
	Wed, 28 Feb 2024 07:18:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj0ah004x-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:18:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41S58RpV021278;
	Wed, 28 Feb 2024 07:16:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfusp4tmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41S7GeA67799416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 07:16:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36E9E2004B;
	Wed, 28 Feb 2024 07:16:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0E5E20043;
	Wed, 28 Feb 2024 07:16:36 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.91.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 07:16:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH v2 2/2] sched/fair: Use helper function to access rd->overutilized
Date: Wed, 28 Feb 2024 12:46:21 +0530
Message-Id: <20240228071621.602596-3-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Q_5dW4nkpacXwMjC5ygaNbxBpE1jPc2O
X-Proofpoint-GUID: 4psO9SMwgOqMoBnKuQIn3fOzgrsTgVps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=834
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280056

Overutilized field is accessed directly in multiple places.
So it could use a helper function. That way one might be more
informed that it needs to be used only in case of EAS.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3105fb08b87e..c085fe8421b8 100644
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
@@ -10872,7 +10882,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;

-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
 			goto out_balanced;
 	}

--
2.39.3


