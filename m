Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55382805067
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbjLEKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbjLEKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD0188;
        Tue,  5 Dec 2023 02:36:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf1e32571so2829971e87.2;
        Tue, 05 Dec 2023 02:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772580; x=1702377380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuEP+uQWEz5IeeuWDx+rXfktVLzDKREZ21gC+/GyIBY=;
        b=IUNeEzntakipIcPoHiN4VSISv6TTXwVlUNYdCS09aHgm1oOg/qcKGJBHTyr09fm7aZ
         KUZ9ndcTR3HlCSObRvEF99gcXNyftODLJwui7mEIWbV6lnMKkCmb1Df0bmsaK6i/h2NY
         rzn/mCnDwFwNqRfx/wJcrY8imUx5VQsVaO4qMwBzsETIVin0/X+vtSwg8Ig7YR0NROQv
         A5vR+Vtkew0AKY+lqQ0R88PY08V4T5cizmX7RiMx2HeNYdUb3M/qZQJAgPfm/VsHi2nS
         S+aDRQ6sx2eYkGk7mLYyRvOHwXhLTd5Eq0zPUbKmTVed0VnBI+qZW2AfY5uf0QO00h2T
         8MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772580; x=1702377380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuEP+uQWEz5IeeuWDx+rXfktVLzDKREZ21gC+/GyIBY=;
        b=eowH7kghzMlJUga/PNa/XDyajyZfIsJ2DUQSe+igR+GCkk0yqV84qkbAwb2NAnKVA5
         sWDKAhpXQ7KS6wMkrTMguNsfwt0IgQRQFx4ORe6RFjDAXV3CEunI2UX34vuoGHyorClb
         WR/XLB1x5oUgU92W8d/2JpZZxblR+S4eX/QbvyozQ54X7/axrk/6T6EFTuWvuI3Fr6/n
         fvQMkcc2GmR4Q94ySwqq2ch62vgyb+RwQZlHCJkD0DDO9bQh463rtS9LoTJqmMi3kvbG
         aNCafLj9+XvujAKxavRaAytRA1dzbBAAEdFYf5iZ7KyBDutHw6sffXLIbaP1f5EF32nu
         N6Eg==
X-Gm-Message-State: AOJu0Yx7oWGgpl9bHEfzs+i0ug8yTMO5jc1wxNL7IcZ7Affy/1CNVDy3
        ZcTm9litmy00VPq6B27zcD0=
X-Google-Smtp-Source: AGHT+IF2gRKmV84qVxXi1M+5W27kf62+M3aukMfAcptcsu0Anuvo7HvEc1fIHQySmQeecOmwdbDEXQ==
X-Received: by 2002:a19:7901:0:b0:50b:ef6c:bc8b with SMTP id u1-20020a197901000000b0050bef6cbc8bmr1801111lfc.134.1701772580383;
        Tue, 05 Dec 2023 02:36:20 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m15-20020a0565120a8f00b0050bfda10057sm372593lfu.85.2023.12.05.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:20 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS MDIO-device support
Date:   Tue,  5 Dec 2023 13:35:31 +0300
Message-ID: <20231205103559.9605-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the memory mapped Synopsys DW XPCS management interface support
was added to the kernel. In that case the DW XPCS device can be registered
via a standard MDIO-bus subsystem. In order to have such devices fully
accessible and properly configured let's add a respective functionality to
the DW XPCS driver.

The main goal of this update is to add a functionality to activate
vendor-specific XPCS capabilities in the driver (like a limited number of
network interfaces, linkmodes, PMA-specific initializations). It's reached
by having DW XPCS devices registered as the platform devices (OF, ACPI,
legacy platform ,etc). From that point of view the suggested update is
threefold. First the driver is now capable to be attached to the
OF-devices registered on the MDIO-bus with the "snps,dw-xpcs*" compatible
string. Second it's possible to have the driver bound to the DW XPCS
device with no OF/ACPI-nodes by means of defining the mdio_board_info
descriptor and registering one with mdiobus_register_board_info() (see
dwmac-intel.c for example). Thirdly it's still possible to use the
unregistered device to auto-detect the DW XPCS device on the MDIO bus. In
all these cases the DW XPCS device info can be passed by means of the
driver-data pointer (of_device_id.data or device.platform_data).

In addition to that the update provides the DW XPCS reference clock
sources request and enabling. These clocks are named as "core" and "pad"
as per the DT-bindings. Note normally they are mutually exclusive: only
one of them can be used at a time, but the system software is responsible
for switching between them. Such functionality will be added later in the
framework of the pma_config() internal callback.

