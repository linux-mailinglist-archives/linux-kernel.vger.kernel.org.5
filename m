Return-Path: <linux-kernel+bounces-56779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2379384CF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24C12856D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557B82C88;
	Wed,  7 Feb 2024 16:37:42 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1881AD4;
	Wed,  7 Feb 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323862; cv=none; b=lsgA6ji51vbOQ41K0RLVnTFCnC/MCqQGnlCdPhUCcghMof2nTpPgUBgCfYHfl7tgwptbagEfEXjJKj7L0HizGySCxVVrJdC2Jmrr6Cj+k3SyVwhFM34uL70IprlkPYe5lbQUY0jcd+Zo6EN+NPbZDY/IAVm0nrOR6A0LnNEMQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323862; c=relaxed/simple;
	bh=6ibKIqdKNK6p4jvhKmJBITPzh/ZNI0jwLkDjKmkAYQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JD718r7I+pwTZ1I6RaIEJZnoSzRwRDFGKCvR5OXDBBq+7kG4f34zACfNRGYvLTy3Xwy6FriKxN0ME+MGF3rHZ91gkP5HDTcJqfOYkWt8FF0hsYw8FXHBSWRgDBt1Ia+BWczYXclB0gD+ijmtCzWfPksvF2e1AbB55yY6lOzedhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id EC8F2100BC6;
	Wed,  7 Feb 2024 16:37:36 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v2 4/5] HID: playstation: DS4: Parse minimal report 0x01
Date: Thu,  8 Feb 2024 01:36:46 +0900
Message-Id: <20240207163647.15792-5-max@enpas.org>
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

Some third-party controllers never switch to the full 0x11 report.

They keep sending the short 0x01 report, so let's parse that instead.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 53bfc2828a61..6b0f25688657 100644
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
@@ -2196,6 +2198,7 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 	int battery_status, i, j;
 	uint16_t sensor_timestamp;
 	unsigned long flags;
+	bool is_minimal = false;
 
 	/*
 	 * DualShock4 in USB uses the full HID report for reportID 1, but
@@ -2223,6 +2226,18 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
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
@@ -2256,6 +2271,9 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 	input_report_key(ds4->gamepad, BTN_MODE,   ds4_report->buttons[2] & DS_BUTTONS2_PS_HOME);
 	input_sync(ds4->gamepad);
 
+	if (is_minimal)
+		return 0;
+
 	/* Parse and calibrate gyroscope data. */
 	for (i = 0; i < ARRAY_SIZE(ds4_report->gyro); i++) {
 		int raw_data = (short)le16_to_cpu(ds4_report->gyro[i]);
-- 
2.39.2


