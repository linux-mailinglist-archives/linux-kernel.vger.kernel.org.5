Return-Path: <linux-kernel+bounces-162288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9638B5918
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DAE28CCE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44C7BB15;
	Mon, 29 Apr 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YMV+j2UB"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5077F32;
	Mon, 29 Apr 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395048; cv=fail; b=qyQqIMnkMv6kI0ZXzWvTbp13Oy5Ex2BHA1y1GhOMuOVVYOHnp3mq1VZgXQpq2/aWaBNFHsjFUMhIlgsiExhN6JpnhVv/Hpieyc9u7x3rCyKT1StJ7jx+0jHFjyFE3Su1VugsDQE2+buGU6Blu/q+8BUVsaKFAhS2O9YGugM3Qsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395048; c=relaxed/simple;
	bh=xu0ScFGHprQXGjeUjrlrMdsxsUwApZ59SWPq1CbOlj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIZHGIDhr2/xTg+sEKjSOIpRPUr6ccQNXyXLII+Bgx+wBqyXhsluyQ4rwCG8btfIr/Wgnf93oNWbZ62fd74R64BVJqdfBdA/BWZNc7ORNq6lX/my+NyZ0IhlVhWW/KX6AY4dbFNMJl4UX4bE2MMELB5yaSq4k7njetCx2v/iTGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YMV+j2UB; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdaLFMI4M0wpFtgx5GMtv8M1yx+It5C2s2tfG+RyRhYtzQCC8vQgGwsdpkmQUQ5fwWdPXFysDXB+tcg8XMEQuXaKixqpKyiRtJJdvqjTUGP+vhxruMOHlK+mdGSttlSj6N1oKDRe9BgGDMB2J8Gw6zxPLm3mpu5Pamkx+sxENPSmYFAmgzcTPZwM2gBoeyOg/mZbC0xNnntCt+TVN2sKCspXkQNFN6GsOKD4saPEOC4O/Dyf4iQ1/LPwKkfB6K1sZAPOfCBPFTADsBfV9AfOG25NN/elrxpxILZM4VJkcZlhxT2CnsJpAm3+uFRsBHhsregnTV8j01nG4lHnXRPO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auFNcIrPvH7HK9lxyY6YgTh7dndOSGd2/26TlLLxI9s=;
 b=HNoqhNIp4cBLrxLJ8yqcJTM0yGUUxJaJOVzzRf2Ml/fRBXCeECdDv1r7LxpyQieJt/jVmpCsbKBUOk76I1HEiItlqsLavGjGTYi+IV2toSDgoSVjdLIkdKyfAXr8ivROiwp8+pcQoZxBZWy0+ZX7kESdPQlxwGb+6qqMEPBmx0tw8b+T9KsYpRJfkkkUOTkTKi5vrLrZ2ySY3qzCiFDfVt96rUF7PGAd6AdN+2YCRPZvleTFYa8sxkYMGV6zWaMTKCSJqX7pKkOk/8QhUf6d6rsUxlZKf79H7AsqWUBnJ28FMko254shP6Ghty70eRiBlFX9hrzRmabRNZ3/6S9iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auFNcIrPvH7HK9lxyY6YgTh7dndOSGd2/26TlLLxI9s=;
 b=YMV+j2UBXNoKZ7WajVx4KHhl+Hjw0W/SH6bXsxV62MTa9Lw3cFJptvCeQ2Uk+T0JlXKrUXxnitkTm3w06XEyo2pr20GC5iZ1kSJjed2U5KkTrcRZDnwFk2E86TZxf1wRrDWzsex3N4kImUuEejx5991ixrFTFtgOS426mcIzkxs=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:50:44 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::4b) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:42 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v5 7/7] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Date: Mon, 29 Apr 2024 14:49:55 +0200
