Return-Path: <linux-kernel+bounces-40292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFE383DDD4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8081F233FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AEF1D52B;
	Fri, 26 Jan 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL/vk/pg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9D1CF9A;
	Fri, 26 Jan 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283759; cv=none; b=Fs4nAK8i5tcKrzHCj8SSSxlGRGoWiy6EPbU3aJhJqcQuk7e9HQqwWvoe868gTsIoc5f6tXTjMZzhm/BU/zb1LA0Mg/EiPYF1vLy+KVyH9BH0+Jq/yvqNeyCmdSxhCbIMe7qCxj8XJNK8oO/SklHm160qs4zIS7lYpC4j0qTnJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283759; c=relaxed/simple;
	bh=+5D7LX6ejz+Gj3H4yPzXFxnsMfyPz22xKcDKIPcZdp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E80njj6ePesqcIPBwPKZ2pzTaGv5OjxpkQZV6BwdA9mKdzuFtuJ1jOYFlFAJmWjYM9ipQ48VkWMWBa83vAkLL4c/m+MPwsjDlKxY9PIj1U/gkgP8QMCFfJRXZlc1c3NyDrtxSYqvG42K+jgOVQW/Q9rAYInVNEhbWQ03f/nLKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL/vk/pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D67A5C43143;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283758;
	bh=+5D7LX6ejz+Gj3H4yPzXFxnsMfyPz22xKcDKIPcZdp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nL/vk/pg5uqedrulSV1G7pVCK2xIg4TwraXM9Ku6oFObHivz7t6ivi8zdgs0cVlUh
	 /uwmc4qwEFsfRLGWvQyIHD7HNjKQXo8IlNIDCo4U0YatdBA/bw2C8wn3ksuVWSU+68
	 xzSMMzQanxvrJNOFpJNVkzxDWGuMtwkZO1E2nasXiqWXti5rL7yYf46n89rC/UAc7t
	 ybJCFQs7fcXYUkINiqgk3RA6wNFawhHpZxpRE4i84Z0qCA3d68jimYhqGXRCdovb8c
	 i0bD+L6hpCJEg1K5kFnhhy9J8GmfbExv6CVK9O1VxSQEm+n2a3juNxWEln+qCH+vyl
	 iqUA4nFXW+DUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DEBC48260;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Date: Fri, 26 Jan 2024 16:42:05 +0100
Subject: [PATCH v5 3/3] w1: add UART w1 bus driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-w1-uart-v5-3-1d82bfdc2ae9@gmail.com>
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
In-Reply-To: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706283756; l=15651;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=fKRUx/fAE17gtqL5N58C2FYdqwv7GZBVaTAJVKwjKMc=;
 b=lQCAmkhK2BRPuTmxj4r/lrqBe2kmfYrbFitTOStmjfFhILVFeaKt7V5FE9Qo78/tQqZ94lV9L
 CDch0bA6BjHD5LuAqkBf00yxUp85+LxMGIMBkhSUc7xSt+gjrrI6njJ
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

From: Christoph Winklhofer <cj.winklhofer@gmail.com>

Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
the Serial Device Bus to create the 1-Wire timing patterns. The driver
was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
DART-6UL" with a DS18S20 temperature sensor.

The 1-Wire timing pattern and the corresponding UART baud-rate with the
interpretation of the transferred bytes are described in the document:

Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html

In short, the UART peripheral must support full-duplex and operate in
open-drain mode. The timing patterns are generated by a specific
combination of baud-rate and transmitted byte, which corresponds to a
1-Wire read bit, write bit or reset.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/w1/masters/index.rst   |   1 +
 Documentation/w1/masters/w1-uart.rst |  54 +++++
 drivers/w1/masters/Kconfig           |  10 +
 drivers/w1/masters/Makefile          |   1 +
 drivers/w1/masters/w1-uart.c         | 402 +++++++++++++++++++++++++++++++++++
 5 files changed, 468 insertions(+)

