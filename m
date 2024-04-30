Return-Path: <linux-kernel+bounces-163682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DF8B6E48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A11C22B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE81A0AF3;
	Tue, 30 Apr 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ao7k59RO"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891A1A38EE;
	Tue, 30 Apr 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468961; cv=fail; b=XKBWvqzpRecsxSnzBdXd11+4cqIgfJh5Oz8WjTGDrCWxHx0VovMgK0pnlYGYMrhpsyvv9xapYUx650RgBlpzSL//ZzpwQr3DeYSkuG3Uo7+eOjCeQ57AzEd4H6eJYF8LmVoJ4ng4+bf1RfvAAJWJKpfZpf0AwWkJxFoUp4pyDG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468961; c=relaxed/simple;
	bh=GGVOQyQcshRXGn7vgXDtIcG0ullrNrrKkucC9HaihuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cd0wUti09og37LS3FE3qeB4KeHCVt7reNWatAbq4rer0u51qds0ZBksJT/YGMJRphDoWu+iNm8sLiO1lnGgI/tallagjq1GgdqV4hrcsEBH25H5ZTBq2YeqOh7gCKAzz5z+tYYJJLFV6ad3tCB/v4mceXtUueXTTvPTQBlCotbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ao7k59RO; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvRZivYsFDVjn/0DtzDFKhJIJL5yqBso2k5t5axrKlUv9SO60U9Y0NjCOKr5lcHN33zk0vzes9aWjUakDgdE9tyZgS6RAo0QRYKgcZ5VMGnFSFhXomU5GpdJpMgvG+XTjwzgADRvtct6Oumq8LC4Z3gdloxaO78RwLaJikFQRGBRNlsmYK/FJxI2UZ4Gj6tgueQ/x6Bq5UmA215d48V57G3oLnGBm09Xday/lHtKsqCpBGln8jdO1tOa+UHFS45mJZw88FsxZDSbUmwfs6vsksEa29j3b1TOLR4JnECvKF4EbCKK923bo8kJPvZx01sxkN7plTjNePFsjVhRK9QRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkL7D3UE3FQj+F2O0O6sABtRz51PmXjFWY+kdAxvrYk=;
 b=gyfcZYjjsW6RdJNlQGvjntBLabRhe4j8U5tBpR5d2F0d0/NmSuggief74tDas4+skv3y3APK9lu72N1k40u8pvc2bCc8G4qBO3BmiOxphdj5chxcYvnNOjWFr+ODvSRqQqji8nacr4kzJws9BZDOr46Z2LWVwBWaZxM4J3b0pK8//5CFsFx+wg74VwuG22IlvUBSGE2NRMfAFnWliYq1K+/454OiWdwOWc/oxGJ7er08nqsAY3Vh/r73SQuGElUnIdnjTo21jxGr1Iz0xTlJsSUcyvZdGdHYYm/gEq1DetufxGK13Fwaxv5krwzJaZLoBkbd2ou7Ga7wQk/95MBxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkL7D3UE3FQj+F2O0O6sABtRz51PmXjFWY+kdAxvrYk=;
 b=ao7k59ROnXmUW8AbQ+yy24I+lzrGuzi1l+FKtVH6c4LAyclYri5krKzJqZ2Hi/9l81Lc3/+u7xPONwcuOINY1sBTlHb4zgdDDTvNxUBoClir9agpbddfjvMIsn7RhJo+gFVRPSCC1Arf/hfk9a4DS9rUgyFtvT7CMZEJg1eXHmU=
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:22:36 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ad) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:36 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:33 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "kernel test
 robot" <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v6 4/7] ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Date: Tue, 30 Apr 2024 11:21:57 +0200
