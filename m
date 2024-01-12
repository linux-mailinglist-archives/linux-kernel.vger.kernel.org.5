Return-Path: <linux-kernel+bounces-24531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A582BDF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E9D1F2747B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA95FEEA;
	Fri, 12 Jan 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vJx5K3mq"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98E5EE65;
	Fri, 12 Jan 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C8bMus023989;
	Fri, 12 Jan 2024 10:53:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=i98/hBFkGLGzRNaC6B6POzerMvXKbdE4VOEIPqiij1g=; b=vJ
	x5K3mqtqK4Wsm2qp9tAqWLylPpusz/27jSMrZLhF1UzjD151CJLxvYRMVZ+YSPr2
	Z1rF9/Z8oGT7WaQ38h3VDUNilW5oj3PiG+sz26SpUE1P3tTmyAsIT/EjOL9Nbpiu
	AfbGhI/Xmum7gvSrfz5HipFZhl945hvhdIGqtYudst02xzvSX9adOjcr2rwkLSxD
	mqgFUfQg5Laxos0XT0mUoMbcErLx/17EB+Sbqx1Es7xFsGsDaK3ns3NQ1NXuG+jN
	GmPLYJOGpvHu0t17XkBlcOPBsjHvEcjCKBAZOqUzMgjYRHQwPZl18NIunL4ztnfw
	DvDEeymo+uzU+R+jrCuQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vk22w8b9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 10:53:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D042710002A;
	Fri, 12 Jan 2024 10:53:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7DCD208D4E;
	Fri, 12 Jan 2024 10:53:26 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Jan
 2024 10:53:26 +0100
From: Valentin Caron <valentin.caron@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH v2 4/4] serial: stm32: get FIFO size from hwcfg register
Date: Fri, 12 Jan 2024 10:53:00 +0100
Message-ID: <20240112095300.2004878-5-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112095300.2004878-1-valentin.caron@foss.st.com>
References: <20240112095300.2004878-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Since STM32MP25, FIFO size could vary regarding the STM32MPxx version.
So we get this size from "hwcfgr1" register and compute threshold values
corresponding to the ratio given by reference manual.

