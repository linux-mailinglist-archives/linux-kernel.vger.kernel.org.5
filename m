Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B57BF6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJJJAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJJI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:59:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF53B6;
        Tue, 10 Oct 2023 01:59:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c7373cff01so47184175ad.1;
        Tue, 10 Oct 2023 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696928382; x=1697533182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N5APtimwj2+roJc3MYRzOc/TcU5zlnnJVZ6QBv4p44=;
        b=PC/xp5IlqyDcM7Otnh5VIYo1L/3X6o7CK1n8PdyP7ejhtoLun2b7fSv6d5DfXbUtYV
         W8V1QA63ECWOznb3K6xs5H2kVwHXXohzt/HAHiVS3NzG0o3afk9EYPJf/gKAamM+vR8w
         nHyC5oFShhLS7cLYyUhPqizkISMNhswsL+0/JilAIC6CLcauHPHywtWxOvZigbUnopvC
         73kYO4ySaFF4t/i34HYOcDr1ZdzrsGF30UvKBSAwQkoSbOzPANPX3UHtxj2fhmC5S4sJ
         r14zbu9AKiMIKR+IyzwLCFIECZkruMeccCDF3G6aapkaSYuoUlP7wanljUpwh6RBZRzt
         fw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928382; x=1697533182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N5APtimwj2+roJc3MYRzOc/TcU5zlnnJVZ6QBv4p44=;
        b=sYlUrhCkxEBn9Dc07+8GneLJNStbYrMbe2FeArurzUQq7APMqDq9O89n9s7jTDSwl+
         pJIU+ZxMdAS/p/XckhZAXvhnrDaeeDUNb67ivNiLiiZszWBZYROQGjum3YmSLuuX4c6X
         E9PRIMmPEb7DXqEFWnDaVUMLDEUbA7oJKSV+7nKgI+7oFfu/gXTzjligTd3RKRxZ4bcf
         4uRoKIxDQen5zBpR9NhuNuyZDK+3mphSVAKbLZiNwGVsqvneuaQpBRRPxp4p2PebI58m
         Yghp0rOdz9D1XMFR+6c63tPr60uGHWDU2s8FCJfpn8v/sJeBoArYUy9DEZvkUm/JRThY
         pggw==
X-Gm-Message-State: AOJu0YwtnZlNpPoaoN6CCvSzYDyqSXR5AZZjNbYGLJ9+n6RlEGw9stOg
        594gCqBzgEDgbci2zdE1TuS9f8uTGCk=
X-Google-Smtp-Source: AGHT+IEylAeBCkJlO38T4nP2awtInP9oNV9Hb+gog4E0F2SEkWJNmmqm08TWyNNF1EISxx71ErnXuA==
X-Received: by 2002:a17:90b:4d8b:b0:27c:df02:88b3 with SMTP id oj11-20020a17090b4d8b00b0027cdf0288b3mr2803824pjb.8.1696928382132;
        Tue, 10 Oct 2023 01:59:42 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:f462:7ab2:1aaa:db73])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a3d4c00b0027782f611d1sm12542731pjf.36.2023.10.10.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:59:41 -0700 (PDT)
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
Subject: [PATCH v5 5/5] drivers/tty/serial: add ESP32S3 ACM gadget driver
Date:   Tue, 10 Oct 2023 01:59:26 -0700
Message-Id: <20231010085926.1021667-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
References: <20231010085926.1021667-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the ACM gadget controller of the Espressif ESP32S3 SoC.
Hardware specification is available at the following URL:

  https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
  (Chapter 33 USB Serial/JTAG Controller)

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v4->v5:
- fix commit message formatting
- rename device from ttyACM to ttyiGS
- drop ttyACM device name mention from the Kconfig entry help
- use PORT_GENERIC instead of unique PORT_ESP32ACM
- add the word 'gadget' to the commit description and to Kconfig text
  to make it more consistent with linux terminology

Changes v2->v3:
- use HZ instead of msecs_to_jiffies(1000) in esp32_acm_put_char_sync
- add early return to esp32_acm_transmit_buffer
- use request_irq/free_irq instead of devm_* versions

Changes v1->v2:
- redefine register fields using BIT and GENMASK
- drop _MASK suffix from register field definitions
- drop *_SHIFT definitions where possible
- split register reads/writes and bitwise operations into multiple lines
- use u8 instead of unsigned char in internal functions
- add timeout to esp32_acm_put_char_sync
- use uart_port_tx_limited in esp32_acm_transmit_buffer
- use IRQ_RETVAL in esp32_acm_int
- drop esp32s3_acm_console_putchar and esp32s3_acm_earlycon_putchar
- turn num_read into unsigned int in esp32_acm_earlycon_read
- drop MODULE_DESCRIPTION

 drivers/tty/serial/Kconfig     |  13 +
 drivers/tty/serial/Makefile    |   1 +
 drivers/tty/serial/esp32_acm.c | 459 +++++++++++++++++++++++++++++++++
 3 files changed, 473 insertions(+)
 create mode 100644 drivers/tty/serial/esp32_acm.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d9ca6b268f01..732c893c8d16 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1591,6 +1591,19 @@ config SERIAL_ESP32
 	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
 	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
 
