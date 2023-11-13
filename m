Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8C7E93BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjKMAwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjKMAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:52:38 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B51BFB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=uNZI7twh1MCj378W/s61ElwRHXmJFA2B2l6wiFxkiz0=; b=U+e1p4
        saoAL4Y1oOx/TTQLZnVYbWwRdR+CkxNl7Ct5ZBhX51sSG6OpZtNNlCplXlXZ+dI0
        W/2gZhneNJz4flknFepJIPND1tU5x1XmrrUpgS5reC2MX+avWmTZLiLXeRVrNt6j
        MNnpdVHspoKZBwblbBYNI/qXLyNFaGLePruZ5OqwVJSZnaUKHHeYk+8d98GoF/Uz
        IgK4k/DnKBKpNR1SlEfMFkk+/dbVRK7T4ti/B3Y9cNMqx8goyEESmUocyeNCU2mT
        u7fWJavKYXhlc40SrK0817IqqWJq0w/iczVIYC/VSKWR9AAPUZHH8WT1kfK5ODxe
        zdSGfopJHBTFqFrQ==
Received: (qmail 4084559 invoked from network); 13 Nov 2023 01:52:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2023 01:52:33 +0100
X-UD-Smtp-Session: l3s3148p1@mR7NFf4JCsMMv8XD
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] gnss: ubx: add support for the reset gpio
Date:   Sun, 12 Nov 2023 19:51:51 -0500
Message-Id: <20231113005152.10656-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas KingFisher board includes a U-Blox Neo-M8 chip. This chip
has a reset pin which is also wired on the board. When Linux starts,
reset is asserted by the firmware. Deassert the reset pin when probing
this driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes since v4:

* don't touch reset during open/close. Only deassert it during probe.

 drivers/gnss/ubx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 9b76b101ba5e..84cb50670644 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/gnss.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -64,6 +65,7 @@ static const struct gnss_serial_ops ubx_gserial_ops = {
 
 static int ubx_probe(struct serdev_device *serdev)
 {
+	struct gpio_desc *reset_gpio;
 	struct gnss_serial *gserial;
 	struct ubx_data *data;
 	int ret;
@@ -90,6 +92,13 @@ static int ubx_probe(struct serdev_device *serdev)
 	if (ret < 0 && ret != -ENODEV)
 		goto err_free_gserial;
 
+	/* Deassert Reset */
+	reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		ret = PTR_ERR(reset_gpio);
+		goto err_free_gserial;
+	}
+
 	ret = gnss_serial_register(gserial);
 	if (ret)
 		goto err_free_gserial;
-- 
2.35.1

