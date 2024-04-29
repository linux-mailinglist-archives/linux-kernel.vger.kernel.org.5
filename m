Return-Path: <linux-kernel+bounces-162284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B88B5915
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA495B27AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B757441F;
	Mon, 29 Apr 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uulUhtrm"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE27317F;
	Mon, 29 Apr 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395036; cv=fail; b=PsZRlF+eAjuSMKWcs9kEVeHdvkpdlSv8wj0ZcL1hCQ24GxcN1PAEwbXb/izSx/2xYYVvpFWrsw29lVQbeZ20PAS0e3nIdY56LPbXS6RAeyNs8rEeia+qZhrb1hOSqK+QU5LpnkmBRrnCU+QJMdV3WI5lFHRzor5Ef1zGBqw2+8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395036; c=relaxed/simple;
	bh=3A0QL/Q2ZLGYAxVW0jdhOQ0VW3DumNN9kZB9MQttzwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tuf8YlwoBEmwwJDsHKWEwZ1SqS3AkTw49Y0hPYvOHaHkwOST61oIdUpeEdQON2Rji1Cbe2sovxmhaJvgSnCHFVpvBtjAlEicJgpfhfXnTZAvvtiLGEZl8qvOO8/VyWrd9gdTDgnmE8n//v8C+YgjNsNbIyrgh3qJI2e/yx0D4Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uulUhtrm; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5YFAQkmN73aDAfDr6EmWuR1Kt5ceWYHHSC2w+4D3Oj+77Qe5aG4+HHG9yhqOMB8BZkzgITadXCxdRnCWSeFuWwWDKAufsIrOfYqrAMWpAz/+Nfa2ug3QITU6vvJvnzmLu9uS9AZoxwygMKISKslf7XOSqtnvNW5cJalZ6OeDrRqNgNGw1EEIZM/SkPYzwk/WX/KMsxEvUnVGw0X1mX7YOKkAsV20uRIF41L5gjR/8nUk9nv7FxwaSHchTJistuPRcwR9eA/FZcteAUzdYdixWBtrO4yaf2bXldtDe49d5SS1kWWpYnb62RFUJQcuWqAh58nNTQsk86XxPefe76uRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UISV2JCdeG71+wO8w7lSn249sa+w/Qr4NBQ9V5O2Ko=;
 b=NLFKoAGhsKMsTLrOTmcFTvyHp0qIiACu0LAyFZWTLQyAXmHYBMK9CuQcEeYJvx85HAfgu/apUMQOSNHMWEhz7T1VgDte0UX9wRWjcFvE4Cs5Gi8WbXz+riqWoe0oJ/oPwx8LzPzsVj1a8gYmopqcq4MiRtU0zf5w/0QIlx9y6GcTOpFOA2nqrI8AKnhE9QAIzF9T8RZ4w0yvOyZ9eCwbBHr9zMKo6iQ6EUcDtqvJ2aKNZw940eEjpcqmtleHieYQMJvUjDNqm0Y8NQV/0kTaiuGTAa6wDlre/1n8VRlKJ2RiiUhuP7NAjYFRNQU/flzIcB1lJVJlvsDTfvyFfwxJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UISV2JCdeG71+wO8w7lSn249sa+w/Qr4NBQ9V5O2Ko=;
 b=uulUhtrmUY/9V8IOJJva9s+Z3WYU7Lp508O9RR7TyPBMvW865x48LAcgwKTzruPjxSmhc3w25SmxKFr+HFtoDz8tcNajpXSF2jbEwJq9GA5mWHo0bRp69U/2WROKw/C9RxCmYDXqXM59oFAvf5M3GwU9nIzqHrYevGxZXSxo2Wk=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:50:31 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::9a) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:28 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v5 3/7] ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
