Return-Path: <linux-kernel+bounces-106675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D2987F1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EF71F22160
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710765A798;
	Mon, 18 Mar 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dWHMcFaS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42C5A4ED;
	Mon, 18 Mar 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796191; cv=fail; b=eUbnCz5szBwXI7avaQ4XE7zr2r+jxRpyWk+GUX1U1USooBmIbeaqx2Xr7tcFF2fUOR6dayEEuDoc9XEOOx+tPzdOAXJ4XBLAMD1ZIeDEbXDoh31PdFvVE1sz0vWGS8Ca126UNxSOgdwyDLQv5nyD2diRr3nL7s+2Wv6FBxyPnS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796191; c=relaxed/simple;
	bh=l2m1bnbrTTCkx/CENgd0NhaNMcXWzJYKNa6R76senbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/tvwZW1/tV58gzXAKeqXoAAJ8o1Ac1gg4mQF9pla9F4gzjQLh7YrXRVk0LrB5XPQXARy3OYjNEWY79yELj5BN9SzDrek7WWCh9f1LmGDt4omoAWklaIO7CzRQ+E/p4ngiAZsHL8N1ZrelVOL3VZcyzsYN4CB4yypnJbzRh6W/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dWHMcFaS; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzuWk5iIfQS/ek/L2nCimDNYGnvOqDgr7+pWlbJNn+1HLox0JvljrE21KhcvB/LjSOOCgGQmazagVP/GtvuDwdgQueY/3gpDrZdwpVRd9nh5Ci5nyJDl1t+2jqm71pX2YWBVm4kDbkl2etAIZKP5gjSPz/9A2FVEr2lOd7degqowKfd0EpmolHNHmApUVyr4pp3xFJxZPwsPbVi7L62tNeyubRJS7K3KN4TBCUK10rkVwaX+D2x354D7Z0H3HlgdjdGwiKlX3eilaX3G7hSEtbsUvgyUuHJ6XgXGmWFkhiknXAA2KWdUofp7ifixlikSme2scu2FkgogSoD+gE/2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EBbmY+EBezwVQPkDMJqdiHHAQP3kBoX9VkXI55EaPg=;
 b=BrtmotaCWBbt4FfZ4lGZXQFTRCyOnyL8UcSLbf+9DqiVKd1/Y0e5SubXtSNqvKVKZzYjL+YHGo0HLpnhIg5TmINuS9ypqxd/kmfeK1e1yFVGbz9d+12eP4CmE7zhNX/PrWwjNDkeaffuoIAK8s5YEjsl0Wb1PWWbSD2OV6UmaTAqlEh6/thF/gS4+WaGAEviLarlpvoMC9otXSmiecWlGwBRUM76/TymoScuA8Lnb2G8rOWKRSCJO8DHXpUI52NI0kKZjf1J4vNVHuQ3hxqIqiopLGqo8Jw3tGCqUgkSamyukjLlURYBchpf1Wcayu0aD9P1UKE1CNhduqtWVYwubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EBbmY+EBezwVQPkDMJqdiHHAQP3kBoX9VkXI55EaPg=;
 b=dWHMcFaSRo7tdaGmv+5pTkgMRpQfi/Uj/pazTCiWgaBeuok2JqH6ysQcU6uA4hlxua3FEi9whuSOOgpRYYe1xhQhg336hKkoNmtrpJP4QXJq1lZ4eccJRzrkcb+FwRXIvoR1mqh2Jahx6hbNJFL8ggXulrdXoaCT2Xnnw461f20=
Received: from CY5PR15CA0215.namprd15.prod.outlook.com (2603:10b6:930:88::8)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 21:09:46 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::39) by CY5PR15CA0215.outlook.office365.com
 (2603:10b6:930:88::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 21:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 21:09:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 16:09:34 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH 2/3] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Date: Mon, 18 Mar 2024 22:09:02 +0100
Message-ID: <20240318210904.2188120-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318210904.2188120-1-rrichter@amd.com>
References: <20240318210904.2188120-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: daecfb19-a1e5-44dd-72b3-08dc478fbd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	leuYkoynjpe804QrJ0Ux1qzWF456Naaowv7VRS8gHRiBxYzXmm1K3Q9P9xucZ6Vh0GMkQNPCnU6NnZyIUdeLyNteafND9OP9/EYPXKxRM/u8WV2UMsBKB1Fe1bFC7gxfRgFj77Q06/Dff1hptlcejYe0PbmRt4QhnBXq+IoMn2veGq0zNlBJ335JuKnTy7b/wgqDkQiQTp8QcavQ/TyYBQDmBYn90R7hqFqcRb6hUMDkNk50kV/6pNTkyCeKzJbDAGovfi1wriG7v3c57wFG8YMEuX1A3dQpAouz92+aIQKQ1t+XY5ht7Cej0Pt2bXzR+Uo6hO6QroJhM5WaNG8n68Ux0uT1nOPYA20VTVUpfdjRhg21Hp55DoBcA2wN0vLkxajBmpwnIwz7FcMAZJnQELrTkpyZ56SafL4knqk0mVjDRGR0NZvGYP6OmJzllgiYicB2qi02qxE/LfG9jjSe6aJn56gU73sa7bHgH40aJY/Kt6njZXkZ3wRbDEN64YTt+Kw05/DgTRXUDfqUrpyHUa7ucYwuyGkS6decDdNb0vvTdh3Y6PI3zmeH6ks6KMLEojZWmIcB5EOTNpQTnWvTN/EIGxGMKEAfW3ZoPuoCg35GHuYqV9vclvDH7ho9Gma9OhNy5yrtuMhF64P0eLnOwRAYa3eBUYyu5PtlDeviVOUk7quEjyIbQZPMHogvcoRcc55PzIcC8emivyx5V91/9Yw+AnWinMDcC7b8/EKtRZlL5i5+N9LZSJjic6+cWzVs
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:09:46.4133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daecfb19-a1e5-44dd-72b3-08dc478fbd92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

