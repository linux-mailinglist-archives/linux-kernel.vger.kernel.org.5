Return-Path: <linux-kernel+bounces-107494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AF887FD49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E0128404B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDA7FBB2;
	Tue, 19 Mar 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ysP0sa9u"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D0B7FBA5;
	Tue, 19 Mar 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849661; cv=fail; b=bijMMOLuBFVjTngckHSqe14OT1E4/pbC1MBCViVokme9K8DMJx5faXbOaVtgyEGdvuKgAd5aNx/eJy67YaQjU28AZKKLXdbyYpn9EQgYBenb6PQJts8/eq1PrYvLdZWNa7YfAbfLu6nYMQ7Rm4hdmDC8RLhIxIdkQWhlERbx7JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849661; c=relaxed/simple;
	bh=l2m1bnbrTTCkx/CENgd0NhaNMcXWzJYKNa6R76senbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqoLDgZ9VDnI2ViZnpvROQCmwRcA2fieuTpTqsScSmnp60Ce3TnKyI71s3CxRAa4n/FCLz6X35zZVNRtI8P8loToOdTmRzDlEy3D5TzJ2NPmUbfVIeqfkJxvnwdCLA2rqFFwcqQZQ0Fs5wxNuX+GrKBNA/irqpavSIo/taqQeQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ysP0sa9u; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsAgywPsKNS+7+uQFG6jgXrSgOpq9dzBcR9XJMQBzzy5jCmYlhNIBnJ8oq/MsAU9Mzpp1RI3jraSw0QTTQbBk3OXeK8CxQz0jVXe8qVaUPk8PKTwHKhkzXBZyysm2qDBalOaKPpfxV97Inm3ei81A/i49CvtY2L3m6h0urady7cg0zK31VU7vx3nVdmDMoXQAWxkgiEQdvLIkeX62ystPe9LeBRkOTLN1TxqokGpybqoFlkSkWkyCjRVA0g9XsBUekPe3NbLIkDXpwJdUo622vdUyfL1dZqyYuCeVrmKdoZGtqiE2wUFEDBY/++fNLpPcHfF4y1QfcDwxTVkD6itrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EBbmY+EBezwVQPkDMJqdiHHAQP3kBoX9VkXI55EaPg=;
 b=PX2+4+Zpftg7QYq0u1Ymp3vj4+beHHNNRGJkCg2XqZ8LbznWGUCBYTrKnthYU4M4qE/PXAFo2LR+CYVrcQOEKnFmlVsGZUJGo5K/NkeiTWFzyEF6fc5PjhEjZUvhbbpFuJqptnPlLrhp64t6nE22xoVQRzVw+CLFjANgVA70lfdtATZpM4yseW/XDZxE8XsPZJaMYXFTmdUcCL0jIvNoWYNPsnAZZS2gHdDmsihLxdhJ9NaMOG+G2ILbqBZTIe/OZEDh4hQSeOCPWZ+54fMTQ4s3zE559pPfCPF9Wmy6ZhMcLgGTwr3jYceLvVFr4vvhtEUBley+dDyS9ECpNLIkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EBbmY+EBezwVQPkDMJqdiHHAQP3kBoX9VkXI55EaPg=;
 b=ysP0sa9ufmji8KvjnnBlmDY+FesBKF+z2gQhzpErEnvKeWNhFPz4jsZBhoYBa5+OkCEp1EmX4OAh/iB9DxAvASsSX+nwrWokOgWrQFzrylPs04loCPD4ltAqCEroHA/RlEP5m+k2n2PVPoVb7HcBGIeupze4iOCY0RZgUIc7NQ8=
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 12:00:55 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::40) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Tue, 19 Mar 2024 12:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 12:00:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 07:00:52 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v2 2/3] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Date: Tue, 19 Mar 2024 13:00:24 +0100
Message-ID: <20240319120026.2246389-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319120026.2246389-1-rrichter@amd.com>
References: <20240319120026.2246389-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 390452fe-fc47-44f1-0be4-08dc480c3b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8jHezV6S0pOMyf+NMZj72yV3VNLupamX0guELmnLLMJn8dLz5+IfxFzLeka7lmUXNUFQ6qKEGz7BLM0ePDFgM3P05i9dDObIiYgLN/HhOoHkdnNXpb5dSgUMhvythtO0vWl3d+hhrleHhV1ZW0VLArtNCYV3vpc9Jh7srv0ZM2o0n3W0dUF924UhlnpOZ5Dv5UwIvYvu4tLzJUl0lQ7gZzfXKzSjedMClLHB5lrg4Q3y+yE9iqiejZC0KRp02Jtwl2844AlUO9c9R1sXIReX19+XMXSQGqaAjBuNFDJIlX1EVYvqCeOG93VeQwI875UhmccJ9ONDs1w8QOlYyT3YSve1NeqnyL4crkfts5fSXBDwoJ2KrUYhSZdDBh0cqswE3If4iKMm11stYWe/KktdxzR3ZfjZ00zc4ruBdt4iQlxkRGnmeDIVbOlqEq2Jk7frNez+aKSMMin0yMaGDGN0Cbs0EfzbXvUCaXd2GGKMCY77SxhmhqSiDWCdVpDfnoOOtcsDqcBaiZ7jmrYZ0sv5E9R9i/Jiu4huDvaKDkYBzORdt9yveSUtKWaeLVndAEGD/3Lt6/rUYlTehZVeC3lCGydR8NZ8YWVp/WRQohtg7NMvQiCjDO3tbcnJ5BFcwHIisKnJTKf/O/afOpxqyXl5gKhTUaZCF3DlcVyuOMvWoLTq2AOGU3u2zpMSlenZZufn8VBL9yKEk5JybIBVemO3eSFBjVHp2NX6h6cED41nRc6jnoLK2Ol+sTJ/CkP2LGyi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 12:00:54.7381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390452fe-fc47-44f1-0be4-08dc480c3b18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

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


