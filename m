Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93A77EC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbjHPV4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346694AbjHPV4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:56:17 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC362723;
        Wed, 16 Aug 2023 14:56:14 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GH20Oi011663;
        Wed, 16 Aug 2023 21:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=mIYrcVXlhgagGdXZFxeAiOfWQRG8/fjsfcYhggEVzv4=;
 b=ccQhGPqicXTpMXItiXS8pgVwSyPEhSBqlKk1WWADoDfCphJEG0ty+FgAxjIkw/LxAcbl
 S9YG0+nba8SV9VlBv4pvAk7B2JVg3t5VE6BSFRIGlGRS+K9dYEQtvMlOYP3GXY86WFjR
 ZtZa4tqHgIrCmivX5yDqe0ybMIGvAkVqX3w5Lg4Ys7LNCo/UoVBL0rcYf+F3oyCTvdHt
 KsFAHfTblS3lcEcmviSAYMlTvJI+ZILXA8VLVw3dujd4gS1kyLkCivSTRI3u1RQoOOnH
 68Pq400wuSz1Nq/8ahGOa0f+Ro5pEV4yjYRQnbNxwbfFkblo/0wkVPbhhVtFO2BtMSOO Bw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sgwsmd98e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:55:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6EF78801711;
        Wed, 16 Aug 2023 21:55:48 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 69E8F800237;
        Wed, 16 Aug 2023 21:55:47 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Date:   Wed, 16 Aug 2023 16:52:19 -0500
Message-Id: <20230816215220.114118-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816215220.114118-1-nick.hawkins@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 1a0MCIreA3w-Xhx9rA8CWO9FfwWILB3w
X-Proofpoint-GUID: 1a0MCIreA3w-Xhx9rA8CWO9FfwWILB3w
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP contains two Ethernet MACs that can be connected externally
to several physical devices. From an external interface perspective
the BMC provides two SERDES interface connections capable of either
SGMII or 1000Base-X operation. The BMC also provides a RMII interface
for sideband connections to external Ethernet controllers.

The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
SERDES interface.  The secondary MAC (umac1) can be mapped to only
the second SGMII/1000-Base X Serdes interface or it can be mapped for
RMII sideband.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v3:
 *Modify Kconfig and Makefile for ethernet directory for hpe
 *Remove version driver info
 *Removed direct writes to PHYs in MAC driver
 *Removed fixed-link code
 *Fixed code alignment
 *Updated commit description
 *Removed Direct PHY Configuration
v2:
 *Change to reverse christmas tree format
 *Fix use of cpu_to_le32
 *Add use of __le32 variable
 *use devm_alloc_etherdev
 *Removed remove function
 *Used devm_register_netdev
 *Removed unnecessary variable err
 *Removed free_netdev
 *Fixed compatible string
 *Removed of_match_ptr
 *Fixed return on failure to register
---
 drivers/net/ethernet/Kconfig        |   1 +
 drivers/net/ethernet/Makefile       |   1 +
 drivers/net/ethernet/hpe/Kconfig    |  32 ++
 drivers/net/ethernet/hpe/Makefile   |   1 +
 drivers/net/ethernet/hpe/gxp-umac.c | 759 ++++++++++++++++++++++++++++
 drivers/net/ethernet/hpe/gxp-umac.h |  89 ++++
 6 files changed, 883 insertions(+)
 create mode 100644 drivers/net/ethernet/hpe/Kconfig
 create mode 100644 drivers/net/ethernet/hpe/Makefile
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac.c
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac.h

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
index 0d872d4efcd1..ce97bbae2cdc 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_NET_VENDOR_FUJITSU) += fujitsu/
 obj-$(CONFIG_NET_VENDOR_FUNGIBLE) += fungible/
 obj-$(CONFIG_NET_VENDOR_GOOGLE) += google/
 obj-$(CONFIG_NET_VENDOR_HISILICON) += hisilicon/
+obj-$(CONFIG_NET_VENDOR_HPE) += hpe/
 obj-$(CONFIG_NET_VENDOR_HUAWEI) += huawei/
 obj-$(CONFIG_NET_VENDOR_IBM) += ibm/
 obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
