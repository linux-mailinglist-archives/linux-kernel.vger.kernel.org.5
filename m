Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E4794061
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbjIFP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjIFP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:28:26 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF721172C;
        Wed,  6 Sep 2023 08:28:21 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3B75586963;
        Wed,  6 Sep 2023 17:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694014100;
        bh=9O91EQl7isO1fgXjXzNLJbAgPm/VBWaOv1dXBxnmRCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pdxeta8GtDesIhInn1iM2ycVC0WKMpfswyJOUWtigkZTrj2HohR7FbS9quPMc4ecH
         jpClkO77m/UJ0FibttF7RzqRh6VxyL3LjthFaa/DkfJXXAEiihq6eyKuYlZu33Kn3N
         KTJhvPRgnnTG5YysAYBV0Y4J1I7af+rchPhAhxrWtiWGUoAs/RYcJ9sT84IP/2ZBbw
         VE/EM7wK55gTB1PcD876WPe+uaAUv2vHq2fPLLjfQpmTrEzaJeJmtasEXxh974F4lA
         s6GVHYJLIalSjwQug/LOoKTq4LHvUTq4ekCBhNc0DnWebnmE02pijY3DwP9XmwdkBI
         i0jLYZRLQMebw==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [[RFC PATCH v4 net-next] 2/2] net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
Date:   Wed,  6 Sep 2023 17:28:01 +0200
Message-Id: <20230906152801.921664-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906152801.921664-1-lukma@denx.de>
References: <20230906152801.921664-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
be filtered in HW (in some special cases - described in AN3474).
Hence, the HSR core code shall be used to discard those not caught frames.

Moreover, some switch registers adjustments are required - like setting
MAC address of HSR network interface.

Additionally, the KSZ9477 switch has been configured to forward frames
between HSR ports (e.g. 1,2) members to provide support for
NETIF_F_HW_HSR_FWD flag.

Join and leave functions are written in a way, that are executed with
single port - i.e. configuration is NOT done only when second HSR port
is configured.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use struct ksz_device to store hsr ports information (not struct dsa)

Changes for v3:
- Enable in-switch forwarding of frames between HSR ports (i.e. enable
  bridging of those two ports)

- The NETIF_F_HW_HSR_FWD flag has been marked as supported by the HSR
  network device

- Remove ETH MAC address validity check as it is done earlier in the net
  driver

- Add comment regarding adding support for NETIF_F_HW_HSR_FWD flag

Changes for v4:
- Merge patches for ksz_common.c and ksz9477.c

- Remove code to set global self-address filtering as this bit has
  already been set at ksz9477_reset_switch() function. Update also
  comment.

- Use already available ksz9477_cfg_port_member() instead of ksz_prmw32()

- Add description about chip limitations

- Allow having only one offloaded hsr interface (e.g. hsr0). Other ones
  (like hsr1) will have only SW HSR support

- Add check if MAC address of HSR device is equal to one from DSA master
- Rewrite the code to support per port join (i.e. not making init only
  when second HSR port is join)
- Add check to allow only one HSR port HW offloading
- Add hsr_ports to ksz_device struct to allow clean removal of network
  interfaces composing hsr device
