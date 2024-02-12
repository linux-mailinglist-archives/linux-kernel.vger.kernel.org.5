Return-Path: <linux-kernel+bounces-62535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28152852280
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B25FB24295
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8F51C45;
	Mon, 12 Feb 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NQJR/Lu5"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BF4F888
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780480; cv=none; b=lf4l4W1swE4nKdVFChWZiCf+mSnnAdEwjE1zqXxGX+7Cv6aBzhO9AQmteA26sqQlgOxW6bPiJtPkwZbwHHSRQQgtb9n0bduimncSMvP5kQRxHwlfBWrncO90lTD/s+nn/rXaTkK0B3rlsEuWsbpbBRFg2in9AJ8WDy+2NTfNt70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780480; c=relaxed/simple;
	bh=SOwuvsAaLR0dNkyt8XZ60TPrC9qAZLshwqZz0Hj2Yuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLpbdaR6pTKqR3OVE/1AHeZ7YQwOV5SxjQsVuORhcTobRdR9/GC/yVARFHUjHEzKCrEghvfQBdWb67ksI4rbT3q0K0BfR4sjFqLTyK4zzOn1yYbFSuURsUnu7WlpCqr6fg94FvVmdrR7kcIYzS2nU5ZNjiltwr6af8TUvE8JqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NQJR/Lu5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2c45b81d8so1289683a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707780476; x=1708385276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLX74Fa9d90V9VkLwpCR7m/vmZr63zncboWNam9EPB0=;
        b=NQJR/Lu5t5bctPZ1Ck/9aqUV/gJHEuGv3KO/pmtJXImeWVYd5TATYphharej1Mhr3f
         fRfoD1OI/kIZcCNuFbtR6Hi3uGFJnrc9+lw/nA1ZOjc2gZDIeyHlXWpxb8IHwazFhLGz
         i6y80X8gz2m3SmrU79T6bAZqrxdGRrY1m7fhW9kejTh2xZegB3/kp3LoAQYlp9wJxNaQ
         NWwhh+6dnFnkJFvdNy2jcD5j1A11iIUW35IaRmbr4GBHTg+AyRs+jhVXzxdxikciWkq0
         Dinwis8RnLgWbuQO8nUvoqkaHVUONcF89Mcqs/QarHRhpGnbG0nIPuYF8wdETXi1WqGZ
         /PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780476; x=1708385276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLX74Fa9d90V9VkLwpCR7m/vmZr63zncboWNam9EPB0=;
        b=D0O7GV/2gVvD1hSeDBwchnBpjFIz1FO0XuSFCB3sZbmMrvMYLRhmBmOBymxpvxvhA0
         kupHmvMX4JM6PKlqI1bYGRKn89/jZA9rVv3yNiW78oRQJ5Qg8K24r/qYab85sC3Dtu+b
         1tTTfBQ8OwqF5pG6OqAGp/JkOKn9cXEOkAn6eqHQu4RtvGtAtFGIz5avwCxuIBIynL5F
         HESiD5f02w1//LmpIMoaFREM8jSJv2EXuGwzjHP669UsX5Jh4NHy4/TM/WqFPz4/pnI7
         57Lla0hZGbES35b12H8vNb0niYAFnVa33hJXLFyzXRckN9HlXhysDN55r9JAZpZ4vTA+
         Ot3Q==
X-Gm-Message-State: AOJu0Yy1+gwyJEQAvZXTpl6XBnB6r1i57DlWHfXudYjKH9cWRo4OzTW4
	bqcjSAEfJrR5EJLbnNFegISi9h+SbB0ppOtznxFcaLnqxOdENfVvGMjLB5zKeuQ=
X-Google-Smtp-Source: AGHT+IENcG0sbm+FxGSeKQ32xuud3iecYncceHk8taz1sm4Yg2pNVJ8oAzK4Wiliu88pFCNfDotmDQ==
X-Received: by 2002:a05:6808:4396:b0:3c0:370c:69ea with SMTP id dz22-20020a056808439600b003c0370c69eamr307850oib.21.1707780475807;
        Mon, 12 Feb 2024 15:27:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWi+s6AcBtZ0faJKmtDS0VKFmvby7nAC38w75GOULRX0y9EwEx7+1J4H9ouW6lZvgCfSXJzdPrc7yhgO3q+HjZI/gPHESEeDPCRuQ/REyCrDkMkJv6LRwKg8Uo1Z/VP7UB+maV2po+cRkt1zHUDomud4hHTEjSVKo1VkbhcHLieCmVmF2Kqam/A9G7dQDDYuHW3eZu0brg+uTKK5AOlNYmeZqIkCCWu/Ru3v84yl6XJsbYnZIzbE/3z1ezjezL0f3AVzKT0610T2R7bCmORiIn8vdONSIM4qGQPMyXP2+xGeKXDtJmU3qIhddqUByKFCCmhPITsVmEHZTV0ZSu8DVluKLVxz1yE5CfaNKZvbiXWUs23Kk2xX6o8l7x0L0Qd833OSHTRbjkeyEpqTy4qxYTtzlOeYpDvj2A4mdKBAdNI1R54Zt5oK87Z4zOTALUFtihDq2C6VC2RX68xgia+zTecW9/zY1uVG4ALoFCXhgqXknkJMDkVxR86w/jjgiv2Vy35XT8Hk8V4JXrFtvGU82GTiScVHa4=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pk17-20020a0568704c1100b0021a7a45e0b1sm330141oab.35.2024.02.12.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:27:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/5] spi: move splitting transfers to spi_optimize_message()