Message-ID: <20240430092200.2335887-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430092200.2335887-1-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eda927c-a4bc-4ec5-13bf-08dc68f712f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ouj8wz3jfWNKd2sNfo+UZhw7Udrh/ejI1kUK638R7lVusgJz2qLWtC3NEC5Z?=
 =?us-ascii?Q?tooWBkcVgn5+I6VmRyYQNfHztNZOYquIQXhP3u68rgFm6J6N0b1nPPYm+fxA?=
 =?us-ascii?Q?XDlPweMhFG5Q8jvMKN/zoLlYPNxsgXsoWk6JbJIDTVftYaayusir6Cb7LPc1?=
 =?us-ascii?Q?p1JwHtrN77c7kbnMbuTcojZhTa7b9YIFmeGc98UzkprGYmX9fZgbEjtHOvo2?=
 =?us-ascii?Q?clDhzEpzBNd571bUQBY5Tnoq89unIDKZuV74xd8TTC+iFnRLp/KZu14aAjdL?=
 =?us-ascii?Q?akdt8BYie8exe5w9kRVIxKKKrPQ+0yfqvemyU3Vr4riHty4iqOLOu4AFza0g?=
 =?us-ascii?Q?rwn2chbtZSL1Ej8eaiUWAPNGv4CnrFLtgDtiiYCA9m10QdUM49y676S8Hs3W?=
 =?us-ascii?Q?lP8CHDzjpO9ocMiieimk3ORdCXQZTXrIM0aDcX8xEohzJaZwmQq4UmiIdnWB?=
 =?us-ascii?Q?EkjyMG0vwPjfwoZ7pff8J7SRPlJBdmSU/g2OyyUo7vfkhEJYtYVyB446SK+T?=
 =?us-ascii?Q?7sx8BIdDgB4GYMQzCs8JL8WEq/jU5JGaq1h7kkGyKw7kRZlPBkFOOOecJgH2?=
 =?us-ascii?Q?p9SL9RtR18okxdhk4hkdodOwD4zSqWIyiaIBaHSI9uYmc4XfVgbyVrC/fyIe?=
 =?us-ascii?Q?V1yDS+9gRd3h6GdFyAEUn9yWDU388hcC4WBhWq5JdJ7OGe72IQtSm/AWa9zC?=
 =?us-ascii?Q?OcYlTi6j/G79BPSRFD3854xIbfsNJzQ9za8FDKbCNIlEfeB7V40xisCM8XmC?=
 =?us-ascii?Q?zvPl1nQknPmyA9UzahnbjNawhAZs5PEou2Onseut6jgmlFtsyZdax8oSTSnA?=
 =?us-ascii?Q?nwdywkcxOFPG7jGnLwcKJPgTQL0YnDDWdqf9moMnx9Vi+cC7fnK3YmZ31wkI?=
 =?us-ascii?Q?cOMERkWJGUvuOdGsIwEu+0S4kIdmlo+yp4dz7OinVV+WJqVtm1il3GvChZgr?=
 =?us-ascii?Q?H6kkDz0jdd3n7yTRxjap3FiubLVTvnNnxmsbEyy4R4sio5bNFpbrAZXv+3qE?=
 =?us-ascii?Q?VPt2ULEcHcnv/TKTNqaIX47hjK0g0UPIgAenst3a4Q0PayB6wyIXJrB56P6r?=
 =?us-ascii?Q?fdBZ78kLTWGvkKTdQ/ABCnWooFYFIkwJQzu5QLZfG20o3N7Sxg1CW1dRgyMT?=
 =?us-ascii?Q?4anxiX7lLkGB0cIjAO5C6bennVSGGRWVwIL82EwctnwaeVh7Jp5h1ox4RXx9?=
 =?us-ascii?Q?FRtzDtZR2D8tczmGXhmyPRJRg6Qe6uicNhxKjffR5HEP1+syVk6Grz+kxge5?=
 =?us-ascii?Q?HMAidGg2fdp2mcP8yhcRzdCR3GZK1hsPcGBLSOPAwcBoMvLEb6hyROGOSzVV?=
 =?us-ascii?Q?e/ZrHqEVj/XrhE/pADCczThu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:36.3001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eda927c-a4bc-4ec5-13bf-08dc68f712f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

After removing architectural code the helper function
acpi_numa_memory_affinity_init() is no longer needed. Squash it into
acpi_parse_memory_affinity(). No functional changes intended.

While at it, fixing checkpatch complaints in code moved.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 430ddcfb8312..e3f26e71637a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -248,22 +248,30 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
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
 
@@ -301,11 +309,15 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
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
 
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
@@ -438,24 +450,6 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
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


