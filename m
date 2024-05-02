Return-Path: <linux-kernel+bounces-166489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8238B9B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344CEB222F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB285C5E;
	Thu,  2 May 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ubcH7Hpr"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE383CD1;
	Thu,  2 May 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655452; cv=fail; b=Kyih854gP5nuBFyNZi0WqZBQjq6ujPGW/y20phgVvpFjPgdfylDBwqHfsHkJX8q3rMBUwkUQ9n1TI5Q19l1gdlZz6vK8gUAJFB+AMDiImaRNE951n5AI26N1XdOxL0u0Qa7GKDHIbhjMri4/b/hXVtXuAVAMwfy7MdqLdnYAQMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655452; c=relaxed/simple;
	bh=v1JhYc6iUtZ9TCumyvSWziE9cjMb5FtLilah2sWZPB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZuR+qCkiB9qjDOIE9N6CcEylATUYgVa53xEpZGinnyitB/jAoSsKbkeYk3VSKiPfPWlRPXiUTG8gB1VbdS3vXvGskNMhbVNe8BHtPKn8Av3TK2w6wXsIVgyxm4STZxRKNBr7fZwQVCj8WihIZSP9mPGDZo5J5VkZfbGLQEIKjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ubcH7Hpr; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZx0aJtdn8l4C/T4jtUy+3c+cyqxzXNcyW6M2wcw4qF8AEsbo14wZvFGjRWKJ55CL2Y0IWhJXL/l6cH9sj5Vb0nFEICafXVQk9YhvlUN++v69F/5mf9FRge2+UMvNRiRP/qF45fccZ1MERr9ZYOGSYA6AUVYXpK08BzNUAVWg+0UTuCuCf5HEV8HIMUOQB6hy+CjPgbGGN0G0NY6aRlv8/rIlOiwunmS93OGBUlZFXWLr/KWwX1Mf3Rgm9CNmwP9lgwyTCFb7bgRr76sDj/vx3e/F2AMnf/Wyk5Evcl+BojVwaoIsG+Nm4xN9JEb0p1DnO/3KzVDGO5DfFH+QSLm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64z5yhRlLAyXKvUjNmlOhdqIx2ToTLjxrNdfM+KGR8M=;
 b=ap1dG68GMGnJMBtO203cnfeu80030bbDpUaP/eHnRjXunpTfMNX/KyICOOBIde8jWVU3i2ZopMGICNa4BWaV2j9fyOroEH3XCT0Y0w3p2APSFNV1z3aAcR0BGPaF5X6zyQ+9QGLTn4C5enn+Mfg3g2hCnRRO5FDA4/ToFUwfa5zG3NbOF437Nif4GK3H2SAHPNshi5C+yNBnBjBVCzIzIhsW6KuQPhqh9E0qn/KX2FltR2Q+/iuBnDulavaU5hrYhGXeOgXCbNFtYyZLKR8DHloeR4kBiMAelKxx69190aWg9zl+p62EXatjKVEO8taluBQe5a6ra2JdM1rNaqFQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64z5yhRlLAyXKvUjNmlOhdqIx2ToTLjxrNdfM+KGR8M=;
 b=ubcH7HprUvd+TJmiHLxAUWK40+c8/2hIxj0kDXcoVwes7ghEmO6H5ZHfrRyVMD9+qwOOutf1JEaCAsk5KedfxMg9hsAoIyIuLrW2HPtNBpycmhTP3SXx6ss3heGBFiGaGpAXVehX+kR3VoLZzaNlgTFq88M6trBxR0m7MPxZCWk=
Received: from CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17) by
 SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 13:10:46 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::6) by CH2PR05CA0004.outlook.office365.com
 (2603:10b6:610::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 13:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 13:10:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 08:10:41 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v7 3/4] ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
