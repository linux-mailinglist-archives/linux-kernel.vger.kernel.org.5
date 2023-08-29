Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3F78C3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjH2MM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjH2MMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:12:21 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D51BD;
        Tue, 29 Aug 2023 05:12:07 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DF05C864ED;
        Tue, 29 Aug 2023 14:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693311121;
        bh=jFJQ50X2AFBWSNbZw+YysF9ezLyf8E4OzqdfmYtXJFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfsQeTQbGlc2fX/bXjUGe07wUDOtzxb1esXutT3+P0vPbtAOCal5VJXSbSwm8nmn5
         WfHOOBrtu0Ld7iBhPC8upuxsfNdmWFXuyrG9rfhDc++LnH8M1WVl229bL3J/N+nd7k
         tYYJSI8G9J+PMvIvqShRES1QOQVrDMaLxU5QXygJmayMsDLBO5INlhMKR727+DA0yb
         yHn4/DlnCY3gkc8Tgpl/UnQauCNOMAt3ZxWQqgjd+Sd27Pkel5FbnB+DOHjEqgnFan
         LjvD54wAmAyrv/Ntx8KXwjjYOQHsm9GVlza9BeOKllFZrB2BEKZs5UKeO+CnMEJDGF
         2cCLyfsPmjCZw==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
Date:   Tue, 29 Aug 2023 14:11:31 +0200
Message-Id: <20230829121132.414335-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829121132.414335-1-lukma@denx.de>
References: <20230829121132.414335-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds functions for providing in KSZ9477 switch HSR
(High-availability Seamless Redundancy) hardware offloading.

According to AN3474 application note following features are provided:
- TX packet duplication from host to switch (NETIF_F_HW_HSR_DUP)
- RX packet duplication discarding
- Prevention of packet loop

For last two ones - there is a probability that some packets will not
be filtered in HW (in some special cases). Hence, the HSR core code
shall be used to discard those not caught frames.

Moreover, some switch registers adjustments are required - like setting
MAC address of HSR network interface.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/dsa/microchip/ksz9477.c | 96 +++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h |  4 ++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 2bf88c2e32a0..bf84c70e675d 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1207,6 +1207,102 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 	return ksz_pwrite16(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
 }
 
+/* The KSZ9477 provides following HW features to accelerate
+ * HSR frames handling:
+ *
+ * 1. TX PACKET DUPLICATION FROM HOST TO SWITCH
+ * 2. RX PACKET DUPLICATION DISCARDING
+ * 3. PREVENTING PACKET LOOP IN THE RING BY SELF-ADDRESS FILTERING
+ *
+ * Only one from point 1. has the NETIF_F* flag available.
+ *
+ * Ones from point 2 and 3 are "best effort" - i.e. those will
+ * work correctly most of the time, but it may happen that some
+ * frames will not be caught. Hence, the SW needs to handle those
+ * special cases. However, the speed up gain is considerable when
+ * above features are used.
+ */
+#define KSZ9477_SUPPORTED_HSR_FEATURES NETIF_F_HW_HSR_DUP
+
+int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
+		     struct dsa_port *partner)
+{
+	struct ksz_device *dev = ds->priv;
+	struct net_device *slave;
+	u8 i, data;
+	int ret;
+
+	/* Program which ports shall support HSR */
+	ds->hsr_ports = BIT(port) | BIT(partner->index);
+	ksz_write32(dev, REG_HSR_PORT_MAP__4, ds->hsr_ports);
+
+	/* Enable discarding of received HSR frames */
+	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
+	data |= HSR_DUPLICATE_DISCARD;
+	data &= ~HSR_NODE_UNICAST;
+	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
+
+	/* Self MAC address filtering for HSR frames to avoid
+	 * traverse of the HSR ring more than once.
+	 *
+	 * The HSR port (i.e. hsr0) MAC address is used.
+	 */
+	if (!is_valid_ether_addr(hsr->dev_addr)) {
+		dev_err(dev->dev,
+			"Set valid MAC address to %s for HSR operation!",
+			hsr->name);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ETH_ALEN; i++) {
+		ret = ksz_write8(dev, REG_SW_MAC_ADDR_0 + i, hsr->dev_addr[i]);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable global self-address filtering if not yet done during switch
+	 * start
+	 */
+	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data);
+	if (!(data & SW_SRC_ADDR_FILTER)) {
+		data |= SW_SRC_ADDR_FILTER;
+		ksz_write8(dev, REG_SW_LUE_CTRL_1, data);
+	}
+
+	/* Enable per port self-address filtering */
+	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
+	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
+		     PORT_SRC_ADDR_FILTER, true);
+
+	/* Setup HW supported features for lan HSR ports */
+	slave = dsa_to_port(ds, port)->slave;
+	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+
+	slave = dsa_to_port(ds, partner->index)->slave;
+	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+
+	pr_debug("%s: HSR join port: %d partner: %d port_map: 0x%x\n", __func__,
+		 port, partner->index, ds->hsr_ports);
+
+	return 0;
+}
+
+int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr,
+		      struct dsa_port *partner)
+{
+	struct ksz_device *dev = ds->priv;
+
+	/* Clear ports HSR support */
+	ksz_write32(dev, REG_HSR_PORT_MAP__4, 0);
+
+	/* Disable per port self-address filtering */
+	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
+	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
+		     PORT_SRC_ADDR_FILTER, false);
+
+	return 0;
+}
+
 int ksz9477_switch_init(struct ksz_device *dev)
 {
 	u8 data8;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index b6f7e3c46e3f..634262efb73c 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -58,5 +58,9 @@ int ksz9477_dsa_init(struct ksz_device *dev);
 int ksz9477_switch_init(struct ksz_device *dev);
 void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
+int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
+		     struct dsa_port *partner);
+int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr,
+		      struct dsa_port *partner);
 
 #endif
-- 
2.20.1

