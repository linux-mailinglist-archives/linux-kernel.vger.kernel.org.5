Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10279F390
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjIMVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjIMVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:15:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2E11739;
        Wed, 13 Sep 2023 14:15:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fb71ded6dso201655b3a.0;
        Wed, 13 Sep 2023 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694639712; x=1695244512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZAktouR9CJHYeqMAbJJx4j6TYbgdWJha7ocuT3jGDI=;
        b=eLyL2yV/EWe90d2y+LRrQ6tESm+g5Gh55v+INAFENLJiUpApDEe9VMC7RRFCdnBvuP
         69jGowCInWanUdyjKiNt5jlmOYGMeNLZnB7IEVj13r9I3mJq4fVdERpbnuNdSYm7joMi
         XTKlwbA2WgIW1zb8NDwO86bcauc4Ybidy2l6BYCx0BSugTklbJCOXnwWgozS1pC7VBKT
         lRkkq/iMSQx+XyV3abvx6UR/hdHCtAIDI6wLxJvTt6WX7Xk5IhO0OLVqxEetIeW0Ba+h
         Fck6q4aLQdmehXJOzU5RahRy3/K0w9EyZSE1F/EZMxUfABQ8HwcGooTwJxCF2YcLAb9N
         IR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639712; x=1695244512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZAktouR9CJHYeqMAbJJx4j6TYbgdWJha7ocuT3jGDI=;
        b=dgcrh6OZj8Pf1VQzLXObg71MIntxIrIuJVHEG7LVPN2vQgCdJhSdjIp1Xm0Ks7C9To
         XdOwvoIskso7PdUcQ5pFw2YhaWt7k/w0NF6M4gqTk2Jqy8hexP9ZF2oovE8POOAjiuTP
         w/2kO3NZYW0ILPCfLITRViBq47dtD+YkHWqHRdLzeXzzitHd9dCBNkIEqLicPJM+kwWp
         yAoOzkgwBmTqI2RF55+KQ4kt7+1zOYAG1n2wnVjzgWBPN1W+PevfF/K1Iv8kux5qKlSM
         SjfgjaPRctMUbFXmyiztYJsKSrl4to6plpokOwqyVdz+euKAjQMV31n3S8GJ5U5gfXNr
         AU5A==
X-Gm-Message-State: AOJu0Yw2ONSU7ugbAwv/cXt2ZtthPVI6LMFkHBfdzEOixALfUjMRHSgW
        jOQwmpLD1lRwbIhHCguf6SNDfLTGU34=
X-Google-Smtp-Source: AGHT+IHDTYVg8QYDJUjOaxlwNhOpQ/l6Tkqw1oHToikHCDpbXq//ZW3+JKIsWz+6XyrL95DSlBkAQQ==
X-Received: by 2002:a05:6a20:ce91:b0:14c:d0c0:dd27 with SMTP id if17-20020a056a20ce9100b0014cd0c0dd27mr3228744pzb.44.1694639712322;
        Wed, 13 Sep 2023 14:15:12 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:82b1:d7c2:2eaf:61e7])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b8c689060dsm73707plh.28.2023.09.13.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:15:11 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/4] drivers/tty/serial: add driver for the ESP32 UART
Date:   Wed, 13 Sep 2023 14:14:47 -0700
Message-Id: <20230913211449.668796-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913211449.668796-1-jcmvbkbc@gmail.com>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
SoCs. Hardware specification is available at the following URLs:

  https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf
  (Chapter 13 UART Controller)
  https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
  (Chapter 26 UART Controller)

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/tty/serial/Kconfig       |  13 +
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/esp32_uart.c  | 766 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 783 insertions(+)
 create mode 100644 drivers/tty/serial/esp32_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bdc568a4ab66..d9ca6b268f01 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1578,6 +1578,19 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
 	  but you can alter that using a kernel command line option such as
 	  "console=ttyNVTx".
 
+config SERIAL_ESP32
+	tristate "Espressif ESP32 UART support"
+	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Driver for the UART controllers of the Espressif ESP32xx SoCs.
+	  When earlycon option is enabled the following kernel command line
+	  snippets may be used:
+	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
+	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 138abbc89738..7b73137df7f3 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
 obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