Date: Thu, 2 May 2024 15:10:11 +0200
Message-ID: <20240502131012.2385725-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502131012.2385725-1-rrichter@amd.com>
References: <20240502131012.2385725-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e002282-0414-4a75-02db-08dc6aa947a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?95jXfq+nJPv3ZA0S1HGoyV1Y4igwipCrwL/eu2blQjaXhDBlHVzqzFBsBDgk?=
 =?us-ascii?Q?JOd04w6iJfpZL7NYp5sGSKcZTvQsMvDcf/zng9LLditWg9NWs5tIcfR/C2Uw?=
 =?us-ascii?Q?jpXIhSUC7VRwNx+S2raNYswkwL6GvEmhj6zKbzkIbwt/XxBN3BsEj1Lql7X3?=
 =?us-ascii?Q?rByLGHtn7/JllQ6FjzW4CaOnXJ+SV1T9t7FBlPPl7UO0VvvvKRcVK66wZCAa?=
 =?us-ascii?Q?BdVWf84jxe1ILAiuZYHiRYBXCf7xapxoPWrRBjsw5u5DYmj2gUdVg2HkHD6l?=
 =?us-ascii?Q?913KPEGECwbkBln6cYLbjuh3QPUyU8nzO9u8WRl3dAL+fKAFMYR23l+Jf9Pb?=
 =?us-ascii?Q?163LvxptM+FX7fGf0CJiEOcl9f1md9yJCAkKThMluAsa74yZWPnEFPnZmrjF?=
 =?us-ascii?Q?XBa3AIXL9tzmDmz7Fc4zEFWliCkJpiHjjZG5bmM22oMWx1Cl6G6tj5i4Zl5p?=
 =?us-ascii?Q?HKVPF6N5B4SxMgGcC97HoLPC2z+8um746uPpHHS7kqSUWBz2ILm8aB2QHTHw?=
 =?us-ascii?Q?CPvX87GvDxfkBH19rDivMgbaf5RrVUsoEKRrQzZXVDuuB1zm0X0De98F9TZc?=
 =?us-ascii?Q?fTl5v/A5VuUMGfounJH77/VG/Ot05XA2TdQD8xl7oqNrJZ8hjGro0dq8bmoS?=
 =?us-ascii?Q?JoTsQWBVPsy/gz5xDkIt9aBX7k11PhOWky/yOZ9wfMWIwH8w/5rZyfPZiJrz?=
 =?us-ascii?Q?Ai+r/9AyqRzkxP6E3ykT0urSKMc/dFMvSDyUsb4180Pc0lIgIHBEi5232dxb?=
 =?us-ascii?Q?q3wl3g+WCJ6vM3jkTzk1vi/4TOeGZFOK8tJKuT1jS/TWBzSL4+RK6rjnSYo+?=
 =?us-ascii?Q?K8qB1OdU7bBcI+NZm/pHDDC7uAlsUWIrQ4rUMPCMOZae50tk7nW5pQ4zXFVh?=
 =?us-ascii?Q?jC9bHuOh6+3ZKb6AGb+03cfhM1w73H/ik17o+L4TLl53GDgz58aSTKFCEZqX?=
 =?us-ascii?Q?TA58Ha2UOdgthLcNVkzwJeRAFtx2ktajVrDyONYAECmef+kIqNa06TkENapV?=
 =?us-ascii?Q?pSF/nYoyKBV7FdntpIVDmUJhLmFMPw0wmeB/D0iiEdvOFu2wWfxfpoHPSq8p?=
 =?us-ascii?Q?eE/b8ZXlAaLQqQSDoR4hSSeJEW9hpdtXGDp3isP0/dd92qvFNz0jscoHaITM?=
 =?us-ascii?Q?njdetjpE+kXbIQqET9FSgV4ddnOo8B+0+Z5Zxzf6y9nbv3KokEn7QqxYwirX?=
 =?us-ascii?Q?SZsCnGaeXiyr6adj90vKeTWAOsmk6p0n8HO99wyCKlOUN9DHY7jqIMAQBmGN?=
 =?us-ascii?Q?e/gue3ZWLxfHzE+eOYfwrLHnYQibdqZkRogCL+zCA+1F7DFWyHj0tGiDicy0?=
 =?us-ascii?Q?KQHu8kfZWMDKKMHnSeAZan5+YNna3posVuYIWK+705uXGxiPvt8WzxgWYAuE?=
 =?us-ascii?Q?SIXF3jk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:10:46.2219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e002282-0414-4a75-02db-08dc6aa947a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

After removing architectural code the helper function
acpi_numa_slit_init() is no longer needed. Squash it into
acpi_parse_slit(). No functional changes intended.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e4d53e3660fd..430ddcfb8312 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -218,10 +218,16 @@ __weak int __init numa_fill_memblks(u64 start, u64 end)
  * I/O localities since SRAT does not list them.  I/O localities are
  * not supported at this point.
  */
-static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
+static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
+	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
 	int i, j;
 
+	if (!slit_valid(slit)) {
+		pr_info("SLIT table looks invalid. Not used.\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < slit->locality_count; i++) {
 		const int from_node = pxm_to_node(i);
 
@@ -238,6 +244,8 @@ static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 				slit->entry[slit->locality_count * i + j]);
 		}
 	}
+
+	return 0;
 }
 
 static int __init
@@ -341,19 +349,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	return 0;
 }
 
-static int __init acpi_parse_slit(struct acpi_table_header *table)
-{
-	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
-
-	if (!slit_valid(slit)) {
-		pr_info("SLIT table looks invalid. Not used.\n");
-		return -EINVAL;
-	}
-	acpi_numa_slit_init(slit);
-
-	return 0;
-}
-
 void __init __weak
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 {
-- 
2.39.2


