Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466F17E9307
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 23:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjKLW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 17:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjKLW7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 17:59:30 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A9D4C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=qtxdvFWO3Bt+NWf/g6muwDaZhpPXIV/xIfXA1Fk33Ec=; b=bJ9bHM
        I77QBMCX0GvIfQC/3foVz/q8W9N+sJzhWK63dbaXJ4JzhPBg3UN8ZBij2Y0C4WEM
        CLsOFD8k1wEzg2PcsxBomTF30QggQzOhxmjmvHm4aghGJMjmfizajR9gdpRY+XiH
        LmYyJSchKXDgHIMiVoTviTbGJnDDPU+AKrwu+HcGSGpakZpRA1VE90MmMtcL1eTz
        7lwTYuL1C3qW8sd1mHZZCtbVOFVLJlmhvCPLRK5+W+XWRIQRhgEELerWjO+NVgCL
        FzZbAm8S4oF0XZQFjnlOeMdBouw+OC3S5Z6DFxHILj0uz1CaxtkYgf0KFrurHKQq
        C9Lz/niNyk5ZBNLw==
Received: (qmail 4066947 invoked from network); 12 Nov 2023 23:59:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Nov 2023 23:59:24 +0100
X-UD-Smtp-Session: l3s3148p1@V0YegfwJwd0Mv8XD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] i2c: gpio: move to per-adapter debugfs directory
Date:   Sun, 12 Nov 2023 17:59:10 -0500
Message-Id: <20231112225911.4650-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231112225444.4487-1-wsa+renesas@sang-engineering.com>
References: <20231112225444.4487-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C core now provides a per-adapter debugfs directory. Use it
instead of creating a custom one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-gpio.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index fb35a75fe0e3..9c8531137354 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -25,7 +25,6 @@ struct i2c_gpio_private_data {
 	struct i2c_algo_bit_data bit_data;
 	struct i2c_gpio_platform_data pdata;
 #ifdef CONFIG_I2C_GPIO_FAULT_INJECTOR
-	struct dentry *debug_dir;
 	/* these must be protected by bus lock */
 	struct completion scl_irq_completion;
 	u64 scl_irq_data;
@@ -72,7 +71,6 @@ static int i2c_gpio_getscl(void *data)
 }
 
 #ifdef CONFIG_I2C_GPIO_FAULT_INJECTOR
-static struct dentry *i2c_gpio_debug_dir;
 
 #define setsda(bd, val)	((bd)->setsda((bd)->data, val))
 #define setscl(bd, val)	((bd)->setscl((bd)->data, val))
@@ -258,41 +256,23 @@ static void i2c_gpio_fault_injector_init(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv = platform_get_drvdata(pdev);
 
-	/*
-	 * If there will be a debugfs-dir per i2c adapter somewhen, put the
-	 * 'fault-injector' dir there. Until then, we have a global dir with
-	 * all adapters as subdirs.
-	 */
-	if (!i2c_gpio_debug_dir)
-		i2c_gpio_debug_dir = debugfs_create_dir("i2c-fault-injector", NULL);
-
-	priv->debug_dir = debugfs_create_dir(pdev->name, i2c_gpio_debug_dir);
-
 	init_completion(&priv->scl_irq_completion);
 
-	debugfs_create_file_unsafe("incomplete_address_phase", 0200, priv->debug_dir,
+	debugfs_create_file_unsafe("incomplete_address_phase", 0200, priv->adap.debugfs,
 				   priv, &fops_incomplete_addr_phase);
-	debugfs_create_file_unsafe("incomplete_write_byte", 0200, priv->debug_dir,
+	debugfs_create_file_unsafe("incomplete_write_byte", 0200, priv->adap.debugfs,
 				   priv, &fops_incomplete_write_byte);
 	if (priv->bit_data.getscl) {
-		debugfs_create_file_unsafe("inject_panic", 0200, priv->debug_dir,
+		debugfs_create_file_unsafe("inject_panic", 0200, priv->adap.debugfs,
 					   priv, &fops_inject_panic);
-		debugfs_create_file_unsafe("lose_arbitration", 0200, priv->debug_dir,
+		debugfs_create_file_unsafe("lose_arbitration", 0200, priv->adap.debugfs,
 					   priv, &fops_lose_arbitration);
 	}
-	debugfs_create_file_unsafe("scl", 0600, priv->debug_dir, priv, &fops_scl);
-	debugfs_create_file_unsafe("sda", 0600, priv->debug_dir, priv, &fops_sda);
-}
-
-static void i2c_gpio_fault_injector_exit(struct platform_device *pdev)
-{
-	struct i2c_gpio_private_data *priv = platform_get_drvdata(pdev);
-
-	debugfs_remove_recursive(priv->debug_dir);
+	debugfs_create_file_unsafe("scl", 0600, priv->adap.debugfs, priv, &fops_scl);
+	debugfs_create_file_unsafe("sda", 0600, priv->adap.debugfs, priv, &fops_sda);
 }
 #else
 static inline void i2c_gpio_fault_injector_init(struct platform_device *pdev) {}
-static inline void i2c_gpio_fault_injector_exit(struct platform_device *pdev) {}
 #endif /* CONFIG_I2C_GPIO_FAULT_INJECTOR*/
 
 /* Get i2c-gpio properties from DT or ACPI table */
@@ -475,8 +455,6 @@ static void i2c_gpio_remove(struct platform_device *pdev)
 	struct i2c_gpio_private_data *priv;
 	struct i2c_adapter *adap;
 
-	i2c_gpio_fault_injector_exit(pdev);
-
 	priv = platform_get_drvdata(pdev);
 	adap = &priv->adap;
 
-- 
2.35.1

