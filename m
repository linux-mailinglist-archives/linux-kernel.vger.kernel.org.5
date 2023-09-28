Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4397B7B2159
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjI1Pas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjI1PaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:30:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526319F;
        Thu, 28 Sep 2023 08:30:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c735473d1aso9011135ad.1;
        Thu, 28 Sep 2023 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695915019; x=1696519819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9lgiJJUM5cRNI7nweoX+gRHVJ/2MGxvUTGA+9HJCuk=;
        b=P57lGWcqleGu8kjNiuOMPk4oFPV7CMH8tDf2/afUVbByD+APZd/uIoc611cyB28GVn
         dbv0Qek5OX7e+wTpw3LRyCGnVZLGe8omSwmBqNc6igL0x4oPOnERI8doY5oFgGYsg4Yx
         tE6AyZjMkvM40uHiUr+NAqeJAKWVO5mOf72BkrUP2kJpBJKEWehFEHgv3w7nDLRiRbeK
         zS2mez3c8bCxFaYW6S4JzysNgDcos91h/i2Oac9sq9V7TP+1cuTvDU9OS3dy5vc65Frw
         rPAJUT4kb8dy/Av0qObQcch6kveGXSO2kd8MVWv2tBHoMjQ5PqD9Abf5XyGoaL97Uaql
         DJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915019; x=1696519819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9lgiJJUM5cRNI7nweoX+gRHVJ/2MGxvUTGA+9HJCuk=;
        b=ZsGd39SHZa1NvMugnY2IYMRIOJ9CpQhIKuRnJGyXMQtHfJXp0lyJefuakcQvU4BOKL
         t1p992rgzrzzKKrZA/1BUWd60yCmoLUJUwCo2KIYt+7XKlX3P0Xe4n6COOOmtzvuUIeY
         gf3tzz6V1rBE3ElO6yWZbMDC0ArxW5YhOKYOPvYsP+NpJIuNOupJjZNtrw9anqLBEDVJ
         9hKb0VN7vSXeyR8g+GlVyrgjgVGEcGZKprhjSUYZvXJwHCRAsbViR9j2/5vAjTEYSEhl
         SSQlZMa/uvTzL5AFsIS8ssdxdTcEbH32rW/l1hsGRfqYOwDW1gmZ6IYfCWHEnrKqev1K
         L0cQ==
X-Gm-Message-State: AOJu0YxvttnzrNTcr3B7J4r5064oxEj0CKYzkq3Qn2m36YtagjD8CVYh
        3GoqZfXiOBIFiErF0y77Pl4o5zbsrWE=
X-Google-Smtp-Source: AGHT+IGKvD1f/aMLq2MFYD8njVA/udOczjWiyxZ0QaonYW0m/KRk5SG9ZT7SFpx3HwyM4/Da1dhlCA==
X-Received: by 2002:a17:90a:c28b:b0:26b:6095:bc3f with SMTP id f11-20020a17090ac28b00b0026b6095bc3fmr1402277pjt.33.1695915018856;
        Thu, 28 Sep 2023 08:30:18 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:a19c:f3d0:698d:f7a])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm3892318pjg.51.2023.09.28.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:30:18 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 3/5] drivers/tty/serial: add driver for the ESP32 UART
Date:   Thu, 28 Sep 2023 08:16:29 -0700
Message-Id: <20230928151631.149333-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230928151631.149333-1-jcmvbkbc@gmail.com>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes v2->v3:
- rework brk handling in esp32_uart_rxint
- only increment port->icount.rx in case insert_flip_char() is called
- use HZ instead of msecs_to_jiffies(1000) in esp32_uart_put_char_sync
- add early return to esp32_uart_transmit_buffer
- use request_irq/free_irq instead of devm_* versions
- add blank lines before certain return statements