Note all the platform resources initialization is performed in the
externally called xpcs_create() method as before this update. The only
crucial update is that it now makes sure that the device is bound to the
DW XPCS driver if it's possible. Otherwise the legacy auto-detection
procedure takes place as before. Moreover due to that semantic there is no
device probe() and remove() methods defined since there is nothing left to
initialize/de-initialize on these stages.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/Kconfig      |   6 +-
 drivers/net/pcs/pcs-xpcs.c   | 112 ++++++++++++++++++++++++++++++++---
 drivers/net/pcs/pcs-xpcs.h   |   6 ++
 include/linux/pcs/pcs-xpcs.h |  27 +++++++++
 4 files changed, 141 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index 87cf308fc6d8..f6aa437473de 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -6,11 +6,11 @@
 menu "PCS device drivers"
 
 config PCS_XPCS
-	tristate
+	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
 	help
-	  This module provides helper functions for Synopsys DesignWare XPCS
-	  controllers.
+	  This module provides a driver and helper functions for Synopsys
+	  DesignWare XPCS controllers.
 
 config PCS_LYNX
 	tristate
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index ea6f56339595..183a37929b60 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -6,10 +6,14 @@
  * Author: Jose Abreu <Jose.Abreu@synopsys.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/pcs/pcs-xpcs.h>
+#include <linux/device.h>
 #include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/phylink.h>
+#include <linux/property.h>
 
 #include "pcs-xpcs.h"
 
@@ -1386,17 +1390,57 @@ static void xpcs_free_data(struct dw_xpcs *xpcs)
 	kfree(xpcs);
 }
 
