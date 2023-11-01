Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3D7DDF08
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKAKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjKAKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:08:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF1D4E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:08:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E5DC433C7;
        Wed,  1 Nov 2023 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698833294;
        bh=+y2U+/CSdO5rFqbvib/QFg2QAHsmQMTqiF0vq4cB0+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGvQqihqH2DdL/DWl5Gm0/nS2ZKbHlIkEWiJEvl/ttg69LgUlP0CBxyKKXG4rzgBN
         Sr5AVOusdwBB0tzrx/F2jXJm1XhP1fbknE8ex219cfpL2aIoc8Tg31x6APqGrADTKw
         S8ehuGOoRIa9y8iljW+6Q5ru7gygqSYV1ytzGLx9v08mxPtYSDC08pKLD1FCqcJ67k
         uGs0XuKZBoRcM3btbFMRWTYJSdfMOdMXW+bCa/+9l7/quCkP8M4XQObegFdn2X5XSZ
         3jTfQ28wzchmgRc0qJt4p0nAxMf/GcZQKzjTo2EcQFREhJGZloIAR+4JgOty0NdlA1
         l1i6Ne870SPag==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/2] accel/habanalabs: update device boot error check
Date:   Wed,  1 Nov 2023 12:08:05 +0200
Message-Id: <20231101100805.596657-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101100805.596657-1-ogabbay@kernel.org>
References: <20231101100805.596657-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Farah Kassabri <fkassabri@habana.ai>

Use a predefined mask which set the device critical boot errors.
Driver will fail and stop its loading, only upon detecting at least
one of those errors defined in this mask.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 122 +++++-------------
 1 file changed, 34 insertions(+), 88 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index 47e8384134aa..ec04234e18a5 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -646,39 +646,27 @@ int hl_fw_send_heartbeat(struct hl_device *hdev)
 	return rc;
 }
 
-static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
-								u32 sts_val)
+static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val, u32 sts_val)
 {
 	bool err_exists = false;
 
 	if (!(err_val & CPU_BOOT_ERR0_ENABLED))
 		return false;
 
-	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL) {
-		dev_err(hdev->dev,
-			"Device boot error - DRAM initialization failed\n");
-		err_exists = true;
-	}
+	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL)
+		dev_err(hdev->dev, "Device boot error - DRAM initialization failed\n");
 
-	if (err_val & CPU_BOOT_ERR0_FIT_CORRUPTED) {
+	if (err_val & CPU_BOOT_ERR0_FIT_CORRUPTED)
 		dev_err(hdev->dev, "Device boot error - FIT image corrupted\n");
-		err_exists = true;
-	}
 
-	if (err_val & CPU_BOOT_ERR0_TS_INIT_FAIL) {
-		dev_err(hdev->dev,
-			"Device boot error - Thermal Sensor initialization failed\n");
-		err_exists = true;
-	}
+	if (err_val & CPU_BOOT_ERR0_TS_INIT_FAIL)
+		dev_err(hdev->dev, "Device boot error - Thermal Sensor initialization failed\n");
 
 	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED) {
 		if (hdev->bmc_enable) {
-			dev_err(hdev->dev,
-				"Device boot error - Skipped waiting for BMC\n");
-			err_exists = true;
+			dev_err(hdev->dev, "Device boot error - Skipped waiting for BMC\n");
 		} else {
-			dev_info(hdev->dev,
-				"Device boot message - Skipped waiting for BMC\n");
+			dev_info(hdev->dev, "Device boot message - Skipped waiting for BMC\n");
 			/* This is an info so we don't want it to disable the
 			 * device
 			 */
@@ -686,101 +674,59 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		}
 	}
 
-	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY) {
-		dev_err(hdev->dev,
-			"Device boot error - Serdes data from BMC not available\n");
-		err_exists = true;
-	}
+	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY)
+		dev_err(hdev->dev, "Device boot error - Serdes data from BMC not available\n");
 
-	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL) {
-		dev_err(hdev->dev,
-			"Device boot error - NIC F/W initialization failed\n");
-		err_exists = true;
-	}
+	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
+		dev_err(hdev->dev, "Device boot error - NIC F/W initialization failed\n");
 
-	if (err_val & CPU_BOOT_ERR0_SECURITY_NOT_RDY) {
-		dev_err(hdev->dev,
-			"Device boot warning - security not ready\n");
-		err_exists = true;
-	}
+	if (err_val & CPU_BOOT_ERR0_SECURITY_NOT_RDY)
+		dev_err(hdev->dev, "Device boot warning - security not ready\n");
 
