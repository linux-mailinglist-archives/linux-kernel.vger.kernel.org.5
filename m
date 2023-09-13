Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3879F394
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjIMVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjIMVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:15:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD91BD1;
        Wed, 13 Sep 2023 14:15:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c06f6f98c0so1932705ad.3;
        Wed, 13 Sep 2023 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694639715; x=1695244515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra7QHeakAG3IqdMga1X/iNOVo977NmM+u0KVkS1eoU8=;
        b=Y5hg1jzYrO+/Ukr5+hqqHCYelP0BNSWnJjAmgGj46r4DodLwANWJ9ouTUslE+UVhAc
         1Cz4W1l4G5ZyQYqSieYdhzdvj4dQCuYAKRUNY83MnUVh6TX5Xjlh2uzxGOsPJ1EWUBLS
         +yjB8YMV96ZBXPk0LMggjqNF58h3gCushlyh/pE1JlurDHLUXaitzbqPXI+DNfF6ulJT
         HiBlCmbUSMrxSDaNe0ElY834g6Ph19u8cb8/yB5ZfDs6aiXJ/mfmolYnGkXV50EXajPl
         22awruquufC2Ew3XSV1V5FYyRPl5P8efC3JWOH2yPaRTJQH3+D53pmWmiq0C0INXmzYw
         pimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639715; x=1695244515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra7QHeakAG3IqdMga1X/iNOVo977NmM+u0KVkS1eoU8=;
        b=d87rL7dQA77MEvIEN9l920iB+X6CVwihPIfWTjxvhWJc+us0EZxN/ysP1pytwMeK9v
         wk5YvstD1kNYnZf/nH1APThQ4kBAxy7QefikXg0OI3szTqFb6cDgeotzqYc+lNn5gEZS
         UuhB0qziL5lg5yTnGsc9ViD3pTgZj6zeQuyGK1CBZ/Hygu1f5vf886gxhvZQAfAu6wg7
         FpIKnW1mpsstYeEfOSvlgg6eR9814aJTeye0Mujq0UZciu/zvA0V6RCfEPK7papCBO2M
         NkbKj61L8Ae1OJYelxhcMpmC6WYH04nsWx0GeLsstHLcOQ4JhXhNQfqvYzDZuF5ENWck
         Z9xQ==
X-Gm-Message-State: AOJu0YzWRf36TK1cQJaUsPiGSAv8hXt161zJLCifi4zBqSv+kTDTFyUY
        JBuFVjLko60/3AFLfWxTNlqScEI7U9E=
X-Google-Smtp-Source: AGHT+IG2YPHiqeP1+YLf7bj27GO8lcutJTqXp9H8KqegqC4W9CtvPO7ALpr8f+vvC+qZQSppKFMsbg==
X-Received: by 2002:a17:902:e5c7:b0:1c3:eaa0:dc5 with SMTP id u7-20020a170902e5c700b001c3eaa00dc5mr3345336plf.26.1694639715126;
        Wed, 13 Sep 2023 14:15:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:82b1:d7c2:2eaf:61e7])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b8c689060dsm73707plh.28.2023.09.13.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:15:14 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/4] drivers/tty/serial: add ESP32S3 ACM device driver
Date:   Wed, 13 Sep 2023 14:14:49 -0700
Message-Id: <20230913211449.668796-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913211449.668796-1-jcmvbkbc@gmail.com>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the ACM  controller of the Espressif ESP32S3 Soc.
Hardware specification is available at the following URL:

  https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
  (Chapter 33 USB Serial/JTAG Controller)

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/tty/serial/Kconfig       |  14 +
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/esp32_acm.c   | 473 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 491 insertions(+)
 create mode 100644 drivers/tty/serial/esp32_acm.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d9ca6b268f01..85807db8f7ce 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1591,6 +1591,20 @@ config SERIAL_ESP32
 	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
 	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
 
+config SERIAL_ESP32_ACM
+	tristate "Espressif ESP32 USB ACM support"
+	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Driver for the CDC ACM controllers of the Espressif ESP32S3 SoCs
+	  that share separate USB controller with the JTAG adapter.
+	  The device name used for this controller is ttyACM.
+	  When earlycon option is enabled the following kernel command line
+	  snippet may be used:
+	    earlycon=esp32s3acm,mmio32,0x60038000
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 7b73137df7f3..970a292ca418 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
 obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
 obj-$(CONFIG_SERIAL_ESP32)	+= esp32_uart.o
