Return-Path: <linux-kernel+bounces-88099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA47886DD56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806C9286994
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45A6A01C;
	Fri,  1 Mar 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n/2PWmHl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5C69943;
	Fri,  1 Mar 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282693; cv=fail; b=ahQ6vfdvThWyWbYlULdryZ//aEcjvRcUQx2bKjyCFYqwXL/kErD17Rj7o+YRLVjSjjy70iQJpBRHH1cCksVRLNq8ZxLHLolVL8G4IjWryPayFJS8221Ug6ZDC5RO7IGQMH+9+MjPw8q+VjAoVkYpkZA/0W+srAwbp7G/GWQG4Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282693; c=relaxed/simple;
	bh=HQBk8Kq1IaYmzeGCcr5VnMa/XwZKNJCk7g2AnMUiIxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9v80cUcp5ttneHXF9lm4c4aom2AvkIOnqSUAHGb3UrBXgmJdvwzQSqMIgnGV3RXKL+u1GbNr0zLJqGudMR4/bjjKPxoOVP+FMR4AAPZPCUEjJ05AA5dE7uwyr5uK97laSZQSN0SgwvqAhlX9zcyLvvUBRf/QB4QkomjOZ07Xyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n/2PWmHl; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nphiiAUL9d+PMPsq0FfEntv/SXLaFsL6+mm48P1aL9ZG8MekyX076USjfLUm+ZdrmyqiPaUOYAW2zT1O5sFIiJBINgAjVgvlLlQmn7ydgdVk8Bx/6uags3VR38PvdBBOFCNK+hKBoecbicwprpvw7mbeyxqLnegQdUd5wct1pcYfBAQxSyZDTDdnDS8QDcvpQyVu5jPyFj+gwyeM2y+l87ONVTlUIBcaqL+8/PejdBt7BBofXf5WSyrDJ0NMRxgTykuoaiLjMzZMHJWqpj2XVVQe5ZsvfET5MS20xXEz9sk5C+wYrelEyb3WqnJZDr9crbAOC8Lh3e0yzivXsLjDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tit7Cx/nddbDN6VRK4Y+eBosA/7A3k8wOWiXyFaNX0=;
 b=HTu2VL27dW+SuI69nsmU9Mby9WBmn0VFbm7bN1064IIUSxsoV4yQrW77LLFoyzKTrHjb2NmQcYAZMDbBPTwWS2s8aI2PA9eBwh2EgTG0xZ4fLu+4tRmb9J3z8VxlYwN/aCsN3iydZmKCRLcXXmhkHhOjt1KbE2G1PMfaJW9tNsngPL6wKum2ZV6DbrFXhUGlYiwF1hu87YQtgNsmG2LOUE2ozV4kwDemaMUE9oAkufVyqlqTgk7w08/U9K5f3CoODzfdYzcF3yaD7QKRrPWbZh54X1yUHrDgcMExThj4wXCymX+2Wf+ridzBPt3AR56511Dl5QRzYU36urh0chAAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tit7Cx/nddbDN6VRK4Y+eBosA/7A3k8wOWiXyFaNX0=;
 b=n/2PWmHl8dlHdVXyMJiwdC9BgdseR5wTCelnwkmrdGDeEUdyaMVPye4e2edUuVKMKNGkQ1TRxNJOtuM7d9M7gtjNC7D2lIhxEbA8eW83VGF4PV6hUOPZ4sCb/EUryEFIECtZXpHWvKoMpElEtz5CMhum9UhJM2PsTQpWAF24YNs=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 08:44:46 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::e3) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 08:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 1 Mar 2024 08:44:46 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 02:44:38 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <eranian@google.com>, <adrian.hunter@intel.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf vendor events amd: Fix Zen 4 cache latency events
