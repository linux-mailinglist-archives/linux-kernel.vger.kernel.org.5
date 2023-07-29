Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA756767A37
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjG2AxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjG2AxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAB935A8;
        Fri, 28 Jul 2023 17:52:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb2468257fso16171525ad.0;
        Fri, 28 Jul 2023 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591899; x=1691196699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOqwUZOD3iGOUgPMbPI/eioSmDoBO3NjKtRLPGRngeo=;
        b=lhNeigezZwzRoJxUcVIY8eGjZOf6ViWmOH8wNGgE904YXd/PWlxKLBMtpcxnC2O7uU
         LaiStYLBngBWZHLJ6LIPGJ1KgyPllwqqH6KnVObuqbimpo0wYm6EnnYZ58yG++rSu8pS
         ahc4RzUerC6KqoK1fxF9OUCS70SkW1kS1TbOV1/Rcdi/CYGCHmuB+o9Tfd0zLe1QnmpX
         j5DzzllfDYhoeXk5fnXnmQ2urzbRuSj7OgA7tMhOPwsvofaeE6c+500dmmWmridyQBKI
         b634CB/e9qIlGo2QnJhkY3XDovSkRF3YWmvzP/KPUUwzvHluXDqKr8p81S5hZ6fP98mK
         +OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591899; x=1691196699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOqwUZOD3iGOUgPMbPI/eioSmDoBO3NjKtRLPGRngeo=;
        b=MWhRrFRS7z1pt5xY+lOlSFAgXWKxe4pbICyhuI3CHkqM9DF1ckn2kDkGZy0fWpdcdE
         xHnekH2IdxwoWokixXo7maQ+E1jYEmLoZo1C6maLfOk7NAd5D60sUrWiH9df2hs5Rrew
         B65q4s5XRArblWoJV6vl45uOeU876XmwNn/ywi4825ay724XSRvo/KvJARv/6m63TyZk
         DLkR2i2lz4UODBTRYinBryhExcS3Y4eef90DBFwhT1yqAujACFhMEuaf06XCtre3cist
         DvvUmGVPiljkwLwUaLNyvsUEi4FSBlGuN4SBcWjZrvB22xAynovjoEaFmxqPM+bMRLUc
         fFSw==
X-Gm-Message-State: ABy/qLYj2SPuRwYzyHce9WVjbPocE+rW/H45Km89C/aunvSpY5kCp4/0
        9j/xNd6++zEWeX8EjsPMrus8HkDmpsw=
X-Google-Smtp-Source: APBJJlE4WYWVihtD0HtEWfNAjBmNOjMXBbBlyhlU2Jj6cdGH2CzmhllEiTfzl6zveHjaqH43JuZ+SA==
X-Received: by 2002:a17:903:32d1:b0:1bb:d59d:8c57 with SMTP id i17-20020a17090332d100b001bbd59d8c57mr3190807plr.18.1690591898798;
        Fri, 28 Jul 2023 17:51:38 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 03/22] Input: iqs269a - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:12 -0700
Message-ID: <20230729005133.1095051-3-dmitry.torokhov@gmail.com>
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
 drivers/input/misc/iqs269a.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index c0a085639870..3c636c75e8a1 100644
--- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -1586,10 +1586,7 @@ static struct attribute *iqs269_attrs[] = {
 	&dev_attr_ati_trigger.attr,
 	NULL,
 };
-
-static const struct attribute_group iqs269_attr_group = {
-	.attrs = iqs269_attrs,
-};
+ATTRIBUTE_GROUPS(iqs269);
 
 static const struct regmap_config iqs269_regmap_config = {
 	.reg_bits = 8,
@@ -1671,10 +1668,6 @@ static int iqs269_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &iqs269_attr_group);
-	if (error)
-		dev_err(&client->dev, "Failed to add attributes: %d\n", error);
-
 	return error;
 }
 
@@ -1743,6 +1736,7 @@ MODULE_DEVICE_TABLE(of, iqs269_of_match);
 static struct i2c_driver iqs269_i2c_driver = {
 	.driver = {
 		.name = "iqs269a",
+		.dev_groups = iqs269_groups,
 		.of_match_table = iqs269_of_match,
 		.pm = pm_sleep_ptr(&iqs269_pm),
 	},
-- 
2.41.0.487.g6d72f3e995-goog

