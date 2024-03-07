Return-Path: <linux-kernel+bounces-95174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B74874A41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5892B1F2196A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEE82D8B;
	Thu,  7 Mar 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LRRyTt9T"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53B657D5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801986; cv=none; b=ZyAwPwlbn8nVbQ73b6boaWDdWtchcN3LYhtaCZaaaYik3kkjHQ8vkkocs1CiH4DeMXguYBjoc9UOi4VSWUbapwnJK3uU1D9fITxyvfzd2LfRZ4U/DhPb2p4PEcIfkKd4mr9Pp+wAC0YFL5ow3oZf9gDNNgXzjopdLTAztupVXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801986; c=relaxed/simple;
	bh=in9euD7RnynsreKIHDYStuw2jxb4WZnJBqhQrmN9KkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LbUu4gfXq892bH1WljE5VJ9L7xvd0hT2X7M1Et+EMljzeepdvC68rkZkdKB16hfoBI4ZK7hBmROdpQ9+2XZM/xbKO12O9JxENIivKaQd3J7fcSZHJDObH7hOE35a9+4K1ZyvTYmtw1yiwU2lA+gEGBQAp/lvUKvxujAmLiEMjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LRRyTt9T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4278WoTP008751;
	Thu, 7 Mar 2024 08:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=zCBrT592VUSeAOXLJHm5G5Zx0UY+JL/SwULyKBYSlGs=;
 b=LRRyTt9Tak2g8wAeZhWfrDV//wJt/6peV10UTj1J+FrfpuSz6ICLT169i0MWly48Ni+B
 5RpPY+ElSddSMoL11QNUvxzwvyUaFQNoIp8vPFaY3YsrwQMjiLt7gS+XKEDj8U4AZIug
 aZ+6wDNrJQ9roMkhQyRhXzUtmgwkOY9EfjQIN4CQ/+dssZKhugfn1RyJu+offFvNGNvy
 NSqqtIz7pg/nrlRslyao+7dtgWqmxp4fcbqSTtdSsDJFOQPQ6aWMNBd6QR7ffUnxVjVh
 P6dUkh5rmmlFSeIUAqQ+jUEOj8Mr2eoayO35T6K9S52b37LGXHyZlqoBpWG2pZCIMKP8 iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5jrdex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:59:33 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4278WrlK008939;
	Thu, 7 Mar 2024 08:59:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5jrd5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:59:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4277Tc69026212;
	Thu, 7 Mar 2024 08:57:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep4f5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:57:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4278vXbp13107684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 08:57:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CBA02004D;
	Thu,  7 Mar 2024 08:57:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900B92004E;
	Thu,  7 Mar 2024 08:57:30 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 08:57:30 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v6 0/3] sched/fair: Limit access to overutilized
Date: Thu,  7 Mar 2024 14:27:22 +0530
Message-Id: <20240307085725.444486-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7hG9tuQGJi8A-MAh8fLTr0DfolaqRqpW
X-Proofpoint-ORIG-GUID: RsuuUOsf0BR_w62_vx4WVXMimh_uYxgz
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
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070064

When running an ISV workload on a large system (240 Cores, SMT8), it was
observed from perf profile that newidle_balance and enqueue_task_fair
were consuming more cycles. Perf annotate showed that most of the time
was spent on accessing overutilized field of root domain. Similar perf profile
was simulated by making some changes to stress-ng --wait. Both
newidle_balance and enqueue_task_fair consume close to 5-7%.

Overutilized was added for EAS(Energy aware scheduler) to decide whether
to do load balance or not. Simultaneous access to overutilized by
multiple CPUs lead cache invalidations due to true sharing. Updating
overutilized is not required for non-EAS platforms. Since overutilized and
overload are part of the same cacheline, there is false sharing as well.

Patch 1/3 - Main patch. It helps in reducing the above said issue.
Both the functions don't show up in the profile. With patch comparison is in
changelog. With the patch stated problem in the ISV workload also got
solved and throughput has improved.
Patch 2/3 - Code refactoring to use the helper function instead of
direct access of the field. Keeping this patch so patch 3/3 becomes
easier to understand. Depends on 1/3.
Patch 3/3 - Refactoring the code since most of the patterns are observed
are eas && !overutilzed. Changed the helper function accordingly.
Depends on 2/3.

More details can be found in cover letter of v1.

v5 -> v6:
- Mades minor changes for !CONFIG_SMP cases as pointed out by Vincent.
v4 -> v5:
- Added EAS check inside helper functions instead of sprinkling it
around. EAS check is static branch at best. So that keeps the code
simpler.
- added EAS check inside cpu_overutilized as suggested by Qais.
- Added patch 3 since most of the code does eas && !overutilized
pattern as suggested by Vincent.
v3 -> v4:
- corrected a mistake where EAS check was missed.
v2 -> v3:
- Pierre and Dietmar suggested we could add one more EAS check before
calling cpu_overutilized. That makes sense since that value is not used
anyway in Non-EAS case.
- Refactored the code as dietmar suggested to avoid additional call to
sched_energy_enabled().
- Minor edits to change log.
v1 -> v2:
Chen Yu pointed out minor issue in code. Corrected that code and updated
the changelog.

v1: https://lore.kernel.org/lkml/20240223150707.410417-1-sshegde@linux.ibm.com/
v2: https://lore.kernel.org/lkml/20240228071621.602596-1-sshegde@linux.ibm.com/
v3: https://lore.kernel.org/lkml/20240229104010.747411-1-sshegde@linux.ibm.com/
v4: https://lore.kernel.org/lkml/20240301151725.874604-1-sshegde@linux.ibm.com/
v5: https://lore.kernel.org/lkml/20240306102454.341014-1-sshegde@linux.ibm.com/

Shrikanth Hegde (3):
  sched/fair: Add EAS checks before updating overutilized
  sched/fair: Use helper function to access rd->overutilized
  sched/fair: Combine EAS check with overutilized access

 kernel/sched/fair.c | 72 ++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

--
2.39.3


