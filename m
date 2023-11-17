Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C047EF051
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjKQK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjKQK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:28:26 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65FD49
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:28:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CAE89240002;
        Fri, 17 Nov 2023 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700216899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hssYZxQ7oYF62vZivWNVQkuQ1Tob1SL3kJykunvJ4/0=;
        b=OojY2ahINfBpf0qydeGz+bModeIomJL0J4gdEXqwOR1DsOnBHPiIYI0KVvFUejAunfsP80
        zJXmFqNOKAZG2Bei5aTGSIChuBwW3qQKRj/REPrcRrdB3mZHqM8OPTJeNBSoA6QS6AnPBr
        zOctfr0ClJRANXoKsGTHeez5FNXau/+7W0nXD83Eyv6tC6bOw9vk3sLLin1eVFM2LKBfkP
        MvWCTSf1Oxe4vNoOSDlf8Oxb7qj+SUNIN2SO/FdzkdzpnzZA0vlyYRDfkK6a+2P8YVuKLv
        T6bdW4t1azyXiEaNtwpwLnTa4Eg6fvO1sUWtL4phXmhZ/VFu0vRfuyizAyRjqw==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Fri, 17 Nov 2023 11:27:53 +0100
Subject: [PATCH] firmware_loader: Expand Firmware upload error codes with
 firmware invalid error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAChAV2UC/x3MQQqDMBBG4avIrBswdmHwKkVkNP+0s9CUidWCe
 HeDu/dt3kEZpsjUVQcZNs2algL/qGj68PKG01hMTd08vfetE/D6MwyiNu9cAmbJhilFuDHElqU
 OHARUDl+D6P++v/rzvAA6CmJwbQAAAA==
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No error code are available to signal an invalid firmware content.
Drivers that can check the firmware content validity can not return this
specific failure to the user-space

Expand the firmware error code with an additional code:
- "firmware invalid" code which can be used when the provided firmware
  is invalid

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This patch was initially submitted as part of a net patch series.
Conor expressed interest in using it in a different subsystem.
Consequently, I extracted it from the series and submitted it separately
to the main tree, driver-core.
https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf249@bootlin.com/
---
 drivers/base/firmware_loader/sysfs_upload.c | 1 +
 include/linux/firmware.h                    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index a0af8f5f13d8..829270067d16 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -27,6 +27,7 @@ static const char * const fw_upload_err_str[] = {
 	[FW_UPLOAD_ERR_INVALID_SIZE] = "invalid-file-size",
 	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
 	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
+	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
 };
 
 static const char *fw_upload_progress(struct device *dev,
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index de7fea3bca51..0311858b46ce 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -27,6 +27,7 @@ struct firmware {
  * @FW_UPLOAD_ERR_INVALID_SIZE: invalid firmware image size
  * @FW_UPLOAD_ERR_RW_ERROR: read or write to HW failed, see kernel log
  * @FW_UPLOAD_ERR_WEAROUT: FLASH device is approaching wear-out, wait & retry
+ * @FW_UPLOAD_ERR_FW_INVALID: invalid firmware file
  * @FW_UPLOAD_ERR_MAX: Maximum error code marker
  */
 enum fw_upload_err {
@@ -38,6 +39,7 @@ enum fw_upload_err {
 	FW_UPLOAD_ERR_INVALID_SIZE,
 	FW_UPLOAD_ERR_RW_ERROR,
 	FW_UPLOAD_ERR_WEAROUT,
+	FW_UPLOAD_ERR_FW_INVALID,
 	FW_UPLOAD_ERR_MAX
 };
 

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-feature_firmware_error_code-b8d7af08a8fe

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

