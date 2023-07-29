Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0928767A46
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjG2Ax0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjG2AxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39054C23;
        Fri, 28 Jul 2023 17:52:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc7b2133fso17280855ad.1;
        Fri, 28 Jul 2023 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591909; x=1691196709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhjavH3Fl28NglOqou/JvG3XUomwygW/aMjIJstyA5E=;
        b=BGAfF10nL++omXc7+bwaAOM2MreVw58HteryuBDOUweKsX/qyzYjdQF/GbSoxr8zPW
         43RgiystT7Logz8KH4mkphXpv6EeYiNYEFixzVItFvtJz9TAZrmtq8GcyX3yGcm8u2u7
         PUp6ga5ymIgqRSx1CsWVoJ+0BaJTcK+kKTErSCMugUrlgJ+y6ELdbuXB3V49V3wiAwte
         hWVkdMvLS1wgWYA4A5suuj/7GXHWfvWpF3h0JcXrtDUf7QaX4wtdgL405hIdLYrhc4dt
         +tnnS5p3Ods8pxjh/KZ+FYno6rbXv4UQfDSgG7nnWl9tZ05kiwQeEhogFxsZnDhVyJ5m
         M/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591909; x=1691196709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhjavH3Fl28NglOqou/JvG3XUomwygW/aMjIJstyA5E=;
        b=WhCKP99pg5UQ96EJO8vGO9igJHeqnzQ/LFA9lbdQFDhp+WJXar1qeAUA5JXbK2keB+
         BFgNswrO4RRWYojk64If+kA7WuNk+mSoASiz/go7kwO1cib9ldj6I9Rj5LpmQ7hMvaTE
         zYIrsO+h3CrTLvWyhc6V5L9ZkNItD/rps+ImFf2JcFxxcq0WzP7Ac2uFGGiK0cfgb8QA
         pdDER1nBdrFw+kwYjhAyed/VPG99VaImzqY9nc2vuHN0KG/dBoYOHDutzyWYp7ZsITLU
         0EzHBHDYmrj3SH2UUFneLYpWmQb8HclK+3baElQKBJyPALoM+KeWUIr9b4WJogfsQRea
         OYSQ==
X-Gm-Message-State: ABy/qLZFNeaWhhX5qnL8/Rl9Hx9l5T5pSk6GIxkUShi0cyPCWhaKKO33
        IItioBe0JQhKAUrAnzpeyUYcf+p82Oc=
X-Google-Smtp-Source: APBJJlHphoodiAj3ieh8++jVlnP9OkfS7Tmu+sksb9lAaNMjbljF66BCE9c8/ej1UMZRSUPyCVxUMg==
X-Received: by 2002:a17:902:da83:b0:1b8:9b1b:ae8e with SMTP id j3-20020a170902da8300b001b89b1bae8emr3627857plx.59.1690591909145;
        Fri, 28 Jul 2023 17:51:49 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:48 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        JungHoon Hyun <hyunjunghoon@melfas.com>
Subject: [PATCH 16/22] Input: melfas-mip4 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:25 -0700
Message-ID: <20230729005133.1095051-16-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
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

Instead of creating driver-specific device attributes with
devm_device_add_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 2ac4483fbc25..aa325486f618 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1419,10 +1419,7 @@ static struct attribute *mip4_attrs[] = {
 	&dev_attr_update_fw.attr,
 	NULL,
 };
-
-static const struct attribute_group mip4_attr_group = {
-	.attrs = mip4_attrs,
-};
+ATTRIBUTE_GROUPS(mip4);
 
 static int mip4_probe(struct i2c_client *client)
 {
@@ -1514,13 +1511,6 @@ static int mip4_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &mip4_attr_group);
-	if (error) {
-		dev_err(&client->dev,
-			"Failed to create sysfs attribute group: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -1589,6 +1579,7 @@ static struct i2c_driver mip4_driver = {
 	.probe = mip4_probe,
 	.driver = {
 		.name = MIP4_DEVICE_NAME,
+		.dev_groups = mip4_groups,
 		.of_match_table = of_match_ptr(mip4_of_match),
 		.acpi_match_table = ACPI_PTR(mip4_acpi_match),
 		.pm = pm_sleep_ptr(&mip4_pm_ops),
-- 
2.41.0.487.g6d72f3e995-goog

