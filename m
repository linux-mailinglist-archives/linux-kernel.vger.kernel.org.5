Return-Path: <linux-kernel+bounces-109241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419B8816A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CD71F2453B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A086A33C;
	Wed, 20 Mar 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FoZvniDk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A21DFC6;
	Wed, 20 Mar 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956322; cv=none; b=QChtTFDFrT1bRKnsfrLkeXpDQxMiuRuGrDiW30lGRfuPrywSQgTqcftk9J3lDnfqYiEf31obtSexnyp8cyfls94Vdwd0E1BT9e4iLBVaaVcnzxiIET7ZXrCA78538d5w0kUU9kVK/ZBhVVpeg6CLybtheRPwKmQnPe+dsz/O1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956322; c=relaxed/simple;
	bh=BD1p7xRCkTigXDTwD7AmWB0J0pQlUtQDyhIDykFPkSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5iKthwe9prQZH4pdR27KuHDWzuUaD/LH9WSl6DLWp57PNxiXCOWuQtEr+zNOcOAlmm1AZYBuh/xHN+0Lr1Yi8IPXJo4z8oLT/KcwFgfy0suD7Y15pYelLp+nTROQH0LQp9XiFoNtCFqbP3UYDxqhZkWKHz9OUGMNtdNlOAx+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FoZvniDk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KHbmHJ004399;
	Wed, 20 Mar 2024 17:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=eAjxk+fkXKrm1SuTXD0WCw3XZrKkOoH6zPt2wZjeslE=;
 b=FoZvniDkh7Md0XhR9tGimioEn1imLxcVatBDEfRsfA/m5cAIRiJ82tuXBP6L3e/ObEKJ
 8T1U3DfL/uO7zgKRrdeTuoUWXuAnae6lCRSGQwkqnScY0XsdzSfLU5tKvz7Gys9PItVB
 REWlFxPgX7KgAqB6tplr8DEVEzGtTnrMM9w30jlRug/eoCUR/fOAmvjfWqof4kiZ+bna
 DDMK1d7dwJq0eoJxSj+0+bFwPaDibaiHfyhVb5cv4kEmEA3H1b4cDByy+VwaLHF/0geX
 6Ynf6rFmJu9s0wb/DZgO1XhuHqazaQe61KVUpr8aWhgwcs7TV+MDJxbODZSGhgN4glhd qw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x04bv004x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:38:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KGT10A010049;
	Wed, 20 Mar 2024 17:38:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav4rwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:38:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KHcUYm49414636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 17:38:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4974F20043;
	Wed, 20 Mar 2024 17:38:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F06C20040;
	Wed, 20 Mar 2024 17:38:29 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.195.38.202])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 17:38:29 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net, mingo@kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Subject: [PATCH] sched/doc: Update documentation for base_slice_ns and CONFIG_HZ relation
Date: Wed, 20 Mar 2024 23:08:16 +0530
Message-ID: <20240320173815.927637-2-mchauras@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OOwoNIBYoUxDU3RtGGienYWVL3cIBdOg
X-Proofpoint-ORIG-GUID: OOwoNIBYoUxDU3RtGGienYWVL3cIBdOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200142

The tunable base_slice_ns is dependent on CONFIG_HZ (i.e. TICK_NSEC)
for any significant performance improvement. The reason being the
scheduler tick is not frequent enough to force preemption when
base_slice expires in case of

           base_slice_ns < TICK_NSEC

The below data is of stress-ng
Number of CPU: 1
Stressor threads: 4
Time: 30sec

On CONFIG_HZ=1000

| base_slice | avg-run (msec) | context-switches |
| ---------- | -------------- | ---------------- |
| 3ms        | 2.914          | 10342            |
| 6ms        | 4.857          | 6196             |
| 9ms        | 6.754          | 4482             |
| 12ms       | 7.872          | 3802             |
| 22ms       | 11.294         | 2710             |
| 32ms       | 13.425         | 2284             |

On CONFIG_HZ=100

| base_slice | avg-run (msec) | context-switches |
| ---------- | -------------- | ---------------- |
| 3ms        | 9.144          | 3337             |
| 6ms        | 9.113          | 3301             |
| 9ms        | 8.991          | 3315             |
| 12ms       | 12.935         | 2328             |
| 22ms       | 16.031         | 1915             |
| 32ms       | 18.608         | 1622             |

base_slice: the value of base_slice in ms
avg-run (msec): average time of the stressor threads got on cpu before
it got preempted
context-switches: number of context switches for the stress-ng process

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 Documentation/scheduler/sched-design-CFS.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index 6cffffe26500..82985d675554 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -100,6 +100,9 @@ which can be used to tune the scheduler from "desktop" (i.e., low latencies) to
 "server" (i.e., good batching) workloads.  It defaults to a setting suitable
 for desktop workloads.  SCHED_BATCH is handled by the CFS scheduler module too.
 
+In case the CONFIG_HZ leads to base_slice_ns < TICK_NSEC. The settings of
+base_slice_ns will have little to no impact on the workloads.
+
 Due to its design, the CFS scheduler is not prone to any of the "attacks" that
 exist today against the heuristics of the stock scheduler: fiftyp.c, thud.c,
 chew.c, ring-test.c, massive_intr.c all work fine and do not impact
-- 
2.44.0


