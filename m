Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127C767A42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbjG2Axp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjG2AxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F89421D;
        Fri, 28 Jul 2023 17:52:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso22012705ad.2;
        Fri, 28 Jul 2023 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591912; x=1691196712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOdo3WS1rinIQ73LQo2Hq0iDUs9lcLtFTTbcX/WR8IM=;
        b=fTWaWXEjBF6L7h4TWCGYSuwqt8Aq8CszC6zBArWUbQ72N6vWhebdZoVkX0Z1q72Ys3
         BHaAZdDICKDRA6fEcEeLUFGJUiI3fBR95QUaHXh0iGBlQu/B4oMCIMeRDPtM/ZdZeQ2b
         acTIXWPMKJMdZoE+TbwCwVRFBbWOY5NI3DXMLemZ9hKg+gJL4GixyPPSpJd3SwjraXUx
         Ygk06FdnvQMfmfzQyRz2lfSXxRTEKOheobQNFQBUo1tR6UNs1UvY7S3UiuYNfSL9+RoI
         hMG0yw0PFLZJWkLRfqh2W1z02ojFXUThwnrNiGWt1Ahilfsmm3R8cTt0eOXbU40Qri0N
         Crmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591912; x=1691196712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOdo3WS1rinIQ73LQo2Hq0iDUs9lcLtFTTbcX/WR8IM=;
        b=RvhGrE7FHLnUueAigR/hpG/e2bN90cXk3KOveWDwl50f7WAeYqf0E6JqJL44IOSZQQ
         YUrNMtVzf2qKnkWOkY6qnymrv/w1bSDnX4awMQOW+d0sTl+vpuYz+mjjsTHA2byVnFYE
         65z+WMcoDIqpKOjAptm3Biz3TwPLCwL6KUV0HNlfYA5ZLevdddaL9eM9tV4UPhzAgAqQ
         jssrYEJPin2HeAJ5ATjkwcElCl+fqbba2/XoWR/EJ4LikB3UHGd0NmURhLnftq7IoFVp
         GCIuufnK27WIaYl8RJZJQWJLhNrxh/SjVtAxLRnUY3b3PMywXZUC22wBi1PDiOGbN5j5
         9kkw==
X-Gm-Message-State: ABy/qLbT/6EHRMLD0dczuzvMnFzjocCqDkU0xUdTzXtodCfBRG9k+FZZ
        CPcitvb9ZLHR2lxHem/LmBqwHQSR9yY=
X-Google-Smtp-Source: APBJJlGTjnNzq1tqygHb0Oce5NEBSya7FDgbbVya48yIukMVYn5UlNcYt12RfDcWrK47vUfR27I1iQ==
X-Received: by 2002:a17:902:f685:b0:1bb:9f0e:7b46 with SMTP id l5-20020a170902f68500b001bb9f0e7b46mr3684949plg.1.1690591912302;
        Fri, 28 Jul 2023 17:51:52 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH 20/22] Input: stmfts - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:29 -0700
Message-ID: <20230729005133.1095051-20-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/stmfts.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 56e371fd88fa..85010fa07908 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -517,10 +517,7 @@ static struct attribute *stmfts_sysfs_attrs[] = {
 	&dev_attr_hover_enable.attr,
 	NULL
 };
-
-static struct attribute_group stmfts_attribute_group = {
-	.attrs = stmfts_sysfs_attrs
-};
+ATTRIBUTE_GROUPS(stmfts_sysfs);
 
 static int stmfts_power_on(struct stmfts_data *sdata)
 {
@@ -727,10 +724,6 @@ static int stmfts_probe(struct i2c_client *client)
 		}
 	}
 
-	err = devm_device_add_group(&client->dev, &stmfts_attribute_group);
-	if (err)
-		return err;
-
 	pm_runtime_enable(&client->dev);
 	device_enable_async_suspend(&client->dev);
 
@@ -804,6 +797,7 @@ MODULE_DEVICE_TABLE(i2c, stmfts_id);
 static struct i2c_driver stmfts_driver = {
 	.driver = {
 		.name = STMFTS_DEV_NAME,
+		.dev_groups = stmfts_sysfs_groups,
 		.of_match_table = of_match_ptr(stmfts_of_match),
 		.pm = pm_ptr(&stmfts_pm_ops),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.41.0.487.g6d72f3e995-goog

