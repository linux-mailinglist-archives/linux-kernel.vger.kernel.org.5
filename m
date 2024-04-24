Return-Path: <linux-kernel+bounces-157246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25B8B0F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF201C2331A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5216D324;
	Wed, 24 Apr 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZzP5BeO"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19054168B02;
	Wed, 24 Apr 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973766; cv=fail; b=lcNzppLnVLk8r3PIKJw9229ZigpED41KUH4fLRJzltZ01Xq4yYm+/OGvsD7RzD8NoaiQD2A6/WI5dCOX4+lg+U4nzEcKFamAin0/TaUg1n7elX5gINvhCXedtsOJOj9ExRcEj2bEmpcAEyh5WrJ0PaHDgQ9R1TYE4g4vW6vvkdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973766; c=relaxed/simple;
	bh=3A0QL/Q2ZLGYAxVW0jdhOQ0VW3DumNN9kZB9MQttzwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxZDFHdZ/z0Juqaw9+JOG20Jt1O6256rF74CUJBEbR/m3i0PxgPVc7Z/jst9oS/WK/WRM6KE9zvJLK2nd0X+Px2KSWKvLJ1S1z0htmwc2EIef8dSnEjhhy8xWlafWF6APsjOepUtv+b7E2TYOwewAq50OI+A7nCx1Kurm4dhdRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZzP5BeO; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoiXVDGKomQTOS5SOuMgMkSNZM+effaoOdVgWvKXwY8ShYe9gRgTsApzE5++EaZUhn3tXtX0FXwgl8KnX9AP+vszJEUxsfH6sX711gl4mtb6xoj915rbfbbD+CdtlEzsZbQKMWwTaNWdZannu1fDMsAzrrqLuMb7FHE5GlZ7aSudG1CeqynxKtSIk1GHVrZGoTDL4Lk21W1U/HF+V6N1mGXeaOMfJa34l8jKmean9M2ENNkEpf5kHGwXn0VnGmfJflEPm/X8x6uw+LkAD9ONF98KRk5AjQDzQVPWeXdPsGFZMWO+oGJJ0OQfQ/fzBWu3BqO4po/3k/tcZG4I15mjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UISV2JCdeG71+wO8w7lSn249sa+w/Qr4NBQ9V5O2Ko=;
 b=iNl/jNC6MeLWVqdiObfSfPglLbMvto3qKVW5GHYaPCuSHQ3oemj23ZWE3LWTQrcm4fnt3LGTNHo+XcYnppMeLAbAaSQ0TsaVC5wWpug9LVjM+I8aVtxl7O0fps0dskfE64EirPIiffss/tiYKXLJtDFtsJ19f/jcPhcQ8D93srYOmdKn2mAUie1+zxV9jzGa2hlSCCF2kigH+rMVNk/lZQrSREVM7eNNBtygJWBiNDNxJqqlRx1pbNGj5FW+7tdtmvbVCM6FK18b75QOKxVHdJk17zXDsHwW1N+7edmxSOvLya0nh7zANDDP4AyGErHnaAILsnP5l9osTLEMHCtT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UISV2JCdeG71+wO8w7lSn249sa+w/Qr4NBQ9V5O2Ko=;
 b=dZzP5BeO5lld13oezXpZ+nTHiA1Zy8AWLqkF1uNG85fmzqIMYA9jcnVRx3B3MBYxbMglLK9ITN5ZFkPqE5CMxIyTVJGKG2oeApDp5Vu7Nawm83BD6fFYwCE5w7jeehBMwd3k0Q/WW9h2X3gV8gSHIxpZ/vgGRv/l7rkPuCi90gE=
Received: from BL1PR13CA0358.namprd13.prod.outlook.com (2603:10b6:208:2c6::33)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:49:22 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::3d) by BL1PR13CA0358.outlook.office365.com
 (2603:10b6:208:2c6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:19 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v4 4/7] ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
