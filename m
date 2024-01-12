Return-Path: <linux-kernel+bounces-24530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C682782BDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2DA28AC22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE24F5EE88;
	Fri, 12 Jan 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="c9C3su9q"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9F5DF3A;
	Fri, 12 Jan 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C8bRbX014643;
	Fri, 12 Jan 2024 10:53:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=MZ2yC/2e1I4xidBJg4kSl8TM52bi1bQR+pbYIgCU74I=; b=c9
	C3su9qwUns9Om7PEG5p0j01D37iXNkrQnfJi7cdsqh9JEpWt3Y+HXn9VbSU6hzKK
	NeFLnJTbuABMcStI72AUVgB/4zGEOXBBYuHg9wJTs8UrSMCFboPk42PC8vwf/zbe
	5rKdXn2rdI7WSI2n9w2NRNBp2mP7KF8EWgaw8vlJvzkXq0INpipTWsUG/FabwCNW
	RK0d3M9Px74lb8Yjf9OmZEX699DvISBjDCkBva2TRp1WFt/egevapgqJFDXwmPAs
	DIQCcpEo9VPkEivZFn9cg9IwHoxffCEGaFzIX9TVsVCsTdevzWj/2MKBW5zeiBvG
	x0g33wQrK6mUOXuawSDg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vk22w8bhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 10:53:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 423DE10004D;
	Fri, 12 Jan 2024 10:53:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B0E8208D4E;
	Fri, 12 Jan 2024 10:53:24 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Jan
 2024 10:53:23 +0100
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
Subject: [PATCH v2 1/4] serial: stm32: implement prescaler tuning to compute low baudrate
Date: Fri, 12 Jan 2024 10:52:57 +0100
Message-ID: <20240112095300.2004878-2-valentin.caron@foss.st.com>
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

In the case of high USART input clock and low baud rate, BRR value
is not enough to get correct baud rate. So here we use USART prescaler to
divide USART input clock to get the correct baud rate.

