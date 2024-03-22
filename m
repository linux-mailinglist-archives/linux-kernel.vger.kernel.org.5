Return-Path: <linux-kernel+bounces-111596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA3886E57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E7828B491
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207747A64;
	Fri, 22 Mar 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QArpZ2fQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2C4D108
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117024; cv=none; b=qU8fjZwVptokTodYq0GXtRe6zczAbpifcD/wHiNlMZCY0VAzLiuoiJNANAlpRNDeLG1hIqqrPFWjwYkN0ZbLUcPvt39lWjChqK+udkDs0AhFYdko6IjlJlVGmIwE8FNAUz1JrBGI3adhwTjTnQgYBrxxyARxU1jd8APqStFjJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117024; c=relaxed/simple;
	bh=nzmvJ2Da21EGOoC2LV82UVtcJnBfX0RAgLO8+F7yjI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KzqjO3ZmVGFGwXRgP33sJZo4hulH3QHr3Cug9boFAEkz4CptX6YCUT1Vzz+/lNPZwoqjMV573zSROIdFnhVMpXt/IxHlav1JTNE+yMjhPGhGNO2vRHdg7Qz/z1b1rUWJI/nT9FotzkC7qijy5F17NmgBoH2F7nnHyb80J5G9P0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QArpZ2fQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDrw6U007780;
	Fri, 22 Mar 2024 14:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fff65kbBg/0vIwu1F0t0Lp3Emtu+jUfGI4js74NSBC8=;
 b=QArpZ2fQ042VgT1P/WLgCb0huP7zNYkpia+dM9JQ6g60tV76kBQSw6TcFyfSXxBJIg7b
 pBkiPVIuwrF1TSVAdsMU541zMyzEZVgLMYn28kYOGBd4/IBNrwpyoTniVRDum0hy1U9n
 gmZKZpuEerGUgH7GFOrdjweAOTaY5AB6FtK5/IKr5yP+0FBsUts3RgLkR5/U/boVBvY1
 1Z1Bg91u12acdH0CUb+iPu0Y3xZYq0XhDr78YTK3r2UDhxPDNvclFFxg1rBH3VJktqos
 4K07vsAu7BQVtDbH9ti+Fe1Oul2fBhASba0hpWtCYMI2lxyvBel2S9HeMrZ8b9bph1L0 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x1b910d34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:44 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MEGite013261;
	Fri, 22 Mar 2024 14:16:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x1b910d31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42ME44WY015696;
	Fri, 22 Mar 2024 14:16:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x15p3bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 14:16:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42MEGdlK31195692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:16:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC5C820040;
	Fri, 22 Mar 2024 14:16:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED5432004F;
	Fri, 22 Mar 2024 14:16:37 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.195.40.125])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 14:16:37 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com, qperret@google.com
Subject: [PATCH v2 1/2] sched/fair: Check rd->overload value before update
Date: Fri, 22 Mar 2024 19:46:31 +0530
Message-Id: <20240322141632.28654-2-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: mSC9w7f90vDTXpXILZhI_clHqp9c6X5C
X-Proofpoint-ORIG-GUID: 9yTo0I81lZWDiIYj1__lUeUuB_O9SLkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=642
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220101

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

Perf probe stats for reference. Detailed info on perf probe can be found
in the cover letter. With Patch while running hackbench.
1M probe:newidle_balance_L38
139 probe:update_sd_lb_stats_L53
129K probe:add_nr_running_L12
74 probe:add_nr_running_L13
54K probe:update_sd_lb_stats_L50

Perf probes prove that actual change in value is less often. L50 vs L53.
So it would be better to check the value before updating it. CPU bus
traffic reduces with the patch.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
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


