Return-Path: <linux-kernel+bounces-64711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1088541CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078A81C26939
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F5C147;
	Wed, 14 Feb 2024 03:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cWmdJHOM"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23612947A;
	Wed, 14 Feb 2024 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707881736; cv=fail; b=cY4orp5Ss805ugtJN73xFjyLVIWy7dyYRzrNwaoRSjVwqK0gIw8KbltujbCLbS9ZmpgcjcShz5kbjdraaoHXIHp/KFsnzHujjLvZBrslPVnMaV1neg5cSKbCGxQ00FXmWkYQ8dzuzA8qVrLZTxz72MJ3YjM0e5mN3iSVnU3M1GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707881736; c=relaxed/simple;
	bh=gimyxNXUvTsQYuT8w/VlUKWh80ra6q6wwDSFemp9sgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfDEkHi4Il8TZ7/CJpcy8l3cMr5tkVtee1L7Kvx/amyBxvDM6ksCeoOK44rVX4FC6F9UziJZVTrWvw2xeoUpG0QiuzGJor8RCHtd6K0xF0FsYCS0DozN4lXiKG/+pymLDpRs6uDDbnhow08g4KYG5Q/IDh+RH9DBFEeLByNVcA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cWmdJHOM; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWH5D+vThPPhyEX6WwAWi/68k9Nn/c6Bc0bJK1HY+tz8YoFH2FVunk7mIOQpyCxVfjTGWGC19Vvr8+JJndA20SakcEMkG1e7hDsFipfSqMcsWxdaWVtLog3066k0BFvVFOd3pX7NHj5E+MSUb6AH94xnDvqFf4QxPHvcmxAtgneO7YjkwLq9domWicDlPOK02M0MfcXFnhpe2HAO9+TtziX0kvaDdVsi+AZP9OJFlxqvsB0fy5RJVbTHIFqNOarda3UGelg5He68wabSJWzVT1aqDGGMRSJz1q6obl3QhKQ6kLFv98yrPjgM4yEqT0uqS0ItiJ6zhPUze1rTQ2/FOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ3zqjLD4IKT+jdIFAQSXzDRgHB24We7Foo4dBWdx9Y=;
 b=YazVH0LXSJeV7K9NPbt4xwcZCO+e4b3oQkokBV5kVmEtxJSjp99P8qsd3mBz9FRhmTur21+tfeMI5NihohVapGmdL3RqAuyVfGYPg8iEy9bWXjYwJKgXUCiMrBe/hVfx+hT9jJlycXqX6E2oU/ZOuGfX55W+RswPLBUb1aAD7craZ9AS7OLPqYhTB8sfKc0V5ibuBwlgbJRYWhO3ytn5s9PArf1zb/aQ6vRHp+5E+oaTjfekhJWj2pzyUNvuZXVGjCLSMU5SJBOZ9+kUsT8x6Rz3y8IMj6+7U4A4b1M76Ku+K9D6Cpi9AdW3b8fxZfP94zUdv2vhrecA/H1xOcjG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ3zqjLD4IKT+jdIFAQSXzDRgHB24We7Foo4dBWdx9Y=;
 b=cWmdJHOMeVntocia9awhKyzz2f41NW5q+BYzhcCVvo8f84lMP7ae6h9zgroA7DuHwOu8kaVqJV3P+eWJ/8yvoISaVnxRR7s9A+e5gMRCHiICw4xwnOqTHW/O1H/FeFePCM3PlfHF8AUGPBye7tIQzAXvofAjlPsoPd3+pUNoehs=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 03:35:31 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::e8) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 03:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 03:35:30 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 21:35:28 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, <sathyapriya.k@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Date: Tue, 13 Feb 2024 21:35:16 -0600
