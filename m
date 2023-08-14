Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78C677BE47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHNQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjHNQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C6110;
        Mon, 14 Aug 2023 09:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A7363180;
        Mon, 14 Aug 2023 16:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F34C433C8;
        Mon, 14 Aug 2023 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692031260;
        bh=sGWBLCcKeaeGw2QE6nrh9AHpg6JP2tE+q6ulpJ2Ul2A=;
        h=From:To:Cc:Subject:Date:From;
        b=GhN5dR7uNn+jKw3+7bsjBMVuUixNzw6uTJc2rrReQq/HwfJ0tlVOSo0zxN48+17zs
         0z72diCYB0eHtnYp7yviLPNqVAKkmiNzSgwXJxniezf7/fsMvLVMHbcHT29E1Se8EE
         gEXoElibfpkbPOArNxGX8nNrIm2XF6Er22tcUfWJgvFKVnKRCjMsTJ4lEkY3cpuvQG
         klnBRrz+3hxQvhXqF1Lg5OigDffqx9SP7/ZHqUA1YoOa/ZTEOUtgR7M3zBYpOTgVxu
         cwaFbcYv8qkXK9zS8jHQ5SIlMM31wCBdSRj6Tc25RHfvkgvFFrtiiGlOBXklH9fUf+
         t0Duu4aRQ7NjA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Richard Cochran <richardcochran@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] tpm_tis: Revert "tpm_tis: Disable interrupts on ThinkPad T490s"
Date:   Mon, 14 Aug 2023 19:40:53 +0300
Message-Id: <20230814164054.64280-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for MMIO driver using FIFO registers, also known as tpm_tis, the
default (and tbh recommended) behaviour is now the polling mode, the
"tristate" workaround is no longer for benefit.

If someone wants to explicitly enable IRQs for a TPM chip that should be
without question allowed. It could very well be a piece hardware in the
existing deny list because of e.g. firmware update or something similar.

While at it, document the module parameter, as this was not done in 2006
when it first appeared in the mainline.

Link: https://lore.kernel.org/linux-integrity/20201015214430.17937-1-jsnitsel@redhat.com/
Link: https://lore.kernel.org/all/1145393776.4829.19.camel@localhost.localdomain/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 drivers/char/tpm/tpm_tis.c                    | 93 +------------------
 2 files changed, 9 insertions(+), 91 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 722b6eca2e93..6354aa779178 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6340,6 +6340,13 @@
 			This will guarantee that all the other pcrs
 			are saved.
 
+	tpm_tis.interrupts= [HW,TPM]
+			Enable interrupts for the MMIO based physical layer
+			for the FIFO interface. By default it is set to false
+			(0). For more information about TPM hardware interfaces
+			defined by Trusted Computing Group (TCG) look up to
+			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+
 	tp_printk	[FTRACE]
 			Have the tracepoints sent to printk as well as the
 			tracing ring buffer. This is useful for early boot up
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7fa3d91042b2..077fdb73740c 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -27,7 +27,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/kernel.h>
-#include <linux/dmi.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
@@ -89,8 +88,8 @@ static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
 	tpm_tis_flush(iobase);
 }
 
-static int interrupts;
-module_param(interrupts, int, 0444);
+static bool interrupts;
+module_param(interrupts, bool, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
 
 static bool itpm;
@@ -103,92 +102,6 @@ module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
 #endif
 
-static int tpm_tis_disable_irq(const struct dmi_system_id *d)
-{
-	if (interrupts == -1) {
-		pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d->ident);
-		interrupts = 0;
-	}
-
-	return 0;
-}
-
-static const struct dmi_system_id tpm_tis_dmi_table[] = {
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "Framework Laptop (12th Gen Intel Core)",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (12th Gen Intel Core)"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "Framework Laptop (13th Gen Intel Core)",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad T490s",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkStation P360 Tiny",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad L490",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad L590",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkStation P620",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "TUXEDO InfinityBook S 15/17 Gen7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "UPX-TGL",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
-		},
-	},
-	{}
-};
-
 #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
 static int has_hid(struct acpi_device *dev, const char *hid)
 {
@@ -312,8 +225,6 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 	int irq = -1;
 	int rc;
 
-	dmi_check_system(tpm_tis_dmi_table);
-
 	rc = check_acpi_tpm2(dev);
 	if (rc)
 		return rc;
-- 
2.39.2

