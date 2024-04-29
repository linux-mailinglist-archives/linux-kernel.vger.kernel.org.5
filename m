Return-Path: <linux-kernel+bounces-162287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C18B5919
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E26BB257AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB757873;
	Mon, 29 Apr 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kPnEuDxq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02B757F6;
	Mon, 29 Apr 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395045; cv=fail; b=JyG2lwekylQ00QzaQD2eJ1A0TSICKmDUMaHFUBc7zKFqKajQE3jfHeBBeI3dMRdetRShLibvsLAjPnpmZtbySFKX+21Adi+bVRUsS/KMD9MsjJOmkvp/OXEmvy3NjrU4VX6s3aZka7l+olNuWTL22dh13Bzkuv36MwHC7sMrHXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395045; c=relaxed/simple;
	bh=vYp95VMxzdzoj/DtrhF05Qgt5E0e6xXnhOR1Zpsoc+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBwVJmTeUCapiCUrmJjScZlKd7AJ3LBom/Lo8/NneZr/EO7HffKq5kb7QzmvBDzxVxlNILPPdGYFl8cKelEDxmZC+4oz9qKYIFhv1ivAjpmpWOLWZZOS7FO0WkiStuHsRKOmNKclCA2lNkVqkOF1myFfV+PzXF8hCZYLqa4P8vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kPnEuDxq; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfUtuB5qTweAa8aQ+byWYXuz1r4hMVi/52skh4qDugq8P4K1Q50Eqy5nPjg93/V6DYXTM98up+tNCltJtEctWCyfQrI+Iku3/HRb9RVZdzHW0rVhQH6SsQsTs1yhUKJuGXEVUJ1VdwMfp4uRx7wqcGgqfM2/4mYeqGRrYUNwx5Q9rjpB7q42smtG8rgAgi0LUW34nO1vGIm7zpe8dSZfIjCJrfQyiHw5cRHTCMf3KaXOEIuyqfKKsEuHIsrsmtxLnalvC5fzGL8OX1a/RX97kXsyw5jW7mdG5rUzppbL0MrhqCnOCj2XtLlJWoIpw1Nxjw3zZK0HL0aFqCN9tE1bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZxv3bUK3ryD91VcL4/Kx8BoqbMa03THTNbV5ekodRY=;
 b=ZoD0y/REKq9/9XgHlqwlctdIiGByRJLIqT0pIzscwQUNeZLN+uiOJ6jBKiWhbZBEx2jt5iKASrXCOwzEJ3DCGUaKo2U7FOnbP0LAmi3AfLqg/99OOBxXAoPXf30d2Ji/LtkYt9LqTXTMcPV+oE4wc2QBu7apYyzv7N2Vf+Imgz1tCK21flO5OfBM0TUFcmtEVjFPEBiDxaaS4W3qCENmfg4oOE11IQcOGcRJlYYBwrmQ0WbHD2ZtHsQXVuLwMhPrJI1JfNFFo/bAXaeKJ1WvkYNDLcvf+DYubsiXsl0i8k6Eb744Wi/KNQIW7qh8h3ewwsR832ROM+0PmfZb+n0ZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZxv3bUK3ryD91VcL4/Kx8BoqbMa03THTNbV5ekodRY=;
 b=kPnEuDxq5aWaoOs+gi/EIlOmpP8ujnZe9WdNwJqBGwI8wdny11UNiErizpERSDSUgsMgnBzVX35RVBTWu4UsAI+tE/s7rjXNhba0IE/8TmVi1CGHNnuW3lTzDJknF8rpNr3iShoQHpnWHE0tqPik4p6gfG7WjYQYlqoDeXOBbkQ=
Received: from MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:50:41 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::e7) by MN2PR14CA0002.outlook.office365.com
 (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:41 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:38 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v5 6/7] ACPI/NUMA: Add log messages for memory ranges found in CEDT