Message-ID: <20240214033516.1344948-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214033516.1344948-1-yazen.ghannam@amd.com>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f22405-6892-469a-9766-08dc2d0dfe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4plJQtQqo0Cby3K/YYtgRnM5TtKifAnjZ4NfXZUf2NTVG+fKaOlY6/pLV7KPFYXYCbWCG1u+8c7YYNI/G6c9My3tZzKK8sw+kb5JI/xiNb75bBc6gCHTR8DORX+fEF0qSXM9zRceDahVvrqR+CS4t3Sdm3sAAZzGBKZCICIK9et9wnCVQqtYIwaqfMqAs9bzVK7CL+Zty19jGAYwrCT021mf08LSKbpmUDk33nwNHbKlyGA3hWmBu1vIUwT4h7T3nN7RNzQgnlNCTsnZzxxcw2c6HheG3ZFeKvDUNW/SJxAj3sum0+xnIf+1Pq/5OBOMghn8P9E9f+sS/JZruyfOq46UCRmoLhUxDFgB/xe5wBe4L/fPvNVmpdfmnMo5gBl/JlqmxNSskHTien8BXzQsyBY79ZcvBeK3me6zvrQahCxP8Mm/CmcaZ58GcTYUaZzvb9XbgrJ82jdC898//KQdwmUIsEHFbur4BREuz5O4za2O+eWQRbszEDqqzzqKxbU5R/zo1IKHmATmIHjHHFWvHIZmHPYYjHOGiJYHAqGSoKSzuaf+Hnin2PzsdApRiDFvXGaijNbTFsjjtn8rVRNLjswjgZ5gPLHg9VosCS6r7Cc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(7696005)(36756003)(41300700001)(478600001)(1076003)(2616005)(83380400001)(26005)(16526019)(426003)(336012)(70586007)(70206006)(5660300002)(4326008)(8936002)(8676002)(110136005)(6666004)(316002)(81166007)(54906003)(86362001)(82740400003)(356005)(66899024)(44832011)(2906002)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 03:35:30.8274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f22405-6892-469a-9766-08dc2d0dfe94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

Memory errors are an expected occurrence on systems with high memory
density. Generally, errors within a small number of unique physical
locations is acceptable, based on manufacturer and/or admin policy.
During run time, memory with errors may be retired so it is no longer
used by the system. This is done in the kernel memory manager, and the
effect will remain until the system is restarted.

If a memory location is consistently faulty, then the same run time
error handling may occur in the next reboot cycle. Running jobs may be
terminated due to previously known bad memory. This could be prevented
if information from the previous boot was not lost.

Some add-in cards with driver-managed memory have on-board persistent
storage. Their driver may save memory error information to the
persistent storage during run time. The information may then be restored
after reset, and known bad memory may be retired before use. A running
log of bad memory locations is kept across multiple resets.

A similar solution is desirable for CPUs. However, this solution should
leverage industry-standard components, as much as possible, rather than
a bespoke platform driver.

Two components are needed: a record format and a persistent storage
interface.

A UEFI CPER "FRU Memory Poison Section" is being proposed, along with a
"Memory Poison Descriptor", to use for this purpose. These new structures
are minimal, saving space on limited non-volatile memory, and extensible.

CPER-aware persistent storage interfaces, like ACPI ERST and EFI Runtime
Variables, can be used. A new interface is not required.

Implement a new module to manage the record formats on persistent
storage. Use the requirements for an AMD MI300-based system to start.
Vendor- and platform-specific details can be abstracted later as needed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 MAINTAINERS            |   7 +
 drivers/ras/Kconfig    |  13 +
 drivers/ras/Makefile   |   1 +
 drivers/ras/amd/fmpm.c | 776 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 797 insertions(+)
 create mode 100644 drivers/ras/amd/fmpm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc5996feba70..8541cc69c43b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18363,6 +18363,13 @@ F:	drivers/ras/
 F:	include/linux/ras.h
 F:	include/ras/ras_event.h
 
+RAS FRU MEMORY POISON MANAGER (FMPM)
+M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+M:	Yazen Ghannam <Yazen.Ghannam@amd.com>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/ras/amd/fmpm.c
+
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index 2e969f59c0ca..782951aa302f 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -34,4 +34,17 @@ if RAS
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
 
