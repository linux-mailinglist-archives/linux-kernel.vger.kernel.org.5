Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635D475376D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjGNKEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjGNKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:04:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA972D63;
        Fri, 14 Jul 2023 03:04:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9924ac01f98so227463866b.1;
        Fri, 14 Jul 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689329072; x=1691921072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC/ekmqpW/98xWIWVd/9RI7IBbK7bLokWpnG3F0TMEs=;
        b=KdeS9tXY3ojXr5cPM6vOzItutVezVCodV0EQVVq6PqzC5qtulq234RLWNCcMzac9vD
         5itkDtJyQoO4oJzAW6nXnhzH+C5u5I619ssfl1zCKw1OGEoak0w8XflYutMQxamjM4SV
         6GY2xA+C7niDtmyJZpC9orSrMIJR7C0FbleCEbNx+Kxi+j2NYSembuuSwHQqGMpX37xL
         jU45XkASr6bH9iX2Zt9r52IoF0RyrBDFE8N3QeHwgII3UltuXlwDc4o7fAAR/+Fn7CoB
         GovYmXXpnRId7VXUKzinFJfn/GgWtnYLrdnUmE2xf3m9u3iJtcYA+Ggt6cZhKVtgUpqk
         6g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329072; x=1691921072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC/ekmqpW/98xWIWVd/9RI7IBbK7bLokWpnG3F0TMEs=;
        b=be74CynDGlC6L5ibB3hTWrk4QaftHoPUZBzEVDGy4Gz9aXET6ipgf9luRJJwW34k+n
         ya5fg47PXDui/M1M8eKG7ThkzjXQJ1o5280XLi0Q3OW7cNFsSU+PKiNSy63V7YUIM58L
         A2ULSbxdysdtjZBNgiba20xEbRGI3ePWAAkLhAbJ9Y1gJYcKcrxuWqzhAkF2ZWlBuidR
         Usv2DeK6eh1NrK9CJXui4h7dnR5X35XigCNChT0VjZ7EuqLaP4+uNscsWs5S3oIH9/GV
         JXBTUw1Ilv2GWzed+tAKXImh/8tWUgXF6zF0Q2LJRqk12g4/7KnzQHIL1O/WaPeJtgtv
         a5NQ==
X-Gm-Message-State: ABy/qLYWWCcWEzuyoo+teTA1Ts+DZTYt6ptpt38pUnIdHBAzEnISU1+c
        CkrYCCtPktnYSreNb/fneco=
X-Google-Smtp-Source: APBJJlGC8Bunb6VpcozrBiN1HQSEO0w5JcMwd6tHxV2t9XojBMKGjN8qrlnM/OjUbW9gdqCkPnh4UA==
X-Received: by 2002:a17:907:1a58:b0:992:c40e:3c17 with SMTP id mf24-20020a1709071a5800b00992c40e3c17mr3179674ejc.75.1689329072184;
        Fri, 14 Jul 2023 03:04:32 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-105.multi.internet.cyfrowypolsat.pl. [37.248.157.105])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709063c0700b0098e42bef736sm5215415ejg.176.2023.07.14.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:04:31 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [RESEND PATCH 2/2] Input: mms114 - add support for touch keys
Date:   Fri, 14 Jul 2023 12:04:24 +0200
Message-ID: <20230714100424.29798-3-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714100424.29798-1-aweber.kernel@gmail.com>
References: <20230714100424.29798-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MELFAS MMS114 and similar touchscreens have support for touch keys.
Enable support of them in the driver. The keycodes to emit can be
controlled by the linux,keycodes DT property.

Sidenote - the MAX_TOUCHKEYS value is set to 15, as that's the
maximum value that the ID field can contain. I don't have access
to any datasheets that could confirm or deny whether this is accurate.

Most downstream drivers I've been able to find only use up to 2 keys
(though I did find a driver that mentioned up to 4, but only 2 were
used). They don't have any checks for a maximum keycode value, it is
just extracted from the ID bits (0xf mask).

The drivers I've been able to find also don't use touch ID 0; I assume
that it is never used, so the keycodes provided in the DT start from
touch ID 1. I suppose this is in-line with the regular behavior
for touch IDs in touchscreen events, as there the provided touch ID
is always lowered by 1, which would cause an overflow if it was 0...
Just in case, we quietly return if the touch ID is set to 0 here.

The implementation of the linux,keycodes property handling code was
adapted from the msg2638 driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 88 +++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index ac12494c7930..14c0514a21ff 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -43,6 +43,7 @@
 /* Touchscreen absolute values */
 #define MMS114_MAX_AREA			0xff
 