diff --git a/Documentation/w1/masters/index.rst b/Documentation/w1/masters/index.rst
index 4442a98850ad..cc40189909fd 100644
--- a/Documentation/w1/masters/index.rst
+++ b/Documentation/w1/masters/index.rst
@@ -12,3 +12,4 @@
    mxc-w1
    omap-hdq
    w1-gpio
+   w1-uart
diff --git a/Documentation/w1/masters/w1-uart.rst b/Documentation/w1/masters/w1-uart.rst
new file mode 100644
index 000000000000..8d0f122178d4
--- /dev/null
+++ b/Documentation/w1/masters/w1-uart.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=====================
+Kernel driver w1-uart
+=====================
+
+Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
+
+
+Description
+-----------
+
+UART 1-Wire bus driver. The driver utilizes the UART interface via the
+Serial Device Bus to create the 1-Wire timing patterns as described in
+the document `"Using a UART to Implement a 1-Wire Bus Master"`_.
+
+.. _"Using a UART to Implement a 1-Wire Bus Master": https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
+
+In short, the UART peripheral must support full-duplex and operate in
+open-drain mode. The timing patterns are generated by a specific
+combination of baud-rate and transmitted byte, which corresponds to a
+1-Wire read bit, write bit or reset pulse.
+
+For instance the timing pattern for a 1-Wire reset and presence detect uses
+the baud-rate 9600, i.e. 104.2 us per bit. The transmitted byte 0xf0 over
+UART (least significant bit first, start-bit low) sets the reset low time
+for 1-Wire to 521 us. A present 1-Wire device changes the received byte by
+pulling the line low, which is used by the driver to evaluate the result of
+the 1-Wire operation.
+
+Similar for a 1-Wire read bit or write bit, which uses the baud-rate
+115200, i.e. 8.7 us per bit. The transmitted byte 0x80 is used for a
+Write-0 operation (low time 69.6us) and the byte 0xff for Read-0, Read-1
+and Write-1 (low time 8.7us).
+
+The default baud-rate for reset and presence detection is 9600 and for
+a 1-Wire read or write operation 115200. In case the actual baud-rate
+is different from the requested one, the transmitted byte is adapted
+to generate the 1-Wire timing patterns.
+
+
+Usage
+-----
+
+Specify the UART 1-wire bus in the device tree by adding the single child
+onewire to the serial node (e.g. uart0). For example:
+::
+
+  @uart0 {
+    ...
+    onewire {
+      compatible = "w1-uart";
+    };
+  };
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 513c0b114337..e6049a75b35b 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -78,5 +78,15 @@ config W1_MASTER_SGI
 	  This support is also available as a module.  If so, the module
 	  will be called sgi_w1.
 
+config W1_MASTER_UART
+	tristate "UART 1-wire driver"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here if you want to communicate with your 1-wire devices using
+	  UART interface.
+
+	  This support is also available as a module.  If so, the module
+	  will be called w1-uart.
+
 endmenu
 
diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
index 6c5a21f9b88c..227f80987e69 100644
--- a/drivers/w1/masters/Makefile
+++ b/drivers/w1/masters/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_W1_MASTER_MXC)		+= mxc_w1.o
 obj-$(CONFIG_W1_MASTER_GPIO)		+= w1-gpio.o
 obj-$(CONFIG_HDQ_MASTER_OMAP)		+= omap_hdq.o
 obj-$(CONFIG_W1_MASTER_SGI)		+= sgi_w1.o
