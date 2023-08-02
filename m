Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFE76D899
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjHBUW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHBUWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:22:20 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43342690;
        Wed,  2 Aug 2023 13:22:16 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372F2DC4013926;
        Wed, 2 Aug 2023 20:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=cgbQEyEDkaDYvyFKCeMhuF9biIyi2pFHLkLYJdz4Olo=;
 b=PNer5wulT5NC/u/kV4aqvWuD+oeNsK8N1+pM015TYE1rvPMOScC0EXl7Go25ruSALPt2
 mJz2AGVY0bStY+smTm8MP3R3UqXYPDEOn2Fm7GILj/KVJBbpTIv1NKzE+nqpBI5Afh9b
 eAOsLN/Mo2h828AaColtZ97zvziASqqlgorpBXWnLfPzdTIq6+8fWbmCmoBaX3vPDmE6
 xKCWD7Tw5MrOzH/UHd6AHAc/fojqCSeBrGUfBo6rgRL4t8xfT10CFcQpXPlFAFtPInJv
 BsGhY4K2bmORFt7MShEvTPObXX0rJOVjLqsi5NkaeR/TSAN5cfAwKURlF1iid75hbY5B iQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3s7hb76myj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 20:21:56 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 91CCED2E7;
        Wed,  2 Aug 2023 20:21:55 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9506D80F492;
        Wed,  2 Aug 2023 20:21:54 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Date:   Wed,  2 Aug 2023 15:18:21 -0500
Message-Id: <20230802201824.3683-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802201824.3683-1-nick.hawkins@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: A9N-jW-ac4Rh0vzy203H3GAfvMqCwa24
X-Proofpoint-ORIG-GUID: A9N-jW-ac4Rh0vzy203H3GAfvMqCwa24
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/Kconfig     |   1 +
 drivers/net/ethernet/Makefile    |   1 +
 drivers/net/mdio/Kconfig         |  13 +++
 drivers/net/mdio/Makefile        |   1 +
 drivers/net/mdio/mdio-gxp-umac.c | 142 +++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-gxp-umac.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 5a274b99f299..b4921b84be51 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -80,6 +80,7 @@ source "drivers/net/ethernet/fujitsu/Kconfig"
 source "drivers/net/ethernet/fungible/Kconfig"
 source "drivers/net/ethernet/google/Kconfig"
 source "drivers/net/ethernet/hisilicon/Kconfig"
+source "drivers/net/ethernet/hpe/Kconfig"
 source "drivers/net/ethernet/huawei/Kconfig"
 source "drivers/net/ethernet/i825xx/Kconfig"
 source "drivers/net/ethernet/ibm/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 0d872d4efcd1..2e3cae9dbe97 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_NET_VENDOR_FREESCALE) += freescale/
 obj-$(CONFIG_NET_VENDOR_FUJITSU) += fujitsu/
 obj-$(CONFIG_NET_VENDOR_FUNGIBLE) += fungible/
 obj-$(CONFIG_NET_VENDOR_GOOGLE) += google/
+obj-$(CONFIG_NET_VENDOR_HPE) += hpe/
 obj-$(CONFIG_NET_VENDOR_HISILICON) += hisilicon/
 obj-$(CONFIG_NET_VENDOR_HUAWEI) += huawei/
 obj-$(CONFIG_NET_VENDOR_IBM) += ibm/
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 9ff2e6f22f3f..58e054bff786 100644
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
+        help
+	  Say y here to support the GXP UMAC MDIO bus. The
+	  MDIO(mdio0) interface from the primary MAC (umac0)
+	  is used for external PHY status and configuration.
+	  The MDIO(mdio1) interface from the secondary MAC
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
index 000000000000..ddce19a7bb1f
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
+#define UMAC_MII_MOWNER         0x00000200
+#define UMAC_MII_MRNW           0x00000100
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
+	status = __raw_readl(umac_mdio->base + UMAC_MII);
+
+	status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
+	status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
+			UMAC_MII_PHY_ADDR_MASK);
+	status |= (reg & UMAC_MII_REG_ADDR_MASK);
+	status |= UMAC_MII_MRNW; /* set bit for read mode */
+	__raw_writel(status, umac_mdio->base + UMAC_MII);
+
+	status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
+	__raw_writel(status, umac_mdio->base + UMAC_MII);
+
+	ret = readl_poll_timeout(umac_mdio->base + UMAC_MII, status,
+				 !(status & UMAC_MII_MOWNER), 1000, 100000);
+	if (ret) {
+		dev_err(bus->parent, "mdio read time out\n");
+		return ret;
+	}
+
+	value = __raw_readl(umac_mdio->base + UMAC_MII_DATA);
+	return value;
+}
+
+static int umac_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 value)
+{
+	struct umac_mdio_priv *umac_mdio = bus->priv;
+	unsigned int status;
+	int ret;
+
+	__raw_writel(value, umac_mdio->base + UMAC_MII_DATA);
+
+	status = __raw_readl(umac_mdio->base + UMAC_MII);
+
+	status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
+	status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
+			UMAC_MII_PHY_ADDR_MASK);
+	status |= (reg & UMAC_MII_REG_ADDR_MASK);
+	status &= ~UMAC_MII_MRNW; /* clear bit for write mode */
+	__raw_writel(status, umac_mdio->base + UMAC_MII);
+
+	status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
+	__raw_writel(status, umac_mdio->base + UMAC_MII);
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

