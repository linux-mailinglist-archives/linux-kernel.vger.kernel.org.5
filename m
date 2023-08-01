Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD776ACFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHAJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjHAJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:24:18 -0400
X-Greylist: delayed 762 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 02:23:23 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3EE103;
        Tue,  1 Aug 2023 02:23:23 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7836342404;
        Tue,  1 Aug 2023 14:09:33 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690880973; bh=yNGffE2xORf7vTs2Y1W53hQMQRyrUgd9ZhG7sX37y4A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hX1plOZNoNSYJ5Tes9r9w+Q/U6cB5DeuWOBj6NBaonWMsBKdPxBjBPNnspPmNgs+x
         e5UtyXZClheTyYeO+gdrQX5tYyArOesq4lX2fw6Inc6GvneEMAisUuwylNh1C0ckNt
         fwZPIiN2bBe5WjN1MnWpJgpOIwGxyjSpUmJGAsKF+Y/uNXXIgDROE3nrQYDlAeoHtm
         yDEaaA2Fmj7ogEpEsdLrtukiaXgImjv08QDZCv9Jmk1RgfmBkUJJbm82s9mmVWI32x
         7FN0e+Bk+D0SoZNCH4cCQKh7odpO8jBIPM8qm2RGN9pm0bpjAd+En3a2DjC5cBIHNk
         P9zisnV7Z9uvA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 01 Aug 2023 14:09:26 +0500
Subject: [PATCH v4 2/2] input: zinitix: Add touchkey support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-zinitix-tkey-v4-2-b85526c5a474@trvn.ru>
References: <20230801-zinitix-tkey-v4-0-b85526c5a474@trvn.ru>
In-Reply-To: <20230801-zinitix-tkey-v4-0-b85526c5a474@trvn.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5056; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=yNGffE2xORf7vTs2Y1W53hQMQRyrUgd9ZhG7sX37y4A=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkyMvLM2Nf8SA/czU3HoTxrDPUJ/IPRby80sAm+
 rJumybz3nSJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMjLywAKCRBDHOzuKBm/
 den8D/4khojf1r+/C8XgSbDvRhAGeqR63FHudPA1/rFI9dJOFGxCHsRRwOUn/E5a0WsltefurHX
 nZ7+wZ01WHndrfUZSHF2WiogfRhvupwPK+8IfQl6igrmOeKovmtVNFQRmd0ZAnzCPYVSdwHmiqD
 6KfOaDngQte2j4mOG0/JvE5BwxWMA4oUPyAge5X6+CQ2NunhjgtcsNFjgClgRxZYdcNbJZxRMS4
 rUkybAPiiteX1VY2D6qtn9j20azMKI9rJhnIag0qlGs32szer8+Smd4FV+AW47u3Ac00cWcp29u
 s75Ctqf/8sf1C8zja9KsY4RcGDP6Pzx02dR+binCR2LY1Lg0uNQ46n1Mtsn+EnD1XhoGF7b8Ves
 VHk18/uJA1mwrVsfOu/9PqIiNOyeoizoRlSSVCeRsWh1fV+A6uXpDJliQNTx+bD6YJvEk3KbUFT
 7EH5ky/dbcZrLt9uZGSA9KBE5ONIxdvej9bGigt2IpCgd8ifZMcIrhewnL+cknT0QUMmXfmIXhX
 T2Trqsil4o9IDJDESMNh4bV+UlrWfslFtU3iKOoUDRDKp4Wx/JtlDLxdPjxOkIbULOguvoHp0r+
 gEP4P3290bb0mGMmMFxd28ZrbEm9QB8cz0Ixu7Kuuwh6/Yvh5OKzW+zhsFesRCkF1jMvdcOqn+z
 dNH/XLZEht3ZWrA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zinitix touch controllers can use some of the sense lines for virtual
keys (like those found on many phones). Add support for those keys.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/input/touchscreen/zinitix.c | 61 +++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 1b4807ba4624..75390d67689e 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -119,6 +119,7 @@
 
 #define DEFAULT_TOUCH_POINT_MODE		2
 #define MAX_SUPPORTED_FINGER_NUM		5
+#define MAX_SUPPORTED_BUTTON_NUM		8
 
 #define CHIP_ON_DELAY				15 // ms
 #define FIRMWARE_ON_DELAY			40 // ms
