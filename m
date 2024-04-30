Return-Path: <linux-kernel+bounces-163686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581788B6E52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA8283AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C501CB327;
	Tue, 30 Apr 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bavQ0b/r"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA41CB31A;
	Tue, 30 Apr 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468973; cv=fail; b=FQfvLYv8nFY6i35ymtbfhB69/urv9b2f0H3tK5aH/7ATqxuCJhh3zitP7Jn2LycP4qoUCTUwqOSSQdk49iYh3GiwnLoSyiJps0AiqA8u24+8oShNnK6O/gIwdBrq3UDZqIavzd7J090xV9OyEuWZ0p6IKrrca/iD35Rz2dHdPJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468973; c=relaxed/simple;
	bh=xu0ScFGHprQXGjeUjrlrMdsxsUwApZ59SWPq1CbOlj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzWLl1KgeYi/g8l5h4otbS2a5EDJX5XkgT4Oa6qkzXqHHhdwyu1lUO+dx6/Oio50C8uCS+NvA+Z1M2pGhY5PF8ipC7K8gEaQ9TMSwVxRB6ZvkUuk6e8ptb5sE42QSW2/Knkyq8sjFynxoivaRoJigZAX2canukxCqErDgUsik/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bavQ0b/r; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKZUsnuvFjyoKzYTMx7HvEEKt7Kx16TqZY6QVgHCVtpJMcKL8QwOAD92vGYFaE3gelQ6o7FIXq9ZTsB4AYBsHTMdJZCqXr4bp2ricDmefIae0hBb81w60bO4DVQLWBpdKeyWJIWOCZvBGFTbcAH5WCM5Vs1k+J0VwledowQ6RdQJ2PvEYakZ1PQAOY+KQFNY9L90yr1N40DWBzymFdoM0wYo++PaQA6F33sRaybyPwY3pb/FKkm4IGlS1M63Mq82jtfPDBLNzRnNIpN1HLxm4kln+NnPdyw9boEflDU57/7SUIKTRHLhu5tj4Wcns9cB8yAWYBTX2SWuZ9xIJ+/l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auFNcIrPvH7HK9lxyY6YgTh7dndOSGd2/26TlLLxI9s=;
 b=Z2XaFPssE6NJ6nAHFCl/A7O2vCrHGcfBUtaAGBFMKlM2+13TyhjUPZJlWo8pZ63IHSHzOa5hAzq3tcnKwcblZVTOmM+qc1BRmgGmxfmKDtzAiRnwEd09sGT1hcpdKYf/NXfeTcRDN+HHSnc1qtwN7MHbHuktM6xOof3MOX7846N3qG3q+CTdt8X/UgDg+1YiSVyVU0nPpGHpHhYN+n9E4Ief/zmJVkVHbckS85ukrU9lKyLzePz3sRJ7YwshgvaTe8eLFwiy/G85AZCAQvR0tCQauJ2GykVKAbXLHmzcKfsw6rzGBNgckqmKaTfuUAxFTnIOntxvM+csy2MFVkpUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auFNcIrPvH7HK9lxyY6YgTh7dndOSGd2/26TlLLxI9s=;
 b=bavQ0b/rBMV5p0/2f5j9eZYKpWwWV/IWIs8P4TxzIJPaJVO8VoaxjDwmVzUOulxIOB7CTaTkRPyOWHsR/n/Jqx3BGOpBFBWpnjnDr189+pEYZCjzAXH6R+PmPcRpLUVCdNnM24iWWlYaWdme4CTORH8b8hgR+cqh7r1bYRfAr+s=
Received: from PH0PR07CA0111.namprd07.prod.outlook.com (2603:10b6:510:4::26)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:22:49 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::e9) by PH0PR07CA0111.outlook.office365.com
 (2603:10b6:510:4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:43 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v6 7/7] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Date: Tue, 30 Apr 2024 11:22:00 +0200
