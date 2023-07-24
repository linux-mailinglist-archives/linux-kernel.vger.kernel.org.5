Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65B75EADC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGXFam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:30:32 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062E109;
        Sun, 23 Jul 2023 22:30:27 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583d63ca1e9so13620087b3.1;
        Sun, 23 Jul 2023 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176626; x=1690781426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnxapSoOoqrx/JmjeK0D4Eqy+ziHuQAnxXeq35Wg/z4=;
        b=Eh9w1ztROQv0GBXKw5jQboCjf5CmerGXt1srqxDtS8JJYcJgFw1XG1VECXJetgpR9M
         p9XlmBV1Y29iuxEdXKhptSXxy/HGSBJoMOsY7f3IRlTdbChDBrq+PCslCkjgJfvF97HT
         YUsGvp63XlaEm1Xyv/RKQiUa3fkyudUZKUwkwZEMvueMR8ZaiqkWrRmRsBbwQj5V6vPP
         DtN5Jhtak3uclk1P4WNr6oZWbt6NmdO1+1HCuoI2OCBkfXHLxhESS6GZrTn76zsCtvHi
         cO6z9Nor38/187qX1wB6VqM+tklJ6iv959TzxMR6LgiRxSs/Z0OMzDV+IaTUL/COdO2h
         to3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176626; x=1690781426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnxapSoOoqrx/JmjeK0D4Eqy+ziHuQAnxXeq35Wg/z4=;
        b=fIRrNGq6ciMf2Xd1gMpRDJUzqdJ+FSaKZvdoVr9uDNioTkNXW9gxtKDgM9UPS6sABP
         X8L7//o97aqtxm0TQQ45+hfiem3HMyEmTVJQ6ldgyVHIb3LrIQAbJC+Vd2uvY2wAiOej
         Zu22FWdOVviT/8MiR8IeU/wEnzW4I7NaYGrT7C1tFDD9HdjkL/HgefRcDz9QhGUxrWzZ
         trD/mI/tD+9XpW+0k6ou7yu8vOCTa8P2TfQNBHL++3mI1nv9ZzZolP11IeXTdTZuB6mT
         0Pmm30De9EdUHi6FDqOi6s70woHOmubY/Dz4SwfCm/LRCCC5B9PUmRCE1eIhnfBQ4cE4
         VZRg==
X-Gm-Message-State: ABy/qLa0irUQd2I4Bxsm3ZaVgahokCztkC4iBGk73YIOCPI5xKPasg5D
        4zn/DEJPSJqcOcpY37USh4MeNz6r2ig=
X-Google-Smtp-Source: APBJJlHFNxoyfLX3t4i1b80DGBzxiqfEOqiDUPJWTHhotLZ5PDy1Hdbdiz1qixcmcFft00WqOMVejQ==
X-Received: by 2002:a0d:d515:0:b0:573:cacd:3b6e with SMTP id x21-20020a0dd515000000b00573cacd3b6emr5678723ywd.30.1690176626563;
        Sun, 23 Jul 2023 22:30:26 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902758e00b001b81a97860asm7801937pll.27.2023.07.23.22.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:30:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Input: tca6416-keypad - always expect proper IRQ number in i2c client
Date:   Sun, 23 Jul 2023 22:30:18 -0700
Message-ID: <20230724053024.352054-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
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

Remove option having i2c client contain raw gpio number instead of proper
IRQ number. There are no users of this facility in mainline and it will
allow cleaning up the driver code with regard to wakeup handling, etc.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca6416-keypad.c | 27 +++++++++----------------
 include/linux/tca6416_keypad.h          |  1 -
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 2f745cabf4f2..01bc0b881188 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -148,7 +148,7 @@ static int tca6416_keys_open(struct input_dev *dev)
 	if (chip->use_polling)
 		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
 	else
-		enable_irq(chip->irqnum);
+		enable_irq(chip->client->irq);
 
 	return 0;
 }
@@ -160,7 +160,7 @@ static void tca6416_keys_close(struct input_dev *dev)
 	if (chip->use_polling)
 		cancel_delayed_work_sync(&chip->dwork);
 	else
-		disable_irq(chip->irqnum);
+		disable_irq(chip->client->irq);
 }
 
 static int tca6416_setup_registers(struct tca6416_keypad_chip *chip)
@@ -266,12 +266,7 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 		goto fail1;
 
 	if (!chip->use_polling) {
-		if (pdata->irq_is_gpio)
-			chip->irqnum = gpio_to_irq(client->irq);
-		else
-			chip->irqnum = client->irq;
-
-		error = request_threaded_irq(chip->irqnum, NULL,
+		error = request_threaded_irq(client->irq, NULL,
 					     tca6416_keys_isr,
 					     IRQF_TRIGGER_FALLING |
 					     IRQF_ONESHOT | IRQF_NO_AUTOEN,
@@ -279,7 +274,7 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 		if (error) {
 			dev_dbg(&client->dev,
 				"Unable to claim irq %d; error %d\n",
-				chip->irqnum, error);
+				client->irq, error);
 			goto fail1;
 		}
 	}
@@ -298,8 +293,8 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 
 fail2:
 	if (!chip->use_polling) {
-		free_irq(chip->irqnum, chip);
-		enable_irq(chip->irqnum);
+		free_irq(client->irq, chip);
+		enable_irq(client->irq);
 	}
 fail1:
 	input_free_device(input);
@@ -312,8 +307,8 @@ static void tca6416_keypad_remove(struct i2c_client *client)
 	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (!chip->use_polling) {
-		free_irq(chip->irqnum, chip);
-		enable_irq(chip->irqnum);
+		free_irq(client->irq, chip);
+		enable_irq(client->irq);
 	}
 
 	input_unregister_device(chip->input);
@@ -323,10 +318,9 @@ static void tca6416_keypad_remove(struct i2c_client *client)
 static int tca6416_keypad_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(chip->irqnum);
+		enable_irq_wake(client->irq);
 
 	return 0;
 }
@@ -334,10 +328,9 @@ static int tca6416_keypad_suspend(struct device *dev)
 static int tca6416_keypad_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(chip->irqnum);
+		disable_irq_wake(client->irq);
 
 	return 0;
 }
diff --git a/include/linux/tca6416_keypad.h b/include/linux/tca6416_keypad.h
index b0d36a9934cc..5cf6f6f82aa7 100644
--- a/include/linux/tca6416_keypad.h
+++ b/include/linux/tca6416_keypad.h
@@ -25,7 +25,6 @@ struct tca6416_keys_platform_data {
 	unsigned int rep:1;	/* enable input subsystem auto repeat */
 	uint16_t pinmask;
 	uint16_t invert;
-	int irq_is_gpio;
 	int use_polling;	/* use polling if Interrupt is not connected*/
 };
 #endif
-- 
2.41.0.487.g6d72f3e995-goog

