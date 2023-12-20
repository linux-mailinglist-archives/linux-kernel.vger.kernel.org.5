Return-Path: <linux-kernel+bounces-6442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A08198DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CF81F218CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C0168A5;
	Wed, 20 Dec 2023 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qrqil/b0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A557168B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK6fNv2006233;
	Wed, 20 Dec 2023 06:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Gcuv9bc/PGAsKEDSp3xMGHP2NwfoGMRFQikfP4UQ2Zo=;
 b=qrqil/b0al4pdEiG9yKSVrhpCpZTDz6SpjLApAGLcZAxs4a+8XKjzwY3c+s9Y6FOPhs7
 PThOpfeAqgSNRtsZYuZbfTIYyDUFFtCwu5G3yTK+CpP+TnIkXgE1B76UGsBb0j5O+i2W
 LRvG3mb8PxH4TJa+dUhyAYo8edCcVzE68t8eFWWwxN3N9N7IBaanGWbUxa54cRY1+bQJ
 nlJKaRW4s2Iip9xzw6BHm41z5GwqnbYSuEZzqGaegA6Hy09pm4ADVWhgQCyP4ULe0Tq1
 a16MrO/YEGljDPgGPbbAkuSEmDYWKU/jWF+YuYyDMhrFZtNc6YKkHzotkygUuU0moPfS Vw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3q9jdmsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:55:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK3i3pf010885;
	Wed, 20 Dec 2023 06:55:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nmtv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:55:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BK6tddT9306626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 06:55:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F41BF20040;
	Wed, 20 Dec 2023 06:55:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9635C2004D;
	Wed, 20 Dec 2023 06:55:36 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.59.83])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 06:55:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com
Subject: [PATCH] sched: move access of avg_rt and avg_dl into existing helper functions
Date: Wed, 20 Dec 2023 12:25:22 +0530
Message-Id: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q8R-wNi0J6IR9TLJQsT3kmdcrFRKm1XZ
X-Proofpoint-GUID: Q8R-wNi0J6IR9TLJQsT3kmdcrFRKm1XZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200045

This is a minor code simplification. There are helper functions called
cpu_util_dl and cpu_util_rt which gives the average utilization of DL
and RT respectively. But there are few places in code where these
variables are used directly.

Instead use the helper function so that code becomes simpler and easy to
maintain later on.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..02631060ca7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9212,19 +9212,17 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)

 static inline bool others_have_blocked(struct rq *rq)
 {
-	if (READ_ONCE(rq->avg_rt.util_avg))
+	if (cpu_util_rt(rq))
 		return true;

-	if (READ_ONCE(rq->avg_dl.util_avg))
+	if (cpu_util_dl(rq))
 		return true;

 	if (thermal_load_avg(rq))
 		return true;

-#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-	if (READ_ONCE(rq->avg_irq.util_avg))
+	if (cpu_util_irq(rq))
 		return true;
-#endif

 	return false;
 }
@@ -9481,8 +9479,8 @@ static unsigned long scale_rt_capacity(int cpu)
 	 * avg_thermal.load_avg tracks thermal pressure and the weighted
 	 * average uses the actual delta max capacity(load).
 	 */
-	used = READ_ONCE(rq->avg_rt.util_avg);
-	used += READ_ONCE(rq->avg_dl.util_avg);
+	used = cpu_util_rt(rq);
+	used += cpu_util_dl(rq);
 	used += thermal_load_avg(rq);

 	if (unlikely(used >= max))
--
2.39.3


