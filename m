Return-Path: <linux-kernel+bounces-151530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790148AB01B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E68C285067
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849712F378;
	Fri, 19 Apr 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YFy0WgYR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530A12F38E;
	Fri, 19 Apr 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535369; cv=fail; b=OMsD+8RlguGpOEjhFw3LBZ2LzijvrbqsGgyvL2kFoFL5K052tu2/C/W8F8zlDFJxC3w1TrEQtzhc922xTcbDwkh0IUGq3YEkqmEH3DGXPgrCBVKwWyOThDHpny1drH4GRkQAWs4hYsu/B9Mh14YLwVkSwnUBcyGpp/X+bh+ZVLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535369; c=relaxed/simple;
	bh=hQQFn7+NPpIkhRObYyxhCTgrPcbE5sLd0PBvzCHaMKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq2/EfkArtDCluX6o9hDMcP7YCCrP/1qKGjP4F0LO6BWblRdHJ5xrnMSk2hhJDKX+C6LmM1RIyDL9TCEOIg48HyTSQxfvSsvh318xdo1Pu2StsVJevxemveh+wI9qZEEg0jsmDqUjFgWZD2LIo9LPaO1+d30ismjzSZJWHIYkG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YFy0WgYR; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSZGAf3i4YYdwBkHbl0GSz6ZC4hUigv+295NsBlSAXPBp8DEyisGPbZlxnESErf0I51Ni+nE6UDO9TFWHYsXJQSEIuF/UAWZDgib+9lUPM5r+5JHPaeIQ8zPlSTxgpZoqcxuvN7qwh0MAPxa6BLBQFCpxMjmPjenrPL6HVaitNdnW97w+hW0tua/nl1QdlsuzRjEn8HnjbT7paZEIAirihVgIuxHjQaFqHoRjJV7RmaCb9IPuTdS8EabpaYtmPvEB+fL+Y7rgFc90Qte094bsqformrivT3v4h18X18r8FhN1zSE5UYj53QAoKFp4vUTgL091JXZqoYl7SjksrgXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp3I68tF4fFltDVLPj2CQJCoy2aIKVULYSXEujpi/xk=;
 b=aEbk/WxPCaaOrnHhBCsYK6B0Uizrso4XBCErclrnGBPcDxz39HEuWUkS9k5TZwpamQyZEWsW+Kr34ETcsTPumq5QSub4TJQkZAy9N1f1PDp5Ov7uHK7ola453ZkGsXJbDWACiM0XrZ3FicfL9BVcYbOUUsVUFe2H1w90sfgovwf+hYKDi677Cb2vruG7aWtSTA+LtAUkrIxf8ClBLDzukFTmaobwrGM/xc2P1euWBtHKwvftm9oyFkUwGN6W+H+oyZCmWCVfrT1+DVOpCJYBGP+v8YJ4wJ07s/9wldsEsxN33v+YVY2gUdK/Yaii1eNsPLsgYzHAADHNpaJdDsYdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp3I68tF4fFltDVLPj2CQJCoy2aIKVULYSXEujpi/xk=;
 b=YFy0WgYRoN4q2DTNTBdu4k5795WyNNfC4FtCBOu1OQna3l4u2Y7bZxvpJfYoYHp1VOPV3yfLvksWvPORLdfs0rS0v/Es6/4/RgHpNqoN3RAdjP1gIDKQ/QT+2ax5yuCLLS1OHuAHJ8Oa+BGJZs1nMAfQG1Z8JUa3BDnfS/tcBo4=
