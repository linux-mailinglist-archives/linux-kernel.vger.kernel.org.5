Return-Path: <linux-kernel+bounces-163683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72508B6E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB8F2832A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215E1BED94;
	Tue, 30 Apr 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uPvZxUmK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDE1BED72;
	Tue, 30 Apr 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468964; cv=fail; b=gXDMSOZk5naLum0eTY2Jxc38mF+HEsD8iVzhhyc+Ur3W52LU4tApAJ1pNzByTph/MqOQYlyVfPF14izEl9q83BsV8hr5P0EXedaBdgGFdFNhmFMENsofZ2vxYOd2/KVCBeSF8QM+0IyShxQ/3wh83lgoJ2EvZzCXpUwLm+LvDLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468964; c=relaxed/simple;
	bh=Ue8WH4C9GLmmniw/cZeViaqoValVaj+Q6uEWMvcoUPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7vZyjSkG5K5G6BKOHLQiRBjojgMMREsNBxRfRYe10kRIzHDjtnMoYzPJVv8VJFtnYY7Qc1XeudDSGYOycfUCwKs41D7NaWif02DIzOzc1BmFiaCTKhtvsRk8eL75GZjVmfOzx4+gtrUvI1EfvRShETeiTfWdEEpRCopK6HoFEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uPvZxUmK; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STPU+Ff1rYUlogWZRlZBi+JL0YLk1pZPz/rfgls+zpNkmhN0EDA6XmkXil+e7PM27EcUU4w59B5vsZDjc51hTBieKB1qJflOxiFeD7Jotj9F+2973cl7OFUUyLLvhcv8NNt4cz61D+ZF1I6kerITy/D2TMaJMxNJ8p9j9tBZv3maSY0Y+trE9P9aFd+xvVAQKh7k+cOzCAyPSzB4qlemJnvInxdRhfRpTCi632CJLsjqGf6J8KToWYdkh9dv8lfFwQuvf+3DK7s/4krC4v0e2rHtva3zG9hp4s+zxKKjWORKfswUmkDcLMJRRf7DZ32VH157F7WpvVIep7MNYjPZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYa3HjH45tLeZst82FHqztgFJXWtI4K9z4B5DEry0aI=;
 b=gIL0wyR0pFVedv2f2AAuoP2ED+nJq1HOpI/w7ed0/4SsIpZFd8DwtbZ7S7uU02dcAPBfuuF5ynlv0VXIAJMCXY+lmcCaS5Oa/ByDmskHPKdsoG/rttarMiZWSvxUTSiCy7jGJtCGyXez/GuTwH2YYmlyW/JgAkGtswbgHL5Y1be7VktfWbRBpUa8MB6U9IDR4Joc0qtBdnkzX7JFXY7wlQFCI46EAbMZl+d8IcqmcPfwfVQhimWnRsh/m3Al96g0cr5NgtR1OIr8inYp/G3SHBlCsaofZ/hu/zrPu3P9emGFYzReD/tShRuL54hVm0I5F1N/yvb4l5z7fcMXunFjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYa3HjH45tLeZst82FHqztgFJXWtI4K9z4B5DEry0aI=;
 b=uPvZxUmK2AwOXpovXgvOIlKidoBj8bjvBYpPbnfg8GjqBb8d/dsFlDegw2Iviwxy0OeLRAt07FQru3NYkD6NsOlTuEsNgAE4b3QyNu+49qCbeOL2INOJHqiHdgDq+jfD7cUpjuYkipVq/ENbj0KmMr8+KM3JhlJgSTVGE+jdYRA=
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:22:40 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8c) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:40 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:36 -0500
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
Subject: [PATCH v6 5/7] ACPI/NUMA: Return memblk modification state from numa_fill_memblks()
Date: Tue, 30 Apr 2024 11:21:58 +0200
Message-ID: <20240430092200.2335887-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bc67a7-aac7-4165-e426-08dc68f7154e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vWgWzqOyaLPGjuAyBJ3r5gC6BH4Kc2lz9V5CL0W3c6pXVLgmz6NasH7bfl+U?=
 =?us-ascii?Q?rHoJm3sNeDj/N2wT1caaZ/FNVj5Ldvvw1vKuKyjkUP/T6bltCMsrr8a0RD56?=
 =?us-ascii?Q?BdLZCz0uPwvjrUc0LaeoWgxtivE1UlaE7G3DATqwfXZdBD1rR+HZrYgGVLnV?=
 =?us-ascii?Q?o9GX7nVg0EL/eqiGnZ466jpuopOj2Cz5Mgc1aM6v63DBVLwfPRSu24Zg01EU?=
 =?us-ascii?Q?bQX6inQ3miDA0AqnyN0WjuP1m3qJXLCy5RuqLeBpvbyHCg7Tid7UcXs7pkiR?=
 =?us-ascii?Q?I9RbbeJPH1nKj/5uL9Y2KPMGFCBVYeL/ys7zjjMpWBabwCqdwSthP7hLze5L?=
 =?us-ascii?Q?DDtNMS9gRgIGLUbZEZvCb+eI9/+sUpxR2WY4/rVthLJRFYZ8VzHJl7UUU/jH?=
 =?us-ascii?Q?TA4V0WIvvwqJJxYEgiv62iisz28mUnpoWiepEHk+VLvGA/CKFgsVzSneiEL0?=
 =?us-ascii?Q?Lg116T3S/E7mfR9vpIACYVZjD7hSblQMsC6A+lSG9FoI8oFRAvtea/AnCNfz?=
 =?us-ascii?Q?aBU1OVorc3Tsqp5OK/o9oP+CD7g7d/U1+FmPt8nUljC/CnAMmwzXq02TQlKt?=
 =?us-ascii?Q?VPsfHuISjy3UOlNe8RdIHKqMjF25fW1uPnPJ1yTbhmkGsUb5pzhlxojIah++?=
 =?us-ascii?Q?fEoOHju5IqqdMBt2eXylp1OaboHmLypgXvaX0/BAuTpIONr2AVZeI2zFQg0+?=
 =?us-ascii?Q?FxxxDbzgvc3IKKWLVz0eN19IY2kJEmQeLYK2ehOuIvC7FQeHATkihwCvEpJM?=
 =?us-ascii?Q?8Tx0gByUiQrysfIEUborvrhSFYAGe46t99Z0gFc1pyLeTQ1F1RZJulxhP4ii?=
 =?us-ascii?Q?rHb3+wK4sVBIzKU5VpKeZEV8K3dlT/6L5eCkfdCrZjkzR6ql59lkh6TfGWEX?=
 =?us-ascii?Q?EbY51FEYK1VTlIdtJJUnJKPUAcVkVjXmwAAJJsfzuO5L0sCfA2cucsWHmJ/j?=
 =?us-ascii?Q?MFJmyQ24jOYmfowBw0/eRuHHJlIEV1IO7qECyXTZQZG8CtvMxM7pE2siKljT?=
 =?us-ascii?Q?xEOUJPLMgaEnCtCsFfovuNoqd8Z0cfe8U6lmLiBXZSeXCEBQP+TOXWjL9KE5?=
 =?us-ascii?Q?hWyxhZoVdD0gteIpD+usjHAGZnBjmcpcsQx7i8cXQARTD9oFpych/3dhuEQ8?=
 =?us-ascii?Q?CQTsiBa4sKBPOIVHsEtyrwvAkkRUwIp0i6IUeBNJFs6M2nJ/3PGN5s1Ehe6S?=
 =?us-ascii?Q?RJeni9lIAPZ8TXUjRuh6GML3haiLLxH/XuWS4Ki5v2P8vXGa9gfJ355drxVn?=
 =?us-ascii?Q?v+PXC6KvZavWJFSP/4gNF+WYewEv1B10cU1K6Sg644uoP/oOn2LfksUnhPpo?=
 =?us-ascii?Q?iuc4U499zq6BJIEInOT49S6B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:40.2532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bc67a7-aac7-4165-e426-08dc68f7154e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

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


