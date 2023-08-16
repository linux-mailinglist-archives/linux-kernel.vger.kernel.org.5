Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88F577EC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346747AbjHPV4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbjHPV4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:56:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C32705;
        Wed, 16 Aug 2023 14:56:29 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFGICY021936;
        Wed, 16 Aug 2023 21:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=rHqtPVdzrJfxM8TrsW0yWtuH3oVT4O+D2GL5zIPyn7c=;
 b=clJ8YA/KnsHT88Yob4X++RE/tjkgPIlK0tWURr1OG9cvhvgmMRGq6IyTceBE6sseQDdt
 Z+RlyRJus40znLImQuCUf0wE2q/cyQuofuNJozxJtMve9lHfCfFEATbFgpc5LkktyP+P
 tteVtMR6n1SDODW2iDcrhtf5X0r5Dq0O/qYqbBm3d4NqITE5oJplwce/YXrMx6HdiG3W
 lEzQuywp6CnFQGVrSBh26bJMrKS6qGXqm+ww/R62EUFOKxs21maxwMeHaOepFgafSOMp
 SXn7WdFg4ZhD8kRAKuzdPhxMzMPBwN+Ug5btWIUyVWY7mG5WxLtkx5nJrqDA6HD5lS8n wQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sh0y039d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:56:17 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 06B6A800189;
        Wed, 16 Aug 2023 21:55:46 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 12814800189;
        Wed, 16 Aug 2023 21:55:46 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] net: hpe: Add GXP UMAC MDIO
Date:   Wed, 16 Aug 2023 16:52:17 -0500
Message-Id: <20230816215220.114118-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816215220.114118-1-nick.hawkins@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: dKnKWSKLeG3hkqzXJD_JtgApmGy5mL2x
X-Proofpoint-ORIG-GUID: dKnKWSKLeG3hkqzXJD_JtgApmGy5mL2x
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP contains two Universal Ethernet MACs that can be
connected externally to several physical devices. From an external
interface perspective the BMC provides two SERDES interface connections
capable of either SGMII or 1000Base-X operation. The BMC also provides
a RMII interface for sideband connections to external Ethernet controllers.

The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
SERDES interface.  The secondary MAC (umac1) can be mapped to only
the second SGMII/1000-Base X Serdes interface or it can be mapped for
RMII sideband.

The MDIO(mdio0) interface from the primary MAC (umac0) is used for
external PHY status and configuration. The MDIO(mdio1) interface from
the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks
on the two SERDES interface connections.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v3:
 *Remove Kconfig and Makefile changes for ethernet
 *Fixed Kconfig alignment and COMPILE_TEST issue
 *removed raw write/reads
 *Put consistent spacing in Kconfing help description
v2:
 *Move from /ethernet to /mdio
 *Add COMPILE_TEST to Kconfig
 *Fix christmas tree variable declaration layout
 *return the error code instead of using defined where possible
 *Modify Kconfig to add depends on OF_MDIO && HAS_IOMEM &&
  MDIO_DEVRES
 *replace , with ;
 *use devm_of_mdiobus_register
 *remove umac_mdio_remove function
 *remove of_ptr_match
 *fix size_of on alloc
---
 drivers/net/mdio/Kconfig         |  13 +++
 drivers/net/mdio/Makefile        |   1 +
 drivers/net/mdio/mdio-gxp-umac.c | 142 +++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-gxp-umac.c

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 9ff2e6f22f3f..c3bf91c86fde 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -115,6 +115,19 @@ config MDIO_GPIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called mdio-gpio.
 
+config GXP_UMAC_MDIO
+	tristate "GXP UMAC mdio support"
+	depends on ARCH_HPE || COMPILE_TEST
+	depends on OF_MDIO && HAS_IOMEM
+	depends on MDIO_DEVRES
+	help
+	  Say y here to support the GXP UMAC MDIO bus. The
+	  MDIO (mdio0) interface from the primary MAC (umac0)
+	  is used for external PHY status and configuration.
+	  The MDIO (mdio1) interface from the secondary MAC
+	  (umac1) is routed to the SGMII/100Base-X IP blocks
+	  on the two SERDES interface connections.
+
 config MDIO_HISI_FEMAC
 	tristate "Hisilicon FEMAC MDIO bus controller"
 	depends on HAS_IOMEM && OF_MDIO
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 7d4cb4c11e4e..4d00299e327f 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
 obj-$(CONFIG_MDIO_BITBANG)		+= mdio-bitbang.o
 obj-$(CONFIG_MDIO_CAVIUM)		+= mdio-cavium.o
 obj-$(CONFIG_MDIO_GPIO)			+= mdio-gpio.o
