Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618E575EABF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGXFN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXFN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:13:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D4DE40;
        Sun, 23 Jul 2023 22:13:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a3373211a1so2373547b6e.0;
        Sun, 23 Jul 2023 22:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690175629; x=1690780429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caoeUxdk/bY/30hShXkM8xzsEfv9tOC0PQvdZObEqiY=;
        b=KYD9a4ljlBeWIzDK9kSM+wtkeKt3bOrazkF5Xp838g3RE1NG9jTSHD/pFsqgGvB8pH
         SKWeeBfl2HV2aMTyoGX3ingxOXm0C3fabo5d1/NoM8vpoxGQr/4ZPHz9e/BmSd4mRqPm
         u2EMUUmFr3TfhsDfhyRQTnJm2V6Lx2LsKP9XaX+yuzg463Im6sZRUnULiXsV7cdG7JYc
         v9Twr8zm/d9pxtQeIwPnqSO1O1c73aJZCaWwVZmb115l8Wg1lzsWQMkmvOxqnR1IxXw8
         HhzI0MYiHSmvisooFrdUvjvs6Md5ffI0KQiupCqjboAphXLLFOP7F8X294iRF0eFLzsr
         Jt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690175629; x=1690780429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caoeUxdk/bY/30hShXkM8xzsEfv9tOC0PQvdZObEqiY=;
        b=OWcxKub/2T78QX4qcQty/6vxk9yvx38alH7g0uQAIdfITfhUlcdK30sN5Oxwi2Cw+I
         AAaRj0Hvq9b9dPQso6SP41rkK1yc2G0WjfWV67ahyIsMVNTQ/tpd9gm9yScP9pilU195
         kluVqHLgxC98MVKDdj71PozXC807n9kQ7tDscdcORS2P9OpuoPvBFbrVx6w4SBdLX35U
         7C6sKeWcrvTh6o7tfxUvrDxSCu7u/YsnyGWH6MoSgvHnbzN38a2TSBTWviALKrRoCk1A
         SAmoofEPzzpL/36ni3VehooizIqq7liYo6V3Idi8GYoHIxREW7XPPCgq44TaezxRMOc3
         3SEQ==
X-Gm-Message-State: ABy/qLa8akFiO0BQsXvMpj1EnNKfdxpCpAQOXirVJLK0/i5Hu7slchvQ
        ABb3p25etODX+vTP6Bk25lltsH/+jow=
X-Google-Smtp-Source: APBJJlEDCNOx+kTZCCY18koIORa1WIU3zN1YrwleKmbxpXbt6hOx2rpIGov6fTFkU+iz2ubrKMu+dA==
X-Received: by 2002:a05:6808:a97:b0:3a4:947:c97b with SMTP id q23-20020a0568080a9700b003a40947c97bmr9726446oij.0.1690175629481;
        Sun, 23 Jul 2023 22:13:49 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id gv17-20020a17090b11d100b00265dc26d8dfsm7501106pjb.27.2023.07.23.22.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:13:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Input: qt2160 - tweak check for i2c adapter functionality
Date:   Sun, 23 Jul 2023 22:13:39 -0700
Message-ID: <20230724051345.335219-1-dmitry.torokhov@gmail.com>
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

i2c_check_functionality() returns essentially a boolean and not an error
code, so treat it as such.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 599ea85cfd30..b0b9d7a2691e 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -345,12 +345,9 @@ static int qt2160_probe(struct i2c_client *client)
 	int i;
 	int error;
 
-	/* Check functionality */
-	error = i2c_check_functionality(client->adapter,
-			I2C_FUNC_SMBUS_BYTE);
-	if (!error) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
 		dev_err(&client->dev, "%s adapter not supported\n",
-				dev_driver_string(&client->adapter->dev));
+			dev_driver_string(&client->adapter->dev));
 		return -ENODEV;
 	}
 
-- 
2.41.0.487.g6d72f3e995-goog

