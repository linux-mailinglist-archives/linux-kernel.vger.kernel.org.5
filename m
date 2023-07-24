Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F175EAD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGXFae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGXFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:30:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B7E40;
        Sun, 23 Jul 2023 22:30:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55c85b4b06bso1837910a12.2;
        Sun, 23 Jul 2023 22:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176629; x=1690781429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGoE1fntbnB7lNqsw0Y5id7dATDTKpa2h3lFuJESfyY=;
        b=CFRQYSKhzjIomrTxQg+sRqUBUBs16XaKWFyxW9nMutG+2Zojcc189NkDW+q7WOQxnD
         S3HWeERTKvY7N9I4rhPHEAep28x/6/89ItIsYdmwvAEXf/rplqWIxrDXfQdRzHr+RAbd
         Xl+pvzC/g+kge9wXQruKktoutaSrp8ueBA6sMIJhaami4AWh2bk3e6OrArdLcefUVYYU
         piKBB7rqk1wG3b7dfJjqDwsPkDiptC6c+q4z5wyoZrVO/QgSjYOS3e/2pwIjHrjsb0r0
         qkYalMOYSGS1/ptPMmlSpr2k79B7+KGUXt9Hz+YOEjV6RDCHVM7CaAppdPDqazcDPHZf
         l8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176629; x=1690781429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGoE1fntbnB7lNqsw0Y5id7dATDTKpa2h3lFuJESfyY=;
        b=Kez2m4eRmntfee8bkcADLb7ZTeNyNnoF3dqdHZNNM/y3qz37Yu+AuJ7H4uVkWgGX+Y
         +ORsSTyaPWrxzgtkHe002RYuQfUICJ0gtilu1xdpy1xX0U+pjp8l6QCblON0f2s+4+Sy
         C0QMN9GgvUWDDE6r7J8JQ1wJ8yMXt/smW2uvmhbxh2SV4P0IP5v8E7pYohFP6LQnhoSU
         V7JdVnP3yCUN/T1+VvE0VxUyhNIETUd3yLCbk/lV47PWlgOE8QhBpam9FU8w/7FIBM1A
         jZqtQEs8pmz/pkiaagDV/S3xSJGw0RpcAJqFX8SFcf9GQcaLb9aRdgr7f80OXBhaF7xI
         bi/g==
X-Gm-Message-State: ABy/qLb5x+LZAu0Bv26BsfowbfqWfXlsd+Wp3Dn1wluEjuA0yxfid823
        I4AJQQNMKWe3nC8HRmE1UYksc4eubZk=
X-Google-Smtp-Source: APBJJlGppRyh3Fj1sqKunNqzpGatEQ1A/yZ8yUc/G5w2gKOOGT0Jq+IvNbNpiY8/cxvTphOajGkUHQ==
X-Received: by 2002:a05:6a21:9988:b0:106:25b3:2f92 with SMTP id ve8-20020a056a21998800b0010625b32f92mr8233714pzb.52.1690176629281;
        Sun, 23 Jul 2023 22:30:29 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902758e00b001b81a97860asm7801937pll.27.2023.07.23.22.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:30:28 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Input: tca6416-keypad - convert to use devm_* api
Date:   Sun, 23 Jul 2023 22:30:21 -0700
Message-ID: <20230724053024.352054-4-dmitry.torokhov@gmail.com>
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

From: Yangtao Li <frank.li@vivo.com>

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca6416-keypad.c | 53 +++++++++----------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 21a2f2de4345..ff665319791e 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -216,12 +216,15 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	chip = kzalloc(struct_size(chip, buttons, pdata->nbuttons), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!chip || !input) {
-		error = -ENOMEM;
-		goto fail1;
-	}
+	chip = devm_kzalloc(&client->dev,
+			    struct_size(chip, buttons, pdata->nbuttons),
+			    GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!input)
+		return -ENOMEM;
 
 	chip->client = client;
 	chip->input = input;
@@ -233,7 +236,6 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 
 	input->phys = "tca6416-keys/input0";
 	input->name = client->name;
-	input->dev.parent = &client->dev;
 
 	input->open = tca6416_keys_open;
 	input->close = tca6416_keys_close;
@@ -263,19 +265,20 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	 */
 	error = tca6416_setup_registers(chip);
 	if (error)
-		goto fail1;
+		return error;
 
 	if (!chip->use_polling) {
-		error = request_threaded_irq(client->irq, NULL,
-					     tca6416_keys_isr,
-					     IRQF_TRIGGER_FALLING |
-					     IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					     "tca6416-keypad", chip);
+		error = devm_request_threaded_irq(&client->dev, client->irq,
+						  NULL, tca6416_keys_isr,
+						  IRQF_TRIGGER_FALLING |
+							IRQF_ONESHOT |
+							IRQF_NO_AUTOEN,
+						  "tca6416-keypad", chip);
 		if (error) {
 			dev_dbg(&client->dev,
 				"Unable to claim irq %d; error %d\n",
 				client->irq, error);
-			goto fail1;
+			return error;
 		}
 	}
 
@@ -283,31 +286,12 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	if (error) {
 		dev_dbg(&client->dev,
 			"Unable to register input device, error: %d\n", error);
-		goto fail2;
+		return error;
 	}
 
 	i2c_set_clientdata(client, chip);
 
 	return 0;
-
-fail2:
-	if (!chip->use_polling)
-		free_irq(client->irq, chip);
-fail1:
-	input_free_device(input);
-	kfree(chip);
-	return error;
-}
-
-static void tca6416_keypad_remove(struct i2c_client *client)
-{
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
-
-	if (!chip->use_polling)
-		free_irq(client->irq, chip);
-
-	input_unregister_device(chip->input);
-	kfree(chip);
 }
 
 static struct i2c_driver tca6416_keypad_driver = {
@@ -315,7 +299,6 @@ static struct i2c_driver tca6416_keypad_driver = {
 		.name	= "tca6416-keypad",
 	},
 	.probe		= tca6416_keypad_probe,
-	.remove		= tca6416_keypad_remove,
 	.id_table	= tca6416_id,
 };
 
-- 
2.41.0.487.g6d72f3e995-goog