Message-ID: <20240430092200.2335887-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bddaab9-30b2-475d-ec35-08dc68f71954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8sHDSGBUQMdnRpXV/xtc1i6Ljdro9c+6lpax08Pg2Cakavt3eXl0+tdxYK7?=
 =?us-ascii?Q?y3YV5S5ObJlPDO9YWV6/UOttDJ0kEtGLzPOlPMzmE+ixwgc/GgpkmohKsWMh?=
 =?us-ascii?Q?SbdIWv2i6oxfFibl2GdMMNlTvPkozsEWEXAfcqZeP1L/Yo7o+jeSrgsfINeU?=
 =?us-ascii?Q?s+xknn8iSKF+lnVViKzrCV1CtMzBBYQOIDSNlIWIZVGZ1AcyGj5rIHCL+Pql?=
 =?us-ascii?Q?GHe5ZZyPqHnpn/xYVxt/3TiNUyrAzBzO4zuvRQcX4QGxbxNtXhFTV6jc01gP?=
 =?us-ascii?Q?2g8W9l4IR0AbFStWSc1to322hCtVz0PAMWHrics6kQxzWYUmTdC92PUppUmT?=
 =?us-ascii?Q?faoM//kPoD41vL4uLaE/bknDmByZ84PqP1eCRlmdsrJ5C1AJ8KVNRDbJEskp?=
 =?us-ascii?Q?oynyklmE4iCy+E1zvIEYjwSr2VvoR3ZvHyA7BlG7kS0v7XDHe7yu1h6wtWoH?=
 =?us-ascii?Q?iSW9L3tXzGLXKCRVrC51/7bAkJPSvdClgjFL+Ff6svuTcW6A8rprhpZRHPyI?=
 =?us-ascii?Q?aNiGK88b8SAWrikxHKu8+5O4sfeJkGdRzsiGwnG3jdm8k33V86pop0wFI1vB?=
 =?us-ascii?Q?40VuoUNefvJE6vAx/yLEhT9sL6J1gmXdeXDt8WzyVd30VUVBtaoYrxZKSHtz?=
 =?us-ascii?Q?Zj1NDCpT8zUZVFH1+2ePeSipxkF3ftmBR7SxYTo2i2q24c2xkqKcfXv2L03X?=
 =?us-ascii?Q?GxfAECTBRV8KJW7Urr8Jq+eXOnVAgy4OiKlALGShAkYQJb+vrwmzRAVmzEbw?=
 =?us-ascii?Q?ut7J0BwxdCVr3KyAHP3CFT4KRARDiEclaG9ZrMEnF1mtZ06Gk2blxjliG9tq?=
 =?us-ascii?Q?Fh6NJZw9FCajYkkYuSG8Cnjf6FdXluz21kD0By0SC6YqJioznhnvFVFRW4r5?=
 =?us-ascii?Q?IdIGOtuct4b+AmPKn70IW2QzNOqb83nqhwJ4Und6Lsb3RoG6bO3kQ2G8j3F+?=
 =?us-ascii?Q?2kvLwuiC4X9ylRCkUAYiA0s69eJ3k8VuNYX9TEYwiA71Baw7RuV/JYjq4Hl4?=
 =?us-ascii?Q?98a1Z41cABD9w8uQtsJG7C8/2BODljadjvoT+ZLV4DcjDD1etzJaosITNFqm?=
 =?us-ascii?Q?N2dn0OSidvb9f7G2sW0ZnRztFgIjwvD9CiX6J5qv8d+8pZbHSGdjyabXxw3c?=
 =?us-ascii?Q?Oo7/oFGLFZqSNpBZcaODTGY1o1VR5U39E3JiDCMknscLnV61za1GUc3OkTCz?=
 =?us-ascii?Q?kRG5ikYJDpP4g/CyVCYP9LJm8U7lm002o7hZTWrpRQSmSv9mjYt4qfjfjRFI?=
 =?us-ascii?Q?TuXt3yQacz6ArTTpm8vvqQdDI+74Yn44Elx9452saTztlfYCvpt2LyyQuAK8?=
 =?us-ascii?Q?JHyePkJT4undm8TVCITKvhBJRh7nRWFmDaIiUkjk1rht7BXZJxNMhxQmbPF3?=
 =?us-ascii?Q?3V0fEUE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:47.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bddaab9-30b2-475d-ec35-08dc68f71954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

The CEDT contains similar entries as the SRAT. For diagnostic reasons
print the CEDT same style as the SRAT.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 111 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 34ecf2dc912f..fa21d4d5fccf 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -320,6 +320,114 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
 	return 0;
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
@@ -518,6 +626,9 @@ int __init acpi_numa_init(void)
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