As STM32MP1x, STM32MP25 and STM32H7 share the same compatible and STM32H7
doesn't have a register to get FIFO size, we force FIFO size to 16 in case
of zero read from hwcfgr1 register.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 158 +++++++++++++++++--------------
 drivers/tty/serial/stm32-usart.h |   6 +-
 2 files changed, 94 insertions(+), 70 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 19a45e1b7102..3cbb498c6ea6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -40,63 +40,64 @@
 /* Register offsets */
 static struct stm32_usart_info __maybe_unused stm32f4_info = {
 	.ofs = {
-		.isr	= 0x00,
-		.rdr	= 0x04,
-		.tdr	= 0x04,
-		.brr	= 0x08,
-		.cr1	= 0x0c,
-		.cr2	= 0x10,
-		.cr3	= 0x14,
-		.gtpr	= 0x18,
-		.rtor	= UNDEF_REG,
-		.rqr	= UNDEF_REG,
-		.icr	= UNDEF_REG,
-		.presc	= UNDEF_REG,
+		.isr		= 0x00,
+		.rdr		= 0x04,
+		.tdr		= 0x04,
+		.brr		= 0x08,
+		.cr1		= 0x0c,
+		.cr2		= 0x10,
+		.cr3		= 0x14,
+		.gtpr		= 0x18,
+		.rtor		= UNDEF_REG,
+		.rqr		= UNDEF_REG,
+		.icr		= UNDEF_REG,
+		.presc		= UNDEF_REG,
+		.hwcfgr1	= UNDEF_REG,
 	},
 	.cfg = {
 		.uart_enable_bit = 13,
 		.has_7bits_data = false,
-		.fifosize = 1,
 	}
 };
 
 static struct stm32_usart_info __maybe_unused stm32f7_info = {
 	.ofs = {
-		.cr1	= 0x00,
-		.cr2	= 0x04,
-		.cr3	= 0x08,
-		.brr	= 0x0c,
-		.gtpr	= 0x10,
-		.rtor	= 0x14,
-		.rqr	= 0x18,
-		.isr	= 0x1c,
-		.icr	= 0x20,
-		.rdr	= 0x24,
-		.tdr	= 0x28,
-		.presc	= UNDEF_REG,
+		.cr1		= 0x00,
+		.cr2		= 0x04,
+		.cr3		= 0x08,
+		.brr		= 0x0c,
+		.gtpr		= 0x10,
+		.rtor		= 0x14,
+		.rqr		= 0x18,
+		.isr		= 0x1c,
+		.icr		= 0x20,
+		.rdr		= 0x24,
+		.tdr		= 0x28,
+		.presc		= UNDEF_REG,
+		.hwcfgr1	= UNDEF_REG,
 	},
 	.cfg = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
 		.has_swap = true,
-		.fifosize = 1,
 	}
 };
 
 static struct stm32_usart_info __maybe_unused stm32h7_info = {
 	.ofs = {
-		.cr1	= 0x00,
-		.cr2	= 0x04,
-		.cr3	= 0x08,
-		.brr	= 0x0c,
-		.gtpr	= 0x10,
-		.rtor	= 0x14,
-		.rqr	= 0x18,
-		.isr	= 0x1c,
-		.icr	= 0x20,
-		.rdr	= 0x24,
-		.tdr	= 0x28,
-		.presc	= 0x2c,
+		.cr1		= 0x00,
+		.cr2		= 0x04,
+		.cr3		= 0x08,
+		.brr		= 0x0c,
+		.gtpr		= 0x10,
+		.rtor		= 0x14,
+		.rqr		= 0x18,
+		.isr		= 0x1c,
+		.icr		= 0x20,
+		.rdr		= 0x24,
+		.tdr		= 0x28,
+		.presc		= 0x2c,
+		.hwcfgr1	= 0x3f0,
 	},
 	.cfg = {
 		.uart_enable_bit = 0,
@@ -104,7 +105,6 @@ static struct stm32_usart_info __maybe_unused stm32h7_info = {
 		.has_swap = true,
 		.has_wakeup = true,
 		.has_fifo = true,
-		.fifosize = 16,
 	}
 };
 
@@ -1498,37 +1498,57 @@ static const struct uart_ops stm32_uart_ops = {
 #endif /* CONFIG_CONSOLE_POLL */
 };
 
-/*
- * STM32H7 RX & TX FIFO threshold configuration (CR3 RXFTCFG / TXFTCFG)
- * Note: 1 isn't a valid value in RXFTCFG / TXFTCFG. In this case,
- * RXNEIE / TXEIE can be used instead of threshold irqs: RXFTIE / TXFTIE.
- * So, RXFTCFG / TXFTCFG bitfields values are encoded as array index + 1.
- */
-static const u32 stm32h7_usart_fifo_thresh_cfg[] = { 1, 2, 4, 8, 12, 14, 16 };
+struct stm32_usart_thresh_ratio {
+	int mul;
+	int div;
+};
+
+static const struct stm32_usart_thresh_ratio stm32h7_usart_fifo_thresh_cfg[] = {
+	{1, 8}, {1, 4}, {1, 2}, {3, 4}, {7, 8}, {1, 1} };
 
-static void stm32_usart_get_ftcfg(struct platform_device *pdev, const char *p,
-				  int *ftcfg)
+static int stm32_usart_get_thresh_value(u32 fifo_size, int index)
 {
-	u32 bytes, i;
+	return fifo_size * stm32h7_usart_fifo_thresh_cfg[index].mul /
+		stm32h7_usart_fifo_thresh_cfg[index].div;
+}
 
-	/* DT option to get RX & TX FIFO threshold (default to 8 bytes) */
+static int stm32_usart_get_ftcfg(struct platform_device *pdev, struct stm32_port *stm32port,
+				 const char *p, int *ftcfg)
+{
+	const struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
+	u32 bytes, i, cfg8;
+	int fifo_size;
+
+	if (WARN_ON(ofs->hwcfgr1 == UNDEF_REG))
+		return 1;
+
+	cfg8 = FIELD_GET(USART_HWCFGR1_CFG8,
+			 readl_relaxed(stm32port->port.membase + ofs->hwcfgr1));
+
+	/* On STM32H7, hwcfgr is not present, so returned value will be 0 */
+	fifo_size = cfg8 ? 1 << cfg8 : STM32H7_USART_FIFO_SIZE;
+
+	/* DT option to get RX & TX FIFO threshold (default to half fifo size) */
 	if (of_property_read_u32(pdev->dev.of_node, p, &bytes))
-		bytes = 8;
+		bytes = fifo_size / 2;
+
+	if (bytes < stm32_usart_get_thresh_value(fifo_size, 0)) {
+		*ftcfg = -EINVAL;
+		return fifo_size;
+	}
 
-	for (i = 0; i < ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg); i++)
-		if (stm32h7_usart_fifo_thresh_cfg[i] >= bytes)
+	for (i = 0; i < ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg); i++) {
+		if (stm32_usart_get_thresh_value(fifo_size, i) >= bytes)
 			break;
+	}
 	if (i >= ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg))
 		i = ARRAY_SIZE(stm32h7_usart_fifo_thresh_cfg) - 1;
 
