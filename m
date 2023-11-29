Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9DB7FD01A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjK2HvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2Hu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:50:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC510D7;
        Tue, 28 Nov 2023 23:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLAXC8t9ydVE42qcfyaf6orKaDWJal20oZY2OpvsXFs58CscSB+EC6+a5Y32UYAcKjnD7r0pYqPadmN1d3uzUV4OYTwZXAVRtXIDquKNX8oz+1Ynb6yfX5uP0BQi2PclAZ4vtuwXnyQLlW8Fbp1E+t3BNS4svzVX1mFmDIZayvLFQ8gz3a9IUs8e928KC+Ndkgp9OfgoywtYbSM3X6ogFlYEM4msOe4/Q4skKL/rhWHBAgcN9nG+pEisgsZioTYMGcqnyHvqO1L+Y/69I3ZQb+IcgxGc6CWMaaomcqz/kburKeIKYkhEp1IqyKqF3l3YfTHQXUnJISHL7cdmoMmWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2Ir53su2wpWzp2wXAfzeCDIqnSDllVeFW9vL4uVQ0c=;
 b=c7PMWFUgFX9fwPjxbmoNRYzXMko1ryHYK1oS0YhONZIh1jwJ83fKNU563J2dumJVcxTPWRBGCZiIOyxnaBMxd2/+9DMaFLZanLrq5xeS+lcTDPL9ImkMWTzKZonPQvgD6ql5BKKRiaguKIAm3L509Vgr6ivduLfqy3hbEEy9JD0f/4N/YeL1EMD/CUm+mY3g0A27U5zawveBYPwHGuhpNPdKX1d1+Ow8QRMrhzUiTvdDTPgl5cH+lnGBFUFkjCxYF6LZ5jPZApKEbnhsXEcfLd+hn72hGr01J5ETidMAm6uwLZ6I2x19nUXMtHXdBvAVnohmcSe3m85iHCVoPdPQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2Ir53su2wpWzp2wXAfzeCDIqnSDllVeFW9vL4uVQ0c=;
 b=SH19mlNq7m1oA/Zuq23J2bXzKgd5/7AQBIHN8WvSgvffvwseDWTLppy5r1a5KCCU7Ji7NAZFwIrX6WcBjsvqP49NEmWMfb2zPcfmmYUw4nRtuDo8hTn9xsA78fvwNqE1vycFDr+JTQCH3bxPaeM5fOIaXMwG0tftuVfsHeXjdps=
