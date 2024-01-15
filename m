Return-Path: <linux-kernel+bounces-26138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511B82DBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BE31F21D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD4517994;
	Mon, 15 Jan 2024 14:48:57 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAB175B5;
	Mon, 15 Jan 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 9F44D101601;
	Mon, 15 Jan 2024 14:48:44 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 1/7] HID: playstation: DS4: Fix LED blinking
Date: Mon, 15 Jan 2024 23:45:32 +0900
Message-Id: <20240115144538.12018-2-max@enpas.org>
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

There was no way to disable blinking once enabled.
Disable it on brightness = 0, as per the Linux LED spec.

The driver reports back the values it sends to the controller, but they
need to be scaled back to milliseconds. Setting the LED blinking via
sysfs works as expected now.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 8ac8f7b8e317..7f50e13601f0 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2037,8 +2037,9 @@ static int dualshock4_led_set_blink(struct led_classdev *led, unsigned long *del
 
 	dualshock4_schedule_work(ds4);
 
-	*delay_on = ds4->lightbar_blink_on;
-	*delay_off = ds4->lightbar_blink_off;
+	/* Report scaled values back to LED subsystem */
+	*delay_on = ds4->lightbar_blink_on * 10;
+	*delay_off = ds4->lightbar_blink_off * 10;
 
 	return 0;
 }
@@ -2065,6 +2066,13 @@ static int dualshock4_led_set_brightness(struct led_classdev *led, enum led_brig
 		break;
 	case 3:
 		ds4->lightbar_enabled = !!value;
+
+		/* brightness = 0 also cancels blinking in Linux. */
+		if (!ds4->lightbar_enabled) {
+			ds4->lightbar_blink_off = 0;
+			ds4->lightbar_blink_on = 0;
+			ds4->update_lightbar_blink = true;
+		}
 	}
 
 	ds4->update_lightbar = true;
-- 
2.39.2


