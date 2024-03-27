Return-Path: <linux-kernel+bounces-120562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575488D961
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599F71C272C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA90381AF;
	Wed, 27 Mar 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hiEPrHVI"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A93612A;
	Wed, 27 Mar 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529030; cv=none; b=n4xR5v4if/4MVsj4eOVUr0W1xh6u4J9a5Fwt4QZa59eKaoKj++z7bpR3Xb6phL3bRd1apDzKY+1NWoR5QE2/AY/gL/RAagXH2y4fICKWDUXkeClxzm0tQz2y3TgKmF5R0HbAkYyub+WEB1SzGQETL2aTcZtqu9gEDGBGWhHlm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529030; c=relaxed/simple;
	bh=8Rj4UzLQ+lgPhSr/BeYRiEb1FGa5j8sUlqT6xDm+xaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sio8WwtgnGEwQyLafi3FLipQIFLAeCAhKpfxxvkeces8uwMcZBkgJyJrvSXF1FWR5NioOXNE5hfEC1B7A9rzJt6fDEl+6hX4syPAO78sNzLVwVVvMdmj5wuvf9VxR+0vvRHeXwoP+PO1XoAlT6VfKu6WJyyCSY+QCrPzVonAqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hiEPrHVI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8849EFF812;
	Wed, 27 Mar 2024 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711529025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPTp0MTYjMgxYrxDkNPxdDoi7haxm4pB5iRe0mgUIg8=;
	b=hiEPrHVIUKUYdZE6f9vyrw5ldmPi1zW3NYWPTWr9ghHKkhEOohdB+rwmc/tBF6BSfVu6O+
	vbcsKSUizhw2MZ9ZrmBnGCnD066QINYltG5tLEqEZQ6vEZWTw+RNiQnwPy953oGtlNhBWR
	D7C7mKb735EGp069dj/McsXOyEDmQjKudNqqrD2tJ++6pxLaJ+1931tG/7YGAcGVffqNvZ
	7YrQCVGsQqYVZaiK0s0XkXX+OYmB0B/W/RrEbthZPkRiURhThivp+gN77nCNQTs0RIGDwE
	0jgoYNMQh7pPyqWO+knZ24CyWzJ92Oh7Kkq+8hOmDkVErksEURtYDnDR95N2jw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 27 Mar 2024 09:43:37 +0100
Subject: [PATCH v3 2/3] spi: omap2-mcspi: Add support for MULTI-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-spi-omap2-mcspi-multi-mode-v3-2-c4ac329dd5a2@bootlin.com>
References: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
In-Reply-To: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4742;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=8Rj4UzLQ+lgPhSr/BeYRiEb1FGa5j8sUlqT6xDm+xaQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA9w/KNsYbiOqJspFOpgHcOO0Om0GrgRHRHnPSknq
 qnq4Z1OJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPcPwAKCRAgrS7GWxAs4qzpEA
 DBQUmIrfY+iTI8ZR7Vao4r570bxb+K1oS+Tyvc8+9ZRidUB+kZVhFfBwBU8hAMpwAkhl82Ru7Pl5dC
 e2V1wg3t2lJUqeHVsa/hN6/cRcjOsQTjo+JlBsza9SzK9O/ZujHRTft+lmHwfaMJlITNHNzN+YxGYi
 YquKOUN6aw3BcMFd/tfOojtpWBhEAx1XndqNB0E5c9g2vpNisXoVVySCq9EzbHK+R5iHtrkpVfzN6c
 XtPHc6Stki+c5hk/J6sAEVLdbd2A7AGsE+Ov4Wg1bzIkE8NWRBT4BNziRR+v9MrrYgkhJ1Vw5qJD0q
 7zNK6xfP9ahJItKnHL6ocGQ13Yl5cMgFqrnyYu7VTNus50SUaYhQTxGQ9ZNvL5cvn70AU5UDt3MM3m
 ynnov0tS9Kw2Rh3MJUUMp/rRmufer7Bmymde92yGEG4yN7klCcY8NmXwUzkNTujFPvOfaWW63sssZz
 KebfVX58/rKWFBOj7oxey1VP+hlLpjrmEtSgnnjHv+P6StVtPv0uGFcJ0WLvTCFcz1TyiUqjF3+qzs
 mxb6IHbAs8PUHBhjvLMviD5zH7p9CtAyxGVwtrtG0ziOWTY1RIQLCeS8cfcf2Dbs1TgqOZ4DAtXwYO
 em6Pd8hZz+n5tBrIGHsSahwmsI+ebC2c6OFfGrx+1PGsd/mS4Up+voSBguxQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce support for MULTI-mode in the OMAP2 MCSPI driver. Currently, the
