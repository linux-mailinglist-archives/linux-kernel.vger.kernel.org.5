Return-Path: <linux-kernel+bounces-157249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66BE8B0F38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382DBB29F32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0716D9CF;
	Wed, 24 Apr 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mf5dn3Wa"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DB16D9AC;
	Wed, 24 Apr 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973776; cv=fail; b=SyuKT7LzJgIpSieLi25WjkAIsJdk8ue4WpJy+wcxIqpbRiB7adiRBsp529k49m+8CzoG9w4Wsto8BN0NYSwUFKXuDGBmVW1gwwTRnDYkp+4ovvjTdCD40S9wV7yypUX6bFj8qGQUXb+Kc4tbDeOBZAJs9vhQ3jXq1QKVIrDGtUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973776; c=relaxed/simple;
	bh=pdegn2ybvQNWM/40WYDhRDHQgU7lJThU1MMuwgbXfoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8SnBz37yDOG4HM/1B5PUfoW14j65ErH7RPmq19w1g5RUlOq0u5z4y2pzl7p3qp/Cploy0lZnhKvcI8Msf5Lo7eJnhK0SamdJlBu3noWDN9DcQhEQTER8WeUreMfZEtNQ0sHi5778oPHhoO+ulHicQvQWOgvlhSaIo93JiXOyf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mf5dn3Wa; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjJKH//CDUb51gX0laKThoLPAosROaEIqesy1QH+ssW0Xbo24dK3VSbylKSVCHD4McvXgazJLF5TLvodWFbOlbruHfM4eXRqnjtWUzTnd+zY7FSgUVWjkTVVtG1Wrzg27hZN98dPZH3ku++4PW0CBHBdgPQ3EIiukeSx+L4IWlgGR0Y2OtH2ToO+GJoDm/FocyQsR5JchvwsGAAY3weZXim2rIpju9U2hVUiUdhof8xcFgfNL7BEZjM3R+OxnHN3XHgVqE56op+a9S6LydaFd0yU01rzRTZpRQbaKC2LcQymO/klGXsI7e90PRcZoGUKRH1SnGlCT5HjSQ/hO0MjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOsN7lDWHj1zlGToBzwiEF/usRnRAugpAK+8dJzwf7k=;
 b=OsNhNGqAGXDs+CO1ig+du2Fi7yURymef6PP98nHmwUN+GbwaCsmMEumXlzkvivbsI5cSNGMS6a4JeNhwgToX5bGHtKLmTArLdgHlLv9AL9ELiMbqQVSzjqBBUzVvLV1OJl7WR8dGUpSPVzg4ShHbBO9lZT5ieiO96d5kbZyGQW8DX9abgE09BZHv1zeQbG4y5D443+vLEwgJvRGzyIacXl/8cZSQ3YR6H7ooaUDtIP9AbEf6yH5spviJvZ1bLnENdpGbgr8isSuljEtQA+Ke5NveRS+UhPgK9tc715UPMBVo2blSElgI2zrQAvAM8dY3QhDoCxhXuLBjupnjkUPD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOsN7lDWHj1zlGToBzwiEF/usRnRAugpAK+8dJzwf7k=;
 b=mf5dn3Wa0HMvVTiCqqP/AlFt7myWoES/8PpqR58Rs/OVO+YJ+OLBAbfy9ESJkTGBimTeu/OaL3kFs8cH8d/r0YN+AVdbLZNNK7jKC/HurQ1LoPIc0sav1UgA2qZt0XiOBvxzyEVUewhBI2Bn0OV4pFIwRCxVdEFyHJdY3bLg8WU=
Received: from MN2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:c0::21)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:49:32 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::52) by MN2PR05CA0008.outlook.office365.com
 (2603:10b6:208:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:29 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v4 7/7] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Date: Wed, 24 Apr 2024 17:48:46 +0200
