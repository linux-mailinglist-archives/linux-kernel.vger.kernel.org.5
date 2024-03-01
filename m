Return-Path: <linux-kernel+bounces-88611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA09886E424
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58895286183
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36906CDCD;
	Fri,  1 Mar 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jQUc7LyP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BD3A8F8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306294; cv=none; b=bnU07r5PHQdxkiotor/ye4KsRz28/nWNQkU3wjUKePsSRrABaS0bR5Q9XNRxzVTcbM71Vl5xaaoO3A+iFwfVuVSnpKaSkAPKlIN4OR2X5IVJR1okfULd4eTg2JT1/9v4q16YcECl6JK13IVX7OVxUz3M9FY/I9kOvKBmap/+Jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306294; c=relaxed/simple;
	bh=cb8XTZXLhtdief3sGmEOEiurGom3N0GO6VlK248uSz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PUjbOgvQlbjarDgNfCTuf7CHecfsIoEwZfRwh7E5yAHtgXDtBqaqQOuIf9EH+/CzcVgAeD0ZBxiagwYqi5SLmTor2q2AGH2tZTIS14HLe9m2GQzzViCvF0ww3SO+5xdNah21OFpE2I2KMYeYYoyL1rLdCbyw/oKGLj4d9Uft/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jQUc7LyP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421Ew7ot004373;
	Fri, 1 Mar 2024 15:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=QRwgG5p9LXiYkhUTkDn+4GU4EqsUgxuh3E+OD24BUIM=;
 b=jQUc7LyPUzrd97cgbu/R/URb0WPOe4X7QqDGyFYBwl2TC2YIi0EEAvpW2qZyF4s2ypDV
 pVxwI3Z+5MxKo2BE6WEAK6fvMor8PilDTi/3/3oTvJhkRyAS09+8O56dRTt82Cn+3cag
 m572+qtliOyq5Uls7GpXZPcRSsgNIZ1X8Rgv9EU3pBr7J0JkeC6ZLqngE1SO3X0qDGg4
 bHcUi0umGAYAu3W0eHSzXR0u5f78LIdFjDChK0SaIjNr+pZWlTdrnCUrzUYgJYN7Rd9u
 iVw4jbS242gjHTN+T7BUD7fiwfYVuLk33ODOaXLprYbZkky6XHqxjCZ3yjffU2KPC9uy 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkh88gfew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 15:17:57 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421FBdM3021497;
	Fri, 1 Mar 2024 15:17:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkh88gfed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 15:17:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421DoCIh021792;
	Fri, 1 Mar 2024 15:17:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu60nak7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 15:17:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421FHngt14418426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 15:17:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4C6020040;
	Fri,  1 Mar 2024 15:17:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A9F20043;
	Fri,  1 Mar 2024 15:17:46 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.108.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 15:17:46 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH v4 0/2] sched/fair: Limit access to overutilized
Date: Fri,  1 Mar 2024 20:47:23 +0530
Message-Id: <20240301151725.874604-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jlku7Lk7abe4i4wh_cX5vKBmyxAXHFcb
X-Proofpoint-ORIG-GUID: Md9zT3R3xfmmZ-B6tcN3RUFShZnTDDqs
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
 definitions=2024-03-01_14,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010127

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

v4 -> v3:
- corrected a mistake where EAS check was missed.
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
v3: https://lore.kernel.org/lkml/20240229104010.747411-1-sshegde@linux.ibm.com/

Shrikanth Hegde (2):
  sched/fair: Add EAS checks before updating overutilized
  sched/fair: Use helper function to access rd->overutilized

 kernel/sched/fair.c | 63 ++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 21 deletions(-)

--
2.39.3