driver always uses SINGLE mode to handle the chip select (CS). With this
enhancement, MULTI-mode is enabled for specific messages, allowing for a
shorter delay between CS enable and the message (some FPGA devices are
sensitive to this delay).

The OMAP2 MCSPI device can use two different mode to send messages, SINGLE
and MULTI:
In SINGLE mode, the controller only leverages one single FIFO, and the
host system has to manually select the CS it wants to enable.
In MULTI mode, each CS is bound to a FIFO, the host system then writes the
data to the relevant FIFO, as the hardware will take care of the CS

The drawback of multi-mode is that it's not possible to keep the CS
enabled between each words. Therefore, this patch enables multi-mode only
for specific messages: the spi_message must contain only spi_transfer of 1
word (of any size) with cs_change enabled.

A new member is introduced in the omap2_mcspi structure to keep track of
the current used mode.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/spi/spi-omap2-mcspi.c | 67 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 601acec37eca..002f29dbcea6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -131,6 +131,7 @@ struct omap2_mcspi {
 	unsigned int		pin_dir:1;
 	size_t			max_xfer_len;
 	u32			ref_clk_hz;
+	bool			use_multi_mode;
 };
 
 struct omap2_mcspi_cs {
@@ -256,10 +257,15 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 
 		l = mcspi_cached_chconf0(spi);
 
-		if (enable)
+		/* Only enable chip select manually if single mode is used */
+		if (mcspi->use_multi_mode) {
 			l &= ~OMAP2_MCSPI_CHCONF_FORCE;
-		else
-			l |= OMAP2_MCSPI_CHCONF_FORCE;
+		} else {
+			if (enable)
+				l &= ~OMAP2_MCSPI_CHCONF_FORCE;
+			else
+				l |= OMAP2_MCSPI_CHCONF_FORCE;
+		}
 
 		mcspi_write_chconf0(spi, l);
 
@@ -283,7 +289,12 @@ static void omap2_mcspi_set_mode(struct spi_controller *ctlr)
 		l |= (OMAP2_MCSPI_MODULCTRL_MS);
 	} else {
 		l &= ~(OMAP2_MCSPI_MODULCTRL_MS);
-		l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
+
+		/* Enable single mode if needed */
+		if (mcspi->use_multi_mode)
+			l &= ~OMAP2_MCSPI_MODULCTRL_SINGLE;
+		else
+			l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
 	}
 	mcspi_write_reg(ctlr, OMAP2_MCSPI_MODULCTRL, l);
 
@@ -1250,15 +1261,59 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	struct omap2_mcspi	*mcspi = spi_controller_get_devdata(ctlr);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	struct omap2_mcspi_cs	*cs;
+	struct spi_transfer	*tr;
+	u8 bits_per_word;
 
-	/* Only a single channel can have the FORCE bit enabled
+	/*
+	 * The conditions are strict, it is mandatory to check each transfer of the list to see if
+	 * multi-mode is applicable.
+	 */
+	mcspi->use_multi_mode = true;
+	list_for_each_entry(tr, &msg->transfers, transfer_list) {
+		if (!tr->bits_per_word)
+			bits_per_word = msg->spi->bits_per_word;
+		else
+			bits_per_word = tr->bits_per_word;
+
+		/*
+		 * Check if this transfer contains only one word;
+		 */
+		if (bits_per_word < 8 && tr->len == 1) {
+			/* multi-mode is applicable, only one word (1..7 bits) */
+		} else if (bits_per_word >= 8 && tr->len == bits_per_word / 8) {
+			/* multi-mode is applicable, only one word (8..32 bits) */
+		} else {
+			/* multi-mode is not applicable: more than one word in the transfer */
+			mcspi->use_multi_mode = false;
+		}
+
+		/* Check if transfer asks to change the CS status after the transfer */
+		if (!tr->cs_change)
+			mcspi->use_multi_mode = false;
+
+		/*
+		 * If at least one message is not compatible, switch back to single mode
+		 *
+		 * The bits_per_word of certain transfer can be different, but it will have no
+		 * impact on the signal itself.
+		 */
+		if (!mcspi->use_multi_mode)
+			break;
+	}
+
+	omap2_mcspi_set_mode(ctlr);
+
+	/* In single mode only a single channel can have the FORCE bit enabled
 	 * in its chconf0 register.
 	 * Scan all channels and disable them except the current one.
 	 * A FORCE can remain from a last transfer having cs_change enabled
+	 *
+	 * In multi mode all FORCE bits must be disabled.
 	 */
 	list_for_each_entry(cs, &ctx->cs, node) {
-		if (msg->spi->controller_state == cs)
+		if (msg->spi->controller_state == cs && !mcspi->use_multi_mode) {
 			continue;
+		}
 
 		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE)) {
 			cs->chconf0 &= ~OMAP2_MCSPI_CHCONF_FORCE;

-- 
2.43.0


