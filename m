Return-Path: <linux-kernel+bounces-95170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B6874A35
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10E8286DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B9682D89;
	Thu,  7 Mar 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G+wusVe6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1A82D73
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801899; cv=none; b=S6Vs7ttOU4NHTZo8VUMJkXuL1nNhZxhlaqxuPwC4RbWOS5+zx/xYawDjPViKqQobp1erY5n842aX/gWdCw2lTtS7J7E802S1WuumQoNEsJE+5PELTxwFdJniXKKxsL//BdPgewuuP7H89osh8WK8QnxahcS3AtyefdahiWeiJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801899; c=relaxed/simple;
	bh=Oq0WmmSAbHNYJsE6eKHeXKHCOi9xt3NB/PHSOD/ncTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pB1ym9n/x7xTOVGffY7Sx2NjsyXFjKQfLT96VKM+O34FtKd70okctx8ykxNBlLnEN8SprWXX1/xhZDauJ7luTSg44u6pidJndISGsVMoO6oiRcZypp+UoEncUvzJgUo2Vw6N/RkzJu0+nUVvysJCsWInZTNiEDyGZTMmJgLXWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G+wusVe6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4278WDBZ020674;
	Thu, 7 Mar 2024 08:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hxxfSt/V2kIxU74jTxTo63XdTt0LQWBgQ0OZjGD0LUg=;
 b=G+wusVe6KmlwvUaCqmZ1GL5TXSWPnu6wOMRJYcL9pNyteoJsefhI1QcUqSZvXz/2lFcS
 amRLelaD4/UFXJRn2XTB+gmwRH4QMixr3Vplx0AG4OZrA1AG1mRmS4L5ERks4ibWrO2D
 Kpopqpn5wmA9esjuEP53rn7LbaRAwWnnUh40Tc7RLLJPN70a3ezyh1Nn3ca5tQsMSq8V
 RNzWryI7A7JZUoaDe3Ba0VzJCNFmen22cwt3hK6fNif1WcvjSkH/TEVy6CwiyKKfY0Et
 SYmnq5EXb7+VM1OkNZ59kgp/fPARIQaib7eSeAG9o6lQa5MYNAgRa2Rqgax2dv4Q/5r/ 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5bgfys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:55 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4278uY9g032138;
	Thu, 7 Mar 2024 08:57:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5bgfva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4275wg6C010877;
	Thu, 7 Mar 2024 08:57:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52m1ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4278vlwA9306402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 08:57:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A99B20040;
	Thu,  7 Mar 2024 08:57:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3C6B2004B;
	Thu,  7 Mar 2024 08:57:44 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 08:57:44 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v6 3/3] sched/fair: Combine EAS check with overutilized access
Date: Thu,  7 Mar 2024 14:27:25 +0530
Message-Id: <20240307085725.444486-4-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: pdgD9pN-oaGrw84VU4hJ9SINOtnkmMDA
X-Proofpoint-ORIG-GUID: LstN7FprOKdg5cQOk6nzUPeIOu7BX0iO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070064

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
 kernel/sched/fair.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87e08a252f94..bcda18a2ccfe 100644
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
@@ -7989,7 +7986,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || is_rd_overutilized(rd))
+	if (!pd)
 		goto unlock;

 	/*
@@ -8192,7 +8189,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;

-		if (sched_energy_enabled()) {
+		if (is_rd_not_overutilized(this_rq()->rd)) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
 				return new_cpu;
@@ -10869,12 +10866,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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


