Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915D7BEC8B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378706AbjJIVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378722AbjJIVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45B8112
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AEBC433C7;
        Mon,  9 Oct 2023 21:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886063;
        bh=mT7mKFR44RqR0uyHV49wMoQ+fmYk1j+hJEVKfvKQEWE=;
        h=From:To:Cc:Subject:Date:From;
        b=dWjgR3m89a5GHLTtUB4ZgPDA8QLOHqzj4qg7dpFhejovWibdhZzYi0Q0lmytbjMbD
         z2PG+90zOMb5z6sfD+ALFq4sKvjUhVOCDZXmnjEvIl09Fw7nF+R7s1pxD040Ep+c8z
         eARDSMc6ei/UxkddAHbuwaBpjyIr25QXU2Yl2VDoRVEAiJzqQD00MQG7ZCuHzP9VBM
         DQmy4L+wFHbXw4gTn5KnlJ1h0Z0DXENsvn7qDnXkP0czi6f1r4/wUv5rE3wH90n9Gn
         zOsR2QHKnZ3+HD8wRTWTobU4mZFqHkIukBkefBcDrkuratnexLakypvqi3VajOIep6
         NVMaKCPtdTM3Q==
Received: (nullmailer pid 3245536 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] mfd: Use spi_get_device_match_data()
Date:   Mon,  9 Oct 2023 16:13:35 -0500
Message-ID: <20231009211356.3242037-5-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

