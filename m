Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720DE75EAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGXFOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGXFN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:13:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16874E4A;
        Sun, 23 Jul 2023 22:13:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so2498470a12.1;
        Sun, 23 Jul 2023 22:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690175630; x=1690780430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T97tcTSFQGPc6gGcVYrEPjC13qxr2ex/c8Suwj0RBNk=;
        b=aUmHYkdfM+iydYeE6Cq29eEtlaaS1Jqy+mInIVnTPDsJt2AGhMsr2uOgoB1totUJkW
         nb6hL+jZbZh0hkvLKsPX4i4V9UhW7cfLK+nXCbajn9hlpIGOoG6Z4jzi1TB4Hylqvqtb
         TTRfJDiURxaQVL8wZR6gXkoHZNqY6CvN3f+X/EklP/SO60y1ExP2EJVChdnMw1i/LtJE
         IZZ7BWt1JvTlUz//D/4PtHCQnU9dxpSGUlVFxv9zRizq2lCVPudhTPl2uYSdVJnzmeXi
         lpPh9JJxVM71d04+7rgjr0x5CF7SAn2CKdmAzdaZBtmySboL9qJaO7+7vJ4K//avvV+V
         EuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690175630; x=1690780430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T97tcTSFQGPc6gGcVYrEPjC13qxr2ex/c8Suwj0RBNk=;
        b=X4qwkQJ+ozcsRZkSyrNF3RtBADN21riaUxTsu+p8BflWqN4vk4tOIFlIDrzkpKPT/O
         hFPfHbEKnVY41gUAhRhTGRiSrzKtNeipeKw8fvknBbook6LfHrwNj8Aj/61EV/MxeKO1
         e16DMzEJrLKlPFMfd7bh+Iv/WbxQ5OK2juFSGdas6n/1JGQOF2gk+f5c8au/NoAnZE5b
         tN7yeaIEi1srmWftPFMzJkSb2YUHu4iBS37mbqnbv1P4Pl8aY7VuTKB20pu0EaGmaziB
         nTCRNgmOOIP9sBLyZlVsYWGm+2HHCXgLGjKOQGzqm5mn2tF+z8nFz5zHz+mRkI87UIIy
         7sSg==
X-Gm-Message-State: ABy/qLbvgRHtKhEPiZ6hX0kh9A/rN7moT3eujOCi5DV9QxS8RnTmwIrV
        YKF/fw0RBUCeZT57ZHDMSswGgmygqYA=
X-Google-Smtp-Source: APBJJlGb88IqWTgJxONyFVXsBNHaRHTl1+rfN3MMSp9txoVwvgyUSrkydDlNAAnMs2QwjlSeujXnQw==
X-Received: by 2002:a17:90b:4d83:b0:263:eb0e:5681 with SMTP id oj3-20020a17090b4d8300b00263eb0e5681mr12020167pjb.3.1690175630233;
        Sun, 23 Jul 2023 22:13:50 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id gv17-20020a17090b11d100b00265dc26d8dfsm7501106pjb.27.2023.07.23.22.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:13:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Input: qt2160 - switch to using threaded interrupt handler
Date:   Sun, 23 Jul 2023 22:13:40 -0700
Message-ID: <20230724051345.335219-2-dmitry.torokhov@gmail.com>
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

Instead of using combination of normal IRQ and work item which required
careful handling on device teardown, use standard threaded interrupt that
allows communication wityh the chip over slow (I2C) bus directly in the
interrupt handler.

To support polling mode switch to standard polling support implemented by
the input core.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 53 ++++++++++++---------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index b0b9d7a2691e..b8c0f0ebf604 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -32,7 +32,7 @@
 
 #define QT2160_NUM_LEDS_X	8
 
