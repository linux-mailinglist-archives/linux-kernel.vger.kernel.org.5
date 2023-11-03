Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936B7E0B66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377974AbjKCW42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377673AbjKCW4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:56:20 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250ED6F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=fmrU2g6eF1M/O9NhTkCGo0q8tJfP+vuJFadhZEhBZqk=; b=bBNUBH
        kTPO9XBWgGHWN/xKtJuHwwsT/4ldN0N7Bfhgzj97e8bmNLSdmsfKSwXmQ2a+JTh4
        /PSSBjswK0XthI/X0n4JxDWvT6U+g8aS6fYDuITqkgJ5ZeRYI7gJTW2GWQ1ia6dZ
        JymuzTl+Kdf8Vo4AoAXoiC6RZigjkp2IRONIBVwESm8VPKGSZk+L6Sq3FzSV+vqu
        KXIgzZp8TmUdoFfyLmpFlO9hT3jngZa0xI8ZaAemMahix3flJ16POcv40EC71HmR
        7CDOiJd4wgTKA4v1ys9UhxFMi0RXikbIn0uSJn+/fi4sRY9hvQYltJACHQjXIaJF
        uGtY5dn4bCkVNh5g==
Received: (qmail 1327964 invoked from network); 3 Nov 2023 23:56:14 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2023 23:56:14 +0100
X-UD-Smtp-Session: l3s3148p1@xx1IaUcJEM5ehhrK
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] gnss: ubx: add support for the reset gpio
Date:   Fri,  3 Nov 2023 23:56:00 +0100
Message-Id: <20231103225601.6499-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
References: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas KingFisher board includes a U-Blox Neo-M8 chip. This chip
has a reset pin which is also wired on the board. Add code to the driver
to support this reset pin. Because my GNSS device is hooked up via UART
and I2C simultaneously, I could verify functionality by opening/closing
the GNSS device using UART and see if the corresponding I2C device was
visible on the bus.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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

