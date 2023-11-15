Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D2F7EC885
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKOQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:28:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A23E8E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E19CDA7;
        Wed, 15 Nov 2023 08:29:31 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98CA23F641;
        Wed, 15 Nov 2023 08:28:43 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] coresight: Make current W=1 warnings default
Date:   Wed, 15 Nov 2023 16:28:33 +0000
Message-Id: <20231115162834.355598-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to drivers/gpu/drm/amd/amdgpu/Makefile and
fs/btrfs/Makefile, copy the current set of W=1 warnings from
Makefile.extrawarn to the coresight makefile to make them default.
Unfortunately there is no easy way to do this without copying.

In addition to the default set of warnings, add -Wno-sign-compare to
disable that warning. That's because Makefile.extrawarn does some extra
steps to disable some -Wextra warnings unless W=2 or W=3 are used.
That's the only one that's needed for Coresight, so disable it.

Although a W=1 currently works for Coresight, because we're not
disabling all of the -Wextra warnings that Makefile.extrawarn does, a
few struct initialiser warnings need to be fixed, so fix those in the
code rather than disabling even more warnings.

Signed-off-by: James Clark <james.clark@arm.com>
---

Changes since V1:
 * Fix arm32 build by fixing struct initialiser in coresight-etm3x-core.c

 drivers/hwtracing/coresight/Makefile          | 20 +++++++++++++++++++
 .../hwtracing/coresight/coresight-cti-core.c  |  2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  2 +-
 .../coresight/coresight-etm3x-core.c          |  2 +-
 .../coresight/coresight-etm4x-core.c          |  2 +-
 .../hwtracing/coresight/coresight-funnel.c    |  4 ++--
 .../coresight/coresight-replicator.c          |  2 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  2 +-
 drivers/hwtracing/coresight/coresight-tpda.c  |  2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |  2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  2 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  2 +-
 13 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 995d3b2c76df..4ba478211b31 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -2,6 +2,26 @@
 #
 # Makefile for CoreSight drivers.
 #
+
+# Current W=1 warnings
+subdir-ccflags-y += -Wextra -Wunused -Wno-unused-parameter
+subdir-ccflags-y += -Wmissing-declarations
+subdir-ccflags-y += -Wmissing-format-attribute
+subdir-ccflags-y += -Wmissing-prototypes
+subdir-ccflags-y += -Wold-style-definition
+subdir-ccflags-y += -Wmissing-include-dirs
+subdir-ccflags-y += -Wno-sign-compare
+condflags := \
+	$(call cc-option, -Wrestrict)				\
+	$(call cc-option, -Wunused-but-set-variable)		\
+	$(call cc-option, -Wunused-const-variable)		\
+	$(call cc-option, -Wpacked-not-aligned)			\
+	$(call cc-option, -Wformat-overflow)			\
+	$(call cc-option, -Wformat-truncation)			\
+	$(call cc-option, -Wstringop-overflow)			\
+	$(call cc-option, -Wstringop-truncation)
+subdir-ccflags-y += $(condflags)
+
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 3999d0a2cb60..e805617020d0 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -974,7 +974,7 @@ static const struct amba_id cti_ids[] = {
 	CS_AMBA_ID(0x000bb9aa), /* CTI - C-A73 */
 	CS_AMBA_UCI_ID(0x000bb9da, uci_id_cti), /* CTI - C-A35 */
 	CS_AMBA_UCI_ID(0x000bb9ed, uci_id_cti), /* Coresight CTI (SoC 600) */
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, cti_ids);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index fa80039e0821..3ae42c5a29eb 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -837,7 +837,7 @@ static const struct amba_id etb_ids[] = {
 		.id	= 0x000bb907,
 		.mask	= 0x000fffff,
 	},
-	{ 0, 0},
+	{ 0, 0, 0 },
 };
 
 MODULE_DEVICE_TABLE(amba, etb_ids);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 116a91d90ac2..8da1622e0837 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -1003,7 +1003,7 @@ static const struct amba_id etm_ids[] = {
 	CS_AMBA_ID_DATA(0x000bb95f, "PTM 1.1"),
 	/* PTM 1.1 Qualcomm */
 	CS_AMBA_ID_DATA(0x000b006f, "PTM 1.1"),
-	{ 0, 0},
+	{ 0, 0, NULL},
 };
 
 MODULE_DEVICE_TABLE(amba, etm_ids);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 285539104bcc..5faa9c85c272 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2392,7 +2392,7 @@ static const struct of_device_id etm4_sysreg_match[] = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id etm4x_acpi_ids[] = {
-	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
+	{"ARMHC500", 0, 0, 0}, /* ARM CoreSight ETM4x */
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b8e150e45b27..24cee5408b86 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -351,7 +351,7 @@ MODULE_DEVICE_TABLE(of, static_funnel_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_funnel_ids[] = {
-	{"ARMHC9FE", 0},
+	{"ARMHC9FE", 0, 0, 0},
 	{},
 };
 
@@ -392,7 +392,7 @@ static const struct amba_id dynamic_funnel_ids[] = {
 		.id     = 0x000bb9eb,
 		.mask   = 0x000fffff,
 	},
-	{ 0, 0},
+	{ 0, 0, 0 },
 };
 
 MODULE_DEVICE_TABLE(amba, dynamic_funnel_ids);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b6be73034996..33e3ba4f97fa 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -364,7 +364,7 @@ MODULE_DEVICE_TABLE(of, static_replicator_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_replicator_acpi_ids[] = {
-	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+	{"ARMHC985", 0, 0, 0}, /* ARM CoreSight Static Replicator */
 	{}
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index a1c27c901ad1..891ee64efed8 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -950,7 +950,7 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
 static const struct amba_id stm_ids[] = {
 	CS_AMBA_ID_DATA(0x000bb962, "STM32"),
 	CS_AMBA_ID_DATA(0x000bb963, "STM500"),
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, stm_ids);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7ec5365e2b64..39bae35d4ffd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -594,7 +594,7 @@ static const struct amba_id tmc_ids[] = {
 	CS_AMBA_ID(0x000bb9e9),
 	/* Coresight SoC 600 TMC-ETF */
 	CS_AMBA_ID(0x000bb9ea),
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, tmc_ids);
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 5f82737c37bb..4ac954f4bc13 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -300,7 +300,7 @@ static struct amba_id tpda_ids[] = {
 		.id     = 0x000f0f00,
 		.mask   = 0x000fff00,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 static struct amba_driver tpda_driver = {
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 97654aa4b772..1a8735fa0a19 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -933,7 +933,7 @@ static struct amba_id tpdm_ids[] = {
 		.id = 0x000f0e00,
 		.mask = 0x000fff00,
 	},
-	{ 0, 0},
+	{ 0, 0, 0 },
 };
 
 static struct amba_driver tpdm_driver = {
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59eac93fd6bb..7e69048ac944 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -218,7 +218,7 @@ static const struct amba_id tpiu_ids[] = {
 		.id	= 0x000bb9e7,
 		.mask	= 0x000fffff,
 	},
-	{ 0, 0},
+	{ 0, 0, NULL },
 };
 
 MODULE_DEVICE_TABLE(amba, tpiu_ids);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index e9a32a97fbee..83f5eea1302f 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -626,7 +626,7 @@ static int smb_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
-	{"HISI03A1", 0},
+	{"HISI03A1", 0, 0, 0},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
-- 
2.34.1

