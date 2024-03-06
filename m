Return-Path: <linux-kernel+bounces-93756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFD873427
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49324289520
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD75660DFB;
	Wed,  6 Mar 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nabz+xiL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6B60DE7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720750; cv=none; b=HjeBqVuxu2GdQfyMNbExwb9ToBPQVzRb57M/SXvlLz5AUqCmWpi/iFX1V6A271z64j5q+At4C0YE8CEgh02xVVpvKvoNLUt/9IoajQs/VG6l5P196fIMXP3P3b4l5CsjakEYVke/ONEtMSKvHTBWqQa6Y9tedjpbfSvyazU+7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720750; c=relaxed/simple;
	bh=hTPHNGHPmEBM3GR8WRNO3zR4R+w/RFE/Qeo2HtsaQXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndYXlW0b7cvQuwP3bGYhnx8up8SvQ7lgbhEymXlvbCDo3Yt5oTu6AuNLKOFnmC++0HPtm7Fxi4Nd3uvm/eba4tfOVC9Ncn8HqONqJUd32Rxspnm/d/K7SYHtCbDZAErcg2JvMprRz4K4E7JHIak/6YEKEmW3jdV2HPuQNyHaWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nabz+xiL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426ACDvx000643;
	Wed, 6 Mar 2024 10:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rc+0MPnQqE5JGj3Tu4WljFP7By+qc43U0SeqvPqs+CM=;
 b=Nabz+xiLRnZzmG1BgdHezy4wFt5Aud+Qph+glNf8HPT8wSeOOWFZF/c9b8Z21EZom0sP
 B+ftMdQPS+K7W+0OJXoMfjyOEocDUZCuiuxdLlH+o5micdtLMjnMht+US4/rDL3rFCPL
 ZLHYbFQGoRJplkLSEuaeAvWMiHbMlXZ0QiAijHOLNt27NLfhdnM0pFzJw5XfpN/8pv/c
 Ldn2xZUedRu3MB+Mb0gwMMXOfxC5YH20fJME3rhkHq5pyl7kCN6Wzri0+2nU1aDaGSqR
 2DQVdEZqOIlJq6L1o8fBfvZuCVH1lAZXOJ0sllh2lCKKIxdY3Ni/yL9gfezSp/ZDstak rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpphb0a3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426AEOt5007913;
	Wed, 6 Mar 2024 10:25:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpphb0a16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426954Kn024193;
	Wed, 6 Mar 2024 10:25:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjws9826-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426APVgM32964864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 10:25:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E9D32004E;
	Wed,  6 Mar 2024 10:25:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50DEE20040;
	Wed,  6 Mar 2024 10:25:28 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.37.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 10:25:28 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v5 3/3] sched/fair: Combine EAS check with overutilized access
Date: Wed,  6 Mar 2024 15:54:54 +0530
Message-Id: <20240306102454.341014-4-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: 4tCdij61nJCe83teSYnDAa5SmuiQVOE9
X-Proofpoint-ORIG-GUID: frKdPZMqmGqaHmn_Yo5tzIlNYXlB99Ff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060082

Access to overutilized is always used with sched_energy_enabled in
the pattern:

if (sched_energy_enabled && !overutilized)
       do something

So modify the helper function to return this pattern. This is more
readable code as it would say, do something when root domain is not
overutilized.

No change in functionality intended.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e3086c8930ea..62f247bdec86 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6676,12 +6676,11 @@ static inline bool cpu_overutilized(int cpu)
 }

 /*
- * Ensure that caller can do EAS. overutilized value
- * make sense only if EAS is enabled
+ * overutilized value make sense only if EAS is enabled
  */
-static inline int is_rd_overutilized(struct root_domain *rd)
+static inline int is_rd_not_overutilized(struct root_domain *rd)
 {
-	return READ_ONCE(rd->overutilized);
+	return sched_energy_enabled() && !READ_ONCE(rd->overutilized);
 }

 static inline void set_rd_overutilized_status(struct root_domain *rd,
@@ -6700,10 +6699,8 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 * overutilized field is used for load balancing decisions only
 	 * if energy aware scheduler is being used
 	 */
-	if (!sched_energy_enabled())
-		return;

-	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
+	if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
@@ -6718,7 +6715,7 @@ static inline void set_rd_overutilized_status(struct root_domain *rd,
 	return 0;
 }

-static inline int is_rd_overutilized(struct root_domain *rd)
+static inline int is_rd_not_overutilized(struct root_domain *rd)
 {
 	return 0;
 }
@@ -8003,7 +8000,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || is_rd_overutilized(rd))
+	if (!pd)
 		goto unlock;

 	/*
@@ -8206,7 +8203,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;

-		if (sched_energy_enabled()) {
+		if (is_rd_not_overutilized(this_rq()->rd)) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
 				return new_cpu;
@@ -10883,12 +10880,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;

-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
-			goto out_balanced;
-	}
+	if (is_rd_not_overutilized(env->dst_rq->rd) &&
+	    rcu_dereference(env->dst_rq->rd->pd))
+		goto out_balanced;

 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)
--
2.39.3


