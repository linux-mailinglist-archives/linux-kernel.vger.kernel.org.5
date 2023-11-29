Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6CF7FD207
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjK2JPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjK2JOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5C1BFD;
        Wed, 29 Nov 2023 01:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTUuFIbr6kkbOBZefuvDJUEAMzJ0SSfnErfi2jK3wERgc/lGgFMNhLJvf/5ZgDBEZjb1SnSc4xkSH73g5DVlZEdJptwqBcFmG37imCxi3ITedGWjzAj7sFZ1YD/iOJ7uAfO9mEMGW67SNyXA5BHpjPEbag4X5Ch4bXetoeN9SCK7vldPiRz3oerDLfKXqcn7/zRe6uLVM8E7sAs28q/tULNKfpUeQcW/uyWvY6QDrcQtqMRN/ftvnj6wWK/AK4KLAaTIPQbLMcZxSQf3SqZTtpeNHNvsvA1cfGlYODWUU9u0lwtI4fvh/KrLzP/I56yNsCGwoUpZPYVCuLgXjVmcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKFSQJSAGZOxQax56bNPWfTbmfVQiNdrX37BllB2UVM=;
 b=Klc/ca9UR6fzEgoyGTrgI9FpJOhMEo225Of5EGTeNohasynd2FACDVBwDkWc+pYP3U6Idx39EhWGklGiyWOo9NKoQrhkNXRSnOpwkL275e4UtvPST2JkJVsU6C/taTYcqqh2tb9/aB19IFM5nQoh97SygdkGf8sUcPchE572/ZBiHBFFuxiw+l7me4sq181/+A3rscc0H2eixUsG7CFbi3S1JEGGOr/9YOp/hCzGM1VGu5DE0hsbEd4lMLj78/S1eRajJ6+v/TmbUwtAHT04cKg6duylIaUSN0BLPV8CE32qAOQMJUrQRARPWdBO2KjzDvdwIFF4wRaJIf/upUF2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKFSQJSAGZOxQax56bNPWfTbmfVQiNdrX37BllB2UVM=;
 b=l4jwISMyOFa0aqCq3iP4MW3m8C8BkoIaGW2vrfaNygp5EAwJSdMsFt+O0+gUAb5VyNebhvXpih1Sq/6X8Dq+QJwTMWJCCqFyDPbUzH9kjzgw9c1XzADP9ktgI4IdEXD9Anu2f/OSH/+k8OI58KkfFNr5UCkhCDKtzadLnnMj+Js=
