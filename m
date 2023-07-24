Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D8375EAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGXFOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXFN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:13:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB13E47;
        Sun, 23 Jul 2023 22:13:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55ae51a45deso1863465a12.3;
        Sun, 23 Jul 2023 22:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690175632; x=1690780432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03EJWrFuVnN7Ttag8T1UjPvKeFWGUuTA0IYhmoMhgg0=;
        b=FiusPs/hFTgSo1KubGOMb8AhhcHl9uCi6O38VK/7Hy02JOrKsymMaqBf/LtSrmhy79
         Sie/LjQYh76DqR5hMBW53/9jh58c1Fts+6s9hgCwJ4O4WoAZTLhhUnCq8lVF4Zl8K9AD
         BNE8yrHpqhIOzQTUBanNCVTMi7TZ/RIBGxvSitsaQdkkpojKaQJ8ONLfVgJBrYb5juSx
         sPd0ZfEFG/FqDhA9cTIkoj5+qJTVXelxjhixuDacyuoOSaga+LmIXkfl7IIexfE8I0l9
         ZuyGKL9vlH+gFX+7YalSMX4Tas40z9XlnLm/AQ5LxcjebTi3GiishznjFcL2dwJ6wYET
         XMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690175632; x=1690780432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03EJWrFuVnN7Ttag8T1UjPvKeFWGUuTA0IYhmoMhgg0=;
        b=BjEXachNGXAoskfRP/PMg9XM7T9sAt9kMZuxrTEib3bV91x9uGH16opnXkHb2nyc1l
         4iwGGD/A9iwrq4mzgaVc9NSysvdFo9umfT0opQEO3tzbulIjFgJySbsjmOJ+4DNQ2aHi
         74eL3MVhc30+fkODbyKEnimLZ4FQKFvwrF+lQKJKTQLlKcxVrDYVjFMCXTIF67JKPdZb
         2INBaU/U7+tyPEeT/gocA0Bk9QS6JWh8F0rmfBfrcJcrd4KWDLFYpx3MZ7m00y5YCBKs
         6tt22flfwLq1HhjyU+pgH3jN1QvLGPAxgTWLiBF4wjvViK4G6BZm7DoKCTb8VfzmU1zs
         qP8g==
X-Gm-Message-State: ABy/qLY1LlzKYxCzCDnT20JXr2wWmsep9sWkVTwN2McvE0PE8hsYLyuk
        MmDnUbcDcvaVhZmmDExfBxhcqafDQpg=
X-Google-Smtp-Source: APBJJlH2b2TLnA+/XQ9lY/4HOD8AV018YZJ4STZy72ICtUXvyaLXUK0m1SINjFMDdyXk6kXvXk9QzQ==
X-Received: by 2002:a17:90a:66c6:b0:262:ce8f:a3e with SMTP id z6-20020a17090a66c600b00262ce8f0a3emr5539310pjl.42.1690175631957;
        Sun, 23 Jul 2023 22:13:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id gv17-20020a17090b11d100b00265dc26d8dfsm7501106pjb.27.2023.07.23.22.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:13:51 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Input: qt2160 - convert to use devm_* api
Date:   Sun, 23 Jul 2023 22:13:42 -0700
Message-ID: <20230724051345.335219-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230724051345.335219-1-dmitry.torokhov@gmail.com>
References: <20230724051345.335219-1-dmitry.torokhov@gmail.com>
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

From: Yangtao Li <frank.li@vivo.com>

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Link: https://lore.kernel.org/r/20230714080611.81302-7-frank.li@vivo.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 77 +++++++++------------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 6cfaabd10482..7e3b09642ab7 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -239,7 +239,7 @@ static int qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 static int qt2160_register_leds(struct qt2160_data *qt2160)
 {
 	struct i2c_client *client = qt2160->client;
-	int ret;
+	int error;
 	int i;
 
 	for (i = 0; i < QT2160_NUM_LEDS_X; i++) {
@@ -252,9 +252,9 @@ static int qt2160_register_leds(struct qt2160_data *qt2160)
 		led->id = i;
 		led->qt2160 = qt2160;
 
-		ret = led_classdev_register(&client->dev, &led->cdev);
-		if (ret < 0)
-			return ret;
+		error = devm_led_classdev_register(&client->dev, &led->cdev);
+		if (error)
+			return error;
 	}
 
 	/* Tur off LEDs */
@@ -265,14 +265,6 @@ static int qt2160_register_leds(struct qt2160_data *qt2160)
 	return 0;
 }
 
