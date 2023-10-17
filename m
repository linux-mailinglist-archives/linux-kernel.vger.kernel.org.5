Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836FC7CCE29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbjJQUgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJQUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:36:02 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B2C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:36:00 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6c4b9e09521so4058196a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574960; x=1698179760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlXWKbsf5/gUFLRD8MZ8nhq2WyOrSzkHVURrmbpQ9bU=;
        b=Z+YxWqHxWB/2tJP0Sj3+as/1m9EQ0Sf1yC6lvCLkxnpV/beQwmj+zLIV6kpN8DRylN
         ih3eZBmzoJzPgrYH3EFrv0MX1ehu1siSRUG6HmjAZDTZqeTo4g3NLkbZjq5An7osqf3/
         SHKfIDOD/mYxcnXabs4Dy67nbfIx2zgN8J3SFvK7PR+f9yOj4stHO9WbCCnC3QnB3C4x
         g6D+1hF95nqzlkDPsAEfOJDhU0xPdkzg3AlWr9vfWUNjo3wUNRRXQoVlBFJID1YOGyc1
         9DdrdQykop5BpeZjoyn0raXejD76sYs5Cq82lynx7Tx6RDulYEAggs0G78SIeMwzwlJ6
         i58w==
X-Gm-Message-State: AOJu0YxQG7l1ufCG5TbWZJ87cixKgybSITE1PJSb3/b/8lZG59lIjBPm
        H2fujltxBQr1xFYYStn8bqvsXhNrZg==
X-Google-Smtp-Source: AGHT+IGcoOcDumfxA8J/EMOQnmu4KybCfB/s8ObwoRn6JYV0yZ9F1x39WFSSB7UAqFWbe9x0t1hVuQ==
X-Received: by 2002:a05:6808:23cf:b0:3af:a72a:96dc with SMTP id bq15-20020a05680823cf00b003afa72a96dcmr4211210oib.3.1697574959735;
        Tue, 17 Oct 2023 13:35:59 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec6-20020a056808638600b003b2e4754cc2sm113093oib.26.2023.10.17.13.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:35:59 -0700 (PDT)
Received: (nullmailer pid 2700789 invoked by uid 1000);
        Tue, 17 Oct 2023 20:35:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [RESEND PATCH] mfd: Use spi_get_device_match_data()
Date:   Tue, 17 Oct 2023 15:35:49 -0500
Message-ID: <20231017203550.2700601-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred spi_get_device_match_data() instead of of_match_device() and
spi_get_device_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/mc13xxx-spi.c | 14 ++------------
 drivers/mfd/wm831x-spi.c  | 16 ++++------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index f70d79aa5a83..c973e2579bdf 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -8,13 +8,12 @@
  */
 
 #include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 
@@ -151,16 +150,7 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	if (spi->dev.of_node) {
-		const struct of_device_id *of_id =
-			of_match_device(mc13xxx_dt_ids, &spi->dev);
-
-		mc13xxx->variant = of_id->data;
-	} else {
-		const struct spi_device_id *id_entry = spi_get_device_id(spi);
-
-		mc13xxx->variant = (void *)id_entry->driver_data;
-	}
+	mc13xxx->variant = spi_get_device_match_data(spi);
 
 	return mc13xxx_common_init(&spi->dev);
 }
diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index 76be7ef5c970..54c87267917b 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
@@ -21,21 +20,14 @@
 static int wm831x_spi_probe(struct spi_device *spi)
 {
 	struct wm831x_pdata *pdata = dev_get_platdata(&spi->dev);
-	const struct spi_device_id *id = spi_get_device_id(spi);
-	const struct of_device_id *of_id;
 	struct wm831x *wm831x;
 	enum wm831x_parent type;
 	int ret;
 
-	if (spi->dev.of_node) {
-		of_id = of_match_device(wm831x_of_match, &spi->dev);
-		if (!of_id) {
-			dev_err(&spi->dev, "Failed to match device\n");
-			return -ENODEV;
-		}
-		type = (uintptr_t)of_id->data;
-	} else {
-		type = (enum wm831x_parent)id->driver_data;
+	type = (uintptr_t)spi_get_device_match_data(spi);
+	if (!type) {
+		dev_err(&spi->dev, "Failed to match device\n");
+		return -ENODEV;
 	}
 
 	wm831x = devm_kzalloc(&spi->dev, sizeof(struct wm831x), GFP_KERNEL);
-- 
2.42.0

