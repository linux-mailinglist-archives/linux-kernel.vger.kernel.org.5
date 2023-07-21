Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891B75D682
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGUVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGUVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:25:20 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DF23A94;
        Fri, 21 Jul 2023 14:24:59 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LIH3d0007369;
        Fri, 21 Jul 2023 21:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=m/rcipiFDUFTVVTI3gLfC3rThRMIiIy72tAvIjWPOYo=;
 b=Ru3o7PmcEdq8eACyf5YBOXD+Yrnu08wlyp0Q9DNQphOG7y1vdZfcS4iYO6WykIV0pBuC
 BgJMfA41ukwffTa8L0MpFd4Cppw3N9mwWDpreD/It0pkrzgCaws0GSzVdCTyteZPixqX
 1tdZkPkSwL9nW3ylexErpf9JxpCCII6GQGFKPlpnbOlri1OePNPR8seWN+knTfWHbkdo
 7mvBjtVOKK19eQC6ouY8ukWCkuxUA7weBQVlTvqnc/SK9/goAg/IIoyC2xN3fpJu5IAu
 cRiaT46IT8KXoYw+C6lOjydv2tSAzRpaH7iftncH/tY3E+GxQOK8z/TmUgdEpFHecphI Fg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ryrxa4mp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 21:24:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1D01FD2C6;
        Fri, 21 Jul 2023 21:24:28 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6753880A555;
        Fri, 21 Jul 2023 21:24:27 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] net: hpe: Add GXP UMAC MDIO
Date:   Fri, 21 Jul 2023 16:20:41 -0500
Message-Id: <20230721212044.59666-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721212044.59666-1-nick.hawkins@hpe.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 65nR56lbpxoCbusJez4V8tEt5Z-hZHWI
X-Proofpoint-GUID: 65nR56lbpxoCbusJez4V8tEt5Z-hZHWI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 drivers/net/ethernet/Kconfig             |   1 +
 drivers/net/ethernet/Makefile            |   1 +
 drivers/net/ethernet/hpe/Kconfig         |  28 ++++
 drivers/net/ethernet/hpe/Makefile        |   1 +
 drivers/net/ethernet/hpe/gxp-umac-mdio.c | 158 +++++++++++++++++++++++
 5 files changed, 189 insertions(+)
 create mode 100644 drivers/net/ethernet/hpe/Kconfig
 create mode 100644 drivers/net/ethernet/hpe/Makefile
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac-mdio.c

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
diff --git a/drivers/net/ethernet/hpe/Kconfig b/drivers/net/ethernet/hpe/Kconfig
new file mode 100644
index 000000000000..461aa15ace34
--- /dev/null
+++ b/drivers/net/ethernet/hpe/Kconfig
@@ -0,0 +1,28 @@
+config NET_VENDOR_HPE
+	bool "HPE device"
+	default y
+	depends on ARCH_HPE
+	help
+	  Say y here to support the HPE network devices.
+	  The GXP contains two Ethernet MACs that can be
+	  connected externally to several physical devices.
+	  From an external interface perspective the BMC
+	  provides two SERDES interface connections capable
+	  of either SGMII or 1000Base-X operation. The BMC
+	  also provides a RMII interface for sideband
+	  connections to external Ethernet controllers.
+
+if NET_VENDOR_HPE
+
+config GXP_UMAC_MDIO
+	tristate "GXP UMAC mdio support"
+	depends on ARCH_HPE
+	help
+	  Say y here to support the GXP UMAC MDIO bus. The
+	  MDIO(mdio0) interface from the primary MAC (umac0)
+	  is used for external PHY status and configuration.
+	  The MDIO(mdio1) interface from the secondary MAC
+	  (umac1) is routed to the SGMII/100Base-X IP blocks
+	  on the two SERDES interface connections.
+
+endif
diff --git a/drivers/net/ethernet/hpe/Makefile b/drivers/net/ethernet/hpe/Makefile
new file mode 100644
index 000000000000..e84c8786ba04
--- /dev/null
+++ b/drivers/net/ethernet/hpe/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_GXP_UMAC_MDIO) += gxp-umac-mdio.o
diff --git a/drivers/net/ethernet/hpe/gxp-umac-mdio.c b/drivers/net/ethernet/hpe/gxp-umac-mdio.c
new file mode 100644
index 000000000000..763e59185409
--- /dev/null
+++ b/drivers/net/ethernet/hpe/gxp-umac-mdio.c
@@ -0,0 +1,158 @@
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
+	unsigned int value;
+	unsigned int status;
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
+		return -ETIMEDOUT;
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
+	if (ret) {
+		dev_err(bus->parent, "mdio read time out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int umac_mdio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct mii_bus *bus;
+	struct umac_mdio_priv *umac_mdio;
+
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "fail to get resource\n");
+		return -ENODEV;
+	}
+
+	bus = devm_mdiobus_alloc_size(&pdev->dev,
+				      sizeof(struct umac_mdio_priv));
+	if (!bus) {
+		dev_err(&pdev->dev, "failed to alloc mii bus\n");
+		return -ENOMEM;
+	}
+
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(&pdev->dev));
+
+	bus->name	= dev_name(&pdev->dev);
+	bus->read	= umac_mdio_read,
+	bus->write	= umac_mdio_write,
+	bus->parent	= &pdev->dev;
+	umac_mdio = bus->priv;
+	umac_mdio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!umac_mdio->base) {
+		dev_err(&pdev->dev, "failed to do ioremap\n");
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, umac_mdio);
+
+	ret = of_mdiobus_register(bus, pdev->dev.of_node);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int umac_mdio_remove(struct platform_device *pdev)
+{
+	struct mii_bus *bus = platform_get_drvdata(pdev);
+
+	if (bus)
+		mdiobus_unregister(bus);
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
+		.of_match_table = of_match_ptr(umac_mdio_of_matches),
+	},
+	.probe   = umac_mdio_probe,
+	.remove  = umac_mdio_remove,
+};
+
+module_platform_driver(umac_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_DESCRIPTION("HPE GXP UMAC MDIO driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