Message-ID: <20240429124955.2294014-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 541ea7a0-c5ca-414a-b352-08dc684afbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+ieKL60/rDgFXHpeghkJTXxZz8eGj7jvk6AsY9Nh9+FSpbW7GEN+h7Slgj8?=
 =?us-ascii?Q?Ul1VgaDmsO6jLg3LAIVlGJ11C+YwGqNaaIMdhqgd/urKt6p2H3PlY/vlUXh4?=
 =?us-ascii?Q?aEGejH+OyOHMIoOMXWxZKs0uRFIwiiRWwsauBcNoyP9qpk6ym/kE7UfQGyyy?=
 =?us-ascii?Q?TQyiH3orWZlOcPsocM+HKoyjQP8fSFpxdD1WCW7MbVmqXwBOi/A3lXDP730q?=
 =?us-ascii?Q?IK+nzjXL0KFuBUktuXYe+v074N5F/vCbckqlJn5DgGE5G2n7Egx1vVNMP7za?=
 =?us-ascii?Q?295KusKAra2lqIqVYkyRrZ6ovSBghqdQIThTxVPckjSEk5qN9GfJS+c5Nsx5?=
 =?us-ascii?Q?vouEkcU6yqASqTh2whwGjNkEaQbhSawAmZg18WiY4CRPD7X5aKfdhF0UQd6w?=
 =?us-ascii?Q?tW8OQwNZ+2I3ihcRPSfD7yhx/UHwN7eabX5LwGxC63uawSMUykiR/0UtBAwf?=
 =?us-ascii?Q?9ZHgURBXJtQ3Jnv0a3PbQR9qj+ZGtC/qO4ifwa1hwoJP0W6BUk+98l83C4rF?=
 =?us-ascii?Q?6R9G2SKT6XcrXqui3mMu35ANfOF/1NIwy48AYuIM/RvRFUntAk+QSmqkHzCK?=
 =?us-ascii?Q?8mlJZq8ZDf77M2KnaTVDEzebaYCOcKQynbyoIf/pidPrmkxmqih9JszCxm7o?=
 =?us-ascii?Q?tB3gXl8HJfwaj1FixTvEq6uDzHBV2XAGi1vuGIjhNE8ByeX8/KzPGXs6Xorl?=
 =?us-ascii?Q?wnrxz7TWQP+rrMbiXMruompR7sPXfiF7X3lCAjghbZllli4hOWE/m7S+4Tdi?=
 =?us-ascii?Q?wW2TaA5CCZ3yFcQdhX/TO6rEqdxr1fjB9HmMcZ86YW54/i+Ztm+qshUVeNwg?=
 =?us-ascii?Q?hc4IJsGzP56NdBqvoYluZgJx98dN62k4QA312BjnGEEdYcQeUtcB2ka/qq7c?=
 =?us-ascii?Q?S1UsEZXQB33Sq8FrlC6T+Bj4dXMWse/RSY+JAgq+pwvs8c7ENgRNMY6Zr016?=
 =?us-ascii?Q?nex0ZFLMSccy9RAS5yXWtd0GfpjQ8+6UYqkSH5O78jLsh6K1W0wcwWtXx04x?=
 =?us-ascii?Q?yxAiVXfawiePk8ZRaIpwPl30xwOYcPSJKAJUCGn3b2z4AiYyrUUx22Ea1CgF?=
 =?us-ascii?Q?cMWKkAFIrOkDtZ6zxMkFU6nZIMoiqzwMJmUBvkBHwqCAxblF5eVj6mmy96dW?=
 =?us-ascii?Q?1qS/P7gjaEWZv9caYUq/bdiEDQ0My/eMCpoAuDScKozDNa6BAFGHRGTfAaIc?=
 =?us-ascii?Q?dxEv4+PTLY1dD1oFmCmYplVG3IfbIpjMkw4GyLouGIr+VU/5nscOxe9RvM/1?=
 =?us-ascii?Q?UHkq1eZJvf1PmuvlcqWjZQc9BgzF1UvcIRtenUZAofLWYog5m0WFNmx/ytqW?=
 =?us-ascii?Q?Dlt3F0Cv5i7dTHInkDorZwnN6iQj/58g+q9V8rx0/o1EI9UiVsblpzQnfF6k?=
 =?us-ascii?Q?Ba86iPA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:44.3940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 541ea7a0-c5ca-414a-b352-08dc684afbfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

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