Received: from CY5PR15CA0073.namprd15.prod.outlook.com (2603:10b6:930:18::21)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 07:50:59 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::b8) by CY5PR15CA0073.outlook.office365.com
 (2603:10b6:930:18::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 07:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:50:59 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:50:56 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Sathya Priya Kumar <sathyapriya.k@amd.com>
Subject: [PATCH 2/4] RAS/fmp: Add FRU memory poison CPER support for Error persistence
Date:   Wed, 29 Nov 2023 07:50:32 +0000
Message-ID: <20231129075034.2159223-3-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129075034.2159223-1-muralimk@amd.com>
References: <20231129075034.2159223-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 38095895-dce3-485d-6b9d-08dbf0afed55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /b8aK+OBsm6yRD+BdBct7AbiVE+HEv/BhjpvRkp6xq9mUbmDn52o0M/Jzb2A1Tozffm1RDC3HDFqQ+koP2CuONf44rTRQEU9ZangPlFuOQSU1hhlkSgDFHxcuoqvmOO9W2C+Quqjt0I2PhhMhvX+jbUbXyijuGLJmGPEjWYwuNu0t7GQs91WxUsl1CI/Ou0flJBd3rUPthIM6CXT3UgBU2vMxlNHvMw5ETbyYgYOHreFb05doQwHVruKjxlMWIYsRROUhel06ni/yvZIp9FQWGCiuj945dvEJ6/TW5mVaAQslCSlsdGak25W1CyxYJ+7OpYevAXTTgpSddb7bSLxljN6KveS2j7iu0OqEfYT0aiYUOi2iRelemBEdlTqkDPFron8qHHVK9EwuM34ZZpk8ZxUpsIZBLeitYhY1D4AQGjCYetTF4ZRgNQNQgWkkCfTG14Z2S+iday7oKuBY/wjmgtMjidK3+mxdshJgkkFaGSEBTlNOAvg5rRqmQR3Uf7ThfqHfX8qr1uhilCQhDToGKT/oPRJWzC2Jq4SXrGJSVUOPV77YtwsE0TR+fwHmHbWR9g2h5rFTJqsuUH9YyYEt7i4TnTh2pLzaFErBEYktsQxcvRWpbehvNFRZlxoG+WOxPX9FqkDnhVryrbqfV9jHPTnH4bRI+bZMRkt0VUYR11YIF8q+5KNATsoAzlCjrc6/7W+r/TXqxVjYhD3X/6GMO+K67GVMn5M8DX5cX0eFjBs54Cjbb2+85vTcCT7hA6dE9rChhxu4o9RrEwrqzyMmqfm3WJqMheq8B7K/L6xlUNMv6n3o03O6ldgKFd4fhEj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(30864003)(4326008)(8676002)(8936002)(41300700001)(316002)(6916009)(54906003)(70206006)(70586007)(40480700001)(7696005)(6666004)(16526019)(478600001)(1076003)(26005)(2616005)(336012)(426003)(83380400001)(40460700003)(47076005)(36860700001)(82740400003)(81166007)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:50:59.3704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38095895-dce3-485d-6b9d-08dbf0afed55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Large-scale Data center servers such as MI300A has on-chip stacked HBM3
(High Bandwidth Memory v3) memory embedded on to CPU socket.

Many memory errors tend to be consistent or intermittent and may recur.
Upon reaching a certain threshold of these errors, the specific memory area
is deemed faulty and should be replaced. In the case of on-die HBM, any
returns due to these issues will likely be directed to the socket vendor.

Define a criteria to identify the Field Replicable Unit(FRU) by evaluating
the count of "poisoned" pages within the socket and log these poisoned
pages persistently in a non-volatile storage. This process assists in
retaining information about defective memory address within the socket for
potential replacement.

To achieve this, CPER structure for FRU memory poisoning is defined.
For each FRU, identified by its Protected Processor Inventory Number(PPIN),
one CPER is allocated. Each CPER includes a poison list offset to the
corresponding PPIN, capable of holding n number of poison entries.

During boot, OS creates CPER FMP records based on number of sockets
available in the system and size of each record is calculated based on
available ERST non-volatile storage provided by BIOS.

In mission mode, Notifier is registered to handle the FRU memory poison
events. The poison count is incremented through MCE error injections,
storing MCE address, MCA_IPID and poison count in the poison list entries
until it attains maximum number of FRU poison entries.

Once maximum FRU poison entries are attained, further storage of poison
events is no longer possible. instead, a warning message is printed.
The user can configure the number of FRU poison entries through kernel
command line argument, by passing "fru_mem_poison.fru_poison_entries=N".

During next bootup, the OS reads the ERST records. The OS matches a system
PPIN with MCE PPIN, enables the retirement of all the poison addresses in
a column of the particular row in a HBM to prevent the usage of compromised
memory address in subsequent boot.

Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
Signed-off-by: Sathya Priya Kumar <sathyapriya.k@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 MAINTAINERS                      |   8 +
 drivers/ras/Kconfig              |   1 +
 drivers/ras/Makefile             |   1 +
 drivers/ras/fmp/Kconfig          |  18 ++
 drivers/ras/fmp/Makefile         |  10 +
 drivers/ras/fmp/fru_mem_poison.c | 522 +++++++++++++++++++++++++++++++
 include/linux/cper.h             |  24 ++
 include/linux/fru_mem_poison.h   |  15 +
 8 files changed, 599 insertions(+)
 create mode 100644 drivers/ras/fmp/Kconfig
 create mode 100644 drivers/ras/fmp/Makefile
 create mode 100644 drivers/ras/fmp/fru_mem_poison.c
 create mode 100644 include/linux/fru_mem_poison.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 764e400f060a..70817bd5203a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,6 +900,14 @@ S:	Supported
 F:	drivers/ras/amd/atl
 F:	include/linux/amd-atl.h
 
+RAS PERSIST FRU MEMORY POISON (FMP)
+M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	Documentation/driver-api/persist_fru_memory_poison.rst
+F:	drivers/ras/fmp/fru_mem_poison.c
+F:	include/linux/fru_mem_poison.h
+
 AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index 2e969f59c0ca..5cec40e3ccb3 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -33,5 +33,6 @@ if RAS
 
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
+source "drivers/ras/fmp/Kconfig"
 
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 3595b9547c25..11d082680f35 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
 obj-$(CONFIG_AMD_ATL)	+= amd/atl/
+obj-$(CONFIG_RAS_FMP)	+= fmp/
diff --git a/drivers/ras/fmp/Kconfig b/drivers/ras/fmp/Kconfig
new file mode 100644
index 000000000000..7c5d80c6b593
--- /dev/null
+++ b/drivers/ras/fmp/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# FRU(Field Replaceable Unit) Memory Poison Kconfig
+#
+# Copyright (c) 2023, Advanced Micro Devices, Inc.
+# All Rights Reserved.
+#
+# Author: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+
+config RAS_FMP
+	tristate "Support persisting FRU memory poisons"
+	default m
+	depends on X86_MCE && X86_LOCAL_APIC
+	help
+	  Additional support for persisting FRU(Field Replaceable Unit)
+	  memory poisons.
+	  Include support of retiring the poison pages during boot, idea is
+	  don't try and use the broken memory again during boot.
diff --git a/drivers/ras/fmp/Makefile b/drivers/ras/fmp/Makefile
new file mode 100644
index 000000000000..b476d219fd20
--- /dev/null
+++ b/drivers/ras/fmp/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# FRU(Field Replaceable Unit) Memory Poison Makefile
+#
+# Copyright (c) 2023, Advanced Micro Devices, Inc.
+# All Rights Reserved.
+#
+# Author: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+
+obj-$(CONFIG_RAS_FMP)		+= fru_mem_poison.o
diff --git a/drivers/ras/fmp/fru_mem_poison.c b/drivers/ras/fmp/fru_mem_poison.c
new file mode 100644
index 000000000000..c21e736c3ed1
--- /dev/null
+++ b/drivers/ras/fmp/fru_mem_poison.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Persisting FRU(Field Replaceable Unit) Memory Poison Error information in
+ * non-volatile storage
+ *
+ * fru_mem_poison.c :  Persist FRU memory poison linux module
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author:
+ *	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+ *	Muralidhara M K <muralidhara.mk@amd.com>
+ */
+#include <linux/kernel.h>
+#include <acpi/apei.h>
+#include <asm/amd_nb.h>
+#include <asm/mce.h>
+
+#include <linux/amd-atl.h>
+#include <linux/cper.h>
+#include <linux/fru_mem_poison.h>
+#include <linux/ktime.h>
+#include <linux/timekeeping.h>
+
+/* Persist FRU Poison Data */
+struct cper_fru_poison_record {
+	struct cper_record_header hdr;
+	struct cper_section_descriptor sec_hdr;
+	struct cper_sec_fru_mem_poisons fmp;
+} __packed;
+
+/* Poison data cache of the System with FRU components */
+struct system_fru_poison_info {
+	int nr_poisons_per_fru;
+	u64 sys_fru_id;     //system fru_id is PPIN in case of AMD
+	u64 recordid;
+	u64 rec_len;
+	struct cper_fru_poison_record *fru_record;
+};
+
+#define CPER_CREATOR_FMP						\
+	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
+		  0xa0, 0x33, 0x08, 0x75)
+#define CPER_SECTION_TYPE_FMP						\
+	GUID_INIT(0x5e4706c1, 0x5356, 0x48c6, 0x93, 0x0b, 0x52, 0xf2,	\
+		  0x12, 0x0a, 0x44, 0x58)
+
+/* Kernel module parameter to specify maximum number of fru poison entries per ppin */
+#define CPER_MAX_FRU_POISON_ENTRIES	512
+/**
+ * DOC: fru_poison_entries (int)
+ * Maximum number of records per socket. Valid setting is between 1 and
+ * default CPER_MAX_FRU_POISON_ENTRIES.
+ */
+static int fru_poison_entries;
+module_param(fru_poison_entries, int, 0644);
+MODULE_PARM_DESC(fru_poison_entries,
+		 "Maximum number of memory poison entries per fru");
+
+/* Maximum number of sockets in a system */
+u16 max_nr_fru;
+
+static void fill_mce_poison_data(struct mce *m, struct cper_fru_poison_data *temp, int fru_idx)
+{
+		m->addr = temp->addr;
+		m->ipid = temp->hw_id;
+		m->socketid = fru_idx;
+		m->extcpu = (nr_cpus_node(fru_idx) / 2 * fru_idx);
+}
+
+/*
+ * During boot, Collect the poison address stored in ERST in the previous boot
+ * and identify all system physical pages in that particular row where poison
+ * address exists and retire all the pages in a row.
+ */
+static void retire_bad_pages_from_erst(void)
+{
+	struct cper_fru_poison_data *base, *temp;
+	struct mce *m;
+	int id, j;
+
+	for (id = 0; id < max_nr_fru; id++) {
+		base = (struct cper_fru_poison_data *)&sys_fmp_info[id]->fru_record->fmp.p_list_off;
+
+		for (j = 1; j <= sys_fmp_info[id]->fru_record->fmp.poison_count; j++) {
+			temp = base + j *  sizeof(struct cper_fru_poison_data);
+			m = (struct mce *)temp;
+			fill_mce_poison_data(m, temp, id);
+
+			/* Don't try for mce address 0 */
+			if (m->addr)
+				amd_umc_retire_column_spa_from_row(m);
+		}
+	}
+}
+
+static u64 calc_checksum(struct cper_sec_fru_mem_poisons *fmp)
+{
+	struct cper_fru_poison_data *temp, *base;
+	u64 checksum = 0;
+	int j;
+
+	checksum = (u64)fmp->signature[0] | (u64)fmp->signature[1] << 8 |
+		   (u64)fmp->signature[2] << 16;
+	checksum += fmp->checksum;
+	checksum += fmp->model_id_type;
+	checksum += fmp->model_id;
+	checksum += fmp->fru_id_type;
+	checksum += fmp->fru_id;
+	checksum += fmp->poison_count;
+	checksum += fmp->p_list_off;
+
+	base = (struct cper_fru_poison_data *)&fmp->p_list_off;
+	for (j = 0; j <= fmp->poison_count; j++) {
+		temp = base + j * sizeof(struct cper_fru_poison_data);
+		checksum += temp->hw_id_type;
+		checksum += temp->addr_type;
+		checksum += temp->hw_id;
+		checksum += temp->addr;
+	}
+	return checksum;
+}
+
+struct tm get_timestamp(u64 timestamp)
+{
+	struct timespec64 ts;
+	struct tm tm;
+
+	ts.tv_sec = timestamp;
+	time64_to_tm(ts.tv_sec, 0, &tm);
+	return tm;
+}
+
+/* Fill initial fmp structure variable during empty record creation */
+static int init_fru_poison_fmp_cache(struct system_fru_poison_info *p)
+{
+	struct cper_fru_poison_record *fru_r = p->fru_record;
+
+	memcpy(fru_r->fmp.signature, "FMP", 3);
+	fru_r->fmp.model_id_type = 0;
+	fru_r->fmp.model_id = 0;
+	fru_r->fmp.fru_id_type = 0;
+	fru_r->fmp.fru_id = p->sys_fru_id;
+	fru_r->fmp.poison_count = 0;
+	fru_r->hdr.record_id = p->recordid;
+	/* Update checksum */
+	fru_r->fmp.checksum -= calc_checksum(&fru_r->fmp);
+
+	return 0;
+}
+
+/* fill cper_fru_poison_record structure variables and write record per node */
+static int apei_write_fmp(struct system_fru_poison_info *p)
+{
+	struct cper_fru_poison_record *fru_r = p->fru_record;
+
+	/* Fill structure variables */
+	memcpy(fru_r->hdr.signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
+	fru_r->hdr.revision = CPER_RECORD_REV;
+	fru_r->hdr.signature_end = CPER_SIG_END;
+	fru_r->hdr.section_count = 1;
+	fru_r->hdr.error_severity = CPER_SEV_FATAL;
+	fru_r->hdr.validation_bits = 0;
+	fru_r->hdr.record_length = p->rec_len;
+	fru_r->hdr.creator_id = CPER_CREATOR_FMP;
+	fru_r->hdr.notification_type = CPER_NOTIFY_MCE;
+	fru_r->hdr.flags = CPER_HW_ERROR_FLAGS_PREVERR;
+
+	fru_r->sec_hdr.section_offset = (void *)&fru_r->fmp - (void *)&fru_r;
+	fru_r->sec_hdr.section_length = sizeof(fru_r->fmp);
+	fru_r->sec_hdr.revision = CPER_SEC_REV;
+	fru_r->sec_hdr.validation_bits = 0;
+	fru_r->sec_hdr.flags = CPER_SEC_PRIMARY;
+	fru_r->sec_hdr.section_type = CPER_SECTION_TYPE_FMP;
+	fru_r->sec_hdr.section_severity = CPER_SEV_FATAL;
+
+	/* write to non-volatile storage */
+	return erst_write(&fru_r->hdr);
+}
+
+static int remove_extra_records(u32 idx, u64 *rec_to_remove)
+{
+	int i;
+
+	/* There are more ERST records and less FRUs in this boot */
+	for (i = 0; i < idx; i++) {
+		if (rec_to_remove[i] != 0 && erst_clear(rec_to_remove[i])) {
+			pr_warn("failed to clear erst record at index: %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int init_fru_records(u32 available_extra_recs, u64 *rec_to_remove)
+{
+	int i, j, rc = 0;
+
+	/* Number of FRUs in this boot are more than ERST records */
+	pr_debug("available_extra_recs:%d\n", available_extra_recs);
+
+	for (i = 0; i < max_nr_fru; i++) {
+		if (sys_fmp_info[i]->recordid) {
+			pr_info("Existed FRU_idx[%d] record_id: 0x%llx\n",
+				i, sys_fmp_info[i]->recordid);
+			continue;
+		}
+
+		sys_fmp_info[i]->recordid = cper_next_record_id();
+		pr_info("created new record_id for FRU_idx[%d]: 0x%llx\n",
+			i, sys_fmp_info[i]->recordid);
+
+		if (init_fru_poison_fmp_cache(sys_fmp_info[i]))
+			return -EINVAL;
+
+		for (j = 0; j < available_extra_recs; j++) {
+			if (rec_to_remove[j] != 0) {
+				sys_fmp_info[i]->recordid = rec_to_remove[j];
+
+				rc = erst_read(sys_fmp_info[i]->recordid,
+					       &sys_fmp_info[i]->fru_record->hdr,
+					       sys_fmp_info[i]->rec_len);
+				if (rc <= 0)
+					return rc;
+
+				rec_to_remove[j] = 0;
+				available_extra_recs--;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int initialize_records(struct system_fru_poison_info **sys_fmp_info,
+			      u32 idx, u64 *rec_to_remove)
+{
+	int fru_idx, rc = 0;
+
+	rc = init_fru_records(idx, rec_to_remove);
+	if (rc != 0)
+		pr_warn("Initializing CPER records failed\n");
+
+	erst_get_record_id_end();
+
+	if (remove_extra_records(idx, rec_to_remove))
+		pr_warn("Clear of extra records failed\n");
+
+	for (fru_idx = 0; fru_idx < max_nr_fru; fru_idx++) {
+		rc = apei_write_fmp(sys_fmp_info[fru_idx]);
+		if (rc) {
+			pr_warn("erst_write[%d] failed\n", fru_idx);
+			return rc;
+		}
+	}
+	return 0;
+}
+
+/* get number of records present in ERST non volatile storage */
+static int find_records(struct system_fru_poison_info **sys_fmp_info)
+{
+	struct cper_fru_poison_record *rcd;
+	int i = 0, rc, pos, count = 0;
+	bool record_matched = false;
+	u64 rec_to_remove[4] = {0};
+	u64 record_id;
+	u32 idx = 0;
+	void *temp;
+
+	temp = kzalloc(sys_fmp_info[0]->rec_len, GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	rcd = (struct cper_fru_poison_record *)temp;
+
+	rc = erst_get_record_id_begin(&pos);
+	if (rc) {
+		kfree(temp);
+		return rc;
+	}
+
+	while (!erst_get_record_id_next(&pos, &record_id)) {
+		if (record_id == APEI_ERST_INVALID_RECORD_ID)
+			goto out;
+
+		memset(temp, 0, sys_fmp_info[0]->rec_len);
+
+		rc = erst_read(record_id, &rcd->hdr, sys_fmp_info[0]->rec_len);
+		if (rc > 0) {
+			pr_debug("Read record:0x%llx, data:%d bytes, fru_id:0x%llx, pcount:%lld\n",
+				 record_id, rc, rcd->fmp.fru_id, rcd->fmp.poison_count);
+		} else {
+			pr_warn("Error reading record: 0x%llx\n", rcd->fmp.fru_id);
+			continue;
+		}
+
+		if (!guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_FMP)) {
+			pr_warn("Record type not matched\n");
+			continue;
+		}
+
+		for (i = 0; i < max_nr_fru; i++) {
+			if (rcd->fmp.fru_id == sys_fmp_info[i]->sys_fru_id) {
+				/* matching FRU is present on the system, store record_id */
+				sys_fmp_info[i]->recordid = record_id;
+				memcpy(sys_fmp_info[i]->fru_record, rcd, sys_fmp_info[i]->rec_len);
+
+				record_matched = true;
+				break;
+			}
+		}
+		if (!record_matched) {
+			rec_to_remove[idx] = record_id;
+			idx++;
+		}
+
+		record_matched = false;
+
+		count++;
+	}
+out:
+	pr_debug("number of records present: %d\n", count);
+	rc = initialize_records(sys_fmp_info, idx, rec_to_remove);
+	kfree(temp);
+	return rc;
+}
+
+static int append_to_fru_poisonlist(struct cper_sec_fru_mem_poisons *fmp_p, struct mce *m)
+{
+	struct cper_fru_poison_data *temp, *base;
+
+	if (!fmp_p && !m)
+		return -EINVAL;
+
+	if (fmp_p->poison_count >= (*sys_fmp_info)->nr_poisons_per_fru) {
+		pr_warn("Max number of poison entries for FRU Exiting\n");
+		return -EINVAL;
+	}
+
+	fmp_p->poison_count += 1;
+
+	base = (struct cper_fru_poison_data *)(&fmp_p->p_list_off);
+	temp = base + fmp_p->poison_count * sizeof(struct cper_fru_poison_data);
+	if (!temp)
+		return -ENOMEM;
+
+	/* Append poison error data to record_id */
+	temp->hw_id_type = 0;
+	temp->addr_type = 0;
+
+	temp->hw_id = m->ipid;
+	temp->addr = m->addr;
+	temp->timestamp = ktime_get_real_seconds();
+
+	/* Update checksum */
+	fmp_p->checksum -= calc_checksum(fmp_p);
+
+	pr_info("Append poison hw_id: 0x%llx addr: 0x%llx poison_num: %lld checksum: 0x%llx\n",
+		temp->hw_id, temp->addr, fmp_p->poison_count, fmp_p->checksum);
+	return 0;
+}
+
+static int fru_mem_poison_handler(struct notifier_block *nb,
+				  unsigned long val, void *data)
+{
+	struct mce *m = (struct mce *)data;
+	int i, ret;
+
+	for (i = 0; i < max_nr_fru; i++) {
+		if (!sys_fmp_info[i])
+			return -ENOMEM;
+
+		if (sys_fmp_info[i]->sys_fru_id == m->ppin) {
+			ret = append_to_fru_poisonlist(&sys_fmp_info[i]->fru_record->fmp, m);
+			if (ret < 0)
+				return ret;
+
+			/* Write to storage*/
+			return erst_write(&sys_fmp_info[i]->fru_record->hdr);
+		}
+		pr_debug("PPIN did not match for FRU_idx[%d]\n", i);
+	}
+
+	pr_debug("No FMP record in NV storage for PPIN %llu\n", m->ppin);
+	return -ENODEV;
+}
+
+static struct notifier_block fru_mem_poison_nb = {
+	.notifier_call  = fru_mem_poison_handler,
+	.priority	= MCE_PRIO_LOWEST,
+};
+
+static int find_num_poison_entries_per_fru(u64 size)
+{
+	int num = (size - sizeof(struct cper_fru_poison_record)) /
+				 sizeof(struct cper_fru_poison_data);
+
+	/* value passed through kernel parameters */
+	if (fru_poison_entries)
+		num = fru_poison_entries;
+
+	if (num >= CPER_MAX_FRU_POISON_ENTRIES)
+		num = CPER_MAX_FRU_POISON_ENTRIES;
+
+	return num;
+}
+
+static int allocate_sys_fru_cache(int nr_fru_entries)
+{
+	int i, ret = -ENOMEM;
+
+	/* On AMD MI300 platforms, max_nr_fru is number of sockets present */
+	max_nr_fru = topology_max_packages();
+	if (!max_nr_fru)
+		return -ENODEV;
+
+	/* Allocate memory for the struct system_fru_poison_info */
+	sys_fmp_info = kcalloc(max_nr_fru, sizeof(struct system_fru_poison_info *), GFP_KERNEL);
+	if (!sys_fmp_info)
+		goto err_out;
+
+	/* per node fru record */
+	for (i = 0; i < max_nr_fru; i++) {
+		sys_fmp_info[i] = kcalloc(1, sizeof(struct system_fru_poison_info), GFP_KERNEL);
+		if (!sys_fmp_info[i])
+			goto err_loop;
+
+		sys_fmp_info[i]->rec_len = sizeof(struct cper_fru_poison_record) +
+					nr_fru_entries * sizeof(struct cper_fru_poison_data);
+
+		sys_fmp_info[i]->fru_record = kzalloc(sys_fmp_info[i]->rec_len, GFP_KERNEL);
+		if (!sys_fmp_info[i]->fru_record)
+			goto err_rec;
+
+		sys_fmp_info[i]->nr_poisons_per_fru = nr_fru_entries;
+
+		/* Get ppins of all sockets present */
+		sys_fmp_info[i]->sys_fru_id = cpu_data(nr_cpus_node(i) / 2 * i).ppin;
+		pr_debug("socket[%d] sys_fru_id:0x%llx, num_of_poisons can hold : %d\n", i,
+			 sys_fmp_info[i]->sys_fru_id, sys_fmp_info[i]->nr_poisons_per_fru);
+	}
+
+	pr_debug("Number of records present, count: %ld\n", erst_get_record_count());
+	return 0;
+
+err_rec:
+	for (i = 0; i < max_nr_fru; i++) {
+		kfree(sys_fmp_info[i]);
+		sys_fmp_info[i] = NULL;
+	}
+err_loop:
+	kfree(sys_fmp_info);
+err_out:
+	return ret;
+}
+
+static int __init fru_mem_poison_init(void)
+{
+	int ret, nr_fru_entries;
+	u64 erst_size;
+
+	if (!cpu_feature_enabled(X86_FEATURE_AMD_PPIN)) {
+		pr_warn("ppin processor id number not supported\n");
+		return 0;
+	}
+
+	ret = erst_get_size();
+	if (!ret)
+		return ret;
+	erst_size = ret;
+	pr_info("Max erst size per CPER record: %lld\n", erst_size);
+
+	ret = find_num_poison_entries_per_fru(erst_size);
+	if (!ret)
+		return ret;
+	nr_fru_entries = ret;
+	pr_info("Each FMP record can hold %d poison_entries\n", nr_fru_entries);
+
+	/* Allocate CPER record per node based on max number of fru entries */
+	ret = allocate_sys_fru_cache(nr_fru_entries);
+	if (ret)
+		return ret;
+
+	/* Check if there records present */
+	ret = find_records(sys_fmp_info);
+	if (ret)
+		return ret;
+
+	/* Register notifier for fru_memory poison handling */
+	mce_register_decode_chain(&fru_mem_poison_nb);
+
+	/* retire FRU poison memory poison pages during boot */
+	retire_bad_pages_from_erst();
+
+	pr_info("Initialized CPER FRU memory poison module\n");
+	return 0;
+}
+
+static void __exit fru_mem_poison_exit(void)
+{
+	int i;
+
+	for (i = 0; i < max_nr_fru; i++) {
+		if (sys_fmp_info[i]->fru_record)
+			sys_fmp_info[i]->fru_record = NULL;
+
+		if (sys_fmp_info[i])
+			sys_fmp_info[i] = NULL;
+	}
+	if (sys_fmp_info)
+		sys_fmp_info = NULL;
+
+	mce_unregister_decode_chain(&fru_mem_poison_nb);
+}
+
+late_initcall(fru_mem_poison_init);
+module_exit(fru_mem_poison_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Persist FRU Memory Poison Driver");
diff --git a/include/linux/cper.h b/include/linux/cper.h
index c1a7dc325121..7f7153ba7858 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -550,6 +550,30 @@ struct cper_sec_fw_err_rec_ref {
 	guid_t record_identifier_guid;
 };
 
+/* FRU Memory Poison Error Section data, UEFI vX.Y sec N.X.Y */
+struct cper_fru_poison_data {
+	u32 hw_id_type;
+	u32 addr_type;
+	u64 hw_id;	/*  MCA_IPID register in case of AMD processors */
+	u64 addr;	/*  MCA_ADDR register in case of x86 processors */
+	u64 timestamp;  /*  Timestamp is UTC format */
+};
+
+/* Memory Poison Error Record Section, UEFI vX.Y sec N.X.Z */
+struct cper_sec_fru_mem_poisons {
+	char signature[4];
+	u64 checksum;
+	u32 model_id_type;
+	u32 model_id;
+	u32 fru_id_type;
+	u64 fru_id;
+	u64 poison_count;
+	u64 p_list_off;	/* Allocate contiguous memory for max_number_poison_entries
+			 * based on available NV storage at the end of the
+			 * struct cper_sec_fru_mem_poisons
+			 */
+};
+
 /* Reset to default packing */
 #pragma pack()
 
diff --git a/include/linux/fru_mem_poison.h b/include/linux/fru_mem_poison.h
new file mode 100644
index 000000000000..d3e567c990aa
--- /dev/null
+++ b/include/linux/fru_mem_poison.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Persist FRU Memory Poison driver
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
+ */
+#ifndef _X86_FMP_H
+#define _X86_FMP_H
+
+struct system_fru_poison_info **sys_fmp_info;
+
+#endif /* _X86_FMP_H */
-- 
2.25.1