+obj-$(CONFIG_GXP_UMAC_MDIO)		+= mdio-gxp-umac.o
 obj-$(CONFIG_MDIO_HISI_FEMAC)		+= mdio-hisi-femac.o
 obj-$(CONFIG_MDIO_I2C)			+= mdio-i2c.o
 obj-$(CONFIG_MDIO_IPQ4019)		+= mdio-ipq4019.o
diff --git a/drivers/net/mdio/mdio-gxp-umac.c b/drivers/net/mdio/mdio-gxp-umac.c
new file mode 100644
index 000000000000..bd1996e937c1
--- /dev/null
+++ b/drivers/net/mdio/mdio-gxp-umac.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett-Packard Development Company, L.P. */
+
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/platform_device.h>
+
+#define UMAC_MII                0x00  /* R/W MII Register */
+#define UMAC_MII_PHY_ADDR_MASK  0x001F0000
+#define UMAC_MII_PHY_ADDR_SHIFT 16
+#define UMAC_MII_MOWNER         BIT(9)
+#define UMAC_MII_MRNW           BIT(8)
+#define UMAC_MII_REG_ADDR_MASK  0x0000001F
+#define UMAC_MII_DATA           0x04  /* R/W MII Data Register */
+
+struct umac_mdio_priv {
+	void __iomem *base;
+};
+
+static int umac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
+{
+	struct umac_mdio_priv *umac_mdio = bus->priv;
+	unsigned int status;
+	unsigned int value;
+	int ret;
+
+	status = readl(umac_mdio->base + UMAC_MII);
+
+	status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
+	status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
+			UMAC_MII_PHY_ADDR_MASK);
+	status |= (reg & UMAC_MII_REG_ADDR_MASK);
+	status |= UMAC_MII_MRNW; /* set bit for read mode */
+	writel(status, umac_mdio->base + UMAC_MII);
+
+	status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
+	writel(status, umac_mdio->base + UMAC_MII);
+
+	ret = readl_poll_timeout(umac_mdio->base + UMAC_MII, status,
+				 !(status & UMAC_MII_MOWNER), 1000, 100000);
+	if (ret) {
+		dev_err(bus->parent, "mdio read time out\n");
+		return ret;
+	}
+
+	value = readl(umac_mdio->base + UMAC_MII_DATA);
+	return value;
+}
+
+static int umac_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 value)
+{
+	struct umac_mdio_priv *umac_mdio = bus->priv;
+	unsigned int status;
+	int ret;
+
+	writel(value, umac_mdio->base + UMAC_MII_DATA);
+
+	status = readl(umac_mdio->base + UMAC_MII);
+
+	status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
+	status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
+			UMAC_MII_PHY_ADDR_MASK);
+	status |= (reg & UMAC_MII_REG_ADDR_MASK);
+	status &= ~UMAC_MII_MRNW; /* clear bit for write mode */
+	writel(status, umac_mdio->base + UMAC_MII);
+
+	status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
+	writel(status, umac_mdio->base + UMAC_MII);
+
+	ret = readl_poll_timeout(umac_mdio->base + UMAC_MII, status,
+				 !(status & UMAC_MII_MOWNER), 1000, 100000);
+	if (ret)
+		dev_err(bus->parent, "mdio read time out\n");
+
+	return ret;
+}
+
+static int umac_mdio_probe(struct platform_device *pdev)
+{
+	struct umac_mdio_priv *umac_mdio;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct mii_bus *bus;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "fail to get resource\n");
+		return -ENODEV;
+	}
+
+	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*umac_mdio));
+	if (!bus) {
+		dev_err(&pdev->dev, "failed to alloc mii bus\n");
+		return -ENOMEM;
+	}
+
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(&pdev->dev));
+
+	bus->name	= dev_name(&pdev->dev);
+	bus->read	= umac_mdio_read;
+	bus->write	= umac_mdio_write;
+	bus->parent	= &pdev->dev;
+	umac_mdio = bus->priv;
+	umac_mdio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!umac_mdio->base) {
+		dev_err(&pdev->dev, "failed to do ioremap\n");
+		return -ENODEV;
+	}
+
+	ret = devm_of_mdiobus_register(dev, bus, pdev->dev.of_node);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id umac_mdio_of_matches[] = {
+	{ .compatible = "hpe,gxp-umac-mdio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, umac_mdio_of_matches);
+
+static struct platform_driver umac_driver = {
+	.driver	= {
+		.name    = "gxp-umac-mdio",
+		.of_match_table = umac_mdio_of_matches,
+	},
+	.probe   = umac_mdio_probe,
+};
+
+module_platform_driver(umac_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_DESCRIPTION("HPE GXP UMAC MDIO driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

