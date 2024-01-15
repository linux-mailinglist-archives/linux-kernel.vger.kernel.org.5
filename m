Return-Path: <linux-kernel+bounces-26141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7183382DBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811D11C21C51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BE18EBB;
	Mon, 15 Jan 2024 14:49:03 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F717C70;
	Mon, 15 Jan 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id AB9F0101653;
	Mon, 15 Jan 2024 14:48:57 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 6/7] HID: playstation: Simplify device type ID
Date: Mon, 15 Jan 2024 23:45:37 +0900
Message-Id: <20240115144538.12018-7-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115144538.12018-1-max@enpas.org>
References: <20240115144538.12018-1-max@enpas.org>
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
index 086b0768fa51..a0eb36d695d9 100644
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
@@ -2690,17 +2695,14 @@ static int ps_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -2734,16 +2736,26 @@ static void ps_remove(struct hid_device *hdev)
 
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


