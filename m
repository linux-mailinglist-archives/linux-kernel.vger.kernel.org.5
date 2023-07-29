Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CEF767A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjG2AyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjG2Ax0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464B049D8;
        Fri, 28 Jul 2023 17:53:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb8e45185bso17379605ad.1;
        Fri, 28 Jul 2023 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591907; x=1691196707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh239bx9Q1ammpCNJ5dKdqtd7HeLRoc7XKTXlpa6yXw=;
        b=psXW/SFetN1vx8Gdl0lLaxC3tlWzZe7SSBV4JnyDhjqn2A5jFZLilEypT6NlgC/epJ
         Kw9NIdWGYzfIrRxq5R32FmjNwWqMJOrW2IpDxj0IWfqVMsSvjy/Us8sTjS8VujCEvia+
         XozD0pFOIg6j2qUah21ytpAd6qUAFMNiKX2x7i0EaYtu+mjxHWycRBNrWRC23ctN4tnm
         yMEk32ZadqU4OVPBoVyWOAzJ+KvtIVe/OcJC4OZC5sFG11vGMWJdZQ9cu4PwEo1RIFOH
         WXx0CNxVDGaqbSNYVHk1KyyGaxKkzZeQETxm9ZUQBTe3YfIi2HTV8fyybHHkTr0p0d8Y
         o26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591907; x=1691196707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh239bx9Q1ammpCNJ5dKdqtd7HeLRoc7XKTXlpa6yXw=;
        b=CWxx3DFipgQWzzi1O076ru5R/U1RPp2zS8ZqaNMo3TmpCzU3gNBhhtsE58RM8rQT0Q
         j8I7yKM20AHfjuGe8OwD0+F1qdNLUkBZBrTsbcoia19MVbBUAJ78JI5tmMNTJSoKQWOr
         DeDj8x/Vgct4Am1r6Yqrteu8PHrVyZJR5WdpLzJvZkwcYICfuhG7LC6v2/0czeS4e9xt
         9yxhDY5xuZ9twwZur05RTaKCf7PtX9ieoLsSNyXS4Qslm6KYoVZRZeOs3OK36dRwlawS
         lH3TXGD9s93+vCa55fQkyP7EKR82T29tZgdy423/Mov54xtJ4BWx/4eS1Uuef/NToasO
         EF+A==
X-Gm-Message-State: ABy/qLYb1LEctRzd8xgZfURjbc3247CrbUryWF9l7IPFYbqg48lquAC1
        mDkD+Kj5/HcB3Mha5DnohBtaMnffzh4=
X-Google-Smtp-Source: APBJJlG7LFWHXY0VwiN0sVb2S9Y2FQ1zum1GGXBOdgVi9FNpT+KaxmzUi57QOjo0mti3qnvtEwAJeQ==
X-Received: by 2002:a17:902:f547:b0:1ba:fe63:6616 with SMTP id h7-20020a170902f54700b001bafe636616mr3311407plf.6.1690591906665;
        Fri, 28 Jul 2023 17:51:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:46 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 13/22] Input: ili210x - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:22 -0700
Message-ID: <20230729005133.1095051-13-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/ili210x.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index ad6828e4f2e2..31ffdc2a93f3 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -876,7 +876,7 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
 
 static DEVICE_ATTR(firmware_update, 0200, NULL, ili210x_firmware_update_store);
 
-static struct attribute *ili210x_attributes[] = {
+static struct attribute *ili210x_attrs[] = {
 	&dev_attr_calibrate.attr,
 	&dev_attr_firmware_update.attr,
 	&dev_attr_firmware_version.attr,
@@ -904,10 +904,11 @@ static umode_t ili210x_attributes_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static const struct attribute_group ili210x_attr_group = {
-	.attrs = ili210x_attributes,
+static const struct attribute_group ili210x_group = {
+	.attrs = ili210x_attrs,
 	.is_visible = ili210x_attributes_visible,
 };
+__ATTRIBUTE_GROUPS(ili210x);
 
 static void ili210x_power_down(void *data)
 {
@@ -1013,13 +1014,6 @@ static int ili210x_i2c_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	error = devm_device_add_group(dev, &ili210x_attr_group);
-	if (error) {
-		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
-			error);
-		return error;
-	}
-
 	error = input_register_device(priv->input);
 	if (error) {
 		dev_err(dev, "Cannot register input device, err: %d\n", error);
@@ -1050,6 +1044,7 @@ MODULE_DEVICE_TABLE(of, ili210x_dt_ids);
 static struct i2c_driver ili210x_ts_driver = {
 	.driver = {
 		.name = "ili210x_i2c",
+		.dev_groups = ili210x_groups,
 		.of_match_table = ili210x_dt_ids,
 	},
 	.id_table = ili210x_i2c_id,
-- 
2.41.0.487.g6d72f3e995-goog

