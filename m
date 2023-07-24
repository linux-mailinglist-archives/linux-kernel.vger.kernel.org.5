Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FC75EADD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGXFar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXFad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:30:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF811A3;
        Sun, 23 Jul 2023 22:30:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9c368f4b5so31930445ad.0;
        Sun, 23 Jul 2023 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176628; x=1690781428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V66bJv3ffs5NyeopA0TuaqhZ6vwYum3/23pBHpOv8l4=;
        b=V+YLo1+BHfpaEdt6D5L9vRwdhNEtxamsi7pL+3rF67yyaOj3qFTmnIY7kGJveM09qV
         C432RIVgidJl0AwPyrnrxzC/zNjhYpIQgYWCH9rfX95kJXxyyNoAMZMrDzGj5jQYmFgX
         jvYoYpHUqGLnWcFHVjHXSayY/BYz4T6IIoDgHow0ocJHRElg8J/W2mjrIkv70QtPk5db
         3K2ITF/gWsX/0wsDYx32qARoMg55W9qn1zWZwmOtUim5pe0IUljETVQuPJ11tnuGQX1y
         Ed1mB+nkdVO695TyWGhCgkuTZTo+FajWBji1enIfXNd9STLmD4NX3liacfJNB+4x/F74
         eCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176628; x=1690781428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V66bJv3ffs5NyeopA0TuaqhZ6vwYum3/23pBHpOv8l4=;
        b=M3Gssj+t4Yfoq3xJNPXwXTXlUVtRbIHwjRBIkgYW99iIoNV0LoLQnJVjy/6JLBDZUS
         95wtm0u2qFSFGT1VJPYR70jTwZMSlEuJCm4DJgznnI0XK8UiFiCrIZ0neFxh3vhIf/KT
         hrkgvyyHirmhzBD3CkieI2L9HeUmHw7HzjkoZakZbqM/7u6TuiE/w+LHZEm9olaM7naJ
         1F5/JUkIvDyj2JMlv96n7vaE7f01JFiyBm9J3AgQgDyQmEaMA+RHGyKT/nLozovO60ii
         YwF8fss1KTPM++sAdixeZTKg0Zq+Qjj83B3xes9fPQAOz1FJW8D7seTYVMyparb0YFdF
         /Xjg==
X-Gm-Message-State: ABy/qLaE8v91V4oa2zB2yHGjEqYUCX1p1d6qoPnjVUcsYmovotNKQhZs
        bOI8RmMyGDbJweUq68GFfKGRSR1jGDM=
X-Google-Smtp-Source: APBJJlH00b55EgKKMXXsqv81oQYytRgotiqh5d6sxPwAtQNnrObdSDgo1I/HUu7GZmFrD0mPJ0kGAw==
X-Received: by 2002:a17:902:ecc1:b0:1b8:c6f8:d9b with SMTP id a1-20020a170902ecc100b001b8c6f80d9bmr11689251plh.34.1690176628245;
        Sun, 23 Jul 2023 22:30:28 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902758e00b001b81a97860asm7801937pll.27.2023.07.23.22.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:30:27 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: tca6416-keypad - fix interrupt enable disbalance
Date:   Sun, 23 Jul 2023 22:30:20 -0700
Message-ID: <20230724053024.352054-3-dmitry.torokhov@gmail.com>
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

The driver has been switched to use IRQF_NO_AUTOEN, but in the error
unwinding and remove paths calls to enable_irq() were left in place, which
will lead to an incorrect enable counter value.

Fixes: bcd9730a04a1 ("Input: move to use request_irq by IRQF_NO_AUTOEN flag")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca6416-keypad.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 906dffbf171c..21a2f2de4345 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -291,10 +291,8 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	return 0;
 
 fail2:
-	if (!chip->use_polling) {
+	if (!chip->use_polling)
 		free_irq(client->irq, chip);
-		enable_irq(client->irq);
-	}
 fail1:
 	input_free_device(input);
 	kfree(chip);
@@ -305,10 +303,8 @@ static void tca6416_keypad_remove(struct i2c_client *client)
 {
 	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
-	if (!chip->use_polling) {
+	if (!chip->use_polling)
 		free_irq(client->irq, chip);
-		enable_irq(client->irq);
-	}
 
 	input_unregister_device(chip->input);
 	kfree(chip);
-- 
2.41.0.487.g6d72f3e995-goog