+static int xpcs_init_clks(struct dw_xpcs *xpcs)
+{
+	static const char *ids[DW_XPCS_NUM_CLKS] = {
+		[DW_XPCS_CLK_CORE] = "core",
+		[DW_XPCS_CLK_PAD] = "pad",
+	};
+	struct device *dev = &xpcs->mdiodev->dev;
+	int ret, i;
+
+	for (i = 0; i < DW_XPCS_NUM_CLKS; ++i)
+		xpcs->clks[i].id = ids[i];
+
+	ret = clk_bulk_get_optional(dev, DW_XPCS_NUM_CLKS, xpcs->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get clocks\n");
+
+	ret = clk_bulk_prepare_enable(DW_XPCS_NUM_CLKS, xpcs->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
+
+	return 0;
+}
+
+static void xpcs_clear_clks(struct dw_xpcs *xpcs)
+{
+	clk_bulk_disable_unprepare(DW_XPCS_NUM_CLKS, xpcs->clks);
+
+	clk_bulk_put(DW_XPCS_NUM_CLKS, xpcs->clks);
+}
+
 static int xpcs_init_id(struct dw_xpcs *xpcs)
 {
-	u32 xpcs_id;
+	const struct dw_xpcs_info *info;
 	int i, ret;
 
-	xpcs_id = xpcs_get_id(xpcs);
+	info = device_get_match_data(&xpcs->mdiodev->dev) ?:
+	       dev_get_platdata(&xpcs->mdiodev->dev);
+	if (!info) {
+		xpcs->info.did = DW_XPCS_ID_NATIVE;
+		xpcs->info.pma = DW_XPCS_PMA_UNKNOWN;
+	} else {
+		xpcs->info = *info;
+	}
+
+	if (xpcs->info.did == DW_XPCS_ID_NATIVE)
+		xpcs->info.did = xpcs_get_id(xpcs);
 
 	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
 		const struct xpcs_id *entry = &xpcs_id_list[i];
 
-		if ((xpcs_id & entry->mask) != entry->id)
+		if ((xpcs->info.did & entry->mask) != entry->id)
 			continue;
 
 		xpcs->id = entry;
@@ -1436,21 +1480,32 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	struct dw_xpcs *xpcs;
 	int ret;
 
+	ret = device_attach(&mdiodev->dev);
+	if (ret < 0 && ret != -ENODEV)
+		return ERR_PTR(ret);
+
 	xpcs = xpcs_create_data(mdiodev);
 	if (IS_ERR(xpcs))
 		return xpcs;
 
+	ret = xpcs_init_clks(xpcs);
+	if (ret)
+		goto out_free_data;
+
 	ret = xpcs_init_id(xpcs);
 	if (ret)
-		goto out;
+		goto out_clear_clks;
 
 	ret = xpcs_init_iface(xpcs, interface);
 	if (ret)
-		goto out;
+		goto out_clear_clks;
 
 	return xpcs;
 
-out:
+out_clear_clks:
+	xpcs_clear_clks(xpcs);
+
+out_free_data:
 	xpcs_free_data(xpcs);
 
 	return ERR_PTR(ret);
@@ -1489,8 +1544,51 @@ void xpcs_destroy(struct dw_xpcs *xpcs)
 
 	mdio_device_put(xpcs->mdiodev);
 
+	xpcs_clear_clks(xpcs);
+
 	xpcs_free_data(xpcs);
 }
 EXPORT_SYMBOL_GPL(xpcs_destroy);
 
+DW_XPCS_INFO_DECLARE(xpcs_generic, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_UNKNOWN);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen1_3g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN1_3G);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen2_3g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN2_3G);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen2_6g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN2_6G);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen4_3g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN4_3G);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen4_6g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN4_6G);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen5_10g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN5_10G);
+DW_XPCS_INFO_DECLARE(xpcs_pma_gen5_12g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN5_12G);
+
+static const struct of_device_id xpcs_of_ids[] = {
+	{ .compatible = "snps,dw-xpcs", .data = &xpcs_generic },
+	{ .compatible = "snps,dw-xpcs-gen1-3g", .data = &xpcs_pma_gen1_3g },
+	{ .compatible = "snps,dw-xpcs-gen2-3g", .data = &xpcs_pma_gen2_3g },
+	{ .compatible = "snps,dw-xpcs-gen2-6g", .data = &xpcs_pma_gen2_6g },
+	{ .compatible = "snps,dw-xpcs-gen4-3g", .data = &xpcs_pma_gen4_3g },
+	{ .compatible = "snps,dw-xpcs-gen4-6g", .data = &xpcs_pma_gen4_6g },
+	{ .compatible = "snps,dw-xpcs-gen5-10g", .data = &xpcs_pma_gen5_10g },
+	{ .compatible = "snps,dw-xpcs-gen5-12g", .data = &xpcs_pma_gen5_12g },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, xpcs_of_ids);
+
+static struct mdio_device_id __maybe_unused xpcs_mdio_ids[] = {
+	{ DW_XPCS_ID, DW_XPCS_ID_MASK },
+	{ NXP_SJA1105_XPCS_ID, DW_XPCS_ID_MASK },
+	{ NXP_SJA1110_XPCS_ID, DW_XPCS_ID_MASK },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, xpcs_mdio_ids);
+
+static struct mdio_driver xpcs_driver = {
+	.mdiodrv.driver = {
+		.name = "dwxpcs",
+		.of_match_table = xpcs_of_ids,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+	},
+};
+mdio_module_driver(xpcs_driver);
+
+MODULE_DESCRIPTION("DWC Ethernet XPCS platform driver");
+MODULE_AUTHOR("Jose Abreu <Jose.Abreu@synopsys.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 369e9196f45a..45fea2641d23 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -6,6 +6,9 @@
  * Author: Jose Abreu <Jose.Abreu@synopsys.com>
  */
 
+#include <linux/bits.h>
+#include <linux/pcs/pcs-xpcs.h>
+
 /* Vendor regs access */
 #define DW_VENDOR			BIT(15)
 
@@ -117,6 +120,9 @@
 /* VR MII EEE Control 1 defines */
 #define DW_VR_MII_EEE_TRN_LPI		BIT(0)	/* Transparent Mode Enable */
 
+#define DW_XPCS_INFO_DECLARE(_name, _did, _pma)			\
+	static const struct dw_xpcs_info _name = { .did = _did, .pma = _pma }
+
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val);
 int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg);
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 8dfe90295f12..53adbffb4c0a 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -7,9 +7,12 @@
 #ifndef __LINUX_PCS_XPCS_H
 #define __LINUX_PCS_XPCS_H
 
+#include <linux/clk.h>
+#include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 
+#define DW_XPCS_ID_NATIVE		0x00000000
 #define NXP_SJA1105_XPCS_ID		0x00000010
 #define NXP_SJA1110_XPCS_ID		0x00000020
 #define DW_XPCS_ID			0x7996ced0
@@ -30,9 +33,33 @@
 
 struct xpcs_id;
 
+enum dw_xpcs_pma {
+	DW_XPCS_PMA_UNKNOWN = 0,
+	DW_XPCS_PMA_GEN1_3G,
+	DW_XPCS_PMA_GEN2_3G,
+	DW_XPCS_PMA_GEN2_6G,
+	DW_XPCS_PMA_GEN4_3G,
+	DW_XPCS_PMA_GEN4_6G,
+	DW_XPCS_PMA_GEN5_10G,
+	DW_XPCS_PMA_GEN5_12G,
+};
+
+enum dw_xpcs_clock {
+	DW_XPCS_CLK_CORE,
+	DW_XPCS_CLK_PAD,
+	DW_XPCS_NUM_CLKS,
+};
+
+struct dw_xpcs_info {
+	u32 did;
+	u32 pma;
+};
+
 struct dw_xpcs {
 	struct mdio_device *mdiodev;
+	struct dw_xpcs_info info;
 	const struct xpcs_id *id;
+	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	int dev_flag;
-- 
2.42.1