+obj-$(CONFIG_W1_MASTER_UART)		+= w1-uart.o
diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
new file mode 100644
index 000000000000..2dc5e5266638
--- /dev/null
+++ b/drivers/w1/masters/w1-uart.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * w1-uart - UART 1-Wire bus driver
+ *
+ * Uses the UART interface (via Serial Device Bus) to create the 1-Wire
+ * timing patterns. Implements the following 1-Wire master interface:
+ *
+ * - reset_bus: requests baud-rate 9600
+ *
+ * - touch_bit: requests baud-rate 115200
+ *
+ * Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <linux/w1.h>
+
+/* UART packet contains start and stop bit */
+#define W1_UART_BITS_PER_PACKET (BITS_PER_BYTE + 2)
+
+#define W1_UART_TIMEOUT msecs_to_jiffies(500)
+
+/*
+ * struct w1_uart_config - configuration for 1-Wire operation
+ *
+ * @baudrate: baud-rate returned from serdev
+ * @delay_us: delay to complete a 1-Wire cycle (in us)
+ * @tx_byte: byte to generate 1-Wire timing pattern
+ */
+struct w1_uart_config {
+	unsigned int baudrate;
+	unsigned int delay_us;
+	u8 tx_byte;
+};
+
+struct w1_uart_device {
+	struct serdev_device *serdev;
+	struct w1_bus_master bus;
+
+	struct w1_uart_config cfg_reset;
+	struct w1_uart_config cfg_touch_0;
+	struct w1_uart_config cfg_touch_1;
+
+	struct completion rx_byte_received;
+	int rx_err;
+	u8 rx_byte;
+
+	struct mutex mutex;
+};
+
+/*
+ * struct w1_uart_limits - limits for 1-Wire operations
+ *
+ * @baudrate: Requested baud-rate to create 1-Wire timing pattern
+ * @bit_min_us: minimum time for a bit (in us)
+ * @bit_max_us: maximum time for a bit (in us)
+ * @sample_us: timespan to sample 1-Wire response
+ * @cycle_us: duration of the 1-Wire cycle
+ */
+struct w1_uart_limits {
+	unsigned int baudrate;
+	unsigned int bit_min_us;
+	unsigned int bit_max_us;
+	unsigned int sample_us;
+	unsigned int cycle_us;
+};
+
+static inline unsigned int baud_to_bit_ns(unsigned int baud)
+{
+	return NSEC_PER_SEC / baud;
+}
+
+static inline unsigned int to_ns(unsigned int us)
+{
+	return us * NSEC_PER_USEC;
+}
+
+/*
+ * Set baud-rate, delay and tx-byte to create a 1-Wire pulse and adapt
+ * the tx-byte according to the actual baud-rate.
+ *
+ * Reject when:
+ * - time for a bit outside min/max range
+ * - a 1-Wire response is not detectable for sent byte
+ */
+static int w1_uart_set_config(struct serdev_device *serdev,
+			      const struct w1_uart_limits *limits,
+			      struct w1_uart_config *w1cfg)
+{
+	unsigned int packet_ns;
+	unsigned int bits_low;
+	unsigned int bit_ns;
+	unsigned int low_ns;
+
+	w1cfg->baudrate = serdev_device_set_baudrate(serdev, limits->baudrate);
+	if (w1cfg->baudrate == 0)
+		return -EINVAL;
+
+	/* Compute in nanoseconds for accuracy */
+	bit_ns = baud_to_bit_ns(w1cfg->baudrate);
+	bits_low = to_ns(limits->bit_min_us) / bit_ns;
+	/* start bit is always low */
+	low_ns = bit_ns * (bits_low + 1);
+
+	if (low_ns < to_ns(limits->bit_min_us))
+		return -EINVAL;
+
+	if (low_ns > to_ns(limits->bit_max_us))
+		return -EINVAL;
+
+	/* 1-Wire response detectable for sent byte */
+	if (limits->sample_us > 0 &&
+	    bit_ns * BITS_PER_BYTE < low_ns + to_ns(limits->sample_us))
+		return -EINVAL;
+
+	/* delay: 1-Wire cycle takes longer than the UART packet */
+	packet_ns = bit_ns * W1_UART_BITS_PER_PACKET;
+	w1cfg->delay_us = 0;
+	if (to_ns(limits->cycle_us) > packet_ns)
+		w1cfg->delay_us =
+			(to_ns(limits->cycle_us) - packet_ns) / NSEC_PER_USEC;
+
+	/* byte to create 1-Wire pulse */
+	w1cfg->tx_byte = 0xff << bits_low;
+
+	return 0;
+}
+
+/*
+ * Configuration for reset and presence detect
+ * - bit_min_us is 480us, add margin and use 485us
+ * - limits for sample time 60us-75us, use 65us
+ */
+static int w1_uart_set_config_reset(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	struct device_node *np = serdev->dev.of_node;
+
+	struct w1_uart_limits limits = { .baudrate = 9600,
+					 .bit_min_us = 485,
+					 .bit_max_us = 640,
+					 .sample_us = 65,
+					 .cycle_us = 960 };
+
+	of_property_read_u32(np, "reset-bps", &limits.baudrate);
+
+	return w1_uart_set_config(serdev, &limits, &w1dev->cfg_reset);
+}
+
+/*
+ * Configuration for write-0 cycle (touch bit 0)
+ * - bit_min_us is 60us, add margin and use 65us
+ * - no sampling required, sample_us = 0
+ */
+static int w1_uart_set_config_touch_0(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	struct device_node *np = serdev->dev.of_node;
+
+	struct w1_uart_limits limits = { .baudrate = 115200,
+					 .bit_min_us = 65,
+					 .bit_max_us = 120,
+					 .sample_us = 0,
+					 .cycle_us = 70 };
+
+	of_property_read_u32(np, "write-0-bps", &limits.baudrate);
+
+	return w1_uart_set_config(serdev, &limits, &w1dev->cfg_touch_0);
+}
+
+/*
+ * Configuration for write-1 and read cycle (touch bit 1)
+ * - bit_min_us is 5us, add margin and use 6us
+ * - limits for sample time 5us-15us, use 15us
+ */
+static int w1_uart_set_config_touch_1(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	struct device_node *np = serdev->dev.of_node;
+
+	struct w1_uart_limits limits = { .baudrate = 115200,
+					 .bit_min_us = 6,
+					 .bit_max_us = 15,
+					 .sample_us = 15,
+					 .cycle_us = 70 };
+
+	of_property_read_u32(np, "write-1-bps", &limits.baudrate);
+
+	return w1_uart_set_config(serdev, &limits, &w1dev->cfg_touch_1);
+}
+
+/*
+ * Configure and open the serial device
+ */
+static int w1_uart_serdev_open(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	struct device *dev = &serdev->dev;
+	int ret;
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret < 0)
+		return ret;
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret < 0) {
+		dev_err(dev, "set parity failed\n");
+		return ret;
+	}
+
+	ret = w1_uart_set_config_reset(w1dev);
+	if (ret < 0) {
+		dev_err(dev, "config for reset failed\n");
+		return ret;
+	}
+
+	ret = w1_uart_set_config_touch_0(w1dev);
+	if (ret < 0) {
+		dev_err(dev, "config for touch-0 failed\n");
+		return ret;
+	}
+
+	ret = w1_uart_set_config_touch_1(w1dev);
+	if (ret < 0) {
+		dev_err(dev, "config for touch-1 failed\n");
+		return ret;
+	}
+
+	serdev_device_set_flow_control(serdev, false);
+
+	return 0;
+}
+
+/*
+ * Send one byte (tx_byte) and read one byte (rx_byte) via serdev.
+ */
+static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
+				const struct w1_uart_config *w1cfg, u8 *rx_byte)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	int ret;
+
+	serdev_device_write_flush(serdev);
+	serdev_device_set_baudrate(serdev, w1cfg->baudrate);
+
+	/* write and immediately read one byte */
+	reinit_completion(&w1dev->rx_byte_received);
+	ret = serdev_device_write_buf(serdev, &w1cfg->tx_byte, 1);
+	if (ret != 1)
+		return -EIO;
+	ret = wait_for_completion_interruptible_timeout(
+		&w1dev->rx_byte_received, W1_UART_TIMEOUT);
+	if (ret <= 0)
+		return -EIO;
+
+	/* locking could fail during driver remove or when serdev is
+	 * unexpectedly in the receive callback.
+	 */
+	if (!mutex_trylock(&w1dev->mutex))
+		return -EIO;
+
+	ret = w1dev->rx_err;
+	if (ret == 0)
+		*rx_byte = w1dev->rx_byte;
+
+	if (w1cfg->delay_us > 0)
+		fsleep(w1cfg->delay_us);
+
+	mutex_unlock(&w1dev->mutex);
+
+	return ret;
+}
+
+static ssize_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
+					  const u8 *buf, size_t count)
+{
+	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
+
+	mutex_lock(&w1dev->mutex);
+
+	/* sent a single byte and receive one single byte */
+	if (count == 1) {
+		w1dev->rx_byte = buf[0];
+		w1dev->rx_err = 0;
+	} else {
+		w1dev->rx_err = -EIO;
+	}
+
+	mutex_unlock(&w1dev->mutex);
+	complete(&w1dev->rx_byte_received);
+
+	return count;
+}
+
+static const struct serdev_device_ops w1_uart_serdev_ops = {
+	.receive_buf = w1_uart_serdev_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+/*
+ * 1-wire reset and presence detect: A present slave will manipulate
+ * the received byte by pulling the 1-Wire low.
+ */
+static u8 w1_uart_reset_bus(void *data)
+{
+	struct w1_uart_device *w1dev = data;
+	const struct w1_uart_config *w1cfg = &w1dev->cfg_reset;
+	int ret;
+	u8 val;
+
+	ret = w1_uart_serdev_tx_rx(w1dev, w1cfg, &val);
+	if (ret < 0)
+		return -1;
+
+	/* Device present (0) or no device (1) */
+	return val != w1cfg->tx_byte ? 0 : 1;
+}
+
+/*
+ * 1-Wire read and write cycle: Only the read-0 manipulates the
+ * received byte, all others left the line untouched.
+ */
+static u8 w1_uart_touch_bit(void *data, u8 bit)
+{
+	struct w1_uart_device *w1dev = data;
+	const struct w1_uart_config *w1cfg = bit ? &w1dev->cfg_touch_1 :
+						   &w1dev->cfg_touch_0;
+	int ret;
+	u8 val;
+
+	ret = w1_uart_serdev_tx_rx(w1dev, w1cfg, &val);
+
+	/* return inactive bus state on error */
+	if (ret < 0)
+		return 1;
+
+	return val == w1cfg->tx_byte ? 1 : 0;
+}
+
+static int w1_uart_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct w1_uart_device *w1dev;
+	int ret;
+
+	w1dev = devm_kzalloc(dev, sizeof(*w1dev), GFP_KERNEL);
+	if (!w1dev)
+		return -ENOMEM;
+	w1dev->bus.data = w1dev;
+	w1dev->bus.reset_bus = w1_uart_reset_bus;
+	w1dev->bus.touch_bit = w1_uart_touch_bit;
+	w1dev->serdev = serdev;
+
+	init_completion(&w1dev->rx_byte_received);
+	mutex_init(&w1dev->mutex);
+
+	ret = w1_uart_serdev_open(w1dev);
+	if (ret < 0)
+		return ret;
+	serdev_device_set_drvdata(serdev, w1dev);
+	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
+
+	return w1_add_master_device(&w1dev->bus);
+}
+
+static void w1_uart_remove(struct serdev_device *serdev)
+{
+	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
+
+	mutex_lock(&w1dev->mutex);
+
+	w1_remove_master_device(&w1dev->bus);
+
+	mutex_unlock(&w1dev->mutex);
+}
+
+static const struct of_device_id w1_uart_of_match[] = {
+	{ .compatible = "w1-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, w1_uart_of_match);
+
+static struct serdev_device_driver w1_uart_driver = {
+	.driver	= {
+		.name		= "w1-uart",
+		.of_match_table = w1_uart_of_match,
+	},
+	.probe	= w1_uart_probe,
+	.remove	= w1_uart_remove,
+};
+
+module_serdev_device_driver(w1_uart_driver);
+
+MODULE_DESCRIPTION("UART w1 bus driver");
+MODULE_AUTHOR("Christoph Winklhofer <cj.winklhofer@gmail.com>");
+MODULE_LICENSE("GPL");

-- 
2.43.0


