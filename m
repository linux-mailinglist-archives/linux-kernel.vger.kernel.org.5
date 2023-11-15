Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0487EC8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjKOQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjKOQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB2FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E81BC433C9;
        Wed, 15 Nov 2023 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066363;
        bh=hH/MtPMheBE4FRnp6r7JcZVzm3gOuvyKUwNseHulg94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVyduxGw7RGktXNcN7T+SGle97iooX2quLtnli9mnVApOKEa8BtmFwngJ42Km8A32
         jARlxlOP9xx6aSCE5ndmrJWMEYasSv0811arbT+bdmSpDodAnf3PY44FCYS+ok/O3b
         uBsOix7P4nF7OBGQtbnE6JD/7+Nfp+SllJcuYjUzKChNuoO8zis+ifrbTAnDBJczU3
         S1M3V2jTYPkMTsMaKM649uBdQJlMDKMR67tlzwYw6BEHvOpnY/fPVRWGq8/Jm/oOeq
         rR4FIwzNS193Ipxn92zAvkqOBH4Pw+anMtS4zxQ7HaTgkYzunzrrN9VD44/l4PDasM
         PZrGVAHbIGckA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 04/10] accel/habanalabs: fix EQ heartbeat mechanism
Date:   Wed, 15 Nov 2023 18:39:06 +0200
Message-Id: <20231115163912.1243175-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Farah Kassabri <fkassabri@habana.ai>

Stop rescheduling another heartbeat check when EQ heartbeat check fails
as it generates confusing logs in dmesg that the heartbeat fails.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index d9447aeb3937..6bf5f1d0d005 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1044,20 +1044,21 @@ static bool is_pci_link_healthy(struct hl_device *hdev)
 	return (vendor_id == PCI_VENDOR_ID_HABANALABS);
 }
 
-static void hl_device_eq_heartbeat(struct hl_device *hdev)
+static int hl_device_eq_heartbeat_check(struct hl_device *hdev)
 {
-	u64 event_mask = HL_NOTIFIER_EVENT_DEVICE_RESET | HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
 	if (!prop->cpucp_info.eq_health_check_supported)
-		return;
+		return 0;
 
 	if (hdev->eq_heartbeat_received) {
 		hdev->eq_heartbeat_received = false;
 	} else {
 		dev_err(hdev->dev, "EQ heartbeat event was not received!\n");
-		hl_device_cond_reset(hdev, HL_DRV_RESET_HARD, event_mask);
+		return -EIO;
 	}
+
+	return 0;
 }
 
 static void hl_device_heartbeat(struct work_struct *work)
@@ -1074,10 +1075,9 @@ static void hl_device_heartbeat(struct work_struct *work)
 	/*
 	 * For EQ health check need to check if driver received the heartbeat eq event
 	 * in order to validate the eq is working.
+	 * Only if both the EQ is healthy and we managed to send the next heartbeat reschedule.
 	 */
-	hl_device_eq_heartbeat(hdev);
-
-	if (!hdev->asic_funcs->send_heartbeat(hdev))
+	if ((!hl_device_eq_heartbeat_check(hdev)) && (!hdev->asic_funcs->send_heartbeat(hdev)))
 		goto reschedule;
 
 	if (hl_device_operational(hdev, NULL))
-- 
2.34.1

