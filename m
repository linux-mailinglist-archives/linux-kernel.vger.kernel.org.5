Return-Path: <linux-kernel+bounces-104964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446E87D6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B831C21F46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E55786B;
	Fri, 15 Mar 2024 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MbG9gn1S"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3C54745
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541799; cv=none; b=E47yozipEz20F7rBdObIqajYYwP3RtBFdDibJX1j6KhtILNXIGmtFfKUbc2Tgfkwv3VPC42VCgV+1jx2AFyPyamgJQZ99zzPFptj0stYZLJHIFYB41Sxd6UsulNOGz76lVQPaM95hsM3yhhjms7u78+okEjdAfkc3OuNMubv+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541799; c=relaxed/simple;
	bh=abZbN+dtmzMeEI+wi27JDUEzPkv7xsNWz/ht4MJdi+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFChJ3Je330+f2apFhmrIqj9Y6Sv7AoArxV+xeVx5uKGXVeb3y9+pCR8PKV94uHHLO8NkHewtv6X88sBkHmMrK5JkHWETEDC9FVI/UlGvAAlD8SZHFJDR25vj9YPHGVKzcul/IhVb2h9mqzwjoA9/9pc4heKPTJnu1ixwA//Vsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MbG9gn1S; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e5d1e95481so1092295a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710541794; x=1711146594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCusZO289RmxKRApmPUsapIonaCtegZudach7X7xosU=;
        b=MbG9gn1SiH/zNBJyDhuwa4f+87ah1KZZZePUyjO7tdoRiET65RUS5qmLrIT2VdwwRd
         y5Kko5ror9ww5c0pR1pD5Ys2RHpWDcKVYVZ7ghfsAvA2YdO+KC7ZUnwN3R5I6R3FwZ/3
         Yku6oN7MS3hGMKRNQVEgwpwWHfPlHyJmPWVe+zUdOnu6C6TUkKtIbSImWDVJUtchUFE+
         1+mUfDdXltK3bI3hNR+mHLvYZZ9rGBKWFq72jPZIaOe9Ueh4w6dXuydybVhsaphp1PlT
         1vGh5zz/PcAqNVCdVweynwgS4/jqy1soQkTsrJCJNgkaXP3FOBmxugQCJTnwb1MBIZHa
         SmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541794; x=1711146594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCusZO289RmxKRApmPUsapIonaCtegZudach7X7xosU=;
        b=KcR8oUvrKb821pBUmWkAsU1u49eUhSTPtSzLFe6I3CG2wd36Db9gADEcapXtrv1YEO
         D372eY31oQFHsQHPFT5rGlbc2QDv2MMGRdXazrD8EpIwW5s/Z+Hgt1yCWFp/ECQnD2O4
         R5Sd1BsKNdQyWzMXLyMaflWKXDdDK7YoWbwCot71NmzOufyawk0ZgbOPD9/umRzpIeeV
         48DUuL8gUJepfB002pY+ii/piFbu/UgAHCwxHOPci+A92+ZowTPk1M8EgZNearMDIN3k
         OIeDC1JvQIm7bHHWXSd7PjuuS8eV9igYf0c9R1JCxnYTMhfmGP5hY1UQEJrlXZPNBnlx
         k14Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz5/wQd1pXqx90HSZ/6/kijvUCrcRPUblAY5Hu4lnITcTDmk/4tGlOan3ltFw5aAzl33gRd2sTBr12/h+G2O6jyhFlmid0Tz0XmMqS
X-Gm-Message-State: AOJu0YxsMWFNnzuyaMDyfSwGTb0Eo2on8g8t13BFhQ0LmGNIZvgRs92D
	i0eMXKXMls7T+c0mqsGqjeGfQHALBa3ceEsfjNFSTlJ474U1SYgWnKE7r0qoavY=
X-Google-Smtp-Source: AGHT+IEW5gN9sbph3kxFIGZdgJVjd6G6qZOWmV9uVNfp7feJ4DfK+CdJShaF1xYaFe+rCRb6NtgQuA==
X-Received: by 2002:a9d:7acb:0:b0:6e4:fa90:2549 with SMTP id m11-20020a9d7acb000000b006e4fa902549mr6850500otn.8.1710541793960;
        Fri, 15 Mar 2024 15:29:53 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id t28-20020a05683022fc00b006e67ef12d07sm227721otc.27.2024.03.15.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:29:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: remove struct spi_message::is_dma_mapped
Date: Fri, 15 Mar 2024 17:29:43 -0500
Message-ID: <20240315-spi-remove-is_dma_mapped-v1-1-ca876f9de1c5@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

There are no more users of the deprecated is_dma_mapped in struct
spi_message so it can be removed.

References in documentation and comments are also removed.

A few similar checks if xfer->tx_dma or xfer->rx_dma are not NULL are
also removed since these are now guaranteed to be NULL because they
were previously set only if is_dma_mapped was true.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/spi/pxa2xx.rst      |  3 ---
 Documentation/spi/spi-summary.rst |  4 ----
 drivers/spi/spi-atmel.c           |  8 ++------
 drivers/spi/spi-pxa2xx.c          | 10 ----------
 drivers/spi/spi.c                 |  7 -------
 include/linux/spi/spi.h           | 11 +++--------
 6 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 19479b801826..43e0b758803a 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -194,9 +194,6 @@ The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis::
 
   if spi_message.len > 65536 then
