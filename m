Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730977988B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbjIHOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjIHOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:30:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2281BF1;
        Fri,  8 Sep 2023 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694183405; x=1725719405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTnw4RkAKahri7QiR37TfnSSXBfjikQbnSydeQyhXww=;
  b=KyiqHqtfPb4VKHTXvfWghkIM/pm9RHyWhuPdrr1CdY2gnvocZHrKclMi
   VyLo8D/2AH6ObBVDnquz2Xtj+h0eLnDRjBly5dMfN0LruycEWVwxwqWs/
   fsXDkmjKcdW6Fc29XWEisvNBBQzdb4X4Dvcu8m1P2RWfNbPOHdIpr6w8N
   31Bycolv3v5WdQ1Wpiea9GbXixUSpFwwCDPhi1NdaNwnUbHLaiEUJNa/Y
   qvjtSrZtOlCm1udhIwQRDh2sWuSNSXsk4OlHdwWM6baQG8YRXBm/jckfD
   Y79iUcOiaKi2TyJ07ZWFa+//ziwR1xBWbqbWyZWzoNmtxKXSH223laJ79
   w==;
X-CSE-ConnectionGUID: jZHmu+07Re+nCxNQqEz9lw==
X-CSE-MsgGUID: vDQBKQIFR92dm4f8igXjTQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="170641697"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 07:30:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 07:30:01 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 8 Sep 2023 07:29:53 -0700
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
Subject: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance control transaction interface
Date:   Fri, 8 Sep 2023 19:59:14 +0530
Message-ID: <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
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

Implement register read/write interface according to the control
communication specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
Interface document. Control transactions consist of one or more control
commands. Control commands are used by the SPI host to read and write
registers within the MAC-PHY. Each control commands are composed of a
32-bit control command header followed by register data.

Control write commands can write either a single register or multiple
consecutive registers. When multiple consecutive registers are written,
the address is automatically post-incremented by the MAC-PHY. The write
command and data is also echoed from the MAC-PHY back to the SPI host to
enable the SPI host to identify which register write failed in the case
of any bus errors.

Control read commands can read either a single register or multiple
consecutive registers. When multiple consecutive registers are read, the
address is automatically post-incremented by the MAC-PHY.