Date: Mon, 29 Apr 2024 14:49:54 +0200
Message-ID: <20240429124955.2294014-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: f8572fe5-308b-4d2e-7058-08dc684afa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZD3PZig3V7Y5jxJdFx/daOSDPOSmDOQ+d0ugdoE7woI6EmLbkN8tcVYHB5t?=
 =?us-ascii?Q?/c36yRA6QHYkks3wV64C7X9qJzcAEMbcKcHtigbofLpoRWOG9kl9qA1EyqZ/?=
 =?us-ascii?Q?YknqalUPrXXKDzug2FhmKa6/2EYsWGP+b9YKWBRqdZ4sNR3ZvcEQXRoMMxjX?=
 =?us-ascii?Q?tK0/QOrK69OIBZw2VjyldbMZiRNNaSrx0JrzPEvZsuEbds5Fe0gYtTxFAaOK?=
 =?us-ascii?Q?3OuG4XW+eEtgBrN3del7gsQL8DYc1KSTIlK/M/LvpQ56AZWDAEGxlwdIkRYc?=
 =?us-ascii?Q?JAZnDQZ589tegpL2rorVOAqHWMoxIv6M7CvpWANzZ6gm5M+in9EQNW3jA4Fm?=
 =?us-ascii?Q?tfWHlo10Sxr3xPL0JgLPCZOP2NBqs3fnGDtqxV/gMYqW6CK7IIdHUtSxKrov?=
 =?us-ascii?Q?aqA4Ffd7rit6oXHzMT4EHcqMjuJpGt37U8Q3VnTvsoaBVju/VG47I5dilsJU?=
 =?us-ascii?Q?NcU7xV/HOcwHwwSBC5BpvjTuCkmMfAcdB9BDqSiWsm3rE7tm8DeZ5NGWJQSo?=
 =?us-ascii?Q?480+Bng78LnMRZiPn2c/4uBo4aIqP7WD/uunh475hqQbD1OKlNms2hM+Vhsc?=
 =?us-ascii?Q?ih9jT8QvIcPRNeYrmuFGHlVbHSfM1pZ/xQbrB9LaRuG+WS0wgRuNqYJMRvGg?=
 =?us-ascii?Q?5tEN7kA+imIhVujfur/vxt9Euu7GnCczwRTHHcLR0jspq3Dv9CH/Uuy44hER?=
 =?us-ascii?Q?qMM4uAjRb0SDXHlQdv/Z1/b3PCYV5ixHW9InRbQQ9pzBKP4VcMc7xv0all51?=
 =?us-ascii?Q?lg09T9gs3EHL/Ki6ODaMgzKxMVzW3cP3tLTEIDnYP0l4e1pyWUtZ8iE/5bbi?=
 =?us-ascii?Q?k+AR0UrogDVEsqUovLOW3w/ozllkexs54kpxDMOf67Ldz0wkf4/n/xcsa3L+?=
 =?us-ascii?Q?eCqafLYhkV9Xx0c4W3l6/7x79cQVaOitcVJYL4wxB5nh7Q5+tbAwbke0Q3dI?=
 =?us-ascii?Q?zwGobP/kx/XRnEr8LPYtoNVHfIH89ktiwIu4uX9IYt1JtRY+uebrigQx7vz/?=
 =?us-ascii?Q?5knRLmfktrzXs7pxre+vl2Nd0p5u4UoWAeaRA1z6YY5Md10P5xIlUeEpr0ki?=
 =?us-ascii?Q?f55lqUloM8yR9EFw/ZcLMM9cOlJJDFd+VMS/wky7pzXJTrGdq6c64q8QR5yw?=
 =?us-ascii?Q?2wruqCeD8SIJrZVmJ5lLyvAHyjP98FWe56ncNtIfDnKY10+ns8clxnYd+P2J?=
 =?us-ascii?Q?UF6Qg7aVx/zOzDqyxgYibwxTGGvNUhZc4tbabjsgWG+wIfDPxMJvnUZHY4lI?=
 =?us-ascii?Q?lwrRIXvOJL216R58iW6mIjoda5gxWgHECbbjRBYIY00XbNbP3la5UvzxHd1D?=
 =?us-ascii?Q?kRcE/ExEL+6fQfwsK47HdLhaFl2JO27bqOaVnAQgvh61McLJCxJDViDj7d75?=
 =?us-ascii?Q?Eo2CaYjKWn/sEGcYTLvdZ+dtP0qZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:41.2532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8572fe5-308b-4d2e-7058-08dc684afa1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

Adding a pr_info() when successfully adding a CFMWS memory range.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 76b39a6d3aef..34ecf2dc912f 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -339,8 +339,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	 * window.
 	 */
 	modified = numa_fill_memblks(start, end);
-	if (modified != NUMA_NO_MEMBLK)
+	if (modified != NUMA_NO_MEMBLK) {
+		if (modified)
+			pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
+				(unsigned long long) start, (unsigned long long) end - 1);
 		return 0;
+	}
 
 	/* No SRAT description. Create a new node. */
 	node = acpi_map_pxm_to_node(*fake_pxm);
@@ -355,8 +359,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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


