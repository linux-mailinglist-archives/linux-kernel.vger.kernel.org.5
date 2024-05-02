Return-Path: <linux-kernel+bounces-166198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E088B9776
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B431C22BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA85466B;
	Thu,  2 May 2024 09:19:45 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9B56443;
	Thu,  2 May 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641584; cv=none; b=XMuwLAkgYMPXGv5UNR1Yf96og/lnQWIHLQITWNy4p+EtNjHRqUw4UdUJb6XYiFjygR58oySpXlotcDR66O1xDqKjDPhRaQJ0wRgLO951yLHXTKL4nx4gjug7xpikntXBZjMlmzboaCCMgwmuB/Vq6fc4WHyLwHOqcuw7b8+Y1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641584; c=relaxed/simple;
	bh=lo9u8HvBEAPQV8TBjsiMlbj6piwWzWpisaWROeXrRdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfMNS8L0C7xvmSoLF8f67wuy2hLg3iDOlaeXNKhFm/Wp1BT21pCk/wFtVnnwhGSkKi6r/l6aEPT9RdyJiJqMI2+hF/u91IxskDBqONx6/ca/+tjtuyNk46HiKZyiQKIaeZfgz/aQM/1OCnAlhWR1OA7AEz4GnVzG7kdWEMkGqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4429JIHU02331007, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4429JIHU02331007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:19:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 17:19:19 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 17:19:17 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v17 01/13] rtase: Add pci table supported in this module
Date: Thu, 2 May 2024 17:18:35 +0800
Message-ID: <20240502091847.65181-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502091847.65181-1-justinlai0215@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add pci table supported in this module, and implement pci_driver function
to initialize this driver, remove this driver, or shutdown this driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    | 326 +++++++++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 618 ++++++++++++++++++
 2 files changed, 944 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
