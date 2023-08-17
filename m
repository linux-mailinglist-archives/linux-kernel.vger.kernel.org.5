Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1065E77F7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351542AbjHQNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351395AbjHQNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:38:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C203D26BB;
        Thu, 17 Aug 2023 06:38:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37HDbrUL3019324, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37HDbrUL3019324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 21:37:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 17 Aug 2023 21:38:13 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 17 Aug
 2023 21:38:12 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v4 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Date:   Thu, 17 Aug 2023 21:38:02 +0800
Message-ID: <20230817133803.177698-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817133803.177698-1-justinlai0215@realtek.com>
References: <20230817133803.177698-1-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.210.160]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

Below is a simplified block diagram of the chip and its relevant interfaces.

          *************************
          *                       *
          *  CPU network device   *
          *    ____________       *
          *   |            |      *
          *   |  PCIE Host |      *
          *************************
                    ||
                   PCIE
                    ||
  ****************************************
  *          | PCIE Endpoint |           *
  *          |---------------|           *
  *              | GMAC |                *
  *              |------|  Realtek       *
  *                 ||   RTL90xx Series  *
  *                 ||                   *
  *    _____________||______________     *
  *   |            |MAC|            |    *
  *   |            |---|            |    *
  *   |                             |    *
  *   |     Ethernet Switch Core    |    *
  *   |                             |    *
  *   |  -----             -----    |    *
  *   |  |MAC| ............|MAC|    |    *
  *   |__|___|_____________|___|____|    *
  *      |PHY| ............|PHY|         *
  *      -----             -----         *
  *********||****************||***********

The block of the Realtek RTL90xx series is our entire chip architecture, the GMAC is connected to the switch core,
and there is no PHY in between. In addition, this driver is mainly used to control GMAC, but does not control the switch core,
so it is not the same as DSA.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/Kconfig          |   17 +
 drivers/net/ethernet/realtek/Makefile         |    1 +
 drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
 drivers/net/ethernet/realtek/rtase/rtase.h    |  391 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2567 +++++++++++++++++
 5 files changed, 2986 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 93d9df55b361..0250d1c3874b 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -113,4 +113,21 @@ config R8169
 	  To compile this driver as a module, choose M here: the module
 	  will be called r8169.  This is recommended.
 
+config RTASE
+	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
+	depends on PCI
+	select CRC32
+	help
+	  Say Y here if you have a Realtek Ethernet adapter belonging to
+	  the following families:
+	  RTL9054 5GBit Ethernet
+	  RTL9068 5GBit Ethernet
+	  RTL9072 5GBit Ethernet
+	  RTL9075 5GBit Ethernet
+	  RTL9068 5GBit Ethernet
+	  RTL9071 5GBit Ethernet
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rtase.  This is recommended.
+
 endif # NET_VENDOR_REALTEK
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 2e1d78b106b0..0c1c16f63e9a 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ATP) += atp.o
 r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
 obj-$(CONFIG_R8169) += r8169.o
