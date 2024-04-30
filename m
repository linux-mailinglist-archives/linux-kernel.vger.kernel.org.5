Return-Path: <linux-kernel+bounces-163685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E38B6E50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9E11F253DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45B1BF6FB;
	Tue, 30 Apr 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0EsqwiEx"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA51BF6C7;
	Tue, 30 Apr 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468968; cv=fail; b=ZD24WgB8yjD1rfYnLA6xnImKCGZ2U1FhNox7WGp5Zmsi4P+OCUNE/IN6A3Xh9hQ/cG5Uqn41vTEH5L54O9Xw3MHdTFv4+N/Dtzac963C/qsDEZKGjHc5gtH7r6TKCsjqkxIG7WoNRnbxoBASXxW5lw4hSePjOVD6ZaapWDP2rc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468968; c=relaxed/simple;
	bh=vYp95VMxzdzoj/DtrhF05Qgt5E0e6xXnhOR1Zpsoc+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTQ6RH0BpT38ld1u+7zxbHTSZcIExbcPod1O5aB+s2oGhMD5d/DHw0jxI+ZfbwnHTEbA5vJM6Y3CZ4yoF7Ed2dGUnP856X9E9VyPH4h7dLYLTMrLYyorDmcsZglEa8ef0nF3pVi37GzwzfzOrrID9qgWdSF4mf54JByhdY+Q8Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0EsqwiEx; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDdXSnuLwgVgT4Wp6NGuN7jDoVvaByLQ03q0JhOQ7STxMggv/g7PMM0CVhcXtsA3vNRa+sz/Bc5WFNyM6Ts+2hpA3CL6fX6hAObHrB6Yxeo3q1XTfCjySdKjzUM2AAAHxSdeXofmauyCXNJZDPeGiVFjzXZqDhLgVU/PH6Qf7zfzb5asW6MqqzgKXM8IehrXE/VNuOam1OC3WvCqgrfbSpS+fPRjUnCuv/k9ieflRPGig1Yg5tAs4UIHIMLU6jXTw46HQLaW5jXg4BZljkMoye48NYjYctIkf3ul71ZtY8kdIDwBVNiRltFLSlEq3Fwdd+bQrmGP56+UsrSQSwruqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZxv3bUK3ryD91VcL4/Kx8BoqbMa03THTNbV5ekodRY=;
 b=mbmqqiTvm+Af8JTVQidNhkdxt3fNXkxbtlQj/i5y4ggG/43EBvIPVDrgk2/i0ICUdbGrIzTxK9xVEe3VVa8EJLNlmcIHaI666horRdgJN7VjFU8Dq7TYWajKsRgpbdmQ8+4TT0s8PawSqoeJex1cGjY9ZAfRm3iuWDPhS9G02PANsRZOD2ocXhKWKVSyP8tIAxzPjKg0okMr0cCKSASGB0we35pE0evZ8WJOalOe3UrZwqkjlnqRp/vul9XdLTBqEekR0wLuxFVPNX1iPLfKX0rOYFu0El5sqsZ+jBUgK00HQxCs3eTYjoF0qZbJKZpUmRzgxrEiCLKEm28bKlhGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZxv3bUK3ryD91VcL4/Kx8BoqbMa03THTNbV5ekodRY=;
 b=0EsqwiExj+jOQxGW1696Aa/beMAomVerIyRFwJzbshhuD3KNYkQXIYEGnwhdnqsd+fa6w+H7pVPXDgYt6KkB8zsedH+KQH0sP4blMle1+9nJIpBxZetd+1TG2T3FuIQWFZh6FBqURfrAyNHqv3RAtbNupKxY5t50TbyG826BeG4=
Received: from PH8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:2d0::22)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Tue, 30 Apr 2024 09:22:43 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::4b) by PH8PR02CA0009.outlook.office365.com
 (2603:10b6:510:2d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:40 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v6 6/7] ACPI/NUMA: Add log messages for memory ranges found in CEDT
