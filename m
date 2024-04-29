Return-Path: <linux-kernel+bounces-162286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B788B5914
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1E128CCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7FA757ED;
	Mon, 29 Apr 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PURPOcxF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71A74BE2;
	Mon, 29 Apr 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395043; cv=fail; b=tNOibZa3TA7SrjNkByUxnBbHIm8Oajp9a1+vR7Uj+hETVPxAX5QMkaj8ThTTVA4g1Ds9Jjz6dWxFJYab49EJy8W0Rb8GWbuveA4TH6zWMP4We9WvykPPaaA5IUtWNdoYh74sznvP3fUWKEjiWiQGGV3ptlKwuYEqNOYDzt1S3nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395043; c=relaxed/simple;
	bh=Ue8WH4C9GLmmniw/cZeViaqoValVaj+Q6uEWMvcoUPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWjIz05jGrXpH9QatpQaOpzE4fbdQ5RXrU29N0vSgq0uFbNYxtXtmiJeu4ghakbJBrjIXKg1Ew1GWysytadE/FMbC/4EtcTvY1Lq4mZ2LNO41QWkRFoDyfJ6evDjKCy4phTQ2QQBM15uWokAAGhvSsRNkUckCMKhnxzm7PUQX8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PURPOcxF; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYp17BgePeoD66MmU+6g6uOjsSh7r9I1q0J1JN7s3LET9VR3q3c50VlKPWgB7Pd1GeUiz1N3Txvt2PYsV6PABo+uZQvcEPTEjesBieSgJZ9vbjz65ccNLVL9Q/OQcWsZv0wExeuRKkOHHW4+U0a77wYgSYLTtvWw+IFiFfPjE8Zc4BtgTx2o7i6yDtwdg7NraX7d8TLw253PznZXXxKEAD/TJf6BmFopY/tDtF0n6VB+pyqkFj71NBxwJIOdKJbOCGBceWww0F9ypZv2CxvL1sQDTzp2VrbSVxB4Lz5nniBsYwQOKQFs5I+LtWdQkrVFTNRKHy9CClTOXwE+mNHOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYa3HjH45tLeZst82FHqztgFJXWtI4K9z4B5DEry0aI=;
 b=VtZhANzL2sqmvjtQZxhWZ7vhwUn9zmQN5YWLOwf0S5YyfW+kfohg+MuaUs6iTmfJmPfy7NMBmXboorHXEtC+zhh/CT4bO2eJk8BCqXI07HTy2hyQlO2G6dVwSzsmNLPGTe5VXm1jnZO5KPrA2Joi5FHOKISOg/PSFRZGzcHQr8GhYjMo7bsdp/SXnoVs4jetVRW2dRg3POiIVObg/nITKx2ERrwxd+eJLKzJg2/LldNKGPr29vmEhfi/b/QXSpirNxpRcg/fyRpvFYjvpDC4i2zpDhxgFD9IHCX1BN25PHzAu9dO7zYg2kPB2UW1LVeEi5NgIE+5qdRCPEZUVKHyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYa3HjH45tLeZst82FHqztgFJXWtI4K9z4B5DEry0aI=;
 b=PURPOcxFvDdZESbT3WqUz5CQckJhKp/nMNUjji0yNxphmxDSqN+7Jbj3SdSg7NrHBYvbhsUyH3dRjyI9AFInhtE9aheQEmC3nTDHeWLhrZ9kc8aEJU7XvbAoMlc75uypjJViN/4UTw5lwXZm+TTOcqXQUpHUVaQor5lJN/C0RAs=
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:50:39 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::ab) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:38 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:34 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Robert Richter
	<rrichter@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v5 5/7] ACPI/NUMA: Return memblk modification state from numa_fill_memblks()
