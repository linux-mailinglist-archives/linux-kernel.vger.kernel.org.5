Return-Path: <linux-kernel+bounces-74386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387785D34A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251811C2086F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B83D0C6;
	Wed, 21 Feb 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iA+jGl6i"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CA3C6AB;
	Wed, 21 Feb 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507178; cv=none; b=QEBjI0Q3cSe2ksgA3cyVDlVWkHO5JCmtRVLtBEmmDBqMeSgB10ZhDBv7atfz+PdXaQeSOhFuxZNh1U1SAM0sCqR+C9jJZxHBaA6tN21I/RvYrdLJeQqb6/iYET9pPlVSoNQ4kvI+4995TSqnkHxh3dluYm3RadYB1m/pCbwkGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507178; c=relaxed/simple;
	bh=Y0eSdqsOMPZg4cFJuddNnZQAwgbH2+fFVg8Ql+kwn1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URt0osyBKwNTJdbDHXBNpJnIQU+WS/WURW88XI+ClvUZRfTuQwkHfsZiCGDma3QQ148MYarltuCNe8cDM/Tly3X6krIc/jOFntD7qmz2SiQVMAU4AOfr3ncouX6yenOZq7PUiAmYuddWiKTpFiQ59jmLGSSdK7+rkfNwuwWP118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iA+jGl6i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L7v8n3008854;
	Wed, 21 Feb 2024 09:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tFKAfbkMIwUfImvPItLL81DNEYGwyEHVVnlhnLff+c4=;
 b=iA+jGl6iLF/5Ydef8xN+fySlSwwyHPfecr/utXRfxR3rNlm+eDUvcGMtczrp+7OShkLL
 QQ3XvtoZpHFEWks7P7ln2XnC8fnQdZpECwtA67bzAhjb6AsKpqOqVv6kbkfV100NMmCI
 /BnIlj2j8EfQEhPUgYTZc/rbiwK26pP9lxfdiMQmR/6WVpAKxyzgCu7uYm8CSmQBOPNr
 pHc83W+5coa7CMxUwRyAF9dE5yIkQqwJ6TdaxUIJ4ulGaR/VFXwpaY5IjSkJH0z4UdNl
 PfyxxEutvBmiuOPqnPqg0utD8rglDfYyFFQknOTw2VkbtDojcj9XyQT3TeDx2m7QTNYl rA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdd7y217v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:19:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41L66ZjC017265;
	Wed, 21 Feb 2024 09:19:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmdx50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:19:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41L9JOcr46334380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 09:19:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC9D2004D;
	Wed, 21 Feb 2024 09:19:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543F020043;
	Wed, 21 Feb 2024 09:19:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 09:19:24 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, krebbel@linux.ibm.com
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: fix short description for some cache events
Date: Wed, 21 Feb 2024 10:19:08 +0100
Message-Id: <20240221091908.1759083-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _2h7yHayXacwZJsa2sHXP_Fowggij04B
X-Proofpoint-ORIG-GUID: _2h7yHayXacwZJsa2sHXP_Fowggij04B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=994 adultscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210072

Correct the short description of the following events:
DCW_REQ, DCW_REQ_CHIP_HIT, DCW_REQ_DRAWER_HIT, DCW_REQ_IV,
DCW_ON_CHIP, DCW_ON_CHIP_IV, DCW_ON_CHIP_CHIP_HIT,
DCW_ON_CHIP_DRAWER_HIT, CW_ON_MODULE, DCW_ON_DRAWER,
DCW_OFF_DRAWER, IDCW_ON_MODULE_IV, IDCW_ON_MODULE_CHIP_HIT,
IDCW_ON_MODULE_DRAWER_HIT, IDCW_ON_DRAWER_IV, IDCW_ON_DRAWER_CHIP_HIT,
IDCW_ON_DRAWER_DRAWER_HIT, IDCW_OFF_DRAWER_IV, IDCW_OFF_DRAWER_CHIP_HIT,
IDCW_OFF_DRAWER_DRAWER_HIT, ICW_REQ, ICW_REQ_IV, CW_REQ_CHIP_HIT,
ICW_REQ_DRAWER_HIT, ICW_ON_CHIP, ICW_ON_CHIP_IV, ICW_ON_CHIP_CHIP_HIT,
ICW_ON_CHIP_DRAWER_HIT, ICW_ON_MODULE and ICW_OFF_DRAWER.

The second Cache should be L2-Cache.

