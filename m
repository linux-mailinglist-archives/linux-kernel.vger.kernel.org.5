Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032217D3B76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjJWPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJWPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:50:21 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149B10A;
        Mon, 23 Oct 2023 08:50:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24DC61BF214;
        Mon, 23 Oct 2023 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698076211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nio1CpKaWfLxkai0x/MxSDtxEyuEAc1tqIOEW8mxPMc=;
        b=e7umfh5WzLS0XOHcXMPpXfjpbCJ6Omeza9fH4dFFYQ7ujNVgEATRAEqmbMxg6i7ir1Oj0N
        qIjDP7EkXKnPvhPhUma9QrcYW2KaDzJFJ2j4kdzlG0yeW98xuXjnPDOK37JyhlojmIHgzU
        JNCQJi1MLrjtqIVCS1XYSRnHK/tc5dOFvljbyz00M/PlstTy2apoijIlVAp1GYxHBh184A
        uLGYkvcvg4EQ5jUZ9dKE95C3OcrvHW1NlPKMoOl6dyYZckAGq5B/vGQm7kSC+JmzGX4zD8
        AceWGT7bKxPIR2TIzMN+YJVq7FuPSyRBWYdLXDkmOPybS2pQb38hKX/sn1vxMw==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS driver
Date:   Mon, 23 Oct 2023 17:50:10 +0200
Message-ID: <20231023155013.512999-4-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023155013.512999-1-romain.gantois@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm IPQ4019 Ethernet Switch Subsystem for the IPQ4019 chip
includes an internal Ethernet switch based on the QCA8K IP.

The CPU-to-switch port data plane depends on the IPQESS EDMA Controller,
a simple 1G Ethernet controller. It is connected to the switch through an
internal link, and doesn't expose directly any external interface.

The EDMA controller has 16 RX and TX queues, with a very basic RSS fanout
configured at init time.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/qualcomm/Kconfig         |   14 +
 drivers/net/ethernet/qualcomm/Makefile        |    2 +
 drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
 .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1162 ++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  484 ++++
 .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++
 .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
 .../ethernet/qualcomm/ipqess/ipqess_port.c    | 2016 +++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   95 +
 .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  559 +++++
 .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   40 +
 12 files changed, 4722 insertions(+)
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 36815d2feb33..df285ef5d36e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17782,6 +17782,13 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 F:	drivers/mailbox/qcom-ipcc.c
 F:	include/dt-bindings/mailbox/qcom-ipcc.h
 
+QUALCOMM IPQ4019 ESS DRIVER
+M:	Romain Gantois <romain.gantois@bootlin.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
+F:	drivers/net/ethernet/qualcomm/ipqess/
+
 QUALCOMM IPQ4019 USB PHY DRIVER
 M:	Robert Marko <robert.marko@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 9210ff360fdc..aaae06f93373 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -61,6 +61,20 @@ config QCOM_EMAC
 	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
 	  Precision Clock Synchronization Protocol.
 
+config QCOM_IPQ4019_ESS
+	tristate "Qualcomm Atheros IPQ4019 Ethernet Switch Subsystem support"
+	depends on (OF && ARCH_QCOM) || COMPILE_TEST
+	select PHYLINK
+	select NET_DSA
+	select NET_SWITCHDEV
+	select NET_DSA_QCA8K_LIB
+	help
+	  This driver supports the Qualcomm Atheros IPQ40xx built-in
+	  Ethernet Switch Subsystem.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ipqess.
+
 source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
 
 endif # NET_VENDOR_QUALCOMM
diff --git a/drivers/net/ethernet/qualcomm/Makefile b/drivers/net/ethernet/qualcomm/Makefile
index 9250976dd884..63c62704a62d 100644
--- a/drivers/net/ethernet/qualcomm/Makefile
+++ b/drivers/net/ethernet/qualcomm/Makefile
@@ -12,3 +12,5 @@ qcauart-objs := qca_uart.o
 obj-y += emac/
 
 obj-$(CONFIG_RMNET) += rmnet/