---
 drivers/net/dsa/microchip/ksz9477.c    | 81 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  2 +
 drivers/net/dsa/microchip/ksz_common.c | 76 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  3 +
 4 files changed, 162 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 83b7f2d5c1ea..f36bc427c468 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1141,6 +1141,87 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
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
+ * frames will not be caught - to be more specific; there is a race
+ * condition in hardware such that, when duplicate packets are received
+ * on member ports very close in time to each other, the hardware fails
+ * to detect that they are duplicates.
+ *
+ * Hence, the SW needs to handle those special cases. However, the speed
+ * up gain is considerable when above features are used.
+ *
+ * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR frames
+ * can be forwarded in the switch fabric between HSR ports.
+ */
+#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_FWD)
+
+void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+{
+	struct ksz_device *dev = ds->priv;
+	struct net_device *slave;
+	u8 i, data;
+
+	/* Program which port(s) shall support HSR */
+	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
+
+	/* Forward frames between HSR ports (i.e. bridge together HSR ports) */
+	ksz9477_cfg_port_member(dev, port,
+				BIT(dsa_upstream_port(ds, port)) | BIT(port));
+
+	if (!dev->hsr_ports) {
+		/* Enable discarding of received HSR frames */
+		ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
+		data |= HSR_DUPLICATE_DISCARD;
+		data &= ~HSR_NODE_UNICAST;
+		ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
+
+		/* Self MAC address filtering for HSR frames to avoid
+		 * traverse of the HSR ring more than once.
+		 *
+		 * The HSR port (i.e. hsr0) MAC address is used.
+		 */
+		for (i = 0; i < ETH_ALEN; i++)
+			ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
+				   hsr->dev_addr[i]);
+	}
+
+	/* Enable per port self-address filtering.
+	 * The global self-address filtering has already been enabled in the
+	 * ksz9477_reset_switch() function.
+	 */
+	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
+
+	/* Setup HW supported features for lan HSR ports */
+	slave = dsa_to_port(ds, port)->slave;
+	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+
+	pr_debug("%s: HSR join port: %d\n", __func__,  port);
+}
+
+void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
+{
+	struct ksz_device *dev = ds->priv;
+
+	/* Clear port HSR support */
+	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), 0);
+
+	/* Disable forwarding frames between HSR ports */
+	ksz9477_cfg_port_member(dev, port, BIT(dsa_upstream_port(ds, port)));
+
+	/* Disable per port self-address filtering */
+	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
+}
+
 int ksz9477_switch_init(struct ksz_device *dev)
 {
 	u8 data8;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index a6f425866a29..8625bf474764 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -56,5 +56,7 @@ int ksz9477_reset_switch(struct ksz_device *dev);
 int ksz9477_switch_init(struct ksz_device *dev);
 void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
+void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
+void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 42db7679c360..b81c3ac422f9 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -16,6 +16,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/if_hsr.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
@@ -3419,6 +3420,79 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+{
+	struct net_device *dm = dsa_port_to_master(dsa_to_port(ds, port));
+	struct ksz_device *dev = ds->priv;
+	enum hsr_version ver;
+	int ret;
+
+	ret = hsr_get_version(hsr, &ver);
+	if (ret)
+		return ret;
+
+	/* Check if HSR net_device's MAC address equals to DSA master.
+	 *
+	 * Only in that way one can assure correct operation between
+	 * different switch features - like WoL, PAUSE and HSR, which
+	 * are using in-switch programmed MAC address.
+	 */
+	if (!ether_addr_equal(dm->dev_addr, hsr->dev_addr)) {
+		dev_err(dev->dev,
+			"DSA master and HSR dev MAC must equal for offloading");
+		return -EOPNOTSUPP;
+	}
+
+	switch (dev->chip_id) {
+	case KSZ9477_CHIP_ID:
+		/* KSZ9477 can support HW offloading of only 1 HSR device */
+		if (dev->hsr_dev && hsr != dev->hsr_dev) {
+			dev_err(dev->dev, "Offload supported for a single HSR");
+			return -EOPNOTSUPP;
+		}
+
+		/* KSZ9477 only supports HSR v0 and v1 */
+		if (!(ver == HSR_V0 || ver == HSR_V1)) {
+			dev_err(dev->dev, "Only HSR v0 and v1 supported");
+			return -EOPNOTSUPP;
+		}
+
+		ksz9477_hsr_join(ds, port, hsr);
+		dev->hsr_dev = hsr;
+		dev->hsr_ports |= BIT(port);
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int ksz_hsr_leave(struct dsa_switch *ds, int port,
+			 struct net_device *hsr)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret = 0;
+
+	switch (dev->chip_id) {
+	case KSZ9477_CHIP_ID:
+		if (hsr != dev->hsr_dev)
+			return -EOPNOTSUPP;
+
+		ksz9477_hsr_leave(ds, port, hsr);
+		dev->hsr_ports &= ~BIT(port);
+		if (!dev->hsr_ports)
+			dev->hsr_dev = NULL;
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
@@ -3438,6 +3512,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a4de58847dea..e36d459de5a1 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -169,6 +169,9 @@ struct ksz_device {
 	struct mutex lock_irq;		/* IRQ Access */
 	struct ksz_irq girq;
 	struct ksz_ptp_data ptp_data;
+
+	struct net_device *hsr_dev;     /* HSR */
+	u8 hsr_ports;
 };
 
 /* List of supported models */
-- 
2.20.1