-	if (err_val & CPU_BOOT_ERR0_SECURITY_FAIL) {
+	if (err_val & CPU_BOOT_ERR0_SECURITY_FAIL)
 		dev_err(hdev->dev, "Device boot error - security failure\n");
-		err_exists = true;
-	}
 
-	if (err_val & CPU_BOOT_ERR0_EFUSE_FAIL) {
+	if (err_val & CPU_BOOT_ERR0_EFUSE_FAIL)
 		dev_err(hdev->dev, "Device boot error - eFuse failure\n");
-		err_exists = true;
-	}
 
-	if (err_val & CPU_BOOT_ERR0_SEC_IMG_VER_FAIL) {
+	if (err_val & CPU_BOOT_ERR0_SEC_IMG_VER_FAIL)
 		dev_err(hdev->dev, "Device boot error - Failed to load preboot secondary image\n");
-		err_exists = true;
-	}
 
-	if (err_val & CPU_BOOT_ERR0_PLL_FAIL) {
+	if (err_val & CPU_BOOT_ERR0_PLL_FAIL)
 		dev_err(hdev->dev, "Device boot error - PLL failure\n");
-		err_exists = true;
-	}
 
-	if (err_val & CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL) {
+	if (err_val & CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL)
 		dev_err(hdev->dev, "Device boot error - Failed to set threshold for temperature sensor\n");
-		err_exists = true;
-	}
 
-	if (err_val & CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL) {
-		/* Ignore this bit, don't prevent driver loading */
-		dev_dbg(hdev->dev, "device unusable status is set\n");
-		err_val &= ~CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL;
-	}
+	if (err_val & CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL)
+		dev_err(hdev->dev, "device unusable status is set\n");
 
-	if (err_val & CPU_BOOT_ERR0_BINNING_FAIL) {
+	if (err_val & CPU_BOOT_ERR0_BINNING_FAIL)
 		dev_err(hdev->dev, "Device boot error - binning failure\n");
-		err_exists = true;
-	}
 
 	if (sts_val & CPU_BOOT_DEV_STS0_ENABLED)
 		dev_dbg(hdev->dev, "Device status0 %#x\n", sts_val);
 
+	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED)
+		dev_err(hdev->dev, "Device boot warning - Skipped DRAM initialization\n");
+
+	if (err_val & CPU_BOOT_ERR_ENG_ARC_MEM_SCRUB_FAIL)
+		dev_err(hdev->dev, "Device boot error - ARC memory scrub failed\n");
+
+	/* All warnings should go here in order not to reach the unknown error validation */
 	if (err_val & CPU_BOOT_ERR0_EEPROM_FAIL) {
 		dev_err(hdev->dev, "Device boot error - EEPROM failure detected\n");
 		err_exists = true;
 	}
 
-	/* All warnings should go here in order not to reach the unknown error validation */
-	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED) {
-		dev_warn(hdev->dev,
-			"Device boot warning - Skipped DRAM initialization\n");
-		/* This is a warning so we don't want it to disable the
-		 * device
-		 */
-		err_val &= ~CPU_BOOT_ERR0_DRAM_SKIPPED;
-	}
-
-	if (err_val & CPU_BOOT_ERR0_PRI_IMG_VER_FAIL) {
-		dev_warn(hdev->dev,
-			"Device boot warning - Failed to load preboot primary image\n");
-		/* This is a warning so we don't want it to disable the
-		 * device as we have a secondary preboot image
-		 */
-		err_val &= ~CPU_BOOT_ERR0_PRI_IMG_VER_FAIL;
-	}
+	if (err_val & CPU_BOOT_ERR0_PRI_IMG_VER_FAIL)
+		dev_warn(hdev->dev, "Device boot warning - Failed to load preboot primary image\n");
 
-	if (err_val & CPU_BOOT_ERR0_TPM_FAIL) {
-		dev_warn(hdev->dev,
-			"Device boot warning - TPM failure\n");
-		/* This is a warning so we don't want it to disable the
-		 * device
-		 */
-		err_val &= ~CPU_BOOT_ERR0_TPM_FAIL;
-	}
+	if (err_val & CPU_BOOT_ERR0_TPM_FAIL)
+		dev_warn(hdev->dev, "Device boot warning - TPM failure\n");
 
-	if (!err_exists && (err_val & ~CPU_BOOT_ERR0_ENABLED)) {
-		dev_err(hdev->dev,
-			"Device boot error - unknown ERR0 error 0x%08x\n", err_val);
+	if (err_val & CPU_BOOT_ERR_FATAL_MASK)
 		err_exists = true;
-	}
 
 	/* return error only if it's in the predefined mask */
 	if (err_exists && ((err_val & ~CPU_BOOT_ERR0_ENABLED) &
-- 
2.34.1