+config RAS_FMPM
+	tristate "FRU Memory Poison Manager"
+	default m
+	depends on X86_MCE
+	imply AMD_ATL
+	help
+	  Support saving and restoring memory error information across reboot
+	  cycles using ACPI ERST as persistent storage. Error information is
+	  saved with the UEFI CPER "FRU Memory Poison" section format.
+
+	  Memory may be retired during boot time and run time depending on
+	  platform-specific policies.
+
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 3fac80f58005..11f95d59d397 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
 
+obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
new file mode 100644
index 000000000000..077d9f35cc7d
--- /dev/null
+++ b/drivers/ras/amd/fmpm.c
@@ -0,0 +1,776 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * FRU (Field-Replaceable Unit) Memory Poison Manager
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors:
+ *	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+ *	Muralidhara M K <muralidhara.mk@amd.com>
+ *	Yazen Ghannam <Yazen.Ghannam@amd.com>
+ *
+ * Implementation notes, assumptions, and limitations:
+ *
+ * - FRU Memory Poison Section and Memory Poison Descriptor definitions are not yet
+ *   included in the UEFI specification. So they are defined here. Afterwards, they
+ *   may be moved to linux/cper.h, if appropriate.
+ *
+ * - Platforms based on AMD MI300 systems will be the first to use these structures.
+ *   There are a number of assumptions made here that will need to be generalized
+ *   to support other platforms.
+ *
+ *   AMD MI300-based platform(s) assumptions:
+ *   - Memory errors are reported through x86 MCA.
+ *   - The entire DRAM row containing a memory error should be retired.
+ *   - There will be (1) FRU Memory Poison Section per CPER.
+ *   - The FRU will be the CPU Package (Processor Socket).
+ *   - The default number of Memory Poison Descriptor entries should be (8).
+ *   - The Platform will use ACPI ERST for persistent storage.
+ *   - All FRU records should be saved to persistent storage. Module init will
+ *     fail if any FRU record is not successfully written.
+ *
+ * - Source code will be under 'drivers/ras/amd/' unless and until there is interest
+ *   to use this module for other vendors.
+ *
+ * - Boot time memory retirement may occur later than ideal due to dependencies
+ *   on other libraries and drivers. This leaves a gap where bad memory may be
+ *   accessed during early boot stages.
+ *
+ * - Enough memory should be pre-allocated for each FRU record to be able to hold
+ *   the expected number of descriptor entries. This, mostly empty, record is
+ *   written to storage during init time. Subsequent writes to the same record
+ *   should allow the Platform to update the stored record in-place. Otherwise,
+ *   if the record is extended, then the Platform may need to perform costly memory
+ *   management operations on the storage. For example, the Platform may spend time
+ *   in Firmware copying and invalidating memory on a relatively slow SPI ROM.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cper.h>
+#include <linux/ras.h>
+
+#include <acpi/apei.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/mce.h>
+
+#pragma pack(1)
+
+/* Validation Bits */
+#define FMP_VALID_ARCH_TYPE		BIT_ULL(0)
+#define FMP_VALID_ARCH			BIT_ULL(1)
+#define FMP_VALID_ID_TYPE		BIT_ULL(2)
+#define FMP_VALID_ID			BIT_ULL(3)
+#define FMP_VALID_LIST_ENTRIES		BIT_ULL(4)
+#define FMP_VALID_LIST			BIT_ULL(5)
+
+/* FRU Architecture Types */
+#define FMP_ARCH_TYPE_X86_CPUID_1_EAX	0
+
+/* FRU ID Types */
+#define FMP_ID_TYPE_X86_PPIN		0
+
+/* FRU Memory Poison Section, UEFI vX.Y sec N.X.Z */
+struct cper_sec_fru_mem_poison {
+	u32 checksum;
+	u64 validation_bits;
+	u32 fru_arch_type;
+	u64 fru_arch;
+	u32 fru_id_type;
+	u64 fru_id;
+	u32 nr_entries;
+};
+
+/* FRU Descriptor ID Types */
+#define FPD_HW_ID_TYPE_MCA_IPID		0
+
+/* FRU Descriptor Address Types */
+#define FPD_ADDR_TYPE_MCA_ADDR		0
+
+/* Memory Poison Descriptor, UEFI vX.Y sec N.X.Y */
+struct cper_fru_poison_desc {
+	u64 timestamp;
+	u32 hw_id_type;
+	u64 hw_id;
+	u32 addr_type;
+	u64 addr;
+};
+
+/* Collection of headers and sections for easy pointer use. */
+struct fru_rec {
+	struct cper_record_header	hdr;
+	struct cper_section_descriptor	sec_desc;
+	struct cper_sec_fru_mem_poison	fmp;
+	struct cper_fru_poison_desc	entries[];
+};
+
+/* Reset to default packing */
+#pragma pack()
+
+/*
+ * Pointers to the complete CPER record of each FRU.
+ *
+ * Memory allocation will include padded space for descriptor entries.
+ */
+static struct fru_rec **fru_records;
+
+#define CPER_CREATOR_FMP						\
+	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
+		  0xa0, 0x33, 0x08, 0x75)
+
+#define CPER_SECTION_TYPE_FMP						\
+	GUID_INIT(0x5e4706c1, 0x5356, 0x48c6, 0x93, 0x0b, 0x52, 0xf2,	\
+		  0x12, 0x0a, 0x44, 0x58)
+
+/**
+ * DOC: fru_poison_entries (byte)
+ * Maximum number of descriptor entries possible for each FRU.
+ *
+ * Values between '1' and '255' are valid.
+ * No input or '0' will default to FMPM_DEFAULT_MAX_NR_ENTRIES.
+ */
+static u8 max_nr_entries;
+module_param(max_nr_entries, byte, 0644);
+MODULE_PARM_DESC(max_nr_entries,
+		 "Maximum number of memory poison descriptor entries per FRU");
+
+#define FMPM_DEFAULT_MAX_NR_ENTRIES	8
+
+/* Maximum number of FRUs in the system. */
+static unsigned int max_nr_fru;
+
+/* Total length of record including headers and list of descriptor entries. */
+static size_t max_rec_len;
+
+/*
+ * Protect the local cache and prevent concurrent writes to storage.
+ * This is only needed after init once notifier block registration is done.
+ */
+static DEFINE_MUTEX(fmpm_update_mutex);
+
+#define for_each_fru(i, rec) \
+	for (i = 0; rec = fru_records[i], i < max_nr_fru; i++)
+
+static inline struct cper_sec_fru_mem_poison *get_fmp(struct fru_rec *rec)
+{
+	return &rec->fmp;
+}
+
+static inline struct cper_fru_poison_desc *get_fpd(struct fru_rec *rec, u32 entry)
+{
+	return &rec->entries[entry];
+}
+
+static inline u32 get_fmp_len(struct fru_rec *rec)
+{
+	return rec->sec_desc.section_length - sizeof(struct cper_section_descriptor);
+}
+
+static struct fru_rec *get_fru_record(u64 fru_id)
+{
+	struct fru_rec *rec;
+	unsigned int i;
+
+	for_each_fru(i, rec) {
+		if (get_fmp(rec)->fru_id == fru_id)
+			return rec;
+	}
+
+	pr_debug("Record not found for FRU 0x%016llx", fru_id);
+	return NULL;
+}
+
+/*
+ * Sum up all bytes within the FRU Memory Poison Section including the Memory
+ * Poison Descriptor entries.
+ */
+static u32 do_fmp_checksum(struct cper_sec_fru_mem_poison *fmp, u32 len)
+{
+	u32 checksum = 0;
+	u8 *buf, *end;
+
+	buf = (u8 *)fmp;
+	end = buf + len;
+
+	while (buf < end)
+		checksum += (u8)(*(buf++));
+
+	return checksum;
+}
+
+/* Calculate a new checksum. */
+static u32 get_fmp_checksum(struct fru_rec *rec)
+{
+	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
+	u32 len, checksum;
+
+	len = get_fmp_len(rec);
+
+	/* Get the current total. */
+	checksum = do_fmp_checksum(fmp, len);
+
+	/* Subtract the current checksum from total. */
+	checksum -= fmp->checksum;
+
+	/* Return the compliment value. */
+	return 0 - checksum;
+}
+
+static int update_record_on_storage(struct fru_rec *rec)
+{
+	int ret;
+
+	rec->fmp.checksum = get_fmp_checksum(rec);
+
+	pr_debug("Writing to storage");
+
+	ret = erst_write(&rec->hdr);
+	if (ret)
+		pr_warn("Storage update failed for FRU 0x%016llx", rec->fmp.fru_id);
+
+	return ret;
+}
+
+static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
+{
+	memset(fpd, 0, sizeof(struct cper_fru_poison_desc));
+
+	fpd->timestamp	= m->time;
+	fpd->hw_id_type = FPD_HW_ID_TYPE_MCA_IPID;
+	fpd->hw_id	= m->ipid;
+	fpd->addr_type	= FPD_ADDR_TYPE_MCA_ADDR;
+	fpd->addr	= m->addr;
+}
+
+static bool has_valid_entries(u64 valid_bits)
+{
+	if (!(valid_bits & FMP_VALID_LIST_ENTRIES))
+		return false;
+
+	if (!(valid_bits & FMP_VALID_LIST))
+		return false;
+
+	return true;
+}
+
+static bool same_fpd(struct cper_fru_poison_desc *old, struct cper_fru_poison_desc *new)
+{
+	/*
+	 * Ignore timestamp field.
+	 * The same physical error may be reported multiple times due to stuck bits, etc.
+	 *
+	 * Also, order the checks from most->least likely to fail to shortcut the code.
+	 */
+	if (old->addr != new->addr)
+		return false;
+
+	if (old->hw_id != new->hw_id)
+		return false;
+
+	if (old->addr_type != new->addr_type)
+		return false;
+
+	if (old->hw_id_type != new->hw_id_type)
+		return false;
+
+	return true;
+}
+
+static bool is_dup_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *new)
+{
+	unsigned int i;
+
+	for (i = 0; i < get_fmp(rec)->nr_entries; i++) {
+		if (same_fpd(get_fpd(rec, i), new)) {
+			pr_debug("Found duplicate record");
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void update_fru_record(struct fru_rec *rec, struct mce *m)
+{
+	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
+	struct cper_fru_poison_desc fpd;
+	u32 entry = 0;
+
+	mutex_lock(&fmpm_update_mutex);
+
+	init_fpd(&fpd, m);
+
+	/* This is the first entry, so just save it. */
+	if (!has_valid_entries(fmp->validation_bits))
+		goto save_fpd;
+
+	/* Ignore already recorded errors. */
+	if (is_dup_fpd(rec, &fpd))
+		goto out_unlock;
+
+	if (fmp->nr_entries >= max_nr_entries) {
+		pr_warn("Exceeded number of entries for FRU 0x%016llx", fmp->fru_id);
+		goto out_unlock;
+	}
+
+	entry = fmp->nr_entries;
+
+save_fpd:
+	memcpy(get_fpd(rec, entry), &fpd, sizeof(struct cper_fru_poison_desc));
+
+	fmp->nr_entries		 = entry + 1;
+	fmp->validation_bits	|= FMP_VALID_LIST_ENTRIES;
+	fmp->validation_bits	|= FMP_VALID_LIST;
+
+	pr_debug("Updated FRU 0x%016llx Entry #%u", fmp->fru_id, entry);
+
+	update_record_on_storage(rec);
+
+out_unlock:
+	mutex_unlock(&fmpm_update_mutex);
+}
+
+static void retire_dram_row(u64 addr, u64 id, u32 cpu)
+{
+	struct atl_err a_err;
+
+	memset(&a_err, 0, sizeof(struct atl_err));
+
+	a_err.addr = addr;
+	a_err.ipid = id;
+	a_err.cpu  = cpu;
+
+	amd_retire_dram_row(&a_err);
+}
+
+static int fru_mem_poison_handler(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct mce *m = (struct mce *)data;
+	struct fru_rec *rec;
+
+	if (!mce_is_memory_error(m))
+		return NOTIFY_DONE;
+
+	retire_dram_row(m->addr, m->ipid, m->extcpu);
+
+	/*
+	 * This should not happen on real errors. But it could happen from
+	 * software error injection, etc.
+	 */
+	rec = get_fru_record(m->ppin);
+	if (!rec)
+		return NOTIFY_DONE;
+
+	update_fru_record(rec, m);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block fru_mem_poison_nb = {
+	.notifier_call  = fru_mem_poison_handler,
+	.priority	= MCE_PRIO_LOWEST,
+};
+
+static u32 get_cpu_from_fru_id(u64 fru_id)
+{
+	unsigned int cpu = 0;
+
+	/* Should there be more robust error handling if none found? */
+	for_each_online_cpu(cpu) {
+		if (topology_ppin(cpu) == fru_id)
+			break;
+	}
+
+	return cpu;
+}
+
+static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries, u32 cpu)
+{
+	struct cper_fru_poison_desc *fpd;
+	unsigned int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		fpd = get_fpd(rec, i);
+
+		if (fpd->hw_id_type != FPD_HW_ID_TYPE_MCA_IPID)
+			continue;
+
+		if (fpd->addr_type != FPD_ADDR_TYPE_MCA_ADDR)
+			continue;
+
+		retire_dram_row(fpd->addr, fpd->hw_id, cpu);
+	}
+}
+
+static void retire_mem_records(void)
+{
+	struct cper_sec_fru_mem_poison *fmp;
+	struct fru_rec *rec;
+	unsigned int i;
+	u32 cpu;
+
+	for_each_fru(i, rec) {
+		fmp = get_fmp(rec);
+
+		if (!has_valid_entries(fmp->validation_bits))
+			continue;
+
+		cpu = get_cpu_from_fru_id(fmp->fru_id);
+
+		retire_mem_fmp(rec, fmp->nr_entries, cpu);
+	}
+}
+
+/* Set the CPER Record Header and CPER Section Descriptor fields. */
+static void set_rec_fields(struct fru_rec *rec)
+{
+	struct cper_section_descriptor	*sec_desc = &rec->sec_desc;
+	struct cper_record_header	*hdr	  = &rec->hdr;
+
+	memcpy(hdr->signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
+	hdr->revision			= CPER_RECORD_REV;
+	hdr->signature_end		= CPER_SIG_END;
+
+	/*
+	 * Currently, it is assumed that there is one FRU Memory Poison
+	 * section per CPER. But this may change for other implementations.
+	 */
+	hdr->section_count		= 1;
+
+	/* The logged errors are recoverable. Otherwise, they'd never make it here. */
+	hdr->error_severity		= CPER_SEV_RECOVERABLE;
+
+	hdr->validation_bits		= 0;
+	hdr->record_length		= max_rec_len;
+	hdr->creator_id			= CPER_CREATOR_FMP;
+	hdr->notification_type		= CPER_NOTIFY_MCE;
+	hdr->record_id			= cper_next_record_id();
+	hdr->flags			= CPER_HW_ERROR_FLAGS_PREVERR;
+
+	sec_desc->section_offset	= sizeof(struct cper_record_header);
+	sec_desc->section_length	= max_rec_len - sizeof(struct cper_record_header);
+	sec_desc->revision		= CPER_SEC_REV;
+	sec_desc->validation_bits	= 0;
+	sec_desc->flags			= CPER_SEC_PRIMARY;
+	sec_desc->section_type		= CPER_SECTION_TYPE_FMP;
+	sec_desc->section_severity	= CPER_SEV_RECOVERABLE;
+}
+
+static int save_new_records(void)
+{
+	struct fru_rec *rec;
+	unsigned int i;
+	int ret = 0;
+
+	for_each_fru(i, rec) {
+		/* Skip restored records. Should these be fixed up? */
+		if (rec->hdr.record_length)
+			continue;
+
+		set_rec_fields(rec);
+
+		ret = update_record_on_storage(rec);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static bool is_valid_fmp(struct fru_rec *rec)
+{
+	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
+	u32 len = get_fmp_len(rec);
+
+	if (!fmp)
+		return false;
+
+	if (!len)
+		return false;
+
+	/* Checksum must sum to zero for the entire section. */
+	if (do_fmp_checksum(fmp, len))
+		return false;
+
+	if (!(fmp->validation_bits & FMP_VALID_ARCH_TYPE))
+		return false;
+
+	if (fmp->fru_arch_type != FMP_ARCH_TYPE_X86_CPUID_1_EAX)
+		return false;
+
+	if (!(fmp->validation_bits & FMP_VALID_ARCH))
+		return false;
+
+	if (fmp->fru_arch != cpuid_eax(1))
+		return false;
+
+	if (!(fmp->validation_bits & FMP_VALID_ID_TYPE))
+		return false;
+
+	if (fmp->fru_id_type != FMP_ID_TYPE_X86_PPIN)
+		return false;
+
+	if (!(fmp->validation_bits & FMP_VALID_ID))
+		return false;
+
+	return true;
+}
+
+static void restore_record(struct fru_rec *new, struct fru_rec *old)
+{
+	/* Records larger than max_rec_len were skipped earlier. */
+	size_t len = min(max_rec_len, old->hdr.record_length);
+
+	memcpy(new, old, len);
+}
+
+static bool valid_record(struct fru_rec *old)
+{
+	struct fru_rec *new;
+
+	if (!is_valid_fmp(old)) {
+		pr_debug("Ignoring invalid record");
+		return false;
+	}
+
+	new = get_fru_record(old->fmp.fru_id);
+	if (!new) {
+		pr_debug("Ignoring record for absent FRU");
+		return false;
+	}
+
+	/* What if ERST has duplicate FRU entries? */
+	restore_record(new, old);
+
+	return true;
+}
+
+/*
+ * Fetch saved records from persistent storage.
+ *
+ * For each found record:
+ * - If it was not created by this module, then ignore it.
+ * - If it is valid, then copy its data to the local cache.
+ * - If it is not valid, then erase it.
+ */
+static int get_saved_records(void)
+{
+	struct fru_rec *old;
+	u64 record_id;
+	int ret, pos;
+	ssize_t len;
+
+	/*
+	 * Assume saved records match current max size.
+	 *
+	 * However, this may not be true depending on module parameters.
+	 */
+	old = kmalloc(max_rec_len, GFP_KERNEL);
+	if (!old) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = erst_get_record_id_begin(&pos);
+	if (ret < 0)
+		goto out_end;
+
+	while (!erst_get_record_id_next(&pos, &record_id)) {
+		/*
+		 * Make sure to clear temporary buffer between reads to avoid
+		 * leftover data from records of various sizes.
+		 */
+		memset(old, 0, max_rec_len);
+
+		len = erst_read_record(record_id, &old->hdr, max_rec_len,
+				       sizeof(struct fru_rec), &CPER_CREATOR_FMP);
+
+		/* Should this be retried if the temporary buffer is too small? */
+		if (len < 0)
+			continue;
+
+		if (!valid_record(old))
+			erst_clear(record_id);
+	}
+
+out_end:
+	erst_get_record_id_end();
+	kfree(old);
+out:
+	return ret;
+}
+
+static void set_fmp_fields(struct cper_sec_fru_mem_poison *fmp, unsigned int cpu)
+{
+	fmp->fru_arch_type    = FMP_ARCH_TYPE_X86_CPUID_1_EAX;
+	fmp->validation_bits |= FMP_VALID_ARCH_TYPE;
+
+	/* Assume all CPUs in the system have the same value for now. */
+	fmp->fru_arch	      = cpuid_eax(1);
+	fmp->validation_bits |= FMP_VALID_ARCH;
+
+	fmp->fru_id_type      = FMP_ID_TYPE_X86_PPIN;
+	fmp->validation_bits |= FMP_VALID_ID_TYPE;
+
+	fmp->fru_id	      = topology_ppin(cpu);
+	fmp->validation_bits |= FMP_VALID_ID;
+}
+
+static unsigned int get_cpu_for_fru_num(unsigned int i)
+{
+	unsigned int cpu = 0;
+
+	/* Should there be more robust error handling if none found? */
+	for_each_online_cpu(cpu) {
+		if (topology_physical_package_id(cpu) == i)
+			return cpu;
+	}
+
+	return cpu;
+}
+
+static void init_fmps(void)
+{
+	struct fru_rec *rec;
+	unsigned int i, cpu;
+
+	for_each_fru(i, rec) {
+		cpu = get_cpu_for_fru_num(i);
+		set_fmp_fields(get_fmp(rec), cpu);
+	}
+}
+
+static int get_system_info(void)
+{
+	u8 model = boot_cpu_data.x86_model;
+
+	/* Only load on MI300A systems for now. */
+	if (!(model >= 0x90 && model <= 0x9f))
+		return -ENODEV;
+
+	if (!cpu_feature_enabled(X86_FEATURE_AMD_PPIN)) {
+		pr_debug("PPIN feature not available");
+		return -ENODEV;
+	}
+
+	/* Use CPU Package (Socket) as FRU for MI300 systems. */
+	max_nr_fru = topology_max_packages();
+	if (!max_nr_fru)
+		return -ENODEV;
+
+	if (!max_nr_entries)
+		max_nr_entries = FMPM_DEFAULT_MAX_NR_ENTRIES;
+
+	max_rec_len  = sizeof(struct fru_rec);
+	max_rec_len += sizeof(struct cper_fru_poison_desc) * max_nr_entries;
+
+	pr_debug("max_nr_fru=%u max_nr_entries=%u, max_rec_len=%lu",
+		 max_nr_fru, max_nr_entries, max_rec_len);
+	return 0;
+}
+
+static void deallocate_records(void)
+{
+	struct fru_rec *rec;
+	int i;
+
+	for_each_fru(i, rec)
+		kfree(rec);
+
+	kfree(fru_records);
+}
+
+static int allocate_records(void)
+{
+	int i, ret = 0;
+
+	fru_records = kcalloc(max_nr_fru, sizeof(struct fru_rec *), GFP_KERNEL);
+	if (!fru_records) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < max_nr_fru; i++) {
+		fru_records[i] = kzalloc(max_rec_len, GFP_KERNEL);
+		if (!fru_records[i]) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	return ret;
+
+out_free:
+	for (; i >= 0; i--)
+		kfree(fru_records[i]);
+
+	kfree(fru_records);
+out:
+	return ret;
+}
+
+static const struct x86_cpu_id fmpm_cpuids[] = {
+	X86_MATCH_VENDOR_FAM(AMD, 0x19, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(x86cpu, fmpm_cpuids);
+
+static int __init fru_mem_poison_init(void)
+{
+	int ret;
+
+	if (!x86_match_cpu(fmpm_cpuids)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (erst_disable) {
+		pr_debug("ERST not available");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = get_system_info();
+	if (ret)
+		goto out;
+
+	ret = allocate_records();
+	if (ret)
+		goto out;
+
+	init_fmps();
+
+	ret = get_saved_records();
+	if (ret)
+		goto out_free;
+
+	ret = save_new_records();
+	if (ret)
+		goto out_free;
+
+	retire_mem_records();
+
+	mce_register_decode_chain(&fru_mem_poison_nb);
+
+	pr_info("FRU Memory Poison Manager initialized");
+	return 0;
+
+out_free:
+	deallocate_records();
+out:
+	return ret;
+}
+
+static void __exit fru_mem_poison_exit(void)
+{
+	mce_unregister_decode_chain(&fru_mem_poison_nb);
+	deallocate_records();
+}
+
+module_init(fru_mem_poison_init);
+module_exit(fru_mem_poison_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FRU Memory Poison Manager");
-- 
2.34.1