The register data being read or written can be protected against simple
bit errors. When enabled by setting the Protection Enable (PROTE) bit in
the CONFIG0 register, protection is accomplished by duplication of each
32-bit word containing register data with its ones’ complement. Errors
are detected at the receiver by performing a simple exclusive-OR (XOR) of
each received 32-bit word containing register data with its received
complement and detecting if there are any zeros in the result.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 Documentation/networking/oa-tc6-framework.rst | 231 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/oa_tc6.c                 | 222 +++++++++++++++++
 include/linux/oa_tc6.h                        |  31 +++
 4 files changed, 492 insertions(+)
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 include/linux/oa_tc6.h

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
new file mode 100644
index 000000000000..5a8af2398f3c
--- /dev/null
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -0,0 +1,231 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=========================================================================
+OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface (TC6) Framework Support
+=========================================================================
+
+:Copyright: |copy| 2023 MICROCHIP
+
+Introduction
+------------
+
+The IEEE 802.3cg project defines two 10 Mbit/s PHYs operating over a
+single pair of conductors. The 10BASE-T1L (Clause 146) is a long reach
+PHY supporting full duplex point-to-point operation over 1 km of single
+balanced pair of conductors. The 10BASE-T1S (Clause 147) is a short reach
+PHY supporting full / half duplex point-to-point operation over 15 m of
+single balanced pair of conductors, or half duplex multidrop bus
+operation over 25 m of single balanced pair of conductors.
+
+Furthermore, the IEEE 802.3cg project defines the new Physical Layer
+Collision Avoidance (PLCA) Reconciliation Sublayer (Clause 148) meant to
+provide improved determinism to the CSMA/CD media access method. PLCA
+works in conjunction with the 10BASE-T1S PHY operating in multidrop mode.
+
+The aforementioned PHYs are intended to cover the low-speed / low-cost
+applications in industrial and automotive environment. The large number
+of pins (16) required by the MII interface, which is specified by the
+IEEE 802.3 in Clause 22, is one of the major cost factors that need to be
+addressed to fulfil this objective.
+
+The MAC-PHY solution integrates an IEEE Clause 4 MAC and a 10BASE-T1x PHY
+exposing a low pin count Serial Peripheral Interface (SPI) to the host
+microcontroller. This also enables the addition of Ethernet functionality
+to existing low-end microcontrollers which do not integrate a MAC
+controller.
+
+Overview
+--------
+
+The MAC-PHY is specified to carry both data (Ethernet frames) and control
+(register access) transactions over a single full-duplex serial
+peripheral interface.
+
+Protocol Overview
+-----------------
+
+Two types of transactions are defined in the protocol: data transactions
+for Ethernet frame transfers and control transactions for register
+read/write transfers. A chunk is the basic element of data transactions
+and is composed of 4 bytes of overhead plus the configured payload size
+for each chunk. Ethernet frames are transferred over one or more data
+chunks. Control transactions consist of one or more register read/write
+control commands.
+
+SPI transactions are initiated by the SPI host with the assertion of CSn
+low to the MAC-PHY and ends with the deassertion of CSn high. In between
+each SPI transaction, the SPI host may need time for additional
+processing and to setup the next SPI data or control transaction.
+
+SPI data transactions consist of an equal number of transmit (TX) and
+receive (RX) chunks. Chunks in both transmit and receive directions may
+or may not contain valid frame data independent from each other, allowing
+for the simultaneous transmission and reception of different length
+frames.
+
+Each transmit data chunk begins with a 32-bit data header followed by a
+data chunk payload on MOSI. The data header indicates whether transmit
+frame data is present and provides the information to determine which
+bytes of the payload contain valid frame data.
+
+In parallel, receive data chunks are received on MISO. Each receive data
+chunk consists of a data chunk payload ending with a 32-bit data footer.
+The data footer indicates if there is receive frame data present within
+the payload or not and provides the information to determine which bytes
+of the payload contain valid frame data.
+
+Reference
+---------
+
+10BASE-T1x MAC-PHY Serial Interface Specification,
+
+Link: https://www.opensig.org/about/specifications/
+
+Hardware Architecture
+---------------------
+
+.. code-block:: none
+                    +-------------------------------------+
+                    |                MAC-PHY              |
+  +----------+      | +-----------+  +-------+  +-------+ |
+  | SPI Host |<---->| | SPI Slave |  |  MAC  |  |  PHY  | |
+  +----------+      | +-----------+  +-------+  +-------+ |
+                    +-------------------------------------+
+
+Software Architecture
+---------------------
+
+.. code-block:: none
+
+  +----------------------------------------------------------+
+  |                 Networking Subsystem                     |
+  +----------------------------------------------------------+
+             |                               |
+             |                               |
+  +----------------------+     +-----------------------------+
+  |     MAC Driver       |<--->| OPEN Alliance TC6 Framework |
+  +----------------------+     +-----------------------------+
+             |                               |
+             |                               |
+  +----------------------+     +-----------------------------+
+  |      PHYLIB          |     |       SPI Subsystem         |
+  +----------------------+     +-----------------------------+
+                                             |
+                                             |
+  +----------------------------------------------------------+
+  |                10BASE-T1x MAC-PHY Device                 |
+  +----------------------------------------------------------+
+
+Implementation
+--------------
+
+MAC Driver
+~~~~~~~~~~
+- Initializes and configures the OA TC6 framework for the MAC-PHY.
+
+- Initializes PHYLIB interface.
+
+- Registers and configures the network device.
+
+- Sends the tx ethernet frame from n/w subsystem to OA TC6 framework.
+
+OPEN Alliance TC6 Framework
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+- Registers macphy interrupt which is used to indicate receive data
+  available, any communication errors and tx credit count availability in
+  case it was 0 already.
+
+- Prepares SPI chunks from the tx ethernet frame enqueued by the MAC
+  driver and sends to MAC-PHY.
+
+- Receives SPI chunks from MAC-PHY and prepares ethernet frame and sends
+  to n/w subsystem.
+
+- Prepares and performs control read/write commands.
+
+Data Transaction
+~~~~~~~~~~~~~~~~
+
+Tx ethernet frame from the n/w layer is divided into multiple chunks in
+the oa_tc6_prepare_tx_chunks() function. Each tx chunk will have 4 bytes
+header and 64/32 bytes chunk payload.
+
+.. code-block:: none
+
+  +---------------------------------------------------+
+  |                     Tx Chunk                      |
+  | +---------------------------+  +----------------+ |   MOSI
+  | | 64/32 bytes chunk payload |  | 4 bytes header | |------------>
+  | +---------------------------+  +----------------+ |
+  +---------------------------------------------------+
+
+The number of buffers available in the MAC-PHY to store the incoming tx
+chunk payloads is represented as tx credit count (txc). This txc can be
+read either from the Buffer Status Register or footer (Refer below in the
+rx case for the footer info) received from the MAC-PHY. The number of txc
+is needed to transport the ethernet frame is calculated from the size of
+the ethernet frame. The header in the each chunk is updated with the
+chunk payload details like data not control, data valid, start valid,
+start word offset, end byte offset, end valid and parity bit.
+
+Once the tx chunks are ready, oa_tc6_handler() task is triggered to
+perform SPI transfer. This task checks for the txc availability in the
+MAC-PHY and sends the number of chunks equal to the txc. If there is no
+txc is available then the task waits for the interrupt to indicate the
+txc availability. If the available txc is less than the needed txc then
+the SPI transfer is performed for the available txc and the rx chunks
+footer is processed for the txc availability again. For every SPI
+transfer the received rx chunks will be processed for the rx ethernet
+frame (if any), txc and rca.
+
+Rx ethernet frame from the MAC-PHY is framed from the rx chunks received
+from the MAC-PHY and will be transferred to the n/w layer. Each rx chunk
+will have 64/32 bytes chunk payload and 4 bytes footer.
+
+.. code-block:: none
+
+  +---------------------------------------------------+
+  |                     Rx Chunk                      |
+  | +----------------+  +---------------------------+ |   MISO
+  | | 4 bytes footer |  | 64/32 bytes chunk payload | |------------>
+  | +----------------+  +---------------------------+ |
+  +---------------------------------------------------+
+
+In case of interrupt, the oa_tc6_handler() task performs an empty chunk
+SPI transfer to get the reason for the interrupt in the received chunk
+footer. The reason can be receive chunk available (rca) or extended block
+status (exst) or txc availability. Based on this the corresponding
+operation is performed. If it is for rca then the SPI transfer is
+performed with the empty chunks equal to the rca to get the rx chunks.
+Rx ethernet frame is framed from the rx chunks received and transferred
+to n/w layer. If it is for exst then the STATUS0 register will be read
+for the error detail.
+
+In the beginning the interrupt occurs for indicating the reset complete
+from the MAC-PHY and is ready for the configuration. oa_tc6_handler() task
+handles this interrupt to get and clear the reset complete status.
+
+Control Transaction
+~~~~~~~~~~~~~~~~~~~
+
+Control transactions are performed to read/write the registers in the
+MAC-PHY. Each control command headers are 4 bytes length with the
+necessary details to read/write the registers.
+
+In case of a register write command, the write command header has the
+information like data not control, write not read, address increment
+disable, memory map selector, address, length and parity followed by the
+data to be written. If the protected mode is enabled in the CONFIG0
+register then each data to be written will be sent first followed by its
+ones' complement value to ensure the error free transfer. For every write
+command, both the write command header and the data will be echoed back in
+the rx path to confirm the error free transaction.
+
+In case of a register read command, the read command is preferred with the
+above mentioned details and the echoed rx data will be processed for the
+register data. In case of protected mode enabled the echoed rx data
+contains the ones' complemented data also for verifying the data error.
+
+oa_tc6_perform_ctrl() function prepares control commands based on the
+read/write request, performs SPI transfer, checks for the error and
+returns read register data in case of control read command.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9cc15c50c2c6..c54454c7e7a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15835,6 +15835,14 @@ L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/ulp/opa_vnic
 
