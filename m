Return-Path: <linux-kernel+bounces-120561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433E88D95F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DBD1C2724D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C39374FF;
	Wed, 27 Mar 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e8MtlAb1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE953398B;
	Wed, 27 Mar 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529029; cv=none; b=GqwKkY15xXl8t9gKi2XeSiyI8FJrPrNDRgflRocuww1V1avR6ltnzuhRS0yeur40mp+q44rXgGHZOiMv0AXIu3da2nKqunIUzpNUwPcCw1ml76lKL3w+BtjxIw1tUClhlAjXOygjawSiAxyxKVDEEwaWd7L0aM8ER3bh3tU5BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529029; c=relaxed/simple;
	bh=BrFNjhI8oLc26SSKfKHH6M/L+OciIVtrBnTYO5nLL64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dY60EY9EyM5CHNIET3YDTuUYgZ5+LBnIDd9qJnS/xarjG3bqmMacZbklB6zN5OP1qzhAu5jzJ/GsyCm/0CXSnpkC8KJyjHyV1WvE3iOrNFYQV7a5OXD9OO7e9L+wr+iQ0oV2tiQ/dnifc35zLuBotw5jUw9LnazkThZAhiSyJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e8MtlAb1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C3A4FF806;
	Wed, 27 Mar 2024 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711529025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knHSdAeL3C8xPiNb5BV1ixMXuco9YBgoOV7376ixMAg=;
	b=e8MtlAb1gLizUVrUWLAnv7MSFuCqG87189i5izDIbvatnrYSeTLq2NmaIae3jGhGZSWCPA
	5vbC9hXODrCKregYiq+CQNXgG74AscToTY7VLGojn+49xohpVwNHswnzCGvUV957WtbVng
	EFUSs7WWPyrmghpbzzjavDaddxf7Wa+ZayECQLxdKOjVYaNEQQNAiTZqy7ws3O8X1J9wHN
	aoRiepxPEFM/3w852FOekaK8oSCKI5PRmca0Ol8/4wcv/5dqopxjs/Y81T3f4d0/6d8uHN
	RLruLD3MWyl9F+fVwOpvXLv+mpsG3bkHA7a4+MPMnm/Wr4GAwumwiROFUn7DAQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 27 Mar 2024 09:43:36 +0100
Subject: [PATCH v3 1/3] spi: spi-omap2-mcspi.c: revert "Toggle CS after
 each word"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-spi-omap2-mcspi-multi-mode-v3-1-c4ac329dd5a2@bootlin.com>
References: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
In-Reply-To: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=BrFNjhI8oLc26SSKfKHH6M/L+OciIVtrBnTYO5nLL64=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA9w/NUAnDS/xLvqKxxcULsx6ggIPcYgTe+hD3tlb
 cclGh1mJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPcPwAKCRAgrS7GWxAs4jNlEA
 CByt+wrzLsf0tJos+LC6LHl5GBgNrz7OGAAxqKF3d0Jo/rsP0GEvseAmlM9+K8b4ON0CxX/fWH4qj5
 QBrItoWv3mw4zwVTe+c0T+04O91RGqRm11MPAtzp4+P3i50sEs2c69M7xqDaR77prFvZntRgtwfSf9
 rT74msmQT1QvjiQ6dPR77bxS4Z4Bpo+bH7hP1ZB2C47MAAqM6op3mSYvbYk6UzBopdH5gGm0pE47av
 L8/ouqGTbWnTQlUoRfumWvvB37HToeeuEzItqx7twjrqBR9HAIq5pwFh6LIO1wMxgOoNEgQsOaqvwn
 UEb7apefQxuSdTYKgzQwQKC5BEq9ZDTSyhkVhbjzd+p9fMqEYD+bqM/g+aupsyF9ve/JqC1vVkEJk/
 rX5qJ+Hhdhc+0hntAFxXbVtguhbc0d0w1zG8AwfVYHgYydr0XJMhyvmQKfhFISq/Mh7Co4tVa7OlIa
 OOOr/7VAd4QXwBM8swkLpI9qFRr9v7Noj6uzX+IyvSBuZXeE2ZKAmbvKpDeqDLEzUWYIIk4y5qojmM
 iqDUhIq8ngjBI3Nd+tg5eFiQD5CR53afN3FAXHfcv8kuOznjf/YT6ILzyuk//PpZDGThHev4DF12Bs
 rs/nO6qO2RTmQP13oNUBazSixe3KlizM/CRogSepSVX+JEFYnUa0Y3dSVocA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Commit 5cbc7ca987fb ("spi: spi-omap2-mcspi.c: Toggle CS after each
word") introduced the toggling of CS after each word for the omap2-mcspi
controller.

The implementation is not respectful of the actual spi_message
content, so the CS can be raised after each word even if the
transfer structure asks to keep the CS active for the whole operation.

As it is not used anyway in the current Linux tree, it can be safely
removed.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/spi/spi-omap2-mcspi.c                 | 15 ---------------
 include/linux/platform_data/spi-omap2-mcspi.h |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index ddf1c684bcc7..601acec37eca 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1175,13 +1175,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		    t->bits_per_word == spi->bits_per_word)
 			par_override = 0;
 	}
-	if (cd && cd->cs_per_word) {
-		chconf = mcspi->ctx.modulctrl;
-		chconf &= ~OMAP2_MCSPI_MODULCTRL_SINGLE;
-		mcspi_write_reg(ctlr, OMAP2_MCSPI_MODULCTRL, chconf);
-		mcspi->ctx.modulctrl =
-			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
-	}
 
 	chconf = mcspi_cached_chconf0(spi);
 	chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
@@ -1240,14 +1233,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		status = omap2_mcspi_setup_transfer(spi, NULL);
 	}
 
-	if (cd && cd->cs_per_word) {
-		chconf = mcspi->ctx.modulctrl;
-		chconf |= OMAP2_MCSPI_MODULCTRL_SINGLE;
-		mcspi_write_reg(ctlr, OMAP2_MCSPI_MODULCTRL, chconf);
-		mcspi->ctx.modulctrl =
-			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
-	}
-
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (spi_get_csgpiod(spi, 0))
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index 3b400b1919a9..9e3c15b4ac91 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -16,9 +16,6 @@ struct omap2_mcspi_platform_config {
 
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;
-
-	/* toggle chip select after every word */
-	unsigned cs_per_word:1;
 };
 
 #endif

-- 
2.43.0


