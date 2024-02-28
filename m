Return-Path: <linux-kernel+bounces-84593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123786A8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2817286C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51002420C;
	Wed, 28 Feb 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RHl7JPFa"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBA23766
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104610; cv=none; b=jEB6hJCiZzhm7f3SsMZzy93blyiW6dSbKJC49qDHV613ySqHXf11HoCh3MeTlicVXmNmgFoGyJ8vbKQRNH2koXySuh1kiEwtKPqZjg6velHEj4fDd7hc9BkHMfiTPDFGbu2o7L/UWgMcVaMBFB0R4UGsodWLJUb3HQAG1476fcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104610; c=relaxed/simple;
	bh=TGKY1pUMR4qMNKwwM9TvhqXUeW4kz8QoOFAk6Q+0K1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAoSqQdrrHu6VKPzTdsyzaP6I8W1Y5Kj2/7zbpTND8Ge8r41kN/mBZkssinIEYmCp3HIDR6fKbl1/cnWGPkDo+t3o8wbbqrIJ/11YEw6L9MyV96aFTZWnuZFYGDwi5Mb7Hn6O+AoYQt54Xgz4BSZtp9O/cEk3ZOrDgfTeFdJLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RHl7JPFa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S7CFtb013248;
	Wed, 28 Feb 2024 07:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ESc/2UapGLAFyJdv6XmJP07aYzuxSsXRZE6wYiiGx6I=;
 b=RHl7JPFajtMXYLG4TH3BS8a7oudzg1mkZ/xF/Q/EA6P7EUmgefxXEPjUnpTq7m9QUT7k
 3JzPraZ3YvPPtwJdIkVjgfV2s/Tc+TgzDPPCxD1a/MFD8c46jG1U1dbvzVIn3F2UMhOs
 a3q3kFkfju20RtjaTXUQkzDZOXUkEn4engL+c4GbFJCwDb4nFqjINZpvyFDEO4u+jNTr
 ASjmNeTHTcnbwJ2Sh8x2eZ7+QeBK86RSH+9xKag4fP17pekBcdIoeynxgd3CxFGKsZwn
 E8DxzD3xEdtniCQ49aCkYn+jkNev2tvpriTcJyfpPJlhDlRy/rikv796LzKQiZtCuCWk eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj07w8364-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41S7Do0Q018648;
	Wed, 28 Feb 2024 07:16:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj07w835m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41S70tT5008792;
	Wed, 28 Feb 2024 07:16:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstn2te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:16:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41S7GToZ19595822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 07:16:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A967720043;
	Wed, 28 Feb 2024 07:16:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4570E20040;
	Wed, 28 Feb 2024 07:16:26 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.91.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 07:16:26 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH v2 0/2] sched/fair: Limit access to overutilized
Date: Wed, 28 Feb 2024 12:46:19 +0530
Message-Id: <20240228071621.602596-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zMZj_7xZNGonnSimPOyBaQs2MZ6uzDRo
X-Proofpoint-ORIG-GUID: v2g_uEG-LdvwpVy3Q8jEQ3CRoAbOOIc8
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
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280056

When running a ISV workload on a large system (240 Cores, SMT8), it was
observed from perf profile that newidle_balance and enqueue_task_fair
were consuming more cycles. Perf annotate showed that most of the time
was spent on accessing overutilized field of root domain.

Aboorva was able to simulate similar perf profile by making some
changes to stress-ng --wait. Both newidle_balance and enqueue_task_fair
consume close to 5-7%. Perf annotate shows that most of the cycles are spent
in accessing rd,rd->overutilized field.

Overutilized was added for EAS(Energy aware scheduler) to choose either
EAS aware load balancing or regular load balance. As checked, on x86 and
powerpc both overload and overutilized share the same cacheline in rd.
Updating overutilized is not required for non-EAS platforms.

Patch 1/2 is the main patch. It helps in reducing the above said issue.
Both the functions don't show up in the profile. With patch comparison is in
changelog. With the patch stated problem in the ISV workload also got
solved and throughput has improved.
Patch 2/2 is only code refactoring to use the helper function instead of
direct access of the field, so one would come to know that it is accessed
only in EAS. This depends on 1/2 to be applied first

Thanks to Aboorva Devarajan and Nysal Jan K A for helping in recreating,
debugging this issue and verifying the patch.
Detailed perf annotate can be found in cover letter of v1.

v2 -> v1:
Chen Yu pointed out minor issue in code. corrected that code and updated
the changelog.

v1: https://lore.kernel.org/lkml/20240223150707.410417-1-sshegde@linux.ibm.com/

Shrikanth Hegde (2):
  sched/fair: Add EAS checks before updating overutilized
  sched/fair: Use helper function to access rd->overutilized

 kernel/sched/fair.c | 49 +++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

--
2.39.3


