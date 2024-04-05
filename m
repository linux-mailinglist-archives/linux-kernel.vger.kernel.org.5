Return-Path: <linux-kernel+bounces-132453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A036089950F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418A8B26294
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A464D9E5;
	Fri,  5 Apr 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR5IkoVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F014C627;
	Fri,  5 Apr 2024 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297355; cv=none; b=Xn7ZqqMU3+QykJzzrkA1ihusIofkQhI3GpwH6rwDcE7IpPDWkIKEtCgkhMtGw//c+JW4lQMcX1AgbKgpV68IlfLRX2kIYPumy4E/AemKLuz/CK+Fz8Sopp8I5FpyD1F4acl1kcnujYfcgaF1WxmjbgLlhePsaa1lVddKENBUBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297355; c=relaxed/simple;
	bh=5+bhGaEEsgnXQkvvlI11yrFLziNuirM9WUE4o2kU49s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKI4O354IR1vnReQe9YR+GgQsqnZ2qTWjuofFHH4ps6z+t9eEoZ2giNyH2EvInEP5YfzkCkp80NUOko0wSXf4IwBhZOJlP6C/PkBVXiHqb58EVlibZ5exzPnenwTTXWBRvoxde7T3gH9tep9gKNce3U1qOOPugCBFYpkEaXkbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR5IkoVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202EDC433F1;
	Fri,  5 Apr 2024 06:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297355;
	bh=5+bhGaEEsgnXQkvvlI11yrFLziNuirM9WUE4o2kU49s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR5IkoVWCThIz/IBG4dzQ2NMBOZgCa6oO3mHsRDzKtpnJI73i/leg0yhmXB/ELmoo
	 k4tJVUb5AYY5fzBvjdbtoGwC7z571VIunje+PC3+0xHmQUzw1S6C2e1HyoVJpEGRR/
	 GNdgND2effh9za7S8E1C7Ho5IKLUTJyHiRL8kaa9hlKzm05fpge3Gyi4OWord4zqVo
	 hF7fwsJ+JIfygO36D2ObOsvpI8Nb8t5wTYEyhZIsd+9e++sd170qbM9glC/WnukVk6
	 NvpxDyXWqS5ONegWMu11GvD322p2uJ6xULNYpFWk9xYyaDnPE17xrmxCMyAdOrAPeC
	 9+F2fxqtatrpg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/15] tty: atmel_serial: define macro for RX size
Date: Fri,  5 Apr 2024 08:08:25 +0200
Message-ID: <20240405060826.2521-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is repeated in the code and there is also a big warning by
ATMEL_SERIAL_RINGSIZE. So define ATMEL_SERIAL_RX_SIZE and use it
appropriatelly.

The macro uses array_size() and kmalloc_array() is switched to
kmalloc().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/atmel_serial.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 69ec80ffc97b..5cde5077c429 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -96,7 +96,9 @@ struct atmel_uart_char {
  * can contain up to 1024 characters in PIO mode and up to 4096 characters in
  * DMA mode.
  */
-#define ATMEL_SERIAL_RINGSIZE 1024
+#define ATMEL_SERIAL_RINGSIZE	1024
+#define ATMEL_SERIAL_RX_SIZE	array_size(sizeof(struct atmel_uart_char), \
+					   ATMEL_SERIAL_RINGSIZE)
 
 /*
  * at91: 6 USARTs and one DBGU port (SAM9260)
@@ -1208,7 +1210,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	BUG_ON(!PAGE_ALIGNED(ring->buf));
 	sg_set_page(&atmel_port->sg_rx,
 		    virt_to_page(ring->buf),
-		    sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE,
+		    ATMEL_SERIAL_RX_SIZE,
 		    offset_in_page(ring->buf));
 	nent = dma_map_sg(port->dev,
 			  &atmel_port->sg_rx,
@@ -2947,9 +2949,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 
 	if (!atmel_use_pdc_rx(&atmel_port->uart)) {
 		ret = -ENOMEM;
-		data = kmalloc_array(ATMEL_SERIAL_RINGSIZE,
-				     sizeof(struct atmel_uart_char),
-				     GFP_KERNEL);
+		data = kmalloc(ATMEL_SERIAL_RX_SIZE, GFP_KERNEL);
 		if (!data)
 			goto err_clk_disable_unprepare;
 		atmel_port->rx_ring.buf = data;
-- 
2.44.0