-#define QT2160_CYCLE_INTERVAL	(2*HZ)
+#define QT2160_CYCLE_INTERVAL	2000 /* msec - 2 sec */
 
 static unsigned char qt2160_key2code[] = {
 	KEY_0, KEY_1, KEY_2, KEY_3,
@@ -54,7 +54,6 @@ struct qt2160_led {
 struct qt2160_data {
 	struct i2c_client *client;
 	struct input_dev *input;
-	struct delayed_work dwork;
 	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
 	u16 key_matrix;
 #ifdef CONFIG_LEDS_CLASS
@@ -155,10 +154,10 @@ static int qt2160_read_block(struct i2c_client *client,
 	return 0;
 }
 
-static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
+static void qt2160_get_key_matrix(struct input_dev *input)
 {
+	struct qt2160_data *qt2160 = input_get_drvdata(input);
 	struct i2c_client *client = qt2160->client;
-	struct input_dev *input = qt2160->input;
 	u8 regs[6];
 	u16 old_matrix, new_matrix;
 	int ret, i, mask;
@@ -173,7 +172,7 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 	if (ret) {
 		dev_err(&client->dev,
 			"could not perform chip read.\n");
-		return ret;
+		return;
 	}
 
 	old_matrix = qt2160->key_matrix;
@@ -191,37 +190,17 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
 	}
 
 	input_sync(input);
-
-	return 0;
 }
 
-static irqreturn_t qt2160_irq(int irq, void *_qt2160)
+static irqreturn_t qt2160_irq(int irq, void *data)
 {
-	struct qt2160_data *qt2160 = _qt2160;
+	struct input_dev *input = data;
 
-	mod_delayed_work(system_wq, &qt2160->dwork, 0);
+	qt2160_get_key_matrix(input);
 
 	return IRQ_HANDLED;
 }
 
-static void qt2160_schedule_read(struct qt2160_data *qt2160)
-{
-	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
-}
-
-static void qt2160_worker(struct work_struct *work)
-{
-	struct qt2160_data *qt2160 =
-		container_of(work, struct qt2160_data, dwork.work);
-
-	dev_dbg(&qt2160->client->dev, "worker\n");
-
-	qt2160_get_key_matrix(qt2160);
-
-	/* Avoid device lock up by checking every so often */
-	qt2160_schedule_read(qt2160);
-}
-
 static int qt2160_read(struct i2c_client *client, u8 reg)
 {
 	int ret;
@@ -365,7 +344,6 @@ static int qt2160_probe(struct i2c_client *client)
 
 	qt2160->client = client;
 	qt2160->input = input;
-	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
 
 	input->name = "AT42QT2160 Touch Sense Keyboard";
 	input->id.bustype = BUS_I2C;
@@ -382,6 +360,8 @@ static int qt2160_probe(struct i2c_client *client)
 	}
 	__clear_bit(KEY_RESERVED, input->keybit);
 
+	input_set_drvdata(input, qt2160);
+
 	/* Calibrate device */
 	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
 	if (error) {
@@ -390,13 +370,21 @@ static int qt2160_probe(struct i2c_client *client)
 	}
 
 	if (client->irq) {
-		error = request_irq(client->irq, qt2160_irq,
-				    IRQF_TRIGGER_FALLING, "qt2160", qt2160);
+		error = request_threaded_irq(client->irq, NULL, qt2160_irq,
+					     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					     "qt2160", input);
 		if (error) {
 			dev_err(&client->dev,
 				"failed to allocate irq %d\n", client->irq);
 			goto err_free_mem;
 		}
+	} else {
+		error = input_setup_polling(input, qt2160_get_key_matrix);
+		if (error) {
+			dev_err(&client->dev, "Failed to setup polling\n");
+			goto err_free_mem;
+		}
+		input_set_poll_interval(input, QT2160_CYCLE_INTERVAL);
 	}
 
 	error = qt2160_register_leds(qt2160);
@@ -413,7 +401,6 @@ static int qt2160_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, qt2160);
-	qt2160_schedule_read(qt2160);
 
 	return 0;
 
@@ -438,8 +425,6 @@ static void qt2160_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, qt2160);
 
-	cancel_delayed_work_sync(&qt2160->dwork);
-
 	input_unregister_device(qt2160->input);
 	kfree(qt2160);
 }
-- 
2.41.0.487.g6d72f3e995-goog