Date: Wed, 24 Apr 2024 17:48:43 +0200
Message-ID: <20240424154846.2152750-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424154846.2152750-1-rrichter@amd.com>
References: <20240424154846.2152750-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eda9d6e-459a-4433-43ac-08dc64761c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BF8mBIsvA+F1kiuqOVBNxhSLeQu97KO1yypbybnvSLMyjeFcazC69zdLa3sV?=
 =?us-ascii?Q?Yy7/mUn9/HdEqQrr9PwcBPC6QN9UX/jUS57DvDQXggWbD+bBMTG3oBpCgG4B?=
 =?us-ascii?Q?efwjtcZOy8s2gSVwBHisFhvdTd8ZYRCbJWqHMCcJxnVMaogbrgTXlnDaCyU1?=
 =?us-ascii?Q?/8AlRPVATLNnATWE+GjH4MThV33u0VLGoTUMzCQaxa/DwAABLgeMfIqypvjQ?=
 =?us-ascii?Q?GhvD/8Jsj1Usaf+NY/Olj8Oq5zOL+Eoi4AYCt2O4PtEaDm+XKGf+UdyzjHYO?=
 =?us-ascii?Q?jUn2g7W/KmrWYhA4AGeuE3gSCrX5DbiY7feuZQlmO1976qoMLPQua8HwJAfX?=
 =?us-ascii?Q?3tWr2vYupXkmC83v8hAcnLq6+X+Sx+u/w+wSBFKOYkpg/j1e5/SVQXZTGtq/?=
 =?us-ascii?Q?v9jTiSLlNSRTHXyuCFL2KW476UY4KopP2ls1fw3SpYdQBDxmWSsIbm96yilM?=
 =?us-ascii?Q?ni14Etpjl8m5zGysw8hYYJqvd5wRN8hkaQXVak7rc1da/M8ynTnHexpPFFvD?=
 =?us-ascii?Q?oQi3kjG495ST43oYRt8CHvnBhwGtPyhFRKltwJaacbqQPJqShhwt+BWreHEp?=
 =?us-ascii?Q?3Pmio3xlsYfhnh9JnkKf8/CrDf1nhyTADYhM48OE6ujckql/1ITUtDQT9DZI?=
 =?us-ascii?Q?8f0kY34BltXLTAWtmJdehhib7LjUrz8Rh1HN1EZdp79E5pdnuiFapLYcdQRZ?=
 =?us-ascii?Q?srDO1jWUbOsg1nFseJBx1VqOTKuOsHTTRCR6bAX4d1Uw+M3tFHVr4VYk5jsI?=
 =?us-ascii?Q?NtXFRDjivp9LkqBnIak3QE3ogZRT6ahI5CQnRjJ0SSvpFxmCmJGWI+CruCGY?=
 =?us-ascii?Q?bDS23lyfr00PYNKycnOfH5IJUrN2LCb8O0TuwKz1TOpFWB0kY9EDMNZV9ypI?=
 =?us-ascii?Q?+xloLKOB6zPYmX29A860ack7iXB9bdnJdxHxloTE3A9b/l9i5UWTlph38Wfx?=
 =?us-ascii?Q?BosgKpi5yPQQNID1O1QXeH8Zkz0OqVd6vRCtRw0IxcdAeU7N7KxsXXqBpl1k?=
 =?us-ascii?Q?+/06+Tc4aJ0CHahmtCbY3cdqSy42PjCL6jA74efarlP0Uv1Sgaf6P6v8cWh5?=
 =?us-ascii?Q?ivskdw/6DTMjc1T9RM3lzAWCk8BoG9ZAP19W84h42CR3HKrnU5kKl0oGN+sJ?=
 =?us-ascii?Q?c79cu5yjydiHRidGEE5HNi3XamUDE+Lu2GDgNRRCw4UhjPJ4HME76DZzZCRj?=
 =?us-ascii?Q?9yh47Ek9+2SEfxrqijeAqnwVXu27DwsXMrXsQCSoBxTEqcdaweAdwrwEC17X?=
 =?us-ascii?Q?wyO2ei9ZPb9kNo+jbVT7/xwrC7XcECIfKIbErc0Bc+QdeGF7MFiYFqw86qjj?=
 =?us-ascii?Q?L3ZFaS+Gnt6du2qr0QbcCjD1C5m/SP4WcURQWjAFk1ujSacycP7sK4Q+oPFP?=
 =?us-ascii?Q?35tdTQc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:22.0683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eda9d6e-459a-4433-43ac-08dc64761c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

After removing architectural code the helper function
acpi_numa_slit_init() is no longer needed. Squash it into
acpi_parse_slit(). No functional changes intended.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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


