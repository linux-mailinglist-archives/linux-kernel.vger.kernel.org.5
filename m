Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA267897B7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjHZPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHZPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:25:25 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E319A0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:25:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 3B5C51014E9;
        Sat, 26 Aug 2023 15:25:16 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Vicki Pfau <vi@endrift.com>, Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Subject: [PATCH 1/2] xpad: XTYPE_XBOX: Report analog buttons
Date:   Sun, 27 Aug 2023 00:21:10 +0900
Message-Id: <20230826152111.13525-2-max@enpas.org>
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

The original Xbox controllers (XTYPE_XBOX) report 8 buttons in an analog
fashion, in addition to the digital on/off state:

 - Action buttons A/B/X/Y/black/white
 - Triggers L/R

Up until now, only the triggers L/R are reported as values 0-255. The
other pressure sensitive buttons are reported as digital buttons, as
found on other controllers.

This change exposes these buttons as axes in a way that is as backwards
compatible as possible.
The new axes are merely added, and numbered after any existing axes.
This way, libraries like SDL which renumber axes in enumeration order,
can keep their button/axis mapping as-is. Userspace can keep working as
before, and can optionally use the new values when handling this type of
gamepad.

 - BTN_A..BTN_Z mapped to ABS_MISC+0..ABS_MISC+5, 0 to 255

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/input/joystick/xpad.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cdb193317c3b..609c06f795de 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -420,6 +420,14 @@ static const signed short xpad_abs_triggers[] = {
 	-1
 };
 
+/* used for analog face buttons mapped to axes */
+static const signed short xpad_abs_analog_face_buttons[] = {
+	ABS_MISC + 0, ABS_MISC + 1, /* A, B */
+	ABS_MISC + 3, ABS_MISC + 4, /* X, Y */
+	ABS_MISC + 2, ABS_MISC + 5, /* C, Z */
+	-1
+};
+
 /* used when the controller has extra paddle buttons */
 static const signed short xpad_btn_paddles[] = {
 	BTN_TRIGGER_HAPPY5, BTN_TRIGGER_HAPPY6, /* paddle upper right, lower right */
@@ -784,6 +792,15 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 	input_report_key(dev, BTN_C, data[8]);
 	input_report_key(dev, BTN_Z, data[9]);
 
+	/* analog buttons A, B, X, Y as axes */
+	input_report_abs(dev, xpad_abs_analog_face_buttons[0], data[4]); /* A */
+	input_report_abs(dev, xpad_abs_analog_face_buttons[1], data[5]); /* B */
+	input_report_abs(dev, xpad_abs_analog_face_buttons[2], data[6]); /* X */
+	input_report_abs(dev, xpad_abs_analog_face_buttons[3], data[7]); /* Y */
+
+	/* analog buttons black, white (C, Z) as axes */
+	input_report_abs(dev, xpad_abs_analog_face_buttons[4], data[8]); /* C */
+	input_report_abs(dev, xpad_abs_analog_face_buttons[5], data[9]); /* Z */
 
 	input_sync(dev);
 }
@@ -1827,6 +1844,14 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
+	case ABS_MISC + 0:
+	case ABS_MISC + 1:
+	case ABS_MISC + 2:
+	case ABS_MISC + 3:
+	case ABS_MISC + 4:
+	case ABS_MISC + 5:
+		input_set_abs_params(input_dev, abs, 0, 255, 0, 0);
+		break;
 	case ABS_PROFILE: /* 4 value profile button (such as on XAC) */
 		input_set_abs_params(input_dev, abs, 0, 4, 0, 0);
 		break;
@@ -1928,6 +1953,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+	if (xpad->xtype == XTYPE_XBOX)
+		for (i = 0; xpad_abs_analog_face_buttons[i] >= 0; i++)
+			xpad_set_up_abs(input_dev, xpad_abs_analog_face_buttons[i]);
+
 	/* setup profile button as an axis with 4 possible values */
 	if (xpad->mapping & MAP_PROFILE_BUTTON)
 		xpad_set_up_abs(input_dev, ABS_PROFILE);
-- 
2.39.2