+obj-$(CONFIG_SERIAL_ESP32)	+= esp32_uart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
new file mode 100644
index 000000000000..05ec0fce3a62
--- /dev/null
+++ b/drivers/tty/serial/esp32_uart.c
@@ -0,0 +1,766 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+#include <linux/delay.h>
+#include <asm/serial.h>
+
+#define DRIVER_NAME	"esp32-uart"
+#define DEV_NAME	"ttyS"
+#define UART_NR		3
+
+#define ESP32_UART_TX_FIFO_SIZE	127
+#define ESP32_UART_RX_FIFO_SIZE	127
+
+#define UART_FIFO_REG			0x00
+#define UART_INT_RAW_REG		0x04
+#define UART_INT_ST_REG			0x08
+#define UART_INT_ENA_REG		0x0c
+#define UART_INT_CLR_REG		0x10
+#define UART_RXFIFO_FULL_INT_MASK		0x00000001
+#define UART_TXFIFO_EMPTY_INT_MASK		0x00000002
+#define UART_BRK_DET_INT_MASK			0x00000080
+#define UART_CLKDIV_REG			0x14
+#define ESP32_UART_CLKDIV_MASK			0x000fffff
+#define ESP32S3_UART_CLKDIV_MASK		0x00000fff
+#define UART_CLKDIV_SHIFT			0
+#define UART_CLKDIV_FRAG_MASK			0x00f00000
+#define UART_CLKDIV_FRAG_SHIFT			20
+#define UART_STATUS_REG			0x1c
+#define ESP32_UART_RXFIFO_CNT_MASK		0x000000ff
+#define ESP32S3_UART_RXFIFO_CNT_MASK		0x000003ff
+#define UART_RXFIFO_CNT_SHIFT			0
+#define UART_DSRN_MASK				0x00002000
+#define UART_CTSN_MASK				0x00004000
+#define ESP32_UART_TXFIFO_CNT_MASK		0x00ff0000
+#define ESP32S3_UART_TXFIFO_CNT_MASK		0x03ff0000
+#define UART_TXFIFO_CNT_SHIFT			16
+#define UART_ST_UTX_OUT_MASK			0x0f000000
+#define UART_ST_UTX_OUT_IDLE			0x00000000
+#define UART_ST_UTX_OUT_SHIFT			24
+#define UART_CONF0_REG			0x20
+#define UART_PARITY_MASK			0x00000001
+#define UART_PARITY_EN_MASK			0x00000002
+#define UART_BIT_NUM_MASK			0x0000000c
+#define UART_BIT_NUM_5				0x00000000
+#define UART_BIT_NUM_6				0x00000004
+#define UART_BIT_NUM_7				0x00000008
+#define UART_BIT_NUM_8				0x0000000c
+#define UART_STOP_BIT_NUM_MASK			0x00000030
+#define UART_STOP_BIT_NUM_1			0x00000010
+#define UART_STOP_BIT_NUM_2			0x00000030
+#define UART_SW_RTS_MASK			0x00000040
+#define UART_SW_DTR_MASK			0x00000080
+#define UART_LOOPBACK_MASK			0x00004000
+#define UART_TX_FLOW_EN_MASK			0x00008000
+#define UART_RTS_INV_MASK			0x00800000
+#define UART_DTR_INV_MASK			0x01000000
+#define ESP32_UART_TICK_REF_ALWAYS_ON_MASK	0x08000000
+#define ESP32S3_UART_TICK_REF_ALWAYS_ON_MASK	0x00000000
+#define UART_CONF1_REG			0x24
+#define ESP32_UART_RXFIFO_FULL_THRHD_MASK	0x0000007f
+#define ESP32S3_UART_RXFIFO_FULL_THRHD_MASK	0x000003ff
+#define UART_RXFIFO_FULL_THRHD_SHIFT		0
+#define ESP32_UART_TXFIFO_EMPTY_THRHD_MASK	0x00007f00
+#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_MASK	0x000ffc00
+#define ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT	8
+#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT	10
+#define ESP32_UART_RX_FLOW_EN_MASK		0x00800000
+#define ESP32S3_UART_RX_FLOW_EN_MASK		0x00400000
+
+struct esp32_port {
+	struct uart_port port;
+	struct clk *clk;
+};
+
+struct esp32_uart_variant {
+	u32 clkdiv_mask;
+	u32 rxfifo_cnt_mask;
+	u32 txfifo_cnt_mask;
+	u32 rxfifo_full_thrhd_mask;
+	u32 txfifo_empty_thrhd_mask;
+	u32 txfifo_empty_thrhd_shift;
+	u32 rx_flow_en;
+	const char *type;
+};
+
+static const struct esp32_uart_variant esp32_variant = {
+	.clkdiv_mask = ESP32_UART_CLKDIV_MASK,
+	.rxfifo_cnt_mask = ESP32_UART_RXFIFO_CNT_MASK,
+	.txfifo_cnt_mask = ESP32_UART_TXFIFO_CNT_MASK,
+	.rxfifo_full_thrhd_mask = ESP32_UART_RXFIFO_FULL_THRHD_MASK,
+	.txfifo_empty_thrhd_mask = ESP32_UART_TXFIFO_EMPTY_THRHD_MASK,
+	.txfifo_empty_thrhd_shift = ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_en = ESP32_UART_RX_FLOW_EN_MASK,
+	.type = "ESP32 UART",
+};
+
+static const struct esp32_uart_variant esp32s3_variant = {
+	.clkdiv_mask = ESP32S3_UART_CLKDIV_MASK,
+	.rxfifo_cnt_mask = ESP32S3_UART_RXFIFO_CNT_MASK,
+	.txfifo_cnt_mask = ESP32S3_UART_TXFIFO_CNT_MASK,
+	.rxfifo_full_thrhd_mask = ESP32S3_UART_RXFIFO_FULL_THRHD_MASK,
+	.txfifo_empty_thrhd_mask = ESP32S3_UART_TXFIFO_EMPTY_THRHD_MASK,
+	.txfifo_empty_thrhd_shift = ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_en = ESP32S3_UART_RX_FLOW_EN_MASK,
+	.type = "ESP32S3 UART",
+};
+
+static const struct of_device_id esp32_uart_dt_ids[] = {
+	{
+		.compatible = "esp,esp32-uart",
+		.data = &esp32_variant,
+	}, {
+		.compatible = "esp,esp32s3-uart",
+		.data = &esp32s3_variant,
+	}, { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, esp32_uart_dt_ids);
+
+static struct esp32_port *esp32_uart_ports[UART_NR];
+
+static const struct esp32_uart_variant *port_variant(struct uart_port *port)
+{
+	return port->private_data;
+}
+
+static void esp32_uart_write(struct uart_port *port, unsigned long reg, u32 v)
+{
+	writel(v, port->membase + reg);
+}
+
+static u32 esp32_uart_read(struct uart_port *port, unsigned long reg)
+{
+	return readl(port->membase + reg);
+}
+
+static u32 esp32_uart_tx_fifo_cnt(struct uart_port *port)
+{
+	return (esp32_uart_read(port, UART_STATUS_REG) &
+		port_variant(port)->txfifo_cnt_mask) >> UART_TXFIFO_CNT_SHIFT;
+}
+
+static u32 esp32_uart_rx_fifo_cnt(struct uart_port *port)
+{
+	return (esp32_uart_read(port, UART_STATUS_REG) &
+		port_variant(port)->rxfifo_cnt_mask) >> UART_RXFIFO_CNT_SHIFT;
+}
+
+/* return TIOCSER_TEMT when transmitter is not busy */
+static unsigned int esp32_uart_tx_empty(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG) &
+		(port_variant(port)->txfifo_cnt_mask | UART_ST_UTX_OUT_MASK);
+
+	pr_debug("%s: %08x\n", __func__, status);
+	return status == UART_ST_UTX_OUT_IDLE ? TIOCSER_TEMT : 0;
+}
+
+static void esp32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 conf0 = esp32_uart_read(port, UART_CONF0_REG) &
+		~(UART_LOOPBACK_MASK |
+		  UART_SW_RTS_MASK | UART_RTS_INV_MASK |
+		  UART_SW_DTR_MASK | UART_DTR_INV_MASK);
+
+	if (mctrl & TIOCM_RTS)
+		conf0 |= UART_SW_RTS_MASK;
+	if (mctrl & TIOCM_DTR)
+		conf0 |= UART_SW_DTR_MASK;
+	if (mctrl & TIOCM_LOOP)
+		conf0 |= UART_LOOPBACK_MASK;
+
+	esp32_uart_write(port, UART_CONF0_REG, conf0);
+}
+
+static unsigned int esp32_uart_get_mctrl(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+	unsigned int ret = TIOCM_CAR;
+
+	if (status & UART_DSRN_MASK)
+		ret |= TIOCM_DSR;
+	if (status & UART_CTSN_MASK)
+		ret |= TIOCM_CTS;
+
+	return ret;
+}
+
+static void esp32_uart_stop_tx(struct uart_port *port)
+{
+	u32 int_ena;
+
+	int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+	esp32_uart_write(port, UART_INT_ENA_REG,
+			 int_ena & ~UART_TXFIFO_EMPTY_INT_MASK);
+}
+
+static void esp32_uart_rxint(struct uart_port *port)
+{
+	struct tty_port *tty_port = &port->state->port;
+	u32 rx_fifo_cnt = esp32_uart_rx_fifo_cnt(port);
+	unsigned long flags;
+	u32 i;
+
+	if (!rx_fifo_cnt)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	for (i = 0; i < rx_fifo_cnt; ++i) {
+		u32 rx = esp32_uart_read(port, UART_FIFO_REG);
+		u32 brk = 0;
+
+		++port->icount.rx;
+
+		if (!rx) {
+			brk = esp32_uart_read(port, UART_INT_ST_REG) &
+				UART_BRK_DET_INT_MASK;
+		}
+		if (brk) {
+			esp32_uart_write(port, UART_INT_CLR_REG, brk);
+			++port->icount.brk;
+			uart_handle_break(port);
+		} else {
+			if (uart_handle_sysrq_char(port, (unsigned char)rx))
+				continue;
+			tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
+		}
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	tty_flip_buffer_push(tty_port);
+}
+
+static void esp32_uart_put_char(struct uart_port *port, unsigned char c)
+{
+	esp32_uart_write(port, UART_FIFO_REG, c);
+}
+
+static void esp32_uart_put_char_sync(struct uart_port *port, unsigned char c)
+{
+	while (esp32_uart_tx_fifo_cnt(port) >= ESP32_UART_TX_FIFO_SIZE)
+		cpu_relax();
+	esp32_uart_put_char(port, c);
+}
+
+static void esp32_uart_transmit_buffer(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	u32 tx_fifo_used = esp32_uart_tx_fifo_cnt(port);
+
+	while (!uart_circ_empty(xmit) && tx_fifo_used < ESP32_UART_TX_FIFO_SIZE) {
+		esp32_uart_put_char(port, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+		++tx_fifo_used;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit)) {
+		esp32_uart_stop_tx(port);
+	} else {
+		u32 int_ena;
+
+		int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+		esp32_uart_write(port, UART_INT_ENA_REG,
+				 int_ena | UART_TXFIFO_EMPTY_INT_MASK);
+	}
+}
+
+static void esp32_uart_txint(struct uart_port *port)
+{
+	esp32_uart_transmit_buffer(port);
+}
+
+static irqreturn_t esp32_uart_int(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	u32 status;
+
+	status = esp32_uart_read(port, UART_INT_ST_REG);
+
+	if (status & (UART_RXFIFO_FULL_INT_MASK | UART_BRK_DET_INT_MASK))
+		esp32_uart_rxint(port);
+	if (status & UART_TXFIFO_EMPTY_INT_MASK)
+		esp32_uart_txint(port);
+
+	esp32_uart_write(port, UART_INT_CLR_REG, status);
+	return IRQ_HANDLED;
+}
+
+static void esp32_uart_start_tx(struct uart_port *port)
+{
+	esp32_uart_transmit_buffer(port);
+}
+
+static void esp32_uart_stop_rx(struct uart_port *port)
+{
+	u32 int_ena;
+
+	int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+	esp32_uart_write(port, UART_INT_ENA_REG,
+			 int_ena & ~UART_RXFIFO_FULL_INT_MASK);
+}
+
+static int esp32_uart_startup(struct uart_port *port)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	ret = clk_prepare_enable(sport->clk);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+	esp32_uart_write(port, UART_CONF1_REG,
+			 (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
+			 (1 << port_variant(port)->txfifo_empty_thrhd_shift));
+	esp32_uart_write(port, UART_INT_CLR_REG,
+			 UART_RXFIFO_FULL_INT_MASK |
+			 UART_BRK_DET_INT_MASK);
+	esp32_uart_write(port, UART_INT_ENA_REG,
+			 UART_RXFIFO_FULL_INT_MASK |
+			 UART_BRK_DET_INT_MASK);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	ret = devm_request_irq(port->dev, port->irq, esp32_uart_int, 0,
+			       DRIVER_NAME, port);
+
+	pr_debug("%s, request_irq: %d, conf1 = %08x, int_st = %08x, status = %08x\n",
+		 __func__, ret,
+		 esp32_uart_read(port, UART_CONF1_REG),
+		 esp32_uart_read(port, UART_INT_ST_REG),
+		 esp32_uart_read(port, UART_STATUS_REG));
+	return ret;
+}
+
+static void esp32_uart_shutdown(struct uart_port *port)
+{
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	esp32_uart_write(port, UART_INT_ENA_REG, 0);
+	devm_free_irq(port->dev, port->irq, port);
+	clk_disable_unprepare(sport->clk);
+}
+
+static void esp32_uart_set_baud(struct uart_port *port, u32 baud)
+{
+	u32 div = port->uartclk / baud;
+	u32 frag = (port->uartclk * 16) / baud - div * 16;
+
+	if (div <= port_variant(port)->clkdiv_mask) {
+		esp32_uart_write(port, UART_CLKDIV_REG,
+				 div | (frag << UART_CLKDIV_FRAG_SHIFT));
+	} else {
+		dev_warn(port->dev,
+			 "%s: %d baud is out of reach, setting %d\n",
+			__func__, baud,
+			port->uartclk / port_variant(port)->clkdiv_mask);
+		esp32_uart_write(port, UART_CLKDIV_REG,
+				 port_variant(port)->clkdiv_mask |
+				 UART_CLKDIV_FRAG_MASK);
+	}
+}
+
+static void esp32_uart_set_termios(struct uart_port *port,
+				   struct ktermios *termios,
+				   const struct ktermios *old)
+{
+	unsigned long flags;
+	u32 conf0, conf1;
+	u32 baud;
+	const u32 rx_flow_en = port_variant(port)->rx_flow_en;
+
+	spin_lock_irqsave(&port->lock, flags);
+	conf0 = esp32_uart_read(port, UART_CONF0_REG) &
+		~(UART_PARITY_EN_MASK | UART_PARITY_MASK |
+		  UART_BIT_NUM_MASK | UART_STOP_BIT_NUM_MASK);
+	conf1 = esp32_uart_read(port, UART_CONF1_REG) &
+		~rx_flow_en;
+
+	if (termios->c_cflag & PARENB) {
+		conf0 |= UART_PARITY_EN_MASK;
+		if (termios->c_cflag & PARODD)
+			conf0 |= UART_PARITY_MASK;
+	}
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		conf0 |= UART_BIT_NUM_5;
+		break;
+	case CS6:
+		conf0 |= UART_BIT_NUM_6;
+		break;
+	case CS7:
+		conf0 |= UART_BIT_NUM_7;
+		break;
+	case CS8:
+		conf0 |= UART_BIT_NUM_8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		conf0 |= UART_STOP_BIT_NUM_2;
+	else
+		conf0 |= UART_STOP_BIT_NUM_1;
+
+	if (termios->c_cflag & CRTSCTS)
+		conf1 |= rx_flow_en;
+
+	esp32_uart_write(port, UART_CONF0_REG, conf0);
+	esp32_uart_write(port, UART_CONF1_REG, conf1);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	/*
+	 * esp32s3 may not support 9600, passing its minimal baud rate
+	 * as the min argument would trigger a WARN inside uart_get_baud_rate
+	 */
+	baud = uart_get_baud_rate(port, termios, old,
+				  0, port->uartclk / 16);
+	if (baud)
+		esp32_uart_set_baud(port, baud);
+}
+
+static const char *esp32_uart_type(struct uart_port *port)
+{
+	return port_variant(port)->type;
+}
+
+static void esp32_uart_release_port(struct uart_port *port)
+{
+}
+
+static int esp32_uart_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+/* configure/auto-configure the port */
+static void esp32_uart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_ESP32UART;
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int esp32_uart_poll_init(struct uart_port *port)
+{
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	return clk_prepare_enable(sport->clk);
+}
+
+static void esp32_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	esp32_uart_put_char_sync(port, c);
+}
+
+static int esp32_uart_poll_get_char(struct uart_port *port)
+{
+	if (esp32_uart_rx_fifo_cnt(port))
+		return esp32_uart_read(port, UART_FIFO_REG);
+	else
+		return NO_POLL_CHAR;
+
+}
+#endif
+
+static const struct uart_ops esp32_uart_pops = {
+	.tx_empty	= esp32_uart_tx_empty,
+	.set_mctrl	= esp32_uart_set_mctrl,
+	.get_mctrl	= esp32_uart_get_mctrl,
+	.stop_tx	= esp32_uart_stop_tx,
+	.start_tx	= esp32_uart_start_tx,
+	.stop_rx	= esp32_uart_stop_rx,
+	.startup	= esp32_uart_startup,
+	.shutdown	= esp32_uart_shutdown,
+	.set_termios	= esp32_uart_set_termios,
+	.type		= esp32_uart_type,
+	.release_port	= esp32_uart_release_port,
+	.request_port	= esp32_uart_request_port,
+	.config_port	= esp32_uart_config_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init	= esp32_uart_poll_init,
+	.poll_put_char	= esp32_uart_poll_put_char,
+	.poll_get_char	= esp32_uart_poll_get_char,
+#endif
+};
+
+static void esp32_uart_console_putchar(struct uart_port *port, unsigned char c)
+{
+	esp32_uart_put_char_sync(port, c);
+}
+
+static void esp32_uart_string_write(struct uart_port *port, const char *s,
+				    unsigned int count)
+{
+	uart_console_write(port, s, count, esp32_uart_console_putchar);
+}
+
+static void
+esp32_uart_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct esp32_port *sport = esp32_uart_ports[co->index];
+	struct uart_port *port = &sport->port;
+	unsigned long flags;
+	int locked = 1;
+
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	else
+		spin_lock_irqsave(&port->lock, flags);
+
+	esp32_uart_string_write(port, s, count);
+
+	if (locked)
+		spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int __init esp32_uart_console_setup(struct console *co, char *options)
+{
+	struct esp32_port *sport;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int ret;
+	/*
+	 * check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index == -1 || co->index >= ARRAY_SIZE(esp32_uart_ports))
+		co->index = 0;
+
+	sport = esp32_uart_ports[co->index];
+	if (!sport)
+		return -ENODEV;
+
+	ret = clk_prepare_enable(sport->clk);
+	if (ret)
+		return ret;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
+}
+
+static int esp32_uart_console_exit(struct console *co)
+{
+	struct esp32_port *sport = esp32_uart_ports[co->index];
+
+	clk_disable_unprepare(sport->clk);
+	return 0;
+}
+
+static struct uart_driver esp32_uart_reg;
+static struct console esp32_uart_console = {
+	.name		= DEV_NAME,
+	.write		= esp32_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= esp32_uart_console_setup,
+	.exit		= esp32_uart_console_exit,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &esp32_uart_reg,
+};
+
+static void esp32_uart_earlycon_putchar(struct uart_port *port, unsigned char c)
+{
+	esp32_uart_put_char_sync(port, c);
+}
+
+static void esp32_uart_earlycon_write(struct console *con, const char *s,
+				      unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, esp32_uart_earlycon_putchar);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int esp32_uart_earlycon_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	int num_read = 0;
+
+	while (num_read < n) {
+		int c = esp32_uart_poll_get_char(&dev->port);
+
+		if (c == NO_POLL_CHAR)
+			break;
+		s[num_read++] = c;
+	}
+	return num_read;
+}
+#endif
+
+static int __init esp32xx_uart_early_console_setup(struct earlycon_device *device,
+						   const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = esp32_uart_earlycon_write;
+#ifdef CONFIG_CONSOLE_POLL
+	device->con->read = esp32_uart_earlycon_read;
+#endif
+	if (device->port.uartclk != BASE_BAUD * 16)
+		esp32_uart_set_baud(&device->port, device->baud);
+
+	return 0;
+}
+
+static int __init esp32_uart_early_console_setup(struct earlycon_device *device,
+						 const char *options)
+{
+	device->port.private_data = (void *)&esp32_variant;
+	return esp32xx_uart_early_console_setup(device, options);
+}
+
+OF_EARLYCON_DECLARE(esp32uart, "esp,esp32-uart",
+		    esp32_uart_early_console_setup);
+
+static int __init esp32s3_uart_early_console_setup(struct earlycon_device *device,
+						   const char *options)
+{
+	device->port.private_data = (void *)&esp32s3_variant;
+	return esp32xx_uart_early_console_setup(device, options);
+}
+
+OF_EARLYCON_DECLARE(esp32s3uart, "esp,esp32s3-uart",
+		    esp32s3_uart_early_console_setup);
+
+static struct uart_driver esp32_uart_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= DRIVER_NAME,
+	.dev_name	= DEV_NAME,
+	.nr		= ARRAY_SIZE(esp32_uart_ports),
+	.cons		= &esp32_uart_console,
+};
+
+static int esp32_uart_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	static const struct of_device_id *match;
+	struct uart_port *port;
+	struct esp32_port *sport;
+	struct resource *res;
+	int ret;
+
+	match = of_match_device(esp32_uart_dt_ids, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	port = &sport->port;
+
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+	if (ret >= UART_NR) {
+		dev_err(&pdev->dev, "driver limited to %d serial ports\n",
+			UART_NR);
+		return -ENOMEM;
+	}
+
+	port->line = ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	port->mapbase = res->start;
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
+	sport->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sport->clk))
+		return PTR_ERR(sport->clk);
+
+	port->uartclk = clk_get_rate(sport->clk);
+	port->dev = &pdev->dev;
+	port->type = PORT_ESP32UART;
+	port->iotype = UPIO_MEM;
+	port->irq = platform_get_irq(pdev, 0);
+	port->ops = &esp32_uart_pops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->has_sysrq = 1;
+	port->fifosize = ESP32_UART_TX_FIFO_SIZE;
+	port->private_data = (void *)match->data;
+
+	esp32_uart_ports[port->line] = sport;
+
+	platform_set_drvdata(pdev, port);
+
+	ret = uart_add_one_port(&esp32_uart_reg, port);
+	return ret;
+}
+
+static int esp32_uart_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&esp32_uart_reg, port);
+
+	return 0;
+}
+
+
+static struct platform_driver esp32_uart_driver = {
+	.probe		= esp32_uart_probe,
+	.remove		= esp32_uart_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.of_match_table	= esp32_uart_dt_ids,
+	},
+};
+
+static int __init esp32_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&esp32_uart_reg);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&esp32_uart_driver);
+	if (ret)
+		uart_unregister_driver(&esp32_uart_reg);
+
+	return ret;
+}
+
+static void __exit esp32_uart_exit(void)
+{
+	platform_driver_unregister(&esp32_uart_driver);
+	uart_unregister_driver(&esp32_uart_reg);
+}
+
+module_init(esp32_uart_init);
+module_exit(esp32_uart_exit);
+
+MODULE_DESCRIPTION("Espressif ESP32 UART driver.");
+MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index add349889d0a..ff076d6be159 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -245,4 +245,7 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Espressif ESP32 UART */
+#define PORT_ESP32UART	124
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.30.2