Changes v1->v2:
- redefine register fields using BIT and GENMASK
- drop _MASK suffix from register field definitions
- drop *_SHIFT definitions where possible
- drop unused rxfifo_full_thrhd_mask and txfifo_empty_thrhd_mask
- split register reads/writes and bitwise operations into multiple lines
- use u8 instead of unsigned char in internal functions
- add timeout to esp32_uart_put_char_sync
- use uart_port_tx_limited in esp32_uart_transmit_buffer
- use IRQ_RETVAL in esp32_uart_int
- disable clock in esp32_uart_startup in case devm_request_irq fails
- rearrange devm_request_irq with enabling IRQs in the UART registers
- drop empty esp32_uart_release_port and esp32_uart_request_port
- simplify esp32_uart_tx_empty
- mask out unsupported CMSPAR flag in termios->c_cflag in
  esp32_uart_set_termios
- invoke uart_update_timeout in esp32_uart_set_termios
- drop MODULE_DESCRIPTION
- rearrange esp32_uart_set_baud: return bool indicating whether baud
  rate was set or not, use it in the esp32_uart_set_termios to set the
  default 115200
- turn 'locked' into bool in esp32_uart_console_write
- turn num_read into unsigned int in esp32_uart_earlycon_read

 drivers/tty/serial/Kconfig       |  13 +
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/esp32_uart.c  | 741 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 758 insertions(+)
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
index 000000000000..bb5471e8b6b6
--- /dev/null
+++ b/drivers/tty/serial/esp32_uart.c
@@ -0,0 +1,741 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
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
+#define UART_RXFIFO_FULL_INT			BIT(0)
+#define UART_TXFIFO_EMPTY_INT			BIT(1)
+#define UART_BRK_DET_INT			BIT(7)
+#define UART_CLKDIV_REG			0x14
+#define ESP32_UART_CLKDIV			GENMASK(19, 0)
+#define ESP32S3_UART_CLKDIV			GENMASK(11, 0)
+#define UART_CLKDIV_SHIFT			0
+#define UART_CLKDIV_FRAG			GENMASK(23, 20)
+#define UART_STATUS_REG			0x1c
+#define ESP32_UART_RXFIFO_CNT			GENMASK(7, 0)
+#define ESP32S3_UART_RXFIFO_CNT			GENMASK(9, 0)
+#define UART_RXFIFO_CNT_SHIFT			0
+#define UART_DSRN				BIT(13)
+#define UART_CTSN				BIT(14)
+#define ESP32_UART_TXFIFO_CNT			GENMASK(23, 16)
+#define ESP32S3_UART_TXFIFO_CNT			GENMASK(25, 16)
+#define UART_TXFIFO_CNT_SHIFT			16
+#define UART_CONF0_REG			0x20
+#define UART_PARITY				BIT(0)
+#define UART_PARITY_EN				BIT(1)
+#define UART_BIT_NUM				GENMASK(3, 2)
+#define UART_BIT_NUM_5				0
+#define UART_BIT_NUM_6				1
+#define UART_BIT_NUM_7				2
+#define UART_BIT_NUM_8				3
+#define UART_STOP_BIT_NUM			GENMASK(5, 4)
+#define UART_STOP_BIT_NUM_1			1
+#define UART_STOP_BIT_NUM_2			3
+#define UART_SW_RTS				BIT(6)
+#define UART_SW_DTR				BIT(7)
+#define UART_LOOPBACK				BIT(14)
+#define UART_TX_FLOW_EN				BIT(15)
+#define UART_RTS_INV				BIT(23)
+#define UART_DTR_INV				BIT(24)
+#define UART_CONF1_REG			0x24
+#define UART_RXFIFO_FULL_THRHD_SHIFT		0
+#define ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT	8
+#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT	10
+#define ESP32_UART_RX_FLOW_EN			BIT(23)
+#define ESP32S3_UART_RX_FLOW_EN			BIT(22)
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
+	u32 txfifo_empty_thrhd_shift;
+	u32 rx_flow_en;
+	const char *type;
+};
+
+static const struct esp32_uart_variant esp32_variant = {
+	.clkdiv_mask = ESP32_UART_CLKDIV,
+	.rxfifo_cnt_mask = ESP32_UART_RXFIFO_CNT,
+	.txfifo_cnt_mask = ESP32_UART_TXFIFO_CNT,
+	.txfifo_empty_thrhd_shift = ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_en = ESP32_UART_RX_FLOW_EN,
+	.type = "ESP32 UART",
+};
+
+static const struct esp32_uart_variant esp32s3_variant = {
+	.clkdiv_mask = ESP32S3_UART_CLKDIV,
+	.rxfifo_cnt_mask = ESP32S3_UART_RXFIFO_CNT,
+	.txfifo_cnt_mask = ESP32S3_UART_TXFIFO_CNT,
+	.txfifo_empty_thrhd_shift = ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT,
+	.rx_flow_en = ESP32S3_UART_RX_FLOW_EN,
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
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+
+	return (status & port_variant(port)->txfifo_cnt_mask) >> UART_TXFIFO_CNT_SHIFT;
+}
+
+static u32 esp32_uart_rx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+
+	return (status & port_variant(port)->rxfifo_cnt_mask) >> UART_RXFIFO_CNT_SHIFT;
+}
+
+/* return TIOCSER_TEMT when transmitter is not busy */
+static unsigned int esp32_uart_tx_empty(struct uart_port *port)
+{
+	return esp32_uart_tx_fifo_cnt(port) ? 0 : TIOCSER_TEMT;
+}
+
+static void esp32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 conf0 = esp32_uart_read(port, UART_CONF0_REG);
+
+	conf0 &= ~(UART_LOOPBACK |
+		   UART_SW_RTS | UART_RTS_INV |
+		   UART_SW_DTR | UART_DTR_INV);
+
+	if (mctrl & TIOCM_RTS)
+		conf0 |= UART_SW_RTS;
+	if (mctrl & TIOCM_DTR)
+		conf0 |= UART_SW_DTR;
+	if (mctrl & TIOCM_LOOP)
+		conf0 |= UART_LOOPBACK;
+
+	esp32_uart_write(port, UART_CONF0_REG, conf0);
+}
+
+static unsigned int esp32_uart_get_mctrl(struct uart_port *port)
+{
+	u32 status = esp32_uart_read(port, UART_STATUS_REG);
+	unsigned int ret = TIOCM_CAR;
+
+	if (status & UART_DSRN)
+		ret |= TIOCM_DSR;
+	if (status & UART_CTSN)
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
+	int_ena &= ~UART_TXFIFO_EMPTY_INT;
+	esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
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
+
+		if (!rx &&
+		    (esp32_uart_read(port, UART_INT_ST_REG) & UART_BRK_DET_INT)) {
+			esp32_uart_write(port, UART_INT_CLR_REG, UART_BRK_DET_INT);
+			++port->icount.brk;
+			uart_handle_break(port);
+		} else {
+			if (uart_handle_sysrq_char(port, (unsigned char)rx))
+				continue;
+			tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
+			++port->icount.rx;
+		}
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	tty_flip_buffer_push(tty_port);
+}
+
+static void esp32_uart_put_char(struct uart_port *port, u8 c)
+{
+	esp32_uart_write(port, UART_FIFO_REG, c);
+}
+
+static void esp32_uart_put_char_sync(struct uart_port *port, u8 c)
+{
+	unsigned long timeout = jiffies + HZ;
+
+	while (esp32_uart_tx_fifo_cnt(port) >= ESP32_UART_TX_FIFO_SIZE) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(port->dev, "timeout waiting for TX FIFO\n");
+			return;
+		}
+		cpu_relax();
+	}
+	esp32_uart_put_char(port, c);
+}
+
+static void esp32_uart_transmit_buffer(struct uart_port *port)
+{
+	u32 tx_fifo_used = esp32_uart_tx_fifo_cnt(port);
+	unsigned int pending;
+	u8 ch;
+
+	if (tx_fifo_used >= ESP32_UART_TX_FIFO_SIZE)
+		return;
+
+	pending = uart_port_tx_limited(port, ch,
+				       ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
+				       true, esp32_uart_put_char(port, ch),
+				       ({}));
+	if (pending) {
+		u32 int_ena;
+
+		int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
+		int_ena |= UART_TXFIFO_EMPTY_INT;
+		esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
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
+	if (status & (UART_RXFIFO_FULL_INT | UART_BRK_DET_INT))
+		esp32_uart_rxint(port);
+	if (status & UART_TXFIFO_EMPTY_INT)
+		esp32_uart_txint(port);
+
+	esp32_uart_write(port, UART_INT_CLR_REG, status);
+
+	return IRQ_RETVAL(status);
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
+	int_ena &= ~UART_RXFIFO_FULL_INT;
+	esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
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
+	ret = request_irq(port->irq, esp32_uart_int, 0, DRIVER_NAME, port);
+	if (ret) {
+		clk_disable_unprepare(sport->clk);
+		return ret;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+	esp32_uart_write(port, UART_CONF1_REG,
+			 (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
+			 (1 << port_variant(port)->txfifo_empty_thrhd_shift));
+	esp32_uart_write(port, UART_INT_CLR_REG, UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
+	esp32_uart_write(port, UART_INT_ENA_REG, UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return ret;
+}
+
+static void esp32_uart_shutdown(struct uart_port *port)
+{
+	struct esp32_port *sport = container_of(port, struct esp32_port, port);
+
+	esp32_uart_write(port, UART_INT_ENA_REG, 0);
+	free_irq(port->irq, port);
+	clk_disable_unprepare(sport->clk);
+}
+
+static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
+{
+	u32 div = port->uartclk / baud;
+	u32 frag = (port->uartclk * 16) / baud - div * 16;
+
+	if (div <= port_variant(port)->clkdiv_mask) {
+		esp32_uart_write(port, UART_CLKDIV_REG,
+				 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
+		return true;
+	}
+
+	return false;
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
+	termios->c_cflag &= ~CMSPAR;
+
+	baud = uart_get_baud_rate(port, termios, old,
+				  port->uartclk / port_variant(port)->clkdiv_mask,
+				  port->uartclk / 16);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	conf0 = esp32_uart_read(port, UART_CONF0_REG);
+	conf0 &= ~(UART_PARITY_EN | UART_PARITY | UART_BIT_NUM | UART_STOP_BIT_NUM);
+
+	conf1 = esp32_uart_read(port, UART_CONF1_REG);
+	conf1 &= ~rx_flow_en;
+
+	if (termios->c_cflag & PARENB) {
+		conf0 |= UART_PARITY_EN;
+		if (termios->c_cflag & PARODD)
+			conf0 |= UART_PARITY;
+	}
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_5);
+		break;
+	case CS6:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_6);
+		break;
+	case CS7:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_7);
+		break;
+	case CS8:
+		conf0 |= FIELD_PREP(UART_BIT_NUM, UART_BIT_NUM_8);
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		conf0 |= FIELD_PREP(UART_STOP_BIT_NUM, UART_STOP_BIT_NUM_2);
+	else
+		conf0 |= FIELD_PREP(UART_STOP_BIT_NUM, UART_STOP_BIT_NUM_1);
+
+	if (termios->c_cflag & CRTSCTS)
+		conf1 |= rx_flow_en;
+
+	esp32_uart_write(port, UART_CONF0_REG, conf0);
+	esp32_uart_write(port, UART_CONF1_REG, conf1);
+
+	if (baud) {
+		esp32_uart_set_baud(port, baud);
+		uart_update_timeout(port, termios->c_cflag, baud);
+	} else {
+		if (esp32_uart_set_baud(port, 115200)) {
+			baud = 115200;
+			tty_termios_encode_baud_rate(termios, baud, baud);
+			uart_update_timeout(port, termios->c_cflag, baud);
+		} else {
+			dev_warn(port->dev,
+				 "unable to set speed to %d baud or the default 115200\n",
+				 baud);
+		}
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *esp32_uart_type(struct uart_port *port)
+{
+	return port_variant(port)->type;
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
+	.config_port	= esp32_uart_config_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init	= esp32_uart_poll_init,
+	.poll_put_char	= esp32_uart_poll_put_char,
+	.poll_get_char	= esp32_uart_poll_get_char,
+#endif
+};
+
+static void esp32_uart_console_putchar(struct uart_port *port, u8 c)
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
+	bool locked = true;
+
+	if (port->sysrq)
+		locked = false;
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
+
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
+static void esp32_uart_earlycon_putchar(struct uart_port *port, u8 c)
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
+	unsigned int num_read = 0;
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
+
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
+
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
+		dev_err(&pdev->dev, "driver limited to %d serial ports\n", UART_NR);
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
+	return uart_add_one_port(&esp32_uart_reg, port);
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

