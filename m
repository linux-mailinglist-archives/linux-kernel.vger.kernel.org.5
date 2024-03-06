Return-Path: <linux-kernel+bounces-93752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E593873423
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241C0281B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE75F848;
	Wed,  6 Mar 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h4oiwLvB"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF2604AE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720733; cv=none; b=IJ1Va4EgVCSBqp4TOiwBCW3WTgiosudqA9GAtpi/YPtZoeS6ZvH5A/g6MYR1ffXspNeBFnBhR7uW5wkXU9KtD6TZvRmHplX7uS+NrkMiP3R6XVTwWCJ96vLJCQh6xx7UJMUOWxPV3QLfuis6fMFHkSt7FTGHhQNnXgPJ+MfrkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720733; c=relaxed/simple;
	bh=Qh3p17Ehza0Jx56BK0JD5/ySilZimcf/y8rGiNa88gY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfk2DL/fhJcPn1CGmfj0YDX7jz+d4nvoWoxT0q8Vzo7EVX8dXnctJ9LLpfz+bFtqZsj/LyC/VdQI11CtpCeM0klPKuUerswIlzaVXltLaB+WGtUHPTu2CnPg+xdTsYM5Xp6nRLk7j/CfBHiUYojyC+wAr+HWfhUyxqlvEwVO0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h4oiwLvB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426ACHA2000781;
	Wed, 6 Mar 2024 10:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=vm6ipVS9+0GjzNArLBOXo5bYWJ471eQvH8mV9S0XCUk=;
 b=h4oiwLvB9MO4tFufRbQKhsuT3pCSMNGSBCN5WFqsSBbT2vD/6yH6TY1a8DeY8Xlsju1c
 B/4nA9S8JFSrZwlF9o3CT1K55Lm/kO8d3tzQbgwbsP+oXx654jynIwvnhW2tui/FVzaZ
 r+QsPIl9p0N68GQ0FO+2ukpLOBkWkUgX5Q8u/pzjj06lHZxWEhdFi+hH7LuN6KknC+q5
 2WnA/JoXM6G2iXhrryE5znZUa11tjIxxX7c3JiQTcwk+lVIoKBgO3A5wgHKAJqjEYnHr
 afVk7LCCRvswefCzzPkSarz+shZrqfULuxrhkbocbu4PGO5/TVEMpMn1fEeajzylHaAq iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpphb09ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:21 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426AOdbo001802;
	Wed, 6 Mar 2024 10:25:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpphb09bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4269B8mK024166;
	Wed, 6 Mar 2024 10:25:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjws97yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:25:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426APDKe16777952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 10:25:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DAB52004D;
	Wed,  6 Mar 2024 10:25:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F1B62004B;
	Wed,  6 Mar 2024 10:25:10 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.37.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 10:25:10 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
Subject: [PATCH v5 0/3] sched/fair: Limit access to overutilized
Date: Wed,  6 Mar 2024 15:54:51 +0530
Message-Id: <20240306102454.341014-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l_Tk9WkwYuUxb9-nyJt21jujoinzTGac
X-Proofpoint-ORIG-GUID: FKVn6JZAOhTW_Kw54TRt2Yxh9CUjoXQN
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
 definitions=2024-03-06_05,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060082

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

Shrikanth Hegde (3):
  sched/fair: Add EAS checks before updating overutilized
  sched/fair: Use helper function to access rd->overutilized
  sched/fair: Combine EAS check with overutilized access

 kernel/sched/fair.c | 86 +++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 27 deletions(-)

--
2.39.3


