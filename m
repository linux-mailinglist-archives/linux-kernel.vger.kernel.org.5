Return-Path: <linux-kernel+bounces-1192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B3814B84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC491F24275
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452873FE4E;
	Fri, 15 Dec 2023 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wKVJJKSq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAE358B0;
	Fri, 15 Dec 2023 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702653243; x=1734189243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Oa+mFk+l/fL5dUo1sh864SZWHzHKXPzp5ZGRFsk+jU=;
  b=wKVJJKSqt5pKwcL71H4bdWFjqVm/Lwxp8H0jxxGaxm+c2PyNAnzasHWP
   3u9gkexHWFW8UgWa7WOs5VILWqkliGy6YYsMNXxsjVvlnav62GP+CRpjI
   CYc+YhFwuHzOoIbURR5hr7KgztqyBM8ECMqSQGnXXz0IPUJAElaxeKyIS
   N2zDQlZ9bCwrFNt6fChOOlqM84y++dR4wO/CiJNsb76bjJrMjsGNktVot
   feREeJFW+KwOAK13PQGwN3CUwRhfVCsH6DmXGwZVqLEnimDxyfz9p1G2D
   NjI0wOJ/wkjB07vl3ZJQDVzjDmYYPqhgo/4XaKpg6UD+eyjf8IMhiZse6
   w==;
X-CSE-ConnectionGUID: BG5aezBORpi9vCgyPr6Htg==
X-CSE-MsgGUID: DBDPU8WCSdK19aMOOAkiHA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="14326571"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2023 08:14:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 08:13:26 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 08:13:23 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <keescook@chromium.org>, <gustavoars@kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <unglinuxdriver@microchip.com>
Subject: [PATCH v1 tty-next 3/4] 8250: microchip: pci1xxxx: Add Burst mode reception support in uart driver for writing into FIFO
Date: Fri, 15 Dec 2023 20:41:22 +0530
Message-ID: <20231215151123.41812-4-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215151123.41812-1-rengarajan.s@microchip.com>
References: <20231215151123.41812-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In PCI1XXXX C0 endpoint, support for Burst mode is added.
pci1xxxx_handle_irq checks the burst status and based on that
incoming characters are received in DWORDs, RX handling is done
in pci1xxxx_rx_burst. While reading the burst status the RX error
is checked and the corresponding error statistics are updated.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 123 +++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 6b6f3731307f..558c4c7f3104 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -66,6 +66,9 @@
 #define SYSLOCK_SLEEP_TIMEOUT			100
 #define SYSLOCK_RETRY_CNT			1000
 
+#define UART_RX_BYTE_FIFO			0x00
+#define UART_FIFO_CTL				0x02
+
 #define UART_ACTV_REG				0x11
 #define UART_BLOCK_SET_ACTIVE			BIT(0)
 
@@ -96,8 +99,23 @@
 #define UART_RESET_REG				0x94
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
 
+#define UART_BURST_STATUS_REG			0x9C
+#define UART_RX_BURST_FIFO			0xA4
+
 #define MAX_PORTS				4
 #define PORT_OFFSET				0x100
