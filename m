Return-Path: <linux-kernel+bounces-154543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A708ADD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540181C217D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7527225DD;
	Tue, 23 Apr 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FQoap4t/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC5224F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853165; cv=none; b=ds3CPhCicH8BvFfGf8Tk29jwNJUXRRUNa1UKIuGHfrSBuZvznObQ5WBdvyuKj/STXfMr6uFfkVO9RrSdWCUCeg6aD5WeFW1DvoNtqD4Ct3EWXRcko26v38ip+P8Y7g78abGoAxb9efLM+hBkWj6JncbO/Lr0ki4bNjStZjocJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853165; c=relaxed/simple;
	bh=ph27R2BpTXuBHduVqEABAOReSVn97erbrODtQLq8Aws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2lIe0bkjAznCiYpVcLlEx4EqmHHp3TwWt1igb0YNp468cV5PCVN9mWBFcVPh18dym+LBFhKgwGx2Sek+gmoDtUpQz5SMCbvgOaCE3w52Zsz4EUeKJaqfyewKj3j9xLbncEZv4bNSu2bRAQawGW25qf0htFQlQvSv8ahr6IUu+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FQoap4t/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N4wZCT018703;
	Tue, 23 Apr 2024 06:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rebl4XUF5d1t4s+WaACiDs/1mUsMeB5uRLuPowNxmS8=;
 b=FQoap4t/NHJHT6itWRjR8lD/qI5D7eOVqnq6hFOV4+K8k61Darn83Z/96JPR8cKZDyxG
 j0VmiRgVddXJd+D4JSztJZbhoKgGPG9bnWvnJkCY+s9SIu+mY4JYYIIi3il00FjohtyC
 U+y4ZxwiJnM4NlZgwDB8Lql/usYF7M1PkHJeNInulhBwBGggVTEvnenmV8MsCFPoHAZf
 0Ni4xmiMzmlLIZG6TBCbqwfM3Px0e2CFHvD1kMMEIPdbqZdzvizV0GFjG4+GxcNLyu20
 f1zUvNerHgzH8+q2osYDa9cZztBt0j071VM4X4EVxnn4lxLVcbc2SytlRMNRk5Vie4kj RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp620g7a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:19:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6JCAM030988;
	Tue, 23 Apr 2024 06:19:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp620g7a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:19:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N6CrKZ029862;
	Tue, 23 Apr 2024 06:19:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmr1tc819-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:19:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N6J8Za48496928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 06:19:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 168BD2004E;
	Tue, 23 Apr 2024 06:19:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 069852004D;
	Tue, 23 Apr 2024 06:19:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 06:19:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id C0A03E0323; Tue, 23 Apr 2024 08:19:07 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: fix selection of wake_cpu in kick_pool()
Date: Tue, 23 Apr 2024 08:19:05 +0200
Message-Id: <20240423061906.2431968-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cv-AG6p42WDMwzLCyD3n36s9vVtCM0h2
X-Proofpoint-ORIG-GUID: okd2d6iM98--I46YMHzt3iKIK70FzNgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230017

With cpu_possible_mask=0-63 and cpu_online_mask=0-7 the following
kernel oops was observed:

smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 8 CPUs
Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000803
[..]
 Call Trace:
arch_vcpu_is_preempted+0x12/0x80
select_idle_sibling+0x42/0x560
select_task_rq_fair+0x29a/0x3b0
try_to_wake_up+0x38e/0x6e0
kick_pool+0xa4/0x198
__queue_work.part.0+0x2bc/0x3a8
call_timer_fn+0x36/0x160
__run_timers+0x1e2/0x328
__run_timer_base+0x5a/0x88
run_timer_softirq+0x40/0x78
__do_softirq+0x118/0x388
irq_exit_rcu+0xc0/0xd8
do_ext_irq+0xae/0x168
ext_int_handler+0xbe/0xf0
psw_idle_exit+0x0/0xc
default_idle_call+0x3c/0x110
do_idle+0xd4/0x158
cpu_startup_entry+0x40/0x48
rest_init+0xc6/0xc8
start_kernel+0x3c4/0x5e0
startup_continue+0x3c/0x50

The crash is caused by calling arch_vcpu_is_preempted() for an offline
CPU. To avoid this, select the cpu with cpumask_any_and_distribute()
to mask __pod_cpumask with cpu_online_mask. In case no cpu is left in
the pool, skip the assignment.

Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0066c8f6c154..a2af0aaf026b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1277,8 +1277,12 @@ static bool kick_pool(struct worker_pool *pool)
 	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
 		struct work_struct *work = list_first_entry(&pool->worklist,
 						struct work_struct, entry);
-		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
-		get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+		int wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
+							  cpu_online_mask);
+		if (wake_cpu < nr_cpu_ids) {
+			p->wake_cpu = wake_cpu;
+			get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+		}
 	}
 #endif
 	wake_up_process(p);
-- 
2.40.1


