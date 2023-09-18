Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502677A41CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbjIRHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbjIRHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:09:17 -0400
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6112C;
        Mon, 18 Sep 2023 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
        s=mail; t=1695020358;
        bh=OVRu7GNa7qghrnBhqjySBsYY/dOGLj4eOCvJhhr7DQI=;
        h=Date:From:To:Subject:From;
        b=UXrIpDtxRvRVJGmtGTBaitahjfNCV1JDDxQKII4pmDy5RVunG00iIgoCi6pysmHwi
         haUjkkabV+Qr9y+QPoFz0Ugerhikcs05xSYSz7R9rzEA7fu4byG9g6X/FRSPVedenT
         uGHevKzmw7VXlqJfEGPPuqhDliBFgz2hUNOswgdLu9qmNBz37LAI6I/UJjg1R39U5f
         dYZ+penTMu6oM/TIigc2XipuhIs0dOspDiAWLHDSWzk+sS1hK96yOmp0gbI9y3xNS0
         sbX1ZiFJMi3K2ypf0+o3yxqqgGTIdf8swRctkX3m7LgisV0WYmoQ//oAZ0lJzy4u4n
         70NZ+5rQSJ2Ww==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by core.lopingdog.com (Postfix) with ESMTPSA id F1E48440EB7;
        Mon, 18 Sep 2023 01:59:16 -0500 (CDT)
Date:   Mon, 18 Sep 2023 01:59:15 -0500
From:   Jay Monkman <jtm@lopingdog.com>
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: [PATCH 4/4] net/onsemi: Add NCN26010 driver
Message-ID: <ZQf1QwNzK5jjOWk9@lopingdog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a driver for the onsemi NCN26010 ethernet controller. The
NCN26010 is combined MAC/PHY that uses SPI to interface to a
microcontroller.

Signed-off-by: Jay Monkman <jtm@lopingdog.com>
---
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/onsemi/Kconfig           |   27 +
 drivers/net/ethernet/onsemi/Makefile          |    9 +
 drivers/net/ethernet/onsemi/onsemi_macphy.h   |  298 +++
 .../net/ethernet/onsemi/onsemi_macphy_core.c  | 2149 +++++++++++++++++
 .../ethernet/onsemi/onsemi_macphy_ethtool.c   |  179 ++
 7 files changed, 2664 insertions(+)
 create mode 100644 drivers/net/ethernet/onsemi/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/onsemi_macphy.h
 create mode 100644 drivers/net/ethernet/onsemi/onsemi_macphy_core.c
 create mode 100644 drivers/net/ethernet/onsemi/onsemi_macphy_ethtool.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 5a274b99f299..5ae26396ccfa 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -145,6 +145,7 @@ source "drivers/net/ethernet/ni/Kconfig"
 source "drivers/net/ethernet/natsemi/Kconfig"
 source "drivers/net/ethernet/neterion/Kconfig"
 source "drivers/net/ethernet/netronome/Kconfig"
+source "drivers/net/ethernet/onsemi/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
 source "drivers/net/ethernet/nxp/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 0d872d4efcd1..62900d4fcd7a 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
 obj-$(CONFIG_LPC_ENET) += nxp/
 obj-$(CONFIG_NET_VENDOR_OKI) += oki-semi/
 obj-$(CONFIG_ETHOC) += ethoc.o
+obj-$(CONFIG_NET_VENDOR_ONSEMI) += onsemi/
 obj-$(CONFIG_NET_VENDOR_PACKET_ENGINES) += packetengines/
 obj-$(CONFIG_NET_VENDOR_PASEMI) += pasemi/
 obj-$(CONFIG_NET_VENDOR_QLOGIC) += qlogic/
