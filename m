Return-Path: <linux-kernel+bounces-119304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677388C6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81C21C3B398
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F413C833;
	Tue, 26 Mar 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VcX+Gl+7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089613AD03
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466814; cv=none; b=Oe9g3z44kxpv49maGvx0XgIwOd46YH6rjY024owrhWPhN+CuNIBXvIoTpRCpAluVxY29x2umtnrXwcfOepvk50sT2tuSqsCH2n/kVMwK/QTpd7RHi58d7QT+rzamfT5k5Iovr3PsztNhNPpun26PkTafPEcSlLER6kMIdChQTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466814; c=relaxed/simple;
	bh=mkjtb6GjqiKzKAPgPuP/1snQCK9mmOWP03fV8t4a17Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vc2iHDxdjrczVeHP/Tb04aYCewC4eE/LRpizXuOKcSeiXILr6UZTVXwSr99zCS+mpRWyPgksxI9+6GvsIADLGliMeT6Un0wIvKFf1y+Y+0p96kGMbFkedph5vX8bB4YhAwFtplSLJqdpquveEdzOTgBlv/OVrrq91xzXkG61cYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VcX+Gl+7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QF2EuO016707;
	Tue, 26 Mar 2024 15:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ADnlaU9yoIddQghLF+HT2oM/IhYvEt7oWPcLJzNLTJw=;
 b=VcX+Gl+7OmHAQdazYXptmKAzEXnkHd5Xr6ckc0sfyzFyy2aIsZQBDemhV7fI8CYw6Uk1
 9TPdg0wYujBSQKZPmOevXHCt688h5yuEUhcRsrwmOFdH4/kFgUd2RlPe8Qwi89OGmQPK
 4eP58YC/BNwpHjkIWM71T/la4bs+Lnzeah5De4+xEZgVC6YBlV9OH2leVIo+t2M5SQiJ
 sk/zolzaMVidPzrld6vW4fOkr9Q28AQ/ucNjJmJcjFe9RnQQsPAZArxEFaQ5/l+3HvYB
 ol679sVmvQp3vdqXi5fwNOk6jB2xLBq7zlAMDAnUu3/DiIVo1lE0dzyAo5BK1X0sbkwz Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x40n8g2aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 15:26:40 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QFQeeC026560;
	Tue, 26 Mar 2024 15:26:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x40n8g2au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 15:26:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QEoe7a003753;
	Tue, 26 Mar 2024 15:26:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42r0hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 15:26:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QFQZx643712916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 15:26:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B2D2004F;
	Tue, 26 Mar 2024 15:26:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1FED20040;
	Tue, 26 Mar 2024 15:26:33 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.195.45.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 15:26:33 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: [PATCH] sched/fair: Combine EAS check with overutilized access
Date: Tue, 26 Mar 2024 20:56:16 +0530
Message-Id: <20240326152616.380999-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hoe224IwZV7rjmUitiMHN-qNC_ofaZFe
X-Proofpoint-ORIG-GUID: JKlNLV9Ms6ahX3IeleiMUdMVfsxmkJUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260108

Access to overutilized is always used with sched_energy_enabled in
the pattern:

if (sched_energy_enabled && !overutilized)
       do something

So modify the helper function to return this pattern. This is more
readable code as it would say, do something when root domain is not
overutilized. This function always return true when EAS is disabled.

No change in functionality intended.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24a7530a7d3f..e222e3ad4cfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
 }

 /*
- * Ensure that caller can do EAS. overutilized value
- * make sense only if EAS is enabled
+ * overutilized value make sense only if EAS is enabled
  */
 static inline int is_rd_overutilized(struct root_domain *rd)
 {
-	return READ_ONCE(rd->overutilized);
+	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
 }

 static inline void set_rd_overutilized_status(struct root_domain *rd,
@@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 * overutilized field is used for load balancing decisions only
 	 * if energy aware scheduler is being used
 	 */
-	if (!sched_energy_enabled())
-		return;

 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
@@ -7999,7 +7996,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || is_rd_overutilized(rd))
+	if (!pd)
 		goto unlock;

 	/*
@@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;

-		if (sched_energy_enabled()) {
+		if (!is_rd_overutilized(this_rq()->rd)) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
 				return new_cpu;
@@ -10903,12 +10900,9 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;

-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
-			goto out_balanced;
-	}
+	if (!is_rd_overutilized(env->dst_rq->rd) &&
+	    rcu_dereference(env->dst_rq->rd->pd))
+		goto out_balanced;

 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)
--
2.39.3