The CEDT contains similar entries as the SRAT. For diagnostic reasons
print the CEDT same style as the SRAT.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e45e64993c50..50ae8557e8d1 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -300,6 +300,114 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 	return -EINVAL;
 }
 
+static int __init
+__acpi_table_print_cedt_entry(union acpi_subtable_headers *__header,
+			      void *arg, const unsigned long table_end)
+{
+	struct acpi_cedt_header *header = (struct acpi_cedt_header *)__header;
+
+	switch (header->type) {
+	case ACPI_CEDT_TYPE_CHBS:
+		{
+			struct acpi_cedt_chbs *p =
+				(struct acpi_cedt_chbs *)header;
+
+			if (header->length < sizeof(struct acpi_cedt_chbs)) {
+				pr_warn("CEDT: unsupported CHBS entry: size %d\n",
+					 header->length);
+				break;
+			}
+
+			pr_info("CEDT: CHBS (0x%llx length 0x%llx uid %lu) %s (%d)\n",
+				 (unsigned long long)p->base,
+				 (unsigned long long)p->length,
+				 (unsigned long)p->uid,
+				 (p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) ?
+				 "cxl11" :
+				 (p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20) ?
+				 "cxl20" :
+				 "unsupported version",
+				 p->cxl_version);
+		}
+		break;
+	case ACPI_CEDT_TYPE_CFMWS:
+		{
+			struct acpi_cedt_cfmws *p =
+				(struct acpi_cedt_cfmws *)header;
+			int eiw_to_ways[] = {1, 2, 4, 8, 16, 3, 6, 12};
+			int targets = -1;
+
+			if (header->length < sizeof(struct acpi_cedt_cfmws)) {
+				pr_warn("CEDT: unsupported CFMWS entry: size %d\n",
+					header->length);
+				break;
+			}
+
+			if (p->interleave_ways < ARRAY_SIZE(eiw_to_ways))
+				targets = eiw_to_ways[p->interleave_ways];
+			if (header->length < struct_size(
+					p, interleave_targets, targets))
+				targets = -1;
+
+			pr_info("CEDT: CFMWS (0x%llx length 0x%llx) with %d target%s",
+				(unsigned long long)p->base_hpa,
+				(unsigned long long)p->window_size,
+				targets, targets > 1 ? "s" : "");
+			for (int i = 0; i < targets; i++)
+				pr_cont("%s%lu", i ? ", " : " (",
+					(unsigned long)p->interleave_targets[i]);
+			pr_cont("%s%s%s%s%s%s\n",
+				targets > 0 ? ")" : "",
+				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ?
+				" type2" : "",
+				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ?
+				" type3" : "",
+				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ?
+				" volatile" : "",
+				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ?
+				" pmem" : "",
+				(p->restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ?
+				" fixed" : "");
+		}
+		break;
+	case ACPI_CEDT_TYPE_CXIMS:
+		{
+			struct acpi_cedt_cxims *p =
+				(struct acpi_cedt_cxims *)header;
+
+			if (header->length < sizeof(struct acpi_cedt_cxims)) {
+				pr_warn("CEDT: unsupported CXIMS entry: size %d\n",
+					header->length);
+				break;
+			}
+
+			pr_info("CEDT: CXIMS (hbig %u nr_xormaps %u)\n",
+				 (unsigned int)p->hbig,
+				 (unsigned int)p->nr_xormaps);
+		}
+		break;
+	default:
+		pr_warn("CEDT: Found unsupported entry (type = 0x%x)\n",
+			header->type);
+		break;
+	}
+
+	return 0;
+}
+
+static void __init acpi_table_print_cedt_entry(enum acpi_cedt_type id)
+{
+	acpi_table_parse_cedt(id, __acpi_table_print_cedt_entry, NULL);
+}
+
+static void __init acpi_table_print_cedt(void)
+{
+	/* Print only implemented CEDT types */
+	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CHBS);
+	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CFMWS);
+	acpi_table_print_cedt_entry(ACPI_CEDT_TYPE_CXIMS);
+}
+
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -341,6 +449,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	return 0;
 }
 #else
+static inline void acpi_table_print_cedt(void) {}
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -526,6 +635,9 @@ int __init acpi_numa_init(void)
 	/* SLIT: System Locality Information Table */
 	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
 
+	/* CEDT: CXL Early Discovery Table */
+	acpi_table_print_cedt();
+
 	/*
 	 * CXL Fixed Memory Window Structures (CFMWS) must be parsed
 	 * after the SRAT. Create NUMA Nodes for CXL memory ranges that
-- 
2.39.2