Date: Mon, 29 Apr 2024 14:49:53 +0200
Message-ID: <20240429124955.2294014-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f6ad2d-50a6-4b8a-1c03-08dc684af8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|1800799015|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1S/1GS+1mK0jkMuZH9mYJUY+a1ehKwZzbMalSkjZsAUm05yCI/xi+xjQcLz?=
 =?us-ascii?Q?9npY4YEowgSB+nrsxWLwNfdYTdCmUymjVYSvrR2zXEK8NCHZ1UJG0COhPuh5?=
 =?us-ascii?Q?HhYSXT20ZMMO4oCXvczsqiv9wicDvQD0PvMCcjmONt8vyW96P7wj94f8Ci8i?=
 =?us-ascii?Q?vFNlildahmGTCYdwOQkFbKMEGi1S6LNvLblKVQYsqWSw8uqMm8w2GZUeHdR2?=
 =?us-ascii?Q?fny1+OctbP/HmhjUrQfGKSqovt9StHN3d8Tvlyt1XLx9MbyFzv6CK66FW2iq?=
 =?us-ascii?Q?vD9JEMbxDdxrMoBntmk6z1FxebomuZq2IAt/uMub6hGqj3WQWsGWEAZ+Hi5P?=
 =?us-ascii?Q?dFLSjc3cEd7TIFnmm2WeyYhoEkE+kv4oB5coq024gcnQ48tbSQyiwL1nRlC5?=
 =?us-ascii?Q?c8c95z0fx7yQJ91Y2cVMMTY/cv7FopwcgRsIvYbY9EWsFj6anRNGh7hTco7/?=
 =?us-ascii?Q?4Fprj0iKou2HK49mIo/a5rdQEcUoMZI6CTbwMa2p2A2HsHS4RdUQwKRX2B8c?=
 =?us-ascii?Q?areN6ZWwmhuB37r2CxmsZINfOlO6ETL1U9ok9M0Zt018oR6YGEez/sqt8SaR?=
 =?us-ascii?Q?tFAK4tHxsUrJHBIEoXiGO0ZkHQXapSvh0r3h3fzLF9YiqlzfC/oBROGPX/bx?=
 =?us-ascii?Q?hXwRdULiSCiCSYdowJOR+7aomZYBtXvZqnH34iou95KIUuGVfVzG2No7wdVT?=
 =?us-ascii?Q?ifP1+NMt+60STJ06n2jbSPwKTHrOyInYM55GABNYc03RfAAg+YDbxeHbQltB?=
 =?us-ascii?Q?nff9Cn5PiuVHHBhKlGo2Z8HDqwa8+mBzG+ocyZG0SjiLFglXFD0RwiujbV6a?=
 =?us-ascii?Q?j4nvsE4DzpFcZNAZb8YxFwDHkI2F+TweCstL1J2WGCDV5rIrZEy6Tk61kust?=
 =?us-ascii?Q?1aSqLLDV8HjvdImEQJhhs1Rrl4HWNvlE/QQux75HZzvdU3ae1mrZ6/N5CqHA?=
 =?us-ascii?Q?GE3WB0SmS9S2NSVJRejH5gxeqcuOcLr8uTd3WVmiUb8PFTZTUDsh7WrbuD3F?=
 =?us-ascii?Q?yCeLYNC8yYKAq1LfclyndXzA4Vy1w/wiOoXSOk//j8vv/4vltVm1AtgeJzR0?=
 =?us-ascii?Q?GwfVWKtjgVRYFf+sFkKE+y4f50Y5+5dIJkPTdnWAEpBxu1EXqa2SRvvqRHCt?=
 =?us-ascii?Q?vbZZmV+1ulPXo/MV1V2GqtnkxTvzRg/z6raiQN8nomMjKfwu/tegNHJrEbBf?=
 =?us-ascii?Q?E9ru2osZmLGWDIHpvAHeViLTHKnqwIUEynSyFzFXjUaNWAWr8gQBPwHegBNT?=
 =?us-ascii?Q?DjkLrd4W2Rh41wwDyuMjHAaOVwR74ALGBmX2gy8OTKvYVX+PrYXboj5rgMKI?=
 =?us-ascii?Q?6RqF5udeDuD6oe8UQCAy3ja8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:38.9245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f6ad2d-50a6-4b8a-1c03-08dc684af8bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

When registering a memory range a possibly overlapping memory block
will be extended instead of creating a new one. If both ranges exactly
overlap, the blocks remain unchanged and are just reused. The
information if a memblock was extended is useful for diagnostics.

Change return code of numa_fill_memblks() to also report if memblocks
have been modified.

Link: https://lore.kernel.org/all/ZiqnbD0CB9WUL1zu@aschofie-mobl2/T/#u
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 arch/x86/mm/numa.c       | 33 ++++++++++++++++++---------------
 drivers/acpi/numa/srat.c |  5 +++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index ce84ba86e69e..e34e96d57656 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -950,15 +950,16 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
  * address range @start-@end
  *
  * RETURNS:
- * 0		  : Success
- * NUMA_NO_MEMBLK : No memblks exist in address range @start-@end
+ * NUMA_NO_MEMBLK if no memblks exist in address range @start-@end,
+ * zero on success without blocks modified and non-zero positive
+ * values on success with blocks modified.
  */
 
 int __init numa_fill_memblks(u64 start, u64 end)
 {
 	struct numa_memblk **blk = &numa_memblk_list[0];
 	struct numa_meminfo *mi = &numa_meminfo;
-	int count = 0;
+	int count = 0, modified = 0;
 	u64 prev_end;
 
 	/*
@@ -981,25 +982,27 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	/* Sort the list of pointers in memblk->start order */
 	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
 
-	/* Make sure the first/last memblks include start/end */
-	blk[0]->start = min(blk[0]->start, start);
-	blk[count - 1]->end = max(blk[count - 1]->end, end);
-
 	/*
 	 * Fill any gaps by tracking the previous memblks
 	 * end address and backfilling to it if needed.
 	 */
-	prev_end = blk[0]->end;
-	for (int i = 1; i < count; i++) {
+	prev_end = start;
+	for (int i = 0; i < count; i++) {
 		struct numa_memblk *curr = blk[i];
 
-		if (prev_end >= curr->start) {
-			if (prev_end < curr->end)
-				prev_end = curr->end;
-		} else {
+		if (prev_end < curr->start) {
 			curr->start = prev_end;
-			prev_end = curr->end;
+			modified = 1;
 		}
+
+		if (prev_end < curr->end)
+			prev_end = curr->end;
 	}
-	return 0;
+
+	if (blk[count - 1]->end < end) {
+		blk[count - 1]->end = end;
+		modified = 1;
+	}
+
+	return modified;
 }
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e3f26e71637a..76b39a6d3aef 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -326,7 +326,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
 	u64 start, end;
-	int node;
+	int node, modified;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
@@ -338,7 +338,8 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	 * found for any portion of the window to cover the entire
 	 * window.
 	 */
-	if (!numa_fill_memblks(start, end))
+	modified = numa_fill_memblks(start, end);
+	if (modified != NUMA_NO_MEMBLK)
 		return 0;
 
 	/* No SRAT description. Create a new node. */
-- 
2.39.2


