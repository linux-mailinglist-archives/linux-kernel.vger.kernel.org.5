Return-Path: <linux-kernel+bounces-163681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE58C8B6E46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24C01C22CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFA129A7B;
	Tue, 30 Apr 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P3tbYBOa"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811071A0AF3;
	Tue, 30 Apr 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468957; cv=fail; b=iNfSPi3YfhWB5yetsrWMvH+fJAG2cS+ELjLUqL5Nzq+DuyZN/7K5s2MY1OhZ0ls+XZvtbKkoEbKxmU59DK5D/MwQUAecjy+KDzisutjzOhUX7uowk3BQLiTaIOfDusIoWmgesXdO/159u9dWXMEwhzVtk3oy8c2+xNrd06rEfeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468957; c=relaxed/simple;
	bh=3A0QL/Q2ZLGYAxVW0jdhOQ0VW3DumNN9kZB9MQttzwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD11klyiJf6Av4xyusibjW6qSSJGVRct+W7UvpnZ+43NkWMqcKG1PctNwUrnFRPMXnz5W8fRZJuJZNATMsLEqe8BY1KOlV4YCxvtpduCBObKlfMhJr7D3FnhBbsqVeK2VxanBM1x28pihwCVFDzbayUrTCmpTvC1YaRqwJ+gSFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P3tbYBOa; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWlL/cXvesapUB1/9Xr57kwG7wsptHbaM6lnIANuIHyGKpcoWEPNlfTF+r5dNSVEtklLx8Aexa7WpqP0rSEwncYu1p8JCdgeA8GJnGRj1SwjAzQMFyClk2HeNSG7pNpHuuSdd1t1rpKXn/vmTB1VU+DB4GK9Ltkzz8kGVSIa4ShfxNekeXpqowWGqGdTAReiSXEcqICERdoW6mMGjDL741L2WcclwhDK5pFiRI/gTBbkkyrtvFlcTMEGqOFiOAaIXY8EfqlofhqUIoQFVNROtqIrQBsJSujUHiyIkSOqs08WK6PSmuk5vi/bP/POvGNbXnXpsS0vBitd4iKBzX3tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UISV2JCdeG71+wO8w7lSn249sa+w/Qr4NBQ9V5O2Ko=;
 b=fUB6O/2hndEfUMmOPbU5WA4u8Y1tAcDAzrhRYKNPkf6gJeZsalQZ0YGsUguW3Tq01iNTu49Prc/KL1DIvzVZuQUSqc3VP9d+iduD3MEg+MFqMpp53mhe9yEHd7ZXqNlgMw05Trd6pU9JfdBaijHvfQuaqTmURbM/Dr6IhBGLbEhluUxWFlahww0YsBtoTkexuTQAxI0IXZhMos04nmCqMlo4mmPI12wxob5hdRpz8SKpxSSNs9SYFNNSSzoSZX1++l9/Me4v/kt7p9C2Vfm9aPWnX0qd1WNs/x3rQTAhlEWimOrCFDOmvuFJtJhIzD6rYtV7/vblLqNo5coqpwlH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UISV2JCdeG71+wO8w7lSn249sa+w/Qr4NBQ9V5O2Ko=;
 b=P3tbYBOaoi/tOMScMElqTjZShO2R0PIiLriEIf6kkfqGWbTiKzYnFHjjDXAHit/o6l49A5cPTpQeh4NuK7wym0/DU0D3Hn8Btd0hKNxZSRmyQKIKKU+pCQxZxdtkl/w8WFUK85oTjLUY4jS2AMBMPTOZcpTGucU1tJ1ePfuiKHI=
Received: from CY5PR17CA0025.namprd17.prod.outlook.com (2603:10b6:930:17::16)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 09:22:33 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::1b) by CY5PR17CA0025.outlook.office365.com
 (2603:10b6:930:17::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:30 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v6 3/7] ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
