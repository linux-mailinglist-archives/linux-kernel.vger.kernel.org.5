Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2577844C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjHJXtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJXtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:49:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F13271E;
        Thu, 10 Aug 2023 16:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku8HXG8EAmQQ3xXzEDQoGp+k6/CauMbmdztJ9gRtpqedV4jGTkpwmvfFvDWoWoZZr4X8vLQ3ud+BmRh/kao7g7wY/HrYVoxLsW4MdlNc4jGVfO71YHjGSgA1mRuwepdQ4ozpDs2vH3uOA64y/x4yJnPCFhfnacjGNJfj4fIIutBT/pVQX+MchOgStO55A3xie/fXKqY2Wl1uMJSzhH+pjTMGo+L69HkC2KBwVzFID6XJZ9McAKbauWJ+QLcrUqrfQIb3TItFDULkm7y7/FRmkSErgNKibG9s2V1i8wRK2iDFwC4T+PZdASK1d4/lS799kFyYQ1fqOIUEwuGHKkYjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru06R9BP7cnlSoaqOOXxLGwcPjvfep4UsGtePEbcs1w=;
 b=KiGVclszUY++DAAJ+X7I6KNVQz+G+dUrBbYLCc3Uy4/2vs5jwHZRGSZWTp+MEvnqYl+SiAS9/M+1RUYPEfSBfwmkJ9R+d0httH/C3Oqtzsa3qAuRMVXMPmcYU11mn5aPTd8BdLpIOh3c3MbNymkUXNhvUmUPTFc3OeZEeakY5skoLHpP7wD85JSqll7KWCJAXn3fg3ZSWP26VgSODMUqpMy8PVxGevw2GYQ4EwqIq81QQU6b+dwppv7ey3zkxNe7hXIa0foTU/1JVRYqwkbFD0JPY4Rn+ciWX1lYK4GQAmVLvuy3tPeZ223rYz2PzLphReDSCFB5q6dMK42FfmKRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru06R9BP7cnlSoaqOOXxLGwcPjvfep4UsGtePEbcs1w=;
 b=eEwuirhzW58PlMXeWCXUHALyYy93GN/IuergFfY3G4spocYMy9hb5m1u0m7cW9rRHPiBWc68XdtrMQdPLejjND19ZPLWQlBxPpkTl/w2KqAdlbeH1LZWWECnQe+sjym1FNRgSI/6Y+dZTVEzGAVoeBFeeZqyeXVfAJG8ahOPZ1Y=
