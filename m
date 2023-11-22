Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EFE7F483E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjKVNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKVNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:52:51 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0D19D;
        Wed, 22 Nov 2023 05:52:46 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBEF220005;
        Wed, 22 Nov 2023 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700661165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5DfjWpEKJ3KT08ABWOZKh8cLOfg3oBu9fPbcsszXf1o=;
        b=lDL1Cb1piMbpyf+9ZogEnOpPrKPH1oC/ubPVxPREMfvMvSSfSNv81uGMfL+UeSThHFIYdT
        yIC5rOuC9XsarVtbhJZwZDSxCvBmiJMuvgLL8l/TZMZ5JIgZrwYHnfJHY+0GLHENF5ZRj8
        rcwTXA7wz6b1B58yMcVG7pwPVMnoFqPEPWO9uVo/2YdKwi1YXIJuvqvx/VxI9HX4igvsGh
        LBQRVQTsmgOPWt0QUJMVpv16A3UeBeopHvaQXnoPWjaLS7VneKsHHRIgwgMq3g0nOob+vN
        E52WKwDMsbVqzqT0D7noXpKJt43yownKHC0u/qB3j3VNJrV6Xyiq/En5RnTzGg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 22 Nov 2023 14:52:43 +0100
Subject: [PATCH net-next v3] firmware_loader: Expand Firmware upload error
 codes with firmware invalid error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKoHXmUC/43N0QrCIBgF4FcZXmdMXei66j0ihnO/TWgav7YWY
 ++eeFU30d05HPjOSiKgg0iO1UoQZhdd8LmIXUXMqP0VqBtyJ7zmgjEmqQWdHgiddTg9dQ6AGLA
 zYQDaq0FqWyutLJAs3BGsW4p+Jh4S9bAkcsnL6GIK+Cq3Myv7Xw8zo4y23LRS6EOtGnnqQ0g35
 /cmTEWe+YfG2W+NZ80q2WopRaMb+Na2bXsDFoUY+SABAAA=
To:     Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Sync lib/test_firmware.c file accordingly.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Add the newly introduced error code to test_firmware.c

This patch was initially submitted as part of a net patch series.
Conor expressed interest in using it in a different subsystem.
https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf249@bootlin.com/

Consequently, I extracted it from the series and submitted it separately.
I first tried to send it to driver-core but it seems also not the best
choice:
https://lore.kernel.org/lkml/2023111720-slicer-exes-7d9f@gregkh/

Jakub could you create a stable branch for this patch and share the branch
information? This way other Maintainers can then pull the patch.
---
 drivers/base/firmware_loader/sysfs_upload.c | 1 +
 include/linux/firmware.h                    | 2 ++
 lib/test_firmware.c                         | 1 +
 3 files changed, 4 insertions(+)

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
 
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index add4699fc6cd..9cfdcd6d21db 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1132,6 +1132,7 @@ static const char * const fw_upload_err_str[] = {
 	[FW_UPLOAD_ERR_INVALID_SIZE] = "invalid-file-size",
 	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
 	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
+	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
 };
 
 static void upload_err_inject_error(struct test_firmware_upload *tst,

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-feature_firmware_error_code-b8d7af08a8fe

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