-	if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
-		reject premapped transfers
-
 	print "rate limited" warning
 	use PIO transfers
 
diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 546de37d6caf..f7f8b1573f25 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -419,10 +419,6 @@ any more such messages.
     to make extra copies unless the hardware requires it (e.g. working
     around hardware errata that force the use of bounce buffering).
 
-    If standard dma_map_single() handling of these buffers is inappropriate,
-    you can use spi_message.is_dma_mapped to tell the controller driver
-    that you've already provided the relevant DMA addresses.
-
   - The basic I/O primitive is spi_async().  Async requests may be
     issued in any context (irq handler, task, etc) and completion
     is reported using a callback provided with the message.
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bad34998454a..b62f57390d8f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -987,8 +987,6 @@ static void atmel_spi_pdc_next_xfer(struct spi_controller *host,
  * For DMA, tx_buf/tx_dma have the same relationship as rx_buf/rx_dma:
  *  - The buffer is either valid for CPU access, else NULL
  *  - If the buffer is valid, so is its DMA address
- *
- * This driver manages the dma address unless message->is_dma_mapped.
  */
 static int
 atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
@@ -1374,8 +1372,7 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
 	 */
-	if ((!host->cur_msg->is_dma_mapped)
-		&& as->use_pdc) {
+	if (as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
 	}
@@ -1454,8 +1451,7 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 		}
 	}
 
-	if (!host->cur_msg->is_dma_mapped
-		&& as->use_pdc)
+	if (as->use_pdc)
 		atmel_spi_dma_unmap_xfer(host, xfer);
 
 	if (as->use_pdc)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f2a856f6a99e..ddc534cdea5a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -959,16 +959,6 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 
 	/* Check if we can DMA this transfer */
 	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
-
-		/* Reject already-mapped transfers; PIO won't always work */
-		if (message->is_dma_mapped
-				|| transfer->rx_dma || transfer->tx_dma) {
-			dev_err(&spi->dev,
-				"Mapped transfer length of %u is greater than %d\n",
-				transfer->len, MAX_DMA_LEN);
-			return -EINVAL;
-		}
-
 		/* Warn ... we force this to PIO mode */
 		dev_warn_ratelimited(&spi->dev,
 				     "DMA disabled for transfer length %u greater than %d\n",
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff75838c1b5d..a2f01116ba09 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3709,9 +3709,6 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	 * to the same values as *xferp, so tx_buf, rx_buf and len
 	 * are all identical (as well as most others)
 	 * so we just have to fix up len and the pointers.
-	 *
-	 * This also includes support for the depreciated
-	 * spi_message.is_dma_mapped interface.
 	 */
 
 	/*
@@ -3725,12 +3722,8 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 		/* Update rx_buf, tx_buf and DMA */
 		if (xfers[i].rx_buf)
 			xfers[i].rx_buf += offset;
-		if (xfers[i].rx_dma)
-			xfers[i].rx_dma += offset;
 		if (xfers[i].tx_buf)
 			xfers[i].tx_buf += offset;
-		if (xfers[i].tx_dma)
-			xfers[i].tx_dma += offset;
 
 		/* Update length */
 		xfers[i].len = min(maxsize, xfers[i].len - offset);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b05d5a87c313..45ed125c0db0 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -957,8 +957,8 @@ struct spi_res {
  * struct spi_transfer - a read/write buffer pair
  * @tx_buf: data to be written (DMA-safe memory), or NULL
  * @rx_buf: data to be read (DMA-safe memory), or NULL
- * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
- * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
+ * @tx_dma: DMA address of tx_buf, currently not for client use
+ * @rx_dma: DMA address of rx_buf, currently not for client use
  * @tx_nbits: number of bits used for writing. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
@@ -1068,8 +1068,7 @@ struct spi_transfer {
 	/*
 	 * It's okay if tx_buf == rx_buf (right?).
 	 * For MicroWire, one buffer must be NULL.
-	 * Buffers must work with dma_*map_single() calls, unless
-	 * spi_message.is_dma_mapped reports a pre-existing mapping.
+	 * Buffers must work with dma_*map_single() calls.
 	 */
 	const void	*tx_buf;
 	void		*rx_buf;
@@ -1113,8 +1112,6 @@ struct spi_transfer {
  * struct spi_message - one multi-segment SPI transaction
  * @transfers: list of transfer segments in this transaction
  * @spi: SPI device to which the transaction is queued
- * @is_dma_mapped: if true, the caller provided both DMA and CPU virtual
- *	addresses for each transfer buffer
  * @pre_optimized: peripheral driver pre-optimized the message
  * @optimized: the message is in the optimized state
  * @prepared: spi_prepare_message was called for the this message
@@ -1148,8 +1145,6 @@ struct spi_message {
 
 	struct spi_device	*spi;
 
-	unsigned		is_dma_mapped:1;
-
 	/* spi_optimize_message() was called for this message */
 	bool			pre_optimized;
 	/* __spi_optimize_message() was called for this message */

---
base-commit: 593c0afc18da08bbb79c7af2a6668884987958f6
change-id: 20240315-spi-remove-is_dma_mapped-ac067635662e

