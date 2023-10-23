Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBC7D3B49
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjJWPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjJWPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:48:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35510C1;
        Mon, 23 Oct 2023 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076101; x=1729612101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKOyYh8+vIo+d2j/qQ/62TebL7XNgXjBI6Y8djFnusY=;
  b=vPtHXHgO5nsRTM1sYqUpNKW4ZKQTgosm4NsNPsA28urqsxRo5ZT+MwBW
   biNNUMIkUB9WR1CurTZObrj4uzFBQHGR1sMf6rbTkVvuQwkYbo0A37sg4
   2d6r2FZ3oXDVibWvxqfz3PBJ8jpb8mq9s+kH55L85EiDdT+AnjdjkluSx
   NGXb91bgvGOSE36aXXp6vRtIKRGU8LNSdN23asG/TLA3cARCcsHGMuDAL
   SWsrSa5dnEeSokS2nRGWt6ixB0ah2oKFXdjGL1/5HmWHDpOyFOqaBwEIG
   KxWuNGBHgb3GduiInzX6/6goHnLK+3KIcJa2R4MLTU2RfFx+izqGTebDr
   Q==;
X-CSE-ConnectionGUID: 5dJfxnw6T/GgyIcRbipreg==
X-CSE-MsgGUID: Saz8qzNpQNGuhgULQlpWSw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="177613862"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:48:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:48:16 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:48:03 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: implement internal PHY initialization
Date:   Mon, 23 Oct 2023 21:16:45 +0530
Message-ID: <20231023154649.45931-6-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal PHY is initialized as per the PHY register capability supported
by the MAC-PHY. Direct PHY Register Access Capability indicates if PHY
registers are directly accessible within the SPI register memory space.
Indirect PHY Register Access Capability indicates if PHY registers are
indirectly accessible through the MDIO/MDC registers MDIOACCn.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 157 ++++++++++++++++++++++++++++++++--
 include/linux/oa_tc6.h        |  65 +++++++-------
 2 files changed, 187 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 9a98d59f286d..a4532c83e909 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,16 +6,23 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
 #include <linux/of.h>
 #include <linux/oa_tc6.h>
 
 /* Opaque structure for MACPHY drivers */
 struct oa_tc6 {
+	struct net_device *netdev;
+	struct phy_device *phydev;
+	struct mii_bus *mdiobus;
 	struct spi_device *spi;
+	struct device *dev;
 	u8 *ctrl_tx_buf;
 	u8 *ctrl_rx_buf;
+	bool dprac;
+	bool iprac;
 	bool prote;
 	u32 cps;
 };
@@ -204,6 +211,8 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
 {
 	struct spi_device *spi = tc6->spi;
 	struct device_node *oa_node;
+	bool dprac;
+	bool iprac;
 	u32 regval;
 	u8 mincps;
 	bool ctc;
@@ -225,8 +234,14 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
+	/* Minimum supported Chunk Payload Size */
 	mincps = FIELD_GET(MINCPS, regval);
+	/* Cut-Through Capability */
 	ctc = (regval & CTC) ? true : false;
+	/* Direct PHY Register Access Capability */
+	dprac = (regval & DPRAC) ? true : false;
+	/* Indirect PHY Register access Capability */
+	iprac = (regval & IPRAC) ? true : false;
 
 	regval = 0;
 	oa_node = of_get_child_by_name(spi->dev.of_node, "oa-tc6");
@@ -242,7 +257,7 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
 			if (tc6->cps < mincps)
 				return -ENODEV;
 		} else {
-			tc6->cps = 64;
+			tc6->cps = OA_TC6_MAX_CPS;
 		}
 		if (of_property_present(oa_node, "oa-txcte")) {
 			/* Return error if the tx cut through mode is configured
@@ -266,8 +281,26 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
 			regval |= PROTE;
 			tc6->prote = true;
 		}
+		if (of_property_present(oa_node, "oa-dprac")) {
+			/* Return error if the direct phy register access mode
+			 * is configured but it is not supported by MAC-PHY.
+			 */
+			if (dprac)
+				tc6->dprac = true;
+			else
+				return -ENODEV;
+		}
+		if (of_property_present(oa_node, "oa-iprac")) {
+			/* Return error if the indirect phy register access mode
+			 * is configured but it is not supported by MAC-PHY.
+			 */
+			if (iprac)
+				tc6->iprac = true;
+			else
+				return -ENODEV;
+		}
 	} else {
-		tc6->cps = 64;
+		tc6->cps = OA_TC6_MAX_CPS;
 	}
 
 	regval |= FIELD_PREP(CPS, ilog2(tc6->cps) / ilog2(2)) | SYNC;
@@ -379,15 +412,108 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_read_registers);
 
