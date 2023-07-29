Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4E767A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjG2AyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbjG2AxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234644A9;
        Fri, 28 Jul 2023 17:52:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54290603887so1631042a12.1;
        Fri, 28 Jul 2023 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591904; x=1691196704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2J00FDl/2dzmub7biLB0NwIVNSlyZGs+22SsVBL+Rk=;
        b=P8h3hg9vcBW16XQ6Fz/4Eo81SZcoa0Ttrh7v/SDyQsWVVrZ8bVZmWSkTgrrRpBtnJD
         /YibsVTiItQKPjTD1wvaar4K5mbPeg3shsZvvs39BhYtUmF7Fn8QYx/GSb99+G7LLEvH
         Ug3/tQop3PglTr2evoz32ppERGEcGHfCdzQ6QBtpgly1kl3fuc5wJywZnGLvBGJB96hx
         6EMVjoLC8b3qbA9OtHC//MTlLsyuh5ScFlHGknY9LzZy2QkZr5yT86v0FqTQfKg0BKxk
         TFNPHidE5ZdLNci8vQpudSwshOVUMEWBCOBY5J6efMuCZ7D7JkG2BbhYPWgJDo6DDp3W
         6wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591904; x=1691196704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2J00FDl/2dzmub7biLB0NwIVNSlyZGs+22SsVBL+Rk=;
        b=gjg/lCr/bG7tswfh9UV8/ZLwo4xYz5dSHjvTFsWWqKhrnCIfy0Z712O1MoyZ1eT7yH
         B+FsJb8yQi+1wwaEdLETFQgCYim62FLw3vpyLZWwX+ssF2J3tyrY6zKqmFTpoze8OrAf
         KYwWTUmhxDpC5l/TZL7KtXA5cepnUJs4VkSGHaNXrVM6qHA1vGuyOVF5Q/O8O6lluMVC
         VB+afIMevGP7d8PksgVBMS2JLX0Ha/+xlOz7+9IyM1avleal3UgVaPbIz8MCvLDg1iO4
         WQYUm5AqorkVHZx5uiV7orl3DML1hSV9OgQF7/thUZ8I4KxUqDldoY8GYfYuFNzSBDcP
         IlKQ==
X-Gm-Message-State: ABy/qLZm/6x8GwErDnQ6PcuroCenARsxM16Ky1t+LUWzbSSeNiWoRC7A
        4O5n/EW/p6CWHeYKO24eFDORWcIzihA=
X-Google-Smtp-Source: APBJJlGhjy8MDDzPlgA3gWXisxwQrXLnP7CBYEY13mNxr04k9VTB7qNViQtnvKKp8Lo7LHdgh7lRmg==
X-Received: by 2002:a17:90b:1403:b0:268:1e9:53bf with SMTP id jo3-20020a17090b140300b0026801e953bfmr2686931pjb.37.1690591903675;
        Fri, 28 Jul 2023 17:51:43 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:43 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH 09/22] Input: elants_i2c - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:18 -0700
Message-ID: <20230729005133.1095051-9-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/elants_i2c.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index a1af3de9f310..365765d40e62 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1299,7 +1299,7 @@ static ELANTS_VERSION_ATTR(solution_version);
 static ELANTS_VERSION_ATTR(bc_version);
 static ELANTS_VERSION_ATTR(iap_version);
 
-static struct attribute *elants_attributes[] = {
+static struct attribute *elants_i2c_attrs[] = {
 	&dev_attr_calibrate.attr,
 	&dev_attr_update_fw.attr,
 	&dev_attr_iap_mode.attr,
@@ -1313,10 +1313,7 @@ static struct attribute *elants_attributes[] = {
 	&elants_ver_attr_iap_version.dattr.attr,
 	NULL
 };
-
-static const struct attribute_group elants_attribute_group = {
-	.attrs = elants_attributes,
-};
+ATTRIBUTE_GROUPS(elants_i2c);
 
 static int elants_i2c_power_on(struct elants_data *ts)
 {
@@ -1552,13 +1549,6 @@ static int elants_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &elants_attribute_group);
-	if (error) {
-		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
-			error);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -1667,6 +1657,7 @@ static struct i2c_driver elants_i2c_driver = {
 	.id_table = elants_i2c_id,
 	.driver = {
 		.name = DEVICE_NAME,
+		.dev_groups = elants_i2c_groups,
 		.pm = pm_sleep_ptr(&elants_i2c_pm_ops),
 		.acpi_match_table = ACPI_PTR(elants_acpi_id),
 		.of_match_table = of_match_ptr(elants_of_match),
-- 
2.41.0.487.g6d72f3e995-goog

