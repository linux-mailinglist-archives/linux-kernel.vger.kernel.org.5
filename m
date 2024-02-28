Return-Path: <linux-kernel+bounces-85327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1086B43E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DEF1F2A7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBC15DBC8;
	Wed, 28 Feb 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCHsQYDL"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816815DBA0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136647; cv=none; b=sE6BOrvP9XEPoHO/Uk3ADnct8U41n8SHOaSI6SLQQyO4cJgxje1YWzDpTG0THq1upRNnMcK3jz0I8XCZCwJfeQEmxCmOlcE7HwFn96lo8+oxusinPXRrPMSzGsokCHhOaRsZ82T22oOCCnuEyA8h89XOogWauR5k0oLINRJ9kpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136647; c=relaxed/simple;
	bh=v1bSpd7EZBi0oQJY2/Py1ZpaK7joUGkT60DVqbnWBFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bZQy/AaG5ze+rFW2otbwTtI0TbCxezY84mUVWtt0DTHiBRyLluXWPtZP4AHeX0gUAKkVrRAgIZfGfyVl4nVUjmc7/EnH444UvznYLdDMUVO5r02h+ZwIOCIuV0IKct6J7QH5Mc4SNUfmIK+/pow9OSzsptMeTiEERsnBqM8vohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCHsQYDL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SFxNhB017565;
	Wed, 28 Feb 2024 16:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=PwSXSRUcKgAuex/APKfO9GfUQIlgZ/cdR8FtLeeSPzE=;
 b=UCHsQYDL9rspywzoTnvMupK4NlLP5gRkd44dJdVMO0OOmOryTtcsbVyaiwn70jLGNtaj
 T8hzArYoLXw/F2um+74nzemGqF5A5s9doDwKJyw+MBUIyVp1oKAF4cUdvk4z7epvQQYE
 vneaCFlCkJw3Du6XliK5eQqzADAk1g59Jy40Z27ELkOlukZ2DPDsgQopavEAQf8XW45a
 BS7ZUNwM+3NsLpum6bz6qyLRCxIF6puQLkrDnfpbUBOlsE7KI+637jUfnAGpgakkKKcV
 ujCNIJS1pihRRieOo5FNC6DHkh98FRkTgZJvowgEreQHBLWtD9MZ3Xwr13rQz8XkTsaB hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7y4gd9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:10:32 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41SGAQDA000546;
	Wed, 28 Feb 2024 16:10:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7y4gd92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:10:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SE7R1u008154;
	Wed, 28 Feb 2024 16:10:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mf5rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:10:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGAPK665798436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:10:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19E82004B;
	Wed, 28 Feb 2024 16:10:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AED820040;
	Wed, 28 Feb 2024 16:10:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.184.61])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:10:25 +0000 (GMT)
From: Tobias Huschle <huschle@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, sshegde@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ankur.a.arora@oracle.com
Subject: [RFC] sched/eevdf: avoid task starvation in cgroups
Date: Wed, 28 Feb 2024 17:10:23 +0100
Message-Id: <20240228161023.14310-1-huschle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: blwDElUAfXDPrFVuEgBB2d8TXU1CasHd
X-Proofpoint-ORIG-GUID: -1uXiWq1bI4WPnP_w6-eQ_zUP4Xg5rEp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280126

When running update_curr, it is checked whether the current task has
missed its deadline (update_deadline). If the deadline has been crossed,
the task is set to be rescheduled if there are other tasks available on
its cfs_rq.
This can cause task starvation in some cgroup configurations.

Assume the following scenario:

           [ ]  rq of CPU
            |
           [ ]  cfs_rq1
          /   \
cfs_rq2 [ ]   othertask
         |
        curr

In this case, update_curr is called for all levels of the hierarchy,
starting at the leaf.
Assume that curr is a kernel task which does not give up the CPU
voluntarily, i.e. loops indefinitely unless forced to give up the CPU.
Assume further that curr has actually reached its deadline, the expected
behavior would be, that the scheduler determines that curr would now
start to overconsume and therefore should set the need_resched flag to
nudge the current task to allow a reschedule in favor of othertask.

To reach the expected behavior, it is not sufficient to check whether
other tasks are queued in the cfs_rq, which curr is assigned to.

In the configuration shown above, each run queue sees:
rq_cpu:  2 tasks
cfs_rq1: 2 tasks
cfs_rq2: 1 task

This means that cfs_rq2 will never reschedule on its own as it sees
no other tasks that would be worth rescheduling for. Hence, the
call to reschedule relies on the upper levels in the hierarchy.
cfs_rq1 sees 1 additional task and could therefore take the desired
decision. But, cfs_rq1 takes the additional task into account when
computing its own deadline, which means, its deadline lies further in
the future. This causes that its deadline is not being reached.
Therefore cfs_rq1 does not even check for other potential tasks to be
ran.

It could now be assumed that cfs_rq1 will reach its deadline at some
point. But, after curr has consumed its timeslice, all sched_entities
in the cgroup tree get reweighted. This causes the deadlines of all
entities in the hierarchy to be shifted further into the future.
This means especially, that the deadline of cfs_rq1 also gets pushed
into the future, causing it to never reach its deadline.
The decision whether a reweight needs to be done depends on the weight
of the sched_entity and a recalculated value of the shares the
sched_entity shall expect (see calc_group_shares in fair.c). These
values are, in the described scenario, always different, hence, reweight
is done.

The combination of these two circumstances can lead to curr
running indefinitely unless interrupted by an external entity.

Address this issue by rather checking for the nr_running value of the
rq of the CPU itself, i.e. if there is any other task, somewhere on the
CPU runqueue, give it a chance to execute.

The scenario that made me discover this is being discussed here:
https://lore.kernel.org/netdev/ZWbapeL34Z8AMR5f@DESKTOP-2CCOB1S./T/

Questions:
1. Is this behavior by design? I couldn't find an explanation why we
   only check for the local cfs_rq. Do we only want to allow take-overs
   from the same cgroup hierarchy level in that case?
2. This problem is referred to as the "hog"-problem by Ankur Arora here:
   https://lore.kernel.org/lkml/20240213055554.1802415-24-ankur.a.arora@oracle.com/
   Might there be a connection, it's the same piece of code in the end. I'd also
   prefer the boolean passing to avoid calling resched_curr too often.
3. Which are the criteria for which I should expect a reweight of the 
   cgroup hierarchy? It seems unintuitive too me, that the shares value
   keeps changing every time.

Feedback and opinions would be highly appreciated.

Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61c4ef20a2f8..e9733ef7964a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1015,7 +1015,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * The task has consumed its request, reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
+	if (rq_of(cfs_rq)->nr_running > 1) {
 		resched_curr(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
 	}
-- 
2.34.1


