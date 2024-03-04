Return-Path: <linux-kernel+bounces-90570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C3870168
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52750287910
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBD3F8D3;
	Mon,  4 Mar 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6sIToEd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CA3D968;
	Mon,  4 Mar 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555451; cv=none; b=P21CqzKOkmrMQq+/GsU4wbCIq94G/M3oX+B2hWZr3CzWVjVBPMR7vDLzCQKB8fx4ZufB9tRwggGw4rbZw3DWJ/Hc5iR4IAMNKtQ6RI+Fp+ZbClCpeme9I5ARJd/VtNuTW6BSj+an2A3LnKkGiN5SLkhrj4ledczPbsw4fdmnKPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555451; c=relaxed/simple;
	bh=MzeE3/tXNoP+XePWQLaHjZ7JMNhfc4kTQ5ZC6sxw0R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD/wWsECvZJIVJlu/fOXs21WGfzkrkPzVkYIu6cqvvWW1cEIVyG00cUAGNUNzX6DCG8aufWlrAcjDhu3K20t+N4uOtoyJc0Ss2xtyajaiQAgnMSMPVVbfAEqB/pzT8GbUj7x/llebFszxrzsbilnko/JM1+zBZiPQV0z92cnbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6sIToEd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555450; x=1741091450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzeE3/tXNoP+XePWQLaHjZ7JMNhfc4kTQ5ZC6sxw0R8=;
  b=n6sIToEdEEtPs9Rh7TkeQYpI6KWVlUXBYBd17zxvKeZ0qz9IRZ1Xr9hq
   A0aXZbo03OEHWL5mrUh7Z7iFSiqKAWfKtMdsmW29+l7UtX/mKz/I/XfUF
   48pI6qkBQhExmrBntB+JDnX+gUv6l8Yo7S0i+vES5h1kMhKVS9FnAPv6R
   AzRWb/QHcDVJkjX2RZ584+nUnPWyUryfGkwgPfcAKBjmu+lvE6vsUmeqc
   88R0M3kvyz5CvyeHXiC6I9wSd25cI175FpHPOECrv0Q6bwSSAoi/pU1nB
   fPpwkT9+MCcjWHr8PT8cNTLQbJdDJs5MJJhE+qBvf7R50A2TYbbPhpx2O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815073"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815073"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040424"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040424"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 58ECA3F1; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 03/14] serial: port: Introduce a common helper to read properties
Date: Mon,  4 Mar 2024 14:27:04 +0200
Message-ID: <20240304123035.758700-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
References: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several serial drivers want to read the same or similar set of
the port properties. Make a common helper for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_port.c | 145 +++++++++++++++++++++++++++++++
 include/linux/serial_core.h      |   2 +
 2 files changed, 147 insertions(+)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 72b6f4f326e2..22b9eeb23e68 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -8,7 +8,10 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/spinlock.h>
 
