Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFD7BEC7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378644AbjJIVOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378672AbjJIVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8573B6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8730C433C9;
        Mon,  9 Oct 2023 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886056;
        bh=92q9941Hk6m7vrKfgjduGlCt6AEAywwnij4Ddy51frE=;
        h=From:To:Cc:Subject:Date:From;
        b=k/XXo9gc9QlbY1l77U8Bza5aj3POoieELBtW3oTcLKEroFgmzY6hF8Z6WnLXPKVmi
         k3j4xeehd3SO9gEkK4GtqhpbS8WImuaArc39fUXNX7/XmiVR+K+Tdilkw0IKLKlLkF
         1ZwdvRV9LBMWEQ+ZWQkqOdqK1ldsC+gyUXqLlVQTPH0BHA7mdu2sduId8SAW3H9aCm
         qFmsiiTnS+fvk8Jv8C1rlZ8sxD7KTapWGpEDedbg7h31jw9GYnONqLZTge1xLbzHX2
         o3OVukaYWdF7WkhoQOiuEc9muxD3YRfHO+FhWDD7DOtjXSjuRg3+WRjxlwdH3p3LNE
         pql0COKbli3mQ==
Received: (nullmailer pid 3245828 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9121: Use i2c_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:38 -0500
Message-ID: <20231009211356.3242037-8-robh@kernel.org>
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

Use preferred i2c_get_match_data() instead of of_match_device() to get
the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/da9121-regulator.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 80098035bb13..b551a400bdd1 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -13,7 +13,7 @@
 //
 // Copyright (C) 2020 Dialog Semiconductor
 
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/of_regulator.h>
@@ -1117,17 +1117,6 @@ static const struct of_device_id da9121_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9121_dt_ids);
 
-static inline int da9121_of_get_id(struct device *dev)
-{
-	const struct of_device_id *id = of_match_device(da9121_dt_ids, dev);
-
-	if (!id) {
-		dev_err(dev, "%s: Failed\n", __func__);
-		return -EINVAL;
-	}
-	return (uintptr_t)id->data;
-}
-
 static int da9121_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9121 *chip;
@@ -1141,7 +1130,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c)
 	}
 
 	chip->pdata = i2c->dev.platform_data;
-	chip->subvariant_id = da9121_of_get_id(&i2c->dev);
+	chip->subvariant_id = (enum da9121_subvariant)i2c_get_match_data(i2c);
 
 	ret = da9121_assign_chip_model(i2c, chip);
 	if (ret < 0)
-- 
2.42.0

