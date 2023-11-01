Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E467DDF09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjKAKIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjKAKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:08:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD018E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:08:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488BFC433C8;
        Wed,  1 Nov 2023 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698833292;
        bh=Pw7Nv8LuVODdBVzdOmKPDbC4v6bStkQt2heq9xRvKtg=;
        h=From:To:Cc:Subject:Date:From;
        b=cROLKlRnyX5+kvNDX34nCWLGkxlFZKa1aq4q9i8bc7xmEXJfXdLaliwzORla07Qz9
         IHR9BK05FWZNnv8oRirYV6FfY60gKX+FeXbQM3R0LBZtf7u4Dsusfh8kJZHzgU32j/
         Adg9rVSR782v90Q84YGQZL+AgE9wRDEabyC2qsBOZ7mJWtjIO4AC9NDsKtOY+Vtpwj
         PFJJArFlS/1KaF6AaHzDAdwYUzsbDBo+dpTpwILyfide8N3Ao7zztewHXBWRTOIi9a
         qr6ChprIp9Qbfu40pRX+WhmXeL/r3xzymx+qcBU1K+b8Xebk9Vssb6BLb4EYxgtxuZ
         6FKIxGAHLzCQA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/2] accel/habanalabs: add pcie reset prepare/done hooks
Date:   Wed,  1 Nov 2023 12:08:04 +0200
Message-Id: <20231101100805.596657-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
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

From: farah kassabri <fkassabri@habana.ai>

When working on a bare-metal system, if FLR will happen the firmware
will handle it and driver will have no knowledge of it, and this will
cause two issues:

1.The driver will be in operational state while it should be in reset.
  This will cause the heartbeat mechanism to keep sending messages to FW
  while pci device is in reset. Eventually heartbeat will fail and
  the device will end up in non-operational state.

2. After FW handles the FLR, and due to the reset it'll go back to
   preboot stage, and driver need to perform hard reset in order to
   load the boot fit binary.

This patch will add reset_prepare hook that will set the device to
be in disabled state, so it'll be not operational, and also
reset_done hook which will be called after the actual FLR handling,
then it will perform hard reset.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../accel/habanalabs/common/habanalabs_drv.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 306a5bc9bf89..35ae0ff347f5 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -670,6 +670,38 @@ static pci_ers_result_t hl_pci_err_slot_reset(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
+static void hl_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct hl_device *hdev;
+
+	hdev = pci_get_drvdata(pdev);
+	if (!hdev)
+		return;
+
+	hdev->disabled = true;
+}
+
+static void hl_pci_reset_done(struct pci_dev *pdev)
+{
+	struct hl_device *hdev;
+	u32 flags;
+
+	hdev = pci_get_drvdata(pdev);
+	if (!hdev)
+		return;
+
+	/*
+	 * Schedule a thread to trigger hard reset.
+	 * The reason for this handler, is for rare cases where the driver is up
+	 * and FLR occurs. This is valid only when working with no VM, so FW handles FLR
+	 * and resets the device. FW will go back preboot stage, so driver needs to perform
+	 * hard reset in order to load FW fit again.
+	 */
+	flags = HL_DRV_RESET_HARD | HL_DRV_RESET_BYPASS_REQ_TO_FW;
+
+	hl_device_reset(hdev, flags);
+}
+
 static const struct dev_pm_ops hl_pm_ops = {
 	.suspend = hl_pmops_suspend,
 	.resume = hl_pmops_resume,
@@ -679,6 +711,8 @@ static const struct pci_error_handlers hl_pci_err_handler = {
 	.error_detected = hl_pci_err_detected,
 	.slot_reset = hl_pci_err_slot_reset,
 	.resume = hl_pci_err_resume,
+	.reset_prepare = hl_pci_reset_prepare,
+	.reset_done = hl_pci_reset_done,
 };
 
 static struct pci_driver hl_pci_driver = {
-- 
2.34.1

