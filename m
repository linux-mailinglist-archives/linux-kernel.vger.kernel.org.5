Return-Path: <linux-kernel+bounces-25626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A182D3C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ADF28171B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE623C5;
	Mon, 15 Jan 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XvTh11TF"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281717CF;
	Mon, 15 Jan 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 090B03F722;
	Mon, 15 Jan 2024 04:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705294302;
	bh=/h0ueumzQRHlEhJDa988fwbrKEXZ/2rrzQgvraRlQ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=XvTh11TFw0EDTwDxRedeNeFkn2S20dhKqZYkET3YbEsT0Im3PVCgGfK1t4sIYpbCW
	 UFcIPZwX9gWN250kSEvp1DtvkOz9D2aRJ9q0q2WLZnrgdNMYlej0bVjm3JSRGoeNCY
	 QctqYkRWuV41PjSo07wbOt6AgW4iHQkKudSe7yQc4qaav44S3i18RLN8tmpcO5hzTl
	 MzLYWkJK0IHaJBo4RTjdb5as1v3idXBFC5Y+tcW7IJakerky6EP3XaaDqrVuSoUcEF
	 zRhC5H+Y7BOQY1wek1WE7Qa1kDMW5aiuTf1wbG7BaR+NWmhCd5+26/BtcRRsdEzdtA
	 x/h+Hy9hS+2qA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: i2c-hid: Skip SET_POWER SLEEP for Cirque touchpad on system suspend
Date: Mon, 15 Jan 2024 12:50:51 +0800
Message-Id: <20240115045054.1170294-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a Cirque touchpad that wakes system up without anything touched
the touchpad. The input report is empty when this happens.
The reason is stated in HID over I2C spec, 7.2.8.2:
"If the DEVICE wishes to wake the HOST from its low power state, it can
issue a wake by asserting the interrupt."

This is fine if OS can put system back to suspend by identifying input
wakeup count stays the same on resume, like Chrome OS Dark Resume [0].
But for regular distro such policy is lacking.

Though the change doesn't bring any impact on power consumption for
touchpad is minimal, other i2c-hid device may depends on SLEEP control
power. So use a quirk to limit the change scope.

[0] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_manager/docs/dark_resume.md

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use quirk instead of applying the change universally.

 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index fb30e228d35f..828a5c022c64 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -298,6 +298,9 @@
 
 #define USB_VENDOR_ID_CIDC		0x1677
 
+#define I2C_VENDOR_ID_CIRQUE           0x0488
+#define I2C_PRODUCT_ID_CIRQUE_1063     0x1063
+
 #define USB_VENDOR_ID_CJTOUCH		0x24b8
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040	0x0040
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90f316ae9819..2df1ab3c31cc 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -49,6 +49,7 @@
 #define I2C_HID_QUIRK_RESET_ON_RESUME		BIT(2)
 #define I2C_HID_QUIRK_BAD_INPUT_SIZE		BIT(3)
 #define I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET	BIT(4)
+#define I2C_HID_QUIRK_NO_SLEEP_ON_SUSPEND	BIT(5)
 
 /* Command opcodes */
 #define I2C_HID_OPCODE_RESET			0x01
@@ -131,6 +132,8 @@ static const struct i2c_hid_quirks {
 		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
+	{ I2C_VENDOR_ID_CIRQUE, I2C_PRODUCT_ID_CIRQUE_1063,
+		I2C_HID_QUIRK_NO_SLEEP_ON_SUSPEND },
 	/*
 	 * Sending the wakeup after reset actually break ELAN touchscreen controller
 	 */
@@ -956,7 +959,8 @@ static int i2c_hid_core_suspend(struct i2c_hid *ihid, bool force_poweroff)
 		return ret;
 
 	/* Save some power */
-	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
+	if (!(ihid->quirks & I2C_HID_QUIRK_NO_SLEEP_ON_SUSPEND))
+		i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
 
 	disable_irq(client->irq);
 
-- 
2.34.1