+OPEN ALLIANCE 10BASE-T1S MACPHY SERIAL INTERFACE FRAMEWORK
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/oa-tc6-framework.rst
+F:	drivers/include/linux/oa_tc6.h
+F:	drivers/net/ethernet/oa_tc6.c
+
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh+dt@kernel.org>
 M:	Frank Rowand <frowand.list@gmail.com>
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
new file mode 100644
index 000000000000..613cf034430a
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface framework
+ *
+ * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/oa_tc6.h>
+
+static int oa_tc6_spi_transfer(struct spi_device *spi, u8 *ptx, u8 *prx,
+			       u16 len)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = ptx,
+		.rx_buf = prx,
+		.len = len,
+	};
+	struct spi_message msg;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	return spi_sync(spi, &msg);
+}
+
+static bool oa_tc6_get_parity(u32 p)
+{
+	bool parity = true;
+
+	/* This function returns an odd parity bit */
+	while (p) {
+		parity = !parity;
+		p = p & (p - 1);
+	}
+	return parity;
+}
+
+static void oa_tc6_prepare_ctrl_buf(struct oa_tc6 *tc6, u32 addr, u32 val[],
+				    u8 len, bool wnr, u8 *buf, bool ctrl_prot)
+{
+	u32 hdr;
+
+	/* Prepare the control header with the required details */
+	hdr = FIELD_PREP(CTRL_HDR_DNC, 0) |
+	      FIELD_PREP(CTRL_HDR_WNR, wnr) |
+	      FIELD_PREP(CTRL_HDR_AID, 0) |
+	      FIELD_PREP(CTRL_HDR_MMS, addr >> 16) |
+	      FIELD_PREP(CTRL_HDR_ADDR, addr) |
+	      FIELD_PREP(CTRL_HDR_LEN, len - 1);
+	hdr |= FIELD_PREP(CTRL_HDR_P, oa_tc6_get_parity(hdr));
+	*(u32 *)buf = cpu_to_be32(hdr);
+
+	if (wnr) {
+		for (u8 i = 0; i < len; i++) {
+			u16 pos;
+
+			if (!ctrl_prot) {
+				/* Send the value to be written followed by the
+				 * header.
+				 */
+				pos = (i + 1) * TC6_HDR_SIZE;
+				*(u32 *)&buf[pos] = cpu_to_be32(val[i]);
+			} else {
+				/* If protected then send complemented value
+				 * also followed by actual value.
+				 */
+				pos = TC6_HDR_SIZE + (i * (TC6_HDR_SIZE * 2));
+				*(u32 *)&buf[pos] = cpu_to_be32(val[i]);
+				pos = (i + 1) * (TC6_HDR_SIZE * 2);
+				*(u32 *)&buf[pos] = cpu_to_be32(~val[i]);
+			}
+		}
+	}
+}
+
+static int oa_tc6_check_control(struct oa_tc6 *tc6, u8 *ptx, u8 *prx, u8 len,
+				bool wnr, bool ctrl_prot)
+{
+	/* 1st 4 bytes of rx chunk data can be discarded */
+	u32 rx_hdr = *(u32 *)&prx[TC6_HDR_SIZE];
+	u32 tx_hdr = *(u32 *)ptx;
+	u32 rx_data_complement;
+	u32 tx_data;
+	u32 rx_data;
+	u16 pos1;
+	u16 pos2;
+
+	/* If tx hdr and echoed hdr are not equal then there might be an issue
+	 * with the connection between SPI host and MAC-PHY. Here this case is
+	 * considered as MAC-PHY is not connected.
+	 */
+	if (tx_hdr != rx_hdr)
+		return -ENODEV;
+
+	if (wnr) {
+		if (!ctrl_prot) {
+			/* In case of ctrl write, both tx data & echoed
+			 * data are compared for the error.
+			 */
+			pos1 = TC6_HDR_SIZE;
+			pos2 = TC6_HDR_SIZE * 2;
+			for (u8 i = 0; i < len; i++) {
+				tx_data = *(u32 *)&ptx[pos1 + (i * TC6_HDR_SIZE)];
+				rx_data = *(u32 *)&prx[pos2 + (i * TC6_HDR_SIZE)];
+				if (tx_data != rx_data)
+					return -ENODEV;
+			}
+			return 0;
+		}
+	} else {
+		if (!ctrl_prot)
+			return 0;
+	}
+
+	/* In case of ctrl read or ctrl write in protected mode, the rx data and
+	 * the complement of rx data are compared for the error.
+	 */
+	pos1 = TC6_HDR_SIZE * 2;
+	pos2 = TC6_HDR_SIZE * 3;
+	for (u8 i = 0; i < len; i++) {
+		rx_data = *(u32 *)&prx[pos1 + (i * TC6_HDR_SIZE * 2)];
+		rx_data_complement = *(u32 *)&prx[pos2 + (i * TC6_HDR_SIZE * 2)];
+		if (rx_data != ~rx_data_complement)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
+			bool wnr, bool ctrl_prot)
+{
+	u8 *tx_buf;
+	u8 *rx_buf;
+	u16 size;
+	u16 pos;
+	int ret;
+
+	if (ctrl_prot)
+		size = (TC6_HDR_SIZE * 2) + (len * (TC6_HDR_SIZE * 2));
+	else
+		size = (TC6_HDR_SIZE * 2) + (len * TC6_HDR_SIZE);
+
+	tx_buf = kzalloc(size, GFP_KERNEL);
+	if (!tx_buf)
+		return -ENOMEM;
+
+	rx_buf = kzalloc(size, GFP_KERNEL);
+	if (!rx_buf) {
+		ret = -ENOMEM;
+		goto err_rx_buf_kzalloc;
+	}
+
+	/* Prepare control command */
+	oa_tc6_prepare_ctrl_buf(tc6, addr, val, len, wnr, tx_buf, ctrl_prot);
+
+	/* Perform SPI transfer */
+	ret = oa_tc6_spi_transfer(tc6->spi, tx_buf, rx_buf, size);
+	if (ret)
+		goto err_ctrl;
+
+	/* Check echoed/received control reply */
+	ret = oa_tc6_check_control(tc6, tx_buf, rx_buf, len, wnr, ctrl_prot);
+	if (ret)
+		goto err_ctrl;
+
+	if (!wnr) {
+		/* Copy read data from the rx data in case of ctrl read */
+		for (u8 i = 0; i < len; i++) {
+			if (!ctrl_prot) {
+				pos = (TC6_HDR_SIZE * 2) + (i * TC6_HDR_SIZE);
+				val[i] = be32_to_cpu(*(u32 *)&rx_buf[pos]);
+			} else {
+				pos = (TC6_HDR_SIZE * 2) +
+				       (i * (TC6_HDR_SIZE * 2));
+				val[i] = be32_to_cpu(*(u32 *)&rx_buf[pos]);
+			}
+		}
+	}
+
+err_ctrl:
+	kfree(rx_buf);
+err_rx_buf_kzalloc:
+	kfree(tx_buf);
+	return ret;
+}
+
+int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len)
+{
+	return oa_tc6_perform_ctrl(tc6, addr, val, len, true, tc6->ctrl_prot);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_write_register);
+
+int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len)
+{
+	return oa_tc6_perform_ctrl(tc6, addr, val, len, false, tc6->ctrl_prot);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_read_register);
+
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
+{
+	struct oa_tc6 *tc6;
+
+	if (!spi)
+		return NULL;
+
+	tc6 = kzalloc(sizeof(*tc6), GFP_KERNEL);
+	if (!tc6)
+		return NULL;
+
+	tc6->spi = spi;
+
+	return tc6;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_init);
+
+void oa_tc6_deinit(struct oa_tc6 *tc6)
+{
+	kfree(tc6);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_deinit);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
new file mode 100644
index 000000000000..5e0a58ab1dcd
--- /dev/null
+++ b/include/linux/oa_tc6.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface framework
+ *
+ * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ */
+
+#include <linux/spi/spi.h>
+
+/* Control header */
+#define CTRL_HDR_DNC	BIT(31)		/* Data-Not-Control */
+#define CTRL_HDR_HDRB	BIT(30)		/* Received Header Bad */
+#define CTRL_HDR_WNR	BIT(29)		/* Write-Not-Read */
+#define CTRL_HDR_AID	BIT(28)		/* Address Increment Disable */
+#define CTRL_HDR_MMS	GENMASK(27, 24)	/* Memory Map Selector */
+#define CTRL_HDR_ADDR	GENMASK(23, 8)	/* Address */
+#define CTRL_HDR_LEN	GENMASK(7, 1)	/* Length */
+#define CTRL_HDR_P	BIT(0)		/* Parity Bit */
+
+#define TC6_HDR_SIZE	4		/* Ctrl command header size as per OA */
+#define TC6_FTR_SIZE	4		/* Ctrl command footer size ss per OA */
+
+struct oa_tc6 {
+	struct spi_device *spi;
+	bool ctrl_prot;
+};
+
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
+void oa_tc6_deinit(struct oa_tc6 *tc6);
+int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
+int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
-- 
2.34.1