Date: Tue, 30 Apr 2024 11:21:59 +0200
Message-ID: <20240430092200.2335887-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7d2274-a3a8-4284-c926-08dc68f71727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XOpRDEi6bTEaxkkOcO4G1GELz6LTox2v/h8HKDRh2lyT+Znh2+KbJWLOpwVr?=
 =?us-ascii?Q?xHc+s+z1n15o7Z9+rIi8n5JYwN11F4oWvrtAk00OTzyfZDOuw81mKLvm/0Cn?=
 =?us-ascii?Q?k9pjJsxmG/n3ZsFknm1MQAstfi2XUobljrZV8oR9mVejb3JPhijiWT/EOUOF?=
 =?us-ascii?Q?nETsZAsUZIEOzjknwNsfu+WDcWo4ksfarfGOTGCnIAimNy4Qf3mZLCFofMOW?=
 =?us-ascii?Q?83ZGCft89pZR9mwIlQ+XMq6fqKTEw8X3AgCh5JDfmv5GZHZ/jC7oC4tbB/H9?=
 =?us-ascii?Q?Sb19fbjUXfmsq0tKgcQTbDhCEbflE4Wz7tSB7oB4INfconnaFm7Yl0/B+CU8?=
 =?us-ascii?Q?Xzrokcpjcs8ULCoZLpBwPBhIDE9wn9tnu5qR1rNMzrbf/8Z0hCHci3eBSgV6?=
 =?us-ascii?Q?kvco1fJ/xqtiBhnWCcWfnzwbN8okoH34VAQ5UrmmD7KKmDq+HOgUpmXpsyom?=
 =?us-ascii?Q?ZgiHR9wkp131Wc2iWR+jg6YU94xVlXWMJhyiGpknBIJYlkN/GU1JPy+6BaNL?=
 =?us-ascii?Q?7i3McBPc3xQMhsVU9QMTCyhtF0tKlpiC1FS86ZpRNbhLmUEe6xiA3HAUiRNh?=
 =?us-ascii?Q?4+IQ30tN6U9Ajlo8y2C+bRjKvNI0JCDgX8136DHTzuoRJcq/HwTTS3GpvQyD?=
 =?us-ascii?Q?clL53JtFRv+vWZRWxCvdAsbtlojW2uY2tyqh6Ofxvuu2Fzhd/S7oD7UhDVxd?=
 =?us-ascii?Q?FjLM3E8CNzFvypNJsSgJaeVSI0a5AdSwI615Zy2efG7+e1IjgOY9hyWfM9GB?=
 =?us-ascii?Q?tbcc8il1zIPiJgwOG1GBCZa2FfUzC319azl4yaI/2doQbXwsc5INXJjqVzEb?=
 =?us-ascii?Q?bj5wF/UtQhaqvEfx1eyRJlstHb30W9LvhHAo8B5EAYEXEo/8ZYRXIF85ky4r?=
 =?us-ascii?Q?JqLAyaQaX04036A5IAbY3yYuhzaBjfouRe8atjYMk9L7qNKxQECA/Mj5DjSC?=
 =?us-ascii?Q?o/Md61lWOLKkJ0YDbfw/PBoe8hxk5fiuEyEVwaVTkfJ21K/oQtHVqHTDFBhY?=
 =?us-ascii?Q?zB71/4u2lqBzXA/sKEVJvChMOTsYdSxT2lknMk7pzONrIAq3dKzPARp6n1xI?=
 =?us-ascii?Q?79JMNE+OpwmctBfxsF7JwCHvf6Bk0FaIJiBf812sOdu19dP8I3Y8Ol1l/LSF?=
 =?us-ascii?Q?KkQTl1ESICq2XB7+C/1TY/WEOfk4nOlWAo8bvKjvrET8POGvx1wC/1Hd3BS7?=
 =?us-ascii?Q?ZPhyQL/SP+BVx0J5JaxZLR0u8LjGUJZAVOn2UrNJrWVXu8gnKI7a3NrfAhVe?=
 =?us-ascii?Q?rpvt15CFHCZmeBr8NKW0/TxMR7XA/i0NPM3W5cySZTfTqPPrXP2BdpIqfXxE?=
 =?us-ascii?Q?gv5HLvdxlbozlMm1+IbU1LX8vb/M6UWdofEbCpg5zlC65oGJLnXXC8ALipYP?=
 =?us-ascii?Q?rHIeuoPVUKYRG2LBsXK7DaRlF5nA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:43.3368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7d2274-a3a8-4284-c926-08dc68f71727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615

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


