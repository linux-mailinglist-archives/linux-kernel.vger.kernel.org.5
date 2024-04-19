Return-Path: <linux-kernel+bounces-151529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA488AB019
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A8C1F2452D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F8130A7A;
	Fri, 19 Apr 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V3719S/H"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8F12DDA6;
	Fri, 19 Apr 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535366; cv=fail; b=iJVWVnsu9rMh3zz0EdKNB29GU6p5ScnZBbUF3ugD6ItunASY+cr4UwU4Vum/cZx/B3WbMD2MmvT2L3WLOaZAYjV5cIejAbnqNrVB7Zw8Qhghm03GlE4xCqW0WGADYLwJiVQQe+8u1pkCMySmZiO9QDL+IITQ3TfpZEaauQAkyBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535366; c=relaxed/simple;
	bh=vXs01KCJ1B6/8hJ3vlUcmAWaYvPucnQu2SRIM7looBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkgwxaa0ozoVsn9wfqQ35sqqlJF1NEzY6oGtx5e8vGFmcRSjXNvvvTPTpo65Y/TEmhgoO76y2zVtOfRjojp9nZR7kYMmOwFiSU8IS4pgVqui6/NUdY1HyhjXkAmQefourKi84POAdR5lSIoxTnYincxu5JPESyAy79mcdaNr/7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V3719S/H; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXCgyShTNYQOHgx1gjds4/kxB7pb8NFXsTi8AGZ4f4iacIrRKP3xDd8TOBRys+p0HKjirt0hgRZlXvMtCeqziKYv8US9eTdcu3D+m2G7ww2ZwMXiWJESE1+NHcuKJUKejAmqWSRyy72nCNUSNF2yaCsGGAL5b92Z8SnAC83NxuypGWl9HZyXmAobqmkeItWoYzrml/6Da5JBAkp5OQbma3PjaBBNV5Gz3bpqWjQqRUiyENFrp9wJtdlK7/btKcMaU18p8OXJmfC4LvuTibOvHJu6a6S7M7EQpzEPkbxd8f67/tj/336JuZQUXlrdwnTwie85pQXD6EaRSplR+/Apjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeLM815AH6iinFumaNCPACcp54hhM4GYhHy8yiiwRfc=;
 b=FhNiqcFTLP0/mcB0r8Ge9zt42HNbkKoURs0tJ16r2DVxaY3pCxXl504lHPyPVqtFUf4DYIbbGqIQOxjGDmDHqPLJkYwNmcwkfvn6otrh1FN7VHBz8ECcNjgmluOqRh+4JDX2INzTTO+Ft5XtJdG0QHpGjkP67btGFs++UGxKghwoiWwrSNSLhGVS02/Ccunb/fDEGc9PXX6/z0r7130dzqxdS8BSIvmlf2NlgmopNKAIMRgo1r3eKel/cPhmZ+yxSW1Iy4EuRw5dsVy8EV5HOnToSzVuvHUQaNifWxZ4K/jlOOvlzNTytFM5YTzQrhlpE7IlaJxdlaednOGyPShuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeLM815AH6iinFumaNCPACcp54hhM4GYhHy8yiiwRfc=;
 b=V3719S/HeOWOBLLNlLoQ/7JVP2K/7o9GZMKpRF6BI9F1JJM5qSeKBCwVOdDqb3JbVhLYQ0iS+5648nETlqw9DwG66svY+i4gBAIn755CoEfsxJhNeKZI5sl5CTAXl7PMF1PKg+0+9Apq2SL88jkqCQpFgg+BXw57n/LBKzqZBHg=
Received: from CH2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:610:60::14)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 14:02:38 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::4c) by CH2PR14CA0004.outlook.office365.com
 (2603:10b6:610:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Fri, 19 Apr 2024 14:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:02:37 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:02:28 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v3 2/5] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Date: Fri, 19 Apr 2024 16:02:00 +0200
Message-ID: <20240419140203.1996635-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ce1546-a370-4ef8-6697-08dc60795ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vIBjvWtH4VEwUdWWJ6/Cd2eMvAnOfcnFN62Ce96D7A1hcHYF9RXm5OkOAPpeN0zr0EOFm5ZaC42IeLfaZHcuwnZtVPBenMraN7uvL02hLcfhQZrJ2ErvAsJUcJ0deYYS075j+8fZFQQnLc2XpqZBFavdycqos6+sIlmqczuHcu2aA/kYXpgmsOHlKc5K1wWMhq2jIyvMPYuH07k5bokjO0+8Tgas8vup4a+jmH3NMuPgU3Agu1R+RRsgvt+fqCDRAhnJzdwZXMWV2AxGv/lyE+uG9QVw8krh7gMmcANqDUquUJ/1qyN/gKqzgeuJIoSvTh3cLogyOhjWVxPea2wItK2VXcUrklcbBTTvUZzxrlF4fbGnLb9dg21myhTPjPu2az0XBlzNymuYoHIH3NoqYjJcuSqaONT0TgQlI4ABJ/qv60bAtfX1AwgpfTaqpZL7pZooyDHDF0KoMDreErOnU8CsAP3s30pAkE6257lYJLfG72TOAE9S77bR9B8afO7VqVjNXpLEePiliG8EVRxSe8dwoyHG8/4IETR69JHd2KSZxbvVvl109bdqSIaCDbWa2z3oHvQ2IrFfn22asJKX4KuXQBJ0MaRyBAC2Jm9LHPePZBFVNRku/V+y2/2sZHZ0VxM+/pscwhceG4kW2hO9k7UVjOFkTu20lt94R0hsZ67xcf0e7WIzbsS6o1CsBuK7ahSmICkp+mCF7gh3sVRgtRcDIu6Iv/KanU5m0tmEVZz9dcJlInlykrTgBOi48fFh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:37.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce1546-a370-4ef8-6697-08dc60795ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

The CEDT contains similar entries as the SRAT. For diagnostic reasons
print the CEDT same style as the SRAT.

Adding also a pr_info() when successfully adding a CFMWS memory range.

Suggested-by: Alison Schofield <alison.schofield@intel.com> # CEDT node info
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 122 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e45e64993c50..43417b4920da 100644
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
+			pr_debug("CEDT: CHBS (0x%llx length 0x%llx uid %lu) %s (%d)\n",
+				(unsigned long long)p->base,
+				(unsigned long long)p->length,
+				(unsigned long)p->uid,
+				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) ?
+				"cxl11" :
+				(p->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20) ?
+				"cxl20" :
+				"unsupported version",
+				p->cxl_version);
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
+			pr_debug("CEDT: CFMWS (0x%llx length 0x%llx) with %d target%s",
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
+			pr_debug("CEDT: CXIMS (hbig %u nr_xormaps %u)\n",
+				(unsigned int)p->hbig,
+				(unsigned int)p->nr_xormaps);
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
@@ -318,8 +426,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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
@@ -334,13 +445,19 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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
 }
 #else
+static inline void acpi_table_print_cedt(void) {}
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -526,6 +643,9 @@ int __init acpi_numa_init(void)
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


