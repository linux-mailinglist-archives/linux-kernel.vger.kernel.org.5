Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5015075EADB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjGXFai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:30:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D8113;
        Sun, 23 Jul 2023 22:30:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686708c986so3813751b3a.0;
        Sun, 23 Jul 2023 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176627; x=1690781427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mBfTAXdbECKfZWYSzzClNT1MWFHwf0oInN5lmMc7Zo=;
        b=qelQGmEM8D2UOVsGzWD/+tKcbMFqhP/rsPQhWqRpsciysH+gEYd/tQxhvO8R3RJ6uL
         6TkO9G30DNNlOF0heMtpfmiRniefRngKoQbAQuL+PDWSkuL+edmHNVeTHCyRY6qB0u7Z
         tVTZfV1yEWCyw0bfrekOe+2I1KhK2omSKrxX5xbYx5Zqe1006+Uefmcj6IiqnQ0WaNaJ
         3yJzYZMQ88tnY+xSavK2MR1pQeay5np+NXxrVz136jsaeXqUUUYppL02SBuRZCb2kYTt
         p2T/6fynSBpo0y8ArrOnxe8OAHR/WnFP2tFc9MHOFUO7KYE75PlEOr3nGwN9A37dsmZp
         iA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176627; x=1690781427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mBfTAXdbECKfZWYSzzClNT1MWFHwf0oInN5lmMc7Zo=;
        b=eaSJt+4o4O71GTKC6MM7nuG+scvJuHTjn6QllWvpAuD8DM6JJDPgLudv2F9W7jFxY7
         hqSNBvyyY2UZmC4eUqK0YXEMMvPfTp8yf1qfpHCdf9HnCc35HgWbnUJrTEVeYiwEaRiY
         pMr/TuDhi8uP2wwqkdW+MFiY3lJeLvVOmaCWcijp4DiZdbaQlxlGpx9/zPxt4ddcQCx9
         tK9w6XjIjus4QCXu0wH/CLDa4Yq7XMPav2bCiV9skCjJz+8iQV61O6mWMJx8CQrYt6qk
         pvMPTiTIDiO7jTrWfhNht6uINQzbBLwAufjrqNv2aVyvihRwo6I3RkB4m6pjIaBxtmwx
         iMNw==
X-Gm-Message-State: ABy/qLY537GyjscX6J5fjx/fwlY9unRKEFLIoLaCrfCVWDDzvg7abfvR
        WsMlyqYJBJ5rOiqf2A+D8f8yTNlLw/U=
X-Google-Smtp-Source: APBJJlHMn/Vy0WKXwSzwW9qJEK4mwc1gnQgipnYWmICYuTlhAYX7Fxjh9UYydLw+hphrySGibltl2A==
X-Received: by 2002:a17:902:ead1:b0:1bb:a4e4:54b6 with SMTP id p17-20020a170902ead100b001bba4e454b6mr2369869pld.62.1690176627406;
        Sun, 23 Jul 2023 22:30:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902758e00b001b81a97860asm7801937pll.27.2023.07.23.22.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:30:27 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Input: tca6416-keypad - rely on I2C core to set up suspend/resume
Date:   Sun, 23 Jul 2023 22:30:19 -0700
Message-ID: <20230724053024.352054-2-dmitry.torokhov@gmail.com>
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

tca6416_keypad_suspend() and tca6416_keypad_resume() only configure device
IRQ for wakeup. I2C core already does this by registering interrupt as a
wakeup IRQ in case when device is marked as wakeup-enabled, so we can
simply remove this code from the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca6416-keypad.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 01bc0b881188..906dffbf171c 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -287,7 +287,6 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, chip);
-	device_init_wakeup(&client->dev, 1);
 
 	return 0;
 
@@ -315,33 +314,9 @@ static void tca6416_keypad_remove(struct i2c_client *client)
 	kfree(chip);
 }
 
-static int tca6416_keypad_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	if (device_may_wakeup(dev))
-		enable_irq_wake(client->irq);
-
-	return 0;
-}
-
-static int tca6416_keypad_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	if (device_may_wakeup(dev))
-		disable_irq_wake(client->irq);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(tca6416_keypad_dev_pm_ops,
-				tca6416_keypad_suspend, tca6416_keypad_resume);
-
 static struct i2c_driver tca6416_keypad_driver = {
 	.driver = {
 		.name	= "tca6416-keypad",
-		.pm	= pm_sleep_ptr(&tca6416_keypad_dev_pm_ops),
 	},
 	.probe		= tca6416_keypad_probe,
 	.remove		= tca6416_keypad_remove,
-- 
2.41.0.487.g6d72f3e995-goog