PRESC register is only available since stm32h7.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 71 ++++++++++++++++++++++----------
 drivers/tty/serial/stm32-usart.h |  6 +++
 2 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 794b77512740..19a45e1b7102 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -9,6 +9,7 @@
  * Inspired by st-asc.c from STMicroelectronics (c)
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -50,6 +51,7 @@ static struct stm32_usart_info __maybe_unused stm32f4_info = {
 		.rtor	= UNDEF_REG,
 		.rqr	= UNDEF_REG,
 		.icr	= UNDEF_REG,
+		.presc	= UNDEF_REG,
 	},
 	.cfg = {
 		.uart_enable_bit = 13,
@@ -71,6 +73,7 @@ static struct stm32_usart_info __maybe_unused stm32f7_info = {
 		.icr	= 0x20,
 		.rdr	= 0x24,
 		.tdr	= 0x28,
+		.presc	= UNDEF_REG,
 	},
 	.cfg = {
 		.uart_enable_bit = 0,
@@ -93,6 +96,7 @@ static struct stm32_usart_info __maybe_unused stm32h7_info = {
 		.icr	= 0x20,
 		.rdr	= 0x24,
 		.tdr	= 0x28,
+		.presc	= 0x2c,
 	},
 	.cfg = {
 		.uart_enable_bit = 0,
@@ -1145,6 +1149,8 @@ static void stm32_usart_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
+static const unsigned int stm32_usart_presc_val[] = {1, 2, 4, 6, 8, 10, 12, 16, 32, 64, 128, 256};
+
 static void stm32_usart_set_termios(struct uart_port *port,
 				    struct ktermios *termios,
 				    const struct ktermios *old)
@@ -1153,17 +1159,19 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	struct serial_rs485 *rs485conf = &port->rs485;
-	unsigned int baud, bits;
+	unsigned int baud, bits, uart_clk, uart_clk_pres;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
-	u32 cr1, cr2, cr3, isr;
+	u32 cr1, cr2, cr3, isr, brr, presc;
 	unsigned long flags;
 	int ret;
 
 	if (!stm32_port->hw_flow_control)
 		cflag &= ~CRTSCTS;
 
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 8);
+	uart_clk = clk_get_rate(stm32_port->clk);
+
+	baud = uart_get_baud_rate(port, termios, old, 0, uart_clk / 8);
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -1265,27 +1273,48 @@ static void stm32_usart_set_termios(struct uart_port *port,
 		cr3 |= USART_CR3_CTSE | USART_CR3_RTSE;
 	}
 
-	usartdiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
+	for (presc = 0; presc <= USART_PRESC_MAX; presc++) {
+		uart_clk_pres = DIV_ROUND_CLOSEST(uart_clk, stm32_usart_presc_val[presc]);
+		usartdiv = DIV_ROUND_CLOSEST(uart_clk_pres, baud);
 
-	/*
-	 * The USART supports 16 or 8 times oversampling.
-	 * By default we prefer 16 times oversampling, so that the receiver
-	 * has a better tolerance to clock deviations.
-	 * 8 times oversampling is only used to achieve higher speeds.
-	 */
-	if (usartdiv < 16) {
-		oversampling = 8;
-		cr1 |= USART_CR1_OVER8;
-		stm32_usart_set_bits(port, ofs->cr1, USART_CR1_OVER8);
-	} else {
-		oversampling = 16;
-		cr1 &= ~USART_CR1_OVER8;
-		stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_OVER8);
+		/*
+		 * The USART supports 16 or 8 times oversampling.
+		 * By default we prefer 16 times oversampling, so that the receiver
+		 * has a better tolerance to clock deviations.
+		 * 8 times oversampling is only used to achieve higher speeds.
+		 */
+		if (usartdiv < 16) {
+			oversampling = 8;
+			cr1 |= USART_CR1_OVER8;
+			stm32_usart_set_bits(port, ofs->cr1, USART_CR1_OVER8);
+		} else {
+			oversampling = 16;
+			cr1 &= ~USART_CR1_OVER8;
+			stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_OVER8);
+		}
+
+		mantissa = (usartdiv / oversampling) << USART_BRR_DIV_M_SHIFT;
+		fraction = usartdiv % oversampling;
+		brr = mantissa | fraction;
+
+		if (FIELD_FIT(USART_BRR_MASK, brr)) {
+			if (ofs->presc != UNDEF_REG) {
+				port->uartclk = uart_clk_pres;
+				writel_relaxed(presc, port->membase + ofs->presc);
+			} else if (presc) {
+				/* We need a prescaler but we don't have it (STM32F4, STM32F7) */
+				dev_err(port->dev,
+					"unable to set baudrate, input clock is too high");
+			}
+			break;
+		} else if (presc == USART_PRESC_MAX) {
+			/* Even with prescaler and brr at max value we can't set baudrate */
+			dev_err(port->dev, "unable to set baudrate, input clock is too high");
+			break;
+		}
 	}
 
-	mantissa = (usartdiv / oversampling) << USART_BRR_DIV_M_SHIFT;
-	fraction = usartdiv % oversampling;
-	writel_relaxed(mantissa | fraction, port->membase + ofs->brr);
+	writel_relaxed(brr, port->membase + ofs->brr);
 
 	uart_update_timeout(port, cflag, baud);
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index f59f831b2a10..8cecfdce9386 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -20,6 +20,7 @@ struct stm32_usart_offsets {
 	u8 icr;
 	u8 rdr;
 	u8 tdr;
+	u8 presc;
 };
 
 struct stm32_usart_config {
@@ -71,6 +72,7 @@ struct stm32_usart_info {
 #define USART_BRR_DIV_M_MASK	GENMASK(15, 4)
 #define USART_BRR_DIV_M_SHIFT	4
 #define USART_BRR_04_R_SHIFT	1
+#define USART_BRR_MASK		(USART_BRR_DIV_M_MASK | USART_BRR_DIV_F_MASK)
 
 /* USART_CR1 */
 #define USART_CR1_SBK		BIT(0)
@@ -176,6 +178,10 @@ struct stm32_usart_info {
 #define USART_ICR_CMCF		BIT(17)		/* F7 */
 #define USART_ICR_WUCF		BIT(20)		/* H7 */
 
+/* USART_PRESC */
+#define USART_PRESC		GENMASK(3, 0)	/* H7 */
+#define USART_PRESC_MAX		0b1011
+
 #define STM32_SERIAL_NAME "ttySTM"
 #define STM32_MAX_PORTS 8
 
-- 
2.25.1