+
+obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess/
diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
new file mode 100644
index 000000000000..51d7163ef0fc
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the IPQ ESS driver
+#
+
+obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
+
+ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_notifiers.o ipqess_edma.o
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
new file mode 100644
index 000000000000..1f4e7b8bfa63
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
@@ -0,0 +1,1162 @@
+// SPDX-License-Identifier: GPL-2.0 OR ISC
+/* Copyright (c) 2014 - 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017 - 2018, John Crispin <john@phrozen.org>
+ * Copyright (c) 2018 - 2019, Christian Lamparter <chunkeey@gmail.com>
+ * Copyright (c) 2020 - 2021, Gabor Juhos <j4g8y7@gmail.com>
+ * Copyright (c) 2021 - 2022, Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/of_net.h>
+#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
+#include <linux/reset.h>
+#include <linux/of_platform.h>
+#include <net/ip6_checksum.h>
+#include <net/dst_metadata.h>
+
+#include "ipqess_edma.h"
+#include "ipqess_port.h"
+#include "ipqess_switch.h"
+#include "ipqess_notifiers.h"
+
+#define IPQESS_EDMA_RRD_SIZE		16
+#define IPQESS_EDMA_NEXT_IDX(X, Y) (((X) + 1) & ((Y) - 1))
+#define IPQESS_EDMA_TX_DMA_BUF_LEN	0x3fff
+
+static void ipqess_edma_w32(struct ipqess_edma *edma, u32 reg, u32 val)
+{
+	writel(val, edma->hw_addr + reg);
+}
+
+static u32 ipqess_edma_r32(struct ipqess_edma *edma, u16 reg)
+{
+	return readl(edma->hw_addr + reg);
+}
+
+static void ipqess_edma_m32(struct ipqess_edma *edma, u32 mask, u32 val,
+			    u16 reg)
+{
+	u32 _val = ipqess_edma_r32(edma, reg);
+
+	_val &= ~mask;
+	_val |= val;
+
+	ipqess_edma_w32(edma, reg, _val);
+}
+
+static int ipqess_edma_tx_ring_alloc(struct ipqess_edma *edma)
+{
+	struct device *dev = &edma->pdev->dev;
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		struct ipqess_edma_tx_ring *tx_ring = &edma->tx_ring[i];
+		size_t size;
+		u32 idx;
+
+		tx_ring->edma = edma;
+		tx_ring->ring_id = i;
+		tx_ring->idx = i * 4;
+		tx_ring->count = IPQESS_EDMA_TX_RING_SIZE;
+		tx_ring->nq = netdev_get_tx_queue(edma->netdev, i);
+
+		size = sizeof(struct ipqess_edma_buf) * IPQESS_EDMA_TX_RING_SIZE;
+		tx_ring->buf = devm_kzalloc(dev, size, GFP_KERNEL);
+		if (!tx_ring->buf)
+			return -ENOMEM;
+
+		size = sizeof(struct ipqess_edma_tx_desc) * IPQESS_EDMA_TX_RING_SIZE;
+		tx_ring->hw_desc = dmam_alloc_coherent(dev, size, &tx_ring->dma,
+						       GFP_KERNEL);
+		if (!tx_ring->hw_desc)
+			return -ENOMEM;
+
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TPD_BASE_ADDR_Q(tx_ring->idx),
+				(u32)tx_ring->dma);
+
+		idx = ipqess_edma_r32(edma, IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx));
+		idx >>= IPQESS_EDMA_TPD_CONS_IDX_SHIFT; /* need u32 here */
+		idx &= 0xffff;
+		tx_ring->head = idx;
+		tx_ring->tail = idx;
+
+		ipqess_edma_m32(edma,
+				IPQESS_EDMA_TPD_PROD_IDX_MASK
+					<< IPQESS_EDMA_TPD_PROD_IDX_SHIFT,
+				idx, IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx));
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_SW_CONS_IDX_Q(tx_ring->idx),
+				idx);
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TPD_RING_SIZE,
+				IPQESS_EDMA_TX_RING_SIZE);
+	}
+
+	return 0;
+}
+
+static int ipqess_edma_tx_unmap_and_free(struct device *dev,
+					 struct ipqess_edma_buf *buf)
+{
+	int len = 0;
+
+	if (buf->flags & IPQESS_EDMA_DESC_SINGLE)
+		dma_unmap_single(dev, buf->dma,	buf->length, DMA_TO_DEVICE);
+	else if (buf->flags & IPQESS_EDMA_DESC_PAGE)
+		dma_unmap_page(dev, buf->dma, buf->length, DMA_TO_DEVICE);
+
+	if (buf->flags & IPQESS_EDMA_DESC_LAST) {
+		len = buf->skb->len;
+		dev_kfree_skb_any(buf->skb);
+	}
+
+	buf->flags = 0;
+
+	return len;
+}
+
+static void ipqess_edma_tx_ring_free(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		int j;
+
+		if (edma->tx_ring[i].hw_desc)
+			continue;
+
+		for (j = 0; j < IPQESS_EDMA_TX_RING_SIZE; j++) {
+			struct ipqess_edma_buf *buf = &edma->tx_ring[i].buf[j];
+
+			ipqess_edma_tx_unmap_and_free(&edma->pdev->dev, buf);
+		}
+
+		edma->tx_ring[i].buf = NULL;
+	}
+}
+
+static int ipqess_edma_rx_buf_prepare(struct ipqess_edma_buf *buf,
+				      struct ipqess_edma_rx_ring *rx_ring)
+{
+	memset(buf->skb->data, 0, sizeof(struct ipqess_edma_rx_desc));
+
+	buf->dma = dma_map_single(rx_ring->ppdev, buf->skb->data,
+				  IPQESS_EDMA_RX_HEAD_BUFF_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(rx_ring->ppdev, buf->dma)) {
+		dev_kfree_skb_any(buf->skb);
+		buf->skb = NULL;
+		return -EFAULT;
+	}
+
+	buf->length = IPQESS_EDMA_RX_HEAD_BUFF_SIZE;
+	rx_ring->hw_desc[rx_ring->head] =
+			(struct ipqess_edma_rx_desc *)buf->dma;
+	rx_ring->head = (rx_ring->head + 1) % IPQESS_EDMA_RX_RING_SIZE;
+
+	ipqess_edma_m32(rx_ring->edma, IPQESS_EDMA_RFD_PROD_IDX_BITS,
+			(rx_ring->head + IPQESS_EDMA_RX_RING_SIZE - 1)
+			% IPQESS_EDMA_RX_RING_SIZE,
+			IPQESS_EDMA_REG_RFD_IDX_Q(rx_ring->idx));
+
+	return 0;
+}
+
+/* locking is handled by the caller */
+static int ipqess_edma_rx_buf_alloc_napi(struct ipqess_edma_rx_ring *rx_ring)
+{
+	struct ipqess_edma_buf *buf = &rx_ring->buf[rx_ring->head];
+
+	buf->skb = napi_alloc_skb(&rx_ring->napi_rx,
+				  IPQESS_EDMA_RX_HEAD_BUFF_SIZE);
+	if (!buf->skb)
+		return -ENOMEM;
+
+	return ipqess_edma_rx_buf_prepare(buf, rx_ring);
+}
+
+static int ipqess_edma_rx_buf_alloc(struct ipqess_edma_rx_ring *rx_ring)
+{
+	struct ipqess_edma_buf *buf = &rx_ring->buf[rx_ring->head];
+
+	buf->skb = netdev_alloc_skb_ip_align(rx_ring->edma->netdev,
+					     IPQESS_EDMA_RX_HEAD_BUFF_SIZE);
+
+	if (!buf->skb)
+		return -ENOMEM;
+
+	return ipqess_edma_rx_buf_prepare(buf, rx_ring);
+}
+
+static void ipqess_edma_refill_work(struct work_struct *work)
+{
+	struct ipqess_edma_rx_ring_refill *rx_refill =
+			container_of(work, struct ipqess_edma_rx_ring_refill,
+				     refill_work);
+	struct ipqess_edma_rx_ring *rx_ring = rx_refill->rx_ring;
+	int refill = 0;
+
+	/* don't let this loop by accident. */
+	while (atomic_dec_and_test(&rx_ring->refill_count)) {
+		napi_disable(&rx_ring->napi_rx);
+		if (ipqess_edma_rx_buf_alloc(rx_ring)) {
+			refill++;
+			dev_dbg(rx_ring->ppdev,
+				"Not all buffers were reallocated");
+		}
+		napi_enable(&rx_ring->napi_rx);
+	}
+
+	if (atomic_add_return(refill, &rx_ring->refill_count))
+		schedule_work(&rx_refill->refill_work);
+}
+
+static int ipqess_edma_rx_ring_alloc(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		int j;
+
+		edma->rx_ring[i].edma = edma;
+		edma->rx_ring[i].ppdev = &edma->pdev->dev;
+		edma->rx_ring[i].ring_id = i;
+		edma->rx_ring[i].idx = i * 2;
+
+		edma->rx_ring[i].buf =
+			devm_kzalloc(&edma->pdev->dev,
+				     sizeof(struct ipqess_edma_buf)
+				     * IPQESS_EDMA_RX_RING_SIZE,
+				     GFP_KERNEL);
+
+		if (!edma->rx_ring[i].buf)
+			return -ENOMEM;
+
+		edma->rx_ring[i].hw_desc =
+			dmam_alloc_coherent(&edma->pdev->dev,
+					    sizeof(struct ipqess_edma_rx_desc)
+					    * IPQESS_EDMA_RX_RING_SIZE,
+					    &edma->rx_ring[i].dma, GFP_KERNEL);
+
+		if (!edma->rx_ring[i].hw_desc)
+			return -ENOMEM;
+
+		for (j = 0; j < IPQESS_EDMA_RX_RING_SIZE; j++)
+			if (ipqess_edma_rx_buf_alloc(&edma->rx_ring[i]) < 0)
+				return -ENOMEM;
+
+		edma->rx_refill[i].rx_ring = &edma->rx_ring[i];
+		INIT_WORK(&edma->rx_refill[i].refill_work,
+			  ipqess_edma_refill_work);
+
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RFD_BASE_ADDR_Q(edma->rx_ring[i].idx),
+				(u32)(edma->rx_ring[i].dma));
+	}
+
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_DESC0,
+			(IPQESS_EDMA_RX_HEAD_BUFF_SIZE << IPQESS_EDMA_RX_BUF_SIZE_SHIFT) |
+			(IPQESS_EDMA_RX_RING_SIZE << IPQESS_EDMA_RFD_RING_SIZE_SHIFT));
+
+	return 0;
+}
+
+static void ipqess_edma_rx_ring_free(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		int j;
+
+		cancel_work_sync(&edma->rx_refill[i].refill_work);
+		atomic_set(&edma->rx_ring[i].refill_count, 0);
+
+		for (j = 0; j < IPQESS_EDMA_RX_RING_SIZE; j++) {
+			dma_unmap_single(&edma->pdev->dev,
+					 edma->rx_ring[i].buf[j].dma,
+					 edma->rx_ring[i].buf[j].length,
+					 DMA_FROM_DEVICE);
+			dev_kfree_skb_any(edma->rx_ring[i].buf[j].skb);
+		}
+	}
+}
+
+static int ipqess_edma_redirect(struct ipqess_edma_rx_ring *rx_ring,
+				struct sk_buff *skb, int port_id)
+{
+	struct ipqess_port *port;
+
+	if (port_id == 0) {
+		/* The switch probably redirected an unknown frame to the CPU port
+		 * (IGMP,BC,unknown MC, unknown UC)
+		 */
+		return -EINVAL;
+	}
+
+	if (port_id < 0 || port_id > QCA8K_NUM_PORTS) {
+		dev_warn(rx_ring->edma->sw->priv->dev,
+			 "received packet tagged with out-of-bounds port id %d\n",
+			 port_id);
+		return -EINVAL;
+	}
+
+	port = rx_ring->edma->sw->port_list[port_id - 1];
+	if (!port) {
+		/* drop packets tagged from unregistered ports */
+		return -EINVAL;
+	}
+
+	skb->dev = port->netdev;
+	skb_push(skb, ETH_HLEN);
+	skb->pkt_type = PACKET_HOST;
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	dev_sw_netstats_rx_add(skb->dev, skb->len + ETH_HLEN);
+
+	napi_gro_receive(&rx_ring->napi_rx, skb);
+
+	return 0;
+}
+
+static int ipqess_edma_refill_rx_ring(struct ipqess_edma_rx_ring *rx_ring,
+				      u32 num_desc)
+{
+	struct work_struct *refill_work = &rx_ring->edma->rx_refill[rx_ring->ring_id].refill_work;
+
+	num_desc += atomic_xchg(&rx_ring->refill_count, 0);
+	while (num_desc) {
+		if (ipqess_edma_rx_buf_alloc_napi(rx_ring)) {
+			num_desc = atomic_add_return(num_desc,
+						     &rx_ring->refill_count);
+			if (num_desc >= DIV_ROUND_UP(IPQESS_EDMA_RX_RING_SIZE * 4, 7))
+				schedule_work(refill_work);
+
+			break;
+		}
+		num_desc--;
+	}
+
+	return num_desc;
+}
+
+static int ipqess_edma_rx_poll(struct ipqess_edma_rx_ring *rx_ring, int budget)
+{
+	u32 length = 0, num_desc, tail, rx_ring_tail;
+	int done = 0;
+	int port_id;
+
+	rx_ring_tail = rx_ring->tail;
+
+	tail = ipqess_edma_r32(rx_ring->edma,
+			       IPQESS_EDMA_REG_RFD_IDX_Q(rx_ring->idx));
+	tail >>= IPQESS_EDMA_RFD_CONS_IDX_SHIFT;
+	tail &= IPQESS_EDMA_RFD_CONS_IDX_MASK;
+
+	while (done < budget) {
+		struct ipqess_edma_rx_desc *rd;
+		struct sk_buff *skb;
+
+		if (rx_ring_tail == tail)
+			break;
+
+		dma_unmap_single(rx_ring->ppdev,
+				 rx_ring->buf[rx_ring_tail].dma,
+				 rx_ring->buf[rx_ring_tail].length,
+				 DMA_FROM_DEVICE);
+
+		skb = xchg(&rx_ring->buf[rx_ring_tail].skb, NULL);
+		rd = (struct ipqess_edma_rx_desc *)skb->data;
+		rx_ring_tail = IPQESS_EDMA_NEXT_IDX(rx_ring_tail,
+						    IPQESS_EDMA_RX_RING_SIZE);
+
+		/* Check if RRD is valid */
+		if (!(rd->rrd7 & cpu_to_le16(IPQESS_EDMA_RRD_DESC_VALID))) {
+			num_desc = 1;
+			dev_kfree_skb_any(skb);
+			goto skip;
+		}
+
+		num_desc = le16_to_cpu(rd->rrd1) & IPQESS_EDMA_RRD_NUM_RFD_MASK;
+		length = le16_to_cpu(rd->rrd6) & IPQESS_EDMA_RRD_PKT_SIZE_MASK;
+
+		skb_reserve(skb, IPQESS_EDMA_RRD_SIZE);
+		if (num_desc > 1) {
+			struct sk_buff *skb_prev = NULL;
+			int size_remaining;
+			int i;
+
+			skb->data_len = 0;
+			skb->tail += (IPQESS_EDMA_RX_HEAD_BUFF_SIZE
+					- IPQESS_EDMA_RRD_SIZE);
+			skb->len = length;
+			skb->truesize = length;
+			size_remaining =
+				length - (IPQESS_EDMA_RX_HEAD_BUFF_SIZE
+						- IPQESS_EDMA_RRD_SIZE);
+
+			for (i = 1; i < num_desc; i++) {
+				struct sk_buff *skb_temp =
+					rx_ring->buf[rx_ring_tail].skb;
+
+				dma_unmap_single(rx_ring->ppdev,
+						 rx_ring->buf[rx_ring_tail].dma,
+						 rx_ring->buf[rx_ring_tail].length,
+						 DMA_FROM_DEVICE);
+
+				skb_put(skb_temp,
+					min(size_remaining, IPQESS_EDMA_RX_HEAD_BUFF_SIZE));
+				if (skb_prev)
+					skb_prev->next =
+						rx_ring->buf[rx_ring_tail].skb;
+				else
+					skb_shinfo(skb)->frag_list =
+						rx_ring->buf[rx_ring_tail].skb;
+				skb_prev = rx_ring->buf[rx_ring_tail].skb;
+				rx_ring->buf[rx_ring_tail].skb->next = NULL;
+
+				skb->data_len += rx_ring->buf[rx_ring_tail].skb->len;
+				size_remaining -= rx_ring->buf[rx_ring_tail].skb->len;
+
+				rx_ring_tail =
+					IPQESS_EDMA_NEXT_IDX(rx_ring_tail,
+							     IPQESS_EDMA_RX_RING_SIZE);
+			}
+
+		} else {
+			skb_put(skb, length);
+		}
+
+		skb->dev = rx_ring->edma->netdev;
+		skb->protocol = eth_type_trans(skb, rx_ring->edma->netdev);
+		skb_record_rx_queue(skb, rx_ring->ring_id);
+
+		if (rd->rrd6 & cpu_to_le16(IPQESS_EDMA_RRD_CSUM_FAIL_MASK))
+			skb_checksum_none_assert(skb);
+		else
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (rd->rrd7 & cpu_to_le16(IPQESS_EDMA_RRD_CVLAN))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       le16_to_cpu(rd->rrd4));
+		else if (rd->rrd1 & cpu_to_le16(IPQESS_EDMA_RRD_SVLAN))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD),
+					       le16_to_cpu(rd->rrd4));
+
+		port_id = FIELD_GET(IPQESS_EDMA_RRD_PORT_ID_MASK,
+				    le16_to_cpu(rd->rrd1));
+
+		if (ipqess_edma_redirect(rx_ring, skb, port_id)) {
+			dev_kfree_skb_any(skb);
+			goto skip;
+		}
+
+		rx_ring->edma->stats.rx_packets++;
+		rx_ring->edma->stats.rx_bytes += length;
+
+		done++;
+skip:
+		num_desc = ipqess_edma_refill_rx_ring(rx_ring, num_desc);
+	}
+
+	ipqess_edma_w32(rx_ring->edma,
+			IPQESS_EDMA_REG_RX_SW_CONS_IDX_Q(rx_ring->idx),
+			rx_ring_tail);
+	rx_ring->tail = rx_ring_tail;
+
+	return done;
+}
+
+static int ipqess_edma_tx_complete(struct ipqess_edma_tx_ring *tx_ring,
+				   int budget)
+{
+	int total = 0, ret;
+	int done = 0;
+	u32 tail;
+
+	tail = ipqess_edma_r32(tx_ring->edma,
+			       IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx));
+	tail >>= IPQESS_EDMA_TPD_CONS_IDX_SHIFT;
+	tail &= IPQESS_EDMA_TPD_CONS_IDX_MASK;
+
+	do {
+		ret = ipqess_edma_tx_unmap_and_free(&tx_ring->edma->pdev->dev,
+						    &tx_ring->buf[tx_ring->tail]);
+		tx_ring->tail = IPQESS_EDMA_NEXT_IDX(tx_ring->tail, tx_ring->count);
+
+		total += ret;
+	} while ((++done < budget) && (tx_ring->tail != tail));
+
+	ipqess_edma_w32(tx_ring->edma,
+			IPQESS_EDMA_REG_TX_SW_CONS_IDX_Q(tx_ring->idx),
+			tx_ring->tail);
+
+	if (netif_tx_queue_stopped(tx_ring->nq)) {
+		netdev_dbg(tx_ring->edma->netdev, "waking up tx queue %d\n",
+			   tx_ring->idx);
+		netif_tx_wake_queue(tx_ring->nq);
+	}
+
+	netdev_tx_completed_queue(tx_ring->nq, done, total);
+
+	return done;
+}
+
+static int ipqess_edma_tx_napi(struct napi_struct *napi, int budget)
+{
+	struct ipqess_edma_tx_ring *tx_ring =
+		container_of(napi, struct ipqess_edma_tx_ring, napi_tx);
+	int work_done = 0;
+	u32 tx_status;
+
+	tx_status = ipqess_edma_r32(tx_ring->edma, IPQESS_EDMA_REG_TX_ISR);
+	tx_status &= BIT(tx_ring->idx);
+
+	work_done = ipqess_edma_tx_complete(tx_ring, budget);
+
+	ipqess_edma_w32(tx_ring->edma, IPQESS_EDMA_REG_TX_ISR, tx_status);
+
+	if (likely(work_done < budget)) {
+		if (napi_complete_done(napi, work_done))
+			ipqess_edma_w32(tx_ring->edma,
+					IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx),
+					0x1);
+	}
+
+	return work_done;
+}
+
+static int ipqess_edma_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct ipqess_edma_rx_ring *rx_ring =
+		container_of(napi, struct ipqess_edma_rx_ring, napi_rx);
+	struct ipqess_edma *edma = rx_ring->edma;
+	u32 rx_mask = BIT(rx_ring->idx);
+	int remaining_budget = budget;
+	int rx_done;
+	u32 status;
+
+	do {
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_ISR, rx_mask);
+		rx_done = ipqess_edma_rx_poll(rx_ring, remaining_budget);
+		remaining_budget -= rx_done;
+
+		status = ipqess_edma_r32(edma, IPQESS_EDMA_REG_RX_ISR);
+	} while (remaining_budget > 0 && (status & rx_mask));
+
+	if (remaining_budget <= 0)
+		return budget;
+
+	if (napi_complete_done(napi, budget - remaining_budget))
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(rx_ring->idx),
+				0x1);
+
+	return budget - remaining_budget;
+}
+
+static irqreturn_t ipqess_edma_interrupt_tx(int irq, void *priv)
+{
+	struct ipqess_edma_tx_ring *tx_ring =
+		(struct ipqess_edma_tx_ring *)priv;
+
+	if (likely(napi_schedule_prep(&tx_ring->napi_tx))) {
+		__napi_schedule(&tx_ring->napi_tx);
+		ipqess_edma_w32(tx_ring->edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx),
+				0x0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ipqess_edma_interrupt_rx(int irq, void *priv)
+{
+	struct ipqess_edma_rx_ring *rx_ring = (struct ipqess_edma_rx_ring *)priv;
+
+	if (likely(napi_schedule_prep(&rx_ring->napi_rx))) {
+		__napi_schedule(&rx_ring->napi_rx);
+		ipqess_edma_w32(rx_ring->edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(rx_ring->idx),
+				0x0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void ipqess_edma_irq_enable(struct ipqess_edma *edma)
+{
+	int i;
+
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_ISR, 0xff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_ISR, 0xffff);
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(edma->rx_ring[i].idx),
+				1);
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(edma->tx_ring[i].idx),
+				1);
+	}
+}
+
+static void ipqess_edma_irq_disable(struct ipqess_edma *edma)
+{
+	int i;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_RX_INT_MASK_Q(edma->rx_ring[i].idx),
+				0);
+		ipqess_edma_w32(edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(edma->tx_ring[i].idx),
+				0);
+	}
+}
+
+static u16 ipqess_edma_tx_desc_available(struct ipqess_edma_tx_ring *tx_ring)
+{
+	u16 count = 0;
+
+	if (tx_ring->tail <= tx_ring->head)
+		count = IPQESS_EDMA_TX_RING_SIZE;
+
+	count += tx_ring->tail - tx_ring->head - 1;
+
+	return count;
+}
+
+static int ipqess_edma_cal_txd_req(struct sk_buff *skb)
+{
+	int tpds;
+
+	/* one TPD for the header, and one for each fragments */
+	tpds = 1 + skb_shinfo(skb)->nr_frags;
+	if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
+		/* for LSOv2 one extra TPD is needed */
+		tpds++;
+	}
+
+	return tpds;
+}
+
+static struct ipqess_edma_buf *ipqess_edma_get_tx_buffer(struct ipqess_edma_tx_ring *tx_ring,
+							 struct ipqess_edma_tx_desc *desc)
+{
+	return &tx_ring->buf[desc - tx_ring->hw_desc];
+}
+
+static struct ipqess_edma_tx_desc *ipqess_edma_tx_desc_next(struct ipqess_edma_tx_ring *tx_ring)
+{
+	struct ipqess_edma_tx_desc *desc;
+
+	desc = &tx_ring->hw_desc[tx_ring->head];
+	tx_ring->head = IPQESS_EDMA_NEXT_IDX(tx_ring->head, tx_ring->count);
+
+	return desc;
+}
+
+static void ipqess_edma_rollback_tx(struct ipqess_edma *eth,
+				    struct ipqess_edma_tx_desc *first_desc,
+				    int ring_id)
+{
+	struct ipqess_edma_tx_ring *tx_ring = &eth->tx_ring[ring_id];
+	struct ipqess_edma_tx_desc *desc = NULL;
+	struct ipqess_edma_buf *buf;
+	u16 start_index, index;
+
+	start_index = first_desc - tx_ring->hw_desc;
+
+	index = start_index;
+	while (index != tx_ring->head) {
+		desc = &tx_ring->hw_desc[index];
+		buf = &tx_ring->buf[index];
+		ipqess_edma_tx_unmap_and_free(&eth->pdev->dev, buf);
+		memset(desc, 0, sizeof(*desc));
+		if (++index == tx_ring->count)
+			index = 0;
+	}
+	tx_ring->head = start_index;
+}
+
+static int ipqess_edma_tx_map_and_fill(struct ipqess_edma_tx_ring *tx_ring,
+				       struct sk_buff *skb, int port_id)
+{
+	struct ipqess_edma_tx_desc *desc = NULL, *first_desc = NULL;
+	u32 word1 = 0, word3 = 0, lso_word1 = 0, svlan_tag = 0;
+	struct platform_device *pdev = tx_ring->edma->pdev;
+	struct ipqess_edma_buf *buf = NULL;
+	u16 len;
+	int i;
+
+	word3 |= port_id << IPQESS_EDMA_TPD_PORT_BITMAP_SHIFT;
+	word3 |= BIT(IPQESS_EDMA_TPD_FROM_CPU_SHIFT);
+	word3 |= 0x3e << IPQESS_EDMA_TPD_PORT_BITMAP_SHIFT;
+
+	if (skb_is_gso(skb)) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
+			lso_word1 |= IPQESS_EDMA_TPD_IPV4_EN;
+			ip_hdr(skb)->check = 0;
+			tcp_hdr(skb)->check = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
+								 ip_hdr(skb)->daddr,
+								 0, IPPROTO_TCP, 0);
+		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6) {
+			lso_word1 |= IPQESS_EDMA_TPD_LSO_V2_EN;
+			ipv6_hdr(skb)->payload_len = 0;
+			tcp_hdr(skb)->check = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
+							       &ipv6_hdr(skb)->daddr,
+							       0, IPPROTO_TCP, 0);
+		}
+
+		lso_word1 |= IPQESS_EDMA_TPD_LSO_EN |
+					((skb_shinfo(skb)->gso_size & IPQESS_EDMA_TPD_MSS_MASK) <<
+						IPQESS_EDMA_TPD_MSS_SHIFT) |
+					(skb_transport_offset(skb) << IPQESS_EDMA_TPD_HDR_SHIFT);
+	} else if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		u8 css, cso;
+
+		cso = skb_checksum_start_offset(skb);
+		css = cso + skb->csum_offset;
+
+		word1 |= (IPQESS_EDMA_TPD_CUSTOM_CSUM_EN);
+		word1 |= (cso >> 1) << IPQESS_EDMA_TPD_HDR_SHIFT;
+		word1 |= ((css >> 1) << IPQESS_EDMA_TPD_CUSTOM_CSUM_SHIFT);
+	}
+
+	if (skb_vlan_tag_present(skb)) {
+		switch (skb->vlan_proto) {
+		case htons(ETH_P_8021Q):
+			word3 |= BIT(IPQESS_EDMA_TX_INS_CVLAN);
+			word3 |= skb_vlan_tag_get(skb) << IPQESS_EDMA_TX_CVLAN_TAG_SHIFT;
+			break;
+		case htons(ETH_P_8021AD):
+			word1 |= BIT(IPQESS_EDMA_TX_INS_SVLAN);
+			svlan_tag = skb_vlan_tag_get(skb);
+			break;
+		default:
+			dev_err(&pdev->dev, "no ctag or stag present\n");
+			goto vlan_tag_error;
+		}
+	}
+
+	if (eth_type_vlan(skb->protocol))
+		word1 |= IPQESS_EDMA_TPD_VLAN_TAGGED;
+
+	if (skb->protocol == htons(ETH_P_PPP_SES))
+		word1 |= IPQESS_EDMA_TPD_PPPOE_EN;
+
+	len = skb_headlen(skb);
+
+	first_desc = ipqess_edma_tx_desc_next(tx_ring);
+	desc = first_desc;
+	if (lso_word1 & IPQESS_EDMA_TPD_LSO_V2_EN) {
+		desc->addr = cpu_to_le32(skb->len);
+		desc->word1 = cpu_to_le32(word1 | lso_word1);
+		desc->svlan_tag = cpu_to_le16(svlan_tag);
+		desc->word3 = cpu_to_le32(word3);
+		desc = ipqess_edma_tx_desc_next(tx_ring);
+	}
+
+	buf = ipqess_edma_get_tx_buffer(tx_ring, desc);
+	buf->length = len;
+	buf->dma = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
+
+	if (dma_mapping_error(&pdev->dev, buf->dma))
+		goto dma_error;
+
+	desc->addr = cpu_to_le32(buf->dma);
+	desc->len = cpu_to_le16(len);
+
+	buf->flags |= IPQESS_EDMA_DESC_SINGLE;
+	desc->word1 = cpu_to_le32(word1 | lso_word1);
+	desc->svlan_tag = cpu_to_le16(svlan_tag);
+	desc->word3 = cpu_to_le32(word3);
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		len = skb_frag_size(frag);
+		desc = ipqess_edma_tx_desc_next(tx_ring);
+		buf = ipqess_edma_get_tx_buffer(tx_ring, desc);
+		buf->length = len;
+		buf->flags |= IPQESS_EDMA_DESC_PAGE;
+		buf->dma = skb_frag_dma_map(&pdev->dev, frag, 0, len,
+					    DMA_TO_DEVICE);
+
+		if (dma_mapping_error(&pdev->dev, buf->dma))
+			goto dma_error;
+
+		desc->addr = cpu_to_le32(buf->dma);
+		desc->len = cpu_to_le16(len);
+		desc->svlan_tag = cpu_to_le16(svlan_tag);
+		desc->word1 = cpu_to_le32(word1 | lso_word1);
+		desc->word3 = cpu_to_le32(word3);
+	}
+	desc->word1 |= cpu_to_le32(1 << IPQESS_EDMA_TPD_EOP_SHIFT);
+	buf->skb = skb;
+	buf->flags |= IPQESS_EDMA_DESC_LAST;
+
+	return 0;
+
+dma_error:
+	ipqess_edma_rollback_tx(tx_ring->edma, first_desc, tx_ring->ring_id);
+	dev_err(&pdev->dev, "TX DMA map failed\n");
+
+vlan_tag_error:
+	return -ENOMEM;
+}
+
+static void ipqess_edma_kick_tx(struct ipqess_edma_tx_ring *tx_ring)
+{
+	/* Ensure that all TPDs has been written completely */
+	dma_wmb();
+
+	/* update software producer index */
+	ipqess_edma_w32(tx_ring->edma, IPQESS_EDMA_REG_TPD_IDX_Q(tx_ring->idx),
+			tx_ring->head);
+}
+
+netdev_tx_t ipqess_edma_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct ipqess_edma *edma = port->edma;
+	struct ipqess_edma_tx_ring *tx_ring;
+	int port_id = port->index;
+	int tx_num;
+	int avail;
+	int ret;
+
+	tx_ring = &edma->tx_ring[skb_get_queue_mapping(skb)];
+	tx_num = ipqess_edma_cal_txd_req(skb);
+	avail = ipqess_edma_tx_desc_available(tx_ring);
+	if (avail < tx_num) {
+		netdev_dbg(netdev,
+			   "stopping tx queue %d, avail=%d req=%d im=%x\n",
+			   tx_ring->idx, avail, tx_num,
+			   ipqess_edma_r32(edma, IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx)));
+		netif_tx_stop_queue(tx_ring->nq);
+		ipqess_edma_w32(tx_ring->edma,
+				IPQESS_EDMA_REG_TX_INT_MASK_Q(tx_ring->idx),
+				0x1);
+		ipqess_edma_kick_tx(tx_ring);
+		return NETDEV_TX_BUSY;
+	}
+
+	ret = ipqess_edma_tx_map_and_fill(tx_ring, skb, port_id);
+	if (ret) {
+		dev_kfree_skb_any(skb);
+		edma->stats.tx_errors++;
+		return ret;
+	}
+
+	edma->stats.tx_packets++;
+	edma->stats.tx_bytes += skb->len;
+	netdev_tx_sent_queue(tx_ring->nq, skb->len);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(tx_ring->nq))
+		ipqess_edma_kick_tx(tx_ring);
+
+	return NETDEV_TX_OK;
+}
+EXPORT_SYMBOL(ipqess_edma_xmit);
+
+static void ipqess_edma_hw_stop(struct ipqess_edma *edma)
+{
+	int i;
+
+	/* disable all RX queue IRQs */
+	for (i = 0; i < IPQESS_EDMA_MAX_RX_QUEUE; i++)
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_INT_MASK_Q(i), 0);
+
+	/* disable all TX queue IRQs */
+	for (i = 0; i < IPQESS_EDMA_MAX_TX_QUEUE; i++)
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_INT_MASK_Q(i), 0);
+
+	/* disable all other IRQs */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_MISC_IMR, 0);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_WOL_IMR, 0);
+
+	/* clear the IRQ status registers */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_ISR, 0xff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TX_ISR, 0xffff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_MISC_ISR, 0x1fff);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_WOL_ISR, 0x1);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_WOL_CTRL, 0);
+
+	/* disable RX and TX queues */
+	ipqess_edma_m32(edma, IPQESS_EDMA_RXQ_CTRL_EN_MASK, 0,
+			IPQESS_EDMA_REG_RXQ_CTRL);
+	ipqess_edma_m32(edma, IPQESS_EDMA_TXQ_CTRL_TXQ_EN, 0,
+			IPQESS_EDMA_REG_TXQ_CTRL);
+}
+
+static int ipqess_edma_hw_init(struct ipqess_edma *edma)
+{
+	int i, err;
+	u32 tmp;
+
+	ipqess_edma_hw_stop(edma);
+
+	ipqess_edma_m32(edma, BIT(IPQESS_EDMA_INTR_SW_IDX_W_TYP_SHIFT),
+			IPQESS_EDMA_INTR_SW_IDX_W_TYPE
+				<< IPQESS_EDMA_INTR_SW_IDX_W_TYP_SHIFT,
+			IPQESS_EDMA_REG_INTR_CTRL);
+
+	/* enable IRQ delay slot */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_IRQ_MODRT_TIMER_INIT,
+			(IPQESS_EDMA_TX_IMT
+				<< IPQESS_EDMA_IRQ_MODRT_TX_TIMER_SHIFT) |
+			(IPQESS_EDMA_RX_IMT
+				<< IPQESS_EDMA_IRQ_MODRT_RX_TIMER_SHIFT));
+
+	/* Set Customer and Service VLAN TPIDs */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_VLAN_CFG,
+			(ETH_P_8021Q << IPQESS_EDMA_VLAN_CFG_CVLAN_TPID_SHIFT)
+			| (ETH_P_8021AD << IPQESS_EDMA_VLAN_CFG_SVLAN_TPID_SHIFT));
+
+	/* Configure the TX Queue bursting */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TXQ_CTRL,
+			(IPQESS_EDMA_TPD_BURST << IPQESS_EDMA_TXQ_NUM_TPD_BURST_SHIFT)
+			| (IPQESS_EDMA_TXF_BURST << IPQESS_EDMA_TXQ_TXF_BURST_NUM_SHIFT)
+			| IPQESS_EDMA_TXQ_CTRL_TPD_BURST_EN);
+
+	/* Set RSS type */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RSS_TYPE,
+			IPQESS_EDMA_RSS_TYPE_IPV4TCP
+			| IPQESS_EDMA_RSS_TYPE_IPV6_TCP
+			| IPQESS_EDMA_RSS_TYPE_IPV4_UDP
+			| IPQESS_EDMA_RSS_TYPE_IPV6UDP
+			| IPQESS_EDMA_RSS_TYPE_IPV4
+			| IPQESS_EDMA_RSS_TYPE_IPV6);
+
+	/* Set RFD ring burst and threshold */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RX_DESC1,
+			(IPQESS_EDMA_RFD_BURST << IPQESS_EDMA_RXQ_RFD_BURST_NUM_SHIFT)
+			| (IPQESS_EDMA_RFD_THR << IPQESS_EDMA_RXQ_RFD_PF_THRESH_SHIFT)
+			| (IPQESS_EDMA_RFD_LTHR << IPQESS_EDMA_RXQ_RFD_LOW_THRESH_SHIFT));
+
+	/* Set Rx FIFO
+	 * - threshold to start to DMA data to host
+	 */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_RXQ_CTRL,
+			IPQESS_EDMA_FIFO_THRESH_128_BYTE
+			| IPQESS_EDMA_RXQ_CTRL_RMV_VLAN);
+
+	err = ipqess_edma_rx_ring_alloc(edma);
+	if (err)
+		return err;
+
+	err = ipqess_edma_tx_ring_alloc(edma);
+	if (err)
+		goto err_rx_ring_free;
+
+	/* Load all of ring base address above into the dma engine */
+	ipqess_edma_m32(edma, 0, BIT(IPQESS_EDMA_LOAD_PTR_SHIFT),
+			IPQESS_EDMA_REG_TX_SRAM_PART);
+
+	/* Disable TX FIFO low watermark and high watermark */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_TXF_WATER_MARK, 0);
+
+	/* Configure RSS indirection table.
+	 * 128 hash will be configured in the following
+	 * pattern: hash{0,1,2,3} = {Q0,Q2,Q4,Q6} respectively
+	 * and so on
+	 */
+	for (i = 0; i < IPQESS_EDMA_NUM_IDT; i++)
+		ipqess_edma_w32(edma, IPQESS_EDMA_REG_RSS_IDT(i),
+				IPQESS_EDMA_RSS_IDT_VALUE);
+
+	/* Configure load balance mapping table.
+	 * 4 table entry will be configured according to the
+	 * following pattern: load_balance{0,1,2,3} = {Q0,Q1,Q3,Q4}
+	 * respectively.
+	 */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_LB_RING, IPQESS_EDMA_LB_REG_VALUE);
+
+	/* Configure Virtual queue for Tx rings */
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_VQ_CTRL0, IPQESS_EDMA_VQ_REG_VALUE);
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_VQ_CTRL1, IPQESS_EDMA_VQ_REG_VALUE);
+
+	/* Configure Max AXI Burst write size to 128 bytes*/
+	ipqess_edma_w32(edma, IPQESS_EDMA_REG_AXIW_CTRL_MAXWRSIZE,
+			IPQESS_EDMA_AXIW_MAXWRSIZE_VALUE);
+
+	/* Enable TX queues */
+	ipqess_edma_m32(edma, 0, IPQESS_EDMA_TXQ_CTRL_TXQ_EN,
+			IPQESS_EDMA_REG_TXQ_CTRL);
+
+	/* Enable RX queues */
+	tmp = 0;
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++)
+		tmp |= IPQESS_EDMA_RXQ_CTRL_EN(edma->rx_ring[i].idx);
+
+	ipqess_edma_m32(edma, IPQESS_EDMA_RXQ_CTRL_EN_MASK, tmp,
+			IPQESS_EDMA_REG_RXQ_CTRL);
+
+	return 0;
+
+err_rx_ring_free:
+
+	ipqess_edma_rx_ring_free(edma);
+	return err;
+}
+
+static void ipqess_edma_reset(struct ipqess_edma *edma)
+{
+	reset_control_assert(edma->edma_rst);
+
+	mdelay(10);
+
+	reset_control_deassert(edma->edma_rst);
+
+	/* Waiting for all inner tables to be flushed and reinitialized.
+	 * This takes between 5 and 10 ms
+	 */
+
+	mdelay(10);
+}
+
+int ipqess_edma_init(struct platform_device *pdev, struct device_node *np)
+{
+	struct ipqess_switch *sw = platform_get_drvdata(pdev);
+	struct net_device *netdev;
+	struct ipqess_edma *edma;
+	struct ipqess_port *port;
+	int i, err = 0;
+	int qid;
+
+	edma = devm_kzalloc(&pdev->dev, sizeof(*edma), GFP_KERNEL);
+	if (!edma)
+		return -ENOMEM;
+
+	edma->pdev = pdev;
+
+	spin_lock_init(&edma->stats_lock);
+
+	edma->hw_addr = devm_platform_ioremap_resource_byname(pdev, "edma");
+	if (IS_ERR(edma->hw_addr)) {
+		err = PTR_ERR(edma->hw_addr);
+		goto err_edma;
+	}
+
+	edma->edma_clk = devm_clk_get(&pdev->dev, "ess");
+	if (IS_ERR(edma->edma_clk)) {
+		err = PTR_ERR(edma->edma_clk);
+		goto err_edma;
+	}
+
+	err = clk_prepare_enable(edma->edma_clk);
+	if (err)
+		goto err_edma;
+
+	edma->edma_rst = devm_reset_control_get(&pdev->dev, "ess");
+	if (IS_ERR(edma->edma_rst)) {
+		err = PTR_ERR(edma->edma_rst);
+		goto err_clk;
+	}
+
+	ipqess_edma_reset(edma);
+
+	for (i = 0; i < IPQESS_EDMA_MAX_TX_QUEUE; i++) {
+		edma->tx_irq[i] = platform_get_irq(pdev, i);
+		scnprintf(edma->tx_irq_names[i], sizeof(edma->tx_irq_names[i]),
+			  "%s:txq%d", pdev->name, i);
+	}
+
+	for (i = 0; i < IPQESS_EDMA_MAX_RX_QUEUE; i++) {
+		edma->rx_irq[i] = platform_get_irq(pdev,
+						   i + IPQESS_EDMA_MAX_TX_QUEUE);
+		scnprintf(edma->rx_irq_names[i], sizeof(edma->rx_irq_names[i]),
+			  "%s:rxq%d", pdev->name, i);
+	}
+
+	netdev = sw->napi_leader;
+	sw->edma = edma;
+	edma->sw = sw;
+	edma->netdev = netdev;
+
+	err = ipqess_edma_hw_init(edma);
+	if (err)
+		goto err_clk;
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		netif_napi_add_tx(netdev, &edma->tx_ring[i].napi_tx,
+				  ipqess_edma_tx_napi);
+		netif_napi_add(netdev, &edma->rx_ring[i].napi_rx,
+			       ipqess_edma_rx_napi);
+	}
+
+	for (i = 0; i < IPQESS_EDMA_NETDEV_QUEUES; i++) {
+		qid = edma->tx_ring[i].idx;
+		err = devm_request_irq(&netdev->dev, edma->tx_irq[qid],
+				       ipqess_edma_interrupt_tx, 0,
+				       edma->tx_irq_names[qid],
+				       &edma->tx_ring[i]);
+		if (err)
+			goto err_clk;
+
+		qid = edma->rx_ring[i].idx;
+		err = devm_request_irq(&netdev->dev, edma->rx_irq[qid],
+				       ipqess_edma_interrupt_rx, 0,
+				       edma->rx_irq_names[qid],
+				       &edma->rx_ring[i]);
+		if (err)
+			goto err_clk;
+
+		napi_enable(&edma->tx_ring[i].napi_tx);
+		napi_enable(&edma->rx_ring[i].napi_rx);
+	}
+
+	ipqess_edma_irq_enable(edma);
+	netif_tx_start_all_queues(netdev);
+
+	if (err)
+		goto err_hw_stop;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port)
+			port->edma = edma;
+	}
+
+	err = ipqess_notifiers_register();
+	if (err)
+		goto err_hw_stop;
+
+	return 0;
+
+err_hw_stop:
+	ipqess_edma_hw_stop(edma);
+
+	ipqess_edma_tx_ring_free(edma);
+	ipqess_edma_rx_ring_free(edma);
+err_clk:
+	clk_disable_unprepare(edma->edma_clk);
+err_edma:
+	devm_kfree(&pdev->dev, edma);
+
+	return err;
+}
+
+void ipqess_edma_uninit(struct ipqess_edma *edma)
+{
+	struct qca8k_priv *priv = edma->sw->priv;
+	u32 val;
+
+	ipqess_notifiers_unregister();
+
+	ipqess_edma_irq_disable(edma);
+	ipqess_edma_hw_stop(edma);
+
+	ipqess_edma_tx_ring_free(edma);
+	ipqess_edma_rx_ring_free(edma);
+
+	/* This register read fixes a bug where
+	 * the switch ID is incorrect at the next probe.
+	 * The source of this issue is unknown.
+	 */
+	qca8k_read(priv, QCA8K_REG_MASK_CTRL, &val);
+
+	clk_disable_unprepare(edma->edma_clk);
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
new file mode 100644
index 000000000000..355061de5243
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
@@ -0,0 +1,484 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR ISC) */
+/* Copyright (c) 2014 - 2016, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017 - 2018, John Crispin <john@phrozen.org>
+ * Copyright (c) 2018 - 2019, Christian Lamparter <chunkeey@gmail.com>
+ * Copyright (c) 2020 - 2021, Gabor Juhos <j4g8y7@gmail.com>
+ * Copyright (c) 2021 - 2022, Maxime Chevallier <maxime.chevallier@bootlin.com>
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ *
+ */
+
+#ifndef _IPQESS_EDMA_H_
+#define _IPQESS_EDMA_H_
+
+#include "ipqess_switch.h"
+
+#define IPQESS_EDMA_NETDEV_QUEUES	4
+
+#define IPQESS_EDMA_TPD_EOP_SHIFT 31
+
+#define IPQESS_EDMA_PORT_ID_SHIFT 12
+#define IPQESS_EDMA_PORT_ID_MASK 0x7
+
+/* tpd word 3 bit 18-28 */
+#define IPQESS_EDMA_TPD_PORT_BITMAP_SHIFT 18
+
+#define IPQESS_EDMA_TPD_FROM_CPU_SHIFT 25
+
+#define IPQESS_EDMA_RX_RING_SIZE 128
+#define IPQESS_EDMA_RX_HEAD_BUFF_SIZE 1540
+#define IPQESS_EDMA_TX_RING_SIZE 128
+#define IPQESS_EDMA_MAX_RX_QUEUE 8
+#define IPQESS_EDMA_MAX_TX_QUEUE 16
+
+/* Configurations */
+#define IPQESS_EDMA_INTR_CLEAR_TYPE 0
+#define IPQESS_EDMA_INTR_SW_IDX_W_TYPE 0
+#define IPQESS_EDMA_FIFO_THRESH_TYPE 0
+#define IPQESS_EDMA_RSS_TYPE 0
+#define IPQESS_EDMA_RX_IMT 0x0020
+#define IPQESS_EDMA_TX_IMT 0x0050
+#define IPQESS_EDMA_TPD_BURST 5
+#define IPQESS_EDMA_TXF_BURST 0x100
+#define IPQESS_EDMA_RFD_BURST 8
+#define IPQESS_EDMA_RFD_THR 16
+#define IPQESS_EDMA_RFD_LTHR 0
+
+/* Flags used in transmit direction */
+#define IPQESS_EDMA_DESC_LAST 0x1
+#define IPQESS_EDMA_DESC_SINGLE 0x2
+#define IPQESS_EDMA_DESC_PAGE 0x4
+
+struct ipqess_edma_tx_desc {
+	__le16  len;
+	__le16  svlan_tag;
+	__le32  word1;
+	__le32  addr;
+	__le32  word3;
+} __aligned(16) __packed;
+
+struct ipqess_edma_rx_desc {
+	__le16 rrd0;
+	__le16 rrd1;
+	__le16 rrd2;
+	__le16 rrd3;
+	__le16 rrd4;
+	__le16 rrd5;
+	__le16 rrd6;
+	__le16 rrd7;
+} __aligned(16) __packed;
+
+struct ipqess_edma_buf {
+	struct sk_buff *skb;
+	dma_addr_t dma;
+	u32 flags;
+	u16 length;
+};
+
+struct ipqess_edma_tx_ring {
+	struct napi_struct napi_tx;
+	u32 idx;
+	int ring_id;
+	struct ipqess_edma *edma;
+	struct netdev_queue *nq;
+	struct ipqess_edma_tx_desc *hw_desc;
+	struct ipqess_edma_buf *buf;
+	dma_addr_t dma;
+	u16 count;
+	u16 head;
+	u16 tail;
+};
+
+struct ipqess_edma_rx_ring {
+	struct napi_struct napi_rx;
+	u32 idx;
+	int ring_id;
+	struct ipqess_edma *edma;
+	struct device *ppdev;
+	struct ipqess_edma_rx_desc **hw_desc;
+	struct ipqess_edma_buf *buf;
+	dma_addr_t dma;
+	u16 head;
+	u16 tail;
+	atomic_t refill_count;
+};
+
+struct ipqess_edma_rx_ring_refill {
+	struct ipqess_edma_rx_ring *rx_ring;
+	struct work_struct refill_work;
+};
+
+#define IPQESS_EDMA_IRQ_NAME_LEN	32
+
+struct ipqess_edma {
+	void __iomem *hw_addr;
+
+	/* sw port device chosen as napi leader */
+	struct net_device *netdev;
+
+	struct clk *edma_clk;
+	struct reset_control *edma_rst;
+
+	struct ipqess_edma_rx_ring rx_ring[IPQESS_EDMA_NETDEV_QUEUES];
+
+	struct platform_device *pdev;
+
+	struct notifier_block netdev_notifier;
+	int dsa_ports;
+
+	struct ipqess_edma_tx_ring tx_ring[IPQESS_EDMA_NETDEV_QUEUES];
+
+	struct ipqess_switch *sw;
+
+	/* Protects stats */
+	spinlock_t stats_lock;
+	struct net_device_stats stats;
+
+	struct ipqess_edma_rx_ring_refill rx_refill[IPQESS_EDMA_NETDEV_QUEUES];
+	u32 tx_irq[IPQESS_EDMA_MAX_TX_QUEUE];
+	char tx_irq_names[IPQESS_EDMA_MAX_TX_QUEUE][IPQESS_EDMA_IRQ_NAME_LEN];
+	u32 rx_irq[IPQESS_EDMA_MAX_RX_QUEUE];
+	char rx_irq_names[IPQESS_EDMA_MAX_TX_QUEUE][IPQESS_EDMA_IRQ_NAME_LEN];
+};
+
+int ipqess_edma_init(struct platform_device *pdev, struct device_node *np);
+void ipqess_edma_uninit(struct ipqess_edma *edma);
+
+netdev_tx_t ipqess_edma_xmit(struct sk_buff *skb, struct net_device *netdev);
+
+/* register definition */
+#define IPQESS_EDMA_REG_MAS_CTRL 0x0
+#define IPQESS_EDMA_REG_TIMEOUT_CTRL 0x004
+#define IPQESS_EDMA_REG_DBG0 0x008
+#define IPQESS_EDMA_REG_DBG1 0x00C
+#define IPQESS_EDMA_REG_SW_CTRL0 0x100
+#define IPQESS_EDMA_REG_SW_CTRL1 0x104
+
+/* Interrupt Status Register */
+#define IPQESS_EDMA_REG_RX_ISR 0x200
+#define IPQESS_EDMA_REG_TX_ISR 0x208
+#define IPQESS_EDMA_REG_MISC_ISR 0x210
+#define IPQESS_EDMA_REG_WOL_ISR 0x218
+
+#define IPQESS_EDMA_MISC_ISR_RX_URG_Q(x) (1 << (x))
+
+#define IPQESS_EDMA_MISC_ISR_AXIR_TIMEOUT 0x00000100
+#define IPQESS_EDMA_MISC_ISR_AXIR_ERR 0x00000200
+#define IPQESS_EDMA_MISC_ISR_TXF_DEAD 0x00000400
+#define IPQESS_EDMA_MISC_ISR_AXIW_ERR 0x00000800
+#define IPQESS_EDMA_MISC_ISR_AXIW_TIMEOUT 0x00001000
+
+#define IPQESS_EDMA_WOL_ISR 0x00000001
+
+/* Interrupt Mask Register */
+#define IPQESS_EDMA_REG_MISC_IMR 0x214
+#define IPQESS_EDMA_REG_WOL_IMR 0x218
+
+#define IPQESS_EDMA_RX_IMR_NORMAL_MASK 0x1
+#define IPQESS_EDMA_TX_IMR_NORMAL_MASK 0x1
+#define IPQESS_EDMA_MISC_IMR_NORMAL_MASK 0x80001FFF
+#define IPQESS_EDMA_WOL_IMR_NORMAL_MASK 0x1
+
+/* Edma receive consumer index */
+#define IPQESS_EDMA_REG_RX_SW_CONS_IDX_Q(x) (0x220 + ((x) * 4))
+						    /* x is the queue id */
+
+/* Edma transmit consumer index */
+#define IPQESS_EDMA_REG_TX_SW_CONS_IDX_Q(x) (0x240 + ((x) * 4))
+						    /* x is the queue id */
+
+/* IRQ Moderator Initial Timer Register */
+#define IPQESS_EDMA_REG_IRQ_MODRT_TIMER_INIT 0x280
+#define IPQESS_EDMA_IRQ_MODRT_TIMER_MASK 0xFFFF
+#define IPQESS_EDMA_IRQ_MODRT_RX_TIMER_SHIFT 0
+#define IPQESS_EDMA_IRQ_MODRT_TX_TIMER_SHIFT 16
+
+/* Interrupt Control Register */
+#define IPQESS_EDMA_REG_INTR_CTRL 0x284
+#define IPQESS_EDMA_INTR_CLR_TYP_SHIFT 0
+#define IPQESS_EDMA_INTR_SW_IDX_W_TYP_SHIFT 1
+#define IPQESS_EDMA_INTR_CLEAR_TYPE_W1 0
+#define IPQESS_EDMA_INTR_CLEAR_TYPE_R 1
+
+/* RX Interrupt Mask Register */
+#define IPQESS_EDMA_REG_RX_INT_MASK_Q(x) (0x300 + ((x) * 4)) /* x = queue id */
+
+/* TX Interrupt mask register */
+#define IPQESS_EDMA_REG_TX_INT_MASK_Q(x) (0x340 + ((x) * 4)) /* x = queue id */
+
+/* Load Ptr Register
+ * Software sets this bit after the initialization of the head and tail
+ */
+#define IPQESS_EDMA_REG_TX_SRAM_PART 0x400
+#define IPQESS_EDMA_LOAD_PTR_SHIFT 16
+
+/* TXQ Control Register */
+#define IPQESS_EDMA_REG_TXQ_CTRL 0x404
+#define IPQESS_EDMA_TXQ_CTRL_IP_OPTION_EN 0x10
+#define IPQESS_EDMA_TXQ_CTRL_TXQ_EN 0x20
+#define IPQESS_EDMA_TXQ_CTRL_ENH_MODE 0x40
+#define IPQESS_EDMA_TXQ_CTRL_LS_8023_EN 0x80
+#define IPQESS_EDMA_TXQ_CTRL_TPD_BURST_EN 0x100
+#define IPQESS_EDMA_TXQ_CTRL_LSO_BREAK_EN 0x200
+#define IPQESS_EDMA_TXQ_NUM_TPD_BURST_MASK 0xF
+#define IPQESS_EDMA_TXQ_TXF_BURST_NUM_MASK 0xFFFF
+#define IPQESS_EDMA_TXQ_NUM_TPD_BURST_SHIFT 0
+#define IPQESS_EDMA_TXQ_TXF_BURST_NUM_SHIFT 16
+
+#define	IPQESS_EDMA_REG_TXF_WATER_MARK 0x408 /* In 8-bytes */
+#define IPQESS_EDMA_TXF_WATER_MARK_MASK 0x0FFF
+#define IPQESS_EDMA_TXF_LOW_WATER_MARK_SHIFT 0
+#define IPQESS_EDMA_TXF_HIGH_WATER_MARK_SHIFT 16
+#define IPQESS_EDMA_TXQ_CTRL_BURST_MODE_EN 0x80000000
+
+/* WRR Control Register */
+#define IPQESS_EDMA_REG_WRR_CTRL_Q0_Q3 0x40c
+#define IPQESS_EDMA_REG_WRR_CTRL_Q4_Q7 0x410
+#define IPQESS_EDMA_REG_WRR_CTRL_Q8_Q11 0x414
+#define IPQESS_EDMA_REG_WRR_CTRL_Q12_Q15 0x418
+
+/* Weight round robin(WRR), it takes queue as input, and computes
+ * starting bits where we need to write the weight for a particular
+ * queue
+ */
+#define IPQESS_EDMA_WRR_SHIFT(x) (((x) * 5) % 20)
+
+/* Tx Descriptor Control Register */
+#define IPQESS_EDMA_REG_TPD_RING_SIZE 0x41C
+#define IPQESS_EDMA_TPD_RING_SIZE_SHIFT 0
+#define IPQESS_EDMA_TPD_RING_SIZE_MASK 0xFFFF
+
+/* Transmit descriptor base addredma */
+#define IPQESS_EDMA_REG_TPD_BASE_ADDR_Q(x) (0x420 + ((x) * 4))
+						   /* x = queue id */
+
+/* TPD Index Register */
+#define IPQESS_EDMA_REG_TPD_IDX_Q(x) (0x460 + ((x) * 4)) /* x = queue id */
+
+#define IPQESS_EDMA_TPD_PROD_IDX_BITS 0x0000FFFF
+#define IPQESS_EDMA_TPD_CONS_IDX_BITS 0xFFFF0000
+#define IPQESS_EDMA_TPD_PROD_IDX_MASK 0xFFFF
+#define IPQESS_EDMA_TPD_CONS_IDX_MASK 0xFFFF
+#define IPQESS_EDMA_TPD_PROD_IDX_SHIFT 0
+#define IPQESS_EDMA_TPD_CONS_IDX_SHIFT 16
+
+/* TX Virtual Queue Mapping Control Register */
+#define IPQESS_EDMA_REG_VQ_CTRL0 0x4A0
+#define IPQESS_EDMA_REG_VQ_CTRL1 0x4A4
+
+/* Virtual QID shift, it takes queue as input, and computes
+ * Virtual QID position in virtual qid control register
+ */
+#define IPQESS_EDMA_VQ_ID_SHIFT(i) (((i) * 3) % 24)
+
+/* Virtual Queue Default Value */
+#define IPQESS_EDMA_VQ_REG_VALUE 0x240240
+
+/* Tx side Port Interface Control Register */
+#define IPQESS_EDMA_REG_PORT_CTRL 0x4A8
+#define IPQESS_EDMA_PAD_EN_SHIFT 15
+
+/* Tx side VLAN Configuration Register */
+#define IPQESS_EDMA_REG_VLAN_CFG 0x4AC
+
+#define IPQESS_EDMA_VLAN_CFG_SVLAN_TPID_SHIFT 0
+#define IPQESS_EDMA_VLAN_CFG_SVLAN_TPID_MASK 0xffff
+#define IPQESS_EDMA_VLAN_CFG_CVLAN_TPID_SHIFT 16
+#define IPQESS_EDMA_VLAN_CFG_CVLAN_TPID_MASK 0xffff
+
+#define IPQESS_EDMA_TX_CVLAN 16
+#define IPQESS_EDMA_TX_INS_CVLAN 17
+#define IPQESS_EDMA_TX_CVLAN_TAG_SHIFT 0
+
+#define IPQESS_EDMA_TX_SVLAN 14
+#define IPQESS_EDMA_TX_INS_SVLAN 15
+#define IPQESS_EDMA_TX_SVLAN_TAG_SHIFT 16
+
+/* Tx Queue Packet Statistic Register */
+#define IPQESS_EDMA_REG_TX_STAT_PKT_Q(x) (0x700 + ((x) * 8)) /* x = queue id */
+
+#define IPQESS_EDMA_TX_STAT_PKT_MASK 0xFFFFFF
+
+/* Tx Queue Byte Statistic Register */
+#define IPQESS_EDMA_REG_TX_STAT_BYTE_Q(x) (0x704 + ((x) * 8)) /* x = queue id */
+
+/* Load Balance Based Ring Offset Register */
+#define IPQESS_EDMA_REG_LB_RING 0x800
+#define IPQESS_EDMA_LB_RING_ENTRY_MASK 0xff
+#define IPQESS_EDMA_LB_RING_ID_MASK 0x7
+#define IPQESS_EDMA_LB_RING_PROFILE_ID_MASK 0x3
+#define IPQESS_EDMA_LB_RING_ENTRY_BIT_OFFSET 8
+#define IPQESS_EDMA_LB_RING_ID_OFFSET 0
+#define IPQESS_EDMA_LB_RING_PROFILE_ID_OFFSET 3
+#define IPQESS_EDMA_LB_REG_VALUE 0x6040200
+
+/* Load Balance Priority Mapping Register */
+#define IPQESS_EDMA_REG_LB_PRI_START 0x804
+#define IPQESS_EDMA_REG_LB_PRI_END 0x810
+#define IPQESS_EDMA_LB_PRI_REG_INC 4
+#define IPQESS_EDMA_LB_PRI_ENTRY_BIT_OFFSET 4
+#define IPQESS_EDMA_LB_PRI_ENTRY_MASK 0xf
+
+/* RSS Priority Mapping Register */
+#define IPQESS_EDMA_REG_RSS_PRI 0x820
+#define IPQESS_EDMA_RSS_PRI_ENTRY_MASK 0xf
+#define IPQESS_EDMA_RSS_RING_ID_MASK 0x7
+#define IPQESS_EDMA_RSS_PRI_ENTRY_BIT_OFFSET 4
+
+/* RSS Indirection Register */
+#define IPQESS_EDMA_REG_RSS_IDT(x) (0x840 + ((x) * 4))
+					   /* x = No. of indirection table */
+#define IPQESS_EDMA_NUM_IDT 16
+#define IPQESS_EDMA_RSS_IDT_VALUE 0x64206420
+
+/* Default RSS Ring Register */
+#define IPQESS_EDMA_REG_DEF_RSS 0x890
+#define IPQESS_EDMA_DEF_RSS_MASK 0x7
+
+/* RSS Hash Function Type Register */
+#define IPQESS_EDMA_REG_RSS_TYPE 0x894
+#define IPQESS_EDMA_RSS_TYPE_NONE 0x01
+#define IPQESS_EDMA_RSS_TYPE_IPV4TCP 0x02
+#define IPQESS_EDMA_RSS_TYPE_IPV6_TCP 0x04
+#define IPQESS_EDMA_RSS_TYPE_IPV4_UDP 0x08
+#define IPQESS_EDMA_RSS_TYPE_IPV6UDP 0x10
+#define IPQESS_EDMA_RSS_TYPE_IPV4 0x20
+#define IPQESS_EDMA_RSS_TYPE_IPV6 0x40
+#define IPQESS_EDMA_RSS_HASH_MODE_MASK 0x7f
+
+#define IPQESS_EDMA_REG_RSS_HASH_VALUE 0x8C0
+
+#define IPQESS_EDMA_REG_RSS_TYPE_RESULT 0x8C4
+
+#define IPQESS_EDMA_HASH_TYPE_START 0
+#define IPQESS_EDMA_HASH_TYPE_END 5
+#define IPQESS_EDMA_HASH_TYPE_SHIFT 12
+
+#define IPQESS_EDMA_RFS_FLOW_ENTRIES 1024
+#define IPQESS_EDMA_RFS_FLOW_ENTRIES_MASK (IPQESS_EDMA_RFS_FLOW_ENTRIES - 1)
+#define IPQESS_EDMA_RFS_EXPIRE_COUNT_PER_CALL 128
+
+/* RFD Base Addredma Register */
+#define IPQESS_EDMA_REG_RFD_BASE_ADDR_Q(x) (0x950 + ((x) * 4))
+						   /* x = queue id */
+
+/* RFD Index Register */
+#define IPQESS_EDMA_REG_RFD_IDX_Q(x) (0x9B0 + ((x) * 4)) /* x = queue id */
+
+#define IPQESS_EDMA_RFD_PROD_IDX_BITS 0x00000FFF
+#define IPQESS_EDMA_RFD_CONS_IDX_BITS 0x0FFF0000
+#define IPQESS_EDMA_RFD_PROD_IDX_MASK 0xFFF
+#define IPQESS_EDMA_RFD_CONS_IDX_MASK 0xFFF
+#define IPQESS_EDMA_RFD_PROD_IDX_SHIFT 0
+#define IPQESS_EDMA_RFD_CONS_IDX_SHIFT 16
+
+/* Rx Descriptor Control Register */
+#define IPQESS_EDMA_REG_RX_DESC0 0xA10
+#define IPQESS_EDMA_RFD_RING_SIZE_MASK 0xFFF
+#define IPQESS_EDMA_RX_BUF_SIZE_MASK 0xFFFF
+#define IPQESS_EDMA_RFD_RING_SIZE_SHIFT 0
+#define IPQESS_EDMA_RX_BUF_SIZE_SHIFT 16
+
+#define IPQESS_EDMA_REG_RX_DESC1 0xA14
+#define IPQESS_EDMA_RXQ_RFD_BURST_NUM_MASK 0x3F
+#define IPQESS_EDMA_RXQ_RFD_PF_THRESH_MASK 0x1F
+#define IPQESS_EDMA_RXQ_RFD_LOW_THRESH_MASK 0xFFF
+#define IPQESS_EDMA_RXQ_RFD_BURST_NUM_SHIFT 0
+#define IPQESS_EDMA_RXQ_RFD_PF_THRESH_SHIFT 8
+#define IPQESS_EDMA_RXQ_RFD_LOW_THRESH_SHIFT 16
+
+/* RXQ Control Register */
+#define IPQESS_EDMA_REG_RXQ_CTRL 0xA18
+#define IPQESS_EDMA_FIFO_THRESH_TYPE_SHIF 0
+#define IPQESS_EDMA_FIFO_THRESH_128_BYTE 0x0
+#define IPQESS_EDMA_FIFO_THRESH_64_BYTE 0x1
+#define IPQESS_EDMA_RXQ_CTRL_RMV_VLAN 0x00000002
+#define IPQESS_EDMA_RXQ_CTRL_EN_MASK			GENMASK(15, 8)
+#define IPQESS_EDMA_RXQ_CTRL_EN(__qid)		BIT(8 + (__qid))
+
+/* AXI Burst Size Config */
+#define IPQESS_EDMA_REG_AXIW_CTRL_MAXWRSIZE 0xA1C
+#define IPQESS_EDMA_AXIW_MAXWRSIZE_VALUE 0x0
+
+/* Rx Statistics Register */
+#define IPQESS_EDMA_REG_RX_STAT_BYTE_Q(x) (0xA30 + ((x) * 4))
+						  /* x = queue id */
+#define IPQESS_EDMA_REG_RX_STAT_PKT_Q(x) (0xA50 + ((x) * 4))
+						  /* x = queue id */
+
+/* WoL Pattern Length Register */
+#define IPQESS_EDMA_REG_WOL_PATTERN_LEN0 0xC00
+#define IPQESS_EDMA_WOL_PT_LEN_MASK 0xFF
+#define IPQESS_EDMA_WOL_PT0_LEN_SHIFT 0
+#define IPQESS_EDMA_WOL_PT1_LEN_SHIFT 8
+#define IPQESS_EDMA_WOL_PT2_LEN_SHIFT 16
+#define IPQESS_EDMA_WOL_PT3_LEN_SHIFT 24
+
+#define IPQESS_EDMA_REG_WOL_PATTERN_LEN1 0xC04
+#define IPQESS_EDMA_WOL_PT4_LEN_SHIFT 0
+#define IPQESS_EDMA_WOL_PT5_LEN_SHIFT 8
+#define IPQESS_EDMA_WOL_PT6_LEN_SHIFT 16
+
+/* WoL Control Register */
+#define IPQESS_EDMA_REG_WOL_CTRL 0xC08
+#define IPQESS_EDMA_WOL_WK_EN 0x00000001
+#define IPQESS_EDMA_WOL_MG_EN 0x00000002
+#define IPQESS_EDMA_WOL_PT0_EN 0x00000004
+#define IPQESS_EDMA_WOL_PT1_EN 0x00000008
+#define IPQESS_EDMA_WOL_PT2_EN 0x00000010
+#define IPQESS_EDMA_WOL_PT3_EN 0x00000020
+#define IPQESS_EDMA_WOL_PT4_EN 0x00000040
+#define IPQESS_EDMA_WOL_PT5_EN 0x00000080
+#define IPQESS_EDMA_WOL_PT6_EN 0x00000100
+
+/* MAC Control Register */
+#define IPQESS_EDMA_REG_MAC_CTRL0 0xC20
+#define IPQESS_EDMA_REG_MAC_CTRL1 0xC24
+
+/* WoL Pattern Register */
+#define IPQESS_EDMA_REG_WOL_PATTERN_START 0x5000
+#define IPQESS_EDMA_PATTERN_PART_REG_OFFSET 0x40
+
+/* TX descriptor fields */
+#define IPQESS_EDMA_TPD_HDR_SHIFT 0
+#define IPQESS_EDMA_TPD_PPPOE_EN 0x00000100
+#define IPQESS_EDMA_TPD_IP_CSUM_EN 0x00000200
+#define IPQESS_EDMA_TPD_TCP_CSUM_EN 0x0000400
+#define IPQESS_EDMA_TPD_UDP_CSUM_EN 0x00000800
+#define IPQESS_EDMA_TPD_CUSTOM_CSUM_EN 0x00000C00
+#define IPQESS_EDMA_TPD_LSO_EN 0x00001000
+#define IPQESS_EDMA_TPD_LSO_V2_EN 0x00002000
+/* The VLAN_TAGGED bit is not used in the publicly available
+ * drivers. The definition has been stolen from the Atheros
+ * 'alx' driver (drivers/net/ethernet/atheros/alx/hw.h). It
+ * seems that it has the same meaning in regard to the EDMA
+ * hardware.
+ */
+#define IPQESS_EDMA_TPD_VLAN_TAGGED 0x00004000
+#define IPQESS_EDMA_TPD_IPV4_EN 0x00010000
+#define IPQESS_EDMA_TPD_MSS_MASK 0x1FFF
+#define IPQESS_EDMA_TPD_MSS_SHIFT 18
+#define IPQESS_EDMA_TPD_CUSTOM_CSUM_SHIFT 18
+
+/* RRD descriptor fields */
+#define IPQESS_EDMA_RRD_NUM_RFD_MASK 0x000F
+#define IPQESS_EDMA_RRD_PKT_SIZE_MASK 0x3FFF
+#define IPQESS_EDMA_RRD_SRC_PORT_NUM_MASK 0x4000
+#define IPQESS_EDMA_RRD_SVLAN 0x8000
+#define IPQESS_EDMA_RRD_FLOW_COOKIE_MASK 0x07FF
+
+#define IPQESS_EDMA_RRD_PKT_SIZE_MASK 0x3FFF
+#define IPQESS_EDMA_RRD_CSUM_FAIL_MASK 0xC000
+#define IPQESS_EDMA_RRD_CVLAN 0x0001
+#define IPQESS_EDMA_RRD_DESC_VALID 0x8000
+
+#define IPQESS_EDMA_RRD_PRIORITY_SHIFT 4
+#define IPQESS_EDMA_RRD_PRIORITY_MASK 0x7
+#define IPQESS_EDMA_RRD_PORT_TYPE_SHIFT 7
+#define IPQESS_EDMA_RRD_PORT_TYPE_MASK 0x1F
+
+#define IPQESS_EDMA_RRD_PORT_ID_MASK 0x7000
+
+#define IPQESS_EDMA_MAX_MTU 9000
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
new file mode 100644
index 000000000000..77f6d79c2ff6
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0 OR ISC
+/*
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa/slave.c
+ */
+
+#include <net/switchdev.h>
+
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/if_hsr.h>
+
+#include "ipqess_notifiers.h"
+#include "ipqess_port.h"
+
+static struct workqueue_struct *ipqess_owq;
+
+static bool ipqess_schedule_work(struct work_struct *work)
+{
+	return queue_work(ipqess_owq, work);
+}
+
+void ipqess_flush_workqueue(void)
+{
+	flush_workqueue(ipqess_owq);
+}
+
+/* switchdev */
+
+static int ipqess_port_fdb_event(struct net_device *netdev,
+				 struct net_device *orig_netdev,
+				 unsigned long event, const void *ctx,
+				 const struct switchdev_notifier_fdb_info *fdb_info)
+{
+	struct ipqess_switchdev_event_work *switchdev_work;
+	struct ipqess_port *port = netdev_priv(netdev);
+	bool host_addr = fdb_info->is_local;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	if (!port->bridge)
+		return 0;
+
+	if (switchdev_fdb_is_dynamically_learned(fdb_info) &&
+	    ipqess_port_offloads_bridge_port(port, orig_netdev))
+		return 0;
+
+	/* Also treat FDB entries on foreign interfaces bridged with us as host
+	 * addresses.
+	 */
+	if (ipqess_port_dev_is_foreign(netdev, orig_netdev))
+		host_addr = true;
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (!switchdev_work)
+		return -ENOMEM;
+
+	netdev_dbg(netdev, "%s FDB entry towards %s, addr %pM vid %d%s\n",
+		   event == SWITCHDEV_FDB_ADD_TO_DEVICE ? "Adding" : "Deleting",
+		   orig_netdev->name, fdb_info->addr, fdb_info->vid,
+		   host_addr ? " as host address" : "");
+
+	INIT_WORK(&switchdev_work->work, ipqess_port_switchdev_event_work);
+	switchdev_work->event = event;
+	switchdev_work->netdev = netdev;
+	switchdev_work->orig_netdev = orig_netdev;
+
+	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
+	switchdev_work->vid = fdb_info->vid;
+	switchdev_work->host_addr = host_addr;
+
+	ipqess_schedule_work(&switchdev_work->work);
+
+	return 0;
+}
+
+/* Called under rcu_read_lock() */
+static int ipqess_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(netdev, ptr,
+						     ipqess_port_recognize_netdev,
+						     ipqess_port_attr_set);
+		return notifier_from_errno(err);
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		err = switchdev_handle_fdb_event_to_device(netdev, event, ptr,
+							   ipqess_port_recognize_netdev,
+							   ipqess_port_dev_is_foreign,
+							   ipqess_port_fdb_event);
+		return notifier_from_errno(err);
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ipqess_switchdev_blocking_event(struct notifier_block *unused,
+					   unsigned long event, void *ptr)
+{
+	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add_foreign(netdev, ptr,
+							    ipqess_port_recognize_netdev,
+							    ipqess_port_dev_is_foreign,
+							    ipqess_port_obj_add);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del_foreign(netdev, ptr,
+							    ipqess_port_recognize_netdev,
+							    ipqess_port_dev_is_foreign,
+							    ipqess_port_obj_del);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(netdev, ptr,
+						     ipqess_port_recognize_netdev,
+						     ipqess_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	return NOTIFY_DONE;
+}
+
+/* netdevice */
+
+static int ipqess_port_changeupper(struct net_device *netdev,
+				   struct netdev_notifier_changeupper_info *info)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct netlink_ext_ack *extack;
+	int err = NOTIFY_DONE;
+
+	if (!ipqess_port_recognize_netdev(netdev))
+		return err;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	if (netif_is_bridge_master(info->upper_dev)) {
+		if (info->linking) {
+			err = ipqess_port_bridge_join(port, info->upper_dev, extack);
+			if (err == -EOPNOTSUPP) {
+				NL_SET_ERR_MSG_WEAK_MOD(extack,
+							"Offloading not supported");
+				err = NOTIFY_DONE;
+			}
+			err = notifier_from_errno(err);
+		} else {
+			ipqess_port_bridge_leave(port, info->upper_dev);
+			err = NOTIFY_OK;
+		}
+	} else if (netif_is_lag_master(info->upper_dev)) {
+		/* LAG offloading is not supported by this driver */
+		NL_SET_ERR_MSG_WEAK_MOD(extack,
+					"Offloading not supported");
+		err = NOTIFY_DONE;
+	} else if (is_hsr_master(info->upper_dev)) {
+		if (info->linking) {
+			NL_SET_ERR_MSG_WEAK_MOD(extack,
+						"Offloading not supported");
+			err = NOTIFY_DONE;
+		} else {
+			err = NOTIFY_OK;
+		}
+	}
+
+	return err;
+}
+
+static int ipqess_port_prechangeupper(struct net_device *netdev,
+				      struct netdev_notifier_changeupper_info *info)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *brport_dev;
+	int err;
+
+	/* sanity check */
+	if (is_vlan_dev(info->upper_dev)) {
+		err = ipqess_port_check_8021q_upper(netdev, info);
+		if (notifier_to_errno(err))
+			return err;
+	}
+
+	/* prechangeupper */
+	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
+		brport_dev = ipqess_port_get_bridged_netdev(port);
+	else
+		return NOTIFY_DONE;
+
+	if (!brport_dev)
+		return NOTIFY_DONE;
+
+	switchdev_bridge_port_unoffload(brport_dev, port,
+					&ipqess_switchdev_notifier,
+					&ipqess_switchdev_blocking_notifier);
+
+	ipqess_flush_workqueue();
+
+	return NOTIFY_DONE;
+}
+
+static int ipqess_netdevice_event(struct notifier_block *nb,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	int err;
+
+	if (!ipqess_port_recognize_netdev(netdev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_PRECHANGEUPPER: {
+		err = ipqess_port_prechangeupper(netdev, ptr);
+		if (notifier_to_errno(err))
+			return err;
+
+		break;
+	}
+
+	case NETDEV_CHANGEUPPER: {
+		err = ipqess_port_changeupper(netdev, ptr);
+		if (notifier_to_errno(err))
+			return err;
+
+		break;
+	}
+
+	/* Handling this is only useful for LAG offloading, which this driver
+	 * doesn't support
+	 */
+	case NETDEV_CHANGELOWERSTATE:
+		return NOTIFY_DONE;
+	case NETDEV_CHANGE:
+	case NETDEV_UP:
+	case NETDEV_GOING_DOWN:
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+struct notifier_block ipqess_switchdev_notifier = {
+	.notifier_call = ipqess_switchdev_event,
+};
+
+struct notifier_block ipqess_switchdev_blocking_notifier = {
+	.notifier_call = ipqess_switchdev_blocking_event,
+};
+
+static struct notifier_block ipqess_nb __read_mostly = {
+	.notifier_call = ipqess_netdevice_event,
+};
+
+int ipqess_notifiers_register(void)
+{
+	int err;
+
+	ipqess_owq = alloc_ordered_workqueue("ipqess_ordered",
+					     WQ_MEM_RECLAIM);
+	if (!ipqess_owq)
+		return -ENOMEM;
+
+	err = register_netdevice_notifier(&ipqess_nb);
+	if (err)
+		goto err_netdev_nb;
+
+	err = register_switchdev_notifier(&ipqess_switchdev_notifier);
+	if (err)
+		goto err_switchdev_nb;
+
+	err = register_switchdev_blocking_notifier(&ipqess_switchdev_blocking_notifier);
+	if (err)
+		goto err_switchdev_blocking_nb;
+
+	return 0;
+
+err_switchdev_blocking_nb:
+	unregister_switchdev_notifier(&ipqess_switchdev_notifier);
+err_switchdev_nb:
+	unregister_netdevice_notifier(&ipqess_nb);
+err_netdev_nb:
+	destroy_workqueue(ipqess_owq);
+
+	return err;
+}
+EXPORT_SYMBOL(ipqess_notifiers_register);
+
+void ipqess_notifiers_unregister(void)
+{
+	unregister_switchdev_blocking_notifier(&ipqess_switchdev_blocking_notifier);
+	unregister_switchdev_notifier(&ipqess_switchdev_notifier);
+	unregister_netdevice_notifier(&ipqess_nb);
+
+	destroy_workqueue(ipqess_owq);
+}
+EXPORT_SYMBOL(ipqess_notifiers_unregister);
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
new file mode 100644
index 000000000000..47f06a757cf7
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 OR ISC */
+
+#ifndef IPQESS_NOTIFIERS_H
+#define IPQESS_NOTIFIERS_H
+
+#include <linux/if_ether.h>
+
+struct ipqess_switchdev_event_work {
+	struct net_device *netdev;
+	struct net_device *orig_netdev;
+	struct work_struct work;
+	unsigned long event;
+	/* Specific for SWITCHDEV_FDB_ADD_TO_DEVICE and
+	 * SWITCHDEV_FDB_DEL_TO_DEVICE
+	 */
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	bool host_addr;
+};
+
+extern struct notifier_block ipqess_switchdev_notifier;
+extern struct notifier_block ipqess_switchdev_blocking_notifier;
+
+int ipqess_notifiers_register(void);
+void ipqess_notifiers_unregister(void);
+
+void ipqess_flush_workqueue(void);
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
new file mode 100644
index 000000000000..95407a008971
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
@@ -0,0 +1,2016 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Handling of a single switch port
+ *
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa
+ */
+
+#include <linux/if_bridge.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/of_net.h>
+#include <net/selftests.h>
+
+#include "ipqess_port.h"
+#include "ipqess_edma.h"
+#include "ipqess_switch.h"
+#include "ipqess_notifiers.h"
+
+#define ipqess_port_from_pl_state(config, pl_config)\
+container_of(config, struct ipqess_port, pl_config)
+
+static struct device_type ipqess_port_type = {
+	.name	= "switch",
+};
+
+struct net_device *ipqess_port_get_bridged_netdev(const struct ipqess_port *port)
+{
+	if (!port->bridge)
+		return NULL;
+
+	return port->netdev;
+}
+
+/* netdev ops */
+
+static void ipqess_port_notify_bridge_fdb_flush(const struct ipqess_port *port,
+						u16 vid)
+{
+	struct net_device *brport_dev = ipqess_port_get_bridged_netdev(port);
+	struct switchdev_notifier_fdb_info info = {
+		.vid = vid,
+	};
+
+	/* When the port becomes standalone it has already left the bridge.
+	 * Don't notify the bridge in that case.
+	 */
+	if (!brport_dev)
+		return;
+
+	call_switchdev_notifiers(SWITCHDEV_FDB_FLUSH_TO_BRIDGE,
+				 brport_dev, &info.info, NULL);
+}
+
+static void ipqess_port_fast_age(const struct ipqess_port *port)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	mutex_lock(&priv->reg_mutex);
+	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port->index);
+	mutex_unlock(&priv->reg_mutex);
+
+	/* Flush all VLANs */
+	ipqess_port_notify_bridge_fdb_flush(port, 0);
+}
+
+static void ipqess_port_stp_state_set(struct ipqess_port *port,
+				      u8 state)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	u32 stp_state;
+	int err;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
+		break;
+	case BR_STATE_BLOCKING:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
+		break;
+	case BR_STATE_LISTENING:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
+		break;
+	case BR_STATE_LEARNING:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
+		break;
+	}
+
+	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
+			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
+
+	if (err)
+		dev_warn(priv->dev,
+			 "failed to set STP state %d for port %d: err %d\n",
+			 stp_state, port->index, err);
+}
+
+static void ipqess_port_set_state_now(struct ipqess_port *port,
+				      u8 state, bool do_fast_age)
+{
+	ipqess_port_stp_state_set(port, state);
+
+	if ((port->stp_state == BR_STATE_LEARNING ||
+	     port->stp_state == BR_STATE_FORWARDING) &&
+	    (state == BR_STATE_DISABLED || state == BR_STATE_BLOCKING ||
+	    state == BR_STATE_LISTENING))
+		ipqess_port_fast_age(port);
+
+	port->stp_state = state;
+}
+
+static int ipqess_port_enable_rt(struct ipqess_port *port,
+				 struct phy_device *phy)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	qca8k_port_set_status(priv, port->index, 1);
+	priv->port_enabled_map |= BIT(port->index);
+
+	phy_support_asym_pause(phy);
+
+	if (!port->bridge)
+		ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
+
+	if (port->pl)
+		phylink_start(port->pl);
+
+	return 0;
+}
+
+static void ipqess_port_disable_rt(struct ipqess_port *port)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	if (port->pl)
+		phylink_stop(port->pl);
+
+	if (!port->bridge)
+		ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
+
+	qca8k_port_set_status(priv, port->index, 0);
+	priv->port_enabled_map &= ~BIT(port->index);
+}
+
+static int ipqess_port_open(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct phy_device *phy = netdev->phydev;
+
+	return ipqess_port_enable_rt(port, phy);
+}
+
+static int ipqess_port_close(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	ipqess_port_disable_rt(port);
+
+	return 0;
+}
+
+static netdev_tx_t ipqess_port_xmit(struct sk_buff *skb,
+				    struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	dev_sw_netstats_tx_add(netdev, 1, skb->len);
+
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	return ipqess_edma_xmit(skb, port->netdev);
+}
+
+static int ipqess_port_set_mac_address(struct net_device *netdev, void *a)
+{
+	struct sockaddr *addr = a;
+	int err;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	/* If the port is down, the address isn't synced yet to hardware
+	 * so there is nothing to change
+	 */
+	if (!(netdev->flags & IFF_UP)) {
+		eth_hw_addr_set(netdev, addr->sa_data);
+		return 0;
+	}
+
+	if (!ether_addr_equal(addr->sa_data, netdev->dev_addr)) {
+		err = dev_uc_add(netdev, addr->sa_data);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_ioctl(struct net_device *netdev, struct ifreq *ifr,
+			     int cmd)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	return phylink_mii_ioctl(port->pl, ifr, cmd);
+}
+
+static int ipqess_port_get_iflink(const struct net_device *dev)
+{
+	return dev->ifindex;
+}
+
+static int ipqess_port_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	int err;
+
+	/* To change the MAX_FRAME_SIZE, the cpu port must be off
+	 * or the switch panics.
+	 */
+	if (port->sw->port0_enabled)
+		qca8k_port_set_status(priv, 0, 0);
+
+	err = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
+			  ETH_HLEN + ETH_FCS_LEN);
+
+	if (port->sw->port0_enabled)
+		qca8k_port_set_status(priv, 0, 1);
+
+	if (err)
+		return err;
+
+	dev->mtu = new_mtu;
+
+	return 0;
+}
+
+static inline struct net_device *ipqess_port_bridge_dev_get(struct ipqess_port *port)
+{
+	return port->bridge ? port->bridge->netdev : NULL;
+}
+
+static int ipqess_port_do_vlan_add(struct qca8k_priv *priv, int port_index,
+				   const struct switchdev_obj_port_vlan *vlan,
+				   struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	int ret;
+
+	ret = qca8k_vlan_add(priv, port_index, vlan->vid, untagged);
+	if (ret) {
+		dev_err(priv->dev, "Failed to add VLAN to port %d (%d)", port_index,
+			ret);
+		return ret;
+	}
+
+	if (pvid) {
+		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
+				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
+				QCA8K_EGREES_VLAN_PORT(port_index, vlan->vid));
+		if (ret)
+			return ret;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
+				  QCA8K_PORT_VLAN_CVID(vlan->vid) |
+				  QCA8K_PORT_VLAN_SVID(vlan->vid));
+	}
+
+	return ret;
+}
+
+static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
+				       u16 vid)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct switchdev_obj_port_vlan vlan = {
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.vid = vid,
+		/* This API only allows programming tagged, non-PVID VIDs */
+		.flags = 0,
+	};
+	struct netlink_ext_ack extack = {0};
+	int ret;
+
+	/* User port... */
+	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
+	if (ret) {
+		if (extack._msg)
+			netdev_err(dev, "%s\n", extack._msg);
+		return ret;
+	}
+
+	/* And CPU port... */
+	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
+	if (ret) {
+		if (extack._msg)
+			netdev_err(dev, "CPU port %d: %s\n", 0, extack._msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
+					u16 vid)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	int err;
+
+	err = qca8k_vlan_del(port->sw->priv, port->index, vid);
+	if (err)
+		return err;
+
+	err = qca8k_vlan_del(port->sw->priv, 0, vid);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int
+ipqess_port_fdb_do_dump(const unsigned char *addr, u16 vid,
+			bool is_static, void *data)
+{
+	struct ipqess_port_dump_ctx *dump = data;
+	u32 portid = NETLINK_CB(dump->cb->skb).portid;
+	u32 seq = dump->cb->nlh->nlmsg_seq;
+	struct nlmsghdr *nlh;
+	struct ndmsg *ndm;
+
+	if (dump->idx < dump->cb->args[2])
+		goto skip;
+
+	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
+			sizeof(*ndm), NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	ndm = nlmsg_data(nlh);
+	ndm->ndm_family  = AF_BRIDGE;
+	ndm->ndm_pad1    = 0;
+	ndm->ndm_pad2    = 0;
+	ndm->ndm_flags   = NTF_SELF;
+	ndm->ndm_type    = 0;
+	ndm->ndm_ifindex = dump->dev->ifindex;
+	ndm->ndm_state   = is_static ? NUD_NOARP : NUD_REACHABLE;
+
+	if (nla_put(dump->skb, NDA_LLADDR, ETH_ALEN, addr))
+		goto nla_put_failure;
+
+	if (vid && nla_put_u16(dump->skb, NDA_VLAN, vid))
+		goto nla_put_failure;
+
+	nlmsg_end(dump->skb, nlh);
+
+skip:
+	dump->idx++;
+	return 0;
+
+nla_put_failure:
+	nlmsg_cancel(dump->skb, nlh);
+	return -EMSGSIZE;
+}
+
+static int
+ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+		     struct net_device *dev, struct net_device *filter_dev,
+		     int *idx)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	struct ipqess_port_dump_ctx dump = {
+		.dev = dev,
+		.skb = skb,
+		.cb = cb,
+		.idx = *idx,
+	};
+	int cnt = QCA8K_NUM_FDB_RECORDS;
+	struct qca8k_fdb _fdb = { 0 };
+	bool is_static;
+	int ret = 0;
+
+	mutex_lock(&priv->reg_mutex);
+	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port->index)) {
+		if (!_fdb.aging)
+			break;
+		is_static = (_fdb.aging == QCA8K_ATU_STATUS_STATIC);
+		ret = ipqess_port_fdb_do_dump(_fdb.mac, _fdb.vid, is_static, &dump);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&priv->reg_mutex);
+
+	*idx = dump.idx;
+
+	return ret;
+}
+
+static const struct net_device_ops ipqess_port_netdev_ops = {
+	.ndo_open               = ipqess_port_open,
+	.ndo_stop               = ipqess_port_close,
+	.ndo_set_mac_address    = ipqess_port_set_mac_address,
+	.ndo_eth_ioctl          = ipqess_port_ioctl,
+	.ndo_start_xmit         = ipqess_port_xmit,
+	.ndo_get_iflink         = ipqess_port_get_iflink,
+	.ndo_change_mtu         = ipqess_port_change_mtu,
+	.ndo_vlan_rx_add_vid    = ipqess_port_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid   = ipqess_port_vlan_rx_kill_vid,
+	.ndo_fdb_dump           = ipqess_port_fdb_dump,
+};
+
+/* Bridge ops */
+
+static int ipqess_port_bridge_alloc(struct ipqess_port *port,
+				    struct net_device *br,
+				    struct netlink_ext_ack *extack)
+{
+	struct ipqess_bridge *bridge;
+
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	refcount_set(&bridge->refcount, 1);
+
+	bridge->netdev = br;
+
+	port->bridge = bridge;
+
+	return 0;
+}
+
+/* Must be called under rcu_read_lock() */
+static bool ipqess_port_can_apply_vlan_filtering(struct ipqess_port *port,
+						 bool vlan_filtering,
+						 struct netlink_ext_ack *extack)
+{
+	int err;
+
+	/* VLAN awareness was off, so the question is "can we turn it on".
+	 * We may have had 8021q uppers, those need to go. Make sure we don't
+	 * enter an inconsistent state: deny changing the VLAN awareness state
+	 * as long as we have 8021q uppers.
+	 */
+	if (vlan_filtering) {
+		struct net_device *br = ipqess_port_bridge_dev_get(port);
+		struct net_device *upper_dev, *netdev = port->netdev;
+		struct list_head *iter;
+
+		netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter) {
+			struct bridge_vlan_info br_info;
+			u16 vid;
+
+			if (!is_vlan_dev(upper_dev))
+				continue;
+
+			vid = vlan_dev_vlan_id(upper_dev);
+
+			/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
+			 * device, respectively the VID is not found, returning
+			 * 0 means success, which is a failure for us here.
+			 */
+			err = br_vlan_get_info(br, vid, &br_info);
+			if (err == 0) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Must first remove VLAN uppers having VIDs also present in bridge");
+				return false;
+			}
+		}
+	}
+
+	/* VLAN filtering is not global so we can just return true here */
+	return true;
+}
+
+static int ipqess_port_restore_vlan(struct net_device *vdev, int vid, void *arg)
+{
+	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
+
+	return ipqess_port_vlan_rx_add_vid(arg, proto, vid);
+}
+
+static int ipqess_port_clear_vlan(struct net_device *vdev, int vid, void *arg)
+{
+	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
+
+	return ipqess_port_vlan_rx_kill_vid(arg, proto, vid);
+}
+
+/* Keep the VLAN RX filtering list in sync with the hardware only if VLAN
+ * filtering is enabled.
+ */
+static int ipqess_port_manage_vlan_filtering(struct net_device *netdev,
+					     bool vlan_filtering)
+{
+	int err;
+
+	if (vlan_filtering) {
+		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+		err = vlan_for_each(netdev, ipqess_port_restore_vlan, netdev);
+		if (err) {
+			netdev_err(netdev,
+				   "Failed to restore all VLAN's successfully, error %d\n",
+				   err);
+			vlan_for_each(netdev, ipqess_port_clear_vlan, netdev);
+			netdev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+			return err;
+		}
+	} else {
+		err = vlan_for_each(netdev, ipqess_port_clear_vlan, netdev);
+		if (err)
+			return err;
+
+		netdev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
+
+	return 0;
+}
+
+static int ipqess_write_vlan_filtering(struct qca8k_priv *priv, int port_index,
+				       bool vlan_filtering)
+{
+	int ret;
+
+	if (vlan_filtering) {
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				QCA8K_PORT_LOOKUP_VLAN_MODE_MASK,
+				QCA8K_PORT_LOOKUP_VLAN_MODE_SECURE);
+	} else {
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				QCA8K_PORT_LOOKUP_VLAN_MODE_MASK,
+				QCA8K_PORT_LOOKUP_VLAN_MODE_NONE);
+	}
+
+	return ret;
+}
+
+static int ipqess_port_vlan_filtering(struct ipqess_port *port,
+				      bool vlan_filtering,
+				      struct netlink_ext_ack *extack)
+{
+	bool old_vlan_filtering = port->vlan_filtering;
+	bool apply;
+	int err;
+
+	/* We are called from ipqess_port_switchdev_blocking_event(),
+	 * which is not under rcu_read_lock(), unlike
+	 * ipqess_port_switchdev_event().
+	 */
+	rcu_read_lock();
+	apply = ipqess_port_can_apply_vlan_filtering(port, vlan_filtering, extack);
+	rcu_read_unlock();
+	if (!apply)
+		return -EINVAL;
+
+	if (old_vlan_filtering == vlan_filtering)
+		return 0;
+
+	err = ipqess_write_vlan_filtering(port->sw->priv, port->index,
+					  vlan_filtering);
+
+	if (err)
+		return err;
+
+	port->vlan_filtering = vlan_filtering;
+
+	err = ipqess_port_manage_vlan_filtering(port->netdev,
+						vlan_filtering);
+	if (err)
+		goto restore;
+
+	return 0;
+
+restore:
+	err = ipqess_write_vlan_filtering(port->sw->priv, port->index,
+					  old_vlan_filtering);
+	port->vlan_filtering = old_vlan_filtering;
+
+	return err;
+}
+
+static void ipqess_port_reset_vlan_filtering(struct ipqess_port *port,
+					     struct ipqess_bridge *bridge)
+{
+	struct netlink_ext_ack extack = {0};
+	bool change_vlan_filtering = false;
+	bool vlan_filtering;
+	int err;
+
+	if (br_vlan_enabled(bridge->netdev)) {
+		change_vlan_filtering = true;
+		vlan_filtering = false;
+	}
+
+	if (!change_vlan_filtering)
+		return;
+
+	err = ipqess_port_vlan_filtering(port, vlan_filtering, &extack);
+	if (extack._msg) {
+		dev_err(&port->netdev->dev, "port %d: %s\n", port->index,
+			extack._msg);
+	}
+	if (err && err != -EOPNOTSUPP) {
+		dev_err(&port->netdev->dev,
+			"port %d failed to reset VLAN filtering to %d: %pe\n",
+			port->index, vlan_filtering, ERR_PTR(err));
+	}
+}
+
+static int ipqess_port_ageing_time(struct ipqess_port *port,
+				   clock_t ageing_clock)
+{
+	unsigned long ageing_jiffies = clock_t_to_jiffies(ageing_clock);
+	unsigned int ageing_time = jiffies_to_msecs(ageing_jiffies);
+
+	if (ageing_time < IPQESS_SWITCH_AGEING_TIME_MIN ||
+	    ageing_time > IPQESS_SWITCH_AGEING_TIME_MAX)
+		return -ERANGE;
+
+	/* Program the fastest ageing time in case of multiple bridges */
+	ageing_time = ipqess_switch_fastest_ageing_time(port->sw, ageing_time);
+
+	port->ageing_time = ageing_time;
+	return ipqess_set_ageing_time(port->sw, ageing_time);
+}
+
+static int ipqess_port_switchdev_sync_attrs(struct ipqess_port *port,
+					    struct netlink_ext_ack *extack)
+{
+	struct net_device *brport_dev = ipqess_port_get_bridged_netdev(port);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	int err;
+
+	ipqess_port_set_state_now(port, br_port_get_stp_state(brport_dev), false);
+
+	err = ipqess_port_vlan_filtering(port, br_vlan_enabled(br), extack);
+	if (err)
+		return err;
+
+	err = ipqess_port_ageing_time(port, br_get_ageing_time(br));
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
+	return 0;
+}
+
+static void ipqess_port_switchdev_unsync_attrs(struct ipqess_port *port,
+					       struct ipqess_bridge *bridge)
+{
+	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
+	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
+	 */
+	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, true);
+
+	ipqess_port_reset_vlan_filtering(port, bridge);
+
+	/* Ageing time is global to the switch chip, so don't change it
+	 * here because we have no good reason (or value) to change it to.
+	 */
+}
+
+static inline bool ipqess_port_offloads_bridge(struct ipqess_port *port,
+					       const struct ipqess_bridge *bridge)
+{
+	return ipqess_port_bridge_dev_get(port) == bridge->netdev;
+}
+
+bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
+				      const struct net_device *netdev)
+{
+	return ipqess_port_get_bridged_netdev(port) == netdev;
+}
+
+static inline bool
+ipqess_port_offloads_bridge_dev(struct ipqess_port *port,
+				const struct net_device *bridge_dev)
+{
+	/* QCA8K ports connected to a bridge, and event was emitted
+	 * for the bridge.
+	 */
+	return ipqess_port_bridge_dev_get(port) == bridge_dev;
+}
+
+static void ipqess_port_bridge_destroy(struct ipqess_port *port,
+				       const struct net_device *br)
+{
+	struct ipqess_bridge *bridge = port->bridge;
+
+	port->bridge = NULL;
+
+	if (!refcount_dec_and_test(&bridge->refcount))
+		return;
+
+	kfree(bridge);
+}
+
+int ipqess_port_bridge_join(struct ipqess_port *port, struct net_device *br,
+			    struct netlink_ext_ack *extack)
+{
+	struct ipqess_switch *sw = port->sw;
+	struct ipqess_bridge *bridge = NULL;
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *other_port;
+	struct net_device *brport_dev;
+	int port_id = port->index;
+	int port_mask = 0;
+	int i, err;
+
+	/* QCA8K doesn't support MST */
+	if (br_mst_enabled(br)) {
+		err = -EOPNOTSUPP;
+		goto out_err;
+	}
+
+	/* Check if we already registered this bridge with
+	 * another switch port
+	 */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i];
+		if (other_port && other_port->bridge &&
+		    other_port->bridge->netdev == br)
+			bridge = other_port->bridge;
+	}
+
+	if (bridge) {
+		refcount_inc(&bridge->refcount);
+		port->bridge = bridge;
+	} else {
+		err = ipqess_port_bridge_alloc(port, br, extack);
+		if (err)
+			goto out_err;
+	}
+	bridge = port->bridge;
+
+	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i - 1];
+		if (!other_port || !ipqess_port_offloads_bridge(other_port, bridge))
+			continue;
+		/* Add this port to the portvlan mask of the other ports
+		 * in the bridge
+		 */
+		err = regmap_set_bits(priv->regmap,
+				      QCA8K_PORT_LOOKUP_CTRL(i),
+				      BIT(port_id));
+		if (err)
+			goto out_rollback;
+		if (i != port_id)
+			port_mask |= BIT(i);
+	}
+	/* Also add the CPU port */
+	err = regmap_set_bits(priv->regmap,
+			      QCA8K_PORT_LOOKUP_CTRL(0),
+			      BIT(port_id));
+	port_mask |= BIT(0);
+
+	/* Add all other ports to this ports portvlan mask */
+	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+			QCA8K_PORT_LOOKUP_MEMBER, port_mask);
+	if (err)
+		goto out_rollback;
+
+	brport_dev = ipqess_port_get_bridged_netdev(port);
+
+	err = switchdev_bridge_port_offload(brport_dev, port->netdev, port,
+					    &ipqess_switchdev_notifier,
+					    &ipqess_switchdev_blocking_notifier,
+					    false, extack);
+	if (err)
+		goto out_rollback_unbridge;
+
+	err = ipqess_port_switchdev_sync_attrs(port, extack);
+	if (err)
+		goto out_rollback_unoffload;
+
+	return 0;
+
+out_rollback_unoffload:
+	switchdev_bridge_port_unoffload(brport_dev, port,
+					&ipqess_switchdev_notifier,
+					&ipqess_switchdev_blocking_notifier);
+	ipqess_flush_workqueue();
+out_rollback_unbridge:
+	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i - 1];
+		if (!other_port ||
+		    !ipqess_port_offloads_bridge(other_port, port->bridge))
+			continue;
+		/* Remove this port from the portvlan mask of the other ports
+		 * in the bridge
+		 */
+		regmap_clear_bits(priv->regmap,
+				  QCA8K_PORT_LOOKUP_CTRL(i),
+				  BIT(port_id));
+	}
+
+	/* Set the cpu port to be the only one in the portvlan mask of
+	 * this port
+	 */
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+		  QCA8K_PORT_LOOKUP_MEMBER, BIT(0));
+out_rollback:
+	ipqess_port_bridge_destroy(port, br);
+out_err:
+	dev_err(&port->netdev->dev, "Failed to join bridge: errno %d\n", err);
+	return err;
+}
+
+void ipqess_port_bridge_leave(struct ipqess_port *port, struct net_device *br)
+{
+	struct ipqess_bridge *bridge = port->bridge;
+	struct ipqess_switch *sw = port->sw;
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *other_port;
+	int port_id = port->index;
+	int i;
+
+	/* If the port could not be offloaded to begin with, then
+	 * there is nothing to do.
+	 */
+	if (!bridge)
+		return;
+
+	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i - 1];
+		if (!other_port || !ipqess_port_offloads_bridge(other_port, bridge))
+			continue;
+		/* Remove this port from the portvlan mask of the other ports
+		 * in the bridge
+		 */
+		regmap_clear_bits(priv->regmap,
+				  QCA8K_PORT_LOOKUP_CTRL(i),
+				  BIT(port_id));
+	}
+
+	/* Set the cpu port to be the only one in the portvlan mask of
+	 * this port
+	 */
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+		  QCA8K_PORT_LOOKUP_MEMBER, BIT(0));
+
+	ipqess_port_switchdev_unsync_attrs(port, bridge);
+
+	/* Here the port is already unbridged. Reflect the current configuration. */
+
+	ipqess_port_bridge_destroy(port, br);
+}
+
+int ipqess_port_attr_set(struct net_device *dev, const void *ctx,
+			 const struct switchdev_attr *attr,
+			 struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	int ret;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		if (!ipqess_port_offloads_bridge_port(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ipqess_port_set_state_now(port, attr->u.stp_state, true);
+		return 0;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		if (!ipqess_port_offloads_bridge_dev(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = ipqess_port_vlan_filtering(port, attr->u.vlan_filtering,
+						 extack);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
+		if (!ipqess_port_offloads_bridge_dev(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = ipqess_port_ageing_time(port, attr->u.ageing_time);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		if (!ipqess_port_offloads_bridge_port(port, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		return -EINVAL;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
+	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static int ipqess_port_vlan_check_for_8021q_uppers(struct net_device *netdev,
+						   const struct switchdev_obj_port_vlan *vlan)
+{
+	struct net_device *upper_dev;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter) {
+		u16 vid;
+
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		vid = vlan_dev_vlan_id(upper_dev);
+		if (vid == vlan->vid)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int ipqess_port_host_vlan_del(struct net_device *netdev,
+				     const struct switchdev_obj *obj)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct switchdev_obj_port_vlan *vlan;
+
+	/* Do nothing if this is a software bridge */
+	if (!port->bridge)
+		return -EOPNOTSUPP;
+
+	if (br && !br_vlan_enabled(br))
+		return 0;
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	return qca8k_vlan_del(port->sw->priv, 0, vlan->vid);
+}
+
+static int ipqess_port_vlan_del(struct net_device *netdev,
+				const struct switchdev_obj *obj)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct qca8k_priv *priv = port->sw->priv;
+	struct switchdev_obj_port_vlan *vlan;
+	int ret;
+
+	if (br && !br_vlan_enabled(br))
+		return 0;
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	ret = qca8k_vlan_del(priv, port->index, vlan->vid);
+
+	if (ret)
+		dev_err(priv->dev, "Failed to delete VLAN from port %d (%d)\n",
+			port->index, ret);
+
+	return ret;
+}
+
+static int ipqess_port_host_vlan_add(struct net_device *netdev,
+				     const struct switchdev_obj *obj,
+				     struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct switchdev_obj_port_vlan *vlan;
+
+	/* Do nothing is this is a software bridge */
+	if (!port->bridge)
+		return -EOPNOTSUPP;
+
+	if (br && !br_vlan_enabled(br)) {
+		NL_SET_ERR_MSG_MOD(extack, "skipping configuration of VLAN");
+		return 0;
+	}
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	vlan->flags &= ~BRIDGE_VLAN_INFO_PVID;
+
+	/* Add vid to CPU port */
+	return ipqess_port_do_vlan_add(port->sw->priv, 0, vlan, extack);
+}
+
+static int ipqess_port_vlan_add(struct net_device *netdev,
+				const struct switchdev_obj *obj,
+				struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct switchdev_obj_port_vlan *vlan;
+	int err;
+
+	if (br && !br_vlan_enabled(br)) {
+		NL_SET_ERR_MSG_MOD(extack, "skipping configuration of VLAN");
+		return 0;
+	}
+
+	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+	/* Deny adding a bridge VLAN when there is already an 802.1Q upper with
+	 * the same VID.
+	 */
+	if (br && br_vlan_enabled(br)) {
+		rcu_read_lock();
+		err = ipqess_port_vlan_check_for_8021q_uppers(netdev, vlan);
+		rcu_read_unlock();
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Port already has a VLAN upper with this VID");
+			return err;
+		}
+	}
+
+	err = ipqess_port_do_vlan_add(port->sw->priv, port->index, vlan, extack);
+	return err;
+}
+
+static int ipqess_port_host_mdb_del(struct ipqess_port *port,
+				    const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_del(priv, BIT(0), addr, vid);
+}
+
+static int ipqess_port_host_mdb_add(struct ipqess_port *port,
+				    const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_insert(priv, BIT(0), addr, vid,
+					   QCA8K_ATU_STATUS_STATIC);
+}
+
+static int ipqess_port_mdb_del(struct ipqess_port *port,
+			       const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_del(priv, BIT(port->index), addr, vid);
+}
+
+static int ipqess_port_mdb_add(struct ipqess_port *port,
+			       const struct switchdev_obj_port_mdb *mdb)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	const u8 *addr = mdb->addr;
+	u16 vid = mdb->vid;
+
+	return qca8k_fdb_search_and_insert(priv, BIT(port->index), addr, vid,
+					   QCA8K_ATU_STATUS_STATIC);
+}
+
+int ipqess_port_obj_add(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj,
+			struct netlink_ext_ack *extack)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	int err;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		if (!ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_mdb_add(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		if (!ipqess_port_offloads_bridge_dev(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_host_mdb_add(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		if (ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			err = ipqess_port_vlan_add(netdev, obj, extack);
+		else
+			err = ipqess_port_host_vlan_add(netdev, obj, extack);
+		break;
+	case SWITCHDEV_OBJ_ID_MRP:
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	int err;
+
+	if (ctx && ctx != port)
+		return 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		if (!ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_mdb_del(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		if (!ipqess_port_offloads_bridge_dev(port, obj->orig_dev))
+			return -EOPNOTSUPP;
+
+		err = ipqess_port_host_mdb_del(port, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		if (ipqess_port_offloads_bridge_port(port, obj->orig_dev))
+			err = ipqess_port_vlan_del(netdev, obj);
+		else
+			err = ipqess_port_host_vlan_del(netdev, obj);
+		break;
+	case SWITCHDEV_OBJ_ID_MRP:
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int ipqess_cpu_port_fdb_del(struct ipqess_port *port,
+				   const unsigned char *addr, u16 vid)
+{
+	struct ipqess_switch *sw = port->sw;
+	struct ipqess_mac_addr *a = NULL;
+	struct ipqess_mac_addr *other_a;
+	int err = 0;
+
+	mutex_lock(&sw->addr_lists_lock);
+
+	list_for_each_entry(other_a, &sw->fdbs, list)
+		if (ether_addr_equal(other_a->addr, addr) && other_a->vid == vid)
+			a = other_a;
+
+	if (!a) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!refcount_dec_and_test(&a->refcount))
+		goto out;
+
+	err = qca8k_fdb_del(sw->priv, addr, BIT(IPQESS_SWITCH_CPU_PORT), vid);
+	if (err) {
+		refcount_set(&a->refcount, 1);
+		goto out;
+	}
+
+	list_del(&a->list);
+	kfree(a);
+
+out:
+	mutex_unlock(&sw->addr_lists_lock);
+
+	return err;
+}
+
+static int ipqess_cpu_port_fdb_add(struct ipqess_port *port,
+				   const unsigned char *addr, u16 vid)
+{
+	struct ipqess_switch *sw = port->sw;
+	struct ipqess_mac_addr *other_a = NULL;
+	struct ipqess_mac_addr *a = NULL;
+	int err = 0;
+
+	mutex_lock(&sw->addr_lists_lock);
+
+	list_for_each_entry(other_a, &sw->fdbs, list)
+		if (ether_addr_equal(other_a->addr, addr) && other_a->vid == vid)
+			a = other_a;
+
+	if (a) {
+		refcount_inc(&a->refcount);
+		goto out;
+	}
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = qca8k_port_fdb_insert(port->sw->priv, addr,
+				    BIT(IPQESS_SWITCH_CPU_PORT), vid);
+	if (err) {
+		kfree(a);
+		goto out;
+	}
+
+	ether_addr_copy(a->addr, addr);
+	a->vid = vid;
+	refcount_set(&a->refcount, 1);
+	list_add_tail(&a->list, &sw->fdbs);
+
+out:
+	mutex_unlock(&sw->addr_lists_lock);
+
+	return err;
+}
+
+static void
+ipqess_fdb_offload_notify(struct ipqess_switchdev_event_work *switchdev_work)
+{
+	struct switchdev_notifier_fdb_info info = {};
+
+	info.addr = switchdev_work->addr;
+	info.vid = switchdev_work->vid;
+	info.offloaded = true;
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				 switchdev_work->orig_netdev, &info.info, NULL);
+}
+
+void ipqess_port_switchdev_event_work(struct work_struct *work)
+{
+	struct ipqess_switchdev_event_work *switchdev_work =
+		container_of(work, struct ipqess_switchdev_event_work, work);
+	struct net_device *netdev = switchdev_work->netdev;
+	const unsigned char *addr = switchdev_work->addr;
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct ipqess_switch *sw = port->sw;
+	struct qca8k_priv *priv = sw->priv;
+	u16 vid = switchdev_work->vid;
+	int err;
+
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (switchdev_work->host_addr)
+			err = ipqess_cpu_port_fdb_add(port, addr, vid);
+		else
+			err = qca8k_port_fdb_insert(priv, addr, BIT(port->index), vid);
+		if (err) {
+			dev_err(&port->netdev->dev,
+				"port %d failed to add %pM vid %d to fdb: %d\n",
+				port->index, addr, vid, err);
+			break;
+		}
+		ipqess_fdb_offload_notify(switchdev_work);
+		break;
+
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (switchdev_work->host_addr)
+			err = ipqess_cpu_port_fdb_del(port, addr, vid);
+		else
+			err = qca8k_fdb_del(priv, addr, BIT(port->index), vid);
+		if (err) {
+			dev_err(&port->netdev->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				port->index, addr, vid, err);
+		}
+
+		break;
+	}
+
+	kfree(switchdev_work);
+}
+
+int ipqess_port_check_8021q_upper(struct net_device *netdev,
+				  struct netdev_notifier_changeupper_info *info)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct net_device *br = ipqess_port_bridge_dev_get(port);
+	struct bridge_vlan_info br_info;
+	struct netlink_ext_ack *extack;
+	int err = NOTIFY_DONE;
+	u16 vid;
+
+	if (!br || !br_vlan_enabled(br))
+		return NOTIFY_DONE;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+	vid = vlan_dev_vlan_id(info->upper_dev);
+
+	/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
+	 * device, respectively the VID is not found, returning
+	 * 0 means success, which is a failure for us here.
+	 */
+	err = br_vlan_get_info(br, vid, &br_info);
+	if (err == 0) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "This VLAN is already configured by the bridge");
+		return notifier_from_errno(-EBUSY);
+	}
+
+	return NOTIFY_DONE;
+}
+
+/* phylink ops */
+
+static int
+ipqess_psgmii_configure(struct qca8k_priv *priv)
+{
+	int ret;
+
+	if (!atomic_fetch_inc(&priv->psgmii_calibrated)) {
+		dev_warn(priv->dev, "Unable to calibrate PSGMII, link will be unstable!\n");
+
+		ret = regmap_clear_bits(priv->psgmii, PSGMIIPHY_MODE_CONTROL,
+					PSGMIIPHY_MODE_ATHR_CSCO_MODE_25M);
+		ret = regmap_write(priv->psgmii, PSGMIIPHY_TX_CONTROL,
+				   PSGMIIPHY_TX_CONTROL_MAGIC_VALUE);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static void
+ipqess_phylink_mac_config(struct phylink_config *config,
+			  unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
+	struct qca8k_priv *priv = port->sw->priv;
+
+	switch (port->index) {
+	case 0:
+		/* CPU port, no configuration needed */
+		return;
+	case 1:
+	case 2:
+	case 3:
+		if (state->interface == PHY_INTERFACE_MODE_PSGMII)
+			if (ipqess_psgmii_configure(priv))
+				dev_err(priv->dev,
+					"PSGMII configuration failed!\n");
+		return;
+	case 4:
+	case 5:
+		if (phy_interface_mode_is_rgmii(state->interface))
+			regmap_set_bits(priv->regmap,
+					QCA8K_IPQ4019_REG_RGMII_CTRL,
+					QCA8K_IPQ4019_RGMII_CTRL_CLK);
+
+		if (state->interface == PHY_INTERFACE_MODE_PSGMII)
+			if (ipqess_psgmii_configure(priv))
+				dev_err(priv->dev,
+					"PSGMII configuration failed!\n");
+		return;
+	default:
+		dev_err(priv->dev, "%s: unsupported port: %i\n", __func__,
+			port->index);
+		return;
+	}
+}
+
+static void
+ipqess_phylink_mac_link_down(struct phylink_config *config,
+			     unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
+	struct qca8k_priv *priv = port->sw->priv;
+
+	qca8k_port_set_status(priv, port->index, 0);
+}
+
+static void ipqess_phylink_mac_link_up(struct phylink_config *config,
+				       struct phy_device *phydev,
+				       unsigned int mode,
+				       phy_interface_t interface,
+				       int speed, int duplex,
+				       bool tx_pause, bool rx_pause)
+{
+	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
+	struct qca8k_priv *priv = port->sw->priv;
+	u32 reg;
+
+	if (phylink_autoneg_inband(mode)) {
+		reg = QCA8K_PORT_STATUS_LINK_AUTO;
+	} else {
+		switch (speed) {
+		case SPEED_10:
+			reg = QCA8K_PORT_STATUS_SPEED_10;
+			break;
+		case SPEED_100:
+			reg = QCA8K_PORT_STATUS_SPEED_100;
+			break;
+		case SPEED_1000:
+			reg = QCA8K_PORT_STATUS_SPEED_1000;
+			break;
+		default:
+			reg = QCA8K_PORT_STATUS_LINK_AUTO;
+			break;
+		}
+
+		if (duplex == DUPLEX_FULL)
+			reg |= QCA8K_PORT_STATUS_DUPLEX;
+
+		if (rx_pause || port->index == 0)
+			reg |= QCA8K_PORT_STATUS_RXFLOW;
+
+		if (tx_pause || port->index == 0)
+			reg |= QCA8K_PORT_STATUS_TXFLOW;
+	}
+
+	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
+
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), reg);
+}
+
+static const struct phylink_mac_ops ipqess_phylink_mac_ops = {
+	.mac_config = ipqess_phylink_mac_config,
+	.mac_link_down = ipqess_phylink_mac_link_down,
+	.mac_link_up = ipqess_phylink_mac_link_up,
+};
+
+static int ipqess_phylink_create(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct phylink_config *pl_config = &port->pl_config;
+	phy_interface_t mode;
+	struct phylink *pl;
+	int err;
+
+	err = of_get_phy_mode(port->dn, &mode);
+	if (err)
+		mode = PHY_INTERFACE_MODE_NA;
+
+	switch (port->index) {
+	case 1:
+	case 2:
+	case 3:
+		__set_bit(PHY_INTERFACE_MODE_PSGMII,
+			  pl_config->supported_interfaces);
+		break;
+	case 4:
+	case 5:
+		phy_interface_set_rgmii(pl_config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_PSGMII,
+			  pl_config->supported_interfaces);
+		break;
+	case 0: /* CPU port, this shouldn't happen */
+	default:
+		return -EINVAL;
+	}
+	/* phylink caps */
+	pl_config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000FD;
+
+	pl = phylink_create(pl_config, of_fwnode_handle(port->dn),
+			    mode, &ipqess_phylink_mac_ops);
+	if (IS_ERR(pl))
+		return PTR_ERR(pl);
+
+	port->pl = pl;
+	return 0;
+}
+
+static int ipqess_port_phy_connect(struct net_device *netdev, int addr,
+				   u32 flags)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+
+	netdev->phydev = mdiobus_get_phy(port->mii_bus, addr);
+	if (!netdev->phydev) {
+		netdev_err(netdev, "no phy at %d\n", addr);
+		return -ENODEV;
+	}
+
+	netdev->phydev->dev_flags |= flags;
+
+	return phylink_connect_phy(port->pl, netdev->phydev);
+}
+
+static int ipqess_port_phy_setup(struct net_device *netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct device_node *port_dn = port->dn;
+	u32 phy_flags = 0;
+	int ret;
+
+	port->pl_config.dev = &netdev->dev;
+	port->pl_config.type = PHYLINK_NETDEV;
+
+	ret = ipqess_phylink_create(netdev);
+	if (ret)
+		return ret;
+
+	ret = phylink_of_phy_connect(port->pl, port_dn, phy_flags);
+	if (ret == -ENODEV && port->mii_bus) {
+		/* We could not connect to a designated PHY or SFP, so try to
+		 * use the switch internal MDIO bus instead
+		 */
+		ret = ipqess_port_phy_connect(netdev, port->index, phy_flags);
+	}
+	if (ret) {
+		netdev_err(netdev, "failed to connect to PHY: %pe\n",
+			   ERR_PTR(ret));
+		phylink_destroy(port->pl);
+		port->pl = NULL;
+	}
+
+	dev_info(&netdev->dev, "enabled port's phy: %s",
+		 phydev_name(netdev->phydev));
+	return ret;
+}
+
+/* ethtool ops */
+
+static void ipqess_port_get_drvinfo(struct net_device *dev,
+				    struct ethtool_drvinfo *drvinfo)
+{
+	strscpy(drvinfo->driver, "qca8k-ipqess", sizeof(drvinfo->driver));
+	strscpy(drvinfo->fw_version, "N/A", sizeof(drvinfo->fw_version));
+	strscpy(drvinfo->bus_info, "platform", sizeof(drvinfo->bus_info));
+}
+
+static int ipqess_port_nway_reset(struct net_device *dev)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_nway_reset(port->pl);
+}
+
+static int ipqess_port_get_eeprom_len(struct net_device *dev)
+{
+	return 0;
+}
+
+static const char ipqess_gstrings_base_stats[][ETH_GSTRING_LEN] = {
+	"tx_packets",
+	"tx_bytes",
+	"rx_packets",
+	"rx_bytes",
+};
+
+static void ipqess_port_get_strings(struct net_device *dev,
+				    u32 stringset, u8 *data)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	int i;
+
+	if (stringset == ETH_SS_STATS) {
+		memcpy(data, &ipqess_gstrings_base_stats,
+		       sizeof(ipqess_gstrings_base_stats));
+
+		if (stringset != ETH_SS_STATS)
+			return;
+
+		for (i = 0; i < priv->info->mib_count; i++)
+			memcpy(data + (4 + i) * ETH_GSTRING_LEN,
+			       ar8327_mib[i].name,
+			       ETH_GSTRING_LEN);
+
+	} else if (stringset == ETH_SS_TEST) {
+		net_selftest_get_strings(data);
+	}
+}
+
+static void ipqess_port_get_ethtool_stats(struct net_device *dev,
+					  struct ethtool_stats *stats,
+					  uint64_t *data)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+	const struct qca8k_mib_desc *mib;
+	struct pcpu_sw_netstats *s;
+	unsigned int start;
+	u32 reg, c, val;
+	u32 hi = 0;
+	int ret;
+	int i;
+
+	for_each_possible_cpu(i) {
+		u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
+
+		s = per_cpu_ptr(dev->tstats, i);
+		do {
+			start = u64_stats_fetch_begin(&s->syncp);
+			tx_packets = u64_stats_read(&s->tx_packets);
+			tx_bytes = u64_stats_read(&s->tx_bytes);
+			rx_packets = u64_stats_read(&s->rx_packets);
+			rx_bytes = u64_stats_read(&s->rx_bytes);
+		} while (u64_stats_fetch_retry(&s->syncp, start));
+		data[0] += tx_packets;
+		data[1] += tx_bytes;
+		data[2] += rx_packets;
+		data[3] += rx_bytes;
+	}
+
+	for (c = 0; c < priv->info->mib_count; c++) {
+		mib = &ar8327_mib[c];
+		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
+
+		ret = qca8k_read(priv, reg, &val);
+		if (ret < 0)
+			continue;
+
+		if (mib->size == 2) {
+			ret = qca8k_read(priv, reg + 4, &hi);
+			if (ret < 0)
+				continue;
+		}
+
+		data[4 + c] = val;
+		if (mib->size == 2)
+			data[4 + c] |= (u64)hi << 32;
+	}
+}
+
+static int ipqess_port_get_sset_count(struct net_device *dev, int sset)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	struct qca8k_priv *priv = port->sw->priv;
+
+	if (sset == ETH_SS_STATS) {
+		int count = 0;
+
+		if (sset != ETH_SS_STATS)
+			count = 0;
+		else
+			count = priv->info->mib_count;
+
+		if (count < 0)
+			return count;
+
+		return count + 4;
+	} else if (sset == ETH_SS_TEST) {
+		return net_selftest_get_count();
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int ipqess_port_set_wol(struct net_device *dev,
+			       struct ethtool_wolinfo *w)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_set_wol(port->pl, w);
+}
+
+static void ipqess_port_get_wol(struct net_device *dev,
+				struct ethtool_wolinfo *w)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	phylink_ethtool_get_wol(port->pl, w);
+}
+
+static int ipqess_port_set_eee(struct net_device *dev, struct ethtool_eee *eee)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+	int ret;
+	u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port->index);
+	struct qca8k_priv *priv = port->sw->priv;
+	u32 reg;
+
+	/* Port's PHY and MAC both need to be EEE capable */
+	if (!dev->phydev || !port->pl)
+		return -ENODEV;
+
+	mutex_lock(&priv->reg_mutex);
+	ret = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &reg);
+	if (ret < 0) {
+		mutex_unlock(&priv->reg_mutex);
+		return ret;
+	}
+
+	if (eee->eee_enabled)
+		reg |= lpi_en;
+	else
+		reg &= ~lpi_en;
+	ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, reg);
+	mutex_unlock(&priv->reg_mutex);
+
+	if (ret)
+		return ret;
+
+	return phylink_ethtool_set_eee(port->pl, eee);
+}
+
+static int ipqess_port_get_eee(struct net_device *dev, struct ethtool_eee *e)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	/* Port's PHY and MAC both need to be EEE capable */
+	if (!dev->phydev || !port->pl)
+		return -ENODEV;
+
+	return phylink_ethtool_get_eee(port->pl, e);
+}
+
+static int ipqess_port_get_link_ksettings(struct net_device *dev,
+					  struct ethtool_link_ksettings *cmd)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_get(port->pl, cmd);
+}
+
+static int ipqess_port_set_link_ksettings(struct net_device *dev,
+					  const struct ethtool_link_ksettings *cmd)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_set(port->pl, cmd);
+}
+
+static void ipqess_port_get_pauseparam(struct net_device *dev,
+				       struct ethtool_pauseparam *pause)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	phylink_ethtool_get_pauseparam(port->pl, pause);
+}
+
+static int ipqess_port_set_pauseparam(struct net_device *dev,
+				      struct ethtool_pauseparam *pause)
+{
+	struct ipqess_port *port = netdev_priv(dev);
+
+	return phylink_ethtool_set_pauseparam(port->pl, pause);
+}
+
+static const struct ethtool_ops ipqess_port_ethtool_ops = {
+	.get_drvinfo		= ipqess_port_get_drvinfo,
+	.nway_reset		= ipqess_port_nway_reset,
+	.get_link		= ethtool_op_get_link,
+	.get_eeprom_len		= ipqess_port_get_eeprom_len,
+	.get_strings		= ipqess_port_get_strings,
+	.get_ethtool_stats	= ipqess_port_get_ethtool_stats,
+	.get_sset_count		= ipqess_port_get_sset_count,
+	.self_test		= net_selftest,
+	.set_wol		= ipqess_port_set_wol,
+	.get_wol		= ipqess_port_get_wol,
+	.set_eee		= ipqess_port_set_eee,
+	.get_eee		= ipqess_port_get_eee,
+	.get_link_ksettings	= ipqess_port_get_link_ksettings,
+	.set_link_ksettings	= ipqess_port_set_link_ksettings,
+	.get_pauseparam		= ipqess_port_get_pauseparam,
+	.set_pauseparam		= ipqess_port_set_pauseparam,
+};
+
+/* netlink */
+
+#define IFLA_IPQESS_UNSPEC 0
+#define IFLA_IPQESS_MAX 0
+
+static const struct nla_policy ipqess_port_policy[IFLA_IPQESS_MAX + 1] = {
+	[IFLA_IPQESS_MAX] = { .type = NLA_U32 },
+};
+
+static size_t ipqess_port_get_size(const struct net_device *dev)
+{
+	return nla_total_size(sizeof(u32));
+}
+
+static int ipqess_port_fill_info(struct sk_buff *skb,
+				 const struct net_device *dev)
+{
+	if (nla_put_u32(skb, IFLA_IPQESS_UNSPEC, dev->ifindex))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static struct rtnl_link_ops ipqess_port_link_ops __read_mostly = {
+	.kind         = "switch",
+	.priv_size    = sizeof(struct ipqess_port),
+	.maxtype      = 1,
+	.policy       = ipqess_port_policy,
+	.get_size     = ipqess_port_get_size,
+	.fill_info    = ipqess_port_fill_info,
+	.netns_refund = true,
+};
+
+/* devlink */
+
+static int ipqess_port_devlink_setup(struct ipqess_port *port)
+{
+	struct devlink_port *dlp = &port->devlink_port;
+	struct devlink *dl = port->sw->devlink;
+	struct devlink_port_attrs attrs = {};
+	unsigned int index = 0;
+	const unsigned char *id = (const unsigned char *)&index;
+	unsigned char len = sizeof(index);
+	int err;
+
+	memset(dlp, 0, sizeof(*dlp));
+	devlink_port_init(dl, dlp);
+
+	attrs.phys.port_number = port->index;
+	memcpy(attrs.switch_id.id, id, len);
+	attrs.switch_id.id_len = len;
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	devlink_port_attrs_set(dlp, &attrs);
+
+	err = devlink_port_register(dl, dlp, port->index);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* register */
+
+int ipqess_port_register(struct ipqess_switch *sw,
+			 struct device_node *port_node)
+{
+	struct qca8k_priv *priv = sw->priv;
+	struct net_device *netdev;
+	struct ipqess_port *port;
+	const char *name;
+	int assign_type;
+	int num_queues;
+	u32 index;
+	int err;
+
+	err = of_property_read_u32(port_node, "reg", &index);
+	if (err) {
+		pr_err("Node without reg property!");
+		return err;
+	}
+
+	name = of_get_property(port_node, "label", NULL);
+	if (!name) {
+		name = "eth%d";
+		assign_type = NET_NAME_ENUM;
+	} else {
+		assign_type = NET_NAME_PREDICTABLE;
+	}
+
+	/* For the NAPI leader, we allocate one queue per MAC queue */
+	if (!sw->napi_leader)
+		num_queues = IPQESS_EDMA_NETDEV_QUEUES;
+	else
+		num_queues = 1;
+
+	netdev = alloc_netdev_mqs(sizeof(struct ipqess_port), name, assign_type,
+				  ether_setup, num_queues, num_queues);
+	if (!netdev)
+		return -ENOMEM;
+
+	if (!sw->napi_leader)
+		sw->napi_leader = netdev;
+
+	port = netdev_priv(netdev);
+	port->index = (int)index;
+	port->dn = port_node;
+	port->netdev = netdev;
+	port->edma = NULL; /* Assigned during edma initialization */
+	port->qid = port->index - 1;
+	port->sw = sw;
+	port->bridge = NULL;
+
+	of_get_mac_address(port_node, port->mac);
+	if (!is_zero_ether_addr(port->mac))
+		eth_hw_addr_set(netdev, port->mac);
+	else
+		eth_hw_addr_random(netdev);
+
+	netdev->netdev_ops = &ipqess_port_netdev_ops;
+	netdev->max_mtu = QCA8K_MAX_MTU;
+	SET_NETDEV_DEVTYPE(netdev, &ipqess_port_type);
+	SET_NETDEV_DEV(netdev, priv->dev);
+	SET_NETDEV_DEVLINK_PORT(netdev, &port->devlink_port);
+	netdev->dev.of_node = port->dn;
+
+	netdev->rtnl_link_ops = &ipqess_port_link_ops;
+	netdev->ethtool_ops = &ipqess_port_ethtool_ops;
+
+	netdev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!netdev->tstats) {
+		free_netdev(netdev);
+		return -ENOMEM;
+	}
+
+	err = ipqess_port_devlink_setup(port);
+	if (err)
+		goto out_free;
+
+	err = gro_cells_init(&port->gcells, netdev);
+	if (err)
+		goto out_devlink;
+
+	err = ipqess_port_phy_setup(netdev);
+	if (err) {
+		pr_err("error setting up PHY: %d\n", err);
+		goto out_gcells;
+	}
+
+	/* We use the qid and not the index because port 0 isn't registered */
+	sw->port_list[port->qid] = port;
+
+	rtnl_lock();
+
+	err = register_netdevice(netdev);
+	if (err) {
+		pr_err("error %d registering interface %s\n",
+		       err, netdev->name);
+		rtnl_unlock();
+		goto out_phy;
+	}
+
+	rtnl_unlock();
+
+	return 0;
+
+out_phy:
+	rtnl_lock();
+	phylink_disconnect_phy(port->pl);
+	rtnl_unlock();
+	phylink_destroy(port->pl);
+	port->pl = NULL;
+out_gcells:
+	gro_cells_destroy(&port->gcells);
+out_devlink:
+	devlink_port_unregister(&port->devlink_port);
+out_free:
+	free_percpu(netdev->tstats);
+	free_netdev(netdev);
+	sw->port_list[port->qid] = NULL;
+	return err;
+}
+
+void ipqess_port_unregister(struct ipqess_port *port)
+{
+	struct net_device *netdev = port->netdev;
+
+	unregister_netdev(netdev);
+
+	devlink_port_unregister(&port->devlink_port);
+
+	rtnl_lock();
+	phylink_disconnect_phy(port->pl);
+	rtnl_unlock();
+	phylink_destroy(port->pl);
+	port->pl = NULL;
+
+	gro_cells_destroy(&port->gcells);
+
+	free_percpu(netdev->tstats);
+	free_netdev(netdev);
+}
+
+/* Utilities */
+
+/* Returns true if any port of this switch offloads the given net_device */
+static bool ipqess_switch_offloads_bridge_port(struct ipqess_switch *sw,
+					       const struct net_device *netdev)
+{
+	struct ipqess_port *port;
+	int i;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port && ipqess_port_offloads_bridge_port(port, netdev))
+			return true;
+	}
+
+	return false;
+}
+
+/* Returns true if any port of this switch offloads the given bridge */
+static inline bool
+ipqess_switch_offloads_bridge_dev(struct ipqess_switch *sw,
+				  const struct net_device *bridge_dev)
+{
+	struct ipqess_port *port;
+	int i;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port && ipqess_port_offloads_bridge_dev(port, bridge_dev))
+			return true;
+	}
+
+	return false;
+}
+
+bool ipqess_port_recognize_netdev(const struct net_device *netdev)
+{
+	return netdev->netdev_ops == &ipqess_port_netdev_ops;
+}
+
+bool ipqess_port_dev_is_foreign(const struct net_device *netdev,
+				const struct net_device *foreign_netdev)
+{
+	struct ipqess_port *port = netdev_priv(netdev);
+	struct ipqess_switch *sw = port->sw;
+
+	if (netif_is_bridge_master(foreign_netdev))
+		return !ipqess_switch_offloads_bridge_dev(sw, foreign_netdev);
+
+	if (netif_is_bridge_port(foreign_netdev))
+		return !ipqess_switch_offloads_bridge_port(sw, foreign_netdev);
+
+	/* Everything else is foreign */
+	return true;
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
new file mode 100644
index 000000000000..a0639933e8bb
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 OR ISC */
+
+#ifndef IPQESS_PORT_H
+#define IPQESS_PORT_H
+
+#include <net/gro_cells.h>
+#include <net/devlink.h>
+
+#include "ipqess_edma.h"
+#include "ipqess_switch.h"
+
+struct ipqess_bridge {
+	struct net_device *netdev;
+	refcount_t refcount;
+};
+
+struct ipqess_port {
+	u16 index;
+	u16 qid;
+
+	struct ipqess_edma *edma;
+	struct ipqess_switch *sw;
+	struct phylink *pl;
+	struct phylink_config pl_config;
+	struct device_node *dn;
+	struct mii_bus *mii_bus;
+	struct net_device *netdev;
+	struct ipqess_bridge *bridge;
+	struct devlink_port devlink_port;
+
+	u8       stp_state;
+
+	u8       mac[ETH_ALEN];
+
+	/* Warning: the following bit field is not atomic, and updating it
+	 * can only be done from code paths where concurrency is not possible
+	 * (probe time or under rtnl_lock).
+	 */
+	u8			vlan_filtering:1;
+
+	unsigned int		ageing_time;
+
+	struct gro_cells	gcells;
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	struct netpoll		*netpoll;
+#endif
+};
+
+struct ipqess_port_dump_ctx {
+	struct net_device *dev;
+	struct sk_buff *skb;
+	struct netlink_callback *cb;
+	int idx;
+};
+
+struct ipqess_mac_addr {
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	refcount_t refcount;
+	struct list_head list;
+};
+
+int ipqess_port_register(struct ipqess_switch *sw,
+			 struct device_node *port_node);
+void ipqess_port_unregister(struct ipqess_port *port);
+
+bool ipqess_port_recognize_netdev(const struct net_device *netdev);
+bool ipqess_port_dev_is_foreign(const struct net_device *netdev,
+				const struct net_device *foreign_netdev);
+
+int ipqess_port_bridge_join(struct ipqess_port *port, struct net_device *br,
+			    struct netlink_ext_ack *extack);
+void ipqess_port_bridge_leave(struct ipqess_port *port, struct net_device *br);
+
+int ipqess_port_attr_set(struct net_device *dev, const void *ctx,
+			 const struct switchdev_attr *attr,
+			 struct netlink_ext_ack *extack);
+
+void ipqess_port_switchdev_event_work(struct work_struct *work);
+
+int ipqess_port_check_8021q_upper(struct net_device *netdev,
+				  struct netdev_notifier_changeupper_info *info);
+
+struct net_device *ipqess_port_get_bridged_netdev(const struct ipqess_port *port);
+
+int ipqess_port_obj_add(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj,
+			struct netlink_ext_ack *extack);
+int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
+			const struct switchdev_obj *obj);
+
+bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
+				      const struct net_device *netdev);
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
new file mode 100644
index 000000000000..45e83a8965be
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
+ * Based on net/dsa
+ */
+
+#include <linux/dsa/qca8k.h>
+#include <linux/of_platform.h>
+#include <linux/of_mdio.h>
+#include <linux/reset.h>
+
+#include "ipqess_switch.h"
+#include "ipqess_port.h"
+#include "ipqess_edma.h"
+
+static struct regmap_config qca8k_ipqess_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x16ac, /* end MIB - Port6 range */
+	.rd_table = &qca8k_readable_table,
+};
+
+static struct regmap_config qca8k_ipqess_psgmii_phy_regmap_config = {
+	.name = "psgmii-phy",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x7fc,
+};
+
+static const struct qca8k_match_data ipqess = {
+	.id = IPQESS_SWITCH_ID,
+	.mib_count = QCA8K_QCA833X_MIB_COUNT,
+};
+
+/* devlink */
+
+static const struct devlink_ops ipqess_devlink_ops = {
+	/* no ops supported by this driver */
+};
+
+static int ipqess_switch_devlink_alloc(struct ipqess_switch *sw)
+{
+	struct ipqess_devlink_priv *dl_priv;
+	struct devlink *dl;
+
+	/* Add the switch to devlink before calling setup, so that setup can
+	 * add dpipe tables
+	 */
+	dl = devlink_alloc(&ipqess_devlink_ops, sizeof(*dl_priv), sw->priv->dev);
+	if (!dl)
+		return -ENOMEM;
+
+	sw->devlink = dl;
+
+	dl_priv = devlink_priv(sw->devlink);
+	dl_priv->sw = sw;
+
+	return 0;
+}
+
+/* setup */
+
+unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
+					       unsigned int ageing_time)
+{
+	struct ipqess_port *port;
+	int i;
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port && port->ageing_time && port->ageing_time < ageing_time)
+			ageing_time = port->ageing_time;
+	}
+
+	return ageing_time;
+}
+
+int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs)
+{
+	struct qca8k_priv *priv = sw->priv;
+	unsigned int secs = msecs / 1000;
+	u32 val;
+
+	/* AGE_TIME reg is set in 7s step */
+	val = secs / 7;
+
+	/* Handle case with 0 as val to NOT disable
+	 * learning
+	 */
+	if (!val)
+		val = 1;
+
+	return regmap_update_bits(priv->regmap, QCA8K_REG_ATU_CTRL,
+				  QCA8K_ATU_AGE_TIME_MASK,
+				  QCA8K_ATU_AGE_TIME(val));
+}
+
+static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct qca8k_pcs, pcs);
+}
+
+static void ipqess_switch_pcs_get_state(struct phylink_pcs *pcs,
+					struct phylink_link_state *state)
+{
+	struct qca8k_priv *priv = pcs_to_qca8k_pcs(pcs)->priv;
+	int port = pcs_to_qca8k_pcs(pcs)->port;
+	u32 reg;
+	int ret;
+
+	ret = qca8k_read(priv, QCA8K_REG_PORT_STATUS(port), &reg);
+	if (ret < 0) {
+		state->link = false;
+		return;
+	}
+
+	state->link = !!(reg & QCA8K_PORT_STATUS_LINK_UP);
+	state->an_complete = state->link;
+	state->duplex = (reg & QCA8K_PORT_STATUS_DUPLEX) ? DUPLEX_FULL :
+							DUPLEX_HALF;
+
+	switch (reg & QCA8K_PORT_STATUS_SPEED) {
+	case QCA8K_PORT_STATUS_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	case QCA8K_PORT_STATUS_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case QCA8K_PORT_STATUS_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	if (reg & QCA8K_PORT_STATUS_RXFLOW)
+		state->pause |= MLO_PAUSE_RX;
+	if (reg & QCA8K_PORT_STATUS_TXFLOW)
+		state->pause |= MLO_PAUSE_TX;
+}
+
+static int ipqess_switch_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+				    phy_interface_t interface,
+				    const unsigned long *advertising,
+				    bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static void ipqess_switch_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static const struct phylink_pcs_ops qca8k_pcs_ops = {
+	.pcs_get_state = ipqess_switch_pcs_get_state,
+	.pcs_config = ipqess_switch_pcs_config,
+	.pcs_an_restart = ipqess_switch_pcs_an_restart,
+};
+
+static void ipqess_switch_setup_pcs(struct qca8k_priv *priv,
+				    struct qca8k_pcs *qpcs,
+				    int port_index)
+{
+	qpcs->pcs.ops = &qca8k_pcs_ops;
+
+	/* We don't have interrupts for link changes, so we need to poll */
+	qpcs->pcs.poll = true;
+	qpcs->priv = priv;
+	qpcs->port = port_index;
+}
+
+static int ipqess_switch_setup_port(struct ipqess_switch *sw, int port_index)
+{
+	struct qca8k_priv *priv = sw->priv;
+	u32 mask = 0;
+	int ret, i;
+	u32 reg;
+
+	/* CPU port gets connected to all registered ports of the switch */
+	if (port_index == IPQESS_SWITCH_CPU_PORT) {
+		for (i = 1; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+			if (sw->port_list[i - 1])
+				mask |= BIT(i);
+		}
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				QCA8K_PORT_LOOKUP_MEMBER, mask);
+		if (ret)
+			return ret;
+		qca8k_read(priv, QCA8K_PORT_LOOKUP_CTRL(IPQESS_SWITCH_CPU_PORT), &reg);
+
+		/* Disable CPU ARP Auto-learning by default */
+		ret = regmap_clear_bits(priv->regmap,
+					QCA8K_PORT_LOOKUP_CTRL(port_index),
+					QCA8K_PORT_LOOKUP_LEARN);
+		if (ret)
+			return ret;
+	}
+
+	/* Individual user ports get connected to CPU port only */
+	if (port_index > 0 && sw->port_list[port_index - 1]) {
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				QCA8K_PORT_LOOKUP_MEMBER,
+				BIT(IPQESS_SWITCH_CPU_PORT));
+		if (ret)
+			return ret;
+
+		/* Enable ARP Auto-learning by default */
+		ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port_index),
+				      QCA8K_PORT_LOOKUP_LEARN);
+		if (ret)
+			return ret;
+
+		/* For port based vlans to work we need to set the
+		 * default egress vid
+		 */
+		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
+				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
+				QCA8K_EGREES_VLAN_PORT(port_index, QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
+				  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
+				  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int ipqess_switch_setup(struct ipqess_switch *sw)
+{
+	struct qca8k_priv *priv = sw->priv;
+	int ret, i;
+	u32 reg;
+
+	ipqess_switch_setup_pcs(priv, &priv->pcs_port_0, 0);
+
+	/* Enable CPU Port */
+	ret = regmap_set_bits(priv->regmap, QCA8K_REG_GLOBAL_FW_CTRL0,
+			      QCA8K_GLOBAL_FW_CTRL0_CPU_PORT_EN);
+	if (ret) {
+		dev_err(priv->dev, "failed enabling CPU port");
+		return ret;
+	}
+
+	/* Enable MIB counters */
+	ret = qca8k_mib_init(priv);
+	if (ret)
+		dev_warn(priv->dev, "MIB init failed");
+
+	/* Disable forwarding by default on all ports */
+	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
+				QCA8K_PORT_LOOKUP_MEMBER, 0);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable QCA header mode on the CPU port */
+	ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(IPQESS_SWITCH_CPU_PORT),
+			  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
+			  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
+	if (ret) {
+		dev_err(priv->dev, "failed enabling QCA header mode");
+		return ret;
+	}
+
+	/* Disable MAC by default on all ports */
+	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
+		if (i > 0)
+			qca8k_port_set_status(priv, i, 0);
+	}
+
+	/* Forward all unknown frames to all ports */
+	ret = qca8k_write(priv, QCA8K_REG_GLOBAL_FW_CTRL1,
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, 0x3f) |
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, 0x3f) |
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, 0x3f) |
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, 0x3f));
+	if (ret) {
+		pr_err("Error while disabling MAC and forwarding unknown frames %d\n",
+		       ret);
+		return ret;
+	}
+
+	/* Setup connection between CPU port & user ports */
+	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
+		ret = ipqess_switch_setup_port(sw, i);
+		if (ret)
+			return ret;
+	}
+
+	/* Setup our port MTUs to match power on defaults */
+	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ETH_FRAME_LEN + ETH_FCS_LEN);
+	if (ret)
+		dev_warn(priv->dev, "failed setting MTU settings");
+
+	/* Flush the FDB table */
+	qca8k_fdb_flush(priv);
+
+	if (ret < 0)
+		goto devlink_free;
+
+	/* set Port0 status */
+	reg  = QCA8K_PORT_STATUS_LINK_AUTO;
+	reg |= QCA8K_PORT_STATUS_DUPLEX;
+	reg |= QCA8K_PORT_STATUS_SPEED_1000;
+	reg |= QCA8K_PORT_STATUS_RXFLOW;
+	reg |= QCA8K_PORT_STATUS_TXFLOW;
+	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(0), reg);
+	sw->port0_enabled = true;
+
+	return 0;
+
+devlink_free:
+	pr_err("qca_switch_setup error: %d\n", ret);
+	return ret;
+}
+EXPORT_SYMBOL(ipqess_switch_setup);
+
+/* probe */
+
+static void ipqess_switch_psgmii_rst(struct ipqess_switch *sw)
+{
+	reset_control_assert(sw->psgmii_rst);
+
+	mdelay(10);
+
+	reset_control_deassert(sw->psgmii_rst);
+
+	mdelay(10);
+}
+
+static int ipqess_switch_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node, *mdio_np, *psgmii_ethphy_np;
+	struct device_node *ports, *port_np;
+	struct ipqess_port *port = NULL;
+	void __iomem *base, *psgmii;
+	struct ipqess_switch *sw;
+	struct qca8k_priv *priv;
+	int ret;
+	int i;
+
+	sw = devm_kzalloc(dev, sizeof(struct ipqess_switch), GFP_KERNEL);
+	if (!sw)
+		return -ENOMEM;
+
+	priv = devm_kzalloc(dev, sizeof(struct qca8k_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	sw->priv = priv;
+	sw->port0_enabled = false;
+	priv->dev = dev;
+	priv->info = &ipqess;
+	priv->ds = NULL;
+
+	ports = of_get_child_by_name(np, "ports");
+	if (!ports) {
+		dev_err(dev, "no 'ports' attribute found\n");
+		return -EINVAL;
+	}
+
+	/* Start by setting up the register mapping */
+	base = devm_platform_ioremap_resource_byname(pdev, "base");
+	if (IS_ERR(base)) {
+		dev_err(dev, "platform ioremap fail %li\n", PTR_ERR(base));
+		return PTR_ERR(base);
+	}
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &qca8k_ipqess_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err(dev, "base regmap initialization failed, %d\n", ret);
+		return ret;
+	}
+
+	psgmii = devm_platform_ioremap_resource_byname(pdev, "psgmii_phy");
+	if (IS_ERR(psgmii)) {
+		dev_err(dev, "platform ioremap psgmii fail %li\n", PTR_ERR(psgmii));
+		return PTR_ERR(psgmii);
+	}
+
+	priv->psgmii = devm_regmap_init_mmio(dev, psgmii,
+					     &qca8k_ipqess_psgmii_phy_regmap_config);
+	if (IS_ERR(priv->psgmii)) {
+		ret = PTR_ERR(priv->psgmii);
+		dev_err(dev, "PSGMII regmap initialization failed, %d\n", ret);
+		return ret;
+	}
+
+	mdio_np = of_parse_phandle(np, "mdio", 0);
+	if (!mdio_np) {
+		dev_err(dev, "unable to get MDIO bus phandle\n");
+		of_node_put(mdio_np);
+		return -EINVAL;
+	}
+
+	priv->bus = of_mdio_find_bus(mdio_np);
+	of_node_put(mdio_np);
+	if (!priv->bus) {
+		dev_err(dev, "unable to find MDIO bus\n");
+		return -EPROBE_DEFER;
+	}
+
+	psgmii_ethphy_np = of_parse_phandle(np, "psgmii-ethphy", 0);
+	if (!psgmii_ethphy_np) {
+		dev_warn(dev, "unable to get PSGMII eth PHY phandle\n");
+		of_node_put(psgmii_ethphy_np);
+	}
+
+	if (psgmii_ethphy_np) {
+		priv->psgmii_ethphy = of_phy_find_device(psgmii_ethphy_np);
+		of_node_put(psgmii_ethphy_np);
+		if (!priv->psgmii_ethphy) {
+			dev_err(dev, "unable to get PSGMII eth PHY\n");
+			return -ENODEV;
+		}
+	}
+
+	/* If we don't reset the PSGMII here the switch id check will fail */
+	sw->psgmii_rst = devm_reset_control_get(&pdev->dev, "psgmii_rst");
+	if (IS_ERR(sw->psgmii_rst)) {
+		ret = PTR_ERR(sw->psgmii_rst);
+		dev_err(dev, "Unable to get PSGMII reset line: err %d\n", ret);
+		return ret;
+	}
+
+	ipqess_switch_psgmii_rst(sw);
+
+	/* Check the detected switch id */
+	ret = qca8k_read_switch_id(sw->priv);
+	if (ret) {
+		dev_err(dev, "Failed to read switch id! error %d\n", ret);
+		return ret;
+	}
+
+	priv->ds = NULL;
+
+	mutex_init(&sw->addr_lists_lock);
+	INIT_LIST_HEAD(&sw->fdbs);
+	INIT_LIST_HEAD(&sw->mdbs);
+
+	mutex_init(&priv->reg_mutex);
+	platform_set_drvdata(pdev, sw);
+
+	ret = ipqess_switch_devlink_alloc(sw);
+	if (ret)
+		goto out_devlink;
+
+	devlink_register(sw->devlink);
+
+	/* Register switch front-facing ports */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++)
+		sw->port_list[i] = NULL;
+
+	for_each_available_child_of_node(ports, port_np) {
+		ret = ipqess_port_register(sw, port_np);
+		if (ret) {
+			pr_err("Failed to register ipqess port! error %d\n", ret);
+			goto out_ports;
+		}
+	}
+	if (!sw->napi_leader) {
+		pr_err("No switch port registered as napi leader!\n");
+		ret = -EINVAL;
+		goto out_ports;
+	}
+
+	ret = ipqess_edma_init(pdev, np);
+	if (ret) {
+		dev_err(dev, "Failed to initialize EDMA controller! error %d\n", ret);
+		goto out_ports;
+	}
+
+	ipqess_switch_setup(sw);
+
+	return 0;
+
+out_ports:
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port)
+			ipqess_port_unregister(port);
+	}
+out_devlink:
+	devlink_free(sw->devlink);
+	pr_err("%s failed with error %d\n", __func__, ret);
+	return ret;
+}
+
+static int
+ipqess_switch_remove(struct platform_device *pdev)
+{
+	struct ipqess_switch *sw = platform_get_drvdata(pdev);
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *port = NULL;
+	int i;
+
+	if (!sw)
+		return 0;
+
+	/* Release EDMA driver */
+	ipqess_edma_uninit(sw->edma);
+
+	/* Disable all user ports */
+	for (i = 1; i < QCA8K_NUM_PORTS; i++) {
+		qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
+			  QCA8K_PORT_LOOKUP_STATE_MASK,
+			  QCA8K_PORT_LOOKUP_STATE_DISABLED);
+			  qca8k_port_set_status(priv, i, 0);
+			  priv->port_enabled_map &= ~BIT(i);
+	}
+
+	/* Unregister user ports */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		port = sw->port_list[i];
+		if (port)
+			ipqess_port_unregister(port);
+	}
+
+	devlink_unregister(sw->devlink);
+	devlink_free(sw->devlink);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id qca8k_ipqess_of_match[] = {
+	{ .compatible = "qca,ipq4019-qca8337n", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver qca8k_ipqess_driver = {
+	.probe = ipqess_switch_probe,
+	.remove = ipqess_switch_remove,
+	.driver = {
+		.name = "ipqess",
+		.of_match_table = qca8k_ipqess_of_match,
+	},
+};
+
+module_platform_driver(qca8k_ipqess_driver);
+
+MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.org>");
+MODULE_AUTHOR("Mathieu Olivari, John Crispin <john@phrozen.org>");
+MODULE_AUTHOR("Gabor Juhos <j4g8y7@gmail.com>, Robert Marko <robert.marko@sartura.hr>");
+MODULE_DESCRIPTION("Qualcomm IPQ4019 Ethernet Switch Subsystem driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
new file mode 100644
index 000000000000..e86674c2947e
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 OR ISC */
+
+#ifndef IPQESS_SWITCH_H
+#define IPQESS_SWITCH_H
+
+#include <linux/dsa/qca8k.h>
+
+#define IPQESS_SWITCH_MAX_PORTS       5
+#define IPQESS_SWITCH_AGEING_TIME_MIN 7000
+#define IPQESS_SWITCH_AGEING_TIME_MAX 458745000
+#define IPQESS_SWITCH_CPU_PORT        0
+#define IPQESS_SWITCH_NUM_PORTS       5
+#define IPQESS_SWITCH_ID              0x14
+
+struct ipqess_switch {
+	struct net_device *napi_leader;
+	struct qca8k_priv *priv;
+	struct ipqess_edma *edma;
+	struct ipqess_port *port_list[IPQESS_SWITCH_MAX_PORTS];
+	struct devlink *devlink;
+	struct reset_control *psgmii_rst;
+	bool port0_enabled;
+
+	/* List of MAC addresses that must be forwarded on the cpu port */
+	struct mutex		addr_lists_lock;
+	struct list_head	fdbs;
+	struct list_head	mdbs;
+};
+
+struct ipqess_devlink_priv {
+	struct ipqess_switch *sw;
+};
+
+unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
+					       unsigned int ageing_time);
+int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs);
+
+int ipqess_switch_setup(struct ipqess_switch *sw);
+
+#endif
-- 
2.42.0

