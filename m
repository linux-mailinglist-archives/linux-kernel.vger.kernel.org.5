Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4179377E7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbjHPRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbjHPRbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:31:32 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8C270D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=VcKHUn11Q66zpSkuewbK9fayGKVu5QJaVzvUdZ9guSU=; b=ZrlguP
        /8DrWZlezE+YMjYFXF4gt+eksVVX7yXlgU99aqvuQTVbbC/LCIKzr83EZfdTFpuR
        R47dvvAvWz1QB5ai6+I5sitcLFtxk05GYwwVEoONwuE1omsaJiTZNCpMJLi9VTC0
        hUicQSrDbQ3xvqhWX7qR3p4hdQ/aKd/W8Y2Uwpu/VPfWUL/k6wZivY7ZyshqkVWw
        mNjmITXNzSWcAsHp34ODFPt0iWV5fcKXazG2UdD9gQU8mVA8mkIqLQrxL4s7bcWh
        bD0whVvC/YlcV1zWdj22li5qmKg0moOWkK87xFGXdylDYUSFjKYzt+FEF0LEr772
        cv8oWUG2rdUQ8uWQ==
Received: (qmail 219520 invoked from network); 16 Aug 2023 19:31:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 19:31:27 +0200
X-UD-Smtp-Session: l3s3148p1@DSNNqg0Dzs5ehhtV
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] gnss: ubx: add support for the reset gpio
Date:   Wed, 16 Aug 2023 19:31:15 +0200
Message-Id: <20230816173116.1176-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816173116.1176-1-wsa+renesas@sang-engineering.com>
References: <20230816173116.1176-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a Renesas KingFisher board. Because my GNSS device is hooked
up via UART and I2C simultaneously, I could verify functionality by
opening/closing the GNSS device using UART and see if the corresponding
I2C device was visible on the bus.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since v1:
* proper reverse order in ubx_set_standby (Thanks, Geert!)
* simplified the comment when initiall asserting the GPIO (Thanks, Geert!)

 drivers/gnss/ubx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 9b76b101ba5e..e7d151cbc8c3 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/gnss.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -18,6 +19,7 @@
 
 struct ubx_data {
 	struct regulator *vcc;
+	struct gpio_desc *reset_gpio;
 };
 
 static int ubx_set_active(struct gnss_serial *gserial)
@@ -29,6 +31,8 @@ static int ubx_set_active(struct gnss_serial *gserial)
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 0);
+
 	return 0;
 }
 
@@ -37,6 +41,8 @@ static int ubx_set_standby(struct gnss_serial *gserial)
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
 	int ret;
 
+	gpiod_set_value_cansleep(data->reset_gpio, 1);
+
 	ret = regulator_disable(data->vcc);
 	if (ret)
 		return ret;
@@ -90,6 +96,13 @@ static int ubx_probe(struct serdev_device *serdev)
 	if (ret < 0 && ret != -ENODEV)
 		goto err_free_gserial;
 
+	/* Start with reset asserted */
+	data->reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset_gpio)) {
+		ret = PTR_ERR(data->reset_gpio);
+		goto err_free_gserial;
+	}
+
 	ret = gnss_serial_register(gserial);
 	if (ret)
 		goto err_free_gserial;
-- 
2.35.1

