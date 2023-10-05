Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D227BA5FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243075AbjJEQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbjJEQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:09 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D23C3A;
        Thu,  5 Oct 2023 08:59:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FAAE1BF207;
        Thu,  5 Oct 2023 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696521558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WtKn/Tb4sVAlce85oVAG5zntlgbWadZVDUoXswIydw=;
        b=LM5De+RiQX+nTg+ib49/YUIVzd9DAeclp5XZnovNXjakXB0AegN3UHBdGFH7ho5anJUPoB
        gsQpXZxIrsM8EcyAe35ohIMbcSAKMw2R94fP4XR2qaJTWMnUrAp7ISJ7/qVEU5PeNXZUWB
        NeVDRmajCs1Tw65WQu5jQgNY55M0anL3RMFDiY1PbKfDuHcNNGjSiyQg77NbPl8SdxkrWS
        HrjmIzpZYJo3TsaF2hQp2BlgsQL4Q03RAYiU92fOhWX4J8F9CxPvi6sviNfjoBBmO6qwyW
        veHxHLj93pJaKo/wFpXGhonCy2Z+sJ7+WmtU+gVdAiMbVsNZqoLcPz4MBV981w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v12 4/7] nvmem: Create a header for internal sharing
Date:   Thu,  5 Oct 2023 17:59:04 +0200
Message-Id: <20231005155907.2701706-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index c63057a7a3b8..073fe4a73e37 100644
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