+static void oa_tc6_handle_link_change(struct net_device *netdev)
+{
+	phy_print_status(netdev->phydev);
+}
+
+static int oa_tc6_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+	u32 regval;
+	bool ret;
+
+	ret = oa_tc6_read_register(tc6, 0xFF00 | (idx & 0xFF), &regval);
+	if (ret)
+		return -ENODEV;
+
+	return regval;
+}
+
+static int oa_tc6_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
+				u16 val)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+
+	return oa_tc6_write_register(tc6, 0xFF00 | (idx & 0xFF), val);
+}
+
+static int oa_tc6_phy_init(struct oa_tc6 *tc6)
+{
+	int ret;
+
+	if (tc6->dprac) {
+		tc6->mdiobus = mdiobus_alloc();
+		if (!tc6->mdiobus) {
+			netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
+			return -ENODEV;
+		}
+
+		tc6->mdiobus->phy_mask = ~(u32)BIT(1);
+		tc6->mdiobus->priv = tc6;
+		tc6->mdiobus->read = oa_tc6_mdiobus_read;
+		tc6->mdiobus->write = oa_tc6_mdiobus_write;
+		tc6->mdiobus->name = "oa-tc6-mdiobus";
+		tc6->mdiobus->parent = tc6->dev;
+
+		snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
+			 dev_name(&tc6->spi->dev));
+
+		ret = mdiobus_register(tc6->mdiobus);
+		if (ret) {
+			netdev_err(tc6->netdev, "Could not register MDIO bus\n");
+			mdiobus_free(tc6->mdiobus);
+			return ret;
+		}
+
+		tc6->phydev = phy_find_first(tc6->mdiobus);
+		if (!tc6->phydev) {
+			netdev_err(tc6->netdev, "No PHY found\n");
+			mdiobus_unregister(tc6->mdiobus);
+			mdiobus_free(tc6->mdiobus);
+			return -ENODEV;
+		}
+
+		tc6->phydev->is_internal = true;
+		ret = phy_connect_direct(tc6->netdev, tc6->phydev,
+					 &oa_tc6_handle_link_change,
+					 PHY_INTERFACE_MODE_INTERNAL);
+		if (ret) {
+			netdev_err(tc6->netdev, "Can't attach PHY to %s\n",
+				   tc6->mdiobus->id);
+			mdiobus_unregister(tc6->mdiobus);
+			mdiobus_free(tc6->mdiobus);
+			return ret;
+		}
+
+		phy_attached_info(tc6->netdev->phydev);
+
+		return ret;
+	} else if (tc6->iprac) {
+		// To be implemented. Currently returns -ENODEV.
+		return -ENODEV;
+	} else {
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
+{
+	phy_disconnect(tc6->phydev);
+	mdiobus_unregister(tc6->mdiobus);
+	mdiobus_free(tc6->mdiobus);
+}
+
 /**
  * oa_tc6_init - allocates and intializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
- * @prote: control data (register) read/write protection enable/disable.
+ * @netdev: network device to use.
  *
  * Returns pointer reference to the oa_tc6 structure if all the memory
  * allocation success otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 {
 	struct oa_tc6 *tc6;
 
@@ -395,15 +521,19 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 	if (!tc6)
 		return NULL;
 
+	/* Allocate memory for the control tx buffer used for SPI transfer. */
 	tc6->ctrl_tx_buf = devm_kzalloc(&spi->dev, TC6_CTRL_BUF_SIZE, GFP_KERNEL);
 	if (!tc6->ctrl_tx_buf)
 		return NULL;
 
+	/* Allocate memory for the control rx buffer used for SPI transfer. */
 	tc6->ctrl_rx_buf = devm_kzalloc(&spi->dev, TC6_CTRL_BUF_SIZE, GFP_KERNEL);
 	if (!tc6->ctrl_rx_buf)
 		return NULL;
 
 	tc6->spi = spi;
+	tc6->netdev = netdev;
+	SET_NETDEV_DEV(netdev, &spi->dev);
 
 	/* Perform MAC-PHY software reset */
 	if (oa_tc6_sw_reset(tc6)) {
@@ -417,10 +547,27 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 		return NULL;
 	}
 
+	/* Initialize PHY */
+	if (oa_tc6_phy_init(tc6)) {
+		dev_err(&spi->dev, "PHY initialization failed\n");
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
 
+/**
+ * oa_tc6_exit - exit function.
+ * @tc6: oa_tc6 struct.
+ *
+ */
+void oa_tc6_exit(struct oa_tc6 *tc6)
+{
+	oa_tc6_phy_exit(tc6);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_exit);
+
 MODULE_DESCRIPTION("OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface Lib");
 MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 378636fd9ca8..36b729c384ac 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -5,54 +5,59 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */
 
+#include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 
 /* Control header */
-#define CTRL_HDR_DNC		BIT(31)		/* Data-Not-Control */
-#define CTRL_HDR_HDRB		BIT(30)		/* Received Header Bad */
-#define CTRL_HDR_WNR		BIT(29)		/* Write-Not-Read */
-#define CTRL_HDR_AID		BIT(28)		/* Address Increment Disable */
-#define CTRL_HDR_MMS		GENMASK(27, 24)	/* Memory Map Selector */
-#define CTRL_HDR_ADDR		GENMASK(23, 8)	/* Address */
-#define CTRL_HDR_LEN		GENMASK(7, 1)	/* Length */
-#define CTRL_HDR_P		BIT(0)		/* Parity Bit */
+#define CTRL_HDR_DNC	BIT(31)		/* Data-Not-Control */
+#define CTRL_HDR_HDRB	BIT(30)		/* Received Header Bad */
+#define CTRL_HDR_WNR	BIT(29)		/* Write-Not-Read */
+#define CTRL_HDR_AID	BIT(28)		/* Address Increment Disable */
+#define CTRL_HDR_MMS	GENMASK(27, 24)	/* Memory Map Selector */
+#define CTRL_HDR_ADDR	GENMASK(23, 8)	/* Address */
+#define CTRL_HDR_LEN	GENMASK(7, 1)	/* Length */
+#define CTRL_HDR_P	BIT(0)		/* Parity Bit */
 
 #define TC6_HDR_SIZE		4	/* Ctrl command header size as per OA */
 #define TC6_FTR_SIZE		4	/* Ctrl command footer size ss per OA */
 #define TC6_CTRL_BUF_SIZE	1032	/* Max ctrl buffer size for 128 regs */
+#define OA_TC6_MAX_CPS	64
 
 /* Open Alliance TC6 Standard Control and Status Registers */
 /* Standard Capabilities Register */
-#define STDCAP			0x0002
-#define CTC			BIT(7)	/* Cut-Through Capability */
-#define MINCPS			GENMASK(2, 0)	/* Minimum supported cps */
+#define STDCAP		0x0002
+#define IPRAC		BIT(9)	/* Indirect PHY Reg access Capability */
+#define DPRAC		BIT(8)	/* Direct PHY Reg Access Capability */
+#define CTC		BIT(7)	/* Cut-Through Capability */
+#define MINCPS		GENMASK(2, 0)	/* Minimum supported cps */
 
 /* Reset Control and Status Register */
-#define RESET			0x0003
-#define SWRESET			BIT(0)	/* Software Reset */
+#define RESET		0x0003
+#define SWRESET		BIT(0)	/* Software Reset */
 
 /* Configuration Register #0 */
-#define CONFIG0			0x0004
-#define SYNC			BIT(15)	/* Configuration Synchronization */
-#define TXCTE			BIT(9)	/* Tx cut-through enable */
-#define RXCTE			BIT(8)	/* Rx cut-through enable */
-#define PROTE			BIT(5)	/* Ctrl read/write Protection Enable */
-#define CPS			GENMASK(2, 0)	/* Chunk Payload Size */
+#define CONFIG0		0x0004
+#define SYNC		BIT(15)	/* Configuration Synchronization */
+#define TXCTE		BIT(9)	/* Tx cut-through enable */
+#define RXCTE		BIT(8)	/* Rx cut-through enable */
+#define PROTE		BIT(5)	/* Ctrl read/write Protection Enable */
+#define CPS		GENMASK(2, 0)	/* Chunk Payload Size */
 
 /* Status Register #0 */
-#define STATUS0			0x0008
-#define RESETC			BIT(6)	/* Reset Complete */
+#define STATUS0		0x0008
+#define RESETC		BIT(6)	/* Reset Complete */
 
 /* Interrupt Mask Register #0 */
-#define IMASK0			0x000C
-#define HDREM			BIT(5)	/* Header Error Mask */
-#define LOFEM			BIT(4)	/* Loss of Framing Error Mask */
-#define RXBOEM			BIT(3)	/* Rx Buffer Overflow Error Mask */
-#define TXBUEM			BIT(2)	/* Tx Buffer Underflow Error Mask */
-#define TXBOEM			BIT(1)	/* Tx Buffer Overflow Error Mask */
-#define TXPEM			BIT(0)	/* Tx Protocol Error Mask */
-
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
+#define IMASK0		0x000C
+#define HDREM		BIT(5)	/* Header Error Mask */
+#define LOFEM		BIT(4)	/* Loss of Framing Error Mask */
+#define RXBOEM		BIT(3)	/* Rx Buffer Overflow Error Mask */
+#define TXBUEM		BIT(2)	/* Tx Buffer Underflow Error Mask */
+#define TXBOEM		BIT(1)	/* Tx Buffer Overflow Error Mask */
+#define TXPEM		BIT(0)	/* Tx Protocol Error Mask */
+
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
+void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 *val);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len);
-- 
2.34.1

