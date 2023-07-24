Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE275EADE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGXFaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGXFad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:30:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0557E41;
        Sun, 23 Jul 2023 22:30:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bba48b0bd2so2504915ad.3;
        Sun, 23 Jul 2023 22:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176630; x=1690781430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myxsHV41W/cEgCHV/ZIjTYl0IALEPxj3hWRr+N7vsnc=;
        b=moHLe0NX/7pk+pvyJOIFWfb6uid2+i4E7Z/Qx2iIMwzSpY3Ai1qWSI0J2RbKFLWTCr
         qUSv0u3jXcLy6CmTCrk65iqCscw1iduJei3nUnw/1ZPZPlV4wgRw4I//x8XiusIi2Rbb
         KWBrHRbGyAsdyFrBDL/zR59LcKoT+TUBwcoQp39sKkeCKp5UZrlhp8YdeZsmqtqy4Zx5
         nGFBe3zxYCZTZevatAvD4dfPoa9vDSZ8HkAlThdOghusxU0MD4WSTR2VmhBFvWA66NvO
         CYji1DXt5fiZ7wz2eFNfzulhGYGbhdAAwicp9R4yeJYNtpsa3qxFBJS9qSs4TGHZ9duh
         Qp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176630; x=1690781430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myxsHV41W/cEgCHV/ZIjTYl0IALEPxj3hWRr+N7vsnc=;
        b=LDRMcKtPDTS4qWRA4eoo1ypozty+dEH7kHuxD/WcJKsW1g4sfBsrcrkf56PU5Vr0a2
         KpD1+qhU9PH8ApDye10OyW13G9pf0EISgsWYV/hKUk2Jqu6KZEGMWKcv7988+EtNf2LR
         M5sycUe+PNPySNdObK5TECxz2kULoYfsrOMOwFInhFlyGQfiKnkE9q/6etxbnXD8lr63
         j5NOmIadBYJEsThbjYKttvnF4+62vNnh52b2xTya9BW6sKXHf4cJlYGSImhBHs6cZ8ye
         btdB3nbYmBqx5TTSfq7kT93v3vilpFZmU/16cYrJ5gm1ZtVMFM0/xEzw4u65MeJFQ9M0
         pEbw==
X-Gm-Message-State: ABy/qLYRYNJ+IzGSeSNK4aedLuT5AXAGGTZCZnTeg7AhG7BuFyRdeIL8
        pmWh29o5AkEk/YtOTD51mxbsI5PZT/s=
X-Google-Smtp-Source: APBJJlEbwFWsFqhgfqgPEjkAoK4JltfHryMjWpUh0kB6xVt29YA7Dk4jCaWcG8L3JG440MTwGE/SXg==
X-Received: by 2002:a17:902:d4ca:b0:1bb:5b88:73da with SMTP id o10-20020a170902d4ca00b001bb5b8873damr9344869plg.61.1690176630106;
        Sun, 23 Jul 2023 22:30:30 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902758e00b001b81a97860asm7801937pll.27.2023.07.23.22.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:30:29 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: tca6416-keypad - switch to using input core's polling features
Date:   Sun, 23 Jul 2023 22:30:22 -0700
Message-ID: <20230724053024.352054-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230724053024.352054-1-dmitry.torokhov@gmail.com>
References: <20230724053024.352054-1-dmitry.torokhov@gmail.com>
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

Instead of rolling custom polling implementation use input core
facilities.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca6416-keypad.c | 46 ++++++++++---------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index ff665319791e..ebc8b9561266 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -24,6 +24,8 @@
 #define TCA6416_INVERT         2
 #define TCA6416_DIRECTION      3
 
+#define TCA6416_POLL_INTERVAL	100 /* msec */
+
 static const struct i2c_device_id tca6416_id[] = {
 	{ "tca6416-keys", 16, },
 	{ "tca6408-keys", 8, },
@@ -43,7 +45,6 @@ struct tca6416_keypad_chip {
 
 	struct i2c_client *client;
 	struct input_dev *input;
-	struct delayed_work dwork;
 	int io_size;
 	int irqnum;
 	u16 pinmask;
@@ -85,9 +86,9 @@ static int tca6416_read_reg(struct tca6416_keypad_chip *chip, int reg, u16 *val)
 	return 0;
 }
 
-static void tca6416_keys_scan(struct tca6416_keypad_chip *chip)
+static void tca6416_keys_scan(struct input_dev *input)
 {
-	struct input_dev *input = chip->input;
+	struct tca6416_keypad_chip *chip = input_get_drvdata(input);
 	u16 reg_val, val;
 	int error, i, pin_index;
 
@@ -122,33 +123,20 @@ static void tca6416_keys_scan(struct tca6416_keypad_chip *chip)
  */
 static irqreturn_t tca6416_keys_isr(int irq, void *dev_id)
 {
-	struct tca6416_keypad_chip *chip = dev_id;
-
-	tca6416_keys_scan(chip);
+	tca6416_keys_scan(dev_id);
 
 	return IRQ_HANDLED;
 }
 
-static void tca6416_keys_work_func(struct work_struct *work)
-{
-	struct tca6416_keypad_chip *chip =
-		container_of(work, struct tca6416_keypad_chip, dwork.work);
-
-	tca6416_keys_scan(chip);
-	schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
-}
-
 static int tca6416_keys_open(struct input_dev *dev)
 {
 	struct tca6416_keypad_chip *chip = input_get_drvdata(dev);
 
-	/* Get initial device state in case it has switches */
-	tca6416_keys_scan(chip);
-
-	if (chip->use_polling)
-		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
-	else
+	if (!chip->use_polling) {
+		/* Get initial device state in case it has switches */
+		tca6416_keys_scan(dev);
 		enable_irq(chip->client->irq);
+	}
 
 	return 0;
 }
@@ -157,9 +145,7 @@ static void tca6416_keys_close(struct input_dev *dev)
 {
 	struct tca6416_keypad_chip *chip = input_get_drvdata(dev);
 
-	if (chip->use_polling)
-		cancel_delayed_work_sync(&chip->dwork);
-	else
+	if (!chip->use_polling)
 		disable_irq(chip->client->irq);
 }
 
@@ -232,8 +218,6 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	chip->pinmask = pdata->pinmask;
 	chip->use_polling = pdata->use_polling;
 
-	INIT_DELAYED_WORK(&chip->dwork, tca6416_keys_work_func);
-
 	input->phys = "tca6416-keys/input0";
 	input->name = client->name;
 
@@ -268,12 +252,20 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 		return error;
 
 	if (!chip->use_polling) {
+		error = input_setup_polling(input, tca6416_keys_scan);
+		if (error) {
+			dev_err(&client->dev, "Failed to setup polling\n");
+			return error;
+		}
+
+		input_set_poll_interval(input, TCA6416_POLL_INTERVAL);
+	} else {
 		error = devm_request_threaded_irq(&client->dev, client->irq,
 						  NULL, tca6416_keys_isr,
 						  IRQF_TRIGGER_FALLING |
 							IRQF_ONESHOT |
 							IRQF_NO_AUTOEN,
-						  "tca6416-keypad", chip);
+						  "tca6416-keypad", input);
 		if (error) {
 			dev_dbg(&client->dev,
 				"Unable to claim irq %d; error %d\n",
-- 
2.41.0.487.g6d72f3e995-goog

