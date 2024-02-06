Return-Path: <linux-kernel+bounces-54636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4084B1D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E1E2810F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF87112D77F;
	Tue,  6 Feb 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J+oeDK55"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297F12D76D;
	Tue,  6 Feb 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213671; cv=none; b=sxQgZ/anhhZ8fIQ2jHWN1uubm51RhaRUsqQQdF+5CQmsab5vvt53AKh3XTwGc4HviE2Ctg7/JhrCfDfkGdYQAR30SeBrF71CWZVoylpU/y6WmKPoB1Z7wQ3fw4xCjobWay+uVsrtGQhgaZrQ+pr2cwGJnA3OV0f83zin5RBPlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213671; c=relaxed/simple;
	bh=dLeoHdat5+2yokZ57ZMb1U/V1RdRR+uIGAJcxMGtu2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXMfIgqAv9PCADsR/RFCbEOQZ7U6oya9xcPZ3/cxWRtChTB707i05sqzQe1I1dU/Vx1xniMRhF8fZTpvK/m5vNTw1YjKTjTswx6o3o0NxfPAREfFmChIlzC+r5JbZM8/EukekvnaJtJbwEtOKrvuUezj/cY69xsw8kbBrFBtcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J+oeDK55; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3893B240012;
	Tue,  6 Feb 2024 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707213661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZyyNB/CZxx9/DUWNjxPsDT3HiAzuHwEEv/w7sNe/Cg=;
	b=J+oeDK55buHO+8CcYynTWmMMg+qfgizl8HUCfvSWyp4iSLtf04Hrv1xBFwTLYw7usBX6hW
	bxBKB0AAWZVRQJl0OFoTuTdayGkVo8gonZRhgf6MVdEBDnuAWxJAQv3cF6I7ORwJVnpCga
	GVbs1PyXfU/2cFsGuhwy4+f0mbQIXImEwfyEeI2Ng7dfIxDJpC8nWXcfyrRyv34ThBp3Yc
	85Dv1RIAnDczpOLW7kaNqDFy+eYAQuT0ZRkwZuDln+TME8QSuQ05mYXu9aRfVSljWv9jWB
	WNaxMsrFcVh7GkKRze01RKD61HwtXvIG0ryznNkL5KfgCA4umFyR9BNR0eJtiA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 06 Feb 2024 11:00:50 +0100
Subject: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>
References: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
In-Reply-To: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=dLeoHdat5+2yokZ57ZMb1U/V1RdRR+uIGAJcxMGtu2w=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBlwgNc490SgPJdYZBCh8N73jiZS1KgRhcdKvOucQHs
 mmRLqHWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZcIDXAAKCRAgrS7GWxAs4rhwD/
 9jG8LYFgLIO0pYCUnLTGlca5mn6PEjqk+gZKi2JAcQ5/p1YlnV6w3ZSuFqOY+FgNXAPc0voIN/P9T2
 yJztrL12vfJf90d5D4SptCK0Ncmv+bJguUiY9ELbwqa6y67EoecbKnb3kIbGJ1foqbJaq1Qw3gZGtY
 WMF7Mkz2fngaQeAOctrnBT8Fs1y4am7TZ+bhD5ffr/b2v6Fi9vSPPXo6/nVk79OXkt1XYcktDlUvF4
 3wHCDyeGfjw4E2sdmF3ZLXhC+SsEFbhqJZZ5m/gc3hItN9+pQ08jiYFX1QUjfx1SICnWL1j1Am5Moq
 qm82fjr/iekD3yBIYFYAQUojmR2PmGEXN2ieuwBMcRw1WXPX9bfaWj0wSzV70LNoNd4hmmLxu5C9MF
 KS8ydETXSG4HxoAtbLnLDc0+V+1YQUrIN0W63yX5fg6p1ZJ0NEGJfa8sRloViKKXBoqMqM/rYmVRnI
 i5St0q9kznSlgnBDDV8CR6cyu3EaDTbugGZz/yzoFQGyCALN+RaX7M1ELJMUl/9FiLF7Oo0rj5yJxr
 WA/ZCmfEs8jVNQhWeZwYPMHAgYRJ+762tML1CQBlFqbw3bdFbpAR1xziT3F1YsQL59zMKbPoNP+p60
 0ZEr008aPriW0QFXDtNRTkFnap9K2598aoRc14UNYKJm4xkIavAj5M7JkNqQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce support for MULTI-mode in the OMAP2 MCSPI driver. Currently, the
driver always uses SINGLE mode to handle the chip select (CS). With this
enhancement, MULTI-mode is enabled for specific messages, allowing for a
shorter delay between CS enable and the message (some FPGA devices are
sensitive to this delay).

The drawback of multi-mode is that it's not possible to keep the CS
enabled between each words. Therefore, this patch enables multi-mode only
for specific messages: the spi_message must contain only spi_transfer of 1
word (of any size) with cs_change enabled.

A new member is introduced in the omap2_mcspi structure to keep track of
the current used mode.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/spi/spi-omap2-mcspi.c | 57 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index fc7f69973334..ab22b1b062f3 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -133,6 +133,8 @@ struct omap2_mcspi {
 	unsigned int		pin_dir:1;
 	size_t			max_xfer_len;
 	u32			ref_clk_hz;
+
+	bool			use_multi_mode;
 };
 
 struct omap2_mcspi_cs {
@@ -258,10 +260,15 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 
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
 
@@ -285,7 +292,12 @@ static void omap2_mcspi_set_mode(struct spi_controller *ctlr)
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
 
@@ -1371,15 +1383,48 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	struct omap2_mcspi	*mcspi = spi_controller_get_devdata(ctlr);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	struct omap2_mcspi_cs	*cs;
+	struct spi_transfer	*tr;
+	u8 bits_per_word;
+	u32 speed_hz;
 
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
+		/* Check if the transfer content is only one word */
+		if ((bits_per_word < 8 && tr->len > 1) ||
+		    (bits_per_word >= 8 && tr->len > bits_per_word / 8))
+			mcspi->use_multi_mode = false;
+
+		/* Check if transfer asks to change the CS status after the transfer */
+		if (!tr->cs_change)
+			mcspi->use_multi_mode = false;
+
+		/* If at least one message is not compatible, switch back to single mode */
+		if (!mcspi->use_multi_mode)
+			break;
+	}
+
+	omap2_mcspi_set_mode(master);
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


