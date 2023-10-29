Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786AD7DAC46
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjJ2Lsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2Lsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:48:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF1FBF;
        Sun, 29 Oct 2023 04:48:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079f9675c6so5411279e87.2;
        Sun, 29 Oct 2023 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698580121; x=1699184921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffdazMpImFy1FetHdByJmVjSy4MkPy3NHoIgY+vA/6Y=;
        b=dg39IE++4FuepBUfYEniHrmYgnTxrEV5K2PJJBh+pdU0jE4FcbYsV9TgwKH9oe7cDY
         jbgmhk/j3qu67kT03gnptnkWwWtJnU1sLmEWUBeLl8EMaq4Sj8dbV6fjtFBfJU4xsptw
         PLHB5tRnlwggLwyKMPWZpBBIEgZ7XLSKC/gwgMZzuJnQRzdO0SDBYu78s9Z22xnhJKOf
         MOBp2JJy3wbb0Wy5KM7O86rBBUD6K5wg5HUPH4dTiZrjsx5E+8yHO8tlMJIXx3N6Iios
         gp2J9BsteuM76mlhyT0dMdxwspjow8b21LwVnCF4mg8Y1f3qdbmmuUsAeyEglN17TD35
         7wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698580121; x=1699184921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffdazMpImFy1FetHdByJmVjSy4MkPy3NHoIgY+vA/6Y=;
        b=wd/93cxkjwzlBYcusGUz+3Q4ItkVebh5hHkCaupt9hdFV5A4T7NbinAUJxDyGmD6HZ
         HlgMjq6CtpDoeQ9ND04CXJy2jePlW+WDnlc28R3TyZfkIjEJCKFHO9RwCbm6ZMK23+FI
         9USvEDRmzI4lO46iKtVnizuqlorvDck1K5R/F4xF1QxT9Ac9TR8V3vEyzxSDdTFLEsHi
         5WieMCFTjKfeeTH5DSCf9IeAhH7Lxy2qyW7BRUe/ik/rvh5Dl0F61hezsTUqb0b4lLxq
         mtnQn1Uqey2SONvU5zg+pSYXYcjXZkzVJyjTZZWs364pW84hJoffZZFsO25FV5CyZ30U
         lviA==
X-Gm-Message-State: AOJu0Yw8ApFVb2WBRaYHS6Ywozd7zjDeRhWMK/fMz/Ux8TNExOF+fznB
        qr+/HofxIX3o3a9apulw38o=
X-Google-Smtp-Source: AGHT+IGGEFN9dF9/qUdc8I54PBYmXWj2i/68f+/tnbsYXwGqFU/BfZzXtg+hd3Gsw9smrCdydi9yPA==
X-Received: by 2002:a19:7004:0:b0:507:9b93:274b with SMTP id h4-20020a197004000000b005079b93274bmr5263657lfc.26.1698580120678;
        Sun, 29 Oct 2023 04:48:40 -0700 (PDT)
Received: from localhost.localdomain (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id ep7-20020a056512484700b00503f39e6bcesm1012464lfb.95.2023.10.29.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 04:48:40 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     tony@atomide.com, lee@kernel.org, robh@kernel.org
Cc:     wens@csie.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: twl4030-power: Revert to use of_match_device()
Date:   Sun, 29 Oct 2023 13:49:09 +0200
Message-ID: <20231029114909.15652-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core twl chip is probed via i2c and the dev->driver->of_match_table is
NULL, causing the driver to fail to probe.

This partially reverts commit 1e0c866887f4.

Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/mfd/twl4030-power.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 1595e9c76132..e35b0f788c50 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -27,8 +27,8 @@
 #include <linux/pm.h>
 #include <linux/mfd/twl.h>
 #include <linux/platform_device.h>
-#include <linux/property.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/mach-types.h>
 
@@ -883,6 +883,7 @@ static int twl4030_power_probe(struct platform_device *pdev)
 {
 	const struct twl4030_power_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *match;
 	int err = 0;
 	int err2 = 0;
 	u8 val;
@@ -903,8 +904,10 @@ static int twl4030_power_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (node)
-		pdata = device_get_match_data(&pdev->dev);
+	match = of_match_device(of_match_ptr(twl4030_power_of_match),
+				&pdev->dev);
+	if (match && match->data)
+		pdata = match->data;
 
 	if (pdata) {
 		err = twl4030_power_configure_scripts(pdata);
-- 
2.42.0

