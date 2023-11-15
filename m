Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8431C7ED51C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbjKOVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbjKOU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:59:51 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF462173B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:59:05 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b2e72fe47fso63616b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081945; x=1700686745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWue5MGrIGXtdwa0DXl26EeYVBaPfv4b8agF9tN7BTk=;
        b=YofpyesxDUNmWDWE91fSi5uorgYYyWs0Jxh9dIidcyyMR8o116h8CyvPKvmjmg9gKb
         taONfl+X6CqxmaIbtKaP8HE42GXoUdEtQ+jf1+3ow/hU4L2fLsPy6yOkY9x58mQFI2wQ
         5A5Evsz/qywQf33L/vEPVzx6hSZzVrhKyjkBWnE82XGnD+shObhS7NjEULitzuhVCYzR
         kCZSdYaMKk+PeojB+WmC5Hccs7ccddBf4KgYKWn1A30IXbcVyxhnlLyrWoPuCXvwV48W
         xxCnPSNkesfz+fKyBh7zJqtT67/6nvbSnVHqr7aKOqjvVcEBxGE+kUP+CPM5WZBaaHuw
         Wgzg==
X-Gm-Message-State: AOJu0YxX5HrWM5DFhq7+9ooykIUlaXYKTIE7zk1umAw54TC7szd2bKcA
        0kcDZww+G3X/iDYOqjo4qOVQB5yMxg==
X-Google-Smtp-Source: AGHT+IFuVEdngiswllHpeBpLA6ZHJAf8BU1GB6j5HsXZXn+UNlYH2/CSecjlOqxQWtnfpSG25qCQ2A==
X-Received: by 2002:a05:6808:4193:b0:3b6:cb02:533b with SMTP id dj19-20020a056808419300b003b6cb02533bmr13975007oib.44.1700081945112;
        Wed, 15 Nov 2023 12:59:05 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a9-20020a05680804c900b003b29c2f50f0sm1588527oie.18.2023.11.15.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:59:04 -0800 (PST)
Received: (nullmailer pid 3732930 invoked by uid 1000);
        Wed, 15 Nov 2023 20:59:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] reset: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 14:58:48 -0600
Message-ID: <20231115205848.3732609-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/reset/reset-npcm.c       |  5 ++---
 drivers/reset/sti/reset-syscfg.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index f6c4f854f2be..8935ef95a2d1 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -6,8 +6,8 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
@@ -351,8 +351,7 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 		}
 	}
 
-	rc->info = (const struct npcm_reset_info *)
-			of_match_device(dev->driver->of_match_table, dev)->data;
+	rc->info = device_get_match_data(dev);
 	switch (rc->info->bmc_id) {
 	case BMC_NPCM7XX:
 		npcm_usb_reset_npcm7xx(rc);
diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
index c1ba04f6f155..2324060b747c 100644
--- a/drivers/reset/sti/reset-syscfg.c
+++ b/drivers/reset/sti/reset-syscfg.c
@@ -7,10 +7,11 @@
  */
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
@@ -183,14 +184,14 @@ static int syscfg_reset_controller_register(struct device *dev,
 int syscfg_reset_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev ? &pdev->dev : NULL;
-	const struct of_device_id *match;
+	const void *data;
 
 	if (!dev || !dev->driver)
 		return -ENODEV;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data)
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
 		return -EINVAL;
 
-	return syscfg_reset_controller_register(dev, match->data);
+	return syscfg_reset_controller_register(dev, data);
 }
-- 
2.42.0

