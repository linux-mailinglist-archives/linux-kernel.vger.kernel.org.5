Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE977E924C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKLTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:43:47 -0500
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611791BFF;
        Sun, 12 Nov 2023 11:43:42 -0800 (PST)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id A225B86A13;
        Sun, 12 Nov 2023 20:43:39 +0100 (CET)
From:   =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: touchscreen: imagis: Add touch key support
Date:   Sun, 12 Nov 2023 20:41:24 +0100
Message-ID: <20231112194124.24916-1-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IST3032C (and possibly some other models) has touch keys. Add support
for them to the imagis driver.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
This patch depends on the series generalizing the driver and adding IST3032C
support: https://lore.kernel.org/all/20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz/
---
 drivers/input/touchscreen/imagis.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 41f28e6e9cb1..5a54ce291655 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -30,6 +30,7 @@
 #define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
 #define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
+#define IST3032C_KEY_STATUS_MASK	GENMASK(20, 16)
 
 #define IST3038B_REG_STATUS		0x20
 #define IST3038B_REG_CHIPID		0x30
@@ -43,6 +44,7 @@ struct imagis_properties {
 	unsigned int whoami_cmd;
 	unsigned int whoami_val;
 	bool protocol_b;
+	bool touch_keys_supported;
 };
 
 struct imagis_ts {
@@ -95,7 +97,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 {
 	struct imagis_ts *ts = dev_id;
 	u32 intr_message, finger_status;
-	unsigned int finger_count, finger_pressed;
+	unsigned int finger_count, finger_pressed, key_pressed;
 	int i;
 	int error;
 
@@ -144,6 +146,11 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 					IST3038C_AREA_SHIFT);
 	}
 
+	key_pressed = FIELD_GET(IST3032C_KEY_STATUS_MASK, intr_message);
+
+	input_report_key(ts->input_dev, KEY_APPSELECT, (key_pressed & BIT(0)));
+	input_report_key(ts->input_dev, KEY_BACK, (key_pressed & BIT(1)));
+
 	input_mt_sync_frame(ts->input_dev);
 	input_sync(ts->input_dev);
 
@@ -229,6 +236,10 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
+	if (ts->tdata->touch_keys_supported) {
+		input_set_capability(input_dev, EV_KEY, KEY_BACK);
+		input_set_capability(input_dev, EV_KEY, KEY_APPSELECT);
+	}
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
@@ -370,6 +381,7 @@ static const struct imagis_properties imagis_3032c_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3032C_WHOAMI,
+	.touch_keys_supported = true,
 };
 
 static const struct imagis_properties imagis_3038b_data = {
-- 
2.42.1


