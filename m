Return-Path: <linux-kernel+bounces-157248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB818B0F11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447AD295799
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017A16D4EC;
	Wed, 24 Apr 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oTNEOfyd"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10F16079C;
	Wed, 24 Apr 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973772; cv=fail; b=tfggPN8CbtZrD+ovu1uNTiUmM5BeFJEa8nYsydmhZESRPhcYJhzyyld+WXOXeQWyc5TDaWSuSCGGq14TLJSprsRyRgDGPIj1pJa3cSNC+jtVPU15F3T/1ML4/t2jba8DBBdal9yThyCybX+z6tQzxn1bnoN0C17/qk13ebGdquM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973772; c=relaxed/simple;
	bh=CbBWWmOXMZJr+vcvwQUw1+jmvgt/g91nyBpwqi4k33M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceGw0H02CTke9R+rf9nMqrBjJlnArzsJqdRgVWM4fe1BMvgAhTB1HmlhVk193MuR7+gXfPvLD5szKiyLNKT0TklgjmlMiSdB6r6KNaVTpbgd/ok41/mIptjGKx+CC9B+QlOHBEqC4R22h1+/qraK5GsMVSKwn22iDRUka2AV390=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oTNEOfyd; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTjL0d4l0gn8anbCKX7GAgyDF2x37KD0Jf5rRIT4Av9OUweLNx4d9DaHV3I39flLJRo2IPc7GCxojP+4aAtIc1AMj9xuzDWeFv+1sBJrOlTbjM3Y6kFjbESxyxgVG7koZKpxAz/q6xqCUG39oqRtkIXzDmkeEgtaU9SKDjkapfvDad0M8mGGbHi3wDCZUqAahsJmOKrx/ELlRAJqJpQn93xnx7AcrU/B4NqLTgFc5ozFHob+CaVVYifiOPavGI0rtJ61YR21VkIR0k6P3K1oNCXThmx/GiKyKwce+u8kKtMtjIV+NdPL/aWSt8qjnwAGzopJkwPOYx03UoJcP1ko2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob0xrBAzWy2sgbstIGdjZMOKVz6xPbKy5SjQ2fC0UZE=;
 b=MQX+uEZHdfS2ZHPn7ikdKcUyYByzzndiTgjXpfXgv8lpKrRlCcnRYCQng77B+48gDgRyBl7fT3yGFzQTTjVMo5bzKwExNFF169ejqTx5UFrhZ6K3P6JqpE2y4GuCast0eb2j+R/aBSg5uKcHZDdImU+jFma6h2Xx7mlHqJAQ8WpdPqamhIDQ3LjE7t8Ah+OK3bcFLLDhaDgcWH/yvRfzahUx6/wYlo4bAW1u4Tgdpm7qTQ18caFHvVQidXRPrKTwvPbwv0QkdbZ6L3EgfYeb45HHOirsvOgCemULB4+8WRU8f6EsCP+6rD0NDyP2b0p0b2lxBRtmniRyzx2CKl4uwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob0xrBAzWy2sgbstIGdjZMOKVz6xPbKy5SjQ2fC0UZE=;
 b=oTNEOfyda28hdQGSbcqXOU8AUuWq14bpFAxZ5Z/tkpv6Fecm56hHFVp/Gs81kkuRnUTo6pRHc8B2PL/w+abzeLHdY3D2fKOObndgHu2mJ70wFtmkrRbENqaYV+PfDncoDYWMfA92RYTBdaaw8oGCXGdtFSeUHl16odIOEMQDrVI=
Received: from MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:49:29 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::b2) by MN2PR05CA0011.outlook.office365.com
 (2603:10b6:208:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:26 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v4 6/7] ACPI/NUMA: Add log messages for memory ranges found in CEDT