new file mode 100644
index 000000000000..6e6fe4759e7f
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
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
+#define RTASE_HW_VER_MASK 0x7C800000
+
+#define RTASE_RX_DMA_BURST_256       4
+#define RTASE_TX_DMA_BURST_UNLIMITED 7
+#define RTASE_RX_BUF_SIZE            (PAGE_SIZE - \
+				      SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define RTASE_MAX_JUMBO_SIZE         (RTASE_RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN)
+
+/* 3 means InterFrameGap = the shortest one */
+#define RTASE_INTERFRAMEGAP 0x03
+
+#define RTASE_REGS_SIZE     256
+#define RTASE_PCI_REGS_SIZE 0x100
+
+#define RTASE_MULTICAST_FILTER_MASK GENMASK(30, 26)
+
+#define RTASE_VLAN_FILTER_ENTRY_NUM 32
+#define RTASE_NUM_TX_QUEUE 8
+#define RTASE_NUM_RX_QUEUE 4
+
+#define RTASE_TXQ_CTRL      1
+#define RTASE_FUNC_TXQ_NUM  1
+#define RTASE_FUNC_RXQ_NUM  1
+#define RTASE_INTERRUPT_NUM 1
+
+#define RTASE_MITI_TIME_COUNT_MASK    GENMASK(3, 0)
+#define RTASE_MITI_TIME_UNIT_MASK     GENMASK(7, 4)
+#define RTASE_MITI_DEFAULT_TIME       128
+#define RTASE_MITI_MAX_TIME           491520
+#define RTASE_MITI_PKT_NUM_COUNT_MASK GENMASK(11, 8)
+#define RTASE_MITI_PKT_NUM_UNIT_MASK  GENMASK(13, 12)
+#define RTASE_MITI_DEFAULT_PKT_NUM    64
+#define RTASE_MITI_MAX_PKT_NUM_IDX    3
+#define RTASE_MITI_MAX_PKT_NUM_UNIT   16
+#define RTASE_MITI_MAX_PKT_NUM        240
+#define RTASE_MITI_COUNT_BIT_NUM      4
+
+#define RTASE_NUM_MSIX 4
+
+#define RTASE_DWORD_MOD 16
+
+/*****************************************************************************/
+enum rtase_registers {
+	RTASE_MAC0   = 0x0000,
+	RTASE_MAC4   = 0x0004,
+	RTASE_MAR0   = 0x0008,
+	RTASE_MAR1   = 0x000C,
+	RTASE_DTCCR0 = 0x0010,
+	RTASE_DTCCR4 = 0x0014,
+#define RTASE_COUNTER_RESET BIT(0)
+#define RTASE_COUNTER_DUMP  BIT(3)
+
+	RTASE_FCR = 0x0018,
+#define RTASE_FCR_RXQ_MASK GENMASK(5, 4)
+
+	RTASE_LBK_CTRL = 0x001A,
+#define RTASE_LBK_ATLD BIT(1)
+#define RTASE_LBK_CLR  BIT(0)
+
+	RTASE_TX_DESC_ADDR0   = 0x0020,
+	RTASE_TX_DESC_ADDR4   = 0x0024,
+	RTASE_TX_DESC_COMMAND = 0x0028,
+#define RTASE_TX_DESC_CMD_CS BIT(15)
+#define RTASE_TX_DESC_CMD_WE BIT(14)
+
+	RTASE_BOOT_CTL  = 0x6004,
+	RTASE_CLKSW_SET = 0x6018,
+
+	RTASE_CHIP_CMD = 0x0037,
+#define RTASE_STOP_REQ      BIT(7)
+#define RTASE_STOP_REQ_DONE BIT(6)
+#define RTASE_RE            BIT(3)
+#define RTASE_TE            BIT(2)
+
+	RTASE_IMR0 = 0x0038,
+	RTASE_ISR0 = 0x003C,
+#define RTASE_TOK7 BIT(30)
+#define RTASE_TOK6 BIT(28)
+#define RTASE_TOK5 BIT(26)
+#define RTASE_TOK4 BIT(24)
+#define RTASE_FOVW BIT(6)
+#define RTASE_RDU  BIT(4)
+#define RTASE_TOK  BIT(2)
+#define RTASE_ROK  BIT(0)
+
+	RTASE_IMR1 = 0x0800,
+	RTASE_ISR1 = 0x0802,
+#define RTASE_Q_TOK BIT(4)
+#define RTASE_Q_RDU BIT(1)
+#define RTASE_Q_ROK BIT(0)
+
+	RTASE_EPHY_ISR = 0x6014,
+	RTASE_EPHY_IMR = 0x6016,
+
+	RTASE_TX_CONFIG_0 = 0x0040,
+#define RTASE_TX_INTER_FRAME_GAP_MASK GENMASK(25, 24)
+	/* DMA burst value (0-7) is shift this many bits */
+#define RTASE_TX_DMA_MASK             GENMASK(10, 8)
+
+	RTASE_RX_CONFIG_0 = 0x0044,
+#define RTASE_RX_SINGLE_FETCH  BIT(14)
+#define RTASE_RX_SINGLE_TAG    BIT(13)
+#define RTASE_RX_MX_DMA_MASK   GENMASK(10, 8)
+#define RTASE_ACPT_FLOW        BIT(7)
+#define RTASE_ACCEPT_ERR       BIT(5)
+#define RTASE_ACCEPT_RUNT      BIT(4)
+#define RTASE_ACCEPT_BROADCAST BIT(3)
+#define RTASE_ACCEPT_MULTICAST BIT(2)
+#define RTASE_ACCEPT_MYPHYS    BIT(1)
+#define RTASE_ACCEPT_ALLPHYS   BIT(0)
+#define RTASE_ACCEPT_MASK      (RTASE_ACPT_FLOW | RTASE_ACCEPT_ERR | \
+				RTASE_ACCEPT_RUNT | RTASE_ACCEPT_BROADCAST | \
+				RTASE_ACCEPT_MULTICAST | RTASE_ACCEPT_MYPHYS | \
+				RTASE_ACCEPT_ALLPHYS)
+
+	RTASE_RX_CONFIG_1 = 0x0046,
+#define RTASE_RX_MAX_FETCH_DESC_MASK GENMASK(15, 11)
+#define RTASE_RX_NEW_DESC_FORMAT_EN  BIT(8)
+#define RTASE_OUTER_VLAN_DETAG_EN    BIT(7)
+#define RTASE_INNER_VLAN_DETAG_EN    BIT(6)
+#define RTASE_PCIE_NEW_FLOW          BIT(2)
+#define RTASE_PCIE_RELOAD_EN         BIT(0)
+
+	RTASE_EEM = 0x0050,
+#define RTASE_EEM_UNLOCK 0xC0
+
+	RTASE_TDFNR  = 0x0057,
+	RTASE_TPPOLL = 0x0090,
+	RTASE_PDR    = 0x00B0,
+	RTASE_FIFOR  = 0x00D3,
+#define RTASE_TX_FIFO_EMPTY BIT(5)
+#define RTASE_RX_FIFO_EMPTY BIT(4)
+
+	RTASE_RMS       = 0x00DA,
+	RTASE_CPLUS_CMD = 0x00E0,
+#define RTASE_FORCE_RXFLOW_EN BIT(11)
+#define RTASE_FORCE_TXFLOW_EN BIT(10)
+#define RTASE_RX_CHKSUM       BIT(5)
+
+	RTASE_Q0_RX_DESC_ADDR0 = 0x00E4,
+	RTASE_Q0_RX_DESC_ADDR4 = 0x00E8,
+	RTASE_Q1_RX_DESC_ADDR0 = 0x4000,
+	RTASE_Q1_RX_DESC_ADDR4 = 0x4004,
+	RTASE_MTPS             = 0x00EC,
+#define RTASE_TAG_NUM_SEL_MASK GENMASK(10, 8)
+
+	RTASE_MISC = 0x00F2,
+#define RTASE_RX_DV_GATE_EN BIT(3)
+
+	RTASE_TFUN_CTRL = 0x0400,
+#define RTASE_TX_NEW_DESC_FORMAT_EN BIT(0)
+
+	RTASE_TX_CONFIG_1 = 0x203E,
+#define RTASE_TC_MODE_MASK GENMASK(11, 10)
+
+	RTASE_TOKSEL      = 0x2046,
+	RTASE_RFIFONFULL  = 0x4406,
+	RTASE_INT_MITI_TX = 0x0A00,
+	RTASE_INT_MITI_RX = 0x0A80,
+
+	RTASE_VLAN_ENTRY_0     = 0xAC80,
+};
+
+enum rtase_desc_status_bit {
+	RTASE_DESC_OWN = BIT(31), /* Descriptor is owned by NIC */
+	RTASE_RING_END = BIT(30), /* End of descriptor ring */
+};
+
+enum rtase_sw_flag_content {
+	RTASE_SWF_MSI_ENABLED  = BIT(1),
+	RTASE_SWF_MSIX_ENABLED = BIT(2),
+};
+
+#define RSVD_MASK 0x3FFFC000
+
+struct rtase_tx_desc {
+	__le32 opts1;
+	__le32 opts2;
+	__le64 addr;
+	__le32 opts3;
+	__le32 reserved1;
+	__le32 reserved2;
+	__le32 reserved3;
+} __packed;
+
+/*------ offset 0 of tx descriptor ------*/
+#define RTASE_TX_FIRST_FRAG BIT(29) /* Tx First segment of a packet */
+#define RTASE_TX_LAST_FRAG  BIT(28) /* Tx Final segment of a packet */
+#define RTASE_GIANT_SEND_V4 BIT(26) /* TCP Giant Send Offload V4 (GSOv4) */
+#define RTASE_GIANT_SEND_V6 BIT(25) /* TCP Giant Send Offload V6 (GSOv6) */
+#define RTASE_TX_VLAN_TAG   BIT(17) /* Add VLAN tag */
+
+/*------ offset 4 of tx descriptor ------*/
+#define RTASE_TX_UDPCS_C BIT(31) /* Calculate UDP/IP checksum */
+#define RTASE_TX_TCPCS_C BIT(30) /* Calculate TCP/IP checksum */
+#define RTASE_TX_IPCS_C  BIT(29) /* Calculate IP checksum */
+#define RTASE_TX_IPV6F_C BIT(28) /* Indicate it is an IPv6 packet */
+
+union rtase_rx_desc {
+	struct {
+		__le64 header_buf_addr;
+		__le32 reserved1;
+		__le32 opts_header_len;
+		__le64 addr;
+		__le32 reserved2;
+		__le32 opts1;
+	} __packed desc_cmd;
+
+	struct {
+		__le32 reserved1;
+		__le32 reserved2;
+		__le32 rss;
+		__le32 opts4;
+		__le32 reserved3;
+		__le32 opts3;
+		__le32 opts2;
+		__le32 opts1;
+	} __packed desc_status;
+} __packed;
+
+/*------ offset 28 of rx descriptor ------*/
+#define RTASE_RX_FIRST_FRAG BIT(25) /* Rx First segment of a packet */
+#define RTASE_RX_LAST_FRAG  BIT(24) /* Rx Final segment of a packet */
+#define RTASE_RX_RES        BIT(20)
+#define RTASE_RX_RUNT       BIT(19)
+#define RTASE_RX_RWT        BIT(18)
+#define RTASE_RX_CRC        BIT(16)
+#define RTASE_RX_V6F        BIT(31)
+#define RTASE_RX_V4F        BIT(30)
+#define RTASE_RX_UDPT       BIT(29)
+#define RTASE_RX_TCPT       BIT(28)
+#define RTASE_RX_IPF        BIT(26) /* IP checksum failed */
+#define RTASE_RX_UDPF       BIT(25) /* UDP/IP checksum failed */
+#define RTASE_RX_TCPF       BIT(24) /* TCP/IP checksum failed */
+#define RTASE_RX_VLAN_TAG   BIT(16) /* VLAN tag available */
+
+#define RTASE_NUM_DESC          1024
+#define RTASE_TX_BUDGET_DEFAULT 256
+#define RTASE_TX_RING_DESC_SIZE (RTASE_NUM_DESC * sizeof(struct rtase_tx_desc))
+#define RTASE_RX_RING_DESC_SIZE (RTASE_NUM_DESC * sizeof(union rtase_rx_desc))
+#define RTASE_TX_STOP_THRS      (MAX_SKB_FRAGS + 1)
+#define RTASE_TX_START_THRS     (2 * RTASE_TX_STOP_THRS)
+#define RTASE_VLAN_TAG_MASK     GENMASK(15, 0)
+#define RTASE_RX_PKT_SIZE_MASK  GENMASK(13, 0)
+
+#define RTASE_IVEC_NAME_SIZE (IFNAMSIZ + 10)
+
+struct rtase_int_vector {
+	struct rtase_private *tp;
+	unsigned int irq;
+	char name[RTASE_IVEC_NAME_SIZE];
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
+	struct sk_buff *skbuff[RTASE_NUM_DESC];
+	union {
+		u32 len[RTASE_NUM_DESC];
+		dma_addr_t data_phy_addr[RTASE_NUM_DESC];
+	} mis;
+
+	struct list_head ring_entry;
+	int (*ring_handler)(struct rtase_ring *ring, int budget);
+};
+
+struct rtase_private {
+	void __iomem *mmio_addr;
+	u32 sw_flag;
+
+	struct pci_dev *pdev;
+	struct net_device *dev;
+	u32 rx_buf_sz;
+
+	struct page_pool *page_pool;
+	struct rtase_ring tx_ring[RTASE_NUM_TX_QUEUE];
+	struct rtase_ring rx_ring[RTASE_NUM_RX_QUEUE];
+	struct rtase_counters *tally_vaddr;
+	dma_addr_t tally_paddr;
+
+	u32 vlan_filter_ctrl;
+	u16 vlan_filter_vid[RTASE_VLAN_FILTER_ENTRY_NUM];
+
+	struct msix_entry msix_entry[RTASE_NUM_MSIX];
+	struct rtase_int_vector int_vector[RTASE_NUM_MSIX];
+
+	u16 tx_queue_ctrl;
+	u16 func_tx_queue_num;
+	u16 func_rx_queue_num;
+	u16 int_nums;
+	u16 tx_int_mit;
+	u16 rx_int_mit;
+};
+
+#define RTASE_LSO_64K 64000
+
+#define RTASE_NIC_MAX_PHYS_BUF_COUNT_LSO2 (16 * 4)
+
+#define RTASE_TCPHO_MASK GENMASK(24, 18)
+
+#define RTASE_MSS_MASK GENMASK(28, 18)
+
+#endif /* _RTASE_H_ */
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
new file mode 100644
index 000000000000..5ddb5f7abfe9
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ *  rtase is the Linux device driver released for Realtek Automotive Switch
+ *  controllers with PCI-Express interface.
+ *
+ *  Copyright(c) 2023 Realtek Semiconductor Corp.
+ *
+ *  Below is a simplified block diagram of the chip and its relevant interfaces.
+ *
+ *               *************************
+ *               *                       *
+ *               *  CPU network device   *
+ *               *                       *
+ *               *   +-------------+     *
+ *               *   |  PCIE Host  |     *
+ *               ***********++************
+ *                          ||
+ *                         PCIE
+ *                          ||
+ *      ********************++**********************
+ *      *            | PCIE Endpoint |             *
+ *      *            +---------------+             *
+ *      *                | GMAC |                  *
+ *      *                +--++--+  Realtek         *
+ *      *                   ||     RTL90xx Series  *
+ *      *                   ||                     *
+ *      *     +-------------++----------------+    *
+ *      *     |           | MAC |             |    *
+ *      *     |           +-----+             |    *
+ *      *     |                               |    *
+ *      *     |     Ethernet Switch Core      |    *
+ *      *     |                               |    *
+ *      *     |   +-----+           +-----+   |    *
+ *      *     |   | MAC |...........| MAC |   |    *
+ *      *     +---+-----+-----------+-----+---+    *
+ *      *         | PHY |...........| PHY |        *
+ *      *         +--++-+           +--++-+        *
+ *      *************||****************||***********
+ *
+ *  The block of the Realtek RTL90xx series is our entire chip architecture,
+ *  the GMAC is connected to the switch core, and there is no PHY in between.
+ *  In addition, this driver is mainly used to control GMAC, but does not
+ *  control the switch core, so it is not the same as DSA.
+ */
+
+#include <linux/crc32.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/in.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/prefetch.h>
+#include <linux/rtnetlink.h>
+#include <linux/tcp.h>
+#include <asm/irq.h>
+#include <net/ip6_checksum.h>
+#include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
+#include <net/pkt_cls.h>
+
+#include "rtase.h"
+
+#define RTK_OPTS1_DEBUG_VALUE 0x0BADBEEF
+#define RTK_MAGIC_NUMBER      0x0BADBADBADBADBAD
+
+static const struct pci_device_id rtase_pci_tbl[] = {
+	{PCI_VDEVICE(REALTEK, 0x906A)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, rtase_pci_tbl);
+
+MODULE_AUTHOR("Realtek ARD Software Team");
+MODULE_DESCRIPTION("Network Driver for the PCIe interface of Realtek Automotive Ethernet Switch");
+MODULE_LICENSE("Dual BSD/GPL");
+
+struct rtase_counters {
+	__le64 tx_packets;
+	__le64 rx_packets;
+	__le64 tx_errors;
+	__le32 rx_errors;
+	__le16 rx_missed;
+	__le16 align_errors;
+	__le32 tx_one_collision;
+	__le32 tx_multi_collision;
+	__le64 rx_unicast;
+	__le64 rx_broadcast;
+	__le32 rx_multicast;
+	__le16 tx_aborted;
+	__le16 tx_underun;
+} __packed;
+
+static void rtase_w8(const struct rtase_private *tp, u16 reg, u8 val8)
+{
+	writeb(val8, tp->mmio_addr + reg);
+}
+
+static void rtase_w16(const struct rtase_private *tp, u16 reg, u16 val16)
+{
+	writew(val16, tp->mmio_addr + reg);
+}
+
+static void rtase_w32(const struct rtase_private *tp, u16 reg, u32 val32)
+{
+	writel(val32, tp->mmio_addr + reg);
+}
+
+static u8 rtase_r8(const struct rtase_private *tp, u16 reg)
+{
+	return readb(tp->mmio_addr + reg);
+}
+
+static u16 rtase_r16(const struct rtase_private *tp, u16 reg)
+{
+	return readw(tp->mmio_addr + reg);
+}
+
+static u32 rtase_r32(const struct rtase_private *tp, u16 reg)
+{
+	return readl(tp->mmio_addr + reg);
+}
+
+static void rtase_tally_counter_clear(const struct rtase_private *tp)
+{
+	u32 cmd = lower_32_bits(tp->tally_paddr);
+
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(tp->tally_paddr));
+	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
+}
+
+static void rtase_enable_eem_write(const struct rtase_private *tp)
+{
+	u8 val;
+
+	val = rtase_r8(tp, RTASE_EEM);
+	rtase_w8(tp, RTASE_EEM, val | RTASE_EEM_UNLOCK);
+}
+
+static void rtase_disable_eem_write(const struct rtase_private *tp)
+{
+	u8 val;
+
+	val = rtase_r8(tp, RTASE_EEM);
+	rtase_w8(tp, RTASE_EEM, val & ~RTASE_EEM_UNLOCK);
+}
+
+static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
+{
+	u32 rar_low, rar_high;
+
+	rar_low = (u32)addr[0] | ((u32)addr[1] << 8) |
+		  ((u32)addr[2] << 16) | ((u32)addr[3] << 24);
+
+	rar_high = (u32)addr[4] | ((u32)addr[5] << 8);
+
+	rtase_enable_eem_write(tp);
+	rtase_w32(tp, RTASE_MAC0, rar_low);
+	rtase_w32(tp, RTASE_MAC4, rar_high);
+	rtase_disable_eem_write(tp);
+	rtase_w16(tp, RTASE_LBK_CTRL, RTASE_LBK_ATLD | RTASE_LBK_CLR);
+}
+
+static void rtase_get_mac_address(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u8 mac_addr[ETH_ALEN] __aligned(2) = {};
+	u32 i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_addr[i] = rtase_r8(tp, RTASE_MAC0 + i);
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		eth_hw_addr_random(dev);
+		netdev_warn(dev, "Random ether addr %pM\n", dev->dev_addr);
+	} else {
+		eth_hw_addr_set(dev, mac_addr);
+		ether_addr_copy(dev->perm_addr, dev->dev_addr);
+	}
+
+	rtase_rar_set(tp, dev->dev_addr);
+}
+
+static void rtase_reset_interrupt(struct pci_dev *pdev,
+				  const struct rtase_private *tp)
+{
+	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED)
+		pci_disable_msix(pdev);
+	else
+		pci_disable_msi(pdev);
+}
+
+static int rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
+{
+	int ret;
+	u16 i;
+
+	memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct msix_entry));
+
+	for (i = 0; i < RTASE_NUM_MSIX; i++)
+		tp->msix_entry[i].entry = i;
+
+	ret = pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums);
+
+	if (!ret) {
+		for (i = 0; i < tp->int_nums; i++)
+			tp->int_vector[i].irq = pci_irq_vector(pdev, i);
+	}
+
+	return ret;
+}
+
+static int rtase_alloc_interrupt(struct pci_dev *pdev,
+				 struct rtase_private *tp)
+{
+	int ret;
+
+	ret = rtase_alloc_msix(pdev, tp);
+	if (ret) {
+		ret = pci_enable_msi(pdev);
+		if (ret)
+			dev_err(&pdev->dev,
+				"unable to alloc interrupt.(MSI)\n");
+		else
+			tp->sw_flag |= RTASE_SWF_MSI_ENABLED;
+	} else {
+		tp->sw_flag |= RTASE_SWF_MSIX_ENABLED;
+	}
+
+	return ret;
+}
+
+static void rtase_init_hardware(const struct rtase_private *tp)
+{
+	u16 i;
+
+	for (i = 0; i < RTASE_VLAN_FILTER_ENTRY_NUM; i++)
+		rtase_w32(tp, RTASE_VLAN_ENTRY_0 + i * 4, 0);
+}
+
+static void rtase_init_int_vector(struct rtase_private *tp)
+{
+	u16 i;
+
+	/* interrupt vector 0 */
+	tp->int_vector[0].tp = tp;
+	tp->int_vector[0].index = 0;
+	tp->int_vector[0].imr_addr = RTASE_IMR0;
+	tp->int_vector[0].isr_addr = RTASE_ISR0;
+	tp->int_vector[0].imr = RTASE_ROK | RTASE_RDU | RTASE_TOK | RTASE_TOK4 |
+				RTASE_TOK5 | RTASE_TOK6 | RTASE_TOK7;
+	tp->int_vector[0].poll = rtase_poll;
+
+	memset(tp->int_vector[0].name, 0x0, sizeof(tp->int_vector[0].name));
+	INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
+
+	netif_napi_add(tp->dev, &tp->int_vector[0].napi,
+		       tp->int_vector[0].poll);
+
+	/* interrupt vector 1 ~ 3 */
+	for (i = 1; i < tp->int_nums; i++) {
+		tp->int_vector[i].tp = tp;
+		tp->int_vector[i].index = i;
+		tp->int_vector[i].imr_addr = RTASE_IMR1 + (i - 1) * 4;
+		tp->int_vector[i].isr_addr = RTASE_ISR1 + (i - 1) * 4;
+		tp->int_vector[i].imr = RTASE_Q_ROK | RTASE_Q_RDU | RTASE_Q_TOK;
+		tp->int_vector[i].poll = rtase_poll;
+
+		memset(tp->int_vector[i].name, 0x0, sizeof(tp->int_vector[0].name));
+		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
+
+		netif_napi_add(tp->dev, &tp->int_vector[i].napi,
+			       tp->int_vector[i].poll);
+	}
+}
+
+static u16 rtase_calc_time_mitigation(u32 time_us)
+{
+	u8 msb, time_count, time_unit;
+	u16 int_miti;
+
+	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
+
+	msb = fls(time_us);
+	if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
+		time_unit = msb - RTASE_MITI_COUNT_BIT_NUM;
+		time_count = time_us >> (msb - RTASE_MITI_COUNT_BIT_NUM);
+	} else {
+		time_unit = 0;
+		time_count = time_us;
+	}
+
+	int_miti = u16_encode_bits(time_count, RTASE_MITI_TIME_COUNT_MASK) |
+		   u16_encode_bits(time_unit, RTASE_MITI_TIME_UNIT_MASK);
+
+	return int_miti;
+}
+
+static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
+{
+	u8 msb, pkt_num_count, pkt_num_unit;
+	u16 int_miti;
+
+	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
+
+	if (pkt_num > 60) {
+		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
+		pkt_num_count = pkt_num / RTASE_MITI_MAX_PKT_NUM_UNIT;
+	} else {
+		msb = fls(pkt_num);
+		if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
+			pkt_num_unit = msb - RTASE_MITI_COUNT_BIT_NUM;
+			pkt_num_count = pkt_num >> (msb - RTASE_MITI_COUNT_BIT_NUM);
+		} else {
+			pkt_num_unit = 0;
+			pkt_num_count = pkt_num;
+		}
+	}
+
+	int_miti = u16_encode_bits(pkt_num_count, RTASE_MITI_PKT_NUM_COUNT_MASK) |
+		   u16_encode_bits(pkt_num_unit, RTASE_MITI_PKT_NUM_UNIT_MASK);
+
+	return int_miti;
+}
+
+static void rtase_init_software_variable(struct pci_dev *pdev,
+					 struct rtase_private *tp)
+{
+	u16 int_miti;
+
+	tp->tx_queue_ctrl = RTASE_TXQ_CTRL;
+	tp->func_tx_queue_num = RTASE_FUNC_TXQ_NUM;
+	tp->func_rx_queue_num = RTASE_FUNC_RXQ_NUM;
+	tp->int_nums = RTASE_INTERRUPT_NUM;
+
+	int_miti = rtase_calc_time_mitigation(RTASE_MITI_DEFAULT_TIME) |
+		   rtase_calc_packet_num_mitigation(RTASE_MITI_DEFAULT_PKT_NUM);
+	tp->tx_int_mit = int_miti;
+	tp->rx_int_mit = int_miti;
+
+	tp->sw_flag = 0;
+
+	rtase_init_int_vector(tp);
+
+	/* MTU range: 60 - hw-specific max */
+	tp->dev->min_mtu = ETH_ZLEN;
+	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
+}
+
+static bool rtase_check_mac_version_valid(struct rtase_private *tp)
+{
+	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
+	bool known_ver = false;
+
+	switch (hw_ver) {
+	case 0x00800000:
+	case 0x04000000:
+	case 0x04800000:
+		known_ver = true;
+		break;
+	}
+
+	return known_ver;
+}
+
+static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
+			    void __iomem **ioaddr_out)
+{
+	struct net_device *dev;
+	void __iomem *ioaddr;
+	int ret = -ENOMEM;
+
+	/* dev zeroed in alloc_etherdev */
+	dev = alloc_etherdev_mq(sizeof(struct rtase_private),
+				RTASE_FUNC_TXQ_NUM);
+	if (!dev)
+		goto err_out;
+
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0)
+		goto err_out_free_dev;
+
+	/* make sure PCI base addr 1 is MMIO */
+	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM)) {
+		ret = -ENODEV;
+		goto err_out_disable;
+	}
+
+	/* check for weird/broken PCI region reporting */
+	if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
+		ret = -ENODEV;
+		goto err_out_disable;
+	}
+
+	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (ret < 0)
+		goto err_out_disable;
+
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		dev_err(&pdev->dev, "no usable dma addressing method\n");
+		goto err_out_free_res;
+	}
+
+	pci_set_master(pdev);
+
+	/* ioremap MMIO region */
+	ioaddr = ioremap(pci_resource_start(pdev, 2),
+			 pci_resource_len(pdev, 2));
+	if (!ioaddr) {
+		ret = -EIO;
+		goto err_out_free_res;
+	}
+
+	*ioaddr_out = ioaddr;
+	*dev_out = dev;
+
+	return ret;
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
+	return ret;
+}
+
+static void rtase_release_board(struct pci_dev *pdev, struct net_device *dev,
+				void __iomem *ioaddr)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_rar_set(tp, tp->dev->perm_addr);
+	iounmap(ioaddr);
+
+	if ((tp->sw_flag & RTASE_SWF_MSIX_ENABLED))
+		pci_disable_msix(pdev);
+	else
+		pci_disable_msi(pdev);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	free_netdev(dev);
+}
+
+static int rtase_init_one(struct pci_dev *pdev,
+			  const struct pci_device_id *ent)
+{
+	struct net_device *dev = NULL;
+	struct rtase_int_vector *ivec;
+	void __iomem *ioaddr = NULL;
+	struct rtase_private *tp;
+	int ret, i;
+
+	if (!pdev->is_physfn && pdev->is_virtfn) {
+		dev_err(&pdev->dev, "This module does not support a virtual function.");
+		return -EINVAL;
+	}
+
+	dev_dbg(&pdev->dev, "Automotive Switch Ethernet driver loaded\n");
+
+	ret = rtase_init_board(pdev, &dev, &ioaddr);
+	if (ret != 0)
+		return ret;
+
+	tp = netdev_priv(dev);
+	tp->mmio_addr = ioaddr;
+	tp->dev = dev;
+	tp->pdev = pdev;
+
+	/* identify chip attached to board */
+	if (!rtase_check_mac_version_valid(tp)) {
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	}
+
+	rtase_init_software_variable(pdev, tp);
+	rtase_init_hardware(tp);
+
+	ret = rtase_alloc_interrupt(pdev, tp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to alloc MSIX/MSI\n");
+		goto err_out_1;
+	}
+
+	rtase_init_netdev_ops(dev);
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
+	dev->features |= NETIF_F_IP_CSUM;
+	dev->features |= NETIF_F_HIGHDMA;
+	dev->features |= NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO;
+	dev->features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+	dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
+			   NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX |
+			   NETIF_F_HW_VLAN_CTAG_RX;
+	dev->hw_features |= NETIF_F_RXALL;
+	dev->hw_features |= NETIF_F_RXFCS;
+	dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
+			     NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	netif_set_tso_max_size(dev, RTASE_LSO_64K);
+	netif_set_tso_max_segs(dev, RTASE_NIC_MAX_PHYS_BUF_COUNT_LSO2);
+
+	rtase_get_mac_address(dev);
+
+	tp->tally_vaddr = dma_alloc_coherent(&pdev->dev,
+					     sizeof(*tp->tally_vaddr),
+					     &tp->tally_paddr,
+					     GFP_KERNEL);
+	if (!tp->tally_vaddr) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	rtase_tally_counter_clear(tp);
+
+	pci_set_drvdata(pdev, dev);
+
+	netif_carrier_off(dev);
+
+	ret = register_netdev(dev);
+	if (ret != 0)
+		goto err_out;
+
+	netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
+
+	return 0;
+
+err_out:
+	if (tp->tally_vaddr) {
+		dma_free_coherent(&pdev->dev,
+				  sizeof(*tp->tally_vaddr),
+				  tp->tally_vaddr,
+				  tp->tally_paddr);
+
+		tp->tally_vaddr = NULL;
+	}
+
+err_out_1:
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		netif_napi_del(&ivec->napi);
+	}
+
+	rtase_release_board(pdev, dev, ioaddr);
+
+	return ret;
+}
+
+static void rtase_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	u32 i;
+
+	unregister_netdev(dev);
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		netif_napi_del(&ivec->napi);
+	}
+
+	rtase_reset_interrupt(pdev, tp);
+	if (tp->tally_vaddr) {
+		dma_free_coherent(&pdev->dev,
+				  sizeof(*tp->tally_vaddr),
+				  tp->tally_vaddr,
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
+	if (netif_running(dev))
+		rtase_close(dev);
+
+	rtase_reset_interrupt(pdev, tp);
+}
+
+static struct pci_driver rtase_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtase_pci_tbl,
+	.probe = rtase_init_one,
+	.remove = rtase_remove_one,
+	.shutdown = rtase_shutdown,
+};
+
+module_pci_driver(rtase_pci_driver);
-- 
2.34.1


