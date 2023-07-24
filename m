Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546CF75EAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGXF3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGXF3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:29:16 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE52E70;
        Sun, 23 Jul 2023 22:29:05 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bb74752ddbso250037fac.0;
        Sun, 23 Jul 2023 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176544; x=1690781344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/GME1Hrj53Pvx8KllmM1wvoDccOebky6rJzZGwtKkc=;
        b=sC1rIwOryQO7puzRI50w3xszsEUohaNuGEeXrjZyjPh5KAVW2LZOwH5gRecRBz6dkh
         Q3ixrdwHhHIQBtyVNKebtfYjrx36dPE4gjBiQ9PdGKJ/ZceVJlvzeHoliivdvU01fXcv
         GQhRKWdFuY9gXEs2XQTEOT69Hj4Fcuua7HfghpLM+hLQYdngdnOvmYUJ5rlOZaOkg87/
         2rsTIXLIhaZ80fNsfIGaHqNhEuTvBGETtHCMOX6bq3+FCO420fp6yaE1yaOA4/4YF6iC
         WkzQxLm+JPWpHhVI3/HFgszS69F+ycfbYMsyniF140kns3ZoaKEavvBG0epLLVmx2cDQ
         4gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176544; x=1690781344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/GME1Hrj53Pvx8KllmM1wvoDccOebky6rJzZGwtKkc=;
        b=TQi3kCn+eX5JzoWuYt8KxLLcYSZhqD6zXd65oEQpD/hx+sxxNaynF/ih+BUfHQ4WhY
         iLFgx7LSFfEY6abGTa3L3tIxHKLbnmyvYK8Zt9wJ8IH+f215XcahkWDpimp0QRxPk38g
         WlMZPXGYe/4ztY+JVua0n9xCJl88HUmdtF2N0sITKDHsi3Rxzzr7etf/RBH8mkGNH0z+
         Vj7wP6tvXUZY+NL8a9DlPZ9I2QwohlhjXLAIyoA422MrPm7U+Rz71o4cI1opyHDNVurK
         AJ5+w0uMhL7eZy8pOA/5BvmWpFxUzh+NjvUlDHB79gnTOSc24kTN39fCsKP94vAWkcqV
         4N1g==
X-Gm-Message-State: ABy/qLbVJmZF2sXXa+/Ube9Olhk9S3hprqfaBN2czIDfJlCZfka/9ksh
        UBR13Il2l5x+ZaYam3hU5BEZoLuF3x4=
X-Google-Smtp-Source: APBJJlHvQEZ0iUdFHcbaGQEK5yyES+iGI16zu2bLrd3P5f1x4NKvOW9+sQ/KhIgw7y+sYqaJIuZDYg==
X-Received: by 2002:a05:6870:1716:b0:1b0:649f:e68a with SMTP id h22-20020a056870171600b001b0649fe68amr9968395oae.25.1690176544526;
        Sun, 23 Jul 2023 22:29:04 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id fk18-20020a056a003a9200b0064d3a9def35sm6721286pfb.188.2023.07.23.22.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:29:04 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: lm8323 - rely on device core to create kp_disable attribute
Date:   Sun, 23 Jul 2023 22:28:59 -0700
Message-ID: <20230724052901.350240-1-dmitry.torokhov@gmail.com>
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

Device core now has facilities to create driver-specific device attributes
as part of driver probing, use them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 3964f6e0f6af..d5195415533a 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -615,6 +615,12 @@ static ssize_t lm8323_set_disable(struct device *dev,
 }
 static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 
+static struct attribute *lm8323_attrs[] = {
+	&dev_attr_disable_kp.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(lm8323);
+
 static int lm8323_probe(struct i2c_client *client)
 {
 	struct lm8323_platform_data *pdata = dev_get_platdata(&client->dev);
@@ -696,9 +702,6 @@ static int lm8323_probe(struct i2c_client *client)
 	}
 
 	lm->kp_enabled = true;
-	err = device_create_file(&client->dev, &dev_attr_disable_kp);
-	if (err < 0)
-		goto fail2;
 
 	idev->name = pdata->name ? : "LM8323 keypad";
 	snprintf(lm->phys, sizeof(lm->phys),
@@ -719,14 +722,14 @@ static int lm8323_probe(struct i2c_client *client)
 	err = input_register_device(idev);
 	if (err) {
 		dev_dbg(&client->dev, "error registering input device\n");
-		goto fail3;
+		goto fail2;
 	}
 
 	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
 			  IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
-		goto fail4;
+		goto fail3;
 	}
 
 	i2c_set_clientdata(client, lm);
@@ -736,11 +739,9 @@ static int lm8323_probe(struct i2c_client *client)
 
 	return 0;
 
-fail4:
+fail3:
 	input_unregister_device(idev);
 	idev = NULL;
-fail3:
-	device_remove_file(&client->dev, &dev_attr_disable_kp);
 fail2:
 	while (--pwm >= 0)
 		if (lm->pwm[pwm].enabled)
@@ -761,8 +762,6 @@ static void lm8323_remove(struct i2c_client *client)
 
 	input_unregister_device(lm->idev);
 
-	device_remove_file(&lm->client->dev, &dev_attr_disable_kp);
-
 	for (i = 0; i < 3; i++)
 		if (lm->pwm[i].enabled)
 			led_classdev_unregister(&lm->pwm[i].cdev);
@@ -823,8 +822,9 @@ static const struct i2c_device_id lm8323_id[] = {
 
 static struct i2c_driver lm8323_i2c_driver = {
 	.driver = {
-		.name	= "lm8323",
-		.pm	= pm_sleep_ptr(&lm8323_pm_ops),
+		.name		= "lm8323",
+		.pm		= pm_sleep_ptr(&lm8323_pm_ops),
+		.dev_groups	= lm8323_groups,
 	},
 	.probe		= lm8323_probe,
 	.remove		= lm8323_remove,
-- 
2.41.0.487.g6d72f3e995-goog

