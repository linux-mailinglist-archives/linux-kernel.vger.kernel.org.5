Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8595767A51
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjG2Ax5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbjG2AxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7535A9;
        Fri, 28 Jul 2023 17:52:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8b4748fe4so18131915ad.1;
        Fri, 28 Jul 2023 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591903; x=1691196703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WiWlMo8N7BlJCcEKqNfovjCGj8L0gu267265Oyn+TE=;
        b=kbl1HaHS+2YZjTHveApVxjEtqiUIsRv1EdXLmi6Qy7JIRfNRnfIE0Ut7WiF4IicsdC
         kACFr8KmokzdUXQkQs6sXaLavSOCfOk8FJTolFFbpeAnv35i+qKvvg83Kp9y/1xN0YYO
         V8ZVqE3Qmk1BMcktogvv+Qcf4vJbcMDycIyhsjn1QPPlNyAkyCtI+Y8mjKMreHaRDXrD
         rOZ9Y72p32KOxPOmNzRh91Wm2Mk2EwIfF4u4US3TWE6QWAtglYGN2FpXE05UKzFVRPhr
         +N+BLeNhKyGN019tTJZzO4o6n4z0+ZYNUOCE9MO4q0xWXJKTq9mFGNwtntoXzW4fb2mi
         +hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591903; x=1691196703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WiWlMo8N7BlJCcEKqNfovjCGj8L0gu267265Oyn+TE=;
        b=O+w4cHHSyViLiWiCnW8FVXLrGsgFtGqfRw6MPnIepoldkbwAQTbibM5KNOfWgiHrun
         3Xi/qT9tGjlrvbBHAY+oPt+EsXm46g4yxElKO2XY46cgmybHLljlHkRN9W8JibutfDh8
         Q7gSpzyZ76JIe2zF9Bn6M68Mquq7ebrbFnxLzdL+8cTUQL/fQL2npxBylODbY5tDk0WA
         /e7wVeiQd19We9i9sErSHDRN2JCPvQAcHZptpKzWYlPHkIgMkxkmjuST6j75MMOUm7q9
         qggcYT2YKlcUUFF1cL3pJf3C0TJOaYZq5D0Pnm2IS/T/kijB30uMAgHvqkQy0XpHiH8C
         yQNw==
X-Gm-Message-State: ABy/qLYz9rboaRWI+xRi/Z1BLF+S9PbAj0kSGU5RZ9BieH/5l6HfrcY1
        5n3tTqDePdpFZpLxKhCHaGzGjgru3TU=
X-Google-Smtp-Source: APBJJlGt/TFeeE/ypV3gcZitnaGyMEIOuasIyG1MUGGYJvxpsio3AHO+DEXBARzRhif6+kIdc8bYEA==
X-Received: by 2002:a17:902:7242:b0:1b8:7fd7:e022 with SMTP id c2-20020a170902724200b001b87fd7e022mr2552370pll.28.1690591902847;
        Fri, 28 Jul 2023 17:51:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/22] Input: edt-ft5x06 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:17 -0700
Message-ID: <20230729005133.1095051-8-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/edt-ft5x06.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 457d53337fbb..3e102bcc4a1c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -580,10 +580,7 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&dev_attr_crc_errors.attr,
 	NULL
 };
-
-static const struct attribute_group edt_ft5x06_attr_group = {
-	.attrs = edt_ft5x06_attrs,
-};
+ATTRIBUTE_GROUPS(edt_ft5x06);
 
 static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
@@ -1330,10 +1327,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &edt_ft5x06_attr_group);
-	if (error)
-		return error;
-
 	error = input_register_device(input);
 	if (error)
 		return error;
@@ -1502,6 +1495,7 @@ MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
 static struct i2c_driver edt_ft5x06_ts_driver = {
 	.driver = {
 		.name = "edt_ft5x06",
+		.dev_groups = edt_ft5x06_groups,
 		.of_match_table = edt_ft5x06_of_match,
 		.pm = pm_sleep_ptr(&edt_ft5x06_ts_pm_ops),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.41.0.487.g6d72f3e995-goog