-	dev_dbg(&pdev->dev, "%s set to %d bytes\n", p,
-		stm32h7_usart_fifo_thresh_cfg[i]);
+	dev_dbg(&pdev->dev, "%s set to %d/%d bytes\n", p,
+		stm32_usart_get_thresh_value(fifo_size, i), fifo_size);
 
-	/* Provide FIFO threshold ftcfg (1 is invalid: threshold irq unused) */
-	if (i)
-		*ftcfg = i - 1;
-	else
-		*ftcfg = -EINVAL;
+	*ftcfg = i;
+	return fifo_size;
 }
 
 static void stm32_usart_deinit_port(struct stm32_port *stm32port)
@@ -1558,7 +1578,6 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
-	port->fifosize	= stm32port->info->cfg.fifosize;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_STM32_CONSOLE);
 	port->irq = irq;
 	port->rs485_config = stm32_usart_config_rs485;
@@ -1574,14 +1593,6 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 	stm32port->swap = stm32port->info->cfg.has_swap &&
 		of_property_read_bool(pdev->dev.of_node, "rx-tx-swap");
 
-	stm32port->fifoen = stm32port->info->cfg.has_fifo;
-	if (stm32port->fifoen) {
-		stm32_usart_get_ftcfg(pdev, "rx-threshold",
-				      &stm32port->rxftcfg);
-		stm32_usart_get_ftcfg(pdev, "tx-threshold",
-				      &stm32port->txftcfg);
-	}
-
 	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
@@ -1604,6 +1615,15 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 		goto err_clk;
 	}
 
+	stm32port->fifoen = stm32port->info->cfg.has_fifo;
+	if (stm32port->fifoen) {
+		stm32_usart_get_ftcfg(pdev, stm32port, "rx-threshold", &stm32port->rxftcfg);
+		port->fifosize = stm32_usart_get_ftcfg(pdev, stm32port, "tx-threshold",
+						       &stm32port->txftcfg);
+	} else {
+		port->fifosize = 1;
+	}
+
 	stm32port->gpios = mctrl_gpio_init(&stm32port->port, 0);
 	if (IS_ERR(stm32port->gpios)) {
 		ret = PTR_ERR(stm32port->gpios);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index bf3720948704..af20258ccc7a 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -21,6 +21,7 @@ struct stm32_usart_offsets {
 	u16 rdr;
 	u16 tdr;
 	u16 presc;
+	u16 hwcfgr1;
 };
 
 struct stm32_usart_config {
@@ -29,7 +30,6 @@ struct stm32_usart_config {
 	bool has_swap;
 	bool has_wakeup;
 	bool has_fifo;
-	int fifosize;
 };
 
 struct stm32_usart_info {
@@ -182,8 +182,12 @@ struct stm32_usart_info {
 #define USART_PRESC		GENMASK(3, 0)	/* H7 */
 #define USART_PRESC_MAX		0b1011
 
+/* USART_HWCFCR1 */
+#define USART_HWCFGR1_CFG8	GENMASK(31, 28)	/* MP1 */
+
 #define STM32_SERIAL_NAME "ttySTM"
 #define STM32_MAX_PORTS 9
+#define STM32H7_USART_FIFO_SIZE 16
 
 #define RX_BUF_L 4096		 /* dma rx buffer length     */
 #define RX_BUF_P (RX_BUF_L / 2)	 /* dma rx buffer period     */
-- 
2.25.1