-static void qt2160_unregister_leds(struct qt2160_data *qt2160)
-{
-	int i;
-
-	for (i = 0; i < QT2160_NUM_LEDS_X; i++)
-		led_classdev_unregister(&qt2160->leds[i].cdev);
-}
-
 #else
 
 static inline int qt2160_register_leds(struct qt2160_data *qt2160)
@@ -280,10 +272,6 @@ static inline int qt2160_register_leds(struct qt2160_data *qt2160)
 	return 0;
 }
 
-static inline void qt2160_unregister_leds(struct qt2160_data *qt2160)
-{
-}
-
 #endif
 
 static bool qt2160_identify(struct i2c_client *client)
@@ -334,13 +322,13 @@ static int qt2160_probe(struct i2c_client *client)
 		return -ENODEV;
 
 	/* Chip is valid and active. Allocate structure */
-	qt2160 = kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!qt2160 || !input) {
-		dev_err(&client->dev, "insufficient memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	qt2160 = devm_kzalloc(&client->dev, sizeof(*qt2160), GFP_KERNEL);
+	if (!qt2160)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!input)
+		return -ENOMEM;
 
 	qt2160->client = client;
 	qt2160->input = input;
@@ -366,22 +354,24 @@ static int qt2160_probe(struct i2c_client *client)
 	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
 	if (error) {
 		dev_err(&client->dev, "failed to calibrate device\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	if (client->irq) {
-		error = request_threaded_irq(client->irq, NULL, qt2160_irq,
-					     IRQF_ONESHOT, "qt2160", input);
+		error = devm_request_threaded_irq(&client->dev, client->irq,
+						  NULL, qt2160_irq,
+						  IRQF_ONESHOT,
+						  "qt2160", input);
 		if (error) {
 			dev_err(&client->dev,
 				"failed to allocate irq %d\n", client->irq);
-			goto err_free_mem;
+			return error;
 		}
 	} else {
 		error = input_setup_polling(input, qt2160_get_key_matrix);
 		if (error) {
 			dev_err(&client->dev, "Failed to setup polling\n");
-			goto err_free_mem;
+			return error;
 		}
 		input_set_poll_interval(input, QT2160_CYCLE_INTERVAL);
 	}
@@ -389,43 +379,17 @@ static int qt2160_probe(struct i2c_client *client)
 	error = qt2160_register_leds(qt2160);
 	if (error) {
 		dev_err(&client->dev, "Failed to register leds\n");
-		goto err_free_irq;
+		return error;
 	}
 
 	error = input_register_device(qt2160->input);
 	if (error) {
 		dev_err(&client->dev,
 			"Failed to register input device\n");
-		goto err_unregister_leds;
+		return error;
 	}
 
-	i2c_set_clientdata(client, qt2160);
-
 	return 0;
-
-err_unregister_leds:
-	qt2160_unregister_leds(qt2160);
-err_free_irq:
-	if (client->irq)
-		free_irq(client->irq, qt2160);
-err_free_mem:
-	input_free_device(input);
-	kfree(qt2160);
-	return error;
-}
-
-static void qt2160_remove(struct i2c_client *client)
-{
-	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
-
-	qt2160_unregister_leds(qt2160);
-
-	/* Release IRQ so no queue will be scheduled */
-	if (client->irq)
-		free_irq(client->irq, qt2160);
-
-	input_unregister_device(qt2160->input);
-	kfree(qt2160);
 }
 
 static const struct i2c_device_id qt2160_idtable[] = {
@@ -442,7 +406,6 @@ static struct i2c_driver qt2160_driver = {
 
 	.id_table	= qt2160_idtable,
 	.probe		= qt2160_probe,
-	.remove		= qt2160_remove,
 };
 
 module_i2c_driver(qt2160_driver);
-- 
2.41.0.487.g6d72f3e995-goog

