Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432F811218
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379005AbjLMMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378988AbjLMMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:51:54 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB21BD0;
        Wed, 13 Dec 2023 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GjL2kXTMd2i2PnTpLka9uYvIe3wh2ToEdTiKO8t/ZLs=; b=GBHhS3atcKbvYSZE+G7lr2xVSQ
        J8Xru9Y54/v9+enWJoWXlcLkIb+UuCAY3g8d/K+IbsmOVNvLtIrmEMFHDoDdsXzBv06qv1y61z79P
        BMxJ8FdjAQm2gM7JfKDvbfwGy4QHuIhxTSAaf0NOkDOS6ChYkW8Uf9bYIDcEVnVr1+Na7zNCxYm8L
        YUxzIokMmeol0Thdj+nFdSCNSPrZTCTyqkGyqhPGFF06oijt4zU/TSoCSo2c0ysNpBZN3e00i+wJn
        vFW+8Z6fY10dFz+JNi6Kg+JJM7xwb/1usJghBrUNHGADIPkPNmb9Nq50ZUdGkY2mjVKU8Os5ZpGni
        bXfksiIw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44942 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1rDOhP-0008Ht-3D;
        Wed, 13 Dec 2023 12:50:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1rDOhS-00Dvla-7i; Wed, 13 Dec 2023 12:50:54 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS support for
 toggling CPU present/enabled
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOhS-00Dvla-7i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Wed, 13 Dec 2023 12:50:54 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Platform firmware can disabled a CPU, or make it not-present by making
an eject-request notification, then waiting for the os to make it offline
and call _EJx. After the firmware updates _STA with the new status.

Not all operating systems support this. For arm64 making CPUs not-present
has never been supported. For all ACPI architectures, making CPUs disabled
has recently been added. Firmware can't know what the OS has support for.

Add two new _OSC bits to advertise whether the OS supports the _STA enabled
or present bits being toggled for CPUs. This will be important for arm64
if systems that support physical CPU hotplug ever appear as arm64 linux
doesn't currently support this, so firmware shouldn't try.

Advertising this support to firmware is useful for cloud orchestrators
to know whether they can scale a particular VM by adding CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
---
I'm assuming Loongarch machines do not support physical CPU hotplug.

Changes since RFC v3:
 * Drop ia64 changes
 * Update James' comment below "---" to remove reference to ia64

Outstanding comment:
 https://lore.kernel.org/r/20230914175021.000018fd@Huawei.com
---
 arch/x86/Kconfig              |  1 +
 drivers/acpi/Kconfig          |  9 +++++++++
 drivers/acpi/acpi_processor.c | 14 +++++++++++++-
 drivers/acpi/bus.c            | 16 ++++++++++++++++
 include/linux/acpi.h          |  4 ++++
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 64fc7c475ab0..33fc4dcd950c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -60,6 +60,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ACPI_HOTPLUG_PRESENT_CPU		if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_HOTPLUG_IGNORE_OSC		if ACPI && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9c5a43d0aff4..020e7c0ab985 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -311,6 +311,15 @@ config ACPI_HOTPLUG_PRESENT_CPU
 	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
 
+config ACPI_HOTPLUG_IGNORE_OSC
+	bool
+	depends on ACPI_HOTPLUG_PRESENT_CPU
+	help
+	  Ignore whether firmware acknowledged support for toggling the CPU
+	  present bit in _STA. Some architectures predate the _OSC bits, so
+	  firmware doesn't know to do this.
+
+
 config ACPI_PROCESSOR_AGGREGATOR
 	tristate "Processor Aggregator"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index ea12e70dfd39..5bb207a7a1dd 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,6 +182,18 @@ static void __init acpi_pcc_cpufreq_init(void)
 static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
+static bool acpi_processor_hotplug_present_supported(void)
+{
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+		return false;
+
+	/* x86 systems pre-date the _OSC bit */
+	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_IGNORE_OSC))
+		return true;
+
+	return osc_sb_hotplug_present_support_acked;
+}
+
 /* Initialization */
 static int acpi_processor_make_present(struct acpi_processor *pr)
 {
@@ -189,7 +201,7 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
+	if (!acpi_processor_hotplug_present_supported()) {
 		pr_err_once("Changing CPU present bit is not supported\n");
 		return -ENODEV;
 	}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 72e64c0718c9..7122450739d6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -298,6 +298,13 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
 bool osc_sb_cppc2_support_acked;
 
+/*
+ * ACPI 6.? Proposed Operating System Capabilities for modifying CPU
+ * present/enable.
+ */
+bool osc_sb_hotplug_enabled_support_acked;
+bool osc_sb_hotplug_present_support_acked;
+
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
@@ -346,6 +353,11 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
+
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_ENABLED_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_PRESENT_SUPPORT;
+
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
@@ -383,6 +395,10 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
 		osc_cpc_flexible_adr_space_confirmed =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
+		osc_sb_hotplug_enabled_support_acked =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_HOTPLUG_ENABLED_SUPPORT;
+		osc_sb_hotplug_present_support_acked =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_HOTPLUG_PRESENT_SUPPORT;
 	}
 
 	kfree(context.ret.pointer);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 00be66683505..c572abac803c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -559,12 +559,16 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
+#define OSC_SB_HOTPLUG_ENABLED_SUPPORT		0x00800000
+#define OSC_SB_HOTPLUG_PRESENT_SUPPORT		0x01000000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
 extern bool osc_sb_native_usb4_support_confirmed;
 extern bool osc_sb_cppc2_support_acked;
 extern bool osc_cpc_flexible_adr_space_confirmed;
+extern bool osc_sb_hotplug_enabled_support_acked;
+extern bool osc_sb_hotplug_present_support_acked;
 
 /* USB4 Capabilities */
 #define OSC_USB_USB3_TUNNELING			0x00000001
-- 
2.30.2

