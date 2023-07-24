Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5583175EAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGXF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGXF3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:29:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C0E56;
        Sun, 23 Jul 2023 22:29:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668711086f4so2476945b3a.1;
        Sun, 23 Jul 2023 22:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176545; x=1690781345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ep0nbubW/pYZF9n+Ovt3HV6C5tiiM1xsOGhla+jSTk=;
        b=LpV/+m6TSa0jr873MZzvUA2YCn38wWRmZxpdjNQ773EaokynMwUShycjGnGchb4W0y
         C6uw7BfDe1AGtJtT8SX+K3k/nDrlw4SevPPtst1TSWiJ0MlKojSO4LPZbTMiIYVs8K6t
         RI5QQXmUrIP/XpTRFofSHPHRufpfGaAB5sXlsR++wm+3iPG5mAL6+8//T66gxBNR06Wk
         nau2hGBuulniQBykM+dk3BodNZW1+omkbVNnKQ682ZjcbTHk7Dyz6PqltCDhxOKVBEmC
         RdioQYmqsV4mMQqynYP73Mrid0YJV0CajNkLbtkcT6jXPIOHQRQZDXlrQR6AmYU3tX3z
         oWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176545; x=1690781345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ep0nbubW/pYZF9n+Ovt3HV6C5tiiM1xsOGhla+jSTk=;
        b=l1iLDF+/gyk2Ufjm+4J7JOjZGrUsKUlyZWk/76PoDZCM7LoWbww/hUdtU31UwuapRW
         Oca37bMvHq1JwBE0pqFGjrBW3niaHY2Q5BrRr1gRfOw4YMfZGZYKlmtm+m78e7/nFwwE
         yOeD+P9Sk11zJf5tZrQJ7N59e1V1xE9gdfo7BYohpqVTD1M9+DNH0DW7L4ecuu+UD3oQ
         cbpxDitl2RQuH7ORse51iDjo+wbgJ1XD94vdPPE+BpYchNT6TfoweDM3FZuyqV5/qXge
         QUlMyfouWpb6hUnQm4YuzCTlusfANg6O0l1O/Wrz9EBdacw0ENZ14IFfqZM4Ep/fdEfb
         +z/A==
X-Gm-Message-State: ABy/qLbkqbVrHcpQdaNipGVdIF6eTu60zOjERjaPqTMZpllXI2F1GTWC
        8XG/V9hzfctxqP8R4ZRSKwE8QnK8wjQ=
X-Google-Smtp-Source: APBJJlHySbRKnbtZ45tZNhTXLVwUjG+9DrrRZD1CzQ01sKzPcjwZxT1HZ05eFbHLpOEoL85qg9Q+DA==
X-Received: by 2002:a05:6a00:1885:b0:678:7744:31fd with SMTP id x5-20020a056a00188500b00678774431fdmr10162211pfh.0.1690176545515;
        Sun, 23 Jul 2023 22:29:05 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id fk18-20020a056a003a9200b0064d3a9def35sm6721286pfb.188.2023.07.23.22.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:29:05 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: lm8323 - convert to use devm_* api
Date:   Sun, 23 Jul 2023 22:29:00 -0700
Message-ID: <20230724052901.350240-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230724052901.350240-1-dmitry.torokhov@gmail.com>
References: <20230724052901.350240-1-dmitry.torokhov@gmail.com>
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
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 77 +++++++++++----------------------
 1 file changed, 26 insertions(+), 51 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index d5195415533a..7bee93e9b0f5 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -556,6 +556,7 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 		    const char *name)
 {
 	struct lm8323_pwm *pwm;
+	int err;
 
 	BUG_ON(id > 3);
 
@@ -575,9 +576,11 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 		pwm->cdev.name = name;
 		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
 		pwm->cdev.groups = lm8323_pwm_groups;
-		if (led_classdev_register(dev, &pwm->cdev) < 0) {
-			dev_err(dev, "couldn't register PWM %d\n", id);
-			return -1;
+
+		err = devm_led_classdev_register(dev, &pwm->cdev);
+		if (err) {
+			dev_err(dev, "couldn't register PWM %d: %d\n", id, err);
+			return err;
 		}
 		pwm->enabled = true;
 	}
@@ -585,8 +588,6 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 	return 0;
 }
 
