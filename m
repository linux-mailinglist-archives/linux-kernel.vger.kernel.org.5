Return-Path: <linux-kernel+bounces-130990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC38981A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E22B25C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E854905;
	Thu,  4 Apr 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSMm1SFE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B65647E;
	Thu,  4 Apr 2024 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213312; cv=none; b=B/BGUp1MmykCl80qjFrpkm80Ro2j9f30Bg+r1fK2BRKB2u8xUh5i0k9al0ufEVZNtHesMiims4fzhQ9O5BfMUVLmdkW0C9Xcx8stdP4nqK0yss08MbvtMCP9hNqCY/TgRx8qBkpiRK3KPtnSrn/10TMNg38D9BMXEz+wEL1JtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213312; c=relaxed/simple;
	bh=CbAmz+aWs+CWVYAvKygY/zR/Cn+sQafTt1184Bv4PI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lh4A2iO8nmOuHQSpRJ25dnl0BiNms2bb4Fjg2LFxK1NNHRpdWTCDbqCBcAFrfUrhelhBuySWfgIGYvttRix/UY+JmUq9FZdSET3DKxbxzWjJQK6yM6kctnYA8wIpWqZUZ5BzT02H+kBXdtKl/FQ6e5E6gKRisnfktRyRgoRT/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSMm1SFE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4346XnaA025867;
	Thu, 4 Apr 2024 06:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+o7eU/Pqmj0XjTMIQ3Syylu4ad9U7Idv5dPX97beCvI=;
 b=XSMm1SFEHGqELEC5cpfgNlfUdW1qj9+Sqp0kZs6Cu1WXljN11uPuXbC1s3eFESTBDokP
 suq3sww12mXaHtOKox+F5zpwP0JQO5Z3TnOdYLUHXLydRfpWLIs2uaEcf5meAHEt0eKE
 aZgRp/MykFQVEDuAD5Wi0a9e7Uk0EzMhvxubeb4QDvCWLKCx0CQ6dyYITvoziGoXHcRU
 L7Ag+lUm/b9bP7ZNRq5VGW7A5o5zZjz3SRAas7tZKgHSoEZFwHYp+4nD0zR/otnPybmn
 hNuUFPuSPeaiCHWXfTuOnjCPpiQR0lGJV54YxS2zJNuUJKAnBlOCbO//GfkPWfN1rNwv rA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9q1hr0wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:48:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4346mPaO017810;
	Thu, 4 Apr 2024 06:48:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9q1hr0wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:48:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43442mqI009114;
	Thu, 4 Apr 2024 06:48:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epxtjbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 06:48:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4346mIp015597950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 06:48:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA4D22004B;
	Thu,  4 Apr 2024 06:48:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B69820040;
	Thu,  4 Apr 2024 06:48:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 06:48:18 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [Ping PATCH 2/2 v2] perf stat: do not fail on metrics on s390 zvm systems
Date: Thu,  4 Apr 2024 08:48:06 +0200
Message-Id: <20240404064806.1362876-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404064806.1362876-1-tmricht@linux.ibm.com>
References: <20240404064806.1362876-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 37w_HzPZ2i3shMUtf0b7dDmfu_bm_6I7
X-Proofpoint-ORIG-GUID: IQNtOTFeopGPm4wjJLJ2voyr6NelNs0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040042

On s390 z/VM virtual machines command perf list also displays metrics:

 # ./perf list | grep -A 20 'Metric Groups:'
 Metric Groups:

 No_group:
  cpi
       [Cycles per Instruction]
  est_cpi
       [Estimated Instruction Complexity CPI infinite Level 1]
  finite_cpi
       [Cycles per Instructions from Finite cache/memory]
  l1mp
       [Level One Miss per 100 Instructions]
  l2p
       [Percentage sourced from Level 2 cache]
  l3p
       [Percentage sourced from Level 3 on same chip cache]
  l4lp
       [Percentage sourced from Level 4 Local cache on same book]
  l4rp
       [Percentage sourced from Level 4 Remote cache on different book]
  memp
       [Percentage sourced from memory]
  ....
 #

The command

 # ./perf stat -M cpi -- true
 event syntax error: '{CPU_CYCLES/metric-id=CPU_CYCLES/.....'
                       \___ Bad event or PMU

 Unable to find PMU or event on a PMU of 'CPU_CYCLES'

 event syntax error: '{CPU_CYCLES/metric-id=CPU_CYCLES/...'
                       \___ Cannot find PMU `CPU_CYCLES'.
			    Missing kernel support?
 #

fails. Perf stat should not fail on metrics when the referenced
CPU Counter Measurement PMU is not available.

Output after:
 # ./perf stat -M est_cpi -- sleep 1

 Performance counter stats for 'sleep 1':

     1,000,887,494 ns   duration_time   #     0.00 est_cpi

       1.000887494 seconds time elapsed

       0.000143000 seconds user
       0.000662000 seconds sys

 #

Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 .../arch/s390/cf_z16/transaction.json         | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index ec2ff78e2b5f..3ab1d3a6638c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -2,71 +2,71 @@
   {
     "BriefDescription": "Transaction count",
     "MetricName": "transaction",
-    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL if has_event(TX_C_TEND) else 0"
   },
   {
     "BriefDescription": "Cycles per Instruction",
     "MetricName": "cpi",
-    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Problem State Instruction Ratio",
     "MetricName": "prbstate",
-    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
-    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 2 cache",
     "MetricName": "l2p",
-    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 3 on same chip cache",
     "MetricName": "l3p",
-    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + DCW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + DCW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ_CHIP_HIT) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 4 Local cache on same book",
     "MetricName": "l4lp",
-    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_ON_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + IDCW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDCW_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_ON_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + IDCW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDCW_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ_DRAWER_HIT) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 4 Remote cache on different book",
     "MetricName": "l4rp",
-    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAWER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAWER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_OFF_DRAWER) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from memory",
     "MetricName": "memp",
-    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_ON_CHIP_MEMORY) else 0"
   },
   {
     "BriefDescription": "Cycles per Instructions from Finite cache/memory",
     "MetricName": "finite_cpi",
-    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
+    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_MISSES) else 0"
   },
   {
     "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
     "MetricName": "est_cpi",
-    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS)"
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
     "MetricName": "scpl1m",
-    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
+    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) if has_event(L1C_TLB2_MISSES) else 0"
   },
   {
     "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
     "MetricName": "tlb_percent",
-    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100 if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Estimated Cycles per TLB Miss",
     "MetricName": "tlb_miss",
-    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) if has_event(DTLB2_MISSES) else 0"
   }
 ]
-- 
2.44.0


