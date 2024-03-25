Return-Path: <linux-kernel+bounces-116550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964888A4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427EAB32CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75514265E;
	Mon, 25 Mar 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Def8TlyZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AF1422DE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345532; cv=none; b=U6/MN0rHTEYNo4AzYmF3VG0qjebCi/8SPurKI/ozjHyZ5H3ymn11d4m/pl2G1s71fcLseqsxmGNr6LljE0/P0XSKbXoiAP/MR0ibwvvoHjUs1rpLg0i7koDrmEQ/sqGcs2R3ZS7untw67zrEqFFauIkhl1Mq1e6DOblPuy9puOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345532; c=relaxed/simple;
	bh=3003hjwxlKjpdM/HTmVW3IjXQTa9b3lBarRdaHkd+Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBBwwenRfoFxPOvyqhGOc6AEce+2t/eRDw7aeiZ2+jnMYdqoQZgNxKmsqpWf3+wKJtarVJVgEJAUAMFPLOek2IKpPp0ZC9ohoLQxjsSGMX0wYtZB3POnw2gnzVZ5QHTGOE4NT6omtDqPomuIr58phdWEWlumN7mc8fcJ2pp0NcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Def8TlyZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ONoMxG030563;
	Mon, 25 Mar 2024 05:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YlGXSj5DSsi3seogjbHk3vlyDbRmRCvlpJOwGGPesu4=;
 b=Def8TlyZH4eVrCQJUWHbfBj6SY+kQVKgR74D5iDwMODCFTbL6ikpYXruGFZr4Y5XcqKD
 cc9yh/RSZrh1ZnQvR0E1PbyGPFAntD+m4AmgmHV1fvVo9l6R/J37zVYz7tN0Z2yrBlz2
 ePGHlZo6pUID5rHz3fszE1uipySmX5nHSuzbfzy2BZx3ihU0UwZlVvfW6Axgn1piKrdQ
 TIgfZwuklNB45VF4U7BSFah1P0DmQfi1rpuahNrgqd8faEJ1hVTPuZTHCDCCiz4ORPf4
 9j46fO+8XeFHNIUdS040SSabiYAuQbdGGQ9xY15ZxhLklBJI2VwzJTK3mpdUXGLa90R9 uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2h6t1hbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:45:19 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42P5jJNN024195;
	Mon, 25 Mar 2024 05:45:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2h6t1hbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:45:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42P3giWA011233;
	Mon, 25 Mar 2024 05:45:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmkpp1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:45:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42P5jECW27984134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 05:45:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC5702004B;
	Mon, 25 Mar 2024 05:45:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E52920043;
	Mon, 25 Mar 2024 05:45:13 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 05:45:12 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: [PATCH v3 1/2] sched/fair: Check rd->overload value before update
Date: Mon, 25 Mar 2024 11:15:04 +0530
Message-Id: <20240325054505.201995-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240325054505.201995-1-sshegde@linux.ibm.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zL1M1edLB8lmiCnn293hjeN7-TR5UjCG
X-Proofpoint-ORIG-GUID: B63sQfFj_90BstVCm4XSra9KUhUIbVXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=646 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250029

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
variable is accessed in sched_balance_newidle. On large systems this would
cause more CPU bus traffic.

Perf probe stats for reference. Detailed info on perf probe can be found
in the cover letter. With Patch while running hackbench.
1M probe:sched_balance_newidle_L38
139 probe:update_sd_lb_stats_L53
129K probe:add_nr_running_L12
74 probe:add_nr_running_L13
54K probe:update_sd_lb_stats_L50

Perf probes prove that actual change in value is less often. L50 vs L53.
So it would be better to check the value before updating it. CPU bus
traffic reduces with the patch.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
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


