Return-Path: <linux-kernel+bounces-101657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962287A9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF521C21E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836DBE7F;
	Wed, 13 Mar 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZeNIHI5Q"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50A47A79
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342149; cv=none; b=p8D5zg0KiMHtEs+l1TI7Lg4t9IQ7XQ26LcduO6TWGZJn2IFW7G24aesH3bGUUVRZYB8wlEdvhvmnfUicNh7qcb6btBfWQNH2XhBtMLn5MfB9dbCllmUgpdq/+lqsJheg/dW7nGuUzRBvzTOP6aStg233whstnn9lb1cb/C5YMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342149; c=relaxed/simple;
	bh=ZLbCFwnKFGY0jbbm/bywBULr1UhtSLUxPSSTEzbDMdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjgFEz8+qhXc4BaC7GIE+fXywaIVd2OE/2Nsj7vKaUlH8/Uzy/f5nt6+bs5lcK+e8cdO26T/lA5wDpYUMGYSjGS0mu9mHNrzCpSKFsQ3rnMz3MUusSlzeU1I+JnujZOtIOE+gbyQHejn78gEZKFXqynl+1QhOju8l4+d28azDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZeNIHI5Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DEx7lo015553;
	Wed, 13 Mar 2024 15:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8QedkPvVxsYjKF4GkxegEq1KNd/vznZSwCtIU82pQ1A=;
 b=ZeNIHI5QLqETBRkefA4qYmPVb10Qa9F0uqrFe5fT/uCLX3w4KlYj2yIO/Auvo2ORSJL7
 lxaYfdwdrWFOPOnRhdNuL1DEP+6YP/dOciMUxDXbbxJNS6J+jCyAR7vGH3gM7FyKuZCz
 TC0SzUdInbjF254hv0DvmfbWH+HJh7u7fzXSxV3nzte6g9ASXvRqfvHz9xLpBTSwxsEM
 BYhDGXadPKC8GHALBvmpyKL4FxMnH+1soExj95Yo+VikaRyK3yd8nZDDWX4gFHb+UBtw
 P9UGywb3cqycbYh6z/DV9i2WaCFDMow2/pQwdaK/wmkB/qJxpsCOfteXKxtxuDWPnCqQ NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuecp81r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:02:08 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DF27nQ025556;
	Wed, 13 Mar 2024 15:02:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuecp81qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:02:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DCKbwE015539;
	Wed, 13 Mar 2024 15:02:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fyxqgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:02:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DF20tB28705058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 15:02:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B839320043;
	Wed, 13 Mar 2024 15:02:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14BFC2004E;
	Wed, 13 Mar 2024 15:01:58 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.39.162])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 15:01:57 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com, qperret@google.com,
        yu.c.chen@intel.com, srikar@linux.ibm.com, pierre.gondois@arm.com
Subject: [PATCH 2/2] sched/fair: Use helper functions to access rd->overload
Date: Wed, 13 Mar 2024 20:31:33 +0530
Message-Id: <20240313150133.1182298-3-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: fawAxr_cExQIzEiPA_h85Xp9qSIX6whp
X-Proofpoint-ORIG-GUID: otkCRwm48X6KkZRG79qiRiPine_wqtJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=784 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130113

rd->overload is accessed at multiple places. Instead it could use helper
get/set functions. This would make the code more readable and easy to
maintain.

No change in functionality intended.

Suggested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c  |  7 ++++---
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eeebadd7d9ae..cee99c93e6a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10621,8 +10621,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd

 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
-			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
+		if (is_rd_overloaded(env->dst_rq->rd) != (sg_status & SG_OVERLOAD))
+			set_rd_overload_status(env->dst_rq->rd,
+					       sg_status & SG_OVERLOAD);

 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
@@ -12344,7 +12345,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);

-	if (!READ_ONCE(this_rq->rd->overload) ||
+	if (!is_rd_overloaded(this_rq->rd) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

 		if (sd)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41024c1c49b4..c91eb8811bef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -918,6 +918,16 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 extern void sched_get_rd(struct root_domain *rd);
 extern void sched_put_rd(struct root_domain *rd);

+static inline int is_rd_overloaded(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overload);
+}
+
+static inline void set_rd_overload_status(struct root_domain *rd, int status)
+{
+	WRITE_ONCE(rd->overload, status);
+}
+
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
@@ -2518,8 +2528,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)

 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
-		if (!READ_ONCE(rq->rd->overload))
-			WRITE_ONCE(rq->rd->overload, 1);
+		if (!is_rd_overloaded(rq->rd))
+			set_rd_overload_status(rq->rd, 1);
 	}
 #endif

--
2.39.3


