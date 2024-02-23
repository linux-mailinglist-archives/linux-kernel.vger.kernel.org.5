Return-Path: <linux-kernel+bounces-78020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC3860E09
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BB01F25DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F195CDEE;
	Fri, 23 Feb 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e5FkuvEU"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A21A731;
	Fri, 23 Feb 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680779; cv=none; b=fuwxbviTqkX1LRWh7N4uf2dk56dSicgXS4gFR5M0aw4cCv9e/cXUmq5DM/eljcRgf6U2xEGyx7zpLA3LTUTKlrMJ6GzXTNkMq7c3GUFp0+0KNGZj4D4xrSjKRo8CObAkwglVh2CZC6eFHgFbQCUvrzwJeBnRrD2cd4jbRJ3JV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680779; c=relaxed/simple;
	bh=e4RXBe7SdrRLGGStxY/kvqt/kAPWHBSBirHEGGNnVHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYwY9dipaFyv1OgyVklSj+uHjdvMdScWkejES8R29gd6+z/QykzG4vy4CWRFUeztGh6ekGhiq2hcMwgHdE98LEE2MRvk658EEGIlxu0FGa+I4xYV5b/csZ+7HGSyaT+Q6QXc9PBzo+d1tp/uzufXb2QcagiaPYChC9peIwRmo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e5FkuvEU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5792D20013;
	Fri, 23 Feb 2024 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708680768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2oRLe0RRlPq8BsMAid2UDLfRRqpSJFqF07a/MXQocI=;
	b=e5FkuvEU2Mtn0cO+/Pa1PC8U8ugIYJVnlW4u1isMnfRprKNsfXGnJv0iLEelAWSBkPl1tH
	6B0/VxrzJaFqOYsWkxXb+itolf3E4GBHd8De+VJHYTFVe7W5lz+ZjJYyWd7shkQSQxO1H5
	v9GX8t6lPIvjgjoeWbNr5tU8SyXmZDP1EBO828Ks0U7oBxUacIDgoljkHKg+AcjzPdBwaQ
	sD3IFPuSOI2/T1JIuIonLCdH6b4SFvzaYrLoZco63ffJwl88Pv9WdZ9PKAl5D7RgHt0y4q
	Eqv9VIy+ZOIeMMEIfmLHehO9FidUyC+yM6dw6lPs1MQvNPS5KlAXIcM6Qv3KaA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 10:32:13 +0100
Subject: [PATCH v2 3/3] spi: omap2-mcpsi: Enable MULTI-mode in more
 situations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-spi-omap2-mcspi-multi-mode-v2-3-afe94476b9c3@bootlin.com>
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
In-Reply-To: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=e4RXBe7SdrRLGGStxY/kvqt/kAPWHBSBirHEGGNnVHY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2GY3HapgT8vFrAzfkho/rXRT8omzMteYRE6HA4M9
 wXk7xeeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdhmNwAKCRAgrS7GWxAs4mxzD/
 0debrX/LIA5gA7Z8tqa7TLIMcoQ0g8WrhuUEvSDtPE+T97+U0bdmBZoTTWtDv517MiqFcjO8JUjKJo
 7rVm1WjO4FKfAZX3MV0vXWPsPqQsmSTsCNEofs1AYGhJV67el0jM+NCfWnZcRX3sxEhGbvgmGUVmx0
 3CitqWMhGGCVsz8H3UncBec47ut7lHvmNpQ1oY41KyLbwmizqCoIwxJYMimwa6rTRAgu4+CWIkwdt1
 ZytzZMlcxrz8p4pb62qv3ei7KE/o7pU3RMNTe39LoAiReSyjhSXlMgDgFXVWhlgZUYgxLdTxKa70Lw
 Av41sUyxGTFN/HMMFoQFdQ04/5L5WmohvgwjC00VLPaMa+itxmxlOYOcxRWqu+/09NimNImd3GhRf4
 hso9WljUe9vPBxl6qhfax3iZ4lZH1KcP9jgmHPpzD05cohjIGXBn8gks6WJuS8MP7UtJFJFtQPCk+v
 PQbTqcz6135eTKjdL1XyoApJzYHYuUoqNEr0QV1G/kzleFVBH+y+PZeC0YETr3J6o9hFeGX1rObvvP
 52fGXdSmGd7fWwi4QnR1faq2TnnBtxLtw015zUhcWJbiNSRLNyTwICzzzxTkx6aUgeEu2OzJtLVq2d
 +GqOShz/Yve+48NUEGNi010THIKw3+e/j84uC8+8YeK9PXJc1IJnEdFpP+Rg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Enable multimode when a transfer of multiple small words can be
transformed in a transfer with a single bigger word. This is allowed as
long as the result on the cable is the same, so word_delay must be zero.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

---

I am not sure if this is the best place to put such "optimization". I
think this improvment should be in the core, as it is not depending on the
driver itself, but I think Mark suggested something like this so if that
fits to what was expected, I am happy to share this small improvement.
---
 drivers/spi/spi-omap2-mcspi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 36075c4416d5..f64cc8cc7587 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1397,14 +1397,26 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 		else
 			bits_per_word = tr->bits_per_word;
 
-	/* Only a single channel can have the FORCE bit enabled
 		/*
 		 * Check if this transfer contains only one word;
+		 * OR contains 1 to 4 words, with bits_per_word == 8 and no delay between each word
+		 * OR contains 1 to 2 words, with bits_per_word == 16 and no delay between each word
+		 *
+		 * If one of the two last case is true, this also change the bits_per_word of this
+		 * transfer to make it a bit faster.
+		 * It's not an issue to change the bits_per_word here even if the multi-mode is not
+		 * applicable for this message, the signal on the wire will be the same.
 		 */
 		if (bits_per_word < 8 && tr->len == 1) {
 			/* multi-mode is applicable, only one word (1..7 bits) */
+		} else if (tr->word_delay.value == 0 && bits_per_word == 8 && tr->len <= 4) {
+			/* multi-mode is applicable, only one "bigger" word (8,16,24,32 bits) */
+			tr->bits_per_word = tr->len * bits_per_word;
+		} else if (tr->word_delay.value == 0 && bits_per_word == 16 && tr->len <= 2) {
+			/* multi-mode is applicable, only one "bigger" word (16,32 bits) */
+			tr->bits_per_word = tr->len * bits_per_word / 2;
 		} else if (bits_per_word >= 8 && tr->len == bits_per_word / 8) {
-			/* multi-mode is applicable, only one word (8..32 bits) */
+			/* multi-mode is applicable, only one word (9..15,17..32 bits) */
 		} else {
 			/* multi-mode is not applicable: more than one word in the transfer */
 			mcspi->use_multi_mode = false;

-- 
2.43.0