Message-ID: <20240424154846.2152750-8-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424154846.2152750-1-rrichter@amd.com>
References: <20240424154846.2152750-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e432e3f-49e6-42cf-dc3a-08dc64762229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4iKjBHYJ1r9HDqTFDcubm1l1eUcvDQ6h8B3EZKk8jmFKtc+GCLscwUrjqQ2U?=
 =?us-ascii?Q?AyVM9CVxeM+KzAlGEbpvparVFIl+1L7oAvzrE1K1Hewoq1jp3qYXfrpNXax2?=
 =?us-ascii?Q?U1gocVb96P6CknMrfg6+d/nUgHdGunIHygy4iMQUAlvvN2fRr+go84kiQNDF?=
 =?us-ascii?Q?4aIiyTNvFVjHNLnire8fvjn7CaNIoNeKJY1xNA0rI8NiiOZzEIQrK3oaDrIc?=
 =?us-ascii?Q?Ys/KqFLJzssPKNkWjmbkSekvyRxKtnCZ0XOKXm4/qhFCZLSGq7b465CCz/Zy?=
 =?us-ascii?Q?UwbeqPiV+0iCSZj0q7jOh1RD8/oltZ4wy7/gzhbxYybQQm2c4H08i4UIKwyz?=
 =?us-ascii?Q?XmYVCUzWlppiqHFPh5S2x36fOiwP7pmB5yCzuxXR9+wRPM+H8fiZGkSw8srv?=
 =?us-ascii?Q?aKTSooDiDah2RADws6mR/T7ttOc9yOLTd0RgGFJwJ8WWrdzJ5X3zEkV5E8/F?=
 =?us-ascii?Q?Qi3eRxUFbAXXzZI/BEvhKJmpIaHjzz1sa4HM1SBNS/JR+2hH8ijc95DBel3Y?=
 =?us-ascii?Q?PcKbW3rQnbZTLK3VFwPaR3Nz9LIHg0FD6Rlod85ZKWBhm1ehOghIGPZUxaTP?=
 =?us-ascii?Q?f6Eyd3MY/BaB5/4nN5V8cwBjJoO3ZA0EPKrRrC81G8WEoRyqCTVYVqc0b8IN?=
 =?us-ascii?Q?zZ+L/sS0yVi94iNcsUQGffhnptOUF8CGjdpoPYPKPmWT14O5DuMXNOOHS6+1?=
 =?us-ascii?Q?ZLJDDxLosI6p0/Vbr35CNeKk7ekqvqoNSCSCJWYUyULfiY/Hx0MfgtBdSGqp?=
 =?us-ascii?Q?Oh0MunvbAVLxG9iS0gjQFHvdZKaG1yAnod7/2X4hRMIaHyuFzaNczI0q6Shi?=
 =?us-ascii?Q?pRAox6Rmm9iSDK7NVN2UhoRpXWKl8I1oHL7Ao+r123fS0jn8JSGJC1PxjbyO?=
 =?us-ascii?Q?sod2f6O1E72zvZZSHaX3tl8V1JOeo9lvLXqDq4YX7ILRzaO1R1cuSmizY7fl?=
 =?us-ascii?Q?X8Dl/MbEzDdQq0Zt81fzLs2B1fhyn3/SV7u9lX3SZg3NztJkt/UJPYlAJXg+?=
 =?us-ascii?Q?3Ow+/l2AnK8dlqrDrJ6BFiRlollXNvaPwGO2aRxjdBDyTtwARIyQXVC1aqDO?=
 =?us-ascii?Q?4yUsf+PcQluDuxcfT/b+P7HxvIOeKIZL+42Cd7iXWvFakn08at5ebcGmP/EN?=
 =?us-ascii?Q?il1grzaEcnhOkHuv63tnmJhHkPH9VHRDzmIeSViMOviHVebm9Cn82nBXWSpJ?=
 =?us-ascii?Q?sCmox2jabpDTgzo/f/b7XklTclS0zc5UchITVMsFrZioMt4SfetyHTMWegBZ?=
 =?us-ascii?Q?wOWcFTs+LaCzOKMaG0gyZNBPeoZSVOOh2uOydKnaJss0nIn5QXxxX4kJqmoW?=
 =?us-ascii?Q?XtNjHnItJpRuahC3zkbPTTBjlS8Ws3JiHvrzINj5R722dL5Zyxfk2dLS74gZ?=
 =?us-ascii?Q?WIEj2KE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:32.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e432e3f-49e6-42cf-dc3a-08dc64762229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576

The CEDT contains similar entries as the SRAT. For diagnostic reasons
print the CEDT same style as the SRAT.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 111 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index c62e4636e472..a7285d23387f 100644
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
@@ -516,6 +624,9 @@ int __init acpi_numa_init(void)
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