+#define RX_BUF_SIZE				512
+#define UART_BYTE_SIZE                          1
+#define UART_BURST_SIZE				4
+
+#define UART_BST_STAT_RX_COUNT_MASK		0x00FF
+#define UART_BST_STAT_IIR_INT_PEND		0x100000
+#define UART_LSR_OVERRUN_ERR_CLR		0x43
+#define UART_BST_STAT_LSR_RX_MASK		0x9F000000
+#define UART_BST_STAT_LSR_RX_ERR_MASK		0x9E000000
+#define UART_BST_STAT_LSR_OVERRUN_ERR		0x2000000
+#define UART_BST_STAT_LSR_PARITY_ERR		0x4000000
+#define UART_BST_STAT_LSR_FRAME_ERR		0x8000000
 
 struct pci1xxxx_8250 {
 	unsigned int nr;
@@ -249,6 +267,103 @@ static int pci1xxxx_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static u32 pci1xxxx_read_burst_status(struct uart_port *port)
+{
+	u32 status;
+
+	status = readl(port->membase + UART_BURST_STATUS_REG);
+	if (status & UART_BST_STAT_LSR_RX_ERR_MASK) {
+		if (status & UART_BST_STAT_LSR_OVERRUN_ERR) {
+			writeb(UART_LSR_OVERRUN_ERR_CLR,
+			       port->membase + UART_FIFO_CTL);
+			port->icount.overrun++;
+		}
+
+		if (status & UART_BST_STAT_LSR_FRAME_ERR)
+			port->icount.frame++;
+
+		if (status & UART_BST_STAT_LSR_PARITY_ERR)
+			port->icount.parity++;
+	}
+	return status;
+}
+
+static void pci1xxxx_process_read_data(struct uart_port *port,
+				       unsigned char *rx_buff, u32 *buff_index,
+				       u32 *valid_byte_count)
+{
+	u32 valid_burst_count = *valid_byte_count / UART_BURST_SIZE;
+	u32 *burst_buf;
+
+	/*
+	 * Depending on the RX Trigger Level the number of bytes that can be
+	 * stored in RX FIFO at a time varies. Each transaction reads data
+	 * in DWORDs. If there are less than four remaining valid_byte_count
+	 * to read, the data is received one byte at a time.
+	 */
+	while (valid_burst_count--) {
+		if (*buff_index > (RX_BUF_SIZE - UART_BURST_SIZE))
+			break;
+		burst_buf = (u32 *)&rx_buff[*buff_index];
+		*burst_buf = readl(port->membase + UART_RX_BURST_FIFO);
+		*buff_index += UART_BURST_SIZE;
+		*valid_byte_count -= UART_BURST_SIZE;
+	}
+
+	while (*valid_byte_count) {
+		if (*buff_index > RX_BUF_SIZE)
+			break;
+		rx_buff[*buff_index] = readb(port->membase +
+					     UART_RX_BYTE_FIFO);
+		*buff_index += UART_BYTE_SIZE;
+		*valid_byte_count -= UART_BYTE_SIZE;
+	}
+}
+
+static void pci1xxxx_rx_burst(struct uart_port *port, u32 uart_status)
+{
+	u32 valid_byte_count = uart_status & UART_BST_STAT_RX_COUNT_MASK;
+	struct tty_port *tty_port = &port->state->port;
+	unsigned char rx_buff[RX_BUF_SIZE];
+	u32 buff_index = 0;
+	u32 copied_len;
+
+	if (valid_byte_count != 0 &&
+	    valid_byte_count < RX_BUF_SIZE) {
+		pci1xxxx_process_read_data(port, rx_buff, &buff_index,
+					   &valid_byte_count);
+
+		copied_len = (u32)tty_insert_flip_string(tty_port, rx_buff,
+							 buff_index);
+
+		if (copied_len != buff_index)
+			port->icount.overrun += buff_index - copied_len;
+
+		port->icount.rx += buff_index;
+		tty_flip_buffer_push(tty_port);
+	}
+}
+
+static int pci1xxxx_handle_irq(struct uart_port *port)
+{
+	unsigned long flags;
+	u32 status;
+
+	status = pci1xxxx_read_burst_status(port);
+
+	if (status & UART_BST_STAT_IIR_INT_PEND)
+		return 0;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (status & UART_BST_STAT_LSR_RX_MASK)
+		pci1xxxx_rx_burst(port, status);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 1;
+}
+
 static bool pci1xxxx_port_suspend(int line)
 {
 	struct uart_8250_port *up = serial8250_get_port(line);
@@ -360,7 +475,7 @@ static int pci1xxxx_resume(struct device *dev)
 }
 
 static int pci1xxxx_setup(struct pci_dev *pdev,
-			  struct uart_8250_port *port, int port_idx)
+			  struct uart_8250_port *port, int port_idx, int rev)
 {
 	int ret;
 
@@ -372,6 +487,10 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	port->port.rs485_config = pci1xxxx_rs485_config;
 	port->port.rs485_supported = pci1xxxx_rs485_supported;
 
+	/* From C0 rev Burst operation is supported */
+	if (rev >= 0xC0)
+		port->port.handle_irq = pci1xxxx_handle_irq;
+
 	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
 	if (ret < 0)
 		return ret;
@@ -491,7 +610,7 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 		else
 			uart.port.irq = pci_irq_vector(pdev, 0);
 
-		rc = pci1xxxx_setup(pdev, &uart, port_idx);
+		rc = pci1xxxx_setup(pdev, &uart, port_idx, priv->dev_rev);
 		if (rc) {
 			dev_warn(dev, "Failed to setup port %u\n", i);
 			continue;
-- 
2.25.1