diff --git a/drivers/net/ethernet/hpe/Kconfig b/drivers/net/ethernet/hpe/Kconfig
new file mode 100644
index 000000000000..6d24ef413067
--- /dev/null
+++ b/drivers/net/ethernet/hpe/Kconfig
@@ -0,0 +1,32 @@
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
+config GXP_UMAC
+	tristate "GXP UMAC support"
+	depends on ARCH_HPE || COMPILE_TEST
+	select CRC32
+	select MII
+	select PHYLIB
+	select GXP_UMAC_MDIO
+	help
+	  Say y here to support the GXP UMACs interface. The
+	  primary MAC (umac0) can be mapped to either
+	  SGMII/1000-BaseX SERDES interface. The secondary MAC
+	  (umac1) can be mapped to only the second
+	  SGMII/1000-Base X Serdes interface or it can be
+	  mapped for RMII sideband.
+
+endif
diff --git a/drivers/net/ethernet/hpe/Makefile b/drivers/net/ethernet/hpe/Makefile
new file mode 100644
index 000000000000..e84bb86f82bc
--- /dev/null
+++ b/drivers/net/ethernet/hpe/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_GXP_UMAC) += gxp-umac.o
diff --git a/drivers/net/ethernet/hpe/gxp-umac.c b/drivers/net/ethernet/hpe/gxp-umac.c
new file mode 100644
index 000000000000..148ad36a73c6
--- /dev/null
+++ b/drivers/net/ethernet/hpe/gxp-umac.c
@@ -0,0 +1,759 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <net/ncsi.h>
+#include <linux/of_device.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
+#include "gxp-umac.h"
+
+#define DRV_MODULE_NAME		"gxp-umac"
+
+#define NUMBER_OF_PORTS 2
+#define EXTERNAL_PORT 1
+#define INTERNAL_PORT 0
+
+struct umac_priv {
+	void __iomem *base;
+	int irq;
+	struct platform_device *pdev;
+	struct umac_tx_descs *tx_descs;
+	struct umac_rx_descs *rx_descs;
+	dma_addr_t tx_descs_dma_addr;
+	dma_addr_t rx_descs_dma_addr;
+	unsigned int tx_cur;
+	unsigned int tx_done;
+	unsigned int rx_cur;
+	struct napi_struct napi;
+	struct net_device *ndev;
+	struct phy_device *phy_dev;
+	struct phy_device *int_phy_dev;
+	struct ncsi_dev *ncsidev;
+	bool use_ncsi;
+};
+
+static void umac_get_drvinfo(struct net_device *ndev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_MODULE_NAME, sizeof(info->driver));
+}
+
+static struct net_device_stats *umac_get_stats(struct net_device *ndev)
+{
+	return &ndev->stats;
+}
+
+static int umac_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+{
+	if (!netif_running(ndev))
+		return -EINVAL;
+
+	if (!ndev->phydev)
+		return -ENODEV;
+
+	return phy_mii_ioctl(ndev->phydev, ifr, cmd);
+}
+
+static void umac_set_mac_address(struct net_device *ndev, void *p_addr)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	char *addr = (char *)p_addr;
+	unsigned int value;
+
+	/* update address to register */
+	value = addr[0] << 8 | addr[1];
+	writel(value, umac->base + UMAC_MAC_ADDR_HI);
+	value = addr[2] << 8 | addr[3];
+	writel(value, umac->base + UMAC_MAC_ADDR_MID);
+	value = addr[4] << 8 | addr[5];
+	writel(value, umac->base + UMAC_MAC_ADDR_LO);
+}
+
+static int umac_eth_mac_addr(struct net_device *ndev, void *p)
+{
+	struct sockaddr *addr = p;
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(ndev, p);
+	if (ret < 0)
+		return ret;
+
+	eth_commit_mac_addr_change(ndev, p);
+	umac_set_mac_address(ndev, addr->sa_data);
+
+	return 0;
+}
+
+static void umac_channel_enable(struct umac_priv *umac)
+{
+	unsigned int value;
+
+	value = readl(umac->base + UMAC_CONFIG_STATUS);
+	value |= UMAC_CFG_TXEN | UMAC_CFG_RXEN;
+	writel(value, umac->base + UMAC_CONFIG_STATUS);
+
+	/* start processing by writing the ring prompt register */
+	writel(0, umac->base + UMAC_RING_PROMPT);
+}
+
+static void umac_channel_disable(struct umac_priv *umac)
+{
+	writel(0, umac->base + UMAC_CONFIG_STATUS);
+}
+
+static int umac_init_ring_discriptor(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	struct platform_device *pdev = umac->pdev;
+
+	struct umac_tx_desc_entry *ptxdesc;
+	struct umac_rx_desc_entry *prxdesc;
+
+	unsigned int i;
+
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+		netdev_err(ndev, "No suitable DMA available\n");
+		return -ENOMEM;
+	}
+
+	umac->tx_descs = dma_alloc_coherent(&pdev->dev,
+					    sizeof(struct umac_tx_descs),
+					    &umac->tx_descs_dma_addr, GFP_KERNEL);
+	if (!umac->tx_descs)
+		return -ENOMEM;
+
+	umac->rx_descs = dma_alloc_coherent(&pdev->dev,
+					    sizeof(struct umac_rx_descs),
+					    &umac->rx_descs_dma_addr, GFP_KERNEL);
+	if (!umac->rx_descs) {
+		dma_free_coherent(&pdev->dev, sizeof(struct umac_tx_descs),
+				  umac->tx_descs,
+				  umac->tx_descs_dma_addr);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < UMAC_MAX_TX_DESC_ENTRIES; i++) {
+		ptxdesc = &umac->tx_descs->entrylist[i];
+		ptxdesc->dmaaddress = cpu_to_le32(umac->tx_descs_dma_addr +
+						  offsetof(struct umac_tx_descs,
+							   framelist[i][0]));
+	}
+
+	for (i = 0; i < UMAC_MAX_RX_DESC_ENTRIES; i++) {
+		prxdesc = &umac->rx_descs->entrylist[i];
+		prxdesc->dmaaddress = cpu_to_le32(umac->rx_descs_dma_addr +
+						  offsetof(struct umac_rx_descs,
+							   framelist[i][0]));
+		prxdesc->status = UMAC_RING_ENTRY_HW_OWN;
+		prxdesc->count = UMAC_MAX_RX_FRAME_SIZE;
+	}
+
+	umac->tx_cur = 0;
+	umac->tx_done = 0;
+	umac->rx_cur = 0;
+
+	return 0;
+}
+
+static int umac_init_hw(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	unsigned int value;
+
+	/* initialize tx and rx rings to first entry */
+	writel(0, umac->base + UMAC_RING_PTR);
+
+	/* clear the missed bit */
+	writel(0, umac->base + UMAC_CLEAR_STATUS);
+
+	/* disable checksum generation */
+	writel(0, umac->base + UMAC_CKSUM_CONFIG);
+
+	/* write the ring size register */
+	value = ((UMAC_RING_SIZE_256 << UMAC_TX_RING_SIZE_SHIFT) &
+			UMAC_TX_RING_SIZE_MASK) |
+		((UMAC_RING_SIZE_256 << UMAC_RX_RING_SIZE_SHIFT) &
+			UMAC_RX_RING_SIZE_MASK);
+	writel(value, umac->base + UMAC_RING_SIZE);
+
+	/* write rx ring base address */
+	writel(umac->rx_descs_dma_addr,
+	       umac->base + UMAC_RX_RING_ADDR);
+
+	/* write tx ring base address */
+	writel(umac->tx_descs_dma_addr,
+	       umac->base + UMAC_TX_RING_ADDR);
+
+	/* write burst size */
+	writel(0x22, umac->base + UMAC_DMA_CONFIG);
+
+	umac_channel_disable(umac);
+
+	/* disable clocks and gigabit mode (leave channels disabled) */
+	value = readl(umac->base + UMAC_CONFIG_STATUS);
+	value &= 0xfffff9ff;
+	writel(value, umac->base + UMAC_CONFIG_STATUS);
+	udelay(2);
+
+	if (umac->use_ncsi) {
+		/* set correct tx clock */
+		value &= UMAC_CFG_TX_CLK_EN;
+		value &= ~UMAC_CFG_GTX_CLK_EN;
+		value &= ~UMAC_CFG_GIGABIT_MODE; /* RMII mode */
+		value |= UMAC_CFG_FULL_DUPLEX; /* full duplex */
+	} else {
+		value |= UMAC_CFG_FULL_DUPLEX;
+
+		if (ndev->phydev->speed == SPEED_1000) {
+			value &= ~UMAC_CFG_TX_CLK_EN;
+			value |= UMAC_CFG_GTX_CLK_EN;
+			value |= UMAC_CFG_GIGABIT_MODE;
+		} else {
+			value |= UMAC_CFG_TX_CLK_EN;
+			value &= ~UMAC_CFG_GTX_CLK_EN;
+			value &= ~UMAC_CFG_GIGABIT_MODE;
+		}
+	}
+	writel(value, umac->base + UMAC_CONFIG_STATUS);
+	udelay(2);
+
+	umac_channel_enable(umac);
+
+	return 0;
+}
+
+static int umac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	struct umac_tx_desc_entry *ptxdesc;
+	unsigned int length;
+	u8 *pframe;
+
+	ptxdesc = &umac->tx_descs->entrylist[umac->tx_cur];
+	pframe = umac->tx_descs->framelist[umac->tx_cur];
+
+	length = skb->len;
+	if (length > 1514) {
+		netdev_err(ndev, "send data %d bytes > 1514, clamp it to 1514\n",
+			   skb->len);
+		length = 1514;
+	}
+
+	memset(pframe, 0, UMAC_MAX_FRAME_SIZE);
+	memcpy(pframe, skb->data, length);
+
+	if (length < ETH_ZLEN)
+		length = ETH_ZLEN; /* minimum tx byte */
+
+	ptxdesc->count = length;
+	ptxdesc->status = UMAC_RING_ENTRY_HW_OWN;
+	ptxdesc->cksumoffset = 0; /* disable checksum generation */
+
+	umac->tx_cur++;
+	if (umac->tx_cur >= UMAC_MAX_TX_DESC_ENTRIES)
+		umac->tx_cur = 0;
+
+	/* if current tx ring buffer is full, stop the queue */
+	ptxdesc = &umac->tx_descs->entrylist[umac->tx_cur];
+	if (ptxdesc->status & UMAC_RING_ENTRY_HW_OWN)
+		netif_stop_queue(ndev);
+
+	/* start processing by writing the ring prompt register */
+	writel(0, umac->base + UMAC_RING_PROMPT);
+	dev_kfree_skb(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static int umac_rx(struct net_device *ndev, int budget)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+
+	struct umac_rx_desc_entry *prxdesc;
+	struct sk_buff *skb;
+
+	unsigned int rxlength;
+	int rxpktcount = 0;
+	u8 *pframe;
+	u8 *skb_buf;
+
+	prxdesc = &umac->rx_descs->entrylist[umac->rx_cur];
+	pframe = umac->rx_descs->framelist[umac->rx_cur];
+
+	while (!(prxdesc->status & UMAC_RING_ENTRY_HW_OWN)) {
+		rxlength = prxdesc->count;
+		skb = netdev_alloc_skb(ndev, rxlength);
+		if (!skb) {
+			/* run out of memory */
+			ndev->stats.rx_dropped++;
+			return rxpktcount;
+		}
+
+		/* make 16 bytes aligned for 14 bytes ethernet header */
+		skb_buf = skb_put(skb, rxlength);
+		memcpy(skb_buf, pframe, rxlength);
+
+		skb->protocol = eth_type_trans(skb, ndev);
+		netif_receive_skb(skb);
+		rxpktcount++;
+
+		prxdesc->status = UMAC_RING_ENTRY_HW_OWN;
+		prxdesc->count = UMAC_MAX_FRAME_SIZE;
+
+		ndev->stats.rx_packets++;
+		ndev->stats.rx_bytes += rxlength;
+
+		/* move to next buffer */
+		umac->rx_cur++;
+		if (umac->rx_cur >= UMAC_MAX_RX_DESC_ENTRIES)
+			umac->rx_cur = 0;
+
+		if (rxpktcount >= budget)
+			break;
+
+		prxdesc = &umac->rx_descs->entrylist[umac->rx_cur];
+		pframe = umac->rx_descs->framelist[umac->rx_cur];
+	}
+	/* start processing by writing the ring prompt register */
+	writel(0, umac->base + UMAC_RING_PROMPT);
+
+	return rxpktcount;
+}
+
+static void umac_tx_done(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+
+	unsigned int txptr;
+	unsigned int value;
+	struct umac_tx_desc_entry *ptxdesc;
+
+	value = readl(umac->base + UMAC_RING_PTR);
+	txptr = (value & UMAC_TX_RING_PTR_MASK) >> UMAC_TX_RING_PTR_SHIFT;
+
+	ptxdesc = &umac->tx_descs->entrylist[umac->tx_done];
+
+	while (!(ptxdesc->status & UMAC_RING_ENTRY_HW_OWN)) {
+		if (umac->tx_done == txptr)
+			break;
+
+		ndev->stats.tx_packets++;
+		ndev->stats.tx_bytes += ptxdesc->count;
+
+		umac->tx_done++;
+		if (umac->tx_done >= UMAC_MAX_TX_DESC_ENTRIES)
+			umac->tx_done = 0;
+		ptxdesc = &umac->tx_descs->entrylist[umac->tx_done];
+	}
+
+	/* clear tx interrupt */
+	value = readl(umac->base + UMAC_INTERRUPT);
+	value &= ~UMAC_TX_INT;
+	writel(value, umac->base + UMAC_INTERRUPT);
+
+	if (netif_queue_stopped(ndev))
+		netif_wake_queue(ndev);
+}
+
+static void umac_irq_enable(struct umac_priv *umac)
+{
+	unsigned int value;
+
+	/* enable interrupt */
+	value = readl(umac->base + UMAC_INTERRUPT);
+	value |= (UMAC_RX_INTEN | UMAC_TX_INTEN);
+	writel(value, umac->base + UMAC_INTERRUPT);
+}
+
+static void umac_irq_disable(struct umac_priv *umac)
+{
+	unsigned int value;
+
+	/* clear and disable interrupt */
+	value = readl(umac->base + UMAC_INTERRUPT);
+	value |= (UMAC_RX_INT | UMAC_TX_INT);
+	value &= ~(UMAC_RX_INTEN | UMAC_TX_INTEN);
+	writel(value, umac->base + UMAC_INTERRUPT);
+}
+
+static irqreturn_t umac_interrupt(int irq, void *p_ndev)
+{
+	struct net_device *ndev = (struct net_device *)p_ndev;
+	struct umac_priv *umac = netdev_priv(ndev);
+
+	if (umac->use_ncsi || netif_running(ndev)) {
+		umac_irq_disable(umac);
+		napi_schedule(&umac->napi);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int umac_poll(struct napi_struct *napi, int budget)
+{
+	struct umac_priv *umac = container_of(napi, struct umac_priv, napi);
+	struct net_device *ndev = umac->ndev;
+	unsigned int value;
+	int rx_done;
+
+	umac_tx_done(ndev);
+
+	rx_done = umac_rx(ndev, budget);
+
+	if (rx_done < budget) {
+		napi_complete_done(napi, rx_done);
+		/* clear rx interrupt */
+		value = readl(umac->base + UMAC_INTERRUPT);
+		value &= ~UMAC_RX_INT;
+		writel(value, umac->base + UMAC_INTERRUPT);
+
+		/* enable interrupt */
+		umac_irq_enable(umac);
+	}
+
+	return rx_done;
+}
+
+static int umac_open(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	int err;
+
+	if (request_irq(ndev->irq, umac_interrupt, 0x0, ndev->name, ndev)) {
+		netdev_err(ndev, "failed to register irq\n");
+		return -EAGAIN;
+	}
+
+	umac_init_ring_discriptor(ndev);
+	umac_init_hw(ndev);
+
+	if (umac->use_ncsi)
+		netif_carrier_on(ndev);
+	else
+		phy_start(ndev->phydev);
+
+	napi_enable(&umac->napi);
+	netif_start_queue(ndev);
+	umac_irq_enable(umac);
+
+	if (umac->use_ncsi) {
+		err = ncsi_start_dev(umac->ncsidev);
+		if (err) {
+			netdev_err(ndev, "failed to start ncsi\n");
+			free_irq(ndev->irq, ndev);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int umac_stop(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	struct platform_device *pdev = umac->pdev;
+
+	dma_free_coherent(&pdev->dev, sizeof(struct umac_tx_descs),
+			  umac->tx_descs, umac->tx_descs_dma_addr);
+	dma_free_coherent(&pdev->dev, sizeof(struct umac_rx_descs),
+			  umac->rx_descs, umac->rx_descs_dma_addr);
+	netif_stop_queue(ndev);
+
+	if (umac->use_ncsi)
+		ncsi_stop_dev(umac->ncsidev);
+	else
+		phy_stop(ndev->phydev);
+	umac_irq_disable(umac);
+	umac_channel_disable(umac);
+	napi_disable(&umac->napi);
+
+	free_irq(ndev->irq, ndev);
+
+	return 0;
+}
+
+static const struct ethtool_ops umac_ethtool_ops = {
+	.get_ts_info	= ethtool_op_get_ts_info,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_drvinfo	= umac_get_drvinfo,
+	.nway_reset	= phy_ethtool_nway_reset,
+	.get_link	= ethtool_op_get_link,
+};
+
+static const struct net_device_ops umac_netdev_ops = {
+	.ndo_open		= umac_open,
+	.ndo_stop		= umac_stop,
+	.ndo_start_xmit		= umac_start_xmit,
+	.ndo_get_stats		= umac_get_stats,
+	.ndo_do_ioctl		= umac_ioctl,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= umac_eth_mac_addr,
+};
+
+static int umac_init_mac_address(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	struct platform_device *pdev = umac->pdev;
+	char addr[ETH_ALEN];
+	int err;
+
+	err = of_get_mac_address(pdev->dev.of_node, addr);
+	if (err)
+		netdev_err(ndev, "Failed to get address from device-tree: %d\n",
+			   err);
+		return -EINVAL;
+
+	if (is_valid_ether_addr(addr)) {
+		dev_addr_set(ndev, addr);
+		netdev_dbg(ndev,
+			   "Read MAC address %pM from DTB\n", ndev->dev_addr);
+	} else {
+		netdev_err(ndev, "Mac Address is Invalid");
+		return -EINVAL;
+	}
+
+	dev_addr_set(ndev, addr);
+	umac_set_mac_address(ndev, addr);
+
+	return 0;
+}
+
+static void umac_ncsi_handler(struct ncsi_dev *ncsidev)
+{
+	if (unlikely(ncsidev->state != ncsi_dev_state_functional))
+		return;
+}
+
+static void umac_adjust_link(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	int value;
+
+	if (ndev->phydev->link) {
+		/* disable both clock */
+		value = readl(umac->base + UMAC_CONFIG_STATUS);
+		value &= 0xfffff9ff;
+		writel(value, umac->base + UMAC_CONFIG_STATUS);
+		udelay(2);
+
+		if (ndev->phydev->duplex)
+			value |= UMAC_CFG_FULL_DUPLEX;
+		else
+			value &= ~UMAC_CFG_FULL_DUPLEX;
+
+		switch (ndev->phydev->speed) {
+		case SPEED_1000:
+			value &= ~UMAC_CFG_TX_CLK_EN;
+			value |= UMAC_CFG_GTX_CLK_EN;
+			value |= UMAC_CFG_GIGABIT_MODE;
+			break;
+		case SPEED_100:
+		case SPEED_10:
+			value |= UMAC_CFG_TX_CLK_EN;
+			value &= ~UMAC_CFG_GTX_CLK_EN;
+			value &= ~UMAC_CFG_GIGABIT_MODE;
+			break;
+		}
+		/* update duplex and gigabit_mode to umac */
+		writel(value, umac->base + UMAC_CONFIG_STATUS);
+		udelay(2);
+	} else {
+		/* disable both clock */
+		value = readl(umac->base + UMAC_CONFIG_STATUS);
+		value &= 0xfffff9ff;
+		writel(value, umac->base + UMAC_CONFIG_STATUS);
+		udelay(2);
+
+		value &= ~UMAC_CFG_FULL_DUPLEX;
+		value &= ~UMAC_CFG_GTX_CLK_EN;
+		value &= ~UMAC_CFG_GIGABIT_MODE;
+		value |= UMAC_CFG_TX_CLK_EN;
+		writel(value, umac->base + UMAC_CONFIG_STATUS);
+		udelay(2);
+	}
+}
+
+static struct device_node *gxp_umac_get_eth_child_node(struct device_node *ether_np, int id)
+{
+	struct device_node *port_np;
+	int port_id;
+
+	for_each_child_of_node(ether_np, port_np) {
+		/* It is not a 'port' node, continue. */
+		if (strcmp(port_np->name, "port"))
+			continue;
+		if (of_property_read_u32(port_np, "reg", &port_id) < 0)
+			continue;
+
+		if (port_id == id)
+			return port_np;
+	}
+
+	/* Not found! */
+	return NULL;
+}
+
+static int umac_setup_phy(struct net_device *ndev)
+{
+	struct umac_priv *umac = netdev_priv(ndev);
+	struct platform_device *pdev = umac->pdev;
+	struct device_node *phy_handle;
+	phy_interface_t interface;
+	struct device_node *eth_ports_np;
+	struct device_node *port_np;
+	int ret;
+	int i;
+
+	/* Get child node ethernet-ports. */
+	eth_ports_np = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
+	if (!eth_ports_np) {
+		dev_err(&pdev->dev, "No ethernet-ports child node found!\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < NUMBER_OF_PORTS; i++) {
+		/* Get port@i of node ethernet-ports */
+		port_np = gxp_umac_get_eth_child_node(eth_ports_np, i);
+		if (!port_np)
+			break;
+
+		if (i == INTERNAL_PORT) {
+			phy_handle = of_parse_phandle(port_np, "phy-handle", 0);
+			if (phy_handle) {
+				umac->int_phy_dev = of_phy_find_device(phy_handle);
+				if (!umac->int_phy_dev)
+					return -ENODEV;
+			} else {
+				return dev_err_probe(&pdev->dev, PTR_ERR(phy_handle),
+						     "Failed to map phy-handle for port %d", i);
+			}
+		}
+
+		if (i == EXTERNAL_PORT) {
+			phy_handle = of_parse_phandle(port_np, "phy-handle", 0);
+			if (phy_handle) {
+				if (ret)
+					dev_err(&pdev->dev, "cannot register phy board fixup\n");
+
+				ret = of_get_phy_mode(phy_handle, &interface);
+				if (ret)
+					interface = PHY_INTERFACE_MODE_NA;
+
+				umac->phy_dev = of_phy_connect(ndev, phy_handle,
+							       &umac_adjust_link,
+							       0, interface);
+
+				if (!umac->phy_dev)
+					return -ENODEV;
+
+				phy_remove_link_mode(umac->phy_dev,
+						     ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+				phy_remove_link_mode(umac->phy_dev,
+						     ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+			} else {
+				return dev_err_probe(&pdev->dev, PTR_ERR(phy_handle),
+						     "Failed to map phy-handle for port %d", i);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int umac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *ndev;
+	struct umac_priv *umac;
+	struct resource *res;
+	int ret;
+
+	ndev = devm_alloc_etherdev(dev, sizeof(*umac));
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	umac = netdev_priv(ndev);
+	umac->pdev = pdev;
+	umac->ndev = ndev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		netdev_err(ndev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+
+	umac->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!umac->base) {
+		netdev_err(ndev, "failed to remap I/O memory\n");
+		return -EBUSY;
+	}
+
+	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0) {
+		netdev_err(ndev, "failed to get irq\n");
+		return -ENXIO;
+	}
+
+	platform_set_drvdata(pdev, ndev);
+
+	ndev->netdev_ops = &umac_netdev_ops;
+	ndev->ethtool_ops = &umac_ethtool_ops;
+
+	umac_init_mac_address(ndev);
+	umac_channel_disable(umac);
+	ret = umac_setup_phy(ndev);
+	if (ret != 0) {
+		netdev_err(ndev, "failed to setup phy ret=%d\n", ret);
+		return -ENODEV;
+	}
+
+	umac->use_ncsi = false;
+	if (of_get_property(pdev->dev.of_node, "use-ncsi", NULL)) {
+		if (!IS_ENABLED(CONFIG_NET_NCSI)) {
+			netdev_err(ndev, "NCSI stack not enabled\n");
+			return 0;
+		}
+
+		dev_info(&pdev->dev, "Using NCSI interface\n");
+		umac->use_ncsi = true;
+		umac->ncsidev = ncsi_register_dev(ndev, umac_ncsi_handler);
+		if (!umac->ncsidev)
+			return -ENODEV;
+	}
+
+	netif_napi_add(ndev, &umac->napi, umac_poll);
+	ret = devm_register_netdev(dev, ndev);
+	if (ret != 0)
+		netdev_err(ndev, "failed to register UMAC ret=%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id umac_of_matches[] = {
+	{ .compatible = "hpe,gxp-umac", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, umac_of_matches);
+
+static struct platform_driver umac_driver = {
+	.driver	= {
+		.name    = "gxp-umac",
+		.of_match_table = umac_of_matches,
+	},
+	.probe   = umac_probe,
+};
+
+module_platform_driver(umac_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com");
+MODULE_DESCRIPTION("HPE GXP UMAC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/hpe/gxp-umac.h b/drivers/net/ethernet/hpe/gxp-umac.h
new file mode 100644
index 000000000000..b8e313cfdcc6
--- /dev/null
+++ b/drivers/net/ethernet/hpe/gxp-umac.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Hewlett-Packard Development Company, L.P. */
+
+#ifndef _UMAC_H_
+#define _UMAC_H_
+
+#define UMAC_CONFIG_STATUS	0x00        /* R/W Configuration and Status
+					     * Register I
+					     */
+#define UMAC_CFG_TXEN		0x00001000  // transmit enable
+#define UMAC_CFG_RXEN		0x00000800  // receive enable
+#define UMAC_CFG_GTX_CLK_EN	0x00000400  // gigabit clock enable
+#define UMAC_CFG_TX_CLK_EN	0x00000200  // 10/100 clock enable
+#define UMAC_CFG_GIGABIT_MODE	0x00000004  // MAC gigabit mode enable
+#define UMAC_CFG_FULL_DUPLEX	0x00000001  // enable ignoring of collisions
+#define UMAC_RING_PTR		0x04        //  R/W Ring Pointer Register
+#define UMAC_TX_RING_PTR_MASK	0x7FFF0000  // transmit ring entry pointer
+#define UMAC_TX_RING_PTR_SHIFT	16
+#define UMAC_RX_RING_PTR_MASK	0x00007FFF  // receive ring entry pointer
+#define UMAC_RX_RING_PTR_SHIFT	0
+
+#define UMAC_CLEAR_STATUS	0x0C	//  W   Clear Status Register
+#define UMAC_RING_PROMPT	0x08	//  W	Ring Prompt Register
+#define UMAC_CKSUM_CONFIG	0x10	//  R/W	Checksum Config Register
+#define UMAC_RING_SIZE		0x14	//  R/W	Ring Size Register
+#define UMAC_TX_RING_SIZE_MASK	0xFF000000
+#define UMAC_TX_RING_SIZE_SHIFT	24
+#define UMAC_RX_RING_SIZE_MASK	0x00FF0000
+#define UMAC_RX_RING_SIZE_SHIFT	16
+#define UMAC_LAST_RX_PKT_SIZE	0x0000FFFF
+#define UMAC_RING_SIZE_256	0x3F
+
+#define UMAC_MAC_ADDR_HI	0x18	//  R/W	MAC Address[47:32] Register
+#define UMAC_MAC_ADDR_MID	0x1C	//  R/W	MAC Address[31:16] Register
+#define UMAC_MAC_ADDR_LO	0x20	//  R/W	MAC Address[15:0] Register
+#define UMAC_INTERRUPT		0x30	//  R/W	MAC Interrupt Configuration
+					// and Status Register
+#define UMAC_RX_INTEN		0x00000008
+#define UMAC_RX_INT		0x00000004
+#define UMAC_TX_INTEN		0x00000002
+#define UMAC_TX_INT		0x00000001
+
+#define UMAC_RX_RING_ADDR	0x4C	//  R/W	Rx Ring Base Address Register
+#define UMAC_TX_RING_ADDR	0x50	//  R/W	Tx Ring Base Address Register
+#define UMAC_DMA_CONFIG		0x54	//  R/W	DMA Config Register
+
+#define UMAC_MAX_TX_DESC_ENTRIES	0x100	/* 256,number of ring buffer
+						 *  entries supported
+						 */
+#define UMAC_MAX_RX_DESC_ENTRIES	0x100
+#define UMAC_MAX_TX_FRAME_SIZE		0x600
+#define UMAC_MAX_RX_FRAME_SIZE		0x600
+
+// ring status masks
+#define UMAC_RING_ENTRY_HW_OWN		0x8000
+
+// maximum ethernet frame size
+#define UMAC_MIN_FRAME_SIZE		60    // excludes preable, sfd, and fcs
+#define UMAC_MAX_PAYLOAD_SIZE		1500
+#define UMAC_MAX_FRAME_SIZE		1514  // excludes preable, sfd, and fcs
+
+struct umac_rx_desc_entry {
+	__le32  dmaaddress;   // Start address for DMA operationg
+	u16  status;       // Packet tx status and ownership flag
+	u16  count;        // Number of bytes received
+	u16  checksum;     // On-the-fly packet checksum
+	u16  control;      // Checksum-in-time flag
+	u32  reserved;
+} __aligned(16);
+
+struct umac_rx_descs {
+	struct umac_rx_desc_entry entrylist[UMAC_MAX_RX_DESC_ENTRIES];
+	u8 framelist[UMAC_MAX_RX_DESC_ENTRIES][UMAC_MAX_RX_FRAME_SIZE];
+} __packed;
+
+struct umac_tx_desc_entry {
+	__le32  dmaaddress;   // Start address for DMA operationg
+	u16  status;       // Packet rx status, type, and ownership flag
+	u16  count;        // Number of bytes received
+	u32  cksumoffset;  // Specifies where to place packet checksum
+	u32  reserved;
+} __aligned(16);
+
+struct umac_tx_descs {
+	struct umac_tx_desc_entry entrylist[UMAC_MAX_TX_DESC_ENTRIES];
+	u8 framelist[UMAC_MAX_TX_DESC_ENTRIES][UMAC_MAX_TX_FRAME_SIZE];
+} __packed;
+
+#endif
-- 
2.17.1