Date: Tue, 30 Apr 2024 11:21:56 +0200
Message-ID: <20240430092200.2335887-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 828bdfa9-6785-4915-20f8-08dc68f710eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tPhTS9om0ThfXe2ZKiixnTEcSABEkFEVj5LJ8gim8FfOE0e8vv6JBlLyMKhF?=
 =?us-ascii?Q?ADQq0f+i2rcZMGlIxogapqgL+11DIVAeYoRmS8IN/H1XVPntqEai/J4/+DFI?=
 =?us-ascii?Q?m3ZyXxYcNTGKMYZ6bHtaVIK+KeQ1aENOLK2R0K8RlQ39aOWxxAIlgXwm40SB?=
 =?us-ascii?Q?86k1Xo5IXAZ6sRNrwmH1wSmN2JBmpoJW271CqP5tR5G5NH8AODVZGjgBmDn8?=
 =?us-ascii?Q?KMWmFkZ6tJGR2gT90G0N7y4eVa83ycR658CKSN/Ern1kh1nMBj2SrlkQOR08?=
 =?us-ascii?Q?WqktJoEelqeSitvBu8pr8mEUw7kUaUuXiEokaTvHNRw7rld0JMFuCUzX3IOw?=
 =?us-ascii?Q?cHet8qngwuhE00NKw9rftyAr/sjgoz5HGXp4wQ1Qebto7p++nSrtQU/sijH1?=
 =?us-ascii?Q?gAnMn5sSWtlBkW2ViR0cmMWXrZ4gLaffFG4MX6pMt1pPiRnKM4FaBcyFrw9J?=
 =?us-ascii?Q?HVRW2RwWd4G+NAco6qSFp3af4l+puptppDOyTSV7lwpy+4crApqQeYjqbFrY?=
 =?us-ascii?Q?FTYeCHiSs+F9FieJUgVf3AvM3Z0vRh57VqKLeEHgEDpXw4iLiTQvexu3R/WY?=
 =?us-ascii?Q?1odBc3Lg62r62qL0sWO0TBgTVpGqJH8uau2hiUlB0owsPjPYOwno2Ga9CjJQ?=
 =?us-ascii?Q?+59BaQXODdDume0mqk0jJ74UzS5QVE6eLzJCKd7N50wcLFlDatQDk1Cy6Coo?=
 =?us-ascii?Q?+9MP7rdIVf8uDaakL2X1WVyzzRzfbuYRqzMMiNJOTTIlkGrWEEbKKbiy+bFk?=
 =?us-ascii?Q?UpHT7OKpVmBHsuxgQM7QxlxBSALMmBsVp73PH5FOoStxq2cPOuMEg70Y61RZ?=
 =?us-ascii?Q?WyxvW4otae+AFvfX9/PsdZvPVCTsi2m4G+V3nqOtcYCbU8lBiDMZ1PEN7FKo?=
 =?us-ascii?Q?DzdkszgKlU5NuArQuRVOsrwNmQ9RCsgi6Ew9XeIDgP9uqMLn5rRMo4F+aIl9?=
 =?us-ascii?Q?PJNaWVQ87BwBdQVLeqpWKvIgWMOuzWfz/koAa8/vE8BG4/aQUqzYNL4oG6Mu?=
 =?us-ascii?Q?Hq/EkMC3R9unmdPldDeIHvJxIiDz9q8OItCh0Za29DGKUNt9/JR2fyVjb2u2?=
 =?us-ascii?Q?Gv1zWnRVvSTZ3d1PMEZrD56DWPWrOesx47grG1hvdSyAB3QnFRfrcRNBZJmq?=
 =?us-ascii?Q?ZC6sWMZw49vz3oGSuBe6ec7p95ujRruUnoYX/8epA6afFNgMNvfmpw8ld52A?=
 =?us-ascii?Q?tndp8aR8HsZYuFy2pOapsd0WBEZ1mSq3FVn2YmmyuESj/N5H9mo/qBqkHhEi?=
 =?us-ascii?Q?stG3qu2TTvdZINJzC9kc8nSUNoFGLMFcaZVdtvRRszvoJIm/3CgmaQi793zh?=
 =?us-ascii?Q?WlvtjH7PUpWAJzThQwSK1lLIaB8s80cAr4anloBOSPQU0FQ1eAWifwElBtcj?=
 =?us-ascii?Q?qzi8cnk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:32.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828bdfa9-6785-4915-20f8-08dc68f710eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

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