Received: from CH0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:610:cc::6)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 23:49:10 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::9e) by CH0PR03CA0061.outlook.office365.com
 (2603:10b6:610:cc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 23:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 23:49:09 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 18:49:08 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <avadnaik@amd.com>
Subject: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Date:   Thu, 10 Aug 2023 18:48:56 -0500
Message-ID: <20230810234856.2580143-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f687bc-ad6f-448b-ddb6-08db99fc643d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQBZjWQC/zpf2aUnC/gxT5ge8rGMvc5qjUQFX7yg1K9up6zsH+R/hY2xZtWHJSJm/6cYlz9+3XDyWU4b6hY0FZtsB3w/yHN7GMQcwHWH87a/rejaeSeas3KlNEFAWWv2y33mVPMBo3Okfj44GDrgaxA7A8pNvvShnUdyKsRyks6fmpvPB5tRv7Mm0w4I3NzQn5rWHhcXHoXoaGJ8LTptHrDB9vAZPQGwMLpXxst5Vu3BxkG3DK9uyTn92fuQbX15GWuXslJzm2BBRxZxCg2V0zC2rgu1OUZBV+LljeiKgEwn90WVjorSY05XmP5md5sj9oo5nnaWKvs/1Pp8fEz2pthNdgfJBTS3oQixgjhmf3PPyCbTQCwQE4+qxVXPalIAKzO2QBN7rZFF9tpIzb30epkMq+bUKjerwUMCfEPi47dpHpQtPkLNo6PN8uhoaEACNezyI2Hhf6M3pJDzT2VUKlslX48/VStc16Yd8qJwJPg86YuzJeBQudIIx4xgJFqG/dZT36Wt/xQXZ7pFVdzX1wNqGZcfg2AfJ/M8TwQS3QiIpCPdnyYV1+VwLay0TE3zY49WN1CzlHGzyYoGZTQrKKke/ztXSEm4qkvYq/dQaX6jmA2mI8cQHWIh/laUFvdyn+NMtkZQNqIwqqB6a3BeTRS13TpnrpQBYDGuo+uTvgpIfo2AFd43LJvF3pynyiANCgkjGiFyuwsV/q02+axkwXJ1M4f5sniNs6Ua+9RvS6h+7Yrs3E+pqj2DtB14O47hm+s7//WSBfLj/t0z4SUtrEJYUpGuhvRN1MBF8IaBjg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(186006)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(1076003)(82740400003)(26005)(41300700001)(47076005)(316002)(8676002)(8936002)(6666004)(44832011)(5660300002)(426003)(16526019)(336012)(40460700003)(83380400001)(40480700001)(54906003)(81166007)(36756003)(30864003)(110136005)(7696005)(36860700001)(356005)(86362001)(478600001)(2906002)(70206006)(70586007)(4326008)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:49:09.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f687bc-ad6f-448b-ddb6-08db99fc643d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
an extensible set of platform health related telemetry. The telemetry is
exposed through Firmware Version and Firmware Health Data Records which
provide version data and health-related information of their associated
components respectively.

Additionally, the platform also provides Reset Reason Health Record in
the PHAT table highlighting the cause of last system reset or boot in case
of both expected and unexpected events. Vendor-specific data capturing the
underlying state of the system during reset can also be optionally provided
through the record.[1]

Add support to parse the PHAT table during system bootup and have its
information logged into the dmesg buffer.

[1] ACPI specification 6.5, section 5.2.31.5

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 drivers/acpi/Kconfig                          |   9 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/phat.c                           | 270 ++++++++++++++++++
 include/acpi/actbl2.h                         |  18 ++
 5 files changed, 302 insertions(+)
 create mode 100644 drivers/acpi/phat.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 722b6eca2e93..33b932302ece 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4490,6 +4490,10 @@
 			allocator.  This parameter is primarily	for debugging
 			and performance comparison.
 
+	phat_disable=	[ACPI]
+			Disable PHAT table parsing and logging of Firmware
+			Version and Health Data records.
+
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/arch/x86/i386/IO-APIC.rst.
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 00dd309b6682..06a7dd6e5a40 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -96,6 +96,15 @@ config ACPI_FPDT
 	  This table provides information on the timing of the system
 	  boot, S3 suspend and S3 resume firmware code paths.
 
+config ACPI_PHAT
+	bool "ACPI Platform Health Assessment Table (PHAT) support"
+	depends on X86_64 || ARM64
+	help
+	  Enable support for Platform Health Assessment Table (PHAT).
+	  This table exposes an extensible set of platform health
+	  related telemetry through Firmware Version and Firmware Health
+	  Data Records.
+
 config ACPI_LPIT
 	bool
 	depends on X86_64
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3fc5a0d54f6e..93a4ec57ba6d 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -69,6 +69,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
 acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
 acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
+acpi-$(CONFIG_ACPI_PHAT)	+= phat.o
 
 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
diff --git a/drivers/acpi/phat.c b/drivers/acpi/phat.c
new file mode 100644
index 000000000000..6006dd7615fa
--- /dev/null
+++ b/drivers/acpi/phat.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform Health Assessment Table (PHAT) support
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Avadhut Naik <avadhut.naik@amd.com>
+ *
+ * This file implements parsing of the Platform Health Assessment Table
+ * through which a platform can expose an extensible set of platform
+ * health related telemetry. The telemetry is exposed through Firmware
+ * Version Data Records and Firmware Health Data Records. Additionally,
+ * a platform, through system firmware, also exposes Reset Reason Health
+ * Record to inform the operating system of the cause of last system
+ * reset or boot.
+ *
+ * For more information on PHAT, please refer to ACPI specification
+ * version 6.5, section 5.2.31
+ */
+
+#include <linux/acpi.h>
+
+static int phat_disable __initdata;
+static const char *prefix = "ACPI PHAT: ";
+
+/* Reset Reason Health Record GUID */
+static const guid_t reset_guid =
+	GUID_INIT(0x7a014ce2, 0xf263, 0x4b77,
+		  0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14);
+
+static struct { u8 mask; const char *str; } const reset_sources[] = {
+	{BIT(0), "Unknown source"},
+	{BIT(1), "Hardware Source"},
+	{BIT(2), "Firmware Source"},
+	{BIT(3), "Software initiated reset"},
+	{BIT(4), "Supervisor initiated reset"},
+};
+
+static struct { u8 val; const char *str; } const reset_reasons[] = {
+	{0, "UNKNOWN"},
+	{1, "COLD BOOT"},
+	{2, "COLD RESET"},
+	{3, "WARM RESET"},
+	{4, "UPDATE"},
+	{32, "UNEXPECTED RESET"},
+	{33, "FAULT"},
+	{34, "TIMEOUT"},
+	{35, "THERMAL"},
+	{36, "POWER LOSS"},
+	{37, "POWER BUTTON"},
+};
+
+/*
+ * Print the last PHAT Version Element associated with a Firmware
+ * Version Data Record.
+ * Firmware Version Data Record consists of an array of PHAT Version
+ * Elements with each entry in the array representing a modification
+ * undertaken on a given platform component.
+ * In the event the array has multiple entries, minimize logs on the
+ * console and print only the last version element since it denotes
+ * the currently running instance of the component.
+ */
+static int phat_version_data_parse(const char *pfx,
+				   struct acpi_phat_version_data *version)
+{
+	char newpfx[64];
+	u32 num_elems = version->element_count - 1;
+	struct acpi_phat_version_element *element;
+	int offset = sizeof(struct acpi_phat_version_data);
+
+	if (!version->element_count) {
+		pr_info("%sNo PHAT Version Elements found.\n", prefix);
+		return 0;
+	}
+
+	offset += num_elems * sizeof(struct acpi_phat_version_element);
+	element = (void *)version + offset;
+
+	pr_info("%sPHAT Version Element:\n", pfx);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+	pr_info("%sComponent ID: %pUl\n", newpfx, element->guid);
+	pr_info("%sVersion: 0x%llx\n", newpfx, element->version_value);
+	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
+	print_hex_dump(newpfx, "Producer ID: ", DUMP_PREFIX_NONE, 16, 4,
+		       &element->producer_id, sizeof(element->producer_id), true);
+
+	return 0;
+}
+
+/*
+ * Print the Reset Reason Health Record
+ */
+static int phat_reset_reason_parse(const char *pfx,
+				   struct acpi_phat_health_data *record)
+{
+	int idx;
+	void *data;
+	u32 data_len;
+	char newpfx[64];
+	struct acpi_phat_reset_reason *rr;
+	struct acpi_phat_vendor_reset_data *vdata;
+
+	rr = (void *)record + record->device_specific_offset;
+
+	for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
+		if (!rr->reset_source) {
+			pr_info("%sUnknown Reset Source.\n", pfx);
+			break;
+		}
+		if (rr->reset_source & reset_sources[idx].mask) {
+			pr_info("%sReset Source: 0x%x\t%s\n", pfx, reset_sources[idx].mask,
+				reset_sources[idx].str);
+			/* According to ACPI v6.5 Table 5.168, Sub-Source is
+			 * defined only for Software initiated reset.
+			 */
+			if (idx == 0x3 && rr->reset_sub_source)
+				pr_info("%sReset Sub-Source: %s\n", pfx,
+					rr->reset_sub_source == 0x1 ?
+					"Operating System" : "Hypervisor");
+			break;
+		}
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
+		if (rr->reset_reason == reset_reasons[idx].val) {
+			pr_info("%sReset Reason: 0x%x\t%s\n", pfx, reset_reasons[idx].val,
+				reset_reasons[idx].str);
+			break;
+		}
+	}
+
+	if (!rr->vendor_count)
+		return 0;
+
+	pr_info("%sReset Reason Vendor Data:\n", pfx);
+	vdata = (void *)rr + sizeof(*rr);
+
+	for (idx = 0; idx < rr->vendor_count; idx++) {
+		snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+		data_len = vdata->length - sizeof(*vdata);
+		data = (void *)vdata + sizeof(*vdata);
+		pr_info("%sVendor Data ID: %pUl\n", newpfx, vdata->vendor_id);
+		pr_info("%sRevision: 0x%x\n", newpfx, vdata->revision);
+		snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
+		print_hex_dump(newpfx, "Data: ", DUMP_PREFIX_NONE, 16, 4,
+			       data, data_len, false);
+		vdata = (void *)vdata + vdata->length;
+	}
+
+	return 0;
+}
+
+/*
+ * Print the Firmware Health Data Record.
+ */
+static int phat_health_data_parse(const char *pfx,
+				  struct acpi_phat_health_data *record)
+{
+	void *data;
+	u32 data_len;
+	char newpfx[64];
+
+	pr_info("%sHealth Records.\n", pfx);
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+	pr_info("%sDevice Signature: %pUl\n", newpfx, record->device_guid);
+
+	switch (record->health) {
+	case ACPI_PHAT_ERRORS_FOUND:
+		pr_info("%sAmHealthy: Errors found\n", newpfx);
+		break;
+	case ACPI_PHAT_NO_ERRORS:
+		pr_info("%sAmHealthy: No errors found.\n", newpfx);
+		break;
+	case ACPI_PHAT_UNKNOWN_ERRORS:
+		pr_info("%sAmHealthy: Unknown.\n", newpfx);
+		break;
+	case ACPI_PHAT_ADVISORY:
+		pr_info("%sAmHealthy: Advisory – additional device-specific data exposed.\n",
+			newpfx);
+		break;
+	default:
+		break;
+	}
+
+	if (!record->device_specific_offset)
+		return 0;
+
+	/* Reset Reason Health Record has a unique GUID and is created as
+	 * a Health Record in the PHAT table. Check if this Health Record
+	 * is a Reset Reason Health Record.
+	 */
+	if (guid_equal((guid_t *)record->device_guid, &reset_guid)) {
+		phat_reset_reason_parse(newpfx, record);
+		return 0;
+	}
+
+	data = (void *)record + record->device_specific_offset;
+	data_len = record->header.length - record->device_specific_offset;
+	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
+	print_hex_dump(newpfx, "Device Data: ", DUMP_PREFIX_NONE, 16, 4,
+		       data, data_len, false);
+
+	return 0;
+}
+
+static int parse_phat_table(const char *pfx, struct acpi_table_phat *phat_tab)
+{
+	char newpfx[64];
+	u32 offset = sizeof(*phat_tab);
+	struct acpi_phat_header *phat_header;
+
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+
+	while (offset < phat_tab->header.length) {
+		phat_header = (void *)phat_tab + offset;
+		switch (phat_header->type) {
+		case ACPI_PHAT_TYPE_FW_VERSION_DATA:
+			phat_version_data_parse(newpfx, (struct acpi_phat_version_data *)
+			    phat_header);
+			break;
+		case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
+			phat_health_data_parse(newpfx, (struct acpi_phat_health_data *)
+			    phat_header);
+			break;
+		default:
+			break;
+		}
+		offset += phat_header->length;
+	}
+	return 0;
+}
+
+static int __init setup_phat_disable(char *str)
+{
+	phat_disable = 1;
+	return 1;
+}
+__setup("phat_disable", setup_phat_disable);
+
+static int __init acpi_phat_init(void)
+{
+	acpi_status status;
+	struct acpi_table_phat *phat_tab;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (phat_disable) {
+		pr_err("%sPHAT support has been disabled.\n", prefix);
+		return 0;
+	}
+
+	status = acpi_get_table(ACPI_SIG_PHAT, 0,
+				(struct acpi_table_header **)&phat_tab);
+
+	if (status == AE_NOT_FOUND) {
+		pr_info("%sPHAT Table not found.\n", prefix);
+		return 0;
+	} else if (ACPI_FAILURE(status)) {
+		pr_err("%sFailed to get PHAT Table: %s.\n", prefix,
+		       acpi_format_exception(status));
+		return -EINVAL;
+	}
+
+	pr_info("%sPlatform Telemetry Records.\n", prefix);
+	parse_phat_table(prefix, phat_tab);
+
+	return 0;
+}
+late_initcall(acpi_phat_init);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0029336775a9..c263893cbc7f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2360,6 +2360,24 @@ struct acpi_phat_health_data {
 #define ACPI_PHAT_UNKNOWN_ERRORS        2
 #define ACPI_PHAT_ADVISORY              3
 
+/* Reset Reason Health Record Structure */
+
+struct acpi_phat_reset_reason {
+	u8 supported_reset_sources;
+	u8 reset_source;
+	u8 reset_sub_source;
+	u8 reset_reason;
+	u16 vendor_count;
+};
+
+/* Reset Reason Health Record Vendor Data Entry */
+
+struct acpi_phat_vendor_reset_data {
+	u8 vendor_id[16];
+	u16 length;
+	u16 revision;
+};
+
 /*******************************************************************************
  *
  * PMTT - Platform Memory Topology Table (ACPI 5.0)
-- 
2.34.1