@@ -146,6 +147,8 @@ struct bt541_ts_data {
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
 	u32 zinitix_mode;
+	u32 keycodes[MAX_SUPPORTED_BUTTON_NUM];
+	int num_keycodes;
 };
 
 static int zinitix_read_data(struct i2c_client *client,
@@ -195,6 +198,7 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 	struct i2c_client *client = bt541->client;
 	int i;
 	int error;
+	u16 int_flags = 0;
 
 	error = zinitix_write_cmd(client, ZINITIX_SWRESET_CMD);
 	if (error) {
@@ -225,6 +229,11 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 	if (error)
 		return error;
 
+	error = zinitix_write_u16(client, ZINITIX_BUTTON_SUPPORTED_NUM,
+				  bt541->num_keycodes);
+	if (error)
+		return error;
+
 	error = zinitix_write_u16(client, ZINITIX_INITIAL_TOUCH_MODE,
 				  bt541->zinitix_mode);
 	if (error)
@@ -235,9 +244,12 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 	if (error)
 		return error;
 
-	error = zinitix_write_u16(client, ZINITIX_INT_ENABLE_FLAG,
-				  BIT_PT_CNT_CHANGE | BIT_DOWN | BIT_MOVE |
-					BIT_UP);
+	int_flags = BIT_PT_CNT_CHANGE | BIT_DOWN | BIT_MOVE | BIT_UP;
+
+	if (bt541->num_keycodes)
+		int_flags |= BIT_ICON_EVENT;
+
+	error = zinitix_write_u16(client, ZINITIX_INT_ENABLE_FLAG, int_flags);
 	if (error)
 		return error;
 
@@ -350,6 +362,15 @@ static void zinitix_report_finger(struct bt541_ts_data *bt541, int slot,
 	}
 }
 
+static void zinitix_report_keys(struct bt541_ts_data *bt541, u16 icon_events)
+{
+	int i;
+
+	for (i = 0; i < bt541->num_keycodes; i++)
+		input_report_key(bt541->input_dev,
+				 bt541->keycodes[i], !!(icon_events & BIT(i)));
+}
+
 static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 {
 	struct bt541_ts_data *bt541 = bt541_handler;
@@ -358,6 +379,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 	unsigned long finger_mask;
 	int error;
 	int i;
+	__le16 icon_events = 0;
 
 	memset(&touch_event, 0, sizeof(struct touch_event));
 
@@ -368,6 +390,17 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 		goto out;
 	}
 
+	if (le16_to_cpu(touch_event.status) & BIT_ICON_EVENT) {
+		error = zinitix_read_data(bt541->client, ZINITIX_ICON_STATUS_REG,
+					  &icon_events, sizeof(icon_events));
+		if (error) {
+			dev_err(&client->dev, "Failed to read icon events\n");
+			goto out;
+		}
+
+		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
+	}
+
 	finger_mask = touch_event.finger_mask;
 	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
 		const struct point_coord *p = &touch_event.point_coord[i];
@@ -453,6 +486,7 @@ static int zinitix_init_input_dev(struct bt541_ts_data *bt541)
 {
 	struct input_dev *input_dev;
 	int error;
+	int i;
 
 	input_dev = devm_input_allocate_device(&bt541->client->dev);
 	if (!input_dev) {
@@ -470,6 +504,14 @@ static int zinitix_init_input_dev(struct bt541_ts_data *bt541)
 	input_dev->open = zinitix_input_open;
 	input_dev->close = zinitix_input_close;
 
+	if (bt541->num_keycodes) {
+		input_dev->keycode = bt541->keycodes;
+		input_dev->keycodemax = bt541->num_keycodes;
+		input_dev->keycodesize = sizeof(bt541->keycodes[0]);
+		for (i = 0; i < bt541->num_keycodes; i++)
+			input_set_capability(input_dev, EV_KEY, bt541->keycodes[i]);
+	}
+
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
@@ -534,6 +576,19 @@ static int zinitix_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	bt541->num_keycodes = of_property_read_variable_u32_array(
+					client->dev.of_node, "linux,keycodes",
+					bt541->keycodes, 0,
+					ARRAY_SIZE(bt541->keycodes));
+	if (bt541->num_keycodes == -EINVAL) {
+		bt541->num_keycodes = 0;
+	} else if (bt541->num_keycodes < 0) {
+		dev_err(&client->dev,
+			"Unable to parse \"linux,keycodes\" property: %d\n",
+			bt541->num_keycodes);
+		return bt541->num_keycodes;
+	}
+
 	error = zinitix_init_input_dev(bt541);
 	if (error) {
 		dev_err(&client->dev,

-- 
2.41.0

