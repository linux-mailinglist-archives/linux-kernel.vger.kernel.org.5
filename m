Return-Path: <linux-kernel+bounces-26140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F882DBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDABF1F21DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2D117BDD;
	Mon, 15 Jan 2024 14:49:00 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634D17BB2;
	Mon, 15 Jan 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 17DA8101651;
	Mon, 15 Jan 2024 14:48:54 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 5/7] HID: playstation: DS4: Parse minimal report 0x01
Date: Mon, 15 Jan 2024 23:45:36 +0900
Message-Id: <20240115144538.12018-6-max@enpas.org>
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

Some third-party controllers never switch to the full 0x11 report.

They keep sending the short 0x01 report, so let's parse that instead.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 2bf44bd3cc8a..086b0768fa51 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -287,6 +287,8 @@ struct dualsense_output_report {
 
 #define DS4_INPUT_REPORT_USB			0x01
 #define DS4_INPUT_REPORT_USB_SIZE		64
+#define DS4_INPUT_REPORT_BT_MINIMAL		0x01
+#define DS4_INPUT_REPORT_BT_MINIMAL_SIZE	10
 #define DS4_INPUT_REPORT_BT			0x11
 #define DS4_INPUT_REPORT_BT_SIZE		78
 #define DS4_OUTPUT_REPORT_USB			0x05
@@ -2198,6 +2200,7 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 	int battery_status, i, j;
 	uint16_t sensor_timestamp;
 	unsigned long flags;
+	bool is_minimal = false;
 
 	/*
 	 * DualShock4 in USB uses the full HID report for reportID 1, but
@@ -2225,6 +2228,18 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 		ds4_report = &bt->common;
 		num_touch_reports = bt->num_touch_reports;
 		touch_reports = bt->touch_reports;
+	} else if (hdev->bus == BUS_BLUETOOTH &&
+		   report->id == DS4_INPUT_REPORT_BT_MINIMAL &&
+			 size == DS4_INPUT_REPORT_BT_MINIMAL_SIZE) {
+		/* Some third-party pads never switch to the full 0x11 report.
+		 * The short 0x01 report is 10 bytes long:
+		 *   u8 report_id == 0x01
+		 *   u8 first_bytes_of_full_report[9]
+		 * So let's reuse the full report parser, and stop it after
+		 * parsing the buttons.
+		 */
+		ds4_report = (struct dualshock4_input_report_common *)&data[1];
+		is_minimal = true;
 	} else {
 		hid_err(hdev, "Unhandled reportID=%d\n", report->id);
 		return -1;
@@ -2258,6 +2273,9 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 	input_report_key(ds4->gamepad, BTN_MODE,   ds4_report->buttons[2] & DS_BUTTONS2_PS_HOME);
 	input_sync(ds4->gamepad);
 
+	if (is_minimal)
+		goto finish_minimal;
+
 	/* Parse and calibrate gyroscope data. */
 	for (i = 0; i < ARRAY_SIZE(ds4_report->gyro); i++) {
 		int raw_data = (short)le16_to_cpu(ds4_report->gyro[i]);
@@ -2365,6 +2383,7 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 	ps_dev->battery_status = battery_status;
 	spin_unlock_irqrestore(&ps_dev->lock, flags);
 
+finish_minimal:
 	return 0;
 }
 
-- 
2.39.2


