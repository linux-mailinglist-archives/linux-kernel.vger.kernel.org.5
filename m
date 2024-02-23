Return-Path: <linux-kernel+bounces-78018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA6860E06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFB1F25E21
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7975C91E;
	Fri, 23 Feb 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cu6x2zgd"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9B5C902;
	Fri, 23 Feb 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680777; cv=none; b=o3krzgNyOwQFeVjAoLlTkYvbmKmg1Qh9xb9UnCxOS+TlDXknLrK5t+tx+WEkQRdhDC6hupdbiJuXEwQe/QVacyVjsakCM92hOJiPK77r7ZpUgnS928BRNIKPbj3iFo5Nmqmd3pJdA/CU4Xr672jJ1t/Kc+WfOSADascyUhG8UQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680777; c=relaxed/simple;
	bh=GCDrJjUFp3RJ0Y/5AvQUzZXLTy9PY6XVQC2ttAy8RRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KmXOuFvKWtjyDfZiMj/PqYcbVMkYxN8ZPDBviA7wMRNSJX36sswplWiJZ/8U9Y1aI/RsmaDPf0Kd/MezG5v+RAhVF4RTPeGO9AivPWwFb1BPkWZRb5qc0ygX34UwsGyD+ZJ1wg6/MocA+IfKHjC45YmMAE36B4SCiKInpTwRwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cu6x2zgd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 417F520012;
	Fri, 23 Feb 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708680767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3/kBXysZgOqeHBBvDliJdBFjiOsLlLOqL3slXKauXw=;
	b=Cu6x2zgdlJVsgmram6kHkZzFg9KruMBorCAQTGyChFv2lcm2YMWujh4BzkGqPiSDqbnk5y
	3wmKJDEKpyTygm57d2Brvkuj/E50uHO81Q3HFyAVOmChTuuecHvkkXVzSdXLo5voh4VwOI
	kAQHpkX0CEmhlHt1jeSEPUbiLs96cz3WV4tVN/fcC14frIrbZa0jDtqEDpbAgAbKf7LLdE
	/PaEW9aAaE70OdDS5udSXly/rRMxidtnBQX77nVM2ddpLCGufQauSkmYa3UerPIwaD1DEJ
	7pnJfqhHeEDHADaS7XdTnqtu731RtOY9wCk6ojaqpSITZeHvxAJF6y+gRGkTeQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 10:32:11 +0100
Subject: [PATCH v2 1/3] spi: spi-omap2-mcspi.c: revert "Toggle CS after
 each word"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-spi-omap2-mcspi-multi-mode-v2-1-afe94476b9c3@bootlin.com>
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
In-Reply-To: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=GCDrJjUFp3RJ0Y/5AvQUzZXLTy9PY6XVQC2ttAy8RRA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2GY3x6HHDnThiMCS4K03QmQtC9VdTVM5i+wAYJwJ
 QZpgr2aJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdhmNwAKCRAgrS7GWxAs4jz6D/
 9BDF/OlkikEstcIpzjUoZ2kJBk+g5qf4uU6kl9f4EOZPrBznv61eL3j3Rpq7ysgs5OAn2B1pp+i+wV
 YZf1HtLY3z9hQZUJT6NUKqJJHWuYifGAZSaj0Do1WB6RThXQa/1P4LUmCkTa55bfcTM5qtA/OvhW/O
 X/OuyLNGEyX4i5DhH3kEXsZyfuXCIXrFV0an/P6akDtcn9b0RbxLsm4ns6Ppm0oFgksa7JAS8Ol+Wn
 lNJ4em1jWz9gXTMqjgCFY02YEgJhlQ/u+jfXHNHC69OZLZfZtkwTYW69XcmzmIBvsXUoE8DhX6cqxs
 QiV+uJ70nniaft1VE3+p7JVDSfYmJY7e8uFtO17+KyaT8d2MQobyWV1E5HAl7PhenrXtMMhwmNxIEK
 IbZpbfMFojwZsz7Bvfo8d4T6wfinDj2TQIqUf1xZff2BC2vMkrN6YFH4DyiF7CQSQNszorMOCv5UlS
 iOLriagDx/rsGvhhEsiBv31Q3H5p6z/UUWzv3poiAkKUfqDp9gU6booTwVRIQd6y8fPWJCiPtTgyYi
 Z9v5Xn9bapOXNahOahDrUHicPuVG1HCt8aW8Tga3klA/KsUorpiBPIcLEvrfRqbAAijffFi6JixCbp
 isFoWIpNoICplphNXOy+K1uH6rYdt1ZP4IcaOiL7OijPFx0s/GWCHtWsbcVg==
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
index a0c9fea908f5..fc7f69973334 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1292,13 +1292,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
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
@@ -1361,14 +1354,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
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


