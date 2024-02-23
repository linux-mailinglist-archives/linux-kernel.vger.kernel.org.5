Return-Path: <linux-kernel+bounces-78573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B056E86153A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BA3286785
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9CF81ACB;
	Fri, 23 Feb 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vdj0i60F"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11360260
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700889; cv=none; b=DwW6bVUxJbn1OjTH1wsTfIYV2NtsYHEE2xk3f6KACXgELRHfrgVysX5nheLPNRRBTUb8o26T7IzsYgVHIyRLRc9NFKj1qlH1tfrVfXbWGIKvgcm3IhCru+CqB72XtlB0fmJOBIQxkmOguMwfxPRcMW8nCBoDbS//TUzlnJcOTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700889; c=relaxed/simple;
	bh=skrSRwZuBvtdVUuRkNsweCyQLPd/DhiIpjJxrmh3Fk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a3F+Sb4UtdJNft0RcL+sXIpqQQ5OdpWMyvfgPloDVjAgdyNV14PnTuUvZ1BMb7/NvBMeNNizdJ/W/upHsz9PV6469mXwf1q9igODTdGLl+eclTpyNRf5/2FbUrSgSpeBq8yhavwAHtna/wtnZztDjdlTMSDvZBlJ5M5xz6mEWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vdj0i60F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NF1KVq016417;
	Fri, 23 Feb 2024 15:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QoIUJOIn9IVI6STldQBwBodmUw8MT6yN0RT2hGipzGk=;
 b=Vdj0i60Fy7w//OmraVDr4fsvsgBwHyYycm6orO9dX1FAgJs/tFXirqgDLm1uMPVRfuKc
 R6cD7+dqbtYdFYLQnYHrzzlw8fopAXIwwZMSWIhtrcv34WowQhDu1owqluNEl4tSH2vi
 14EV7Jehl3cYjHZISZW33Agt6+/AFhWfqK8cCohnWrJ67h3t4RlTdsgEfNWk3QIeUaCp
 4ZBz2bgMlsDONRAWJVT0Ga1f30vwlEhazYyyKEWmbcmu2t2wx9d2J3BWbqbpJKAXW+z1
 09tohKeB8ZLhEwtvpOEWTE5Prr8XkQARQib9i13RHCMON+0NYSqOMAAShUUmlv5p2ueF Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wew9j8r5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NF1XZZ019044;
	Fri, 23 Feb 2024 15:07:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wew9j8r5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NDHEqs003671;
	Fri, 23 Feb 2024 15:07:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u6c4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:07:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NF7XPm53870910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:07:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0537220043;
	Fri, 23 Feb 2024 15:07:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE9B20040;
	Fri, 23 Feb 2024 15:07:30 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.125.115])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:07:30 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH 0/2] sched/fair: Limit access to overutilized
Date: Fri, 23 Feb 2024 20:37:05 +0530
Message-Id: <20240223150707.410417-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JE4Q5ghADXp5UIon3PUDDfxWZWydNAIb
X-Proofpoint-GUID: JLw4Py0rjDGjPj3HjiXGzUpL3Y6U29Qk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=868 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230110

When running a ISV workload on a large system (240 Cores, SMT8), it was
observed from perf profile that newidle_balance and enqueue_task_fair
were consuming more cycles. Perf annotate showed that most of the time
was spent on accessing overutilized field of root domain.

Aboorva was able to simulate similar perf profile by making some
changes to stress-ng --wait. Both newidle_balance and enqueue_task_fair
consume close to 5-7%. Perf annotate shows that most of the cycles are spent
in accessing rd,rd->overutilized field.

perf profile:
7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
6.78%  s                [kernel.vmlinux]              [k] newidle_balance

perf annotate of enqueue_task_fair:
    1.66 :   c000000000223ba4:       beq     c000000000223c50 <enqueue_task_fair+0x238>
         : 6789             update_overutilized_status():
         : 6675             if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
   95.42 :   c000000000223ba8:       ld      r8,2752(r28)
    0.08 :   c000000000223bac:       lwz     r9,540(r8)
Debugging it further, in enqueue_task_fair:
ld      r8,2752(r28) <-- loads rd
lwz     r9,540(r8)   <-- loads rd->overutilized.
Frequent write to rd in other CPUs causes load/store tearing and hence
loading rd could take more time.

Perf annotate of newidle_balance:
         : 12333            sd = rcu_dereference_check_sched_domain(this_rq->sd);
   41.54 :   c000000000228070:       ld      r30,2760(r31)
         : 12335            if (!READ_ONCE(this_rq->rd->overload) ||
    0.07 :   c000000000228074:       lwz     r9,536(r9)
Similarly, in newidle_balance,
ld      r9,2752(r31) <-- loads rd
lwz     r9,536(r9)   <-- loads rd->overload
Though overutilized is not used in this function. The writes to overutilized
could cause the load of overload to take more time. Both overload and
overutilized are part of the same cacheline.

overutilized was added for EAS(Energy aware scheduler) to choose either
EAS aware load balancing or regular load balance. Hence these fields
should only be updated if EAS is active.

As checked, on x86 and powerpc both overload and overutilized share the
same cacheline in rd. Updating overutilized is not required in non-EAS
platforms.  Hence this patch can help reduce cache issues in such archs.

Patch 1/2 is the main patch. It helps in reducing the above said issue.
Both the functions don't show up in the profile. With patch comparison is in
changelog. With the patch stated problem in the ISV workload also got
solved and throughput has improved. Fixes tag 2802bf3cd936 maybe removed
if it causes issues with clean backport all the way. I didn't know what
would be right thing to do here.
Patch 2/2 is only code refactoring to use the helper function instead of
direct access of the field, so one would come to know that it is accessed
only in EAS. This depends on 1/2 to be applied first

Thanks to Aboorva Devarajan and Nysal Jan K A for helping in
recreating,debugging this issue and verifying the patch.

Shrikanth Hegde (2):
  sched/fair: Add EAS checks before updating overutilized
  sched/fair: Use helper function to access rd->overutilized

 kernel/sched/fair.c | 50 +++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

--
2.39.3


