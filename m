Return-Path: <linux-kernel+bounces-78019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71619860E07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD4CB20D54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E075CDC8;
	Fri, 23 Feb 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sa9FhaQb"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6D5C8FE;
	Fri, 23 Feb 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680777; cv=none; b=GeJwK+syPlwB7o/VDGpHui9jbX9ItvazbBuHyMa2226vW2Lg6/+Acer0U/0HFd7I9lDa9RgbZQlRp4vJ/ATV+sXS5sMVTovYBFCZ4amfaFoaekTMaKisza0u336a2M0jFLgzwqk/VbUrQx/CcPYlYMGDDjJ3Gr8BTlx2Ukm8+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680777; c=relaxed/simple;
	bh=REkJW6D+RJj2jvyMJPDaFLG/dTj5svrfGt9foiTBjY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b50VGpie0QdV98iUMmh2Gn1Mhou7vz2v8hT928RWFTCkBN8dDjuvPtEwZ1OEistrduNuviEpoL1mlZuau8eKHnqQ6SVwamoeGvdyfrjxRyxaPpkWBMuXjDlsyLOodJ05OtawSkb+6s7NLrg6deVC3WtfKBvwoglTGYMztgunQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sa9FhaQb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C576720007;
	Fri, 23 Feb 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708680768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18CMWR936xnkrAvlSXRbSNlRO5ba3pEra3S0AcHTwKg=;
	b=Sa9FhaQbqqqrmjHHaac/7v6EuFYGJ+hgOm/wYhunzDVXtP446su8rwD0jG64kpSji8fstq
	WVNgvxXmp5aiSLCpktDgXcosvgYfIqt059Nsu227QlJawU/mboKTWaF1WmcH77ESpUKVAX
	3mTuBkjrAvuzrHKn770M2Ejw+xz834iQNt8YM05vaZpVMdMFsf0uplTACAwgPH4pDE1HbC
	AgrkU6GtGfa0NM8OOOSyNLDKlorbn+4XB+koCoIybL5ZDjQC1Itle+Euu4mw+5c9DwSdzq
	sl34i61DkZ76pbmNSyh4MFLaCnnl1LahhdzdowJgPAPw867+7EGJFHKmVCc8kQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 10:32:12 +0100
Subject: [PATCH v2 2/3] spi: omap2-mcspi: Add support for MULTI-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-spi-omap2-mcspi-multi-mode-v2-2-afe94476b9c3@bootlin.com>
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
In-Reply-To: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4770;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=REkJW6D+RJj2jvyMJPDaFLG/dTj5svrfGt9foiTBjY8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2GY3p7zkPy+VwQpD9XFH8rnxtAdeFSf8ySDohptW
 w4uVlYSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdhmNwAKCRAgrS7GWxAs4k50EA
 Ce0IEV895NOdDJXW+ddeg26Z9nT6amZJM74O/1Bq+bRck82AaZRcqiPWn5Rp+fVWAI1NVZdPoG0m6j
 nqzzvhB6aSxonbFKRRZye7Aj0qTTW9vSPsu3xg02o/p48QrKKvFpRfdTZPYI3jMpaBuhcohA3yKhp2
 IyoV3Prgjj3GD2KL5BnddbjqWJc+M6ShWICTQSQiTUHjbXSXz42SykIrGLAdoEp32D/BAi9/epA6T/
 52/mo9J2mkZDqNiaYhxEJlxFWe/wPk7oaSerzhYDm2lQV37WuXDeWBPKvBB5VyKR2hqvTcDRWOA7R+
 OfV+gGXG5JgTXgH2oS+08ySxPqDqIZV8uludN32aqsIL7ufdlhXofUHkjBhjn7xNZjkN1TEgNWVn42
 VWzIhEBt+dUDZfsQIWYpsSI2vrgKqvdHHqgxhNcPmHkH9IupgW+Esh/skE5lb9uRf4tObVhRTvY8kk
 9CGa3/37jWtBc7cmasfErDHDDG5nyC9KMbK9SQHf5yJoFxk0+6u+A3yYXUHG/CpRxE3hFdDSqholtQ
 pvXyjzxCeGBwQIA4aF7p1pEMgM7FV7EfLImyFWxznSYLyBhDhldl0gZDLfNnUk+eYj/4z3p1k/hd+i
 TrSJ1YTLxB7jwI7hMuQRus+oIosgR/gkkPNWr7XuROpeZ/aVjxTvEiTP+5qg==
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
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index fc7f69973334..36075c4416d5 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -133,6 +133,7 @@ struct omap2_mcspi {
 	unsigned int		pin_dir:1;
 	size_t			max_xfer_len;
 	u32			ref_clk_hz;
+	bool			use_multi_mode;
 };
 
 struct omap2_mcspi_cs {
@@ -258,10 +259,15 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 
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
 
@@ -285,7 +291,12 @@ static void omap2_mcspi_set_mode(struct spi_controller *ctlr)
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
 
@@ -1371,15 +1382,61 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	struct omap2_mcspi	*mcspi = spi_controller_get_devdata(ctlr);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	struct omap2_mcspi_cs	*cs;
+	struct spi_transfer	*tr;
+	bool word_delay_is_zero;
+	u8 bits_per_word;
+
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
 
 	/* Only a single channel can have the FORCE bit enabled
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