diff --git a/drivers/net/ethernet/onsemi/Kconfig b/drivers/net/ethernet/onsemi/Kconfig
new file mode 100644
index 000000000000..a5b029e53a6d
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+#
+# onsemi device configuration
+#
+
+config NET_VENDOR_ONSEMI
+	bool "onsemi devices"
+	default y
+	depends on SPI
+	help
+	  If you have a network (Ethernet) card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about ONSEMI devices. If you say Y, you will be asked
+	  for your specific card in the following questions.
+
+if NET_VENDOR_ONSEMI
+
+config ONSEMI_MACPHY
+	tristate "onsemi NCN260xx SPI MAC-PHY devices"
+	depends on SPI
+	select NCN26000_PHY
+	help
+	  Say yes here to build support for onsemi MAC-PHY devices
+
+endif # NET_VENDOR_ONSEMI
diff --git a/drivers/net/ethernet/onsemi/Makefile b/drivers/net/ethernet/onsemi/Makefile
new file mode 100644
index 000000000000..50ef2e4930a1
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+#
+# Makefile for the onsemi network device drivers.
+#
+
+obj-$(CONFIG_ONSEMI_MACPHY) += onsemi_macphy.o
+onsemi_macphy-y := \
+	onsemi_macphy_core.o \
+	onsemi_macphy_ethtool.o
diff --git a/drivers/net/ethernet/onsemi/onsemi_macphy.h b/drivers/net/ethernet/onsemi/onsemi_macphy.h
new file mode 100644
index 000000000000..0e84d5f06ca8
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/onsemi_macphy.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
+
+/* onsemi MACPHY ethernet driver
+ * Copyright (c) 2023 onsemi
+ */
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/phylink.h>
+#include <linux/spi/spi.h>
+
+// macros ------------------------------------------------------------------- //
+
+#define USEC_TO_KTIME(x) (ns_to_ktime((x) * NSEC_PER_USEC))
+
+// constants ---------------------------------------------------------------- //
+
+#define DRV_NAME        "onmph"
+#define DRV_VERSION     "1.0.3.0"
+
+#define ONMPH_MAX_FRAME_SIZE 1522 // 1500 + MAC HDR + 2 x 802.1Q VLAN
+#define ONMPH_N_MCAST_FILTERS 3
+
+#define ONMPH_MODEL_NCN26010 0x00
+
+// number of stat counters
+#define ONMPH_STATS_NUM 33
+
+// max number of frames we can store in the TX queue
+#define ONMPH_MAX_PENDING_TX_FRAMES 32
+
+// list of device capabilities
+#define ONMPH_CAP_MACADDR BIT(0) // MAC address stored in ROM
+
+// maximum protocol payload size
+#define MPH_MAX_CPS 64
+
+// maximum TX/RX credits reported in the footer
+#define MPH_MAX_CRED 32
+
+// ONMPH registers ----------------------------------------------------------- //
+
+// List of available MMS
+#define ONMPH_MMS_SPI_MII		0
+#define ONMPH_MMS_MAC			1
+#define ONMPH_MMS_PCS			2
+#define ONMPH_MMS_PMA			3
+#define ONMPH_MMS_PLCA_VEND2		4
+#define ONMPH_MMS_VS			12
+
+// SPI protocol ID & version register
+#define ONMPH_REG_SPI_IDVER		0x00
+
+// SPI OID and model register
+#define ONMPH_REG_SPI_PHYID		0x01
+
+#define ONMPH_SPI_PHYID_OUI_SHIFT	10
+#define ONMPH_SPI_PHYID_OUI_MASK	GENMASK(31, ONMPH_SPI_PHYID_OUI_SHIFT)
+#define ONMPH_SPI_PHYID_MODEL_SHIFT	4
+#define ONMPH_SPI_PHYID_MODEL_MASK	GENMASK(9, ONMPH_SPI_PHYID_MODEL_SHIFT)
+#define ONMPH_SPI_PHYID_REV_SHIFT	0
+#define ONMPH_SPI_PHYID_REV_MASK	GENMASK(3, ONMPH_SPI_PHYID_REV_SHIFT)
+
+// SPI reset register
+#define ONMPH_REG_SPI_RST		0x03
+
+#define ONMPH_RST_SRST_BIT		BIT(0)
+
+// SPI configuration register #0
+#define ONMPH_REG_SPI_CFG0		0x04
+
+#define ONMPH_SPI_CFG0_SYNC_BIT		BIT(15)
+#define ONMPH_SPI_CFG0_TXFCSVE_BIT	BIT(14)
+#define ONMPH_SPI_CFG0_CSARFE_BIT	BIT(13)
+#define ONMPH_SPI_CFG0_ZARFE_BIT	BIT(12)
+#define ONMPH_SPI_CFG0_TXCTHRESH_SHIFT	10
+#define ONMPH_SPI_CFG0_TXCTHRESH_MASK	GENMASK(11, ONMPH_SPI_CFG0_TXCTHRESH_SHIFT)
+#define ONMPH_SPI_CFG0_TXCTE_BIT	BIT(9)
+#define ONMPH_SPI_CFG0_RXCTE_BIT	BIT(8)
+#define ONMPH_SPI_CFG0_FTSE_BIT		BIT(7)
+#define ONMPH_SPI_CFG0_FTSS_BIT		BIT(6)
+#define ONMPH_SPI_CFG0_PROTE_BIT	BIT(5)
+#define ONMPH_SPI_CFG0_SEQE_BIT		BIT(4)
+#define ONMPH_SPI_CFG0_CPS_SHIFT	0
+#define ONMPH_SPI_CFG0_CPS_MASK		GENMASK(2, ONMPH_SPI_CFG0_CPS_SHIFT)
+
+#define ONMPH_TXCTHRESH_1		0x0
+#define ONMPH_TXCTHRESH_4		0x1
+#define ONMPH_TXCTHRESH_8		0x2
+#define ONMPH_TXCTHRESH_16		0x3
+
+#define ONMPH_CPS_8			0x3
+#define ONMPH_CPS_16			0x4
+#define ONMPH_CPS_32			0x5
+#define ONMPH_CPS_64			0x6
+
+// SPI status register #0
+#define ONMPH_REG_SPI_ST0		0x08
+
+#define ONMPH_SPI_ST0_CDPE_BIT		BIT(12)
+#define ONMPH_SPI_ST0_TXFCSE_BIT	BIT(11)
+#define ONMPH_SPI_ST0_TTSCAC_BIT	BIT(10)
+#define ONMPH_SPI_ST0_TTSCAB_BIT	BIT(9)
+#define ONMPH_SPI_ST0_TTSCAA_BIT	BIT(8)
+#define ONMPH_SPI_ST0_PHYINT_BIT	BIT(7)
+#define ONMPH_SPI_ST0_RESETC_BIT	BIT(6)
+#define ONMPH_SPI_ST0_HDRE_BIT		BIT(5)
+#define ONMPH_SPI_ST0_LOFE_BIT		BIT(4)
+#define ONMPH_SPI_ST0_RXBOE_BIT		BIT(3)
+#define ONMPH_SPI_ST0_TXBUE_BIT		BIT(2)
+#define ONMPH_SPI_ST0_TXBOE_BIT		BIT(1)
+#define ONMPH_SPI_ST0_TXPE_BIT		BIT(0)
+
+// SPI IRQ enable register #0 (use the ONMPH_SPI_ST0_*_BIT constants)
+#define ONMPH_REG_SPI_IRQM0		0x0c
+
+// SPI buffer status register
+#define ONMPH_REG_SPI_BUFST		0x0b
+
+#define ONMPH_SPI_BUFST_TXC_SHIFT	8
+#define ONMPH_SPI_BUFST_TXC_MASK	GENMASK(15, ONMPH_SPI_BUFST_TXC_SHIFT)
+#define ONMPH_SPI_BUFST_RCA_SHIFT	0
+#define ONMPH_SPI_BUFST_RCA_MASK	GENMASK(7, ONMPH_SPI_BUFST_RCA_SHIFT)
+
+// MAC control register
+#define ONMPH_REG_MAC_CONTROL           0
+
+#define ONMPH_MAC_CONTROL_NFCSF_BIT	BIT(19)
+#define ONMPH_MAC_CONTROL_MCSF_BIT	BIT(18)
+#define ONMPH_MAC_CONTROL_ADRF_BIT	BIT(16)
+#define ONMPH_MAC_CONTROL_FCSA_BIT	BIT(8)
+#define ONMPH_MAC_CONTROL_TXEN_BIT	BIT(1)
+#define ONMPH_MAC_CONTROL_RXEN_BIT      BIT(0)
+
+// MAC address filter registers
+#define ONMPH_REG_MAC_ADDRFILTL(n)      (16 + 2 * (n))
+#define ONMPH_REG_MAC_ADDRFILTH(n)      (17 + 2 * (n))
+#define ONMPH_REG_MAC_ADDRMASKL(n)      (32 + 2 * (n))
+#define ONMPH_REG_MAC_ADDRMASKH(n)      (33 + 2 * (n))
+
+#define ONMPH_MAC_ADDRFILT_EN_BIT       BIT(31)
+
+// MAC statistic registers
+#define ONMPH_REG_MAC_STOCTECTSTXL      48
+#define ONMPH_REG_MAC_STOCTECTSTXH      49
+#define ONMPH_REG_MAC_STFRAMESTXOK      50
+#define ONMPH_REG_MAC_STBCASTTXOK       51
+#define ONMPH_REG_MAC_STMCASTTXOK       52
+#define ONMPH_REG_MAC_STFRAMESTX64      53
+#define ONMPH_REG_MAC_STFRAMESTX65      54
+#define ONMPH_REG_MAC_STFRAMESTX128     55
+#define ONMPH_REG_MAC_STFRAMESTX256     56
+#define ONMPH_REG_MAC_STFRAMESTX512     57
+#define ONMPH_REG_MAC_STFRAMESTX1024    58
+#define ONMPH_REG_MAC_STTXUNDEFLOW      59
+#define ONMPH_REG_MAC_STSINGLECOL       60
+#define ONMPH_REG_MAC_STMULTICOL        61
+#define ONMPH_REG_MAC_STEXCESSCOL       62
+#define ONMPH_REG_MAC_STDEFERREDTX      63
+#define ONMPH_REG_MAC_STCRSERR          64
+#define ONMPH_REG_MAC_STOCTECTSRXL      65
+#define ONMPH_REG_MAC_STOCTECTSRXH      66
+#define ONMPH_REG_MAC_STFRAMESRXOK      67
+#define ONMPH_REG_MAC_STBCASTRXOK       68
+#define ONMPH_REG_MAC_STMCASTRXOK       69
+#define ONMPH_REG_MAC_STFRAMESRX64      60
+#define ONMPH_REG_MAC_STFRAMESRX65      71
+#define ONMPH_REG_MAC_STFRAMESRX128     72
+#define ONMPH_REG_MAC_STFRAMESRX256     73
+#define ONMPH_REG_MAC_STFRAMESRX512     74
+#define ONMPH_REG_MAC_STFRAMESRX1024    75
+#define ONMPH_REG_MAC_STRUNTSERR        76
+#define ONMPH_REG_MAC_STRXTOOLONG       77
+#define ONMPH_REG_MAC_STFCSERRS         78
+#define ONMPH_REG_MAC_STSYMBOLERRS      79
+#define ONMPH_REG_MAC_STALIGNERRS       80
+#define ONMPH_REG_MAC_STRXOVERFLOW      81
+#define ONMPH_REG_MAC_STRXDROPPED       82
+
+// first/last statistic register for sequential access
+#define ONMPH_REG_MAC_FIRST_STAT	ONMPH_REG_MAC_STOCTECTSTXL
+#define ONMPH_REG_MAC_LAST_STAT		ONMPH_REG_MAC_STRXDROPPED
+
+#define ONMPH_NUMBER_OF_STAT_REGS \
+	(ONMPH_REG_MAC_LAST_STAT - ONMPH_REG_MAC_FIRST_STAT + 1)
+
+// permanent MAC address register
+#define ONMPH_REG_VS_MACID0		0x1002
+#define ONMPH_REG_VS_MACID1		0x1003
+
+#define ONMPH_MACID1_UID_SHIFT		0
+#define ONMPH_MACID1_UID_MASK		GENMASK(7, ONMPH_MACID1_UID_SHIFT)
+
+// chip identification register
+#define ONMPH_REG_VS_CHIPID		0x1000
+
+#define ONMPH_CHIPID_MODEL_SHIFT	8
+#define ONMPH_CHIPID_MODEL_MASK		GENMASK(15, ONMPH_CHIPID_MODEL_SHIFT)
+#define ONMPH_CHIPID_REVISION_SHIFT	0
+#define ONMPH_CHIPID_REVISION_MASK	GENMASK(7, ONMPH_CHIPID_REVISION_SHIFT)
+
+// prototypes / forward declarations ---------------------------------------- //
+
+extern const struct ethtool_ops onmph_ethtool_ops;
+
+// type definitions --------------------------------------------------------- //
+
+struct onmph_info {
+	struct device *dev;
+	struct net_device *ndev;
+
+	// model information
+	u32 model;
+	u32 version;
+	unsigned int capabilities;
+
+	// tasks and synchronization variables
+	spinlock_t lock;
+	struct task_struct *thread;
+
+	// global state variables
+	bool event_pending; // related to the EXST footer flag
+	unsigned int rx_flags;
+	bool rx_flags_upd;
+
+	// global configuration
+	unsigned int mtu; // maximum frame size for RX
+	bool ctrl_protected; // reg read/write protected enabled
+
+	bool tx_fcs_calc; // driver calculates TX FCS
+	bool rx_fcs_check; // driver checks RX FCS
+
+	// polling time in jiffies, or MAX_SCHEDULE_TIMEOUT (disable)
+	signed long poll_jiff;
+
+	// SPI
+	struct spi_device *spi;
+	bool irq_pending;
+	unsigned int cps; // current chunk payload size
+	unsigned int csz; // total chunk size
+
+	// PHY IRQ emulation
+	struct irq_domain *irqdm;
+	bool phy_irq_pending;
+	bool phy_irq_en;
+	int phy_virq;
+
+	// PHY MDIO emulation
+	struct mii_bus *mdio_bus;
+	char mdio_bus_name[MII_BUS_ID_SIZE];
+	u16 mii_c45_ctrl;
+	u16 mii_c45_addr[32];
+
+	// PHY config/status
+	struct phy_device *phy;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+
+	// TX state variables
+	struct list_head tx_skb_q; // queue of skb ready for TX
+	unsigned int tx_skb_q_sz; // number of TX skbs in tx_skb_q
+
+	struct sk_buff *tx_skb; // skb currently being transmitted
+	unsigned int tx_txc; // TX chunks available
+	void *tx_mem;
+
+	// RX state variables
+	struct sk_buff *rx_skb; // skb currently being received
+	unsigned int rx_rca; // RX chunks available
+	bool rx_skip; // skip chunks until new SV
+	void *rx_mem;
+
+	// statistic counters variables
+	u64 stats_data[ONMPH_STATS_NUM];
+
+	struct irq_chip irq_chip;
+};
+
+// helpers ------------------------------------------------------------------ //
+
+int onmph_wregs(struct onmph_info *priv, int mms, int addr, int len,
+		const u32 *data);
+
+int onmph_rregs(struct onmph_info *priv, int mms, int addr, int len, u32 *data);
+
+static inline int onmph_wreg(struct onmph_info *priv, int mms, int addr, u32 data)
+{
+	return onmph_wregs(priv, mms, addr, 1, &data);
+}
+
+static inline int onmph_rreg(struct onmph_info *priv, int mms, int addr, u32 *data)
+{
+	return onmph_rregs(priv, mms, addr, 1, data);
+}
+
+// -------------------------------------------------------------------------- //
diff --git a/drivers/net/ethernet/onsemi/onsemi_macphy_core.c b/drivers/net/ethernet/onsemi/onsemi_macphy_core.c
new file mode 100644
index 000000000000..121f38b3f895
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/onsemi_macphy_core.c
@@ -0,0 +1,2149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+
+/* onsemi MACPHY ethernet driver
+ * Copyright (c) 2022 onsemi
+ */
+
+#include "onsemi_macphy.h"
+
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+
+// ONMPH functions & definitions--------------------------------------------- //
+
+// struct to hold chunk header flags
+struct mph_dhdr_info {
+	unsigned int sv;  // start-valid flag
+	unsigned int ev;  // end-valid flag
+	unsigned int swo; // start word (u32) offset
+	unsigned int ebo; // end byte offset
+};
+
+// converts a MACPHY ID to a device name
+static inline const char *onmph_id_to_name(u32 id)
+{
+	switch (id) {
+	case ONMPH_MODEL_NCN26010:
+		return "NCN26010";
+	}
+
+	return "unknown";
+}
+
+// calculates the header parity according to the MACPHY protocol specifications
+static inline int parity32(u32 data)
+{
+	u32 tmp = data ^ (data >> 16);
+
+	tmp ^= tmp >> 8;
+	tmp ^= tmp >> 4;
+	tmp ^= tmp >> 2;
+	tmp ^= tmp >> 1;
+
+	return !(tmp & 1);
+}
+
+// make generic data header
+#define MPH_MKDATAHDR(DV, SV, EV, SWO, EBO, NRX) (\
+	(0x80000000) | \
+	((NRX) << 29) | \
+	((DV)  << 21) | \
+	((SV)  << 20) | \
+	((SWO) << 16) | \
+	((EV)  << 14) | \
+	((EBO) << 8))
+
+// make data header for TX/RX
+#define MPH_MKDATAHDR_TXRX(SV, EV, SWO, EBO) \
+	MPH_MKDATAHDR(1, SV, EV, SWO, EBO, 0)
+
+// make data header for TX only
+#define MPH_MKDATAHDR_TX(SV, EV, SWO, EBO) MPH_MKDATAHDR(1, SV, EV, SWO, EBO, 1)
+
+// make data header for RX only
+#define MPH_MKDATAHDR_RX MPH_MKDATAHDR(0, 0, 0, 0, 0, 0)
+
+// make a data header for TX and RX in network byte order
+static inline u32 onmph_mkdatahdr_txrx(struct mph_dhdr_info *info)
+{
+	u32 ret = MPH_MKDATAHDR_TXRX(info->sv, info->ev, info->swo, info->ebo);
+
+	ret = cpu_to_be32(ret | parity32(ret));
+
+	return ret;
+}
+
+// make a data header for RX only in network byte order
+static inline u32 onmph_mkdatahdr_rx(void)
+{
+	// return a constant which parity is 0 (optimization)
+	return cpu_to_be32(MPH_MKDATAHDR_RX);
+}
+
+// make generic control header
+#define MPH_MKCTLHDR(MMS, ADR, LEN, WNR) (\
+	((WNR) << 29) | \
+	((MMS) << 24) | \
+	((ADR) <<  8) | \
+	(((LEN) - 1) << 1))
+
+// make single register (R)ead/(W)rite
+#define MPH_MKCTLHDR_SR(MMS, ADR) MPH_MKCTLHDR(MMS, ADR, 1, 0)
+#define MPH_MKCTLHDR_SW(MMS, ADR) MPH_MKCTLHDR(MMS, ADR, 1, 1)
+
+// make multiple register (R)ead/(W)rite
+#define MPH_MKCTLHDR_MR(MMS, ADR, LEN) MPH_MKCTLHDR(MMS, ADR, LEN, 0)
+#define MPH_MKCTLHDR_MW(MMS, ADR, LEN) MPH_MKCTLHDR(MMS, ADR, LEN, 1)
+
+/* Make a control header a single register read
+ *
+ * The header includes parity and is in network byte order
+ * Parameters
+ *    mms  - memory mode selection group
+ *    addr - register address
+ */
+static inline u32 onmph_mkctlhdr_sr(int mms, int addr)
+{
+	u32 ret = MPH_MKCTLHDR_SR(mms, addr);
+
+	ret = cpu_to_be32(ret | parity32(ret));
+
+	return ret;
+}
+
+/* Make a control header for a multiple register read
+ *
+ * The header includes parity and is in network byte order
+ * Parameters
+ *    mms  - memory mode selection group
+ *    addr - base register address
+ *    len  - number of registers
+ */
+static inline u32 onmph_mkctlhdr_mr(int mms, int addr, int len)
+{
+	u32 ret = MPH_MKCTLHDR_MR(mms, addr, len);
+
+	ret = cpu_to_be32(ret | parity32(ret));
+
+	return ret;
+}
+
+/* Make a control header a single register write
+ *
+ * The header includes parity and is in network byte order
+ * Parameters
+ *    mms  - memory mode selection group
+ *    addr - register address
+ */
+static inline u32 onmph_mkctlhdr_sw(int mms, int addr)
+{
+	u32 ret = MPH_MKCTLHDR_SW(mms, addr);
+
+	ret = cpu_to_be32(ret | parity32(ret));
+
+	return ret;
+}
+
+/* Make a control header for a multiple register write
+ *
+ * The header includes parity and is in network byte order
+ * Parameters
+ *    mms  - memory mode selection group
+ *    addr - base register address
+ *    len  - number of registers
+ */
+static inline u32 onmph_mkctlhdr_mw(int mms, int addr, int len)
+{
+	u32 ret = MPH_MKCTLHDR_MW(mms, addr, len);
+
+	ret = cpu_to_be32(ret | parity32(ret));
+
+	return ret;
+}
+
+// struct to hold chunk footer flags
+struct mph_dftr_info {
+	bool exst;
+	bool hdrb;
+	bool sync;
+	bool dv;
+	bool sv;
+	bool fd;
+	bool ev;
+
+	unsigned int rca;
+	unsigned int txc;
+	unsigned int swo;
+	unsigned int ebo;
+	unsigned int sbo;
+};
+
+#define MPH_FOOTER_EXTS BIT(31)
+#define MPH_FOOTER_HDRB BIT(30)
+#define MPH_FOOTER_SYNC BIT(29)
+#define MPH_FOOTER_DV	BIT(21)
+#define MPH_FOOTER_SV	BIT(20)
+#define MPH_FOOTER_FD	BIT(15)
+#define MPH_FOOTER_EV	BIT(14)
+
+#define MPH_FOOTER_RCA_SHIFT 24
+#define MPH_FOOTER_RCA_MASK GENMASK(28, MPH_FOOTER_RCA_SHIFT)
+#define MPH_FOOTER_SWO_SHIFT 16
+#define MPH_FOOTER_SWO_MASK GENMASK(19, MPH_FOOTER_SWO_SHIFT)
+#define MPH_FOOTER_EBO_SHIFT 8
+#define MPH_FOOTER_EBO_MASK GENMASK(13, MPH_FOOTER_EBO_SHIFT)
+#define MPH_FOOTER_TXC_SHIFT 1
+#define MPH_FOOTER_TXC_MASK GENMASK(5, MPH_FOOTER_TXC_SHIFT)
+
+static int onmph_parse_footer(u32 ftr, struct mph_dftr_info *info)
+{
+	ftr = be32_to_cpu(ftr);
+
+	if (parity32(ftr))
+		return -EPROTO;
+
+	info->exst = (ftr & MPH_FOOTER_EXTS) != 0;
+	info->hdrb = (ftr & MPH_FOOTER_HDRB) != 0;
+	info->sync = (ftr & MPH_FOOTER_SYNC) != 0;
+	info->dv = (ftr & MPH_FOOTER_DV) != 0;
+	info->sv = (ftr & MPH_FOOTER_SV) != 0;
+	info->fd = (ftr & MPH_FOOTER_FD) != 0;
+	info->ev = (ftr & MPH_FOOTER_EV) != 0;
+
+	info->rca = (ftr & MPH_FOOTER_RCA_MASK) >> MPH_FOOTER_RCA_SHIFT;
+	info->txc = (ftr & MPH_FOOTER_TXC_MASK) >> MPH_FOOTER_TXC_SHIFT;
+	info->swo = (ftr & MPH_FOOTER_SWO_MASK) >> MPH_FOOTER_SWO_SHIFT;
+	info->ebo = (ftr & MPH_FOOTER_EBO_MASK) >> MPH_FOOTER_EBO_SHIFT;
+	info->sbo = info->swo << 2;
+
+	return 0;
+}
+
+// Helper to prepare a control SPI transfer.
+static int onmph_prepare_ctrl_transfer(struct onmph_info *priv, int len,
+				       struct spi_transfer *st)
+{
+	int ws;
+
+	// protocol only allows from 1 to 128 registers access in a row
+	if (unlikely(len > 128 || len < 1))
+		return -EINVAL;
+
+	/* Allocate a single buffer for both TX & RX (twice the transfer length)
+	 * including 2 words for the header and the dummy tail.
+	 * When protected mode is enabled, we further need to double the
+	 * data buffer length to accommodate the redundancy.
+	 */
+	ws = (priv->ctrl_protected ? 2 * len : len) + 2;
+	st->len = ws << 2; // 4 bytes per register / header
+
+	st->tx_buf = kzalloc(2 * st->len, GFP_ATOMIC);
+	if (!st->tx_buf)
+		return -ENOMEM;
+
+	// set rx_buf half-way into the allocated buffer
+	st->rx_buf = (void *)(st->tx_buf + st->len);
+	return 0;
+}
+
+static inline void onmph_finalize_ctrl_transfer(const struct spi_transfer *st)
+{
+	kfree(st->tx_buf);
+}
+
+// Write multiple MACPHY registers
+int onmph_wregs(struct onmph_info *priv, int mms, int addr, int len,
+		const u32 *data)
+{
+	struct spi_transfer st = { 0 };
+	u32 *wptr;
+	int ret;
+
+	ret = onmph_prepare_ctrl_transfer(priv, len, &st);
+	if (ret)
+		return ret;
+
+	wptr = (u32 *)st.tx_buf;
+	*(wptr++) = onmph_mkctlhdr_mw(mms, addr, len);
+
+	// copy the data in network byte order
+	do {
+		const u32 val = cpu_to_be32(*data);
+		*wptr = val;
+
+		// in protected mode, duplicate the value (complemented)
+		if (priv->ctrl_protected)
+			*(++wptr) = ~val;
+
+		if (--len == 0)
+			break;
+
+		wptr++;
+		data++;
+	} while (true);
+
+	ret = spi_sync_transfer(priv->spi, &st, 1);
+	if (!priv->ctrl_protected || ret)
+		goto out;
+
+	// check header & data loopback skipping the initial dummy RX word
+	if (memcmp(st.tx_buf, st.rx_buf + 4, st.len - 4))
+		ret = -EIO;
+
+out:
+	onmph_finalize_ctrl_transfer(&st);
+	return ret;
+}
+
+// Read multiple MACPHY registers
+int onmph_rregs(struct onmph_info *priv, int mms, int addr, int len, u32 *data)
+{
+	struct spi_transfer st = { 0 };
+	const u32 *rptr;
+	u32 *wptr;
+	int ret;
+
+	ret = onmph_prepare_ctrl_transfer(priv, len, &st);
+	if (ret)
+		return ret;
+
+	wptr = (u32 *)st.tx_buf;
+	*wptr = onmph_mkctlhdr_mr(mms, addr, len);
+
+	ret = spi_sync_transfer(priv->spi, &st, 1);
+	if (ret)
+		goto out;
+
+	rptr = st.rx_buf + 4; // looped-back header (skip dummy)
+	if (*(rptr++) != *wptr) {
+		ret = -EIO;
+		goto out;
+	}
+
+	do {
+		*data = be32_to_cpu(*rptr);
+
+		if (priv->ctrl_protected) {
+			if (~(*data) != be32_to_cpu(*(++rptr))) {
+				ret = -EIO;
+				goto out;
+			}
+		}
+
+		if (--len == 0)
+			break;
+
+		rptr++;
+		data++;
+	} while (true);
+out:
+	onmph_finalize_ctrl_transfer(&st);
+	return ret;
+}
+
+// initializes the net device MAC address by reading the UID stored into the
+// device internal non-volatile memory
+static int onmph_read_mac_from_nvmem(struct onmph_info *priv)
+{
+	u8 addr[ETH_ALEN];
+	int i, j;
+	u32 val;
+	int ret;
+
+	ret = onmph_rreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_PHYID, &val);
+	if (ret)
+		goto out;
+
+	val = (val & ONMPH_SPI_PHYID_OUI_MASK) >> ONMPH_SPI_PHYID_OUI_SHIFT;
+
+	// convert the OID in host bit / byte order
+	for (i = 2; i >= 0; --i) {
+		addr[i] = 0;
+		for (j = 0; j < 8; ++j) {
+			addr[i] |= (val & 1) << (7 - j);
+			val >>= 1;
+		}
+	}
+
+	ret = onmph_rreg(priv, ONMPH_MMS_VS, ONMPH_REG_VS_MACID1, &val);
+	if (ret)
+		goto out;
+
+	addr[3] = val & 0xff;
+
+	ret = onmph_rreg(priv, ONMPH_MMS_VS, ONMPH_REG_VS_MACID0, &val);
+	if (ret)
+		goto out;
+
+	addr[4] = (val >> 8) & 0xff;
+	addr[5] = val & 0xff;
+
+	__dev_addr_set(priv->ndev, addr, ETH_ALEN);
+	priv->ndev->addr_assign_type = NET_ADDR_PERM;
+
+out:
+	return ret;
+}
+
+// Writes MAC address to macphy registers
+static int onmph_set_mac_filter(struct net_device *ndev, const u8 *mac)
+{
+	struct onmph_info *priv = netdev_priv(ndev);
+	u32 val;
+	int ret;
+
+	// set unicast address filter
+	ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_ADDRMASKL(0),
+			 0xffffffff);
+	if (ret)
+		return ret;
+
+	ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_ADDRMASKH(0),
+			 0x0000ffff);
+	if (ret)
+		return ret;
+
+	val =	((u32)mac[2] << 24) |
+		((u32)mac[3] << 16) |
+		((u32)mac[4] << 8)  |
+		((u32)mac[5]);
+
+	ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_ADDRFILTL(0), val);
+	if (ret)
+		return ret;
+
+	val = ONMPH_MAC_ADDRFILT_EN_BIT | ((u32)mac[0] << 8) | ((u32)mac[1]);
+
+	return onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_ADDRFILTH(0), val);
+}
+
+/* Reset the NCN26010 and configure control data protection */
+static int onmph_reset(struct onmph_info *priv)
+{
+	int i = 0;
+	u32 val;
+	int ret;
+
+	// reset the MACPHY
+	ret = onmph_wreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_RST,
+			 ONMPH_RST_SRST_BIT);
+	if (ret)
+		return ret;
+
+	// the reset cleared PROTE bit --> switch to normal accesses
+	priv->ctrl_protected = false;
+
+	do {
+		// wait for reset to complete
+		usleep_range(1000, 2000);
+		ret = onmph_rreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_ST0,
+				 &val);
+
+		if (ret)
+			return ret;
+	} while (!(val & ONMPH_SPI_ST0_RESETC_BIT) && (i++ < 3));
+
+	if (i >= 3)
+		return -ENODEV;
+
+	if (device_property_read_bool(priv->dev, "ctrl-protected")) {
+		// protected control access is configured --> enable it
+		ret = onmph_rreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_CFG0,
+				 &val);
+		if (ret) {
+			dev_err(priv->dev, "failed to read CFG0 reg\n");
+			return ret;
+		}
+
+		val |= ONMPH_SPI_CFG0_PROTE_BIT;
+
+		ret = onmph_wreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_CFG0,
+				 val);
+		if (ret) {
+			dev_err(priv->dev, "failed to write CFG0 reg\n");
+			return ret;
+		}
+
+		priv->ctrl_protected = true;
+
+		dev_info(priv->dev, "control data protection enabled\n");
+	} else {
+		// nothing to do!
+		dev_info(priv->dev, "control data protection disabled\n");
+	}
+
+	return 0;
+}
+
+static int onmph_init(struct onmph_info *priv)
+{
+	u32 val;
+	int ret;
+
+	ret = onmph_reset(priv);
+	if (ret) {
+		dev_err(priv->dev, "device reset failed\n");
+		goto out;
+	}
+
+	// acknowledge all IRQ status bits
+	ret = onmph_wreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_ST0, val);
+	if (ret)
+		goto out;
+
+	/* TODO: investigate why enabling ONMPH_SPI_CFG0_RXCTE_BIT
+	 * (RX Cut-Through mode) makes the device produce RX frames larger than
+	 * the MTU in some corner cases (e.g, SPI too slow). Potential HW bug??
+	 * For now, let's stick to Store & Forward
+	 */
+
+	// configure the SPI protocol
+	val = (ONMPH_SPI_CFG0_SYNC_BIT) |
+	      (ONMPH_TXCTHRESH_8 << ONMPH_SPI_CFG0_TXCTHRESH_SHIFT) |
+	      (ONMPH_CPS_64 << ONMPH_SPI_CFG0_CPS_SHIFT);
+
+	if (priv->ctrl_protected)
+		val |= ONMPH_SPI_CFG0_PROTE_BIT;
+
+	if (priv->tx_fcs_calc)
+		val |= ONMPH_SPI_CFG0_TXFCSVE_BIT;
+
+	ret = onmph_wreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_CFG0, val);
+	if (ret)
+		goto out;
+
+	// unmask relevant interrupts
+	val = (u32) ~(ONMPH_SPI_ST0_PHYINT_BIT | ONMPH_SPI_ST0_RESETC_BIT |
+		      ONMPH_SPI_ST0_HDRE_BIT | ONMPH_SPI_ST0_LOFE_BIT |
+		      ONMPH_SPI_ST0_RXBOE_BIT | ONMPH_SPI_ST0_TXBOE_BIT |
+		      ONMPH_SPI_ST0_TXPE_BIT);
+
+	ret = onmph_wreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_IRQM0, val);
+	if (ret)
+		goto out;
+
+	// read the initial value of TX credits
+	ret = onmph_rreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_BUFST, &val);
+	if (ret)
+		goto out;
+
+	priv->tx_txc = (val & ONMPH_SPI_BUFST_TXC_MASK) >> ONMPH_SPI_BUFST_TXC_SHIFT;
+
+	if (priv->tx_txc > MPH_MAX_CRED)
+		priv->tx_txc = MPH_MAX_CRED;
+
+	// RX credits and errors are reset too
+	priv->rx_rca = 0;
+	priv->rx_skip = false;
+
+	// program the source MAC address into the device
+	ret = onmph_set_mac_filter(priv->ndev, priv->ndev->dev_addr);
+
+	// enable the MAC w/ default config
+	val = ONMPH_MAC_CONTROL_ADRF_BIT | ONMPH_MAC_CONTROL_TXEN_BIT |
+	      ONMPH_MAC_CONTROL_RXEN_BIT;
+
+	if (!priv->tx_fcs_calc)
+		val |= ONMPH_MAC_CONTROL_FCSA_BIT;
+
+	ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, val);
+	if (ret)
+		goto out;
+
+	// allow TX frames to be delivered
+	netif_start_queue(priv->ndev);
+out:
+	return ret;
+}
+
+static void onmph_shutdown(struct onmph_info *priv)
+{
+	struct net_device *ndev = priv->ndev;
+	u32 reg;
+
+	// stop the TX queue
+	netif_stop_queue(ndev);
+	disable_irq(ndev->irq);
+
+	// stop the MAC
+	onmph_rreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, &reg);
+	reg &= ~(ONMPH_MAC_CONTROL_TXEN_BIT | ONMPH_MAC_CONTROL_RXEN_BIT);
+	onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, reg);
+}
+
+// Configures macphy for promiscuous mode
+static int onmph_set_promiscuous_mode(struct onmph_info *priv,
+				      unsigned int rx_flags)
+{
+	int ret = 0;
+	u32 val;
+	u32 ctrl0;
+
+	// read the current status of the control register
+	ret = onmph_rreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, &ctrl0);
+	if (ret)
+		return ret;
+
+	if (rx_flags & IFF_PROMISC) {
+		if (!(ctrl0 & ONMPH_MAC_CONTROL_ADRF_BIT))
+			return 0;
+
+		// set promiscuous mode by clearing ADRF
+		val = ctrl0 & ~ONMPH_MAC_CONTROL_ADRF_BIT;
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL,
+				 val);
+	} else if (!(ctrl0 & ONMPH_MAC_CONTROL_ADRF_BIT)) {
+		// disable promiscuous mode
+		val = ctrl0 | ONMPH_MAC_CONTROL_ADRF_BIT;
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL,
+				 val);
+	}
+
+	return ret;
+}
+
+// Configure macphy for multicast filtering
+static int onmph_set_multicast_mode(struct onmph_info *priv,
+				    unsigned int rx_flags)
+{
+	int ret = 0;
+	u32 ctrl0;
+	u32 val;
+
+	if ((rx_flags & IFF_ALLMULTI) ||
+	    (netdev_mc_count(priv->ndev) > ONMPH_N_MCAST_FILTERS)) {
+		// Disable multicast filter
+		ret = onmph_rreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, &ctrl0);
+		if (ret)
+			return ret;
+
+		ctrl0 &= ~ONMPH_MAC_CONTROL_MCSF_BIT;
+
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, ctrl0);
+		if (ret)
+			return ret;
+
+		// accept all multicasts (any address with the LSB = 1 in the first byte)
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+				 ONMPH_REG_MAC_ADDRMASKL(1), 0x00000000);
+		if (ret)
+			return ret;
+
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+				 ONMPH_REG_MAC_ADDRMASKH(1), 0x00000100);
+		if (ret)
+			return ret;
+
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+				 ONMPH_REG_MAC_ADDRFILTL(1), 0x00000000);
+		if (ret)
+			return ret;
+
+		val = ONMPH_MAC_ADDRFILT_EN_BIT | 0x00000100;
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+				 ONMPH_REG_MAC_ADDRFILTH(1), val);
+
+		return ret;
+
+	} else if (netdev_mc_count(priv->ndev) == 0) {
+		int i;
+
+		// Enable multicast filter
+		ret = onmph_rreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, &ctrl0);
+		if (ret)
+			return ret;
+
+		ctrl0 |= ONMPH_MAC_CONTROL_MCSF_BIT;
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, ctrl0);
+		if (ret)
+			return ret;
+
+		// disable filters
+		for (i = 1; i <= 3; i++) {
+			ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+					 ONMPH_REG_MAC_ADDRFILTH(i), 0x00000000);
+			if (ret)
+				return ret;
+		}
+
+		return ret;
+	} else {
+		struct netdev_hw_addr *ha;
+		u32 addrh;
+		u32 addrl;
+		int i;
+
+		// Disable multicast filter
+		ret = onmph_rreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, &ctrl0);
+		if (ret)
+			return ret;
+
+		ctrl0 &= ~ONMPH_MAC_CONTROL_MCSF_BIT;
+
+		ret = onmph_wreg(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_CONTROL, ctrl0);
+		if (ret)
+			return ret;
+
+		// disable filters
+		for (i = 1; i <= 3; i++) {
+			ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+					 ONMPH_REG_MAC_ADDRFILTH(i), 0x00000000);
+			if (ret)
+				return ret;
+		}
+
+		i = 1;
+		netdev_for_each_mc_addr(ha, priv->ndev) {
+			if (i > 3)
+				break;
+
+			addrh = ((ha->addr[0] << 8) | ha->addr[1] |
+				 ONMPH_MAC_ADDRFILT_EN_BIT);
+			addrl = ((ha->addr[2] << 24) | (ha->addr[3] << 16) |
+				 (ha->addr[4] << 8) | (ha->addr[5]));
+
+			ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+					 ONMPH_REG_MAC_ADDRFILTH(i), addrh);
+			if (ret)
+				return ret;
+
+			ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+					 ONMPH_REG_MAC_ADDRFILTL(i), addrl);
+			if (ret)
+				return ret;
+
+			ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+					 ONMPH_REG_MAC_ADDRMASKL(i), 0xffffffff);
+			if (ret)
+				return ret;
+
+			ret = onmph_wreg(priv, ONMPH_MMS_MAC,
+					 ONMPH_REG_MAC_ADDRMASKH(i), 0x0000ffff);
+			if (ret)
+				return ret;
+			i++;
+		}
+
+		return ret;
+	}
+}
+
+// deferred function for applying RX mode flags in non-atomic context
+static int onmph_rx_mode_update(struct onmph_info *priv)
+{
+	unsigned int rx_flags;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	// apply the configuration changes
+	rx_flags = priv->rx_flags;
+	priv->rx_flags_upd = false;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	ret = onmph_set_promiscuous_mode(priv, rx_flags);
+	if (ret)
+		goto out;
+
+	ret = onmph_set_multicast_mode(priv, rx_flags);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static struct sk_buff *onmph_pop_tx_frame(struct onmph_info *priv,
+					  unsigned int *npkt)
+{
+	struct sk_buff *ret = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->tx_skb_q_sz) {
+		ret = list_first_entry(&priv->tx_skb_q, struct sk_buff, list);
+
+		__list_del_entry(&ret->list);
+		*npkt = --priv->tx_skb_q_sz;
+
+		if (netif_queue_stopped(priv->ndev) &&
+		    priv->tx_skb_q_sz < ONMPH_MAX_PENDING_TX_FRAMES / 2)
+			netif_wake_queue(priv->ndev);
+	} else {
+		// queue is empty
+		*npkt = 0;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+/* Breaks up parts of one or more skbs into chunks for transmission.
+ * This will create as many chunks as there is space available.
+ */
+static int onmph_prepare_tx_chunks(struct onmph_info *priv, bool *more)
+{
+	struct mph_dhdr_info pflags = { 0 };
+	struct sk_buff *skb = priv->tx_skb;
+	u32 *chdr = priv->tx_mem;
+	void *cdata = chdr + 1;
+	unsigned int nchk = 0;
+	unsigned int nwr = 0;
+	unsigned int npkt;
+	unsigned int n;
+
+	/* if we are congested, send a number of empty TX chunks for receiving,
+	 * or just one in case no RX frames are available.
+	 */
+	if (unlikely(!priv->tx_txc))
+		goto add_rx_chunks;
+
+	// load as many TX chunks as possible, up to the available credits
+	while (true) {
+		if (!skb) {
+			// get next SKB in the queue
+			skb = onmph_pop_tx_frame(priv, &npkt);
+
+			// no skb --> no party
+			if (!skb)
+				break;
+
+			pflags.swo = nwr >> 2;
+			pflags.sv = 1;
+			if (priv->tx_fcs_calc) {
+				int to_add;
+				u32 crc;
+
+				to_add = ETH_FCS_LEN +
+					 (skb->len >= ETH_ZLEN ? 0 : ETH_ZLEN - skb->len);
+
+				if (skb_tailroom(skb) < to_add) {
+					struct sk_buff *new_skb;
+
+					new_skb = skb_copy_expand(skb, 0,
+								  to_add - skb_tailroom(skb),
+								  GFP_KERNEL);
+					if (!new_skb) {
+						// Couldn't grow the skb, drop it and
+						// continue
+						dev_err(priv->dev,
+							"Unable to grow skb\n");
+						consume_skb(skb);
+						priv->ndev->stats.rx_dropped++;
+						continue;
+					}
+
+					consume_skb(skb);
+					skb = new_skb;
+				}
+
+				if (skb->len < ETH_ZLEN)
+					skb_put_zero(skb, ETH_ZLEN - skb->len);
+
+				crc = ~ether_crc_le(skb->len, skb->data);
+				skb_put_data(skb, &crc, sizeof(crc));
+			}
+		} else {
+			/* we don't need locking here, we're just accessing a
+			 * basic integer, and we don't care if we read the
+			 * old or the new value
+			 */
+			npkt = READ_ONCE(priv->tx_skb_q_sz);
+		}
+
+		// copy as much data as possible from the skb to the chunk
+		n = min(skb->len, priv->cps - nwr);
+		memcpy(cdata + nwr, skb->data, n);
+		priv->ndev->stats.tx_bytes += n;
+		nwr += n;
+
+		/* if there is no more data in the socket buffer, record the end
+		 * of frame within the chunk and prepare for loading the next
+		 * socket buffer
+		 */
+		if (skb->len == n) {
+			consume_skb(skb);
+			skb = NULL;
+
+			pflags.ev = 1;
+			pflags.ebo = nwr - 1;
+			nwr = round_up(nwr, 4);
+			priv->ndev->stats.tx_packets++;
+
+			/* if there is still room in the current chunk, and
+			 * there are more packets available, concatenate two
+			 * frames within the same chunk. That, unless the
+			 * current frame fits entirely in one chunk.
+			 */
+			if (npkt && nwr < priv->cps && !pflags.sv)
+				continue;
+		} else {
+			// consume data from the beginning of the socket buffer
+			skb_pull(skb, n);
+		}
+
+		// write the header
+		*chdr = onmph_mkdatahdr_txrx(&pflags);
+		chdr = cdata + priv->cps;
+
+		/* stop if we exhausted the available number of chunks, or we
+		 * don't have any further data to transmit
+		 */
+		if (++nchk == priv->tx_txc || (!npkt && !skb))
+			break;
+
+		// move to the next chunk
+		cdata = chdr + 1;
+
+		// reset the protocol flags & variables
+		memset(&pflags, 0, sizeof(pflags));
+		nwr = 0;
+	}
+
+	// save the current socket buffer being transmitted for the next round
+	priv->tx_skb = skb;
+
+	/* if at the end of the cycle we still have frames pending, schedule
+	 * another round immediately after this one
+	 */
+	if (skb || npkt)
+		*more = true;
+
+add_rx_chunks:
+
+	/* add as many empty chunks up to the maximum buffer size and up to
+	 * the receive chunks available to optimize RX
+	 */
+	for (n = max(priv->rx_rca, 1U); nchk < n; nchk++) {
+		*chdr = onmph_mkdatahdr_rx();
+		chdr = (void *)chdr + priv->csz;
+	}
+
+	return nchk;
+}
+
+// Initiates SPI transfer for tx/rx chunks
+static int onmph_do_txrx(struct onmph_info *priv, int nchk)
+{
+	struct spi_transfer st = { 0 };
+
+	// the TX chunks have been prepared in priv->tx_mem
+	st.tx_buf = priv->tx_mem;
+	st.rx_buf = priv->rx_mem;
+	st.len = priv->csz * nchk;
+
+	return spi_sync_transfer(priv->spi, &st, 1);
+}
+
+// Final processing of receive SKB before sending up network stack
+static int onmph_deliver_rx_skb(struct onmph_info *priv, int err)
+{
+	const int rxall = priv->ndev->features & NETIF_F_RXALL;
+	struct sk_buff *skb = priv->rx_skb;
+	unsigned int len;
+
+	if (err && !((err == -EIO) && rxall))
+		goto out_drop;
+
+	if (priv->rx_fcs_check) {
+		u32 *rx_fcs;
+		u32 crc;
+
+		crc = ~ether_crc_le(skb->len - 4, skb->data);
+		rx_fcs = (u32 *)&skb->data[skb->len - 4];
+
+		if (unlikely(crc != *rx_fcs) && !rxall) {
+			err = NET_RX_DROP;
+			goto out_drop;
+		}
+	}
+
+	if (likely(!(priv->ndev->features & NETIF_F_RXFCS)))
+		skb_trim(skb, skb->len - 4);
+
+	// set protocol from EtherType field
+	skb->protocol = eth_type_trans(skb, priv->ndev);
+
+	len = skb->len;
+	err = netif_rx(skb);
+	if (err == NET_RX_SUCCESS) {
+		priv->ndev->stats.rx_bytes += len;
+
+		priv->ndev->stats.rx_packets++;
+	}
+
+out:
+	priv->rx_skb = NULL;
+	return err;
+
+out_drop:
+	kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+	priv->ndev->stats.rx_dropped++;
+	goto out;
+}
+
+// process received chunks, assemble in skbs
+static int onmph_process_rx_chunks(struct onmph_info *priv, bool *more, int nchk)
+{
+	void *cdata = priv->rx_mem;
+	struct mph_dftr_info ftr;
+	unsigned int nrd;
+	int err = 0;
+	int n = 0;
+	u32 *cftr;
+
+	cftr = cdata + priv->cps;
+
+	while (true) {
+		err = onmph_parse_footer(*cftr, &ftr);
+
+		if (unlikely(err)) {
+			netdev_warn(priv->ndev, "footer parity error!\n");
+			priv->ndev->stats.rx_fifo_errors++;
+			// frame drop: skip everything until new SV without FD
+			priv->rx_skip = true;
+			if (priv->rx_skb)
+				onmph_deliver_rx_skb(priv, -EIO);
+
+			goto next_chunk;
+		}
+
+		if (unlikely(!ftr.sync)) {
+			// the macphy restarted unexpectedly, we need to
+			// stop the interface and let userspace handle the
+			// problem.
+			netdev_err(priv->ndev, "spurious reset detected!\n");
+
+			if (priv->rx_skb)
+				onmph_deliver_rx_skb(priv, -EIO);
+			return -EIO;
+		}
+
+		if (unlikely(ftr.hdrb)) {
+			priv->ndev->stats.rx_fifo_errors++;
+			netdev_warn(priv->ndev, "header bad detected!\n");
+		}
+
+		// skip empty chunks
+		if (!ftr.dv)
+			goto next_chunk;
+
+		if (ftr.fd) {
+			// frame drop: skip everything until new SV without FD
+			if (priv->rx_skb)
+				onmph_deliver_rx_skb(priv, -EIO);
+
+			priv->rx_skip = true;
+			goto next_chunk;
+		}
+
+		// if dropping the frame, skip chunks until a new SV
+		if (priv->rx_skip) {
+			if (!ftr.sv) {
+				priv->rx_skip = true;
+				goto next_chunk;
+			}
+
+			priv->rx_skip = false;
+		}
+
+		// handle data
+		if (priv->rx_skb) {
+			/* this chunk shall contain the continuation or the end
+			 * of a packet
+			 */
+			if (ftr.sv && (!ftr.ev || ftr.ebo >= ftr.sbo)) {
+				netdev_warn(priv->ndev,
+					    "SPI protocol error (repeated SV)");
+
+				priv->rx_skip = true;
+
+				// discard frame
+				onmph_deliver_rx_skb(priv, -EPROTO);
+				goto next_chunk;
+			}
+
+			// calculate the amount of valid data in the chunk
+			nrd = ftr.ev ? ftr.ebo + 1 : priv->cps;
+
+			// check that there is enough room left in the buffer
+			if (unlikely(priv->rx_skb->len + nrd > priv->mtu)) {
+				netdev_err(priv->ndev,
+					   "received frame exceeds the MTU!");
+
+				priv->rx_skip = true;
+
+				// discard frame
+				onmph_deliver_rx_skb(priv, -EPROTO);
+				goto next_chunk;
+			}
+
+			// copy data to the socket buffer
+			skb_put_data(priv->rx_skb, cdata, nrd);
+
+			if (!ftr.ev) {
+				// intermediate chunk --> keep going
+				goto next_chunk;
+			}
+
+			// the socket buffer is ready to be delivered
+			onmph_deliver_rx_skb(priv, err);
+
+			if (!ftr.sv) {
+				// end of frame w/o concatenation
+				goto next_chunk;
+			}
+
+			// handle concatenation
+			ftr.ev = 0;
+		}
+
+		// this chunk shall contain the start of a packet
+		if (!ftr.sv) {
+			netdev_warn(priv->ndev,
+				    "SPI protocol error (missing SV)");
+
+			priv->rx_skip = true;
+			goto next_chunk;
+		}
+
+		priv->rx_skb = netdev_alloc_skb_ip_align(priv->ndev, priv->mtu);
+		if (unlikely(!priv->rx_skb)) {
+			netdev_err(priv->ndev, "cannot allocate RX skb!\n");
+			// No memory available, skip the chunk
+			break;
+		}
+
+		// adjust the offset of the data within the chunk
+		cdata += ftr.sbo;
+
+		// calculate the number of valid bytes within the chunk
+		nrd = priv->cps - ftr.sbo;
+
+		// copy data to the socket
+		skb_put_data(priv->rx_skb, cdata, nrd);
+
+		if (ftr.ev)
+			onmph_deliver_rx_skb(priv, err);
+
+next_chunk:
+		// stop if we processed all the chunks
+		if (++n == nchk)
+			break;
+
+		// move to next footer
+		cdata = cftr + 1;
+		cftr = cdata + priv->cps;
+	}
+
+	// use the last footer to retrieve status information
+	if (ftr.exst)
+		priv->event_pending = true;
+
+	priv->tx_txc = ftr.txc;
+	priv->rx_rca = ftr.rca;
+
+	if (ftr.rca > 0)
+		*more = true;
+
+	return 0;
+}
+
+// Check for and handle any PHY events
+static int onmph_process_events(struct onmph_info *priv)
+{
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	if (!priv->event_pending)
+		return 0;
+
+	priv->event_pending = false;
+
+	ret = onmph_rreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_ST0, &val);
+	if (ret) {
+		dev_err(priv->dev, "Error reading ST0 register: %d\n", ret);
+		return ret;
+	}
+
+	if ((val & ONMPH_SPI_ST0_PHYINT_BIT) && priv->phy_virq != PHY_POLL) {
+		spin_lock_irqsave(&priv->lock, flags);
+		if (priv->phy_irq_en) {
+			spin_unlock_irqrestore(&priv->lock, flags);
+			generic_handle_irq_safe(priv->phy_virq);
+		} else {
+			priv->phy_irq_pending = true;
+			spin_unlock_irqrestore(&priv->lock, flags);
+		}
+	}
+
+	// acknowledge all handled events
+	ret = onmph_wreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_ST0, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+// kernel thread for MACPHY protocol handling
+static int onmph_thread_fun(void *data)
+{
+	struct onmph_info *priv = data;
+	signed long tout = priv->poll_jiff;
+	bool update_rx_mode = false;
+	struct net_device *ndev;
+	unsigned long flags;
+	bool more;
+	int ret;
+
+	ndev = priv->ndev;
+	// IRQ was created disabled to allow the task to start first
+	enable_irq(ndev->irq);
+
+	do {
+		if (update_rx_mode) {
+			// check RX mode flags
+			ret = onmph_rx_mode_update(priv);
+			if (unlikely(ret)) {
+				netdev_err(ndev, "failed to set new RX mode\n");
+				break;
+			}
+		}
+
+		if (tout == 0) {
+			// reload polling timer
+			tout = priv->poll_jiff;
+
+			// force checking the status register
+			priv->event_pending = true;
+		}
+
+		do {
+			int chunks;
+
+			more = false;
+
+			// process pending TX frames, if any
+			chunks = onmph_prepare_tx_chunks(priv, &more);
+
+			// process "ret" chunks
+			if (onmph_do_txrx(priv, chunks) != 0) {
+				// if we get here, there was an SPI error
+				// and we can't recover here
+				ret = -EIO;
+				break;
+			}
+
+			// analyze received footer(s) and handle RX
+			ret = onmph_process_rx_chunks(priv, &more, chunks);
+			if (ret)
+				break;
+
+			// process any interrupt / event from the device
+			onmph_process_events(priv);
+		} while (more);
+
+		// Unrecoverable error - disable irq, exit thread
+		if (unlikely(ret))
+			goto err_unrecoverable;
+
+		// handle new IRQs or sleep
+
+		spin_lock_irqsave(&priv->lock, flags);
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		update_rx_mode = priv->rx_flags_upd;
+		ret = priv->irq_pending || priv->tx_skb_q_sz || update_rx_mode;
+
+		priv->irq_pending = false;
+		spin_unlock_irqrestore(&priv->lock, flags);
+
+		if (!ret)
+			tout = schedule_timeout(tout);
+		else
+			set_current_state(TASK_RUNNING);
+	} while (!kthread_should_stop());
+
+	return 0;
+
+err_unrecoverable:
+	disable_irq(ndev->irq);
+	return ret;
+}
+
+// MACPHY ISR - wakeup the handler thread
+static irqreturn_t onmph_interrupt(int irq, void *dev)
+{
+	struct onmph_info *priv = netdev_priv(dev);
+
+	priv->irq_pending = true;
+
+	// wakeup the kthread
+	return wake_up_process(priv->thread) ? IRQ_HANDLED : IRQ_NONE;
+}
+
+// phylink mac ops ---------------------------------------------------------- //
+// The phylink callbacks are required, but we don't need to do anything in them
+static void onmph_phylink_mac_link_up(struct phylink_config *config,
+				      struct phy_device *phy, unsigned int mode,
+				      phy_interface_t interface, int speed,
+				      int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+static void onmph_phylink_mac_link_down(struct phylink_config *config,
+					unsigned int mode,
+					phy_interface_t interface)
+{
+}
+
+static void onmph_phylink_mac_config(struct phylink_config *config,
+				     unsigned int mode,
+				     const struct phylink_link_state *state)
+{
+}
+
+static const struct phylink_mac_ops onmph_phylink_mac_ops = {
+	.validate = phylink_generic_validate,
+	.mac_config = onmph_phylink_mac_config,
+	.mac_link_down = onmph_phylink_mac_link_down,
+	.mac_link_up = onmph_phylink_mac_link_up,
+};
+
+// netdev ops --------------------------------------------------------------- //
+
+static int onmph_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+	struct onmph_info *priv = netdev_priv(ndev);
+	int ret = -EOPNOTSUPP;
+
+	if (!netif_running(ndev))
+		return -EINVAL;
+
+	switch (cmd) {
+	case SIOCGMIIPHY:
+	case SIOCGMIIREG:
+	case SIOCSMIIREG:
+		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+// Updates address list filtering
+static void onmph_set_rx_mode(struct net_device *ndev)
+{
+	struct onmph_info *priv = netdev_priv(ndev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	priv->rx_flags_upd = true;
+	priv->rx_flags = ndev->flags;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	wake_up_process(priv->thread);
+}
+
+// Sets MAC address
+static int onmph_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(ndev, addr->sa_data);
+	return onmph_set_mac_filter(ndev, addr->sa_data);
+}
+
+// Add TX skb to queue of outgoing SKBs and wake up handler thread
+static netdev_tx_t onmph_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct onmph_info *priv = netdev_priv(ndev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	// add the socket to the coaleshing list
+	list_add_tail(&skb->list, &priv->tx_skb_q);
+
+	// apply TX flow control
+	if (++priv->tx_skb_q_sz >= ONMPH_MAX_PENDING_TX_FRAMES) {
+		// suspend TX queue until we flushed out some frames
+		netif_stop_queue(ndev);
+	}
+
+	// wakeup the kthread
+	wake_up_process(priv->thread);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return NETDEV_TX_OK;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+
+static void onmph_poll_controller(struct net_device *ndev)
+{
+	disable_irq(ndev->irq);
+	onmph_interrupt(ndev->irq, ndev);
+	enable_irq(ndev->irq);
+}
+
+#endif
+
+// Brings up network interface
+static int onmph_open(struct net_device *ndev)
+{
+	struct onmph_info *priv = netdev_priv(ndev);
+	int ret;
+
+	// request the IRQ
+	priv->irq_pending = false;
+	if (request_irq(ndev->irq, &onmph_interrupt, IRQF_NO_AUTOEN, ndev->name, ndev)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	ret = onmph_init(priv);
+	if (unlikely(ret)) {
+		netdev_err(ndev, "failed to initialize the device");
+		goto err_phy_connect;
+	}
+
+	// connect to the PHY
+	ret = phylink_fwnode_phy_connect(priv->phylink, priv->dev->fwnode, 0);
+
+	if (ret) {
+		netdev_err(priv->ndev,
+			   "could not connect to the PHY, err = %d\n", ret);
+
+		ret = -ENODEV;
+		goto err_phy_connect;
+	}
+
+	// start the PHY
+	phylink_start(priv->phylink);
+
+	// create and start the main thread
+	priv->thread = kthread_run(onmph_thread_fun, priv, DRV_NAME "/%s:%d",
+				   dev_name(&priv->spi->dev),
+				   priv->spi->chip_select);
+
+	if (IS_ERR(priv->thread)) {
+		ret = PTR_ERR(priv->thread);
+		goto err_create_thread;
+	}
+
+	return 0;
+
+err_create_thread:
+	phylink_disconnect_phy(priv->phylink);
+
+err_phy_connect:
+	free_irq(ndev->irq, ndev);
+
+out:
+	return ret;
+}
+
+// Brings down network interface
+static int onmph_stop(struct net_device *ndev)
+{
+	struct onmph_info *priv = netdev_priv(ndev);
+
+	// stop the MAC
+	onmph_shutdown(priv);
+
+	// stop the thread and wait
+	kthread_stop(priv->thread);
+	priv->thread = NULL;
+
+	// stop the PHY
+	phylink_stop(priv->phylink);
+
+	// disconnect from the PHY
+	phylink_disconnect_phy(priv->phylink);
+
+	// release IRQs
+	free_irq(ndev->irq, ndev);
+
+	// free the rx skb
+	if (priv->rx_skb)
+		kfree_skb(priv->rx_skb);
+
+	return 0;
+}
+
+// mask the interrupt source
+static void onmph_irq_mask(struct irq_data *d)
+{
+	struct onmph_info *priv = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->phy_irq_en = false;
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+// unmask the interrupt source
+static void onmph_irq_unmask(struct irq_data *d)
+{
+	struct onmph_info *priv = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->phy_irq_en = true;
+
+	if (priv->phy_irq_pending) {
+		priv->phy_irq_pending = false;
+		spin_unlock_irqrestore(&priv->lock, flags);
+
+		generic_handle_irq_safe(priv->phy_virq);
+	} else {
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
+}
+
+// Create mapping between virtual and hardware irq numbers
+static int onmph_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	struct onmph_info *priv = d->host_data;
+
+	irq_set_chip_and_handler(irq, &priv->irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, priv);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+// Remove mapping between virtual and hardware irq numbers
+static void onmph_irqdomain_unmap(struct irq_domain *d, unsigned int irq)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+	irq_set_chip_data(irq, NULL);
+}
+
+// callbacks for irq_domain objects
+static const struct irq_domain_ops onmphirqd_ops = {
+	.map = onmph_irqdomain_map,
+	.unmap = onmph_irqdomain_unmap,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static const struct net_device_ops onmph_netdev_ops = {
+	.ndo_open	     = onmph_open,
+	.ndo_stop	     = onmph_stop,
+	.ndo_start_xmit	     = onmph_start_xmit,
+	.ndo_set_mac_address = onmph_set_mac_address,
+	.ndo_eth_ioctl	     = onmph_ioctl,
+	.ndo_set_rx_mode     = onmph_set_rx_mode,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = onmph_poll_controller,
+#endif
+};
+
+// convert the PHY's MMDs into MACPHY's MMSs
+static int mmd2mms(int mmd)
+{
+	int ret;
+
+	switch (mmd) {
+	case MDIO_MMD_PMAPMD:
+		ret = ONMPH_MMS_PMA;
+		break;
+
+	case MDIO_MMD_PCS:
+		ret = ONMPH_MMS_PCS;
+		break;
+
+	case MDIO_MMD_VEND1:
+		ret = ONMPH_MMS_VS;
+		break;
+
+	case MDIO_MMD_VEND2:
+		ret = ONMPH_MMS_PLCA_VEND2;
+		break;
+
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+// Read MDIO clause 45 register
+static int onmph_mdio_read_c45(struct mii_bus *bus, int addr, int devnum,
+			       int regnum)
+{
+	struct onmph_info *priv = bus->priv;
+	int mms;
+	u32 val;
+	int ret;
+
+	// we support only PHY #0 at this time
+	if (addr != 0)
+		return -ENODEV;
+
+	if (regnum < 0 || regnum > 0xffff)
+		return -ENXIO;
+
+	mms = mmd2mms(devnum);
+	if (mms < 0)
+		return mms;
+
+	ret = onmph_rreg(priv, mms, regnum, &val);
+	return ret < 0 ? ret : (int)val;
+}
+
+// Read clause MDIO register
+static int onmph_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct onmph_info *priv = bus->priv;
+	int mmd;
+	int mms;
+	int cmd;
+	u32 val;
+	int ret;
+
+	// we support only PHY #0 at this time
+	if (addr != 0)
+		return -ENODEV;
+
+	if (regnum < 0 || regnum > 31)
+		return -ENXIO;
+
+	if (regnum == MII_MMD_CTRL) {
+		// emulate c22 to c45 control access
+		return priv->mii_c45_ctrl;
+	}
+
+	if (regnum == MII_MMD_DATA) {
+		// emulate c22 to c45 data access
+		cmd = priv->mii_c45_ctrl & ~MII_MMD_CTRL_DEVAD_MASK;
+		mmd = priv->mii_c45_ctrl & MII_MMD_CTRL_DEVAD_MASK;
+
+		if (cmd == MII_MMD_CTRL_ADDR) {
+			// just return the indirect address for this mmd
+			return priv->mii_c45_addr[mmd];
+		}
+
+		// do read clause 45 register
+		ret = onmph_mdio_read_c45(bus, addr, mmd,
+					  priv->mii_c45_addr[mmd]);
+		if (ret < 0)
+			return ret;
+
+		switch (cmd) {
+		case MII_MMD_CTRL_INCR_ON_WT:
+			fallthrough;
+		case MII_MMD_CTRL_NOINCR:
+			// no increment --> done!
+			break;
+
+		case MII_MMD_CTRL_INCR_RDWT:
+			// increment address
+			priv->mii_c45_addr[mmd]++;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		return ret;
+	}
+
+	if (priv->version == 0x01) {
+		// WA: due to an HW bug the PHYID does get updated
+		// when there is a new OUI assigned to onsemi
+		// Therefore, we force overwriting the PHYID on read
+		// to the 60:C0:BF OUI
+		if (regnum == MII_PHYSID1) {
+			// overwrite PHYID reg 2
+			return 0x180f;
+		} else if (regnum == MII_PHYSID2) {
+			// overrite PHYID reg 3
+			return 0xf5a1;
+		}
+	}
+
+	if (regnum < 16) {
+		// standard register, map to MMS SPI w/ offset
+		mms = ONMPH_MMS_SPI_MII;
+		regnum |= 0xff00;
+	} else {
+		// vendor specific register, map to specific MMS
+		mms = ONMPH_MMS_VS;
+	}
+
+	ret = onmph_rreg(priv, mms, regnum, &val);
+	return ret ? ret : (int)val;
+}
+
+// Write MDIO clause 45 register
+static int onmph_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
+				int regnum, u16 val)
+{
+	struct onmph_info *priv = bus->priv;
+	int mms;
+
+	// we support only PHY #0 at this time
+	if (addr != 0)
+		return -ENODEV;
+
+	if (regnum < 0 || regnum > 0xffff)
+		return -ENXIO;
+
+	mms = mmd2mms(devnum);
+	if (mms < 0)
+		return mms;
+
+	return onmph_wreg(priv, mms, regnum, val);
+}
+
+// Write MDIO register
+static int onmph_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
+{
+	struct onmph_info *priv = bus->priv;
+	int mmd;
+	int mms;
+	int cmd;
+	int ret;
+
+	// we support only PHY #0 at this time
+	if (addr != 0)
+		return -ENODEV;
+
+	if (regnum < 0 || regnum > 31)
+		return -ENXIO;
+
+	if (regnum == MII_MMD_CTRL) {
+		// emulate c22 to c45 control access
+		priv->mii_c45_ctrl = val;
+		return 0;
+	}
+
+	if (regnum == MII_MMD_DATA) {
+		// emulate c22 to c45 data access
+		cmd = priv->mii_c45_ctrl & ~MII_MMD_CTRL_DEVAD_MASK;
+		mmd = priv->mii_c45_ctrl & MII_MMD_CTRL_DEVAD_MASK;
+
+		if (cmd == MII_MMD_CTRL_ADDR) {
+			// just record the indirect address for this mmd
+			priv->mii_c45_addr[mmd] = val;
+			return 0;
+		}
+
+		// do write clause 45 register
+		ret = onmph_mdio_write_c45(bus, addr, mmd,
+					   priv->mii_c45_addr[mmd], val);
+		if (ret < 0)
+			return ret;
+
+		switch (cmd) {
+		case MII_MMD_CTRL_NOINCR:
+			// no increment --> done!
+			break;
+
+		case MII_MMD_CTRL_INCR_RDWT:
+			fallthrough;
+		case MII_MMD_CTRL_INCR_ON_WT:
+			// increment address
+			priv->mii_c45_addr[mmd]++;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	// WA: prevent the PHY from being reset from the control register. The
+	// NCN26010 triggers a global soft-reset when resetting the PHY.
+	if (regnum == MII_BMCR && (val & BMCR_RESET))
+		val &= ~BMCR_RESET;
+
+	if (regnum < 16) {
+		// standard register, map to MMS SPI w/ offset
+		mms = ONMPH_MMS_SPI_MII;
+		regnum |= 0xff00;
+	} else {
+		// vendor specific register, map to specific MMS
+		mms = ONMPH_MMS_VS;
+	}
+
+	return onmph_wreg(priv, mms, regnum, val);
+}
+
+// Create the pseudo MDIO bus for accessing PHY regs
+static int onmph_mdiobus_create(struct onmph_info *priv)
+{
+	struct mii_bus *mdio_bus;
+	int ret;
+
+	mdio_bus = devm_mdiobus_alloc(priv->dev);
+	if (!mdio_bus) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	snprintf(priv->mdio_bus_name, MII_BUS_ID_SIZE, "%s:%s:%u", "NCN26010",
+		 dev_name(&priv->spi->dev), priv->spi->chip_select);
+
+	mdio_bus->priv = priv;
+	mdio_bus->parent = priv->dev;
+
+	// These two are required for phylink to work properly.
+	device_set_of_node_from_dev(&mdio_bus->dev, priv->dev);
+	device_set_node(&mdio_bus->dev, priv->dev->fwnode);
+
+	mdio_bus->name = priv->mdio_bus_name;
+	mdio_bus->read = onmph_mdio_read;
+	mdio_bus->write = onmph_mdio_write;
+	mdio_bus->read_c45 = onmph_mdio_read_c45;
+	mdio_bus->write_c45 = onmph_mdio_write_c45;
+
+	mdio_bus->phy_mask = ~((u32)GENMASK(0, 0));
+
+	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s", dev_name(priv->dev));
+
+	ret = mdiobus_register(mdio_bus);
+	if (ret)
+		goto err_register;
+
+	priv->mdio_bus = mdio_bus;
+	return 0;
+
+err_register:
+	mdiobus_free(mdio_bus);
+
+err_alloc:
+	return ret;
+}
+
+// Create phy interface for accessing phy part of MACPHY
+static int onmph_phy_create(struct onmph_info *priv)
+{
+	struct fwnode_handle *mac_fwn = priv->dev->fwnode;
+	struct net_device *ndev = priv->ndev;
+	struct fwnode_handle *phy_fwn;
+	phy_interface_t phy_mode;
+
+	phy_mode = fwnode_get_phy_mode(mac_fwn);
+	if (phy_mode < 0) {
+		netdev_err(ndev, "incorrect phy-mode\n");
+		return phy_mode;
+	}
+
+	phy_fwn = fwnode_get_phy_node(mac_fwn);
+	if (IS_ERR(phy_fwn)) {
+		netdev_err(ndev, "cannot find PHY device node\n");
+		return PTR_ERR(phy_fwn);
+	}
+
+	priv->phy = fwnode_phy_find_device(phy_fwn);
+	if (IS_ERR(priv->phy)) {
+		netdev_err(ndev, "cannot get PHY from device node\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	priv->phy->irq = priv->phy_virq;
+
+	priv->phylink_config.dev = &ndev->dev;
+	priv->phylink_config.type = PHYLINK_NETDEV;
+
+	priv->phylink_config.mac_capabilities = MAC_10;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  priv->phylink_config.supported_interfaces);
+
+	priv->phylink = phylink_create(&priv->phylink_config, mac_fwn, phy_mode,
+				       &onmph_phylink_mac_ops);
+
+	if (IS_ERR(priv->phylink))
+		return PTR_ERR(priv->phylink);
+
+	return 0;
+}
+
+// Bind driver to SPI device, begin initialization
+static int onmph_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *devid = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
+	struct fwnode_handle *fwn;
+	struct net_device *ndev;
+	struct onmph_info *priv;
+	u32 val;
+	u32 model;
+	int ret;
+
+	fwn = dev->fwnode;
+
+	// allocate net device and related private data
+	ndev = devm_alloc_etherdev(dev, sizeof(struct onmph_info));
+	if (!ndev) {
+		ret = -ENOMEM;
+		goto err_netdev_alloc;
+	}
+
+	priv = netdev_priv(ndev);
+	SET_NETDEV_DEV(ndev, dev);
+
+	// initialize private data
+	spin_lock_init(&priv->lock);
+	INIT_LIST_HEAD(&priv->tx_skb_q);
+
+	priv->dev = dev;
+	priv->spi = spi;
+	priv->ndev = ndev;
+
+	priv->cps = MPH_MAX_CPS;
+	priv->csz = priv->cps + 4; // + 4 for header or footer
+
+	priv->mtu = ONMPH_MAX_FRAME_SIZE;
+
+	priv->irq_chip.name = dev->driver->name;
+	priv->irq_chip.irq_mask = onmph_irq_mask;
+	priv->irq_chip.irq_unmask = onmph_irq_unmask;
+
+	priv->tx_mem = devm_kmalloc(dev, MPH_MAX_CRED * priv->csz, GFP_KERNEL);
+	priv->rx_mem = devm_kmalloc(dev, MPH_MAX_CRED * priv->csz, GFP_KERNEL);
+
+	if (!priv->tx_mem || !priv->rx_mem) {
+		ret = -ENOMEM;
+		goto err_netdev_alloc;
+	}
+
+	// initialize SPI parameters
+	spi->dev.platform_data = priv;
+
+	// configure SPI for OATC14 MACPHY protocol
+	spi->mode = SPI_MODE_0; // CPOL=0, CPHA=0, MSB first
+	spi->bits_per_word = 8;
+
+	// initialize netdev
+	ndev->netdev_ops = &onmph_netdev_ops;
+	ndev->ethtool_ops = &onmph_ethtool_ops;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+
+	// set supported changeable features
+	// NETIF_F_RXFCS     --> append FCS to skb (default off)
+	// NETIF_F_RXALL     --> receive errored frames (default off)
+	ndev->hw_features = NETIF_F_RXFCS | NETIF_F_RXALL;
+
+	// get model & version
+	priv->model = devid->driver_data;
+
+	/* Start with non-protected control accesses for single register reads.
+	 * NOTE: the device starts in this mode after reset, but it is possible
+	 * that the PROTE bit was set by a previous module load/unload.
+	 * In this case, non-protected register writes won't work, but -single-
+	 * unprotected register reads will. Therefore, we can safely probe the
+	 * device using regular control accesses and switch to protected mode
+	 * later, when resetting the device.
+	 */
+	ret = onmph_rreg(priv, ONMPH_MMS_VS, ONMPH_REG_VS_CHIPID, &val);
+	if (ret)
+		goto err_model;
+
+	model = (val & ~ONMPH_CHIPID_MODEL_MASK) >> ONMPH_CHIPID_MODEL_SHIFT;
+	if (priv->model != model) {
+		dev_err(priv->dev, "unrecognized macphy model 0x%08x\n", model);
+
+		ret = -ENODEV;
+		goto err_model;
+	}
+
+	priv->version = (val & ONMPH_CHIPID_REVISION_MASK) >> ONMPH_CHIPID_REVISION_SHIFT;
+
+	ret = onmph_rreg(priv, ONMPH_MMS_SPI_MII, ONMPH_REG_SPI_CFG0, &val);
+	if (ret) {
+		dev_err(priv->dev, "failed to read CFG0 register\n");
+		goto err_model;
+	}
+
+	// If the device is already configured for protected register accesses,
+	// switch to protected mode now, otherwise we would not even be able to
+	// reset it.
+	if (val & ONMPH_SPI_CFG0_PROTE_BIT)
+		priv->ctrl_protected = true;
+
+	if (val & ONMPH_SPI_CFG0_SYNC_BIT) {
+		// The device is already configured --> reset it now
+		ret = onmph_reset(priv);
+		if (ret) {
+			dev_err(priv->dev, "device reset failed\n");
+			goto err_reset;
+		}
+	}
+
+	if (device_property_read_u32(priv->dev, "poll-interval", &val))
+		val = 5;
+
+	priv->poll_jiff = HZ * val;
+
+	// model-specific initializations/fixups
+	switch (priv->model) {
+	case ONMPH_MODEL_NCN26010:
+		priv->capabilities = ONMPH_CAP_MACADDR;
+
+		if (priv->version == 0x01) {
+			// WA: due to an HW bug the PHY irq may not be fired.
+			// Therefore, we force polling for this device.
+			priv->phy_virq = PHY_POLL;
+		}
+		break;
+	}
+
+	priv->tx_fcs_calc = device_property_read_bool(priv->dev,
+						      "tx-fcs-calc");
+	if (priv->tx_fcs_calc)
+		dev_info(priv->dev, "TX frame SW FCS calculation enabled\n");
+
+	priv->rx_fcs_check =
+		device_property_read_bool(priv->dev, "rx-fcs-check");
+	if (priv->rx_fcs_check)
+		dev_info(priv->dev, "RX frame SW FCS check enabled\n");
+
+	// get the MAC address from DT
+	ret = device_get_ethdev_address(dev, ndev);
+
+	// if failed, try reading from NVM
+	if (ret && (priv->capabilities & ONMPH_CAP_MACADDR))
+		ret = onmph_read_mac_from_nvmem(priv);
+
+	// use a random MAC as a last resort
+	if (ret) {
+		eth_hw_addr_random(ndev);
+		dev_warn(dev, "using random MAC address %pM\n", ndev->dev_addr);
+	}
+
+	dev_info(priv->dev, "onsemi macphy model %s, version %u\n",
+		 onmph_id_to_name(priv->model), priv->version);
+
+	// netdev structure initialization
+	ndev->irq = fwnode_irq_get(fwn, 0);
+	if (ndev->irq == -ENXIO) {
+		dev_err(priv->dev, "failed to map onmph IRQ\n");
+		ret = ndev->irq;
+
+		goto err_irq;
+	}
+
+	// initialize PHY IRQ emulation
+	if (priv->phy_virq != PHY_POLL) {
+		priv->irqdm =
+			irq_domain_create_linear(fwn, 1, &onmphirqd_ops, priv);
+		if (IS_ERR(priv->irqdm))
+			goto err_irqdomain;
+
+		priv->phy_virq = irq_create_mapping(priv->irqdm, 0);
+	}
+
+	// initialize the virtual MDIO bus
+	ret = onmph_mdiobus_create(priv);
+	if (ret)
+		goto err_mdiobus;
+
+	// configures priv->phylink
+	ret = onmph_phy_create(priv);
+	if (ret)
+		goto err_no_phy;
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(dev, "failed to register the ONMPH device\n");
+		ret = -ENODEV;
+
+		goto err_netdev_register;
+	}
+
+	// success
+	return 0;
+
+err_netdev_register:
+	phylink_destroy(priv->phylink);
+
+err_no_phy:
+err_mdiobus:
+	if (priv->phy_virq != PHY_POLL) {
+		irq_dispose_mapping(priv->phy_virq);
+		irq_domain_remove(priv->irqdm);
+	}
+
+err_irqdomain:
+	irq_dispose_mapping(ndev->irq);
+
+err_irq:
+err_reset:
+err_model:
+err_netdev_alloc:
+	dev_err(priv->dev, "could not initialize macphy, err = %d\n", ret);
+	return ret;
+}
+
+static void onmph_remove(struct spi_device *spi)
+{
+	struct onmph_info *priv = spi->dev.platform_data;
+	struct net_device *ndev = priv->ndev;
+
+	unregister_netdev(ndev);
+	phylink_destroy(priv->phylink);
+
+	mdiobus_unregister(priv->mdio_bus);
+	of_node_put(priv->mdio_bus->dev.of_node);
+
+	if (priv->phy_virq != PHY_POLL) {
+		irq_dispose_mapping(priv->phy_virq);
+		irq_domain_remove(priv->irqdm);
+	}
+
+	irq_dispose_mapping(ndev->irq);
+}
+
+static const struct of_device_id onmph_of_match[] = {
+	{ .compatible = "onnn,ncn26010" },
+	{}
+};
+
+static const struct spi_device_id onmph_ids[] = {
+	{ "ncn26010", ONMPH_MODEL_NCN26010 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, onmph_ids);
+
+static struct spi_driver onsemi_onmph_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.of_match_table = onmph_of_match,
+	},
+	.probe		= onmph_probe,
+	.remove		= onmph_remove,
+	.id_table	= onmph_ids,
+};
+
+module_spi_driver(onsemi_onmph_driver);
+
+MODULE_AUTHOR("Piergiorgio Beruto <piergiorgio.beruto@gmail.com>");
+MODULE_AUTHOR("Jay Monkman <jtm@lopingdog.com>");
+MODULE_DESCRIPTION("onsemi MACPHY ethernet driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/onsemi/onsemi_macphy_ethtool.c b/drivers/net/ethernet/onsemi/onsemi_macphy_ethtool.c
new file mode 100644
index 000000000000..131b5112db38
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/onsemi_macphy_ethtool.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+/*
+ * onsemi MACPHY ethernet driver
+ * Copyright (c) 2022 onsemi
+ */
+
+#include "onsemi_macphy.h"
+#include <linux/ethtool.h>
+
+// constants ---------------------------------------------------------------- //
+
+static const char onmph_stat_strings[][ETH_GSTRING_LEN] = {
+	"tx-bytes-ok",
+	"tx-frames",
+	"tx-broadcast-frames",
+	"tx-multicast-frames",
+	"tx-64-frames",
+	"tx-65-127-frames",
+	"tx-128-255-frames",
+	"tx-256-511-frames",
+	"tx-512-1023-frames",
+	"tx-1024-1518-frames",
+	"tx-underrun-errors",
+	"tx-single-collision",
+	"tx-multiple-collision",
+	"tx-excessive-collision",
+	"tx-deferred-frames",
+	"tx-carrier-sense-errors",
+	"rx-bytes-ok",
+	"rx-frames",
+	"rx-broadcast-frames",
+	"rx-multicast-frames",
+	"rx-64-frames",
+	"rx-65-127-frames",
+	"rx-128-255-frames",
+	"rx-256-511-frames",
+	"rx-512-1023-frames",
+	"rx-1024-1518-frames",
+	"rx-runt",
+	"rx-too-long-frames",
+	"rx-crc-errors",
+	"rx-symbol-errors",
+	"rx-alignment-errors",
+	"rx-busy-drop-frames",
+	"rx-mismatch-drop-frames",
+};
+
+#define ONMPH_STATS_LEN ARRAY_SIZE(onmph_stat_strings)
+static_assert(ONMPH_STATS_LEN == ONMPH_STATS_NUM);
+
+// helper functions --------------------------------------------------------- //
+
+#define STAT_REG_OFFSET(x) ((ONMPH_REG_MAC_ST##x) - ONMPH_REG_MAC_FIRST_STAT)
+
+#define STAT_OFF_TX_BYTES_OK 0
+#define STAT_OFF_TX_FRAMES 1
+
+static void onmph_update_mac_stats(struct onmph_info *priv)
+{
+	u64 *data = priv->stats_data;
+	u64 tx_frames_before;
+	u32 *regs, *rptr;
+	int ret;
+
+	// read all registers at once
+	regs = kmalloc_array(ONMPH_STATS_LEN, sizeof(u32), GFP_ATOMIC);
+	ret = onmph_rregs(priv, ONMPH_MMS_MAC, ONMPH_REG_MAC_STOCTECTSTXL,
+			  ONMPH_NUMBER_OF_STAT_REGS, regs);
+
+	if (ret)
+		goto out;
+
+	rptr = regs;
+
+	// WA for NCN26010 version 0x01
+	tx_frames_before = priv->stats_data[STAT_OFF_TX_FRAMES];
+
+	// TX bytes is a 64-bit register that spans over two 32-bit regs
+	// note: HW does auto-freeze when reading LSB and un-freeze on MSB
+	*(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+	// run until the next 64-bit register
+	for (rptr += 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rptr)
+		*(data++) += *rptr;
+
+	// RX bytes is a 64-bit register that spans over two 32-bit regs
+	// note: HW does auto-freeze when reading LSB and un-freeze on MSB
+	*(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+	// copy everything else
+	for (rptr += 2; (rptr - regs) < ONMPH_NUMBER_OF_STAT_REGS; ++rptr)
+		*(data++) += *rptr;
+
+	// model-specific fixes
+	switch (priv->model) {
+	case ONMPH_MODEL_NCN26010:
+		if (priv->version == 0x01) {
+			// add 4 to transmitted bytes for each transmitted packet
+			// because the HW is not counting the FCS
+			priv->stats_data[STAT_OFF_TX_BYTES_OK] +=
+				4 * (priv->stats_data[STAT_OFF_TX_FRAMES] -
+				     tx_frames_before);
+		}
+		break;
+	}
+out:
+	kfree(regs);
+}
+
+// ethtool ops -------------------------------------------------------------- //
+
+static void onmph_get_drvinfo(struct net_device *dev,
+			      struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(&dev->dev), sizeof(info->bus_info));
+	strscpy(info->version, DRV_VERSION, sizeof(info->version));
+}
+
+static int onmph_ethtool_set_link_ksettings(struct net_device *dev,
+					    const struct ethtool_link_ksettings *cmd)
+{
+	struct onmph_info *priv = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
+}
+
+static int onmph_ethtool_get_link_ksettings(struct net_device *dev,
+					    struct ethtool_link_ksettings *cmd)
+{
+	struct onmph_info *priv = netdev_priv(dev);
+
+	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
+}
+
+static int onmph_get_sset_count(struct net_device *dev, int sset)
+{
+	int ret;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		ret = ONMPH_STATS_LEN;
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static void onmph_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	memcpy(buf, onmph_stat_strings, ONMPH_STATS_LEN * ETH_GSTRING_LEN);
+}
+
+static void onmph_get_ethtool_stats(struct net_device *dev,
+				    struct ethtool_stats *stats, u64 *data)
+{
+	struct onmph_info *priv = netdev_priv(dev);
+
+	onmph_update_mac_stats(priv);
+	memcpy(data, priv->stats_data, sizeof(priv->stats_data));
+}
+
+// -------------------------------------------------------------------------- //
+
+const struct ethtool_ops onmph_ethtool_ops = {
+	.get_drvinfo		= onmph_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= onmph_ethtool_get_link_ksettings,
+	.set_link_ksettings	= onmph_ethtool_set_link_ksettings,
+	.get_sset_count		= onmph_get_sset_count,
+	.get_strings		= onmph_get_strings,
+	.get_ethtool_stats	= onmph_get_ethtool_stats,
+};
+
+// -------------------------------------------------------------------------- //
-- 
2.40.1

