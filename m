Return-Path: <linux-kernel+bounces-86564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04F86C71B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D071F28665
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680E79DCF;
	Thu, 29 Feb 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QlD4gtms"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E987995E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203237; cv=none; b=nKgtjWD0wLFZRaJat+zjeqRHcHlGsTr9v2sInqVlE8K6Nog27UuZ4kxlFHvNnzdAb4V6TxrElxtLnfK1WCKoPUT3BsweCDM3hBbjGDu6ZtX28Hgaoy3w8mybsGOXj5/yHRITmN4l3I3IZUynEnmDZvoSK4g3TIhJi2wpresO8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203237; c=relaxed/simple;
	bh=8Pwhvk9k4qc9PDpM40JOEH5UNHmu6na0wZQeHbg7A+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GR8z6eFHyuxev/ilKwGYOihxwmADJqkmxAonSVfe3xZvTGq0jkWgZ5L+GDoUze4EVJvejhYQ/+vJSmUYdRmLrqo5HPw3MMfVAsZikcAXTJftb2bmVKf2xLtZv0ub/TxOiMleb+8CBvfleBnxh1tNP3euDeC3TalpF75C3C5CNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QlD4gtms; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TAQpso001273;
	Thu, 29 Feb 2024 10:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=loF0SmSWPcJ4zxQI6fve6GvqAQj10hnLxptyanWQ5Jg=;
 b=QlD4gtmszLmLgflWdRFtFylwp0OsRM2x6ZGxYwtAN+4HnvCxYTxOL3/flvTdDCM1BrAB
 BBYUC8SI+doI1Nk+gD3cNqru3ttvN1H+2df0kuVAFs7CG5otg1NssNXPtjRHLEWU0jyM
 j8BwW56EqhUaKqAqulSyLPmpnuK2K4tDCxzORP1lgvJw1LO19sKRaoTKJTVaixgu3aE9
 D4DXZu1+u0Xv8GANQwKqhnLUIIZbaNXkSGuuxv1ENZ+WhDcPaMobIN88J2xwyyOxLnNk
 Od4vZbaUIkmv3gSSj55q59EsDHGVi7wj+0VJsJrpuGpg8BtW0SGd3c76aOKgiK/14TSl hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqcwhmtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:40:22 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41TAR1xo002529;
	Thu, 29 Feb 2024 10:40:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqcwhmt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:40:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T8d4jd008189;
	Thu, 29 Feb 2024 10:40:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mmhgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:40:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TAeFn441943404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 10:40:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B209B20063;
	Thu, 29 Feb 2024 10:40:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 283EE2004B;
	Thu, 29 Feb 2024 10:40:13 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 10:40:12 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH v3 0/2] sched/fair: Limit access to overutilized
Date: Thu, 29 Feb 2024 16:10:08 +0530
Message-Id: <20240229104010.747411-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jh1zKwqrwWq3b6ZfG7iRCwcXAlD5FS7E
X-Proofpoint-ORIG-GUID: qw-drBYX9Ckp7NCTxm68Cuy3reK0_juJ
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
 definitions=2024-02-29_02,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290081

When running a ISV workload on a large system (240 Cores, SMT8), it was
observed from perf profile that newidle_balance and enqueue_task_fair
were consuming more cycles. Perf annotate showed that most of the time
was spent on accessing overutilized field of root domain.

Aboorva was able to simulate similar perf profile by making some
changes to stress-ng --wait. Both newidle_balance and enqueue_task_fair
consume close to 5-7%. Perf annotate shows that most of the cycles are spent
in accessing rd,rd->overutilized field.

Overutilized was added for EAS(Energy aware scheduler) to decide whether
to do load balance or not. Simultaneous access to overutilized by
multiple CPUs lead cache invalidations due to true sharing. Updating
overutilized is not required for non-EAS platforms. Since overutilized and
overload are part of the same cacheline, there is false sharing as well.

Patch 1/2 is the main patch. It helps in reducing the above said issue.
Both the functions don't show up in the profile. With patch comparison is in
changelog. With the patch stated problem in the ISV workload also got
solved and throughput has improved.
Patch 2/2 is only code refactoring to use the helper function instead of
direct access of the field

Detailed perf annotate can be found in cover letter of v1.

v3 -> v2:
- Pierre and Dietmar suggested we could add one more EAS check before
calling cpu_overutilized. That makes sense since that value is not used
anyway in Non-EAS case.
- Refactored the code as dietmar suggested to avoid additional call to
sched_energy_enabled().
- Minor edits to change log.
v2 -> v1:
Chen Yu pointed out minor issue in code. Corrected that code and updated
the changelog.

v1: https://lore.kernel.org/lkml/20240223150707.410417-1-sshegde@linux.ibm.com/
v2: https://lore.kernel.org/lkml/20240228071621.602596-1-sshegde@linux.ibm.com/


Shrikanth Hegde (2):
  sched/fair: Add EAS checks before updating overutilized
  sched/fair: Use helper function to access rd->overutilized

 kernel/sched/fair.c | 61 ++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 20 deletions(-)

--
2.39.3