+obj-$(CONFIG_SERIAL_ESP32_ACM)	+= esp32_acm.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
new file mode 100644
index 000000000000..f178e6af93f3
--- /dev/null
+++ b/drivers/tty/serial/esp32_acm.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+#define DRIVER_NAME	"esp32s3-acm"
+#define DEV_NAME	"ttyACM"
+#define UART_NR		4
+
+#define ESP32S3_ACM_TX_FIFO_SIZE	64
+
+#define USB_SERIAL_JTAG_EP1_REG		0x00
+#define USB_SERIAL_JTAG_EP1_CONF_REG	0x04
+#define USB_SERIAL_JTAG_WR_DONE_MASK				0x00000001
+#define USB_SERIAL_JTAG_SERIAL_IN_EP_DATA_FREE_MASK		0x00000002
+#define USB_SERIAL_JTAG_SERIAL_OUT_EP_DATA_AVAIL_MASK		0x00000008
+#define USB_SERIAL_JTAG_INT_ST_REG	0x0c
+#define USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST_MASK		0x00000004
+#define USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST_MASK		0x00000008
+#define USB_SERIAL_JTAG_INT_ENA_REG	0x10
+#define USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA_MASK	0x00000004
+#define USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA_MASK		0x00000008
+#define USB_SERIAL_JTAG_INT_CLR_REG	0x14
+#define USB_SERIAL_JTAG_IN_EP1_ST_REG	0x2c
+#define USB_SERIAL_JTAG_IN_EP1_WR_ADDR_MASK			0x000001fc
+#define USB_SERIAL_JTAG_IN_EP1_WR_ADDR_SHIFT			2
+#define USB_SERIAL_JTAG_OUT_EP1_ST_REG	0x3c
+#define USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT_MASK		0x007f0000
+#define USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT_SHIFT		16
+
+static const struct of_device_id esp32s3_acm_dt_ids[] = {
+	{
+		.compatible = "esp,esp32s3-acm",
+	}, { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, esp32s3_acm_dt_ids);
+
+static struct uart_port *esp32s3_acm_ports[UART_NR];
+
+static void esp32s3_acm_write(struct uart_port *port, unsigned long reg, u32 v)
+{
+	writel(v, port->membase + reg);
+}
+
+static u32 esp32s3_acm_read(struct uart_port *port, unsigned long reg)
+{
+	return readl(port->membase + reg);
+}
+
+static u32 esp32s3_acm_tx_fifo_free(struct uart_port *port)
+{
+	return esp32s3_acm_read(port, USB_SERIAL_JTAG_EP1_CONF_REG) &
+		USB_SERIAL_JTAG_SERIAL_IN_EP_DATA_FREE_MASK;
+}
+
+static u32 esp32s3_acm_tx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_IN_EP1_ST_REG);
+
+	return (status & USB_SERIAL_JTAG_IN_EP1_WR_ADDR_MASK) >>
+		USB_SERIAL_JTAG_IN_EP1_WR_ADDR_SHIFT;
+}
+
+static u32 esp32s3_acm_rx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_OUT_EP1_ST_REG);
+
+	return (status & USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT_MASK) >>
+		USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT_SHIFT;
+}
+
+/* return TIOCSER_TEMT when transmitter is not busy */
+static unsigned int esp32s3_acm_tx_empty(struct uart_port *port)
+{
+	return esp32s3_acm_tx_fifo_cnt(port) == 0 ? TIOCSER_TEMT : 0;
+}
+
+static void esp32s3_acm_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static unsigned int esp32s3_acm_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CAR;
+}
+
+static void esp32s3_acm_stop_tx(struct uart_port *port)
+{
+	u32 int_ena;
+
+	int_ena = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ENA_REG);
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
+			  int_ena & ~USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA_MASK);
+}
+
+static void esp32s3_acm_rxint(struct uart_port *port)
+{
+	struct tty_port *tty_port = &port->state->port;
+	u32 rx_fifo_cnt = esp32s3_acm_rx_fifo_cnt(port);
+	unsigned long flags;
+	u32 i;
+
+	if (!rx_fifo_cnt)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	for (i = 0; i < rx_fifo_cnt; ++i) {
+		u32 rx = esp32s3_acm_read(port, USB_SERIAL_JTAG_EP1_REG);
+
+		++port->icount.rx;
+		tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	tty_flip_buffer_push(tty_port);
+}
+
+static void esp32s3_acm_push(struct uart_port *port)
+{
+	if (esp32s3_acm_tx_fifo_free(port))
+		esp32s3_acm_write(port, USB_SERIAL_JTAG_EP1_CONF_REG,
+				  USB_SERIAL_JTAG_WR_DONE_MASK);
+}
+
+static void esp32s3_acm_put_char(struct uart_port *port, unsigned char c)
+{
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_EP1_REG, c);
+}
+
+static void esp32s3_acm_put_char_sync(struct uart_port *port, unsigned char c)
+{
+	while (!esp32s3_acm_tx_fifo_free(port))
+		cpu_relax();
+	esp32s3_acm_put_char(port, c);
+	esp32s3_acm_push(port);
+}
+
+static void esp32s3_acm_transmit_buffer(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	u32 tx_fifo_used = esp32s3_acm_tx_fifo_cnt(port);
+
+	if (esp32s3_acm_tx_fifo_free(port)) {
+		while (!uart_circ_empty(xmit) && tx_fifo_used < ESP32S3_ACM_TX_FIFO_SIZE) {
+			esp32s3_acm_put_char(port, xmit->buf[xmit->tail]);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			port->icount.tx++;
+			++tx_fifo_used;
+		}
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit)) {
+		esp32s3_acm_stop_tx(port);
+	} else {
+		u32 int_ena;
+
+		int_ena = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ENA_REG);
+		esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
+				  int_ena | USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA_MASK);
+	}
+
+	if (tx_fifo_used > 0 && tx_fifo_used < ESP32S3_ACM_TX_FIFO_SIZE)
+		esp32s3_acm_write(port, USB_SERIAL_JTAG_EP1_CONF_REG,
+				  USB_SERIAL_JTAG_WR_DONE_MASK);
+}
+
+static void esp32s3_acm_txint(struct uart_port *port)
+{
+	esp32s3_acm_transmit_buffer(port);
+}
+
+static irqreturn_t esp32s3_acm_int(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	u32 status;
+
+	status = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ST_REG);
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_CLR_REG, status);
+
+	if (status & USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST_MASK)
+		esp32s3_acm_rxint(port);
+	if (status & USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST_MASK)
+		esp32s3_acm_txint(port);
+
+	return IRQ_HANDLED;
+}
+
+static void esp32s3_acm_start_tx(struct uart_port *port)
+{
+	esp32s3_acm_transmit_buffer(port);
+}
+
+static void esp32s3_acm_stop_rx(struct uart_port *port)
+{
+	u32 int_ena;
+
+	int_ena = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ENA_REG);
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
+			  int_ena & ~USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA_MASK);
+}
+
+static int esp32s3_acm_startup(struct uart_port *port)
+{
+	int ret = 0;
+
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
+			  USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA_MASK);
+	ret = devm_request_irq(port->dev, port->irq, esp32s3_acm_int, 0,
+			       DRIVER_NAME, port);
+	return ret;
+}
+
+static void esp32s3_acm_shutdown(struct uart_port *port)
+{
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG, 0);
+	devm_free_irq(port->dev, port->irq, port);
+}
+
+static void esp32s3_acm_set_termios(struct uart_port *port,
+				    struct ktermios *termios,
+				    const struct ktermios *old)
+{
+}
+
+static const char *esp32s3_acm_type(struct uart_port *port)
+{
+	return "ESP32S3 ACM";
+}
+
+/* configure/auto-configure the port */
+static void esp32s3_acm_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_ESP32ACM;
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static void esp32s3_acm_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	esp32s3_acm_put_char_sync(port, c);
+}
+
+static int esp32s3_acm_poll_get_char(struct uart_port *port)
+{
+	if (esp32s3_acm_rx_fifo_cnt(port))
+		return esp32s3_acm_read(port, USB_SERIAL_JTAG_EP1_REG);
+	else
+		return NO_POLL_CHAR;
+
+}
+#endif
+
+static const struct uart_ops esp32s3_acm_pops = {
+	.tx_empty	= esp32s3_acm_tx_empty,
+	.set_mctrl	= esp32s3_acm_set_mctrl,
+	.get_mctrl	= esp32s3_acm_get_mctrl,
+	.stop_tx	= esp32s3_acm_stop_tx,
+	.start_tx	= esp32s3_acm_start_tx,
+	.stop_rx	= esp32s3_acm_stop_rx,
+	.startup	= esp32s3_acm_startup,
+	.shutdown	= esp32s3_acm_shutdown,
+	.set_termios	= esp32s3_acm_set_termios,
+	.type		= esp32s3_acm_type,
+	.config_port	= esp32s3_acm_config_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_put_char	= esp32s3_acm_poll_put_char,
+	.poll_get_char	= esp32s3_acm_poll_get_char,
+#endif
+};
+
+static void esp32s3_acm_console_putchar(struct uart_port *port, unsigned char c)
+{
+	esp32s3_acm_put_char_sync(port, c);
+}
+
+static void esp32s3_acm_string_write(struct uart_port *port, const char *s,
+				     unsigned int count)
+{
+	uart_console_write(port, s, count, esp32s3_acm_console_putchar);
+}
+
+static void
+esp32s3_acm_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_port *port = esp32s3_acm_ports[co->index];
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
+	esp32s3_acm_string_write(port, s, count);
+
+	if (locked)
+		spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct uart_driver esp32s3_acm_reg;
+static struct console esp32s3_acm_console = {
+	.name		= DEV_NAME,
+	.write		= esp32s3_acm_console_write,
+	.device		= uart_console_device,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &esp32s3_acm_reg,
+};
+
+static void esp32s3_acm_earlycon_putchar(struct uart_port *port, unsigned char c)
+{
+	esp32s3_acm_put_char_sync(port, c);
+}
+
+static void esp32s3_acm_earlycon_write(struct console *con, const char *s,
+				      unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, esp32s3_acm_earlycon_putchar);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int esp32s3_acm_earlycon_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	int num_read = 0;
+
+	while (num_read < n) {
+		int c = esp32s3_acm_poll_get_char(&dev->port);
+
+		if (c == NO_POLL_CHAR)
+			break;
+		s[num_read++] = c;
+	}
+	return num_read;
+}
+#endif
+
+static int __init esp32s3_acm_early_console_setup(struct earlycon_device *device,
+						   const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = esp32s3_acm_earlycon_write;
+#ifdef CONFIG_CONSOLE_POLL
+	device->con->read = esp32s3_acm_earlycon_read;
+#endif
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(esp32s3acm, "esp,esp32s3-acm",
+		    esp32s3_acm_early_console_setup);
+
+static struct uart_driver esp32s3_acm_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= DRIVER_NAME,
+	.dev_name	= DEV_NAME,
+	.nr		= ARRAY_SIZE(esp32s3_acm_ports),
+	.cons		= &esp32s3_acm_console,
+};
+
+static int esp32s3_acm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct uart_port *port;
+	struct resource *res;
+	int ret;
+
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
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
+	port->dev = &pdev->dev;
+	port->type = PORT_ESP32ACM;
+	port->iotype = UPIO_MEM;
+	port->irq = platform_get_irq(pdev, 0);
+	port->ops = &esp32s3_acm_pops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->has_sysrq = 1;
+	port->fifosize = ESP32S3_ACM_TX_FIFO_SIZE;
+
+	esp32s3_acm_ports[port->line] = port;
+
+	platform_set_drvdata(pdev, port);
+
+	ret = uart_add_one_port(&esp32s3_acm_reg, port);
+	return ret;
+}
+
+static int esp32s3_acm_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&esp32s3_acm_reg, port);
+	return 0;
+}
+
+
+static struct platform_driver esp32s3_acm_driver = {
+	.probe		= esp32s3_acm_probe,
+	.remove		= esp32s3_acm_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.of_match_table	= esp32s3_acm_dt_ids,
+	},
+};
+
+static int __init esp32s3_acm_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&esp32s3_acm_reg);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&esp32s3_acm_driver);
+	if (ret)
+		uart_unregister_driver(&esp32s3_acm_reg);
+
+	return ret;
+}
+
+static void __exit esp32s3_acm_exit(void)
+{
+	platform_driver_unregister(&esp32s3_acm_driver);
+	uart_unregister_driver(&esp32s3_acm_reg);
+}
+
+module_init(esp32s3_acm_init);
+module_exit(esp32s3_acm_exit);
+
+MODULE_DESCRIPTION("Espressif ESP32S3 USB ACM driver.");
+MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index ff076d6be159..1045bf096837 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -248,4 +248,7 @@
 /* Espressif ESP32 UART */
 #define PORT_ESP32UART	124
 
+/* Espressif ESP32 ACM */
+#define PORT_ESP32ACM	125
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.30.2

