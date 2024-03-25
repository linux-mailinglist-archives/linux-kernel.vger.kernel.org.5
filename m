Return-Path: <linux-kernel+bounces-117398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C162888AADE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E062E7D70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36A56B72;
	Mon, 25 Mar 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Omr2Ug9q"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1F1CD10
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381229; cv=none; b=hpOXCd8FMJqcX+BdVaMDIZyD+aKG3LuEEaFzxB/etTv58qvURQcOreBqIBw0EYjreZjF8DmtUizr0HFRL8psKLSXkN/r7SJpAiQOTMc/eWukNtxWJ0nVnmT0dAHIabD+ur1O8sD0zG6ohSmTBH7XMUAy0UGuA1TfUFyf3+wyv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381229; c=relaxed/simple;
	bh=RDTj58u2L6pJY0yAT+AAilYBkhFN6j8jun4h7jQVqi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9DqwEj7z2B4aX99Q30mN8+ihAbvYSENWppDWFnDeEZ7WQiUbmKem6mIVgEaA9sxz713Gr+V8+IaNbvwnWu4h01YpnqhpGX1W7lhowR8ap1ixFE3cR893p8vGbhX+SqVpo/4veCHKxnDeKdF6rFAa1eEI2NqQa3je/CrSjn8qSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Omr2Ug9q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBxpXd009469;
	Mon, 25 Mar 2024 15:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=BKxuORmBP5BftCyYrw5/0i1OlyrwAxyjIee01hLjLb8=;
 b=Omr2Ug9qAWUEAJIRcAbLfotN1oEy2Kz6Bo+vQjIPkAqYmQUAAAZ2qTuMiQkw34lkxMps
 Lda2Jhw5JkxPWIPFv35JyX2j/pAzIx8DIM5Vi+4Stzn8KaVVtKbaT0wbj/+yNSThqd6s
 y2DtNXyi8bXQt5YZUJGVS6tKykrMEprI4UOX5xppm5O0jinsrDrE4EZgXGU4rfvkLJ9W
 KcrnlBk+L4vEIqn0rNEf+Sky2GoXxMQDwnV9QiaOBIDecI4LrjA4Ic4LxDxhL0vryUj3
 TRJ8/ZhdjrBCYGy5S/fjx4JRYJB6ZHTZTNHYA861uNxp9+atEOMCqwfy5Bz/2XLFUidY HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2bhyb8b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:40:04 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PFe4jd002792;
	Mon, 25 Mar 2024 15:40:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2bhyb8aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:40:03 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PDV0wl016605;
	Mon, 25 Mar 2024 15:40:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dttc0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:40:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PFdx7W15204838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 15:40:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D862004D;
	Mon, 25 Mar 2024 15:39:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 424032004B;
	Mon, 25 Mar 2024 15:39:57 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.195.43.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 15:39:57 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, vschneid@redhat.com, joshdon@google.com,
        riel@surriel.com
Subject: [PATCH] sched/fair: Simplify continue_balancing for newidle
Date: Mon, 25 Mar 2024 21:09:26 +0530
Message-Id: <20240325153926.274284-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VwDaHz06k9uYDzAlQZtBxE7VYE_B-gAU
X-Proofpoint-ORIG-GUID: CJZUCqEYRSW8N7LHfFIifIFsFaMzlq-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250086

newidle(CPU_NEWLY_IDLE) balancing doesn't stop the load balancing if the
continue_balancing flag is reset. Other two balancing (IDLE, BUSY) do
that. newidle balance stops the load balancing if rq has a task or there
is wakeup pending. The same checks are present in should_we_balance for
newidle. Hence use the return value and simplify continue_balancing
mechanism for newidle. Update the comment surrounding it as well.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f00cb66cc479..d80535df8f03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12307,6 +12307,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
+	int continue_balancing = 1;
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
@@ -12321,8 +12322,9 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		return 0;

 	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
+	 * We must set idle_stamp _before_ calling sched_balance_rq()
+	 * for CPU_NEWLY_IDLE, such that we measure the this duration
+	 * as idle time.
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);

@@ -12361,7 +12363,6 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)

 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
-		int continue_balancing = 1;
 		u64 domain_cost;

 		update_next_balance(sd, &next_balance);
@@ -12387,8 +12388,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || this_rq->nr_running > 0 ||
-		    this_rq->ttwu_pending)
+		if (pulled_task || !continue_balancing)
 			break;
 	}
 	rcu_read_unlock();
--
2.39.3


