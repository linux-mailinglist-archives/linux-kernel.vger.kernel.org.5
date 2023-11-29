Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB37FDD46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjK2Qho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2Qhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:37:37 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE5F10A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2507FC0007;
        Wed, 29 Nov 2023 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701275861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFyU6O8ilcV7xp4q/of+2+aQkRrhD5AxyRveYuZqHQY=;
        b=aWBx7yX3Ta1jei4cV0eIEV73KUZHp7UHbwBlkWjCofvx+OaOLayuNcLBsvY6BKmRTVAnTo
        mz6LcYUSyxry5Skh1ZeD8Owq6u0qkwOSfOx6Hz/9IESUN7O2X/hEAq4lbwz9hH/xYem2AY
        XLtRu9d7Xgb6h/7ReBnF5MjjCD/d1wvn6PwRQrtZX7uYQHSUA15nmgaJ0HOn/8PiQWnoj6
        Mwrj4jZkMnZfoBVQdYX1Cw8nZPg+PC4y3p5MlkCQdhBCzcC2weAUGt1O5FPTAfaHcKoFA0
        /vA2jEvWlt2hHk/i6Rt/NpJQUutfdfWvKIfOJ9jgjJM2GKtU3oE6dYNq6Hb1MA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v14 3/8] nvmem: Create a header for internal sharing
Date:   Wed, 29 Nov 2023 17:37:32 +0100
Message-Id: <20231129163737.698317-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before adding all the NVMEM layout bus infrastructure to the core, let's
move the main nvmem_device structure in an internal header, only
available to the core. This way all the additional code can be added in
a dedicated file in order to keep the current core file tidy.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c      | 24 +-----------------------
 drivers/nvmem/internals.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 23 deletions(-)
 create mode 100644 drivers/nvmem/internals.h

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b6ec8e04bb..b5e5ce67398f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -19,29 +19,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 
-struct nvmem_device {
-	struct module		*owner;
-	struct device		dev;
-	int			stride;
-	int			word_size;
-	int			id;
-	struct kref		refcnt;
-	size_t			size;
-	bool			read_only;
-	bool			root_only;
-	int			flags;
-	enum nvmem_type		type;
-	struct bin_attribute	eeprom;
-	struct device		*base_dev;
-	struct list_head	cells;
-	const struct nvmem_keepout *keepout;
-	unsigned int		nkeepout;
-	nvmem_reg_read_t	reg_read;
-	nvmem_reg_write_t	reg_write;
-	struct gpio_desc	*wp_gpio;
-	struct nvmem_layout	*layout;
-	void *priv;
-};
+#include "internals.h"
 
 #define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
new file mode 100644
index 000000000000..ce353831cd65
--- /dev/null
+++ b/drivers/nvmem/internals.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_NVMEM_INTERNALS_H
+#define _LINUX_NVMEM_INTERNALS_H
+
+#include <linux/device.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+
+struct nvmem_device {
+	struct module		*owner;
+	struct device		dev;
+	struct list_head	node;
+	int			stride;
+	int			word_size;
+	int			id;
+	struct kref		refcnt;
+	size_t			size;
+	bool			read_only;
+	bool			root_only;
+	int			flags;
+	enum nvmem_type		type;
+	struct bin_attribute	eeprom;
+	struct device		*base_dev;
+	struct list_head	cells;
+	const struct nvmem_keepout *keepout;
+	unsigned int		nkeepout;
+	nvmem_reg_read_t	reg_read;
+	nvmem_reg_write_t	reg_write;
+	struct gpio_desc	*wp_gpio;
+	struct nvmem_layout	*layout;
+	void *priv;
+};
+
+#endif  /* ifndef _LINUX_NVMEM_INTERNALS_H */
-- 
2.34.1