+obj-$(CONFIG_RTASE) += rtase/
diff --git a/drivers/net/ethernet/realtek/rtase/Makefile b/drivers/net/ethernet/realtek/rtase/Makefile
new file mode 100644
index 000000000000..5205bd330041
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2023 Realtek Semiconductor Corp. All rights reserved.
+
+#
+# Makefile for the Realtek PCIe driver
+#
+
+obj-$(CONFIG_RTASE) += rtase.o
+
+rtase-objs := rtase_main.o
diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
new file mode 100644
index 000000000000..ff6005f3175f
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -0,0 +1,391 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  rtase is the Linux device driver released for Realtek Automotive Switch
+ *  controllers with PCI-Express interface.
+ *
+ *  Copyright(c) 2023 Realtek Semiconductor Corp.
+ */
+
+#ifndef _RTASE_H_
+#define _RTASE_H_
+
+#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
+
+#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX
+#define NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX
+
+/* the low 32 bit address of receive buffer must be 8-byte alignment. */
+#define RTK_RX_ALIGN 8u
+
+#define RX_DMA_BURST_256       4u
+#define TX_DMA_BURST_UNLIMITED 7u
+#define JUMBO_FRAME_1K         ETH_DATA_LEN
+#define JUMBO_FRAME_9K         ((9 * 1024) - ETH_HLEN - VLAN_HLEN - ETH_FCS_LEN)
+
+/* 3 means InterFrameGap = the shortest one */
+#define INTERFRAMEGAP 0x03u
+
+#define RTASE_REGS_SIZE 256u
+
+#define RTASE_TX_TIMEOUT (6 * HZ)
+
+#define VLAN_FILTER_ENTRY_NUM 32u
+/* Number of Tx queues */
+#define NUM_TX_QUEUE 8u
+/* Number of Rx queues */
+#define NUM_RX_QUEUE 4u
+
+#define TXQ_CTRL      1u
+#define FUNC_TXQ_NUM  1u
+#define FUNC_RXQ_NUM  1u
+#define INTERRUPT_NUM 1u
+
+/* default tx interrupt mitigation, num = 64, time = 131.072us */
+#define TX_INT_MITIGATION 0x3448u
+/* default rx interrupt mitigation, num = 64, time = 131.072us */
+#define RX_INT_MITIGATION 0x3448u
+
+#define NUM_MSIX 4u
+
+#define RX_BUF_SIZE (1522u + 1u)
+
+/* write/read MMIO register */
+#define RTL_W8(tp, reg, val8)   writeb((val8), tp->mmio_addr + (reg))
+#define RTL_W16(tp, reg, val16) writew((val16), tp->mmio_addr + (reg))
+#define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
+#define RTL_R8(tp, reg)         readb(tp->mmio_addr + (reg))
+#define RTL_R16(tp, reg)        readw(tp->mmio_addr + (reg))
+#define RTL_R32(tp, reg)        readl(tp->mmio_addr + (reg))
+
+/*****************************************************************************/
+enum rtase_registers {
+	MAC0 = 0x0000u,
+	MAC4 = 0x0004u,
+	MAR0 = 0x0008u,
+	MAR1 = 0x000Cu,
+	DTCCR0 = 0x0010u,
+	DTCCR4 = 0x0014u,
+	FCR = 0x0018u,
+	LBK_CTRL = 0x001Au,
+	TX_DESC_START_ADDR0 = 0x0020u,
+	TX_DESC_START_ADDR4 = 0x0024u,
+	TX_DESC_COMMAND = 0x0028u,
+	CHIP_CMD = 0x0037u,
+	IMR0 = 0x0038u,
+	ISR0 = 0x003Cu,
+	IMR1 = 0x0800u,
+	ISR1 = 0x0802u,
+	TX_CONFIG_0 = 0x0040u,
+	RX_CONFIG_0 = 0x0044u,
+	RX_CONFIG_1 = 0x0046u,
+	EEM = 0x0050u,
+	TDFNR = 0x0057u,
+	TPPOLL = 0x0090u,
+	PDR = 0x00B0u,
+	FIFOR = 0x00D3u,
+	PCPR = 0x00D8u,
+	RMS = 0x00DAu,
+	CPLUS_CMD = 0x00DAu,
+	Q0_RX_DESC_ADDR0 = 0x00E4u,
+	Q0_RX_DESC_ADDR4 = 0x00E8u,
+	Q1_RX_DESC_ADDR0 = 0x4000u,
+	Q1_RX_DESC_ADDR4 = 0x4004u,
+	MTPS = 0x00ECu,
+	MISC = 0x00F2u,
+
+	TFUN_CTRL = 0x0400u,
+	TX_CONFIG_1 = 0x203Eu,
+	TOKSEL = 0x2046u,
+	TXQCRDT_0 = 0x2500u,
+	RFIFONFULL = 0x4406u,
+	VQCTRL = 0x4800u,
+	INT_MITI_TX = 0x0A00u,
+	INT_MITI_RX = 0x0A80u,
+
+	VLAN_ENTRY_MEM_0 = 0x7234u,
+	VLAN_ENTRY_0 = 0xAC80u,
+};
+
+enum rtase_register_content {
+	/* InterruptStatusBits 0 */
+	TOK7 = BIT(30),
+	TOK6 = BIT(28),
+	TOK5 = BIT(26),
+	TOK4 = BIT(24),
+	FOVW = BIT(6),
+	RDU = BIT(4),
+	TOK = BIT(2),
+	ROK = BIT(0),
+
+	/* InterruptStatusBits 1~3 */
+	Q_TOK = BIT(4),
+	Q_RDU = BIT(1),
+	Q_ROK = BIT(0),
+
+	/* ChipCmdRegBits */
+	STOP_REQ = BIT(7),
+	STOP_REQ_DONE = BIT(6),
+	RE = BIT(3),
+	TE = BIT(2),
+
+	/* Cfg9346Bits */
+	EEM_UNLOCK = 0xC0u,
+
+	/* Receive Configuration 0 */
+	RX_SINGLE_FETCH = BIT(14),
+	RX_SINGLE_TAG = BIT(13),
+	RX_MX_DMA_MASK = 0x7,
+	RX_MX_DMA_SHIFT = 8u,
+	ACPT_FLOW = BIT(7),
+	ACCEPT_ERR = BIT(5),
+	ACCEPT_RUNT = BIT(4),
+	ACCEPT_BROADCAST = BIT(3),
+	ACCEPT_MULTICAST = BIT(2),
+	ACCEPT_MYPHYS = BIT(1),
+	ACCEPT_ALLPHYS = BIT(0),
+	ACCEPT_MASK = (ACPT_FLOW | ACCEPT_ERR | ACCEPT_RUNT | ACCEPT_BROADCAST | ACCEPT_MULTICAST
+		       | ACCEPT_MYPHYS | ACCEPT_ALLPHYS),
+
+	/* Receive Configuration 1 */
+	RX_MAX_FETCH_DESC_MASK = 0x1F,
+	RX_MAX_FETCH_DESC_SHIFT = 11u,
+	RX_NEW_DESC_FORMAT_EN = BIT(8),
+	OUTER_VLAN_DETAG_EN = BIT(7),
+	INNER_VLAN_DETAG_EN = BIT(6),
+	PCIE_NEW_FLOW = BIT(2),
+	PCIE_RELOAD_En = BIT(0),
+
+	/* TxConfigBits */
+	TX_INTER_FRAME_GAP_MASK = 0x3u,
+	TX_INTER_FRAME_GAP_SHIFT = 24u,
+	TX_DMA_MASK = 0x7u,
+	/* DMA burst value (0-7) is shift this many bits */
+	TX_DMA_SHIFT = 8u,
+
+	/* TFunCtrl */
+	TX_NEW_DESC_FORMAT_EN = BIT(0),
+
+	/* TxDescCommand */
+	TX_DESC_CMD_CS = BIT(15),
+	TX_DESC_CMD_WE = BIT(14),
+
+	/* CPlusCmd */
+	FORCE_RXFLOW_EN = BIT(11),
+	FORCE_TXFLOW_EN = BIT(10),
+	RX_CHKSUM = BIT(5),
+
+	/* MISC */
+	RX_DV_GATE_EN = BIT(3),
+
+	/* ResetCounterCommand */
+	COUNTER_RESET = BIT(0),
+	/* DumpCounterCommand */
+	COUNTER_DUMP = BIT(3),
+
+	/* OCP access */
+	OCPR_WRITE = 0x80000000u,
+	OCPR_ADDR_REG_SHIFT = 16u,
+
+	/* MCU Command */
+	TX_FIFO_EMPTY = BIT(5),
+	RX_FIFO_EMPTY = BIT(4),
+
+	/* Function Control Register */
+	FCR_TX_LOOPBACK_EN = BIT(9),
+	FCR_TE = BIT(8),
+	FCR_RXQ_MASK = 0x3u,
+	FCR_RXQ_SHIFT = 4u,
+	FCR_MAR_EN = BIT(3),
+	FCR_BAR_EN = BIT(2),
+	FCR_VLAN_FTR_EN = BIT(1),
+	FCR_RE = BIT(0),
+
+	/* Loopback Control */
+	LBK_ATLD = BIT(1),
+	LBK_CLR = BIT(0),
+
+	/* PCP Register */
+	PCPR_VLAN_FTR_EN = BIT(6),
+};
+
+enum desc_status_bit {
+	DESC_OWN = BIT(31), /* Descriptor is owned by NIC */
+	RING_END = BIT(30), /* End of descriptor ring */
+
+	/* Tx private */
+	/*------ offset 0 of tx descriptor ------*/
+	TX_FIRST_FRAG = BIT(29), /* Tx First segment of a packet */
+	TX_LAST_FRAG = BIT(28),  /* Tx Final segment of a packet */
+	GIANT_SEND_V4 = BIT(26), /* TCP Giant Send Offload V4 (GSOv4) */
+	GIANT_SEND_V6 = BIT(25), /* TCP Giant Send Offload V6 (GSOv6) */
+	TX_VLAN_TAG = BIT(17),   /* Add VLAN tag */
+
+	/*------ offset 4 of tx descriptor ------*/
+	TX_UDPCS_C = BIT(31), /* Calculate UDP/IP checksum */
+	TX_TCPCS_C = BIT(30), /* Calculate TCP/IP checksum */
+	TX_IPCS_C = BIT(29),  /* Calculate IP checksum */
+	TX_IPV6F_C = BIT(28), /* Indicate it is an IPv6 packet */
+
+	/* Rx private */
+	/*------ offset 28 of rx descriptor ------*/
+	RX_FIRST_FRAG = BIT(25), /* Rx First segment of a packet */
+	RX_LAST_FRAG = BIT(24),  /* Rx Final segment of a packet */
+	RX_RES = BIT(20),
+	RX_RUNT = BIT(19),
+	RX_RWT = BIT(18),
+	RX_CRC = BIT(16),
+
+	RX_V6F = BIT(31),
+	RX_V4F = BIT(30),
+	RX_UDPT = BIT(29),
+	RX_TCPT = BIT(28),
+	RX_IPF = BIT(26),           /* IP checksum failed */
+	RX_UDPF = BIT(25),          /* UDP/IP checksum failed */
+	RX_TCPF = BIT(24),          /* TCP/IP checksum failed */
+	RX_LBK_FIFO_FULL = BIT(17), /* Loopback FIFO Full */
+	RX_VLAN_TAG = BIT(16),      /* VLAN tag available */
+};
+
+enum sw_flag_content {
+	SWF_MSI_ENABLED = BIT(1),
+	SWF_MSIX_ENABLED = BIT(2),
+};
+
+#define RSVD_MASK 0x3FFFC000u
+
+typedef struct {
+	u32 opts1;
+	u32 opts2;
+	u64 addr;
+	u32 opts3;
+	u32 reserved1;
+	u32 reserved2;
+	u32 reserved3;
+} tx_desc;
+
+typedef union {
+	struct {
+		u64 header_buf_addr;
+		u32 reserved1;
+		u32 opts_header_len;
+		u64 addr;
+		u32 reserved2;
+		u32 opts1;
+	} desc_cmd;
+
+	struct {
+		u32 reserved1;
+		u32 reserved2;
+		u32 rss;
+		u32 opts4;
+		u32 reserved3;
+		u32 opts3;
+		u32 opts2;
+		u32 opts1;
+	} desc_status;
+} rx_desc;
+
+#define NUM_DESC                1024u
+#define RTASE_TX_RING_DESC_SIZE (NUM_DESC * sizeof(tx_desc))
+#define RTASE_RX_RING_DESC_SIZE (NUM_DESC * sizeof(rx_desc))
+#define VLAN_ENTRY_CAREBIT      0xF0000000u
+
+/* txqos hardware definitions */
+#define RTASE_1T_CLOCK            64u
+#define RTASE_1T_POWER            10000000u
+#define RTASE_IDLESLOPE_INT_SHIFT 25u
+
+struct rtase_int_vector {
+	struct rtase_private *tp;
+	unsigned int irq;
+	u8 status;
+	u8 name[20];
+	u16 index;
+	u16 imr_addr;
+	u16 isr_addr;
+	u32 imr;
+	struct list_head ring_list;
+	struct napi_struct napi;
+	int (*poll)(struct napi_struct *napi, int budget);
+};
+
+struct rtase_ring {
+	struct rtase_int_vector *ivec;
+	void *desc;
+	dma_addr_t phy_addr;
+	u32 cur_idx;
+	u32 dirty_idx;
+	u16 index;
+
+	struct sk_buff *skbuff[NUM_DESC];
+	union {
+		u32 len[NUM_DESC];
+		dma_addr_t data_phy_addr[NUM_DESC];
+	} mis;
+
+	struct list_head ring_entry;
+	s32 (*ring_handler)(struct rtase_ring *ring, s32 budget);
+};
+
+struct rtase_txqos {
+	s32 hicredit;
+	s32 locredit;
+	s32 idleslope;
+	s32 sendslope;
+};
+
+struct rtase_private {
+	void __iomem *mmio_addr; /* memory map physical address */
+	u32 sw_flag;
+	struct work_struct msg_work;
+	u32 mc_filter[2];
+
+	struct pci_dev *pdev; /* Index of PCI device */
+	struct net_device *dev;
+	spinlock_t lock;      /* spin lock flag */
+	u32 msg_enable;
+	u16 max_jumbo_frame_size;
+	u8 mcfg;
+	u32 rx_buf_sz;
+
+	struct rtase_ring tx_ring[NUM_TX_QUEUE];
+	struct rtase_txqos tx_qos[NUM_TX_QUEUE];
+	struct rtase_ring rx_ring[NUM_RX_QUEUE];
+	struct rtase_counters *tally_vaddr;
+	dma_addr_t tally_paddr;
+
+	u32 vlan_filter_ctrl;
+	u16 vlan_filter_vid[VLAN_FILTER_ENTRY_NUM];
+
+	struct delayed_work task;
+	u8 hw_ic_ver_unknown;
+	u8 random_mac;
+	u8 org_mac_addr[ETH_ALEN];
+	struct msix_entry msix_entry[NUM_MSIX];
+	struct rtase_int_vector int_vector[NUM_MSIX];
+
+	u16 tx_queue_ctrl;
+	u16 func_tx_queue_num;
+	u16 func_rx_queue_num;
+	u16 int_nums;
+	u16 tx_int_mit;
+	u16 rx_int_mit;
+};
+
+enum mcfg {
+	CFG_METHOD_1 = (0u),
+	CFG_METHOD_DEFAULT = (1u),
+};
+
+#define LSO_64K 64000
+
+#define NIC_MAX_PHYS_BUF_COUNT_LSO2 (16 * 4)
+
+#define GTTCPHO_SHIFT 18
+
+#define TCPHO_SHIFT 18u
+#define TCPHO_MAX   0x3FFu
+
+#define MSS_MAX 0x07FFu /* MSS value */
+
+#endif                  /* _RTASE_H_ */
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
new file mode 100644
index 000000000000..d5132b57cd91
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -0,0 +1,2567 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  rtase is the Linux device driver released for Realtek Automotive Switch
+ *  controllers with PCI-Express interface.
+ *
+ *  Copyright(c) 2023 Realtek Semiconductor Corp.
+ *
+ *  Below is a simplified block diagram of the chip and its relevant interfaces.
+ *
+ *	  *************************
+ *	  *                       *
+ *	  *  CPU network device   *
+ *	  *    ____________       *
+ *	  *   |            |      *
+ *	  *   |  PCIE Host |      *
+ *	  *************************
+ *		    ||
+ *		   PCIE
+ *		    ||
+ *  ****************************************
+ *  *          | PCIE Endpoint |           *
+ *  *          |---------------|           *
+ *  *              | GMAC |                *
+ *  *              |------|  Realtek       *
+ *  *                 ||   RTL90xx Series  *
+ *  *                 ||                   *
+ *  *    _____________||______________     *
+ *  *   |            |MAC|            |    *
+ *  *   |            |---|            |    *
+ *  *   |                             |    *
+ *  *   |     Ethernet Switch Core    |    *
+ *  *   |                             |    *
+ *  *   |  -----             -----    |    *
+ *  *   |  |MAC| ............|MAC|    |    *
+ *  *   |__|___|_____________|___|____|    *
+ *  *      |PHY| ............|PHY|         *
+ *  *      -----             -----         *
+ *  *********||****************||***********
+ *
+ *  The block of the Realtek RTL90xx series is our entire chip architecture, the GMAC is connected
+ *  to the switch core, and there is no PHY in between. In addition, this driver is mainly used to
+ *  control GMAC, but does not control the switch core, so it is not the same as DSA.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/delay.h>
+#include <linux/if_vlan.h>
+#include <linux/crc32.h>
+#include <linux/interrupt.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/init.h>
+#include <linux/rtnetlink.h>
+#include <linux/prefetch.h>
+#include <linux/dma-mapping.h>
+#include <linux/moduleparam.h>
+#include <linux/mdio.h>
+#include <net/ip6_checksum.h>
+#include <net/pkt_cls.h>
+#include <linux/io.h>
+#include <asm/irq.h>
+
+#include "rtase.h"
+
+/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
+ * The RTL chips use a 64 element hash table based on the Ethernet CRC.
+ */
+static const struct {
+	const char *name;
+	u8 mcfg;
+	u16 jumbo_frame_sz;
+} rtl_chip_info[] = {{"RTL9072", CFG_METHOD_1, JUMBO_FRAME_9K},
+
+		     {"Unknown", CFG_METHOD_DEFAULT, JUMBO_FRAME_1K}};
+
+static struct pci_device_id rtase_pci_tbl[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x906A),
+	},
+	{
+		0,
+	},
+};
+
+MODULE_AUTHOR("Realtek ARD Software Team");
+MODULE_DESCRIPTION("Realtek Automotive Switch Ethernet and Network PCIe Driver");
+MODULE_LICENSE("GPL");
+
+/******************************************************************************
+ * Function
+ ******************************************************************************/
+struct rtase_counters {
+	u64 tx_packets;
+	u64 rx_packets;
+	u64 tx_errors;
+	u32 rx_errors;
+	u16 rx_missed;
+	u16 align_errors;
+	u32 tx_one_collision;
+	u32 tx_multi_collision;
+	u64 rx_unicast;
+	u64 rx_broadcast;
+	u32 rx_multicast;
+	u16 tx_aborted;
+	u16 tx_underun;
+};
+
+static void rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t paddr)
+{
+	u32 wait_cnt;
+	u32 cmd;
+
+	RTL_W32(tp, DTCCR4, (paddr >> 32));
+	cmd = paddr & DMA_BIT_MASK(32);
+	RTL_W32(tp, DTCCR0, cmd);
+	RTL_W32(tp, DTCCR0, (cmd | COUNTER_DUMP));
+
+	wait_cnt = 0;
+	while ((RTL_R32(tp, DTCCR0) & COUNTER_DUMP) != 0u) {
+		usleep_range(10, 20);
+
+		wait_cnt++;
+		if (wait_cnt > 20u)
+			break;
+	}
+}
+
+static void mac_ocp_write(const struct rtase_private *tp, u16 reg_addr, u16 value)
+{
+	u32 data32;
+
+	WARN_ON_ONCE(reg_addr % 2u);
+
+	data32 = reg_addr / 2u;
+	data32 <<= OCPR_ADDR_REG_SHIFT;
+	data32 += value;
+	data32 |= OCPR_WRITE;
+
+	RTL_W32(tp, PDR, data32);
+}
+
+static void rtase_interrupt_mitigation(const struct rtase_private *tp)
+{
+	u32 i = 0;
+
+	/* tx interrupt mitigation */
+	for (i = 0u; i < tp->func_tx_queue_num; i++)
+		RTL_W16(tp, (INT_MITI_TX + (i * 2u)), tp->tx_int_mit);
+
+	/* rx interrupt mitigation */
+	for (i = 0u; i < tp->func_rx_queue_num; i++)
+		RTL_W16(tp, (INT_MITI_RX + (i * 2u)), tp->rx_int_mit);
+}
+
+static inline void rtase_enable_hw_interrupt(const struct rtase_private *tp)
+{
+	const struct rtase_int_vector *ivec = &tp->int_vector[0];
+	u32 i = 0;
+
+	RTL_W32(tp, ivec->imr_addr, ivec->imr);
+
+	for (i = 1; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		RTL_W16(tp, ivec->imr_addr, ivec->imr);
+	}
+}
+
+static void rtase_irq_mask_and_ack(const struct rtase_private *tp)
+{
+	const struct rtase_int_vector *ivec = &tp->int_vector[0];
+	u8 i = 0;
+
+	RTL_W32(tp, ivec->imr_addr, 0);
+	RTL_W32(tp, ivec->isr_addr, RTL_R32(tp, ivec->isr_addr));
+
+	for (i = 1; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		RTL_W16(tp, ivec->imr_addr, 0);
+		RTL_W16(tp, ivec->isr_addr, RTL_R16(tp, ivec->isr_addr));
+	}
+}
+
+static void rtase_nic_reset(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config;
+	u16 i = 0;
+
+	rx_config = RTL_R16(tp, RX_CONFIG_0);
+	RTL_W16(tp, RX_CONFIG_0, (rx_config & ~ACCEPT_MASK));
+
+	/* rxdv_gated_en - mask rxdv in PHYIO */
+	RTL_W8(tp, MISC, (RTL_R8(tp, MISC) | RX_DV_GATE_EN));
+	/* stop any TLP request from PCIe */
+	RTL_W8(tp, CHIP_CMD, (RTL_R8(tp, CHIP_CMD) | STOP_REQ));
+	mdelay(2);
+
+	/* wait TLP request done */
+	for (i = 0u; i < 1500u; i++) {
+		if ((RTL_R8(tp, CHIP_CMD) & STOP_REQ_DONE) != 0u)
+			break;
+
+		usleep_range(100, 110);
+	}
+
+	/* wait FIFO empty */
+	for (i = 0u; i < 1000u; i++) {
+		if ((RTL_R8(tp, FIFOR) & (TX_FIFO_EMPTY | RX_FIFO_EMPTY))
+		    == (TX_FIFO_EMPTY | RX_FIFO_EMPTY))
+			break;
+
+		usleep_range(100, 110);
+	}
+
+	RTL_W8(tp, CHIP_CMD, (RTL_R8(tp, CHIP_CMD) & ~(TE | RE)));
+
+	RTL_W8(tp, CHIP_CMD, (RTL_R8(tp, CHIP_CMD) & ~STOP_REQ));
+
+	RTL_W16(tp, RX_CONFIG_0, rx_config);
+}
+
+static void rtase_nic_enable(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rcr = RTL_R16(tp, RX_CONFIG_1);
+
+	/* PCIe PLA reload */
+	RTL_W16(tp, RX_CONFIG_1, (rcr & ~PCIE_RELOAD_En));
+	RTL_W16(tp, RX_CONFIG_1, (rcr | PCIE_RELOAD_En));
+
+	/* Set PCIe TE & RE */
+	RTL_W8(tp, CHIP_CMD, (RTL_R8(tp, CHIP_CMD) | (TE | RE)));
+
+	/* Clear rxdv_gated_en */
+	RTL_W8(tp, MISC, (RTL_R8(tp, MISC) & ~RX_DV_GATE_EN));
+}
+
+void rtase_hw_reset(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	/* disable & clear interrupts */
+	rtase_irq_mask_and_ack(tp);
+
+	/* nic reset */
+	rtase_nic_reset(dev);
+}
+
+static void rtase_enable_EEM_write(const struct rtase_private *tp)
+{
+	RTL_W8(tp, EEM, (RTL_R8(tp, EEM) | EEM_UNLOCK));
+}
+
+static void rtase_disable_EEM_write(const struct rtase_private *tp)
+{
+	RTL_W8(tp, EEM, (RTL_R8(tp, EEM) & ~EEM_UNLOCK));
+}
+
+static inline u32 rtase_tx_vlan_tag(const struct rtase_private *tp, const struct sk_buff *skb)
+{
+	u32 tag;
+
+	tag = (skb_vlan_tag_present(skb) != 0u) ? (TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb)))
+						: 0x00u;
+
+	return tag;
+}
+
+static s32 rtase_rx_vlan_skb(rx_desc *desc, struct sk_buff *skb)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+	s32 ret = -1;
+
+	if ((opts2 & RX_VLAN_TAG) != 0u)
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xFFFFu));
+
+	desc->desc_status.opts2 = 0;
+	return ret;
+}
+
+static s32 rtase_hw_set_features(const struct net_device *dev, netdev_features_t features)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config;
+
+	rx_config = RTL_R16(tp, RX_CONFIG_0);
+	if ((features & NETIF_F_RXALL) != 0u)
+		rx_config |= (ACCEPT_ERR | ACCEPT_RUNT);
+	else
+		rx_config &= ~(ACCEPT_ERR | ACCEPT_RUNT);
+
+	RTL_W16(tp, RX_CONFIG_0, rx_config);
+
+	rx_config = RTL_R16(tp, RX_CONFIG_1);
+	if ((dev->features & NETIF_F_HW_VLAN_RX) != 0u)
+		rx_config |= (INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
+	else
+		rx_config &= ~(INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
+
+	RTL_W16(tp, RX_CONFIG_1, rx_config);
+
+	if ((features & NETIF_F_RXCSUM) != 0u)
+		RTL_W16(tp, CPLUS_CMD, (RTL_R16(tp, CPLUS_CMD) | RX_CHKSUM));
+	else
+		RTL_W16(tp, CPLUS_CMD, (RTL_R16(tp, CPLUS_CMD) & ~RX_CHKSUM));
+
+	return 0;
+}
+
+static const char rtase_gstrings[][ETH_GSTRING_LEN] = {
+	"tx_packets",   "rx_packets",           "tx_errors",           "rx_errors", "rx_missed",
+	"align_errors", "tx_single_collisions", "tx_multi_collisions", "unicast",   "broadcast",
+	"multicast",    "tx_aborted",           "tx_underrun",
+};
+
+static void rtase_get_mac_version(struct rtase_private *tp)
+{
+	u32 reg_val, hw_ver;
+
+	reg_val = RTL_R32(tp, TX_CONFIG_0);
+	hw_ver = reg_val & 0x7C800000u;
+
+	switch (hw_ver) {
+	case 0x00800000:
+	case 0x04000000:
+	case 0x04800000:
+		tp->mcfg = CFG_METHOD_1;
+		break;
+
+	default:
+		netdev_info(tp->dev, "unknown chip version (%x)\n", hw_ver);
+		tp->mcfg = CFG_METHOD_DEFAULT;
+		tp->hw_ic_ver_unknown = true;
+		break;
+	}
+}
+
+static void rtase_tally_counter_addr_fill(const struct rtase_private *tp)
+{
+
+	if (tp->tally_paddr != 0u) {
+		RTL_W32(tp, DTCCR4, (u32)(tp->tally_paddr >> 32));
+		RTL_W32(tp, DTCCR0, (u32)(tp->tally_paddr & (DMA_BIT_MASK(32))));
+	}
+}
+
+static void rtase_tally_counter_clear(const struct rtase_private *tp)
+{
+
+	if (tp->tally_paddr != 0u) {
+		RTL_W32(tp, DTCCR4, (u32)(tp->tally_paddr >> 32));
+		RTL_W32(tp, DTCCR0, (u32)((tp->tally_paddr & (DMA_BIT_MASK(32))) | COUNTER_RESET));
+	}
+}
+
+/*  The interrupt handler does RXQ0 and TXQ0, TXQ4~7 interrutp status.
+ */
+static irqreturn_t rtase_interrupt(int irq, void *dev_instance)
+{
+	struct net_device *dev = (struct net_device *)dev_instance;
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec = &tp->int_vector[0];
+	s32 handled = 0;
+	u32 status;
+
+	do {
+		status = RTL_R32(tp, ivec->isr_addr);
+
+		handled = 1;
+		RTL_W32(tp, ivec->imr_addr, 0x0);
+		RTL_W32(tp, ivec->isr_addr, (status & ~FOVW));
+
+		if ((status & ivec->imr) != 0u) {
+			if (likely(napi_schedule_prep(&ivec->napi)))
+				__napi_schedule(&ivec->napi);
+		}
+	} while (false);
+
+	return IRQ_RETVAL(handled);
+}
+
+/*  The interrupt handler does RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 interrutp
+ *  status according to interrupt vector.
+ */
+static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance)
+{
+	struct rtase_int_vector *ivec = (struct rtase_int_vector *)dev_instance;
+	const struct rtase_private *tp = ivec->tp;
+	int handled = 0;
+	u16 status;
+
+	do {
+		status = RTL_R16(tp, ivec->isr_addr);
+
+		handled = 1;
+		RTL_W16(tp, ivec->imr_addr, 0x0);
+		RTL_W16(tp, ivec->isr_addr, status);
+
+		/* don't support without NAPI */
+		if (likely(napi_schedule_prep(&ivec->napi)))
+			__napi_schedule(&ivec->napi);
+		else
+			netdev_info(tp->dev, "%s: interrupt %04x in poll\n", ivec->name, status);
+
+	} while (false);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int rtase_poll(struct napi_struct *napi, int budget)
+{
+	const struct rtase_int_vector *ivec = container_of(napi, struct rtase_int_vector, napi);
+	const struct rtase_private *tp = ivec->tp;
+	struct rtase_ring *ring;
+	int total_workdone = 0;
+	s32 clean_flag = 1;
+	s32 workdone = 0;
+
+	/* clang-format off */
+	list_for_each_entry(ring, &ivec->ring_list, ring_entry) {
+		workdone = ring->ring_handler(ring, budget);
+		total_workdone += workdone;
+		if (workdone == budget)
+			clean_flag = 0;
+	}
+	/* clang-format on */
+
+	if (clean_flag != 0) {
+		total_workdone = min(total_workdone, budget - 1);
+		if (likely(napi_complete_done(napi, total_workdone))) {
+			if (ivec->index == 0u)
+				RTL_W32(tp, ivec->imr_addr, ivec->imr);
+			else
+				RTL_W16(tp, ivec->imr_addr, ivec->imr);
+		}
+	} else {
+		/* still need to poll */
+		total_workdone = budget;
+	}
+
+	return total_workdone;
+}
+
+static void rtase_init_int_vector(struct rtase_private *tp)
+{
+	u16 i = 0u;
+
+	/* interrupt vector 0 */
+	tp->int_vector[0].tp = tp;
+	memset(tp->int_vector[0].name, 0x0, 20);
+	tp->int_vector[0].index = 0;
+	tp->int_vector[0].imr_addr = IMR0;
+	tp->int_vector[0].isr_addr = ISR0;
+	tp->int_vector[0].imr = ROK | RDU | TOK | TOK4 | TOK5 | TOK6 | TOK7;
+	INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
+	tp->int_vector[0].poll = rtase_poll;
+	netif_napi_add(tp->dev, &tp->int_vector[0].napi, tp->int_vector[0].poll);
+	napi_enable(&tp->int_vector[0].napi);
+
+	/* interrupt vector 1 ~ 3 */
+	for (i = 1; i < tp->int_nums; i++) {
+		tp->int_vector[i].tp = tp;
+		memset(tp->int_vector[i].name, 0x0, 20);
+		tp->int_vector[i].index = i;
+		tp->int_vector[i].imr_addr = (IMR1 + ((i - 1u) * 4u));
+		tp->int_vector[i].isr_addr = (ISR1 + ((i - 1u) * 4u));
+		tp->int_vector[i].imr = Q_ROK | Q_RDU | Q_TOK;
+		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
+		tp->int_vector[i].poll = rtase_poll;
+		netif_napi_add(tp->dev, &tp->int_vector[i].napi, tp->int_vector[i].poll);
+		napi_enable(&tp->int_vector[i].napi);
+	}
+}
+
+static void rtase_init_software_variable(struct rtase_private *tp)
+{
+	spin_lock_init(&tp->lock);
+
+	/* assign module parameters */
+	tp->tx_queue_ctrl = TXQ_CTRL;
+	tp->func_tx_queue_num = FUNC_TXQ_NUM;
+	tp->func_rx_queue_num = FUNC_RXQ_NUM;
+	tp->int_nums = INTERRUPT_NUM;
+	tp->tx_int_mit = TX_INT_MITIGATION;
+	tp->rx_int_mit = RX_INT_MITIGATION;
+
+	tp->sw_flag = 0;
+
+	/* new, interrutp variables init */
+	rtase_init_int_vector(tp);
+
+	tp->max_jumbo_frame_size = rtl_chip_info[tp->mcfg].jumbo_frame_sz;
+	/* MTU range: 60 - hw-specific max */
+	tp->dev->min_mtu = ETH_ZLEN;
+	tp->dev->max_mtu = tp->max_jumbo_frame_size;
+}
+
+static void rtase_init_hardware(const struct rtase_private *tp)
+{
+	u16 i;
+
+	/* vlan filter table */
+	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++)
+		RTL_W32(tp, (VLAN_ENTRY_0 + (i * 4u)), 0);
+}
+
+/* rtase_rar_set - Puts an ethernet address into a receive address register.
+ *
+ * tp - The private data structure for driver
+ * addr - Address to put into receive address register
+ */
+static void rtase_rar_set(const struct rtase_private *tp, const uint8_t *addr)
+{
+	u32 rar_high = 0;
+	u32 rar_low = 0;
+
+	rar_low = ((uint32_t)addr[0] | ((uint32_t)addr[1] << 8) | ((uint32_t)addr[2] << 16)
+		   | ((uint32_t)addr[3] << 24));
+
+	rar_high = ((uint32_t)addr[4] | ((uint32_t)addr[5] << 8));
+
+	rtase_enable_EEM_write(tp);
+	RTL_W32(tp, MAC0, rar_low);
+	RTL_W32(tp, MAC4, rar_high);
+	rtase_disable_EEM_write(tp);
+	RTL_W16(tp, LBK_CTRL, (LBK_ATLD | LBK_CLR));
+}
+
+static void rtase_hw_address_set(struct net_device *dev, const u8 mac_addr[ETH_ALEN])
+{
+	eth_hw_addr_set(dev, mac_addr);
+}
+
+static void rtase_get_mac_address(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u8 mac_addr[ETH_ALEN];
+	u32 i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_addr[i] = RTL_R8(tp, MAC0 + i);
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		netif_err(tp, probe, dev, "Invalid ether addr %pM\n", mac_addr);
+		eth_hw_addr_random(dev);
+		ether_addr_copy(mac_addr, dev->dev_addr);
+		netif_info(tp, probe, dev, "Random ether addr %pM\n", mac_addr);
+		tp->random_mac = 1;
+	}
+
+	rtase_hw_address_set(dev, mac_addr);
+	rtase_rar_set(tp, mac_addr);
+
+	/* keep the original MAC address */
+	memcpy(tp->org_mac_addr, dev->dev_addr, ETH_ALEN);
+	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
+}
+/******************************************************************************
+ * Ethtool Operations
+ ******************************************************************************/
+static void rtase_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *drvinfo)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	strscpy(drvinfo->driver, KBUILD_MODNAME, 32);
+	strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
+}
+
+#undef ethtool_op_get_link
+#define ethtool_op_get_link _kc_ethtool_op_get_link
+static u32 _kc_ethtool_op_get_link(struct net_device *dev)
+{
+	return netif_carrier_ok(dev) ? 1u : 0u;
+}
+
+static int rtase_get_settings(struct net_device *dev, struct ethtool_link_ksettings *cmd)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u32 advertising = 0;
+	u32 supported = 0;
+	u32 speed = 0;
+	u16 value = 0;
+
+	supported |= SUPPORTED_MII | SUPPORTED_Pause;
+
+	advertising |= ADVERTISED_MII;
+
+	/* speed */
+	switch (tp->pdev->bus->cur_bus_speed) {
+	case PCIE_SPEED_2_5GT:
+		speed = SPEED_1000;
+		break;
+	case PCIE_SPEED_5_0GT:
+		speed = SPEED_2500;
+		break;
+	case PCIE_SPEED_8_0GT:
+		speed = SPEED_5000;
+		break;
+	default:
+		/* nothing to do. */
+		break;
+	}
+
+	/* pause */
+	value = RTL_R16(tp, CPLUS_CMD);
+	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) == (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN))
+		advertising |= ADVERTISED_Pause;
+	else if ((value & FORCE_TXFLOW_EN) != 0u)
+		advertising |= ADVERTISED_Asym_Pause;
+	else if ((value & FORCE_RXFLOW_EN) != 0u)
+		advertising |= (ADVERTISED_Pause | ADVERTISED_Asym_Pause);
+	else
+		netdev_info(dev, "pause is disable\n");
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, supported);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, advertising);
+	cmd->base.speed = speed;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_MII;
+
+	return 0;
+}
+
+static void rtase_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = RTL_R16(tp, CPLUS_CMD);
+
+	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) == (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) {
+		pause->rx_pause = 1;
+		pause->tx_pause = 1;
+	} else if ((value & FORCE_TXFLOW_EN) != 0u) {
+		pause->tx_pause = 1;
+	} else if ((value & FORCE_RXFLOW_EN) != 0u) {
+		pause->rx_pause = 1;
+	} else {
+		/* not enable pause */
+	}
+}
+
+static int rtase_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = RTL_R16(tp, CPLUS_CMD);
+
+	value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
+
+	if (pause->tx_pause == 1u)
+		value |= FORCE_TXFLOW_EN;
+
+	if (pause->rx_pause == 1u)
+		value |= FORCE_RXFLOW_EN;
+
+	RTL_W16(tp, CPLUS_CMD, value);
+	return 0;
+}
+
+static u32 rtase_get_msglevel(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	return tp->msg_enable;
+}
+
+static void rtase_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+
+	tp->msg_enable = value;
+}
+
+static void rtase_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(data, *rtase_gstrings, sizeof(rtase_gstrings));
+		break;
+	default:
+		/* nothing to do. */
+		break;
+	}
+}
+
+static int rtase_get_sset_count(struct net_device *dev, int sset)
+{
+	int ret = 0;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		ret = ARRAY_SIZE(rtase_gstrings);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static void rtase_get_ethtool_stats(struct net_device *dev, struct ethtool_stats *stats, u64 *data)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters;
+	unsigned long flags;
+	dma_addr_t paddr;
+
+	ASSERT_RTNL();
+
+	counters = tp->tally_vaddr;
+	paddr = tp->tally_paddr;
+	if (!counters)
+		goto out;
+
+	spin_lock_irqsave(&tp->lock, flags);
+	rtase_dump_tally_counter(tp, paddr);
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	data[0] = le64_to_cpu(counters->tx_packets);
+	data[1] = le64_to_cpu(counters->rx_packets);
+	data[2] = le64_to_cpu(counters->tx_errors);
+	data[3] = le32_to_cpu(counters->rx_errors);
+	data[4] = le16_to_cpu(counters->rx_missed);
+	data[5] = le16_to_cpu(counters->align_errors);
+	data[6] = le32_to_cpu(counters->tx_one_collision);
+	data[7] = le32_to_cpu(counters->tx_multi_collision);
+	data[8] = le64_to_cpu(counters->rx_unicast);
+	data[9] = le64_to_cpu(counters->rx_broadcast);
+	data[10] = le32_to_cpu(counters->rx_multicast);
+	data[11] = le16_to_cpu(counters->tx_aborted);
+	data[12] = le16_to_cpu(counters->tx_underun);
+
+out:
+	return;
+}
+
+static s32 rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
+{
+	s32 rc = 0;
+	u16 i = 0;
+
+	memset(tp->msix_entry, 0x0, NUM_MSIX * sizeof(struct msix_entry));
+	for (i = 0u; i < NUM_MSIX; i++)
+		tp->msix_entry[i].entry = i;
+
+	rc = pci_enable_msix_range(pdev, tp->msix_entry, tp->int_nums, tp->int_nums);
+
+	if (rc == tp->int_nums) {
+		for (i = 0u; i < tp->int_nums; i++) {
+			tp->int_vector[i].irq = pci_irq_vector(pdev, i);
+			tp->int_vector[i].status = 1;
+		}
+	}
+
+	return rc;
+}
+
+static s32 rtase_alloc_interrupt(struct pci_dev *pdev, struct rtase_private *tp)
+{
+	s32 rc = 0;
+
+	rc = rtase_alloc_msix(pdev, tp);
+	if (rc != tp->int_nums) {
+		rc = pci_enable_msi(pdev);
+		if (rc != 0)
+			dev_err(&pdev->dev, "unable to alloc interrupt.(MSI)\n");
+		else
+			tp->sw_flag |= SWF_MSI_ENABLED;
+	} else {
+		tp->sw_flag |= SWF_MSIX_ENABLED;
+	}
+
+	return rc;
+}
+
+static void rtase_reset_interrupt(struct pci_dev *pdev, const struct rtase_private *tp)
+{
+	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u)
+		pci_disable_msix(pdev);
+	else if ((tp->sw_flag & SWF_MSI_ENABLED) != 0u)
+		pci_disable_msi(pdev);
+	else
+		netdev_info(tp->dev, "interrupt is never enabled\n");
+}
+
+static void rtase_set_rxbufsize(struct rtase_private *tp, const struct net_device *dev)
+{
+	u32 mtu = dev->mtu;
+
+	tp->rx_buf_sz = (mtu > ETH_DATA_LEN) ? (mtu + ETH_HLEN + 8u + 1u) : RX_BUF_SIZE;
+}
+
+static void rtase_free_desc(struct rtase_private *tp)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 i = 0;
+
+	for (i = 0u; i < tp->func_tx_queue_num; i++) {
+		if (tp->tx_ring[i].desc) {
+			dma_free_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE, tp->tx_ring[i].desc,
+					  tp->tx_ring[i].phy_addr);
+			tp->tx_ring[i].desc = NULL;
+		}
+	}
+
+	for (i = 0u; i < tp->func_rx_queue_num; i++) {
+		if (tp->rx_ring[i].desc) {
+			dma_free_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE, tp->rx_ring[i].desc,
+					  tp->rx_ring[i].phy_addr);
+			tp->rx_ring[i].desc = NULL;
+		}
+	}
+}
+
+static s32 rtase_alloc_desc(struct rtase_private *tp)
+{
+	struct pci_dev *pdev = tp->pdev;
+	s32 retval = 0;
+	u32 i = 0;
+
+	/* Rx and Tx descriptors needs 256 bytes alignment.
+	 * dma_alloc_coherent provides more.
+	 */
+	for (i = 0u; i < tp->func_tx_queue_num; i++) {
+		tp->tx_ring[i].desc = dma_alloc_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE,
+							 &tp->tx_ring[i].phy_addr, GFP_KERNEL);
+		if (!tp->tx_ring[i].desc) {
+			retval = -ENOMEM;
+			break;
+		}
+	}
+
+	if (retval == 0) {
+		for (i = 0u; i < tp->func_rx_queue_num; i++) {
+			tp->rx_ring[i].desc =
+				dma_alloc_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE,
+						   &tp->rx_ring[i].phy_addr, GFP_KERNEL);
+			if (!tp->rx_ring[i].desc) {
+				retval = -ENOMEM;
+				break;
+			}
+		}
+	}
+
+	return retval;
+}
+
+#define RTK_OPTS1_DEBUG_VALUE 0x0BADBEEF
+#define RTK_MAGIC_NUMBER      0x0BADBADBADBADBADuLL
+static void rtase_unmap_tx_skb(struct pci_dev *pdev, u32 len, tx_desc *desc)
+{
+	dma_unmap_single(&pdev->dev, le64_to_cpu(desc->addr), len, DMA_TO_DEVICE);
+	desc->opts1 = cpu_to_le32(RTK_OPTS1_DEBUG_VALUE);
+	desc->opts2 = 0x00;
+	desc->addr = RTK_MAGIC_NUMBER;
+}
+
+static unsigned int rtase_tx_avail(struct rtase_ring *ring)
+{
+	return READ_ONCE(ring->dirty_idx) + NUM_DESC - READ_ONCE(ring->cur_idx) - 1;
+}
+
+static s32 tx_handler(struct rtase_ring *ring, s32 budget)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	struct net_device *dev = tp->dev;
+	s32 workdone = 0;
+	u32 dirty_tx;
+	u32 tx_left;
+
+	dirty_tx = READ_ONCE(ring->dirty_idx);
+	tx_left = READ_ONCE(ring->cur_idx) - dirty_tx;
+
+	while (tx_left > 0u) {
+		u32 entry = dirty_tx % NUM_DESC;
+		tx_desc *desc = ring->desc + (sizeof(tx_desc) * entry);
+		u32 len = ring->mis.len[entry];
+		u32 status;
+
+		status = le32_to_cpu(desc->opts1);
+
+		if ((status & DESC_OWN) != 0u) {
+			tx_left = 0;
+			continue;
+		}
+
+		dev->stats.tx_bytes += len;
+		dev->stats.tx_packets++;
+		rtase_unmap_tx_skb(tp->pdev, len, desc);
+		ring->mis.len[entry] = 0;
+		if (ring->skbuff[entry]) {
+			dev_consume_skb_any(ring->skbuff[entry]);
+			ring->skbuff[entry] = NULL;
+		}
+		dirty_tx++;
+		tx_left--;
+		workdone++;
+
+		if (workdone == budget) {
+			tx_left = 0;
+			continue;
+		}
+	}
+
+	if (ring->dirty_idx != dirty_tx) {
+		WRITE_ONCE(ring->dirty_idx, dirty_tx);
+
+		if (netif_queue_stopped(dev) && (rtase_tx_avail(ring) >= MAX_SKB_FRAGS))
+			netif_wake_queue(dev);
+
+		if (ring->cur_idx != dirty_tx)
+			RTL_W8(tp, TPPOLL, BIT(ring->index));
+	}
+
+	return workdone;
+}
+
+static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->tx_ring[idx];
+	tx_desc *desc;
+	u32 i = 0;
+
+	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, (NUM_DESC * sizeof(struct sk_buff *)));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0u; i < NUM_DESC; i++) {
+		ring->mis.len[i] = 0;
+		if ((NUM_DESC - 1u) == i) {
+			desc = ring->desc + (sizeof(tx_desc) * i);
+			desc->opts1 = cpu_to_le32(RING_END);
+		}
+	}
+
+	ring->ring_handler = tx_handler;
+	if (idx < 4u) {
+		ring->ivec = &tp->int_vector[idx];
+		list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
+	} else {
+		ring->ivec = &tp->int_vector[0];
+		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
+	}
+}
+
+static void rtase_tx_clear_range(struct rtase_ring *ring, u32 start, u32 n)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	struct net_device *dev = tp->dev;
+	u32 i;
+
+	for (i = 0u; i < n; i++) {
+		u32 entry = (start + i) % NUM_DESC;
+		u32 len = ring->mis.len[entry];
+
+		if (len != 0u) {
+			struct sk_buff *skb = ring->skbuff[entry];
+
+			rtase_unmap_tx_skb(tp->pdev, len, ring->desc + (sizeof(tx_desc) * entry));
+			ring->mis.len[entry] = 0;
+			if (skb) {
+				dev->stats.tx_dropped++;
+				dev_kfree_skb_any(skb);
+				ring->skbuff[entry] = NULL;
+			}
+		}
+	}
+}
+
+void rtase_tx_clear(struct rtase_private *tp)
+{
+	struct rtase_ring *ring;
+	u16 i;
+
+	for (i = 0u; i < tp->func_tx_queue_num; i++) {
+		ring = &tp->tx_ring[i];
+		rtase_tx_clear_range(ring, ring->dirty_idx, NUM_DESC);
+		ring->cur_idx = 0;
+		ring->dirty_idx = 0;
+	}
+}
+
+static inline void rtase_mark_to_asic(rx_desc *desc, u32 rx_buf_sz)
+{
+	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RING_END;
+
+	desc->desc_cmd.opts1 = cpu_to_le32(DESC_OWN | eor | rx_buf_sz);
+}
+
+static inline s32 rtase_fragmented_frame(u32 status)
+{
+	s32 ret;
+
+	if ((status & (RX_FIRST_FRAG | RX_LAST_FRAG)) != (RX_FIRST_FRAG | RX_LAST_FRAG))
+		ret = 1;
+	else
+		ret = 0;
+
+	return ret;
+}
+
+static inline void rtase_rx_csum(const struct rtase_private *tp, struct sk_buff *skb,
+				 const rx_desc *desc)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	/* rx csum offload */
+	if ((((opts2 & RX_V4F) != 0u) && ((opts2 & RX_IPF) == 0u)) || ((opts2 & RX_V6F) != 0u)) {
+		if ((((opts2 & RX_TCPT) != 0u) && ((opts2 & RX_TCPF) == 0u))
+		    || (((opts2 & RX_UDPT) != 0u) && ((opts2 & RX_UDPF) == 0u))) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			skb->ip_summed = CHECKSUM_NONE;
+		}
+	} else {
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+}
+
+static inline void rtase_rx_skb(const struct rtase_ring *ring, struct sk_buff *skb)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+
+	napi_gro_receive(&ivec->napi, skb);
+}
+
+static inline void rtase_map_to_asic(rx_desc *desc, dma_addr_t mapping, u32 rx_buf_sz)
+{
+	desc->desc_cmd.addr = cpu_to_le64(mapping);
+	/* make sure the physical address has been updated */
+	wmb();
+	rtase_mark_to_asic(desc, rx_buf_sz);
+}
+
+static inline void rtase_make_unusable_by_asic(rx_desc *desc)
+{
+	desc->desc_cmd.addr = 0x0BADBADBADBADBADuLL;
+	desc->desc_cmd.opts1 &= ~cpu_to_le32(DESC_OWN | RSVD_MASK);
+}
+
+static s32 rtase_alloc_rx_skb(const struct rtase_ring *ring, struct sk_buff **p_sk_buff,
+			      rx_desc *desc, dma_addr_t *rx_phy_addr, u32 rx_buf_sz, u8 in_intr)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+	const struct rtase_private *tp = ivec->tp;
+	struct sk_buff *skb = NULL;
+	dma_addr_t mapping;
+	s32 ret = 0;
+
+	if (in_intr != 0u)
+		skb = napi_alloc_skb(&ivec->napi, (rx_buf_sz + RTK_RX_ALIGN));
+	else
+		skb = dev_alloc_skb((rx_buf_sz + RTK_RX_ALIGN));
+
+	if (unlikely(!skb))
+		goto err_out;
+
+	skb_reserve(skb, RTK_RX_ALIGN);
+
+	mapping = dma_map_single(&tp->pdev->dev, skb->data, rx_buf_sz, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+		if (unlikely(net_ratelimit()))
+			netif_err(tp, drv, tp->dev, "Failed to map RX DMA!\n");
+
+		goto err_out;
+	}
+
+	*p_sk_buff = skb;
+	*rx_phy_addr = mapping;
+	rtase_map_to_asic(desc, mapping, rx_buf_sz);
+	goto out;
+
+err_out:
+	if (skb)
+		dev_kfree_skb(skb);
+
+	ret = -ENOMEM;
+	rtase_make_unusable_by_asic(desc);
+
+out:
+	return ret;
+}
+
+static u32 rtase_rx_ring_fill(struct rtase_ring *ring, u32 ring_start, u32 ring_end, u8 in_intr)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	u32 cur;
+
+	for (cur = ring_start; (ring_end - cur) > 0u; cur++) {
+		s32 ret = 0;
+		u32 i = cur % NUM_DESC;
+		rx_desc *desc = ring->desc + (sizeof(rx_desc) * i);
+
+		if (ring->skbuff[i])
+			continue;
+
+		ret = rtase_alloc_rx_skb(ring, &ring->skbuff[i], desc, &ring->mis.data_phy_addr[i],
+					 tp->rx_buf_sz, in_intr);
+		if (ret < 0)
+			break;
+	}
+
+	return (cur - ring_start);
+}
+
+static s32 rx_handler(struct rtase_ring *ring, s32 budget)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	u32 pkt_size, cur_rx, delta, entry, status;
+	struct net_device *dev = tp->dev;
+	struct sk_buff *skb;
+	s32 workdone = 0;
+	rx_desc *desc;
+
+	if (!ring->desc)
+		goto rx_out;
+
+	cur_rx = ring->cur_idx;
+	entry = cur_rx % NUM_DESC;
+	desc = ring->desc + (sizeof(rx_desc) * entry);
+
+	do {
+		/* make sure discriptor has been updated */
+		rmb();
+		status = le32_to_cpu(desc->desc_status.opts1);
+
+		if (status & DESC_OWN)
+			break;
+
+		if (unlikely(status & RX_RES)) {
+			if (net_ratelimit())
+				netdev_warn(dev, "Rx ERROR. status = %08x\n", status);
+
+			dev->stats.rx_errors++;
+
+			if (status & (RX_RWT | RX_RUNT))
+				dev->stats.rx_length_errors++;
+
+			if (status & RX_CRC)
+				dev->stats.rx_crc_errors++;
+
+			if (dev->features & NETIF_F_RXALL)
+				goto process_pkt;
+
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto out;
+		}
+
+process_pkt:
+		pkt_size = status & GENMASK(13, 0);
+		if (likely(!(dev->features & NETIF_F_RXFCS)))
+			pkt_size -= ETH_FCS_LEN;
+
+		/* The driver does not support incoming fragmented
+		 * frames. They are seen as a symptom of over-mtu
+		 * sized frames.
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			dev->stats.rx_dropped++;
+			dev->stats.rx_length_errors++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			continue;
+		}
+
+		skb = ring->skbuff[entry];
+		dma_sync_single_for_cpu(&tp->pdev->dev, ring->mis.data_phy_addr[entry],
+					tp->rx_buf_sz, DMA_FROM_DEVICE);
+
+		dma_unmap_single(&tp->pdev->dev, ring->mis.data_phy_addr[entry], tp->rx_buf_sz,
+				 DMA_FROM_DEVICE);
+		ring->skbuff[entry] = NULL;
+
+		if ((dev->features & NETIF_F_RXCSUM) != 0u)
+			rtase_rx_csum(tp, skb, desc);
+
+		skb->dev = dev;
+		skb_put(skb, pkt_size);
+		skb->protocol = eth_type_trans(skb, dev);
+
+		if (skb->pkt_type == PACKET_MULTICAST)
+			dev->stats.multicast++;
+
+		if (rtase_rx_vlan_skb(desc, skb) < 0)
+			rtase_rx_skb(ring, skb);
+
+		dev->stats.rx_bytes += pkt_size;
+		dev->stats.rx_packets++;
+out:
+		workdone++;
+		cur_rx++;
+		entry = cur_rx % NUM_DESC;
+		desc = ring->desc + (sizeof(rx_desc) * entry);
+		prefetch(desc);
+
+	} while (workdone != budget);
+
+	ring->cur_idx = cur_rx;
+	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx, 1);
+
+	if ((delta == 0u) && (workdone != 0))
+		netdev_info(dev, "%s: no Rx buffer allocated\n", dev->name);
+
+	ring->dirty_idx += delta;
+
+	/* FIXME: until there is periodic timer to try and refill the ring,
+	 * a temporary shortage may definitely kill the Rx process.
+	 * - disable the asic to try and avoid an overflow and kick it again
+	 *   after refill ?
+	 * - how do others driver handle this condition (Uh oh...).
+	 */
+	if (((ring->dirty_idx + NUM_DESC) == ring->cur_idx))
+		netdev_emerg(dev, "%s: Rx buffers exhausted\n", dev->name);
+
+rx_out:
+	return workdone;
+}
+
+static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->rx_ring[idx];
+	u16 i = 0;
+
+	memset(ring->desc, 0x0, RTASE_RX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, (NUM_DESC * sizeof(struct sk_buff *)));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0u; i < NUM_DESC; i++)
+		ring->mis.data_phy_addr[i] = 0;
+
+	ring->ring_handler = rx_handler;
+	ring->ivec = &tp->int_vector[idx];
+	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
+}
+
+static void rtase_desc_addr_fill(const struct rtase_private *tp)
+{
+	const struct rtase_ring *ring;
+	u16 cmd = 0;
+	u16 i = 0;
+
+	for (i = 0u; i < tp->func_tx_queue_num; i++) {
+		ring = &tp->tx_ring[i];
+
+		RTL_W32(tp, TX_DESC_START_ADDR0, (u32)(ring->phy_addr & DMA_BIT_MASK(32)));
+		RTL_W32(tp, TX_DESC_START_ADDR4, (u32)(ring->phy_addr >> 32));
+		cmd = i | TX_DESC_CMD_WE | TX_DESC_CMD_CS;
+		RTL_W16(tp, TX_DESC_COMMAND, cmd);
+		usleep_range(100, 110);
+	}
+
+	for (i = 0u; i < tp->func_rx_queue_num; i++) {
+		ring = &tp->rx_ring[i];
+
+		if (i == 0u) {
+			RTL_W32(tp, Q0_RX_DESC_ADDR0, (u32)((ring->phy_addr & DMA_BIT_MASK(32))));
+			RTL_W32(tp, Q0_RX_DESC_ADDR4, (u32)(ring->phy_addr >> 32));
+		} else {
+			RTL_W32(tp, (Q1_RX_DESC_ADDR0 + ((i - 1u) * 8u)),
+				(u32)(ring->phy_addr & DMA_BIT_MASK(32)));
+			RTL_W32(tp, (Q1_RX_DESC_ADDR4 + ((i - 1u) * 8u)),
+				(u32)(ring->phy_addr >> 32));
+		}
+	}
+}
+
+static inline void rtase_mark_as_last_descriptor(rx_desc *desc)
+{
+	desc->desc_cmd.opts1 |= cpu_to_le32(RING_END);
+}
+
+static void rtase_rx_ring_clear(struct rtase_ring *ring)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	rx_desc *desc;
+	u32 i;
+
+	for (i = 0u; i < NUM_DESC; i++) {
+		desc = ring->desc + (sizeof(rx_desc) * i);
+
+		if (ring->skbuff[i]) {
+			dma_unmap_single(&tp->pdev->dev, ring->mis.data_phy_addr[i], tp->rx_buf_sz,
+					 DMA_FROM_DEVICE);
+
+			dev_kfree_skb(ring->skbuff[i]);
+
+			ring->skbuff[i] = NULL;
+
+			rtase_make_unusable_by_asic(desc);
+		}
+	}
+}
+
+void rtase_rx_clear(struct rtase_private *tp)
+{
+	u32 i;
+
+	for (i = 0u; i < tp->func_rx_queue_num; i++)
+		rtase_rx_ring_clear(&tp->rx_ring[i]);
+}
+
+static s32 rtase_init_ring(const struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	s32 rc = 0;
+	u16 i = 0;
+
+	for (i = 0u; i < tp->func_tx_queue_num; i++)
+		rtase_tx_desc_init(tp, i);
+
+	for (i = 0u; i < tp->func_rx_queue_num; i++) {
+		rtase_rx_desc_init(tp, i);
+		if (rtase_rx_ring_fill(&tp->rx_ring[i], 0, NUM_DESC, 0) != NUM_DESC)
+			goto err_out;
+
+		rtase_mark_as_last_descriptor(tp->rx_ring[i].desc
+					      + (sizeof(rx_desc) * (NUM_DESC - 1u)));
+	}
+
+	goto out;
+
+err_out:
+	rtase_rx_clear(tp);
+	rc = -ENOMEM;
+out:
+	return rc;
+}
+
+static void rtase_set_mar(const struct rtase_private *tp)
+{
+
+	RTL_W32(tp, MAR0, tp->mc_filter[0]);
+	RTL_W32(tp, MAR1, tp->mc_filter[1]);
+}
+
+void rtase_hw_set_rx_packet_filter(struct net_device *dev)
+{
+	static const s32 multicast_filter_limit = 32;
+	struct rtase_private *tp = netdev_priv(dev);
+	u32 mc_filter[2];
+	u16 rx_mode;
+
+	rx_mode = (RTL_R16(tp, RX_CONFIG_0) & ~ACCEPT_MASK);
+
+	if ((dev->flags & IFF_PROMISC) != 0u) {
+		rx_mode |= ACCEPT_BROADCAST | ACCEPT_MULTICAST | ACCEPT_MYPHYS | ACCEPT_ALLPHYS;
+		mc_filter[0] = 0xFFFFFFFFu;
+		mc_filter[1] = 0xFFFFFFFFu;
+	} else if ((netdev_mc_count(dev) > multicast_filter_limit)
+		   || ((dev->flags & IFF_ALLMULTI) != 0u)) {
+		/* Too many to filter perfectly -- accept all multicasts. */
+		rx_mode |= ACCEPT_BROADCAST | ACCEPT_MULTICAST | ACCEPT_MYPHYS;
+		mc_filter[0] = 0xFFFFFFFFu;
+		mc_filter[1] = 0xFFFFFFFFu;
+	} else {
+		const struct netdev_hw_addr *ha;
+
+		rx_mode |= ACCEPT_BROADCAST | ACCEPT_MYPHYS;
+		mc_filter[0] = 0u;
+		mc_filter[1] = 0u;
+
+		/* clang-format off */
+		netdev_for_each_mc_addr(ha, dev) {
+			u32 bit_nr = (ether_crc(ETH_ALEN, ha->addr) >> 26);
+
+			mc_filter[bit_nr >> 5] |= (1u << (bit_nr & 31u));
+			rx_mode |= ACCEPT_MULTICAST;
+		}
+		/* clang-format on */
+	}
+
+	if ((dev->features & NETIF_F_RXALL) != 0u)
+		rx_mode |= (ACCEPT_ERR | ACCEPT_RUNT);
+
+	tp->mc_filter[0] = swab32(mc_filter[1]);
+	tp->mc_filter[1] = swab32(mc_filter[0]);
+
+	rtase_set_mar(tp);
+	RTL_W16(tp, RX_CONFIG_0, rx_mode);
+}
+
+static void rtase_hw_config(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u32 reg_data = 0;
+
+	rtase_hw_reset(dev);
+
+	/* Set Rx DMA burst */
+	reg_data = RTL_R16(tp, RX_CONFIG_0);
+	reg_data &= ~(RX_SINGLE_TAG | RX_SINGLE_FETCH);
+	reg_data &= ~(RX_MX_DMA_MASK << RX_MX_DMA_SHIFT);
+	reg_data |= (RX_DMA_BURST_256 << RX_MX_DMA_SHIFT);
+	RTL_W16(tp, RX_CONFIG_0, reg_data);
+
+	/* New Rx Descritpor */
+	reg_data = RTL_R16(tp, RX_CONFIG_1);
+	reg_data |= RX_NEW_DESC_FORMAT_EN;
+	reg_data |= PCIE_NEW_FLOW;
+	/* Rx Fetch Desc Number */
+	reg_data &= ~(RX_MAX_FETCH_DESC_MASK << RX_MAX_FETCH_DESC_SHIFT);
+	reg_data |= (0xF << RX_MAX_FETCH_DESC_SHIFT);
+	RTL_W16(tp, RX_CONFIG_1, reg_data);
+
+	/* Rx queue numbers */
+	reg_data = RTL_R16(tp, FCR);
+	reg_data &= ~(FCR_RXQ_MASK << FCR_RXQ_SHIFT);
+	switch (tp->func_rx_queue_num) {
+	case 1:
+		reg_data |= (0x1u << FCR_RXQ_SHIFT);
+		break;
+	case 2:
+		reg_data |= (0x2u << FCR_RXQ_SHIFT);
+		break;
+	case 4:
+		reg_data |= (0x3u << FCR_RXQ_SHIFT);
+		break;
+	default:
+		/* nothing to do. */
+		break;
+	}
+	RTL_W16(tp, FCR, reg_data);
+
+	/* interrupt mitigation */
+	rtase_interrupt_mitigation(tp);
+
+	/* Set Tx DMA burst size and Interframe Gap Time */
+	reg_data = RTL_R32(tp, TX_CONFIG_0);
+	reg_data &= ~((TX_DMA_MASK << TX_DMA_SHIFT)
+		      | (TX_INTER_FRAME_GAP_MASK << TX_INTER_FRAME_GAP_SHIFT));
+	reg_data |= ((TX_DMA_BURST_UNLIMITED << TX_DMA_SHIFT)
+		     | (INTERFRAMEGAP << TX_INTER_FRAME_GAP_SHIFT));
+	RTL_W32(tp, TX_CONFIG_0, reg_data);
+
+	/* New Tx Descriptor */
+	RTL_W16(tp, TFUN_CTRL, (RTL_R16(tp, TFUN_CTRL) | TX_NEW_DESC_FORMAT_EN));
+
+	/* Tx Fetch Desc Number */
+	RTL_W8(tp, TDFNR, 0x10);
+
+	/* tag num select */
+	reg_data = RTL_R16(tp, MTPS);
+	reg_data &= ~(0x7u << 8);
+	reg_data |= (0x4u << 8);
+	RTL_W16(tp, MTPS, reg_data);
+
+	/* Tx queue numbers */
+	reg_data = RTL_R16(tp, TX_CONFIG_1);
+	reg_data &= ~(0x3u << 10);
+	switch (tp->tx_queue_ctrl) {
+	case 1:
+		break;
+	case 2:
+		reg_data |= (0x1u << 10);
+		break;
+	case 3:
+	case 4:
+		reg_data |= (0x2u << 10);
+		break;
+	default:
+		reg_data |= (0x3u << 10);
+		break;
+	}
+	RTL_W16(tp, TX_CONFIG_1, reg_data);
+
+	/* TOK condition */
+	RTL_W16(tp, TOKSEL, 0x5555);
+
+	rtase_tally_counter_addr_fill(tp);
+	rtase_desc_addr_fill(tp);
+
+	if (rtase_hw_set_features(dev, dev->features) != 0)
+		netdev_alert(dev, "unable to set hw features\n");
+
+	/* TBD: enable flow control */
+	reg_data = RTL_R16(tp, CPLUS_CMD);
+	reg_data |= (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
+	RTL_W16(tp, CPLUS_CMD, reg_data);
+	/* Set Near FIFO Threshold - rx missed issue. */
+	RTL_W16(tp, RFIFONFULL, 0x190);
+
+	RTL_W16(tp, RMS, tp->rx_buf_sz);
+
+	/* Set Rx packet filter */
+	rtase_hw_set_rx_packet_filter(dev);
+
+	/* enable ephy interrupt */
+	mac_ocp_write(tp, 0xEAD0, 0xFF07);
+}
+
+void rtase_hw_start(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_nic_enable(dev);
+	rtase_enable_hw_interrupt(tp);
+}
+
+static int rtase_open(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec = &tp->int_vector[0];
+	const struct pci_dev *pdev = tp->pdev;
+	int retval;
+	u16 i;
+
+	rtase_set_rxbufsize(tp, dev);
+
+	retval = rtase_alloc_desc(tp);
+	if (retval < 0)
+		goto err_free_all_allocated_mem;
+
+	retval = rtase_init_ring(dev);
+	if (retval < 0)
+		goto err_free_all_allocated_mem;
+
+	INIT_DELAYED_WORK(&tp->task, NULL);
+
+	rtase_hw_config(dev);
+
+	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u) {
+		retval = request_irq(ivec->irq, rtase_interrupt, 0, dev->name, dev);
+
+		/* request other interrupts to handle multiqueue */
+		for (i = 1; i < tp->int_nums; i++) {
+			if (retval == 0) {
+				ivec = &tp->int_vector[i];
+				if (ivec->status == 1u) {
+					sprintf((char *)&ivec->name, "%s_int%i", dev->name, i);
+					retval = request_irq(ivec->irq, rtase_q_interrupt, 0,
+							     (char *)&ivec->name, ivec);
+				}
+			}
+		}
+	} else if ((tp->sw_flag & SWF_MSI_ENABLED) != 0u) {
+		retval = request_irq(pdev->irq, rtase_interrupt, 0, dev->name, dev);
+	} else {
+		retval = request_irq(pdev->irq, rtase_interrupt, IRQF_SHARED, dev->name, dev);
+	}
+
+	if (retval != 0) {
+		netdev_err(dev, "%s: can't request MSIX interrupt. Error: %d", dev->name, retval);
+		goto err_free_all_allocated_mem;
+	}
+
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+	netdev_info(dev, "%s: link up\n", dev->name);
+
+	goto out;
+
+err_free_all_allocated_mem:
+	rtase_free_desc(tp);
+
+out:
+	return retval;
+}
+
+static void rtase_down(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	unsigned long flags;
+	u32 i = 0u;
+
+	netif_stop_queue(dev);
+
+	/* Give a racing hard_start_xmit a few cycles to complete. */
+	synchronize_rcu();
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	netif_carrier_off(dev);
+
+	rtase_hw_reset(dev);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	for (i = 0u; i < tp->int_nums; i++)
+		synchronize_irq(tp->int_vector[i].irq);
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	rtase_tx_clear(tp);
+
+	rtase_rx_clear(tp);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+}
+
+static int rtase_close(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+	u32 i = 0;
+
+	rtase_down(dev);
+
+	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u) {
+		free_irq(tp->int_vector[i].irq, dev);
+		for (i = 1; i < tp->int_nums; i++)
+			free_irq(tp->int_vector[i].irq, &tp->int_vector[i]);
+
+	} else {
+		free_irq(pdev->irq, dev);
+	}
+
+	rtase_free_desc(tp);
+
+	return 0;
+}
+
+static s32 rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb, u32 opts1, u32 opts2)
+{
+	const struct skb_shared_info *info = skb_shinfo(skb);
+	const struct rtase_private *tp = ring->ivec->tp;
+	const u8 nr_frags = info->nr_frags;
+	u32 cur_frag, entry;
+	tx_desc *txd = NULL;
+	u64 pkt_len_cnt = 0;
+	s32 rc = 0;
+
+	entry = ring->cur_idx;
+	for (cur_frag = 0; cur_frag < nr_frags; cur_frag++) {
+		const skb_frag_t *frag = &info->frags[cur_frag];
+		dma_addr_t mapping;
+		u32 status, len;
+		void *addr;
+
+		entry = (entry + 1u) % NUM_DESC;
+
+		txd = ring->desc + (sizeof(tx_desc) * entry);
+		len = skb_frag_size(frag);
+		addr = skb_frag_address(frag);
+		mapping = dma_map_single(&tp->pdev->dev, addr, len, DMA_TO_DEVICE);
+
+		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+			if (unlikely(net_ratelimit()))
+				netif_err(tp, drv, tp->dev, "Failed to map TX fragments DMA!\n");
+
+			goto err_out;
+		}
+
+		if (((entry + 1u) % NUM_DESC) == 0u)
+			status = (opts1 | len | RING_END);
+		else
+			status = opts1 | len;
+
+		if (cur_frag == (nr_frags - 1u)) {
+			ring->skbuff[entry] = skb;
+			status |= TX_LAST_FRAG;
+		}
+
+		txd->addr = cpu_to_le64(mapping);
+		ring->mis.len[entry] = len;
+		txd->opts2 = cpu_to_le32(opts2);
+		/* make sure the operating fields have been updated */
+		wmb();
+		txd->opts1 = cpu_to_le32(status);
+		pkt_len_cnt += len;
+	}
+
+	rc = cur_frag;
+	goto out;
+
+err_out:
+	rtase_tx_clear_range(ring, ring->cur_idx + 1u, cur_frag);
+	rc = -EIO;
+out:
+	return rc;
+}
+
+static inline __be16 get_protocol(const struct sk_buff *skb)
+{
+	__be16 protocol;
+
+	if (skb->protocol == htons(ETH_P_8021Q))
+		protocol = vlan_eth_hdr(skb)->h_vlan_encapsulated_proto;
+	else
+		protocol = skb->protocol;
+
+	return protocol;
+}
+
+static inline u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
+{
+	u32 csum_cmd = 0;
+	u8 ip_protocol;
+
+	switch (vlan_get_protocol(skb)) {
+	case htons(ETH_P_IP):
+		csum_cmd = TX_IPCS_C;
+		ip_protocol = ip_hdr(skb)->protocol;
+		break;
+
+	case htons(ETH_P_IPV6):
+		csum_cmd = TX_IPV6F_C;
+		ip_protocol = ipv6_hdr(skb)->nexthdr;
+		break;
+
+	default:
+		ip_protocol = IPPROTO_RAW;
+		break;
+	}
+
+	if (ip_protocol == IPPROTO_TCP)
+		csum_cmd |= TX_TCPCS_C;
+	else if (ip_protocol == IPPROTO_UDP)
+		csum_cmd |= TX_UDPCS_C;
+	else
+		WARN_ON_ONCE(1);
+
+	csum_cmd |= skb_transport_offset(skb) << TCPHO_SHIFT;
+
+	return csum_cmd;
+}
+
+static netdev_tx_t rtase_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct rtase_private *tp = netdev_priv(dev);
+	u32 q_idx, entry, len, opts1, opts2;
+	u32 mss = shinfo->gso_size;
+	struct rtase_ring *ring;
+	unsigned long flags;
+	dma_addr_t mapping;
+	tx_desc *txd;
+	s32 frags;
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	/* multiqueues */
+	q_idx = skb_get_queue_mapping(skb);
+	ring = &tp->tx_ring[q_idx];
+
+	if (unlikely(rtase_tx_avail(ring) < shinfo->nr_frags)) {
+		if (net_ratelimit())
+			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
+		goto err_stop;
+	}
+
+	entry = ring->cur_idx % NUM_DESC;
+	txd = ring->desc + (sizeof(tx_desc) * entry);
+
+	opts1 = DESC_OWN;
+	opts2 = rtase_tx_vlan_tag(tp, skb);
+
+	/* TCP Segmentation Offload (or TCP Large Send) */
+	if (mss) {
+		if (shinfo->gso_type & SKB_GSO_TCPV4) {
+			opts1 |= GIANT_SEND_V4;
+		} else if (shinfo->gso_type & SKB_GSO_TCPV6) {
+			if (skb_cow_head(skb, 0))
+				goto err_dma_0;
+
+			tcp_v6_gso_csum_prep(skb);
+			opts1 |= GIANT_SEND_V6;
+		} else {
+			WARN_ON_ONCE(1);
+		}
+
+		opts1 |= skb_transport_offset(skb) << GTTCPHO_SHIFT;
+		opts2 |= mss << 18;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		opts2 |= rtase_tx_csum(skb, dev);
+	}
+
+	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
+	if (unlikely(frags < 0))
+		goto err_dma_0;
+
+	if (frags) {
+		len = skb_headlen(skb);
+		opts1 |= TX_FIRST_FRAG;
+	} else {
+		len = skb->len;
+		ring->skbuff[entry] = skb;
+		opts1 |= (TX_FIRST_FRAG | TX_LAST_FRAG);
+	}
+
+	if ((((entry + 1u) % NUM_DESC) == 0u))
+		opts1 |= (len | RING_END);
+	else
+		opts1 |= len;
+
+	mapping = dma_map_single(&tp->pdev->dev, skb->data, len, DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+		if (unlikely(net_ratelimit()))
+			netif_err(tp, drv, dev, "Failed to map TX DMA!\n");
+
+		goto err_dma_1;
+	}
+
+	ring->mis.len[entry] = len;
+	txd->addr = cpu_to_le64(mapping);
+	txd->opts2 = cpu_to_le32(opts2);
+	txd->opts1 = cpu_to_le32(opts1 & ~DESC_OWN);
+	/* make sure the operating fields have been updated */
+	wmb();
+	txd->opts1 = cpu_to_le32(opts1);
+	skb_tx_timestamp(skb);
+
+	/* tx needs to see descriptor changes before updated cur_idx */
+	smp_wmb();
+	WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1u);
+
+	/* set polling bit */
+	RTL_W8(tp, TPPOLL, BIT(ring->index));
+
+	if (rtase_tx_avail(ring) < MAX_SKB_FRAGS) {
+		netif_stop_queue(dev);
+		/* make sure cur_idx and dirty_idx have been updated */
+		smp_rmb();
+		if (rtase_tx_avail(ring) >= MAX_SKB_FRAGS)
+			netif_wake_queue(dev);
+	}
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+	return NETDEV_TX_OK;
+
+err_dma_1:
+	ring->skbuff[entry] = NULL;
+	rtase_tx_clear_range(ring, ring->cur_idx + 1u, frags);
+
+err_dma_0:
+	dev->stats.tx_dropped++;
+	spin_unlock_irqrestore(&tp->lock, flags);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+
+err_stop:
+	netif_stop_queue(dev);
+	dev->stats.tx_dropped++;
+	spin_unlock_irqrestore(&tp->lock, flags);
+	return NETDEV_TX_BUSY;
+}
+
+static void rtase_set_rx_mode(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	rtase_hw_set_rx_packet_filter(dev);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+}
+
+/* rtase_set_mac_address - Change the Ethernet Address of the NIC
+ * @dev: network interface device structure
+ * @p:   pointer to an address structure
+ *
+ * Return 0 on success, negative on failure
+ */
+static int rtase_set_mac_address(struct net_device *dev, void *p)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct sockaddr *addr = p;
+	unsigned long flags;
+	s32 rc = 0;
+
+	if (!is_valid_ether_addr((u8 *)&addr->sa_data)) {
+		rc = -EADDRNOTAVAIL;
+	} else {
+		spin_lock_irqsave(&tp->lock, flags);
+		rtase_hw_address_set(dev, (u8 *)&addr->sa_data);
+		rtase_rar_set(tp, dev->dev_addr);
+		spin_unlock_irqrestore(&tp->lock, flags);
+	}
+
+	return rc;
+}
+
+static int rtase_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&tp->lock, flags);
+	dev->mtu = new_mtu;
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_down(dev);
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	rtase_set_rxbufsize(tp, dev);
+
+	ret = rtase_init_ring(dev);
+
+	if (ret < 0) {
+		spin_unlock_irqrestore(&tp->lock, flags);
+		goto err_out;
+	}
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	rtase_hw_config(dev);
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+out:
+	netdev_update_features(dev);
+
+err_out:
+	return ret;
+}
+
+static void rtase_wait_for_quiescence(const struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	u32 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		synchronize_irq(ivec->irq);
+		/* Wait for any pending NAPI task to complete */
+		napi_disable(&ivec->napi);
+	}
+
+	rtase_irq_mask_and_ack(tp);
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_enable(&ivec->napi);
+	}
+}
+
+static void rtase_sw_reset(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	unsigned long flags;
+
+	netdev_info(dev, "%s is triggered.", __func__);
+	spin_lock_irqsave(&tp->lock, flags);
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	rtase_hw_reset(dev);
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	/* Let's wait a bit while any (async) irq lands on */
+	rtase_wait_for_quiescence(dev);
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	if (rtase_init_ring(dev) != 0)
+		netdev_alert(dev, "unable to init ring\n");
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+}
+
+static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	rtase_sw_reset(dev);
+}
+
+static void rtase_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters = tp->tally_vaddr;
+	dma_addr_t paddr = tp->tally_paddr;
+
+	if (counters) {
+		netdev_stats_to_stats64(stats, &dev->stats);
+		dev_fetch_sw_netstats(stats, dev->tstats);
+
+		/* Fetch additional counter values missing in stats collected by driver from tally
+		 * counter
+		 */
+		rtase_dump_tally_counter(tp, paddr);
+
+		stats->tx_errors = le64_to_cpu(counters->tx_errors);
+		stats->collisions = le64_to_cpu(counters->tx_multi_collision);
+		stats->tx_aborted_errors = le64_to_cpu(counters->tx_aborted);
+		stats->rx_missed_errors = le64_to_cpu(counters->rx_missed);
+	}
+}
+
+static void rtase_vlan_filter(const struct rtase_private *tp, u8 enabled)
+{
+	u16 tmp = 0;
+
+	if (enabled == 1u) {
+		/* PFCR */
+		tmp = RTL_R16(tp, FCR);
+		if ((tmp & FCR_VLAN_FTR_EN) == 0u)
+			RTL_W16(tp, FCR, (tmp | FCR_VLAN_FTR_EN));
+
+		/* PCPR */
+		tmp = RTL_R16(tp, PCPR);
+		if ((tmp & PCPR_VLAN_FTR_EN) == 0u)
+			RTL_W16(tp, PCPR, (tmp | PCPR_VLAN_FTR_EN));
+
+	} else {
+		/* PFCR */
+		tmp = RTL_R16(tp, FCR);
+		if ((tmp & FCR_VLAN_FTR_EN) != 0u)
+			RTL_W16(tp, FCR, (tmp & ~FCR_VLAN_FTR_EN));
+
+		/* PCPR */
+		tmp = RTL_R16(tp, PCPR);
+		if ((tmp & PCPR_VLAN_FTR_EN) == 0u)
+			RTL_W16(tp, PCPR, (tmp & ~PCPR_VLAN_FTR_EN));
+	}
+}
+
+static int rtase_vlan_rx_add_vid(struct net_device *dev, __be16 protocol, u16 vid)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u16 tmp_mem = 0;
+	int ret = 0;
+	u16 i = 0u;
+
+	if (be16_to_cpu(protocol) != ETH_P_8021Q) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* vlan filter table */
+	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++) {
+		if ((tp->vlan_filter_ctrl & BIT(i)) == 0u) {
+			tp->vlan_filter_ctrl |= BIT(i);
+			tp->vlan_filter_vid[i] = vid;
+			RTL_W32(tp, (VLAN_ENTRY_0 + (i * 4u)), (vid | VLAN_ENTRY_CAREBIT));
+
+			tmp_mem = RTL_R16(tp, (VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)));
+			tmp_mem |= (0x1u << ((i % 2u) * 8u));
+			RTL_W16(tp, (VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)), tmp_mem);
+			break;
+		}
+	}
+
+	if (i == VLAN_FILTER_ENTRY_NUM) {
+		ret = -ENOMEM;
+	} else {
+		/* check vlan filter enabled */
+		rtase_vlan_filter(tp, 1u);
+	}
+
+out:
+	return ret;
+}
+
+static int rtase_vlan_rx_kill_vid(struct net_device *dev, __be16 protocol, u16 vid)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u16 tmp_mem = 0u;
+	u16 i = 0u;
+	s32 rc = 0;
+
+	if (be16_to_cpu(protocol) != ETH_P_8021Q) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/* vlan filter table */
+	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++) {
+		if (tp->vlan_filter_vid[i] == vid) {
+			tp->vlan_filter_ctrl &= ~BIT(i);
+			tp->vlan_filter_vid[i] = 0;
+			RTL_W32(tp, (VLAN_ENTRY_0 + (i * 4u)), 0);
+
+			tmp_mem = RTL_R16(tp, (VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)));
+			tmp_mem &= (~(0x1u << ((i % 2u) * 8u)));
+			RTL_W16(tp, (VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)), tmp_mem);
+			break;
+		}
+	}
+
+	/* check vlan filter enabled */
+	if (tp->vlan_filter_ctrl == 0u) {
+		/* disable vlan filter */
+		rtase_vlan_filter(tp, 0u);
+	}
+
+out:
+	return rc;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+
+/* Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+static void rtase_netpoll(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+
+	disable_irq(pdev->irq);
+	rtase_interrupt(pdev->irq, dev);
+	enable_irq(pdev->irq);
+}
+#endif
+
+static void rtase_set_hw_cbs(const struct rtase_private *tp, u32 queue)
+{
+	u32 idle = tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
+	u32 regV = 0;
+	u32 i = 0;
+
+	regV = idle / RTASE_1T_POWER;
+	regV <<= RTASE_IDLESLOPE_INT_SHIFT;
+	idle %= RTASE_1T_POWER;
+	for (i = 0; i < RTASE_IDLESLOPE_INT_SHIFT; i++) {
+		idle *= 2u;
+		if ((idle / RTASE_1T_POWER) == 1u)
+			regV |= (0x1u << (RTASE_IDLESLOPE_INT_SHIFT - i - 1u));
+
+		idle %= RTASE_1T_POWER;
+	}
+	RTL_W32(tp, (TXQCRDT_0 + (queue * 4u)), regV);
+}
+
+static int rtase_setup_tc_cbs(struct rtase_private *tp, const struct tc_cbs_qopt_offload *qopt)
+{
+	u32 queue = qopt->queue;
+
+	/* record settings */
+	tp->tx_qos[queue].hicredit = qopt->hicredit;
+	tp->tx_qos[queue].locredit = qopt->locredit;
+	tp->tx_qos[queue].idleslope = qopt->idleslope;
+	tp->tx_qos[queue].sendslope = qopt->sendslope;
+
+	/* set hardware cbs */
+	rtase_set_hw_cbs(tp, queue);
+
+	return 0;
+}
+
+static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret = 0;
+
+	switch (type) {
+	case TC_SETUP_QDISC_MQPRIO:
+		break;
+	case TC_SETUP_BLOCK:
+		break;
+	case TC_SETUP_QDISC_CBS:
+		ret = rtase_setup_tc_cbs(tp, type_data);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static netdev_features_t rtase_fix_features(struct net_device *dev, netdev_features_t features)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	netdev_features_t features_fix = features;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tp->lock, flags);
+	if (dev->mtu > MSS_MAX)
+		features_fix &= ~NETIF_F_ALL_TSO;
+
+	if (dev->mtu > ETH_DATA_LEN) {
+		features_fix &= ~NETIF_F_ALL_TSO;
+		features_fix &= ~NETIF_F_ALL_CSUM;
+	}
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	return features_fix;
+}
+
+static int rtase_set_features(struct net_device *dev, netdev_features_t features)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	netdev_features_t features_set = features;
+	unsigned long flags;
+
+	features_set &= NETIF_F_RXALL | NETIF_F_RXCSUM | NETIF_F_HW_VLAN_RX;
+
+	spin_lock_irqsave(&tp->lock, flags);
+	if ((features_set ^ dev->features) != 0u) {
+		if (rtase_hw_set_features(dev, features_set) != 0)
+			netdev_alert(dev, "unable to set hw feature\n");
+	}
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	return 0;
+}
+
+static const struct net_device_ops rtase_netdev_ops = {
+	.ndo_open = rtase_open,
+	.ndo_stop = rtase_close,
+	.ndo_start_xmit = rtase_start_xmit,
+	.ndo_set_rx_mode = rtase_set_rx_mode,
+	.ndo_set_mac_address = rtase_set_mac_address,
+	.ndo_change_mtu = rtase_change_mtu,
+	.ndo_tx_timeout = rtase_tx_timeout,
+	.ndo_get_stats64 = rtase_get_stats64,
+	.ndo_vlan_rx_add_vid = rtase_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = rtase_vlan_rx_kill_vid,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = rtase_netpoll,
+#endif
+	.ndo_setup_tc = rtase_setup_tc,
+	.ndo_fix_features = rtase_fix_features,
+	.ndo_set_features = rtase_set_features,
+};
+
+static const struct ethtool_ops rtase_ethtool_ops = {
+	.get_drvinfo = rtase_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_link_ksettings = rtase_get_settings,
+	.get_pauseparam = rtase_get_pauseparam,
+	.set_pauseparam = rtase_set_pauseparam,
+	.get_msglevel = rtase_get_msglevel,
+	.set_msglevel = rtase_set_msglevel,
+	.get_strings = rtase_get_strings,
+	.get_sset_count = rtase_get_sset_count,
+	.get_ethtool_stats = rtase_get_ethtool_stats,
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
+static void rtase_init_netdev_ops(struct net_device *dev)
+{
+	dev->netdev_ops = &rtase_netdev_ops;
+	dev->ethtool_ops = &rtase_ethtool_ops;
+}
+
+/* rtase_init_board -
+ * @pdev: PCI device struct
+ * @dev_out:
+ * @ioaddr_out:
+ *
+ * Return 0 on success, negative on failure
+ */
+static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
+			    void __iomem **ioaddr_out)
+{
+	struct net_device *dev;
+	void __iomem *ioaddr;
+	int rc = -ENOMEM;
+
+	/* dev zeroed in alloc_etherdev */
+	dev = alloc_etherdev_mq(sizeof(struct rtase_private), FUNC_TXQ_NUM);
+	if (!dev)
+		goto err_out;
+
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	/* enable device (incl. PCI PM wakeup and hotplug setup) */
+	rc = pci_enable_device(pdev);
+	if (rc < 0)
+		goto err_out_free_dev;
+
+	/* make sure PCI base addr 1 is MMIO */
+	if ((pci_resource_flags(pdev, 2) & IORESOURCE_MEM) == 0u) {
+		rc = -ENODEV;
+		goto err_out_disable;
+	}
+
+	/* check for weird/broken PCI region reporting */
+	if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
+		rc = -ENODEV;
+		goto err_out_disable;
+	}
+
+	rc = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (rc < 0)
+		goto err_out_disable;
+
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) == 0)
+		dev->features |= NETIF_F_HIGHDMA;
+	else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0)
+		goto err_out_free_res;
+	else
+		pr_info("DMA_BIT_MASK: 32\n");
+
+	pci_set_master(pdev);
+
+	/* ioremap MMIO region */
+	ioaddr = ioremap(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
+	if (!ioaddr) {
+		rc = -EIO;
+		goto err_out_free_res;
+	}
+
+	*ioaddr_out = ioaddr;
+	*dev_out = dev;
+	goto out;
+
+err_out_free_res:
+	pci_release_regions(pdev);
+
+err_out_disable:
+	pci_disable_device(pdev);
+
+err_out_free_dev:
+	free_netdev(dev);
+
+err_out:
+	*ioaddr_out = NULL;
+	*dev_out = NULL;
+
+out:
+	return rc;
+}
+
+static void rtase_release_board(struct pci_dev *pdev, struct net_device *dev, void __iomem *ioaddr)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_rar_set(tp, tp->org_mac_addr);
+	iounmap(ioaddr);
+	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u)
+		pci_disable_msix(pdev);
+	else
+		pci_disable_msi(pdev);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	free_netdev(dev);
+}
+
+/* rtase_init_one - PCI Device Initialization
+ * @pdev: PCI device struct
+ * @ent: entry in rtlxxx_pci_tbl
+ *
+ * Return 0 on success, negative on failure
+ */
+static int rtase_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct net_device *dev = NULL;
+	void __iomem *ioaddr = NULL;
+	struct rtase_private *tp;
+	int rc;
+
+	if ((pdev->is_physfn == 0u) && (pdev->is_virtfn != 0u)) {
+		pr_info("This module does not support a virtual function.");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	pr_info("Automotive Switch Ethernet driver loaded\n");
+
+	rc = rtase_init_board(pdev, &dev, &ioaddr);
+	if (rc != 0)
+		goto out;
+
+	tp = netdev_priv(dev);
+	tp->mmio_addr = ioaddr;
+	tp->dev = dev;
+	tp->pdev = pdev;
+	/* Identify chip attached to board */
+	rtase_get_mac_version(tp);
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		goto err_out_1;
+
+	rtase_init_software_variable(tp);
+	rtase_init_hardware(tp);
+
+	rc = rtase_alloc_interrupt(pdev, tp);
+	if (rc < 0)
+		pr_err("unable to alloc MSIX/MSI\n");
+
+	rtase_init_netdev_ops(dev);
+
+	dev->watchdog_timeo = RTASE_TX_TIMEOUT;
+	dev->irq = pdev->irq;
+	dev->base_addr = (unsigned long)ioaddr;
+
+	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
+
+	if (tp->mcfg != CFG_METHOD_DEFAULT) {
+		dev->features |= NETIF_F_IP_CSUM;
+		dev->features |= NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO;
+		dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO | NETIF_F_RXCSUM
+				   | NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
+		dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO | NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+		dev->hw_features |= NETIF_F_RXALL;
+		dev->hw_features |= NETIF_F_RXFCS;
+		dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+		dev->features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+		netif_set_tso_max_size(dev, LSO_64K);
+		netif_set_tso_max_segs(dev, NIC_MAX_PHYS_BUF_COUNT_LSO2);
+	}
+
+	rtase_get_mac_address(dev);
+
+	tp->tally_vaddr = dma_alloc_coherent(&pdev->dev, sizeof(*tp->tally_vaddr), &tp->tally_paddr,
+					     GFP_KERNEL);
+	if (!tp->tally_vaddr) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	rtase_tally_counter_clear(tp);
+
+	pci_set_drvdata(pdev, dev);
+
+	rc = register_netdev(dev);
+	if (rc != 0)
+		goto err_out;
+
+	netdev_info(dev, "%s, %pM, IRQ %d\n", dev->name, dev->dev_addr, dev->irq);
+
+	netif_carrier_off(dev);
+
+	goto out;
+
+err_out:
+	if (tp->tally_vaddr) {
+		dma_free_coherent(&pdev->dev, sizeof(*tp->tally_vaddr), tp->tally_vaddr,
+				  tp->tally_paddr);
+
+		tp->tally_vaddr = NULL;
+	}
+
+err_out_1:
+	rtase_release_board(pdev, dev, ioaddr);
+
+out:
+	return rc;
+}
+
+static void rtase_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	u32 i = 0u;
+
+	for (i = 0u; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		netif_napi_del(&ivec->napi);
+	}
+
+	unregister_netdev(dev);
+	rtase_reset_interrupt(pdev, tp);
+	if (tp->tally_vaddr) {
+		dma_free_coherent(&pdev->dev, sizeof(*tp->tally_vaddr), tp->tally_vaddr,
+				  tp->tally_paddr);
+		tp->tally_vaddr = NULL;
+	}
+
+	rtase_release_board(pdev, dev, tp->mmio_addr);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static void rtase_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	if (netif_running(dev)) {
+		if (rtase_close(dev) != 0)
+			netdev_alert(dev, "unable to close\n");
+	}
+	rtase_reset_interrupt(pdev, tp);
+}
+
+#ifdef CONFIG_PM
+
+static int rtase_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	unsigned long flags;
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_stop_queue(dev);
+
+	netif_carrier_off(dev);
+
+	netif_device_detach(dev);
+
+	spin_lock_irqsave(&tp->lock, flags);
+
+	rtase_hw_reset(dev);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+out:
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int rtase_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	/* restore last modified mac address */
+	rtase_rar_set(tp, dev->dev_addr);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_wait_for_quiescence(dev);
+	netif_device_attach(dev);
+
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	if (rtase_init_ring(dev) != 0)
+		netdev_alert(dev, "unable to init ring\n");
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+out:
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+static struct pci_driver rtase_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtase_pci_tbl,
+	.probe = rtase_init_one,
+	.remove = rtase_remove_one,
+	.shutdown = rtase_shutdown,
+#ifdef CONFIG_PM
+	.suspend = rtase_suspend,
+	.resume = rtase_resume,
+#endif
+};
+
+module_pci_driver(rtase_pci_driver);
-- 
2.34.1