+#define MMS114_MAX_TOUCHKEYS		15
 #define MMS114_MAX_TOUCH		10
 #define MMS114_EVENT_SIZE		8
 #define MMS136_EVENT_SIZE		6
@@ -70,6 +71,9 @@ struct mms114_data {
 	unsigned int		contact_threshold;
 	unsigned int		moving_threshold;
 
+	u32 keycodes[MMS114_MAX_TOUCHKEYS];
+	int num_keycodes;
+
 	/* Use cache data for mode control register(write only) */
 	u8			cache_mode_control;
 };
@@ -167,11 +171,6 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
 		return;
 	}
 
-	if (touch->type != MMS114_TYPE_TOUCHSCREEN) {
-		dev_err(&client->dev, "Wrong touch type (%d)\n", touch->type);
-		return;
-	}
-
 	id = touch->id - 1;
 	x = touch->x_lo | touch->x_hi << 8;
 	y = touch->y_lo | touch->y_hi << 8;
@@ -191,9 +190,33 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
 	}
 }
 
+static void mms114_process_touchkey(struct mms114_data *data,
+				    struct mms114_touch *touch)
+{
+	struct i2c_client *client = data->client;
+	struct input_dev *input_dev = data->input_dev;
+	unsigned int keycode_id;
+
+	if (touch->id == 0)
+		return;
+
+	if (touch->id > data->num_keycodes) {
+		dev_err(&client->dev, "Wrong touch id for touchkey (%d)\n",
+			touch->id);
+		return;
+	}
+
+	keycode_id = touch->id - 1;
+	dev_dbg(&client->dev, "keycode id: %d, pressed: %d\n", keycode_id,
+		touch->pressed);
+
+	input_report_key(input_dev, data->keycodes[keycode_id], touch->pressed);
+}
+
 static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 {
 	struct mms114_data *data = dev_id;
+	struct i2c_client *client = data->client;
 	struct input_dev *input_dev = data->input_dev;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
 	int packet_size;
@@ -223,8 +246,22 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (error < 0)
 		goto out;
 
-	for (index = 0; index < touch_size; index++)
-		mms114_process_mt(data, touch + index);
+	for (index = 0; index < touch_size; index++) {
+		switch (touch[index].type) {
+		case MMS114_TYPE_TOUCHSCREEN:
+			mms114_process_mt(data, touch + index);
+			break;
+
+		case MMS114_TYPE_TOUCHKEY:
+			mms114_process_touchkey(data, touch + index);
+			break;
+
+		default:
+			dev_err(&client->dev, "Wrong touch type (%d)\n",
+				touch[index].type);
+			break;
+		}
+	}
 
 	input_mt_report_pointer_emulation(data->input_dev, true);
 	input_sync(data->input_dev);
@@ -446,6 +483,7 @@ static int mms114_probe(struct i2c_client *client)
 	struct input_dev *input_dev;
 	const void *match_data;
 	int error;
+	int i;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "Not supported I2C adapter\n");
@@ -469,6 +507,42 @@ static int mms114_probe(struct i2c_client *client)
 
 	data->type = (enum mms_type)match_data;
 
+	data->num_keycodes = device_property_count_u32(&client->dev,
+						       "linux,keycodes");
+	if (data->num_keycodes == -EINVAL) {
+		data->num_keycodes = 0;
+	} else if (data->num_keycodes < 0) {
+		dev_err(&client->dev,
+			"Unable to parse linux,keycodes property: %d\n",
+			data->num_keycodes);
+		return data->num_keycodes;
+	} else if (data->num_keycodes > MMS114_MAX_TOUCHKEYS) {
+		dev_warn(&client->dev,
+			"Found %d linux,keycodes but max is %zd, ignoring the rest\n",
+			 data->num_keycodes, MMS114_MAX_TOUCHKEYS);
+		data->num_keycodes = MMS114_MAX_TOUCHKEYS;
+	}
+
+	if (data->num_keycodes > 0) {
+		error = device_property_read_u32_array(&client->dev,
+						       "linux,keycodes",
+						       data->keycodes,
+						       data->num_keycodes);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to read linux,keycodes values: %d\n",
+				error);
+			return error;
+		}
+
+		input_dev->keycode = data->keycodes;
+		input_dev->keycodemax = data->num_keycodes;
+		input_dev->keycodesize = sizeof(data->keycodes[0]);
+		for (i = 0; i < data->num_keycodes; i++)
+			input_set_capability(input_dev,
+					     EV_KEY, data->keycodes[i]);
+	}
+
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
-- 
2.41.0