Date: Mon, 12 Feb 2024 17:26:42 -0600
Message-ID: <20240212-mainline-spi-precook-message-v1-2-a2373cd72d36@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Splitting transfers is an expensive operation so we can potentially
optimize it by doing it only once per optimization of the message
instead of repeating each time the message is transferred.

The transfer splitting functions are currently the only user of
spi_res_alloc() so spi_res_release() can be safely moved at this time
from spi_finalize_current_message() to spi_unoptimize_message().

The doc comments of the public functions for splitting transfers are
also updated so that callers will know when it is safe to call them
to ensure proper resource management.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 110 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5bac215d7009..8a21fa5bd4b9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1747,38 +1747,6 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 
 	trace_spi_message_start(msg);
 
-	/*
-	 * If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
-	 * for the CS line, we can emulate the CS-per-word hardware function by
-	 * splitting transfers into one-word transfers and ensuring that
-	 * cs_change is set for each transfer.
-	 */
-	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					       spi_is_csgpiod(msg->spi))) {
-		ret = spi_split_transfers_maxwords(ctlr, msg, 1);
-		if (ret) {
-			msg->status = ret;
-			spi_finalize_current_message(ctlr);
-			return ret;
-		}
-
-		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-			/* Don't change cs_change on the last entry in the list */
-			if (list_is_last(&xfer->transfer_list, &msg->transfers))
-				break;
-			xfer->cs_change = 1;
-		}
-	} else {
-		ret = spi_split_transfers_maxsize(ctlr, msg,
-						  spi_max_transfer_size(msg->spi));
-		if (ret) {
-			msg->status = ret;
-			spi_finalize_current_message(ctlr);
-			return ret;
-		}
-	}
-
 	if (ctlr->prepare_message) {
 		ret = ctlr->prepare_message(ctlr, msg);
 		if (ret) {
@@ -2124,6 +2092,8 @@ static void __spi_unoptimize_message(struct spi_message *msg)
 	if (ctlr->unoptimize_message)
 		ctlr->unoptimize_message(msg);
 
+	spi_res_release(ctlr, msg);
+
 	msg->optimized = false;
 	msg->opt_state = NULL;
 }
@@ -2169,15 +2139,6 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	spi_unmap_msg(ctlr, mesg);
 
-	/*
-	 * In the prepare_messages callback the SPI bus has the opportunity
-	 * to split a transfer to smaller chunks.
-	 *
-	 * Release the split transfers here since spi_map_msg() is done on
-	 * the split transfers.
-	 */
-	spi_res_release(ctlr, mesg);
-
 	if (mesg->prepared && ctlr->unprepare_message) {
 		ret = ctlr->unprepare_message(ctlr, mesg);
 		if (ret) {
@@ -3819,6 +3780,10 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
  * @msg:   the @spi_message to transform
  * @maxsize:  the maximum when to apply this
  *
+ * This function allocates resources that are automatically freed during the
+ * spi message unoptimize phase so this function should only be called from
+ * optimize_message callbacks.
+ *
  * Return: status of transformation
  */
 int spi_split_transfers_maxsize(struct spi_controller *ctlr,
@@ -3857,6 +3822,10 @@ EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
  * @msg:      the @spi_message to transform
  * @maxwords: the number of words to limit each transfer to
  *
+ * This function allocates resources that are automatically freed during the
+ * spi message unoptimize phase so this function should only be called from
+ * optimize_message callbacks.
+ *
  * Return: status of transformation
  */
 int spi_split_transfers_maxwords(struct spi_controller *ctlr,
@@ -4231,6 +4200,57 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	return 0;
 }
 
+/**
+ * spi_split_transfers - generic handling of transfer splitting
+ * @msg: the message to split
+ *
+ * Under certain conditions, a SPI controller may not support arbitrary
+ * transfer sizes or other features required by a peripheral. This function
+ * will split the transfers in the message into smaller transfers that are
+ * supported by the controller.
+ *
+ * Controllers with special requirements not covered here can also split
+ * transfers in the optimize_message() callback.
+ *
+ * Context: can sleep
+ * Return: zero on success, else a negative error code
+ */
+static int spi_split_transfers(struct spi_message *msg)
+{
+	struct spi_controller *ctlr = msg->spi->controller;
+	struct spi_transfer *xfer;
+	int ret;
+
+	/*
+	 * If an SPI controller does not support toggling the CS line on each
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
+	 * splitting transfers into one-word transfers and ensuring that
+	 * cs_change is set for each transfer.
+	 */
+	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
+					       spi_is_csgpiod(msg->spi))) {
+		ret = spi_split_transfers_maxwords(ctlr, msg, 1);
+		if (ret)
+			return ret;
+
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			/* Don't change cs_change on the last entry in the list */
+			if (list_is_last(&xfer->transfer_list, &msg->transfers))
+				break;
+
+			xfer->cs_change = 1;
+		}
+	} else {
+		ret = spi_split_transfers_maxsize(ctlr, msg,
+						  spi_max_transfer_size(msg->spi));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * __spi_optimize_message - shared implementation for spi_optimize_message()
  *                          and spi_maybe_optimize_message()
@@ -4256,10 +4276,16 @@ static int __spi_optimize_message(struct spi_device *spi,
 	if (ret)
 		return ret;
 
+	ret = spi_split_transfers(msg);
+	if (ret)
+		return ret;
+
 	if (ctlr->optimize_message) {
 		ret = ctlr->optimize_message(msg);
-		if (ret)
+		if (ret) {
+			spi_res_release(ctlr, msg);
 			return ret;
+		}
 	}
 
 	msg->pre_optimized = pre_optimized;

-- 
2.43.0