Output before (display diff of the first four events)
  # perf list -d
  DCW_REQ
       [Directory Write Level 1 Data Cache from Cache. Unit: cpum_cf]
  DCW_REQ_CHIP_HIT
       [Directory Write Level 1 Data Cache from Cache with Chip HP \
	       Hit. Unit: cpum_cf]
  DCW_REQ_DRAWER_HIT
       [Directory Write Level 1 Data Cache from Cache with Drawer \
	       HP Hit. Unit: cpum_cf]
  DCW_REQ_IV
       [Directory Write Level 1 Data Cache from Cache with Intervention. \
	       Unit: cpum_cf]

Output after:
  # perf list -d
  DCW_REQ
       [Directory Write Level 1 Data Cache from L2-Cache. Unit: cpum_cf]
  DCW_REQ_CHIP_HIT
       [Directory Write Level 1 Data Cache from L2-Cache with Chip HP \
	       Hit. Unit: cpum_cf]
  DCW_REQ_DRAWER_HIT
       [Directory Write Level 1 Data Cache from L2-Cache with Drawer \
	       HP Hit. Unit: cpum_cf]
  DCW_REQ_IV
       [Directory Write Level 1 Data Cache from L2-Cache with \
	       Intervention. Unit: cpum_cf]

Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
Reported-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Andreas Krebbel <krebbel@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z16/extended.json | 62 +++++++++----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
index c2b10ec1c6e0..02cce3a629cb 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
@@ -94,77 +94,77 @@
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "DCW_REQ",
-		"BriefDescription": "Directory Write Level 1 Data Cache from Cache",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "DCW_REQ_IV",
-		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "DCW_REQ_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Chip HP Hit",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache with Chip HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "DCW_REQ_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Drawer HP Hit",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache with Drawer HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "DCW_ON_CHIP",
-		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "DCW_ON_CHIP_IV",
-		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "DCW_ON_CHIP_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache with Chip HP Hit",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache with Chip HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "DCW_ON_CHIP_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache with Drawer HP Hit",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache with Drawer HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "DCW_ON_MODULE",
-		"BriefDescription": "Directory Write Level 1 Data Cache from On-Module Cache",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Module L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Module Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "DCW_ON_DRAWER",
-		"BriefDescription": "Directory Write Level 1 Data Cache from On-Drawer Cache",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Drawer L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "DCW_OFF_DRAWER",
-		"BriefDescription": "Directory Write Level 1 Data Cache from Off-Drawer Cache",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Off-Drawer L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache."
 	},
 	{
@@ -199,140 +199,140 @@
 		"Unit": "CPU-M-CF",
 		"EventCode": "160",
 		"EventName": "IDCW_ON_MODULE_IV",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "161",
 		"EventName": "IDCW_ON_MODULE_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory Cache with Chip Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory L2-Cache with Chip Hit",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache using chip horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "162",
 		"EventName": "IDCW_ON_MODULE_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory Cache with Drawer Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory L2-Cache with Drawer Hit",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "163",
 		"EventName": "IDCW_ON_DRAWER_IV",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "164",
 		"EventName": "IDCW_ON_DRAWER_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer Cache with Chip Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer L2-Cache with Chip Hit",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "165",
 		"EventName": "IDCW_ON_DRAWER_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer Cache with Drawer Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer L2-Cache with Drawer Hit",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "166",
 		"EventName": "IDCW_OFF_DRAWER_IV",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "167",
 		"EventName": "IDCW_OFF_DRAWER_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer Cache with Chip Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer L2-Cache with Chip Hit",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "168",
 		"EventName": "IDCW_OFF_DRAWER_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer Cache with Drawer Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer L2-Cache with Drawer Hit",
 		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "169",
 		"EventName": "ICW_REQ",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced the requestors Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "170",
 		"EventName": "ICW_REQ_IV",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "171",
 		"EventName": "ICW_REQ_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Chip HP Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache with Chip HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "172",
 		"EventName": "ICW_REQ_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Drawer HP Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache with Drawer HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "173",
 		"EventName": "ICW_ON_CHIP",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "174",
 		"EventName": "ICW_ON_CHIP_IV",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache with Intervention",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced an On-Chip Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "175",
 		"EventName": "ICW_ON_CHIP_CHIP_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache with Chip HP Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache with Chip HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "176",
 		"EventName": "ICW_ON_CHIP_DRAWER_HIT",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache with Drawer HP Hit",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache with Drawer HP Hit",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip level 2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "177",
 		"EventName": "ICW_ON_MODULE",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Module Cache",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Module L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "178",
 		"EventName": "ICW_ON_DRAWER",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Drawer Cache",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Drawer L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced an On-Drawer Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "179",
 		"EventName": "ICW_OFF_DRAWER",
-		"BriefDescription": "Directory Write Level 1 Instruction Cache from Off-Drawer Cache",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Off-Drawer L2-Cache",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced an Off-Drawer Level-2 cache."
 	},
 	{
-- 
2.43.0