Date: Fri, 1 Mar 2024 14:14:31 +0530
Message-ID: <20240301084431.646221-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 0984ff97-e303-4218-b204-08dc39cbd909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Yi9624+EXDuNo4x0gJ0ZBRkscySg/AHDbKqBq/uttJxxFeiTE9GvuGh+91sKA0SJTyK4frS9/MLe1IHB1bFO271Ctwh6QQFV0Agyixdp6wevD1CBAjJGN5zlUDdWOjRTeb/1bR2hN4ZxlD69D9Nl19bXhXUDUVaOr+46qyU/QPZqwIrByd4482SGiXwvnC4Spx4D0rM6it7MIE0g8yz/lzNSKlgcUHjuL11IOxJ5d97CT3ulCNJ9ejTmwvAbCX47ynmXpLIhzsW/dIR6f0cMCrEIMey0rZ4vB2wVWhDMEYfOXVFKCbO257PaerbZ6GCVWAYHD2nswkaUqXwnO4+Nq6QcgliTAHZxs1K6qf8xcaMrmn85BkGIXWzfwViaqdJ/4uDTfQEPLM42SlEpx7pBC3QBFXmmwkz5hNcxSrzRP4SrmOp/i7vwAcYD2pd59bp6tHnJb2pslQ/uaZV3F8CavuCB40Nh7BK/54tPKIIzIHjeDdk2WLw/q+XADgyP5y/8j6Y0plqOZulVE3jEfGXnkDREVFjv29JmvFoh2AX62hR3JFwcOFyaW2wKneAEO0a/RRFNJJuwhZuN7b8r1IwjMgPtQvXXCfewEszfYIfLD9K0Hq8IDZQe37VlI1/ROmVb3haO9tSxKX9XYtZZJWHASLzcFXZ/MKqtI8NdLw9uMZk+WDxcAF5MoJ33NJbHrUqMyd1/ioyQSKytSKaB+Wu4L79UnX2IK/dqBZlN2y5jiNPln6kR/VapVKqnpn7Bpab
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:44:46.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0984ff97-e303-4218-b204-08dc39cbd909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

L3PMCx0AC and L3PMCx0AD, used in l3_xi_sampled_latency* events, have a
quirk that requires them to be programmed with SliceId set to 0x3.
Without this, the events do not count at all and affects dependent
metrics such as l3_read_miss_latency.

If ThreadMask is not specified, the amd-uncore driver internally sets
ThreadMask to 0x3, EnAllCores to 0x1 and EnAllSlices to 0x1 but does
not set SliceId. Since SliceId must also be set to 0x3 in this case,
specify all the other fields explicitly.

E.g.

  $ sudo perf stat -e l3_xi_sampled_latency.all,l3_xi_sampled_latency_requests.all -a sleep 1

Before:

   Performance counter stats for 'system wide':

                   0      l3_xi_sampled_latency.all
                   0      l3_xi_sampled_latency_requests.all

         1.005155399 seconds time elapsed

After:

   Performance counter stats for 'system wide':

             921,446      l3_xi_sampled_latency.all
              54,210      l3_xi_sampled_latency_requests.all

         1.005664472 seconds time elapsed

Fixes: 5b2ca349c313 ("perf vendor events amd: Add Zen 4 uncore events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen4/cache.json    | 56 +++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |  4 ++
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
index ecbe9660b2b3..e6d710cf3ce2 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
@@ -676,6 +676,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from DRAM in the same NUMA node.",
     "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -683,6 +687,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from DRAM in a different NUMA node.",
     "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -690,6 +698,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in the same NUMA node.",
     "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -697,6 +709,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in a different NUMA node.",
     "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -704,6 +720,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in the same NUMA node.",
     "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -711,6 +731,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in a different NUMA node.",
     "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -718,6 +742,10 @@
     "EventCode": "0xac",
     "BriefDescription": "Average sampled latency from all data sources.",
     "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -725,6 +753,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from DRAM in the same NUMA node.",
     "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -732,6 +764,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from DRAM in a different NUMA node.",
     "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -739,6 +775,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in the same NUMA node.",
     "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -746,6 +786,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in a different NUMA node.",
     "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -753,6 +797,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in the same NUMA node.",
     "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -760,6 +808,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in a different NUMA node.",
     "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   },
   {
@@ -767,6 +819,10 @@
     "EventCode": "0xad",
     "BriefDescription": "L3 cache fill requests sourced from all data sources.",
     "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
     "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2c7e5d61ce92..e42efc16723e 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -373,6 +373,10 @@ class JsonEvent:
         ('UMask', 'umask='),
         ('NodeType', 'type='),
         ('RdWrMask', 'rdwrmask='),
+        ('EnAllCores', 'enallcores='),
+        ('EnAllSlices', 'enallslices='),
+        ('SliceId', 'sliceid='),
+        ('ThreadMask', 'threadmask='),
     ]
     for key, value in event_fields:
       if key in jd and not is_zero(jd[key]):
-- 
2.34.1