Date: Wed, 24 Apr 2024 17:48:45 +0200
Message-ID: <20240424154846.2152750-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbc7451-2034-4e2e-f2b4-08dc64762039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400014|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?64PXKo6orVqAgyg/T/jb3LzmsbP146CMqKuwaTU8CiUJP2YxU4y2CtkVx+iP?=
 =?us-ascii?Q?EvpCZ2nAaoZH6LuNuSiI8/I3fTso+VzaTXLMLs5sSsk4RxJFiAx3CoHHl92v?=
 =?us-ascii?Q?1QUkdQYSIUPf92W10xz9lJHQPxMXcRNVakzDiiuDiKSP7FrEMX8mFAdiCf6V?=
 =?us-ascii?Q?4Y/S2igEthkVQB4rIg2UymW8itY5uMjV7AQrmFlzwB/r226STnBcSwvb9b8C?=
 =?us-ascii?Q?9W1eWkZjXj7SorIw5fdobjYJ7TWI/U5hTbArlG3nWxkewuqffX2S/fOwme4z?=
 =?us-ascii?Q?nbniiXZFMeufRBo2P8PZbd+ZUemUVYGYGgCGQEIvwRl+LuH32/vgbKER0D+m?=
 =?us-ascii?Q?tQST2G3pXm2cUZxx1QkSg21vmyT7O+yIKAID3wWGfy9tWK+2lrQWVPA7PGyv?=
 =?us-ascii?Q?zJ1S0L3R1B/ejvws6ML3kJPMYlzrTsSnRN6kQ5wIfMy4yU9tSBvhEaFQO2CY?=
 =?us-ascii?Q?EPRgv2huheKbOyNJ+WgOXQpivySpREWjdsOSFrF/0n1Q2EI5I3dkyOLm6O9O?=
 =?us-ascii?Q?ZO9e9MpZK8W68aAn6xOD0A4wgUKldDG2wdg4ehpAeQ0L9FNGWoCg4PfBRsUe?=
 =?us-ascii?Q?eYBKCSkORVGbVpGXNO1y/X8TAgf1nsqNG8PsBqFWpssqkr4OicIfbszrgmhz?=
 =?us-ascii?Q?GWErRzt0PYu+0I4MM6NvTmjQkdzm2Wjgd7WcQa3vuf6fcxrZE7Vd57vEsqPy?=
 =?us-ascii?Q?2Iqf2gmWCw6YYhPe1EvzdCrspx+bGVFIvrItNMKWlzcLE+MxxAyQqovJi+4c?=
 =?us-ascii?Q?vjNNuSCKvtCe61QnzWRD05Dt/+YuMqNuJygSBYJxQD+OMJ7J2UEJrnv2xTnw?=
 =?us-ascii?Q?6DQ3EiH2Q7uEmLTvXU0FxonmiCa50qczNkwKn4qVd2PdsgX+bDrdMcK97FO6?=
 =?us-ascii?Q?8ySd+zSupX7bBES4VM9xnzXrhKI0CEDpubTyMy1FMZ4p29zV2bgMsJRAzNVO?=
 =?us-ascii?Q?lpa627AVlRvWwuRoSAOHgfxgbFsQWVKIwps0W4cJbjn4/40rcjApAGfZtCnl?=
 =?us-ascii?Q?oOp/aY5E/jpBivhua5DtCwpY0NKkb0MUzTdwMRowBG6quHaAPfEQf84wpv/q?=
 =?us-ascii?Q?jfsKpjNMtpn/LLYWfwtvvjwGLXzS0ndn87BbcQg0ZnQpwL/0+pSpN2//ik7j?=
 =?us-ascii?Q?0rFWtdBjarx1WAq+jGWtMPlrUN5W0ZIqNeXnPxngnUVBiJ2SIpIHLIYuA2dQ?=
 =?us-ascii?Q?q/tEVyA3bUPsLgrlIW/HJh/EDDDLi2Hgwme6t+3CgCZm3fy5ju4M+FQ18CnS?=
 =?us-ascii?Q?Ehcq3bXM/bg0L25jMlcZSkcTYFrfoMKzmPDK+rBX2ckk8aZuKvFYOvPcDvq1?=
 =?us-ascii?Q?x1uHetE7zPQQGanOvrVKjiJYJMMn9LFF21At8BA0EsmupUzwYz0gNTojcKl1?=
 =?us-ascii?Q?pdG/IZ32SKyu7irC0Owbq8uKG0EQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:28.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbc7451-2034-4e2e-f2b4-08dc64762039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

Adding a pr_info() when successfully adding a CFMWS memory range.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e3f26e71637a..c62e4636e472 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -338,8 +338,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	 * found for any portion of the window to cover the entire
 	 * window.
 	 */
-	if (!numa_fill_memblks(start, end))
+	if (!numa_fill_memblks(start, end)) {
+		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
+			(unsigned long long) start, (unsigned long long) end - 1);
 		return 0;
+	}
 
 	/* No SRAT description. Create a new node. */
 	node = acpi_map_pxm_to_node(*fake_pxm);
@@ -354,8 +357,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
 			node, start, end);
 	}
+
 	node_set(node, numa_nodes_parsed);
 
+	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
+		node, *fake_pxm,
+		(unsigned long long) start, (unsigned long long) end - 1);
+
 	/* Set the next available fake_pxm value */
 	(*fake_pxm)++;
 	return 0;
-- 
2.39.2


