Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFB7BC158
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjJFVkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjJFVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:39:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CC0D50;
        Fri,  6 Oct 2023 14:39:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD9BC433C9;
        Fri,  6 Oct 2023 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628368;
        bh=2XziYcmjBQwlHQ8WEyRONsKUONRLFG9IYWm+kWdCfdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=WtHKJAnumyWwN6Ciax6SvYhzJ3vyq+rbg41/4VP1xSVJ+NxVzQTDBqaNxGZ/CHUVC
         F4fhrev+XNLFauaBsfhPEWAz9JxqCtVMe2QrrT6J5S0fjfpgMwdrO4mFuEZ2vvVA1r
         +rW+efnyEjSqtWic+5vfK3grmgwgkgh94fO2UFilHOx2FnXHX1xVIJ4feCeIohqbPy
         DRt4WjmxEjU4JS7mDmABQc/mioPuz38BsvFP/OxBKJZNt5jQwmOVPqlBRUspcYqfRe
         Nv2spYh1jdV9w0i3BOqNp9hQRfRWiprXa6QI8RgdRqtAC8hggmEW7cL5lLWkEfVjm/
         63N6yj698wwjg==
Received: (nullmailer pid 333873 invoked by uid 1000);
        Fri, 06 Oct 2023 21:39:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:39:17 -0500
Message-Id: <20231006213917.333702-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/crypto/aspeed/aspeed-hace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 8f7aab82e1d8..d9da04fb816e 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -12,11 +12,9 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #ifdef CONFIG_CRYPTO_DEV_ASPEED_DEBUG
 #define HACE_DBG(d, fmt, ...)	\
@@ -101,7 +99,6 @@ static const struct of_device_id aspeed_hace_of_matches[] = {
 static int aspeed_hace_probe(struct platform_device *pdev)
 {
 	struct aspeed_engine_crypto *crypto_engine;
-	const struct of_device_id *hace_dev_id;
 	struct aspeed_engine_hash *hash_engine;
 	struct aspeed_hace_dev *hace_dev;
 	int rc;
@@ -111,14 +108,13 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	if (!hace_dev)
 		return -ENOMEM;
 
-	hace_dev_id = of_match_device(aspeed_hace_of_matches, &pdev->dev);
-	if (!hace_dev_id) {
+	hace_dev->version = (uintptr_t)device_get_match_data(&pdev->dev);
+	if (!hace_dev->version) {
 		dev_err(&pdev->dev, "Failed to match hace dev id\n");
 		return -EINVAL;
 	}
 
 	hace_dev->dev = &pdev->dev;
-	hace_dev->version = (unsigned long)hace_dev_id->data;
 	hash_engine = &hace_dev->hash_engine;
 	crypto_engine = &hace_dev->crypto_engine;
 
-- 
2.40.1