+config SERIAL_ESP32_ACM
+	tristate "Espressif ESP32 USB ACM gadget support"
+	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Driver for the CDC ACM gadget controller of the Espressif ESP32S3
+	  SoCs that share separate USB controller with the JTAG adapter.
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
index 000000000000..cb28a87736aa
--- /dev/null
+++ b/drivers/tty/serial/esp32_acm.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
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
+#define DRIVER_NAME	"esp32s3-acm"
+#define DEV_NAME	"ttyGS"
+#define UART_NR		4
+
+#define ESP32S3_ACM_TX_FIFO_SIZE	64
+
+#define USB_SERIAL_JTAG_EP1_REG		0x00
+#define USB_SERIAL_JTAG_EP1_CONF_REG	0x04
+#define USB_SERIAL_JTAG_WR_DONE				BIT(0)
+#define USB_SERIAL_JTAG_SERIAL_IN_EP_DATA_FREE		BIT(1)
+#define USB_SERIAL_JTAG_INT_ST_REG	0x0c
+#define USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST	BIT(2)
+#define USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST		BIT(3)
+#define USB_SERIAL_JTAG_INT_ENA_REG	0x10
+#define USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA	BIT(2)
+#define USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA		BIT(3)
+#define USB_SERIAL_JTAG_INT_CLR_REG	0x14
+#define USB_SERIAL_JTAG_IN_EP1_ST_REG	0x2c
+#define USB_SERIAL_JTAG_IN_EP1_WR_ADDR			GENMASK(8, 2)
+#define USB_SERIAL_JTAG_OUT_EP1_ST_REG	0x3c
+#define USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT		GENMASK(22, 16)
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
+	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_EP1_CONF_REG);
+
+	return status & USB_SERIAL_JTAG_SERIAL_IN_EP_DATA_FREE;
+}
+
+static u32 esp32s3_acm_tx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_IN_EP1_ST_REG);
+
+	return FIELD_GET(USB_SERIAL_JTAG_IN_EP1_WR_ADDR, status);
+}
+
+static u32 esp32s3_acm_rx_fifo_cnt(struct uart_port *port)
+{
+	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_OUT_EP1_ST_REG);
+
+	return FIELD_GET(USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT, status);
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
+	int_ena &= ~USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA;
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG, int_ena);
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
+				  USB_SERIAL_JTAG_WR_DONE);
+}
+
+static void esp32s3_acm_put_char(struct uart_port *port, u8 c)
+{
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_EP1_REG, c);
+}
+
+static void esp32s3_acm_put_char_sync(struct uart_port *port, u8 c)
+{
+	unsigned long timeout = jiffies + HZ;
+
+	while (!esp32s3_acm_tx_fifo_free(port)) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(port->dev, "timeout waiting for TX FIFO\n");
+			return;
+		}
+		cpu_relax();
+	}
+	esp32s3_acm_put_char(port, c);
+	esp32s3_acm_push(port);
+}
+
+static void esp32s3_acm_transmit_buffer(struct uart_port *port)
+{
+	u32 tx_fifo_used;
+	unsigned int pending;
+	u8 ch;
+
+	if (!esp32s3_acm_tx_fifo_free(port))
+		return;
+
+	tx_fifo_used = esp32s3_acm_tx_fifo_cnt(port);
+	pending = uart_port_tx_limited(port, ch,
+				       ESP32S3_ACM_TX_FIFO_SIZE - tx_fifo_used,
+				       true, esp32s3_acm_put_char(port, ch),
+				       ({}));
+	if (pending) {
+		u32 int_ena;
+
+		int_ena = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ENA_REG);
+		int_ena |= USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA;
+		esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG, int_ena);
+	}
+	esp32s3_acm_push(port);
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
+	if (status & USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST)
+		esp32s3_acm_rxint(port);
+	if (status & USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST)
+		esp32s3_acm_txint(port);
+
+	return IRQ_RETVAL(status);
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
+	int_ena &= ~USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA;
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG, int_ena);
+}
+
+static int esp32s3_acm_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = request_irq(port->irq, esp32s3_acm_int, 0, DRIVER_NAME, port);
+	if (ret)
+		return ret;
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
+			  USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA);
+
+	return 0;
+}
+
+static void esp32s3_acm_shutdown(struct uart_port *port)
+{
+	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG, 0);
+	free_irq(port->irq, port);
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
+		port->type = PORT_GENERIC;
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
+static void esp32s3_acm_string_write(struct uart_port *port, const char *s,
+				     unsigned int count)
+{
+	uart_console_write(port, s, count, esp32s3_acm_put_char_sync);
+}
+
+static void
+esp32s3_acm_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_port *port = esp32s3_acm_ports[co->index];
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
+static void esp32s3_acm_earlycon_write(struct console *con, const char *s,
+				      unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, esp32s3_acm_put_char_sync);
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static int esp32s3_acm_earlycon_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	unsigned int num_read = 0;
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
+	port->type = PORT_GENERIC;
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
+	return uart_add_one_port(&esp32s3_acm_reg, port);
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
+MODULE_AUTHOR("Max Filippov <jcmvbkbc@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.2

