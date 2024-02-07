Return-Path: <linux-kernel+bounces-56781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E388E84CF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0117286920
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0B83CBB;
	Wed,  7 Feb 2024 16:37:45 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD982D6C;
	Wed,  7 Feb 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323864; cv=none; b=rB+YTvR+82XREK8CPXpm1N9RRJ580uKL6YIEkb998tMcl0A1l88LCqeS29SP+xEw4QIG7Mjkzj7CUF++BmK4vA8AWVlra4R9V/LpVkMLmbQwEZAYxS0of5FlZDO/asKHw4gFK+PtOtmZP9H6KIbWKYypcHT6hZzXwIXBrKq+Xc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323864; c=relaxed/simple;
	bh=ht0PP+NQoSopSGNlDo9KrMKWZ0EUv1IshXzKGdpnxi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pt7Ti4GW2G5xD7fGJ34i3jPIswU9581RQEI2QhiJaGFCCN9skFDiiZOUsDhG7TgdhekBiIARr9741D3Vi9fYRr8hkXotjUem69cZQZ5ed8YZ3lZ+Z824hOe8mNvCFLJ8rehj9H2IJAWrOi5AO1RENBGM0fE0ZuQqjdfDx3l45UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 84677100072;
	Wed,  7 Feb 2024 16:37:39 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v2 5/5] HID: playstation: Simplify device type ID
Date: Thu,  8 Feb 2024 01:36:47 +0900
Message-Id: <20240207163647.15792-6-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163647.15792-1-max@enpas.org>
References: <20240207163647.15792-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Distinguish PS4/PS5 type controllers using .driver_data in
MODULE_DEVICE_TABLE rather than by VID/PID.

This allows adding compatible controllers with different VID/PID.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 6b0f25688657..edc46fc02e9a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -27,6 +27,11 @@ static DEFINE_IDA(ps_player_id_allocator);
 
 #define HID_PLAYSTATION_VERSION_PATCH 0x8000
 
+enum PS_TYPE {
+	PS_TYPE_PS4_DUALSHOCK4,
+	PS_TYPE_PS5_DUALSENSE,
+};
+
 /* Base class for playstation devices. */
 struct ps_device {
 	struct list_head list;
@@ -2687,17 +2692,14 @@ static int ps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_stop;
 	}
 
-	if (hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER ||
-		hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_2 ||
-		hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE) {
+	if (id->driver_data == PS_TYPE_PS4_DUALSHOCK4) {
 		dev = dualshock4_create(hdev);
 		if (IS_ERR(dev)) {
 			hid_err(hdev, "Failed to create dualshock4.\n");
 			ret = PTR_ERR(dev);
 			goto err_close;
 		}
-	} else if (hdev->product == USB_DEVICE_ID_SONY_PS5_CONTROLLER ||
-		hdev->product == USB_DEVICE_ID_SONY_PS5_CONTROLLER_2) {
+	} else if (id->driver_data == PS_TYPE_PS5_DUALSENSE) {
 		dev = dualsense_create(hdev);
 		if (IS_ERR(dev)) {
 			hid_err(hdev, "Failed to create dualsense.\n");
@@ -2731,16 +2733,26 @@ static void ps_remove(struct hid_device *hdev)
 
 static const struct hid_device_id ps_devices[] = {
 	/* Sony DualShock 4 controllers for PS4 */
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
+		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
+		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
+		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
+		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE),
+		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
+
 	/* Sony DualSense controllers for PS5 */
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
+		.driver_data = PS_TYPE_PS5_DUALSENSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
+		.driver_data = PS_TYPE_PS5_DUALSENSE },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2),
+		.driver_data = PS_TYPE_PS5_DUALSENSE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2),
+		.driver_data = PS_TYPE_PS5_DUALSENSE },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ps_devices);
-- 
2.39.2


