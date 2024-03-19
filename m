Return-Path: <linux-kernel+bounces-107348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B921587FB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718611F21E97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236380638;
	Tue, 19 Mar 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUwsaYP7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7E8061F;
	Tue, 19 Mar 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842045; cv=none; b=KIdAHXvUEsMbsxFuWWS+EZedioCeqxGo/o40zSsbWoLfVhSuOT+qqAjUjSEg++ciLAFqzTKU6LQjmOD+yyld72r6EpGufXHDCyLUTLPwD23NmMZIIsqGNnTTZMxqIBKIaM7J91W6XOhK3py/Z2YWq884shA4C2yI/NBMYASCiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842045; c=relaxed/simple;
	bh=5+bhGaEEsgnXQkvvlI11yrFLziNuirM9WUE4o2kU49s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHG/jRutHF/RpMPmaBWhu1Og9X/lgwOV0grPUFB+xNh77y+WUCC5MgbxV6PO1oBTYKREeg9LW3+mZxewCjo3cH5T4iJuOsUE12T7jp4L/miPb7VbWIodZFPxoyBsyHs6gYz1dTQGSn97j1oC4IRB1CxDHrv1FtlNQj9Q1z5d3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUwsaYP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCC7C433F1;
	Tue, 19 Mar 2024 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842044;
	bh=5+bhGaEEsgnXQkvvlI11yrFLziNuirM9WUE4o2kU49s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUwsaYP7lie6Y6XI47LkB7londD7Gp3FNQROjsfd3lbl3fgR+6zQeFMYnIzuOIzIh
	 22bX7FIOs56cbSzowCk1XvOV7TuU7zTHynTDI41tf0RX1lzL/VIlH/9G7In0/1Fn4K
	 wlRK9FVlNrNGvwHSxND1cYZt+CQ5wrXttsOQ6D3baU456ArY/vq4xNTaN1f158hKkV
	 H21etsIJ/eAab8AAR6dyS/evvGDWvSuAnv3NFZoRzMJk2+MtLk087KMXku0UYiEV0v
	 3hElb9xSv3cSm/ExolGg/cakzvfv6aJ2PUDG6K5mHptb5QnuAmXJgJlySGNNdgRsuo
	 1f+4zAJumFMmQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFT 14/15] tty: atmel_serial: define macro for RX size
Date: Tue, 19 Mar 2024 10:53:14 +0100
Message-ID: <20240319095315.27624-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
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


