Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C6767A44
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjG2Axi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbjG2AxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D663C3B;
        Fri, 28 Jul 2023 17:52:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-563f4e49ff9so1539952a12.3;
        Fri, 28 Jul 2023 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591911; x=1691196711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHWHJPusj/tr4ofRWYliJ6SaLkd1ssdiXE1hqXu1re0=;
        b=F4vxxi4kwHOZdYfgmMA0F5BVaCEIykgpQd8vSCVz1MXNb986hs8DzylodiUYCBo5B4
         mOzkMukYC/v514T23WE180NX4vc2NbsTKdrqJZZX5yrhNtTE0A4kfdPJGqE4Ldhu7fpP
         cttRiBiI+lV7B5cfSnyco0QxeBREcBK195xUiOOkU61bnWAXJRknK2I+S8BWNySyVUed
         x1zgm4LciCOugW4/e9jVVBdlwSa7U0ZU23VzrqPKnCkhueT7N1lIVCoW1JW4DgE/ZQLw
         Eg/U420+VARIyBaE9ATDSEc91KpL323VwkKxDMl00sqFdSxYHwvZaNJXXjrERRFvH+PS
         31TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591911; x=1691196711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHWHJPusj/tr4ofRWYliJ6SaLkd1ssdiXE1hqXu1re0=;
        b=YVNVF69+TZIf6nbVisiHDOyi+CiTLF0GbxhnlqYCtALFreXbLP0zaLD67qnokHHYVo
         5N3xzfj6Eb89pawLE/OGlrgF1X7yG4aBN+KNZfL4FeZoWP/zFPNwXygLhnSF7WAcrZ/g
         W+peo+IlGltt99WCGEmMZZOOIEvMJyWKKL363dcZEpPXHln5/lMVW/pXbGjM7jgmxNoS
         tM+re1GY+syNtoZnCa+NdWC3FgPE0UkNLYt3flLAuaHa6TLF59z20rhrn2BfUBvXxCNM
         qeCXkotwjFPIRDqFM9gBvYYbLQk+drKXI9j3LGs7yAI7UCeTWV9q9Dl6WCqT8I1AVmCW
         slAQ==
X-Gm-Message-State: ABy/qLZTaPLJpgqctMp7OOe38nAhEL8xpbAZP1QRf30IGvHnRFzP5sdy
        BSx4yTEihIAiY+p6hMwOVMHXVzwL62k=
X-Google-Smtp-Source: APBJJlF7RGwf+zbqv4Ag1IqqCQ+Hz6WZoc0vXCQB92RiINcNvZ7bf5Bq2oS15kO5BAhU/vC6QLbxkg==
X-Received: by 2002:a17:902:bc87:b0:1b3:f5c3:7682 with SMTP id bb7-20020a170902bc8700b001b3f5c37682mr2716594plb.68.1690591911435;
        Fri, 28 Jul 2023 17:51:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:51 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 19/22] Input: s6sy761 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:28 -0700
Message-ID: <20230729005133.1095051-19-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/s6sy761.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 998d99d18911..149cc2c4925e 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -286,10 +286,7 @@ static struct attribute *s6sy761_sysfs_attrs[] = {
 	&dev_attr_devid.attr,
 	NULL
 };
-
-static struct attribute_group s6sy761_attribute_group = {
-	.attrs = s6sy761_sysfs_attrs
-};
+ATTRIBUTE_GROUPS(s6sy761_sysfs);
 
 static int s6sy761_power_on(struct s6sy761_data *sdata)
 {
@@ -465,10 +462,6 @@ static int s6sy761_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
-	err = devm_device_add_group(&client->dev, &s6sy761_attribute_group);
-	if (err)
-		return err;
-
 	pm_runtime_enable(&client->dev);
 
 	return 0;
@@ -535,6 +528,7 @@ MODULE_DEVICE_TABLE(i2c, s6sy761_id);
 static struct i2c_driver s6sy761_driver = {
 	.driver = {
 		.name = S6SY761_DEV_NAME,
+		.dev_groups = s6sy761_sysfs_groups,
 		.of_match_table = of_match_ptr(s6sy761_of_match),
 		.pm = pm_ptr(&s6sy761_pm_ops),
 	},
-- 
2.41.0.487.g6d72f3e995-goog