-static struct i2c_driver lm8323_i2c_driver;
-
 static ssize_t lm8323_show_disable(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -648,12 +649,13 @@ static int lm8323_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	lm = kzalloc(sizeof *lm, GFP_KERNEL);
-	idev = input_allocate_device();
-	if (!lm || !idev) {
-		err = -ENOMEM;
-		goto fail1;
-	}
+	lm = devm_kzalloc(&client->dev, sizeof(*lm), GFP_KERNEL);
+	if (!lm)
+		return -ENOMEM;
+
+	idev = devm_input_allocate_device(&client->dev);
+	if (!idev)
+		return -ENOMEM;
 
 	lm->client = client;
 	lm->idev = idev;
@@ -669,8 +671,10 @@ static int lm8323_probe(struct i2c_client *client)
 
 	lm8323_reset(lm);
 
-	/* Nothing's set up to service the IRQ yet, so just spin for max.
-	 * 100ms until we can configure. */
+	/*
+	 * Nothing's set up to service the IRQ yet, so just spin for max.
+	 * 100ms until we can configure.
+	 */
 	tmo = jiffies + msecs_to_jiffies(100);
 	while (lm8323_read(lm, LM8323_CMD_READ_INT, data, 1) == 1) {
 		if (data[0] & INT_NOINIT)
@@ -690,15 +694,14 @@ static int lm8323_probe(struct i2c_client *client)
 	/* If a true probe check the device */
 	if (lm8323_read_id(lm, data) != 0) {
 		dev_err(&client->dev, "device not found\n");
-		err = -ENODEV;
-		goto fail1;
+		return -ENODEV;
 	}
 
 	for (pwm = 0; pwm < LM8323_NUM_PWMS; pwm++) {
 		err = init_pwm(lm, pwm + 1, &client->dev,
 			       pdata->pwm_names[pwm]);
-		if (err < 0)
-			goto fail2;
+		if (err)
+			return err;
 	}
 
 	lm->kp_enabled = true;
@@ -722,14 +725,16 @@ static int lm8323_probe(struct i2c_client *client)
 	err = input_register_device(idev);
 	if (err) {
 		dev_dbg(&client->dev, "error registering input device\n");
-		goto fail2;
+		return err;
 	}
 
-	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
-			  IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
+	err = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, lm8323_irq,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					"lm8323", lm);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
-		goto fail3;
+		return err;
 	}
 
 	i2c_set_clientdata(client, lm);
@@ -738,35 +743,6 @@ static int lm8323_probe(struct i2c_client *client)
 	enable_irq_wake(client->irq);
 
 	return 0;
-
-fail3:
-	input_unregister_device(idev);
-	idev = NULL;
-fail2:
-	while (--pwm >= 0)
-		if (lm->pwm[pwm].enabled)
-			led_classdev_unregister(&lm->pwm[pwm].cdev);
-fail1:
-	input_free_device(idev);
-	kfree(lm);
-	return err;
-}
-
-static void lm8323_remove(struct i2c_client *client)
-{
-	struct lm8323_chip *lm = i2c_get_clientdata(client);
-	int i;
-
-	disable_irq_wake(client->irq);
-	free_irq(client->irq, lm);
-
-	input_unregister_device(lm->idev);
-
-	for (i = 0; i < 3; i++)
-		if (lm->pwm[i].enabled)
-			led_classdev_unregister(&lm->pwm[i].cdev);
-
-	kfree(lm);
 }
 
 /*
@@ -827,7 +803,6 @@ static struct i2c_driver lm8323_i2c_driver = {
 		.dev_groups	= lm8323_groups,
 	},
 	.probe		= lm8323_probe,
-	.remove		= lm8323_remove,
 	.id_table	= lm8323_id,
 };
 MODULE_DEVICE_TABLE(i2c, lm8323_id);
-- 
2.41.0.487.g6d72f3e995-goog