@@ -105,6 +108,148 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
+/**
+ * __uart_read_properties - read firmware properties of the given UART port
+ * @port: corresponding port
+ * @use_defaults: apply defaults (when %true) or validate the values (when %false)
+ *
+ * The following device properties are supported:
+ *   - clock-frequency (optional)
+ *   - fifo-size (optional)
+ *   - no-loopback-test (optional)
+ *   - reg-shift (defaults may apply)
+ *   - reg-offset (value may be validated)
+ *   - reg-io-width (defaults may apply or value may be validated)
+ *   - interrupts (OF only)
+ *   - serial [alias ID] (OF only)
+ *
+ * If the port->dev is of struct platform_device type the interrupt line
+ * will be retrieved via platform_get_irq() call against that device.
+ * Otherwise it will be assigned by fwnode_irq_get() call. In both cases
+ * the index 0 of the resource is used.
+ *
+ * The caller is responsible to initialize the following fields of the @port
+ *   ->dev (must be valid)
+ *   ->flags
+ *   ->mapbase
+ *   ->mapsize
+ *   ->regshift (if @use_defaults is false)
+ * before calling this function. Alternatively the above mentioned fields
+ * may be zeroed, in such case the only ones, that have associated properties
+ * found, will be set to the respective values.
+ *
+ * If no error happened, the ->irq, ->mapbase, ->mapsize will be altered.
+ * The ->iotype is always altered.
+ *
+ * When @use_defaults is true and the respective property is not found
+ * the following values will be applied:
+ *   ->regshift = 0
+ * In this case IRQ must be provided, otherwise an error will be returned.
+ *
+ * When @use_defaults is false and the respective property is found
+ * the following values will be validated:
+ *   - reg-io-width (->iotype)
+ *   - reg-offset (->mapsize against ->mapbase)
+ *
+ * Returns: 0 on success or negative errno on failure
+ */
+static int __uart_read_properties(struct uart_port *port, bool use_defaults)
+{
+	struct device *dev = port->dev;
+	u32 value;
+	int ret;
+
+	/* Read optional UART functional clock frequency */
+	device_property_read_u32(dev, "clock-frequency", &port->uartclk);
+
+	/* Read the registers alignment (default: 8-bit) */
+	ret = device_property_read_u32(dev, "reg-shift", &value);
+	if (ret)
+		port->regshift = use_defaults ? 0 : port->regshift;
+	else
+		port->regshift = value;
+
+	/* Read the registers I/O access type (default: MMIO 8-bit) */
+	ret = device_property_read_u32(dev, "reg-io-width", &value);
+	if (ret) {
+		port->iotype = UPIO_MEM;
+	} else {
+		switch (value) {
+		case 1:
+			port->iotype = UPIO_MEM;
+			break;
+		case 2:
+			port->iotype = UPIO_MEM16;
+			break;
+		case 4:
+			port->iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
+			break;
+		default:
+			if (!use_defaults) {
+				dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
+				return -EINVAL;
+			}
+			port->iotype = UPIO_UNKNOWN;
+			break;
+		}
+	}
+
+	/* Read the address mapping base offset (default: no offset) */
+	ret = device_property_read_u32(dev, "reg-offset", &value);
+	if (ret)
+		value = 0;
+
+	/* Check for shifted address mapping overflow */
+	if (!use_defaults && port->mapsize < value) {
+		dev_err(dev, "reg-offset %u exceeds region size %pa\n", value, &port->mapsize);
+		return -EINVAL;
+	}
+
+	port->mapbase += value;
+	port->mapsize -= value;
+
+	/* Read optional FIFO size */
+	device_property_read_u32(dev, "fifo-size", &port->fifosize);
+
+	if (device_property_read_bool(dev, "no-loopback-test"))
+		port->flags |= UPF_SKIP_TEST;
+
+	/* Get index of serial line, if found in DT aliases */
+	ret = of_alias_get_id(dev_of_node(dev), "serial");
+	if (ret >= 0)
+		port->line = ret;
+
+	if (dev_is_platform(dev))
+		ret = platform_get_irq(to_platform_device(dev), 0);
+	else
+		ret = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret > 0)
+		port->irq = ret;
+	else if (use_defaults)
+		/* By default IRQ support is mandatory */
+		return ret;
+	else
+		port->irq = 0;
+
+	port->flags |= UPF_SHARE_IRQ;
+
+	return 0;
+}
+
+int uart_read_port_properties(struct uart_port *port)
+{
+	return __uart_read_properties(port, true);
+}
+EXPORT_SYMBOL_GPL(uart_read_port_properties);
+
+int uart_read_and_validate_port_properties(struct uart_port *port)
+{
+	return __uart_read_properties(port, false);
+}
+EXPORT_SYMBOL_GPL(uart_read_and_validate_port_properties);
+
 static struct device_driver serial_port_driver = {
 	.name = "port",
 	.suppress_bind_attrs = true,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c2cf9484014c..c1fd3d2f6238 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -962,6 +962,8 @@ int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
+int uart_read_port_properties(struct uart_port *port);
+int uart_read_and_validate_port_properties(struct uart_port *port);
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2);
 
-- 
2.43.0.rc1.1.gbec44491f096