Date: Mon, 29 Apr 2024 14:49:51 +0200
Message-ID: <20240429124955.2294014-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429124955.2294014-1-rrichter@amd.com>
References: <20240429124955.2294014-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcdb0a4-c498-4e62-518c-08dc684af3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCtUv+JrWYoZ97/hQgyHKn8A5yRw39ocf/ERROUQN7ki6pOX7U8T6GbVnFex?=
 =?us-ascii?Q?HltdzBxJboxdjfqdx7/8zDEUL6QXYod5MIm0w9AtQpJ1ZI9fXDkoPN6QtmTF?=
 =?us-ascii?Q?hw/DkAqlZcasny+YOevloJs3ELVVgOWf5KVyF6ehLK1s+wZpHmIRPAgiyVi2?=
 =?us-ascii?Q?KX9nAyD1ppQaOjfcQuiJ0eQ4vOk4aLGIPKRfexaYion/TGX8VTq/AsBGZ0De?=
 =?us-ascii?Q?bEQPe+hGr4Zyby0upxU1y92s0j9WBPvwsb4Hqvxp7qQ6poKFubCczVYI48Z3?=
 =?us-ascii?Q?1TGSZcbqxw1FcS+gji5AkMfvndoLihzlJyYLDXsTieXHo0dcMH6oLYDveHG1?=
 =?us-ascii?Q?ZG5DVAyeS4tsNc66yi2axf0C8C0nZB4EsUsK6MiDKIfxuK5FWinemh4TYUMO?=
 =?us-ascii?Q?qklU4BWuU+MZlb1cL7xUqneTvu4Wsk0arvM+YUpoQXXsEGcvcnJnMbBMsvXX?=
 =?us-ascii?Q?3ZVbCkALp4shd8ncRxrcnd7Mp5p1rtFpCtKqWhCPPxPyy3Zq8pL6AGqVFteE?=
 =?us-ascii?Q?QlnoYtTiZwf3G58+rodTvCaSdYPe72l04+f5Ze8BHiYHf38ym/47PW2WLA+F?=
 =?us-ascii?Q?zv8E8v2d5eIwr0hvH2xkzA1cVYB9Ej8yNmRPwf4bZzH7TRPF4KTeVPDu3I25?=
 =?us-ascii?Q?Pwg1s0m1w3O83M8ytbtVkDEizauJ/Tt4dcvP3tIGU6q9acFpkV0ysLVCczVZ?=
 =?us-ascii?Q?dceKVB/WO91/AU/FH/376Rm4RWiUsCq5X5AifI79NP93XlLaGqE24c2G7lTC?=
 =?us-ascii?Q?w6uvoQHA87BpvW3zTEVcSf71WruyH+CqMlJ55MwemptZ1CC+JErPJO2cM6tA?=
 =?us-ascii?Q?2aDIyb6CnMhJW0vqajiGtx10nhfOIWBFb4Ojxn3gMd4J3XaVv5st3btSOZrP?=
 =?us-ascii?Q?LwKk7XlwD1h/x/+HXlgjiIQALejL4Fpok7ThYVScUEo9lxqiVP5bmOmZ03x7?=
 =?us-ascii?Q?d4ROckenNBJzACYkNJtSseI5p7ha8fuqXG9wBKucI+ZZxDm2iwV1uceIVlzn?=
 =?us-ascii?Q?3KriZAXbMxmZy2AxPQfjZ4z7ErRZBqJXRWv3eo+UNx0FeVHYN5liBTU8mrQH?=
 =?us-ascii?Q?dSny2xjoP/lhy2rOBR+rWwAnI599I1OXe8PZVZaKrkKJ2DmckA6oIUfUv9vR?=
 =?us-ascii?Q?lYU2V0jMLS057tFo4op3NOgyxFBzeDK/RrU6EYS0QnsMrz1v1mrdjUpMZY/y?=
 =?us-ascii?Q?xMfDB3a5uhgcwoY8KQ3Xj+DqYSKHxoBBw1tRdwswHw9lWvg8n3g8utRJX0ks?=
 =?us-ascii?Q?km6iZ5JOcTCuFVr4t5vkTSva/CZstTJvC6AeUa33a+eL4tesw11bTmX5DNBY?=
 =?us-ascii?Q?P47DLXt6tHqsUauVmLn0Jly/SNIFkn6GRrflPqyOpnARDtLfrDizywABGbVN?=
 =?us-ascii?Q?+vEShcE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:30.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcdb0a4-c498-4e62-518c-08dc684af3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

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


