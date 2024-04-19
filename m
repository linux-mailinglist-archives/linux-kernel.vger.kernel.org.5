Return-Path: <linux-kernel+bounces-151531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BD8AB01E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD601C22DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76736130E5C;
	Fri, 19 Apr 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v5MGr1TF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6714130A5C;
	Fri, 19 Apr 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535371; cv=fail; b=POhBJlI/KbcMP8Y1DL2ZIfItFI/lvhoQ6n3ewyEZs87EpGpL0Gq5dR+JB8U5sSPxgxt7wayUBSVwkmtqZ+5aGsEIFi42OUy4PJIOMhjObQsg8KwZ3nJpwIi6qfbTSIu6NRDQQqelZxRG+ByAc4xWPvSDWY/GgI2/1UpAGITC+s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535371; c=relaxed/simple;
	bh=wWZn00pR0mxg6qbbKHXOXOaKz6XaO/nwjyLCtI3VJ3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st442Oyot+brbQ+Q4Km+EQVh+3r2UaJQLtSCKobem1GUIOqwWg2VAVeSGsGaMQFLyEDxTMYs7fS8cijOhGOAlYYpWFh1Hq/racJ69rW6Rm7crtBj+eDDY4AW5peAjVAHKGl9ZBFppPeJ2lJaFiimIooCh1DNxDxPob04pPfhENA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v5MGr1TF; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG7VvnIXnLE2gZhJYfceNpPB/PAbZkds1Y3aBbFXyGBWV3rs8rrotcbAjOVZqGDzjz/PpWLFJhJz/5zl8yjHiuVrq8yMhdXDEwTEJZFtausy/upbD6QLfmM6jLR9A/IOnB8+BcP4+YqkJSgQ8eAyf+9Lzf4gayLjjmabLvNrqAHCtTPdOOYR2xXUUM8Xi6xuaa8vugD/cjGWtcZ4Kz8QZn2LIs5xV286HHqKyPM4tA15YE3gvaGmf3colosfHl+HriG8hkN0RoXiOGnOKm+jLy8dODJBVC2v+0qZXVLeku9apbe0NMjnquFtkIWuBnhLB3WR2jR1ilQWmyCzkz7inQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JjN48UjGIOz4zPwQx/47zapDuKMSrcSLyLKWmhaYWU=;
 b=j/YBweHhdGZkQL4qPGAsO7AUTpK8BzvmvEudpKJViqDLTqg+2M4Q9WOjinLqFqGNDMqGl9tU0qHxuHhj9V9+YvQh4Oh5o4yVKzrOTP69fl6IH3DlGAUYq3SneK1Ri5CA9TIe4tNQea+16xYnepXAUcKM3IFGVUFtjJ3yJCS51RkS10hFXujN82gnwDyogZEiRVSSG+H61bRTCYP+50WaLsEIg/W7CpAEpJHXUSU1hYgT1oE9BW15uRT0lzu+gVbILYQ0mUoQimnQJPLP7TVxKpJ5d4o+5glhkZ+FnUgxYO/oICBqeE9VRG2p9oI2+XKWXh2BwMqU/g937ywex4P9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JjN48UjGIOz4zPwQx/47zapDuKMSrcSLyLKWmhaYWU=;
 b=v5MGr1TFwVZ4gCbwoo/M0N8jVQ3PWxl/R6at/CgvWJ8p/9y2U8GpvA8BRqziBBUxkufkI+mqz5CceBVHcjRI+EVnwZx2FJUirRQDHZuHhwoQKvGV0I9MxkNDGzRQFrGDFFc0Qpj4Dij57Q4RrUZd+iPAErQy+TMH/znIvdhm69w=
Received: from CH5P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::15)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:02:43 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::58) by CH5P221CA0007.outlook.office365.com
 (2603:10b6:610:1f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 14:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:02:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:02:34 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v3 4/5] ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
Date: Fri, 19 Apr 2024 16:02:02 +0200
Message-ID: <20240419140203.1996635-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc155c0-c834-42f7-395f-08dc607961dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vAip3yaWjd+VU0sZsnf6Ib1OSbuUU7KvsHeHU8cxsAQrG50sDqVXYQyQeNvtLmEyJu7UdStlh3pvGtE4d+GuR5OP+pYS0Y1pRct/Ys4ld8kbpcddyMJg4KphXYEFoW06bIWn4LfYfKaVi5GA8pjmp+bDnsP7un7/tFJjZXtBdJ53cRjwYZKLZ5XVbO2IH++ft4FjDJxBdpt1hw7lb1cfaH4yMeM8f7v8BrrmPMOTUG2uWFacAexYfV7PCpu3s9pezup2h4BchjzyzlWE/1eHkoOcYkkeDdvgcWVm34cyEkavMpgnQ2WLgpN8VHmcGKVnii/z9ArG/2MYNjE2ZZYX18SQs+JRalGnaBEKAeAsgVvjQoDG6bYS93YhNrBAvOliSacnhTerRUToF0n3Dh2VrQWoa10VhOSeTApQvlgdBg7UDWSrUZSu6QDEkHDDeDWLVLb/gzoiedaF6vCIqweTnm4VgwrdiyAfN/K5NIsOTeec/J8A5UNjNxG1cCNpPe0/jVuVt0y1LMl3pYkoXHKCTIJ7lX2EI0RtKTaxxOOP4K2LsPH6M3QGw9O9Y6x+oZgq/4sZ38UUGxTgNpTgEvwjHsyNUySMhUgUytJq474N2OaRBiZqKn+bzSy46JaAUQ7L/JAB4S2eXZ+Fsb4Od1yeaQ4ISATrcY4CwrxvEzwxLn0JCMd/XMLgWhdZBQGvzVUnld3v8c4GUjBa5LQ3oTrPyXup3XHXRgQV6kLMn+nlLgFnGhw0iKedSlbwwXHrwG5A
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:42.7715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc155c0-c834-42f7-395f-08dc607961dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

After removing architectural code the helper function
acpi_numa_slit_init() is no longer needed. Squash it into
acpi_parse_slit(). No functional changes intended.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index bd0e2d342ba2..37a0f4b3d24a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -213,10 +213,16 @@ int __init srat_disabled(void)
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
 
@@ -233,6 +239,8 @@ static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 				slit->entry[slit->locality_count * i + j]);
 		}
 	}
+
+	return 0;
 }
 
 static int __init
@@ -452,19 +460,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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


