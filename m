Return-Path: <linux-kernel+bounces-101656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9487A9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F4F1F2531B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5445978;
	Wed, 13 Mar 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MboPjkNi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D27446B4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342143; cv=none; b=JqI2I5Zj+P3aSHMqTNUC0HVlP04mkJyNlNpv2w41VSiZwZwGsEfb/VYPVL8iI+3qOYXkBAgE7Sq3Xu0sROyYFckdg45rygIdQEScoNh5nCScpEm0p5anmMhFBjzQmAGKPWdR8OnWClGCd9Zmst05KrOi3MChVaGZImifGcO+3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342143; c=relaxed/simple;
	bh=OYHeCdoch8Nm4ywfv4eWB35vEDiCrEqFtw1Oyl2Qs58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joxRGVN8t0gH1nyeNHgx6Yaw+dK14LMImzF0Ut2kdnmTGtmdRZbkN9Cq4s0zHAwSU7JLPfNua6Dhn0v4B7uIyUWVBhh9S1/oo61VYBmz/7i8ICrOFMGANUeAkDfcuk8EgTNz/jgjol1E9KeH+ZYw0OEqVRULbMsoWS2sf97oifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MboPjkNi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DDkCuK016065;
	Wed, 13 Mar 2024 15:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qr/x9mWPGexA7zxG6Eg+5pVKBlygqLXncydSqd7r7jA=;
 b=MboPjkNiY+j2gys2v11btmBBS39JJC2MTt5U5n9oAtOHR/gDZMqpPG9n9R2RXCA2Oo0M
 7+96oQ+fs6kUdD+seTo56/oHhSVfTah1fxUxu2/KMveFMhWcLmGaBsHSxcszQxuByCvA
 mJd6v57HnqhegEXMEJk8zxzSQP8QQwTsUHuN+gBVI4mCw6ua5OFYTxPbEI5J2DIEvEJX
 1xt+BaoDmD2B26y4Oxoettws5V2srd2oB5kHGkhBYck2q83NOs3ROdZ6u/FXrv1476nn
 cwxHMcmaSaIQLsfF0W83IZ39fD16SnafsMnOS5Ys1xXyA+hecqOvZRFo6ENAX1Ux4Nki zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wud0msqw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:02:03 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DF04fr028780;
	Wed, 13 Mar 2024 15:02:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wud0msqvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:02:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DEgaJB018621;
	Wed, 13 Mar 2024 15:02:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t262w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:02:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DF1up250725176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 15:01:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98FA32004D;
	Wed, 13 Mar 2024 15:01:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDDD520043;
	Wed, 13 Mar 2024 15:01:53 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.39.162])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 15:01:53 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com, qperret@google.com,
        yu.c.chen@intel.com, srikar@linux.ibm.com, pierre.gondois@arm.com
Subject: [PATCH 1/2] sched/fair: Check rd->overload value before update
Date: Wed, 13 Mar 2024 20:31:32 +0530
Message-Id: <20240313150133.1182298-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240313150133.1182298-1-sshegde@linux.ibm.com>
References: <20240313150133.1182298-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: runK8kNDYGBk5WfLqfxsZCURQj-6dE2J
X-Proofpoint-ORIG-GUID: PCqAQ3RuYAyK14ZyQQjdr0KpQ4RtoRXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 mlxlogscore=608
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130111

Overload is an indicator used to inform if there is any rq in the root
domain has 2 or more running tasks. Root domain is a global structure per
cpuset island.

Overload status is updated when adding a task to the runqueue.
It is cleared in update_sd_lb_stats during load balance, if none of the
rq has 2 or more running task. It is used during to newidle
balance to see if its worth doing load balance. If it is set, then
newidle balance will try aggressively to pull a task.

Since commit 630246a06ae2 ("sched/fair: Clean-up update_sg_lb_stats
parameters"), overload is being updated unconditionally. The change in
value of this depends on the workload. On typical workloads, it is
likely that this value doesn't change often. Write causes the
cacheline to be invalidated. This would cause true sharing when the same
variable is accessed in newidle_balance. On large systems this would
cause more CPU bus traffic.

Perf probes prove that actual change in value is less often. So it would
be better to check the value before updating it. Detailed perf probes
and annotation can be found in the cover letter. CPU bus traffic reduces
with the patch.

Fixes: 630246a06ae2 ("sched/fair: Clean-up update_sg_lb_stats parameters")
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02d4d224b436..eeebadd7d9ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10621,7 +10621,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd

 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
+		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
+			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
--
2.39.3