Received: from CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::16)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Fri, 19 Apr 2024 14:02:44 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::37) by CH5P221CA0012.outlook.office365.com
 (2603:10b6:610:1f2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 14:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:02:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:02:37 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "kernel test
 robot" <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v3 5/5] ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Date: Fri, 19 Apr 2024 16:02:03 +0200
Message-ID: <20240419140203.1996635-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419140203.1996635-1-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9b0543-1c1b-442d-2dea-08dc607962d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X/9DjHW6FJicihtEH3RK23Rr9m1K3XCo6Q+D3nHc+BR78j8pTy6dRPsA6gEsGirJWLkfzdw3VB7oPaxzb3tmVXboNr9hsvCcH7WDWCWWJ/EjdYek1YyUwvm1PGiFjkaMvBtXlR5qtXwBSG3+ifmzeJT+fzNvykXjZR+XlJxi5owWdp+8SYMQzJAx3ckNz75pdyGboUrbOuqwy4+LW5SWL7FUotBsxGBuu6yduNFPCf6t7ZGiA7PGmNY4cJ7wfUij0kWwyHCv8a2kxUo6GuAdv1nRJ4zMG1rHUnfpWkHbd1Lr1dNSGy9NRwHPwYGZYA/n3LhFjzifCp40ojVUkKgHSEe53AXmr8Xt5ooSm4CjfXaE4I1mO2lY/h32p3riU3ge/BfcN/HFsGwc0JJD418o9j1xfjxeOIbCxYCMGJ+YSOinOGUHUNpilde/ntp84lcti4Hx7wkhp51+F0K7YgwsMytNMwXqEzdHuBLWybRDQJ/Q4Xf9tSbeRMrcA3DmDrkMStTVoloUaYiAXSH5iryFSzNogcPSXdHKSUsvQZA8FfhamihRmHpiNiPTNxhbQ9Xoy+a7wr7ZTH3wgK0klIZAE0wYcTwO0/mE4we5g6X5Kr84weALK9sYFc8RCAUcggKHNcPtK7yQLoPBItQHElVjU6YnUt+Tj+Q6twOrqP5E7J6db57+nfkh095m3pep+uUtSQWamu6dIIgjO1J2t8fEa+kyo3nap5Tiz7nxtcWMmYPe6AAYF8IcSBv6kCF7vSYX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:44.3965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9b0543-1c1b-442d-2dea-08dc607962d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

After removing architectural code the helper function
acpi_numa_memory_affinity_init() is no longer needed. Squash it into
acpi_parse_memory_affinity(). No functional changes intended.

While at it, fixing checkpatch complaints in code moved.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 37a0f4b3d24a..cfa1cbe4a1f5 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -243,22 +243,30 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	return 0;
 }
 
+static int parsed_numa_memblks __initdata;
+
 static int __init
-acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
+acpi_parse_memory_affinity(union acpi_subtable_headers *header,
+			   const unsigned long table_end)
 {
+	struct acpi_srat_mem_affinity *ma;
 	u64 start, end;
 	u32 hotpluggable;
 	int node, pxm;
 
+	ma = (struct acpi_srat_mem_affinity *)header;
+
+	acpi_table_print_srat_entry(&header->common);
+
 	if (srat_disabled())
-		goto out_err;
+		return 0;
 	if (ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
 		pr_err("SRAT: Unexpected header length: %d\n",
 		       ma->header.length);
 		goto out_err_bad_srat;
 	}
 	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
-		goto out_err;
+		return 0;
 	hotpluggable = IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
 		(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE);
 
@@ -296,11 +304,15 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
 
+	parsed_numa_memblks++;
+
 	return 0;
+
 out_err_bad_srat:
+	/* Just disable SRAT, but do not fail and ignore errors. */
 	bad_srat();
-out_err:
-	return -EINVAL;
+
+	return 0;
 }
 
 static int __init
@@ -549,24 +561,6 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
 }
 #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
-static int __initdata parsed_numa_memblks;
-
-static int __init
-acpi_parse_memory_affinity(union acpi_subtable_headers * header,
-			   const unsigned long end)
-{
-	struct acpi_srat_mem_affinity *memory_affinity;
-
-	memory_affinity = (struct acpi_srat_mem_affinity *)header;
-
-	acpi_table_print_srat_entry(&header->common);
-
-	/* let architecture-dependent part to do it */
-	if (!acpi_numa_memory_affinity_init(memory_affinity))
-		parsed_numa_memblks++;
-	return 0;
-}
-
 static int __init acpi_parse_srat(struct acpi_table_header *table)
 {
 	struct acpi_table_srat *srat = (struct acpi_table_srat *)table;
-- 
2.39.2


