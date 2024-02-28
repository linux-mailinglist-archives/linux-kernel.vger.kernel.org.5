Return-Path: <linux-kernel+bounces-85326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30886B43D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5357128265E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A415D5D8;
	Wed, 28 Feb 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FE13DZ76"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA615CD4A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136644; cv=none; b=YfzONc39owFKOnzd73cRnJt8iLRV6FJV5XOAH71jZlehNrRBfuZ85Z9CmYl6LQkDc4tqA2i9G8TGEzQULN4sfMvXSBdqTQtMhzMN9MIeiAxFAKkcSBxJcof+2rY9bnlYNuOV7x5FMVr5LBVTOPChdOM8FNosYlKg8XpYEU68rfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136644; c=relaxed/simple;
	bh=fe8lOuxEMj1yMsRcOiFuSFp7gwfqXyve/jnu+J2Xg9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rIwaAa7oTDOMqwY0C9u5mVBNH342UT9XZvrBshaukOvt6Fb6GEC5gcGvrUcS3Q/ue6+MUxq4Lyhjnr8bivOJsIKShOEO5jnLLvHmETqwkMz5ze5Z1/8nAoly2cVQiDfgBF9raQ0PR5Tw4KEpAnMg8FybhEaGIbXm8j9646UO+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FE13DZ76; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SG00j7011011;
	Wed, 28 Feb 2024 16:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=lFzZ+uKK9jWdHGRqBfOIQfaRRz7nH+OApMLXZqmSw38=;
 b=FE13DZ76EJt6cOMeazEmd3luq6vjhV1izqWqqFILHjRq7J+wPBPkU41f7W/i/duxxU6O
 F2SyR82gdgLu5XjEBovjTiT3myUYOwsML3tqYv8baQLPqhXVU71w3B4e+MlaZ0zBUrYu
 V+3Cad3XXKgLGF1i5hT0AUODMncaYo4+4Akv+GAU5+2REpdRhXCakcyHb8FVXBdyeXaU
 Thlx5qYEh3ORDsYFaNZbK4MGXqWmcLD0jpAfmRk9Z4c7clnFtjpdebhdAkZLeW8Gq/q7
 7wZHpZGxMpc/e6QzHbpH5qkgE3AxYap9ckUrFD+b5XCFXVv+eXhnYdQciZuMwVSUPGhx Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7ybge9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:10:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41SFxwRa010832;
	Wed, 28 Feb 2024 16:10:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7ybge9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:10:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SDe9qQ008782;
	Wed, 28 Feb 2024 16:10:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstqkd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:10:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGAKGt28574014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:10:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D3C2005A;
	Wed, 28 Feb 2024 16:10:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FF9D2004F;
	Wed, 28 Feb 2024 16:10:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.184.61])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:10:20 +0000 (GMT)
From: Tobias Huschle <huschle@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, sshegde@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Date: Wed, 28 Feb 2024 17:10:18 +0100
Message-Id: <20240228161018.14253-1-huschle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U_5Hm9dPXdMRVcUqEwgF8Jr34BZT4MAW
X-Proofpoint-ORIG-GUID: htKPM3LVBjGR6p1vhcpzqx_CsnXtnahg
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402280126

The previously used CFS scheduler gave tasks that were woken up an
enhanced chance to see runtime immediately by deducting a certain value
from its vruntime on runqueue placement during wakeup.

This property was used by some, at least vhost, to ensure, that certain
kworkers are scheduled immediately after being woken up. The EEVDF
scheduler, does not support this so far. Instead, if such a woken up
entitiy carries a negative lag from its previous execution, it will have
to wait for the current time slice to finish, which affects the
performance of the process expecting the immediate execution negatively.

To address this issue, implement EEVDF strategy #2 for rejoining
entities, which dismisses the lag from previous execution and allows
the woken up task to run immediately (if no other entities are deemed
to be preferred for scheduling by EEVDF).

The vruntime is decremented by an additional value of 1 to make sure,
that the woken up tasks gets to actually run. This is of course not
following strategy #2 in an exact manner but guarantees the expected
behavior for the scenario described above. Without the additional
decrement, the performance goes south even more. So there are some
side effects I could not get my head around yet.

Questions:
1. The kworker getting its negative lag occurs in the following scenario
   - kworker and a cgroup are supposed to execute on the same CPU
   - one task within the cgroup is executing and wakes up the kworker
   - kworker with 0 lag, gets picked immediately and finishes its
     execution within ~5000ns
   - on dequeue, kworker gets assigned a negative lag
   Is this expected behavior? With this short execution time, I would
   expect the kworker to be fine.
   For a more detailed discussion on this symptom, please see:
   https://lore.kernel.org/netdev/ZWbapeL34Z8AMR5f@DESKTOP-2CCOB1S./T/
2. The proposed code change of course only addresses the symptom. Am I
   assuming correctly that this is in general the exepected behavior and
   that the task waking up the kworker should rather do an explicit
   reschedule of itself to grant the kworker time to execute?
   In the vhost case, this is currently attempted through a cond_resched
   which is not doing anything because the need_resched flag is not set.

Feedback and opinions would be highly appreciated.

Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
---
 kernel/sched/fair.c     | 5 +++++
 kernel/sched/features.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..c20ae6d62961 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5239,6 +5239,11 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		lag = div_s64(lag, load);
 	}
 
+	if (sched_feat(NOLAG_WAKEUP) && (flags & ENQUEUE_WAKEUP)) {
+		se->vlag = 0;
+		lag = 1;
+	}
+
 	se->vruntime = vruntime - lag;
 
 	/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..d3118e7568b4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,6 +7,7 @@
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 SCHED_FEAT(RUN_TO_PARITY, true)
+SCHED_FEAT(NOLAG_WAKEUP, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
-- 
2.34.1