Received: from BL0PR02CA0083.namprd02.prod.outlook.com (2603:10b6:208:51::24)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 09:14:33 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::61) by BL0PR02CA0083.outlook.office365.com
 (2603:10b6:208:51::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:33 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:26 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
        Evan Quan <quanliangl@hotmail.com>
Subject: [PATCH v14 2/9] platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature
Date:   Wed, 29 Nov 2023 17:13:41 +0800
Message-ID: <20231129091348.3972539-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dade31c-c8d1-4cac-17e9-08dbf0bb99cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmuKq6RQ4pPbfNjFHhLmhmkGpGVtqGv0Ij9pajZFnGfX64yPB2HsXqD3CTTbMPseQ7PWLvBmiO4os/U8wyvpIGcD6t0t5Dh0H2idSd4IzKAmCXs4LFnrZzw9ge3ZWUp3a7X5bWxDNtvlAHcV85AA4FJSll+YQJnUFskSzyKr53OQNAq4ItkqVJnatSZiK2i51lox4p8xDg2ZmIqJY/Fr3E03OzNXATCOIBH3ZQFx/QGh4gW7TIzeLtC0fZqSTbG4S+E1EXSiBrTmItfgpPn+YoRKdBBwvx++mcsK9UE8iLO7cDHj9iVHJO7fYaYMb2gj5G8/k+Q+aOlWFSJSl/67Yfnk5yMrYcGXJAgIDc2XoS4hLuk0e91zkOyN8HO2o5lUjBIUgiiT4tRZhcPuaJKaM4c4GvHvNVL+JNZjllU/4WoJdx44iY1SGRenmEjnJqr5ASWxJL4JAoghcXSKqXlsJyEAd4ZX91K0BBSE4rEeILtFbmUL9FuzuI2bsBs+r0aPTE9mJ5SzZEANuqKXIl2ZcthSY+f7KeHzsG4YmpYpFFtWQKNxI4dSVfHqsm1i1ACW4OCmf87AGJj3KHAgEMo5PCGV0QVseEoiHi1iKiFnJU3a6YcvM5gLmrzXkKdXTye/oqLt36NnJFMJtciaJU3WNafJa7aLN6XydgepIBKf3r3+EjAKJ6xE0UrDBkzlWWctBh+iIVtFKH9eSehxzii6Vd7I8IKKbFxlDWxpYHXM4lEqZiLGJNqjrH+1tAlhgpLrYXyXrcRvx81+xDm431ENG2oRhGefaAdyWIaCHo0aWFQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(70206006)(70586007)(40480700001)(54906003)(41300700001)(83380400001)(4326008)(8676002)(36860700001)(478600001)(7416002)(2906002)(5660300002)(30864003)(110136005)(316002)(86362001)(8936002)(45080400002)(6666004)(32650700002)(7696005)(40460700003)(36756003)(356005)(2616005)(81166007)(1076003)(16526019)(26005)(921008)(82740400003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:33.2362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dade31c-c8d1-4cac-17e9-08dbf0bb99cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to electrical and mechanical constraints in certain platform designs
there may be likely interference of relatively high-powered harmonics of
the (G-)DDR memory clocks with local radio module frequency bands used
by Wifi 6/6e/7.

To mitigate this, AMD has introduced a mechanism that devices can use to
notify active use of particular frequencies so that other devices can make
relative internal adjustments as necessary to avoid this resonance.

Co-developed-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

--
v11:
 - fix typo(Simon)
v12:
 - Fix the code logic (Rafael)
 - Move amd_wbrf.c to drivers/platform/x86/amd/wbrf.c
 - Updated Evan's email because he's no longer at AMD.Thanks
for his work in earlier versions.
v13:
 - Fix the format issue (IIpo Jarvinen)
 - Add comment for some functions
v14:
 - Use the apci_check_dsm and acpi_evaluate_dsm (Hans de Goede)
---
 drivers/platform/x86/amd/Kconfig  |  15 ++
 drivers/platform/x86/amd/Makefile |   1 +
 drivers/platform/x86/amd/wbrf.c   | 337 ++++++++++++++++++++++++++++++
 include/linux/acpi_amd_wbrf.h     |  94 +++++++++
 4 files changed, 447 insertions(+)
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index 55f3a2fc6aec..ac2b7758a04f 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -18,3 +18,18 @@ config AMD_HSMP
 
 	  If you choose to compile this driver as a module the module will be
 	  called amd_hsmp.
+
+config AMD_WBRF
+	bool "AMD Wifi RF Band mitigations (WBRF)"
+	depends on ACPI
+	default n
+	help
+	  WBRF(Wifi Band RFI mitigation) mechanism allows Wifi drivers
+	  to notify the frequencies they are using so that other hardware
+	  can be reconfigured to avoid harmonic conflicts.
+
+	  AMD provides an ACPI based mechanism to support WBRF on platform with
+	  appropriate underlying support.
+
+	  This mechanism will only be activated on platforms that advertise a
+	  need for it.
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index f04932b7a7d1..dcec0a46f8af 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
 amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
+obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
diff --git a/drivers/platform/x86/amd/wbrf.c b/drivers/platform/x86/amd/wbrf.c
new file mode 100644
index 000000000000..36e90a1159be
--- /dev/null
+++ b/drivers/platform/x86/amd/wbrf.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Frequency Band Manage Interface
+ * Copyright (C) 2023 Advanced Micro Devices
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_amd_wbrf.h>
+
+#define ACPI_AMD_WBRF_METHOD	"\\WBRF"
+
+/*
+ * Functions bit vector for WBRF method
+ *
+ * Bit 0: WBRF supported.
+ * Bit 1: Function 1 (Add / Remove frequency) is supported.
+ * Bit 2: Function 2 (Get frequency list) is supported.
+ */
+#define WBRF_ENABLED		0x0
+#define WBRF_RECORD			0x1
+#define WBRF_RETRIEVE		0x2
+
+#define WBRF_REVISION		0x1
+
+/*
+ * The data structure used for WBRF_RETRIEVE is not naturally aligned.
+ * And unfortunately the design has been settled down.
+ */
+struct amd_wbrf_ranges_out {
+	u32			num_of_ranges;
+	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+} __packed;
+
+static const guid_t wifi_acpi_dsm_guid =
+	GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
+		  0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
+
+/*
+ * Used to notify consumer (amdgpu driver currently) about
+ * the wifi frequency is change.
+ */
+static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
+
+static int wbrf_record(struct acpi_device *adev, uint8_t action, struct wbrf_ranges_in_out *in)
+{
+	union acpi_object argv4;
+	union acpi_object *tmp;
+	union acpi_object *obj;
+	u32 num_of_ranges = 0;
+	u32 num_of_elements;
+	u32 arg_idx = 0;
+	int ret;
+	u32 i;
+
+	if (!in)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
+		if (in->band_list[i].start && in->band_list[i].end)
+			num_of_ranges++;
+	}
+
+	/*
+	 * The num_of_ranges value in the "in" object supplied by
+	 * the caller is required to be equal to the number of
+	 * entries in the band_list array in there.
+	 */
+	if (num_of_ranges != in->num_of_ranges)
+		return -EINVAL;
+
+	/*
+	 * Every input frequency band comes with two end points(start/end)
+	 * and each is accounted as an element. Meanwhile the range count
+	 * and action type are accounted as an element each.
+	 * So, the total element count = 2 * num_of_ranges + 1 + 1.
+	 */
+	num_of_elements = 2 * num_of_ranges + 2;
+
+	tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	argv4.package.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = num_of_elements;
+	argv4.package.elements = tmp;
+
+	/* save the number of ranges*/
+	tmp[0].integer.type = ACPI_TYPE_INTEGER;
+	tmp[0].integer.value = num_of_ranges;
+
+	/* save the action(WBRF_RECORD_ADD/REMOVE/RETRIEVE) */
+	tmp[1].integer.type = ACPI_TYPE_INTEGER;
+	tmp[1].integer.value = action;
+
+	arg_idx = 2;
+	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
+		if (!in->band_list[i].start || !in->band_list[i].end)
+			continue;
+
+		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+		tmp[arg_idx++].integer.value = in->band_list[i].start;
+		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
+		tmp[arg_idx++].integer.value = in->band_list[i].end;
+	}
+
+	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
+				WBRF_REVISION, WBRF_RECORD, &argv4);
+
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = obj->integer.value;
+	if (ret)
+		ret = -EINVAL;
+
+out:
+	ACPI_FREE(obj);
+	kfree(tmp);
+
+	return ret;
+}
+
+/**
+ * acpi_amd_wbrf_add_remove - add or remove the frequency band the device is using
+ *
+ * @dev: device pointer
+ * @action: remove or add the frequency band into bios
+ * @in: input structure containing the frequency band the device is using
+ *
+ * Broadcast to other consumers the frequency band the device starts
+ * to use. Underneath the surface the information is cached into an
+ * internal buffer first. Then a notification is sent to all those
+ * registered consumers. So then they can retrieve that buffer to
+ * know the latest active frequency bands. Consumers that haven't
+ * yet been registered can retrieve the information from the cache
+ * when they register.
+ *
+ * Return:
+ * 0 for success add/remove wifi frequency band.
+ * Returns a negative error code for failure.
+ */
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in)
+{
+	struct acpi_device *adev;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	ret = wbrf_record(adev, action, in);
+	if (ret)
+		return ret;
+
+	blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_remove);
+
+static bool acpi_amd_wbrf_supported_system(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
+
+	return ACPI_SUCCESS(status);
+}
+
+/**
+ * acpi_amd_wbrf_supported_producer - determine if the WBRF can be enabled
+ *                                    for the device as a producer
+ *
+ * @dev: device pointer
+ *
+ * Check if the platform equipped with necessary implementations to
+ * support WBRF for the device as a producer.
+ *
+ * Return:
+ * true if WBRF is supported, otherwise returns false
+ */
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return false;
+
+	if (!acpi_amd_wbrf_supported_system())
+		return false;
+
+
+	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
+			      WBRF_REVISION, BIT(WBRF_RECORD));
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
+
+/**
+ * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
+ *                                    for the device as a consumer
+ *
+ * @dev: device pointer
+ *
+ * Determine if the platform equipped with necessary implementations to
+ * support WBRF for the device as a consumer.
+ *
+ * Return:
+ * true if WBRF is supported, otherwise returns false.
+ */
+bool acpi_amd_wbrf_supported_consumer(struct device *dev)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return false;
+
+	if (!acpi_amd_wbrf_supported_system())
+		return false;
+
+	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
+			      WBRF_REVISION, BIT(WBRF_RETRIEVE));
+}
+EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
+
+/**
+ * amd_wbrf_retrieve_freq_band - retrieve current active frequency
+ *                                     bands
+ *
+ * @dev: device pointer
+ * @out: output structure containing all the active frequency bands
+ *
+ * Retrieve the current active frequency bands which were broadcasted
+ * by other producers. The consumer who calls this API should take
+ * proper actions if any of the frequency band may cause RFI with its
+ * own frequency band used.
+ *
+ * Return:
+ * 0 for getting wifi freq band successfully.
+ * Returns a negative error code for failure.
+ */
+int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
+{
+	struct amd_wbrf_ranges_out acpi_out = {0};
+	struct acpi_device *adev;
+	union acpi_object *obj;
+	union acpi_object param;
+	int ret = 0;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	param.type = ACPI_TYPE_STRING;
+	param.string.length = 0;
+	param.string.pointer = NULL;
+
+	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
+							WBRF_REVISION, WBRF_RETRIEVE, &param);
+	if (!obj)
+		return -EINVAL;
+
+	/*
+	 * The return buffer is with variable length and the format below:
+	 * number_of_entries(1 DWORD):       Number of entries
+	 * start_freq of 1st entry(1 QWORD): Start frequency of the 1st entry
+	 * end_freq of 1st entry(1 QWORD):   End frequency of the 1st entry
+	 * ...
+	 * ...
+	 * start_freq of the last entry(1 QWORD)
+	 * end_freq of the last entry(1 QWORD)
+	 *
+	 * Thus the buffer length is determined by the number of entries.
+	 * - For zero entry scenario, the buffer length will be 4 bytes.
+	 * - For one entry scenario, the buffer length will be 20 bytes.
+	 */
+	if (obj->buffer.length > sizeof(acpi_out) || obj->buffer.length < 4) {
+		dev_err(dev, "Wrong sized WBRT information");
+		ret = -EINVAL;
+		goto out;
+	}
+	memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
+
+	out->num_of_ranges = acpi_out.num_of_ranges;
+	memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));
+
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(amd_wbrf_retrieve_freq_band);
+
+/**
+ * amd_wbrf_register_notifier - register for notifications of frequency
+ *                                   band update
+ *
+ * @nb: driver notifier block
+ *
+ * The consumer should register itself via this API so that it can get
+ * notified on the frequency band updates from other producers.
+ *
+ * Return:
+ * 0 for registering a consumer driver successfully.
+ * Returns a negative error code for failure.
+ */
+int amd_wbrf_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(amd_wbrf_register_notifier);
+
+/**
+ * amd_wbrf_unregister_notifier - unregister for notifications of
+ *                                     frequency band update
+ *
+ * @nb: driver notifier block
+ *
+ * The consumer should call this API when it is longer interested with
+ * the frequency band updates from other producers. Usually, this should
+ * be performed during driver cleanup.
+ *
+ * Return:
+ * 0 for unregistering a consumer driver.
+ * Returns a negative error code for failure.
+ */
+int amd_wbrf_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(amd_wbrf_unregister_notifier);
diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
new file mode 100644
index 000000000000..15b54734a080
--- /dev/null
+++ b/include/linux/acpi_amd_wbrf.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Wifi Band Exclusion Interface (AMD ACPI Implementation)
+ * Copyright (C) 2023 Advanced Micro Devices
+ */
+
+#ifndef _ACPI_AMD_WBRF_H
+#define _ACPI_AMD_WBRF_H
+
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+/* The maximum number of frequency band ranges */
+#define MAX_NUM_OF_WBRF_RANGES		11
+
+/* Record actions */
+#define WBRF_RECORD_ADD		0x0
+#define WBRF_RECORD_REMOVE	0x1
+
+/**
+ * struct freq_band_range - Wifi frequency band range definition
+ * @start: start frequency point (in Hz)
+ * @end: end frequency point (in Hz)
+ */
+struct freq_band_range {
+	u64		start;
+	u64		end;
+};
+
+/**
+ * struct wbrf_ranges_in_out - wbrf ranges info
+ * @num_of_ranges: total number of band ranges in this struct
+ * @band_list: array of Wifi band ranges
+ */
+struct wbrf_ranges_in_out {
+	u64			num_of_ranges;
+	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+};
+
+/**
+ * enum wbrf_notifier_actions - wbrf notifier actions index
+ * @WBRF_CHANGED: there was some frequency band updates. The consumers
+ *               should retrieve the latest active frequency bands.
+ */
+enum wbrf_notifier_actions {
+	WBRF_CHANGED,
+};
+
+#if IS_ENABLED(CONFIG_AMD_WBRF)
+bool acpi_amd_wbrf_supported_producer(struct device *dev);
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in);
+bool acpi_amd_wbrf_supported_consumer(struct device *dev);
+int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out);
+int amd_wbrf_register_notifier(struct notifier_block *nb);
+int amd_wbrf_unregister_notifier(struct notifier_block *nb);
+#else
+static inline
+bool acpi_amd_wbrf_supported_consumer(struct device *dev)
+{
+	return false;
+}
+static inline
+int acpi_amd_wbrf_remove_exclusion(struct device *dev, struct wbrf_ranges_in_out *in)
+{
+	return -ENODEV;
+}
+static inline
+int acpi_amd_wbrf_add_exclusion(struct device *dev, struct wbrf_ranges_in_out *in)
+{
+	return -ENODEV;
+}
+static inline
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	return false;
+}
+static inline
+int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
+{
+	return -ENODEV;
+}
+static inline
+int amd_wbrf_register_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+static inline
+int amd_wbrf_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_AMD_WBRF */
+
+#endif /* _ACPI_AMD_WBRF_H */
-- 
2.34.1

