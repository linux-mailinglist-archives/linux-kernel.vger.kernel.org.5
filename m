Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81BC7897B9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHZPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHZPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:25:28 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF3199F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:25:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id B3E3D101532;
        Sat, 26 Aug 2023 15:25:20 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Vicki Pfau <vi@endrift.com>, Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Subject: [PATCH 2/2] hid-sony: DS3: Report analog buttons for Sixaxis
Date:   Sun, 27 Aug 2023 00:21:11 +0900
Message-Id: <20230826152111.13525-3-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230826152111.13525-1-max@enpas.org>
References: <20230826152111.13525-1-max@enpas.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sixaxis and DualShock 3 controllers report 12 buttons in an analog
fashion, in addition to the digital on/off state:

 - D-Pad up/down/left/right
 - Action buttons Triangle/Circle/Cross/Square
 - L1/R1
 - Triggers L2/R2

Up until now, only the triggers L2/R2 are reported as values 0-255. The
other pressure sensitive buttons are reported as digital buttons, as
found on other controllers.

This change exposes these buttons as axes in a way that is as backwards
compatible and as close to the Linux gamepad spec as possible.
The new axes are merely added, and numbered after any existing axes.
This way, libraries like SDL which renumber axes in enumeration order,
can keep their button/axis mapping as-is. Userspace can keep working as
before, and can optionally use the new values when handling this type of
gamepad.

 - The D-Pad as ABS_HAT0X/ABS_HAT0Y, -255 to 255
 - R1 as ABS_HAT1X, 0 to 255
 - L1 as ABS_HAT1Y, 0 to 255
 - BTN_A..BTN_Z mapped to ABS_MISC+0..ABS_MISC+5, 0 to 255

Most buttons are straight HID remappings in sixaxis_mapping().
For the D-Pad, two pairs of buttons need to be merged to a single axis
each, so this is handled manually in sixaxis_parse_report().

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-sony.c | 66 ++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index dd942061fd77..642fd715ba39 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -484,6 +484,7 @@ struct sony_sc {
 	spinlock_t lock;
 	struct list_head list_node;
 	struct hid_device *hdev;
+	struct input_dev *gamepad;
 	struct input_dev *touchpad;
 	struct input_dev *sensor_dev;
 	struct led_classdev *leds[MAX_LEDS];
@@ -711,22 +712,37 @@ static int sixaxis_mapping(struct hid_device *hdev, struct hid_input *hi,
 	} else if (usage->hid == HID_GD_POINTER) {
 		/* The DS3 provides analog values for most buttons and even
 		 * for HAT axes through GD Pointer. L2 and R2 are reported
-		 * among these as well instead of as GD Z / RZ. Remap L2
-		 * and R2 and ignore other analog 'button axes' as there is
-		 * no good way for reporting them.
+		 * among these as well instead of as GD Z / RZ.
 		 */
+		__u16 c;
+
 		switch (usage->usage_index) {
+		case 10: /* L1 */
+			c = ABS_HAT1Y;
+			break;
+		case 11: /* R1 */
+			c = ABS_HAT1X;
+			break;
+		case 12: /* NORTH */
+		case 13: /* EAST */
+		case 14: /* SOUTH */
+		case 15: /* WEST */
+			c = sixaxis_keymap[usage->usage_index + 1]
+				- BTN_GAMEPAD + ABS_MISC;
+			break;
 		case 8: /* L2 */
 			usage->hid = HID_GD_Z;
+			c = ABS_Z;
 			break;
 		case 9: /* R2 */
 			usage->hid = HID_GD_RZ;
+			c = ABS_RZ;
 			break;
 		default:
 			return -1;
 		}
 
-		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, usage->hid & 0xf);
+		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, c);
 		return 1;
 	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
 		unsigned int abs = usage->hid & HID_USAGE;
@@ -837,6 +853,17 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		val = 511 - ((rd[offset+3] << 8) | rd[offset+2]);
 		input_report_abs(sc->sensor_dev, ABS_Z, val);
 
+		/* Report analog D-pad */
+		if (rd[17] > rd[15])  /* left */
+			input_report_abs(sc->gamepad, ABS_HAT0X, 0 - rd[17]);
+		else  /* right */
+			input_report_abs(sc->gamepad, ABS_HAT0X, rd[15]);
+
+		if (rd[14] > rd[16]) /* up */
+			input_report_abs(sc->gamepad, ABS_HAT0Y, 0 - rd[14]);
+		else /* down */
+			input_report_abs(sc->gamepad, ABS_HAT0Y, rd[16]);
+
 		input_sync(sc->sensor_dev);
 	}
 }
@@ -1597,18 +1624,8 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 
 static int sony_init_ff(struct sony_sc *sc)
 {
-	struct hid_input *hidinput;
-	struct input_dev *input_dev;
-
-	if (list_empty(&sc->hdev->inputs)) {
-		hid_err(sc->hdev, "no inputs found\n");
-		return -ENODEV;
-	}
-	hidinput = list_entry(sc->hdev->inputs.next, struct hid_input, list);
-	input_dev = hidinput->input;
-
-	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
-	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
+	input_set_capability(sc->gamepad, EV_FF, FF_RUMBLE);
+	return input_ff_create_memless(sc->gamepad, NULL, sony_play_effect);
 }
 
 #else
@@ -2039,6 +2056,23 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 	}
 
+	if (sc->quirks & (SONY_FF_SUPPORT | SIXAXIS_CONTROLLER)) {
+		struct hid_input *hidinput;
+
+		if (list_empty(&sc->hdev->inputs)) {
+			hid_err(sc->hdev, "no inputs found\n");
+			return -ENODEV;
+		}
+		hidinput = list_entry(sc->hdev->inputs.next, struct hid_input, list);
+		sc->gamepad = hidinput->input;
+	}
+
+	if (sc->quirks & SIXAXIS_CONTROLLER) {
+		/* Register axes for analog buttons */
+		input_set_abs_params(sc->gamepad, ABS_HAT0X, -255, 255, 0, 0);
+		input_set_abs_params(sc->gamepad, ABS_HAT0Y, -255, 255, 0, 0);
+	}
+
 	if (sc->quirks & SONY_FF_SUPPORT) {
 		ret = sony_init_ff(sc);
 		if (ret < 0)
-- 
2.39.2

