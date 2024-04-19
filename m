Return-Path: <linux-kernel+bounces-151563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002578AB07D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A051F26A88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14F12D76E;
	Fri, 19 Apr 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deB2QTFG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621012F59A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536056; cv=none; b=SkCW4Lwq7wBKucYvG+CKIOvnTtiZ03m78Cz9udbHacX8L51Pp9X6pKZDGsJJmS4LfELAaeJT3/z1r6mOXf51+SqB5JzEZt99f2u2lfQjs+OLWFzXGFLyfPNTROBPnv2BmQ8N/3SvK5okdKjZLzw91Z9eaxAcbUV0+AEVk0GoXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536056; c=relaxed/simple;
	bh=ZiwsAW01Vo0W/LIsWonJMl/TomhMGShCbtNy1DqFzs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhN5zUlR93oZmGv1bwGIU1ZJSP8/2erdF0wzoPXANPo2rXYnuHZqbRZyia4ZSNcKtkiKEDPmrOMsl4pjqP1V+D1RnwkgeUjg9DZ76ytETMcAGUqoc+EbXxAd86yULazJ9mSsXWETfjZza3LhdrkS5W2Um6CjaDoIadpldnzOILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deB2QTFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306E4C072AA;
	Fri, 19 Apr 2024 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536056;
	bh=ZiwsAW01Vo0W/LIsWonJMl/TomhMGShCbtNy1DqFzs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deB2QTFGDKjdUBu0Q5WELIIiO5HhzOLZ7gcHlleifYuS24mXPFrzTu6lN28JmfA6P
	 TUw+RBKKNKoZXDLgx1b3cO3niv8S5w5oRwdiYxnVutR1KsBiwB++p5lrAjCBoBVv5J
	 f2NedEPAOjVHxT3sj6Mz4ZXq/e607XsamxO/tOyCfvXcdPdp865QfErNOOiK9FMJhs
	 l62w8gCcMeGFWu5/ppd7DvoLdJ8Ad770WMuSibO58MrpVOQkKtc3Yb9xB4P3x0MrgF
	 WysT3sAN6Mw77z8sBKpZg10JcwOwOHjJSgzVpZ4dOdvaJaej7zgSficI9SDPzeMtuP
	 +CQrT5SiL+KyA==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 4/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
Date: Fri, 19 Apr 2024 16:12:47 +0200
Message-Id: <20240419141249.609534-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419141249.609534-1-mwalle@kernel.org>
References: <20240419141249.609534-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evervision FRAM devices are the only user of the NO_FR flag. Drop
the global flag and instead use a manufacturer fixup for the evervision
flashes to drop the fast read support.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Please note, that the fast read opcode will still be set in
spi_nor_init_default_params(), but the selection of the read opcodes
just depends on the mask.

That is also something I want to fix soon: the opcodes can always
be set and the drivers/SFDP will only set the mask. Opcodes then can be
switched between 3b and 4b ones if necessary.
---
 drivers/mtd/spi-nor/core.c     |  9 ++-------
 drivers/mtd/spi-nor/core.h     |  2 --
 drivers/mtd/spi-nor/everspin.c | 19 +++++++++++++++----
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f4c0b5185818..4e2ae6642d4c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2923,15 +2923,10 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
 	params->n_banks = info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
 
-	if (!(info->flags & SPI_NOR_NO_FR)) {
-		/* Default to Fast Read for DT and non-DT platform devices. */
+	/* Default to Fast Read for non-DT and enable it if requested by DT. */
+	if (!np || of_property_read_bool(np, "m25p,fast-read"))
 		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
 
-		/* Mask out Fast Read if not requested at DT instantiation. */
-		if (np && !of_property_read_bool(np, "m25p,fast-read"))
-			params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
-	}
-
 	/* (Fast) Read settings. */
 	params->hwcaps.mask |= SNOR_HWCAPS_READ;
 	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ],
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 497957b64906..1516b6d0dc37 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -470,7 +470,6 @@ struct spi_nor_id {
  *                            Usually these will power-up in a write-protected
  *                            state.
  *   SPI_NOR_NO_ERASE:        no erase command needed.
- *   SPI_NOR_NO_FR:           can't do fastread.
  *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
  *   SPI_NOR_RWW:             flash supports reads while write.
  *
@@ -519,7 +518,6 @@ struct flash_info {
 #define SPI_NOR_BP3_SR_BIT6		BIT(4)
 #define SPI_NOR_SWP_IS_VOLATILE		BIT(5)
 #define SPI_NOR_NO_ERASE		BIT(6)
-#define SPI_NOR_NO_FR			BIT(7)
 #define SPI_NOR_QUAD_PP			BIT(8)
 #define SPI_NOR_RWW			BIT(9)
 
diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index 5f321e24ae7d..0720a61947e7 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -14,28 +14,39 @@ static const struct flash_info everspin_nor_parts[] = {
 		.size = SZ_16K,
 		.sector_size = SZ_16K,
 		.addr_nbytes = 2,
-		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+		.flags = SPI_NOR_NO_ERASE,
 	}, {
 		.name = "mr25h256",
 		.size = SZ_32K,
 		.sector_size = SZ_32K,
 		.addr_nbytes = 2,
-		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+		.flags = SPI_NOR_NO_ERASE,
 	}, {
 		.name = "mr25h10",
 		.size = SZ_128K,
 		.sector_size = SZ_128K,
-		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+		.flags = SPI_NOR_NO_ERASE,
 	}, {
 		.name = "mr25h40",
 		.size = SZ_512K,
 		.sector_size = SZ_512K,
-		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+		.flags = SPI_NOR_NO_ERASE,
 	}
 };
 
+static void evervision_nor_default_init(struct spi_nor *nor)
+{
+	/* Everspin FRAMs don't support the fast read opcode. */
+	nor->params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
+}
+
+static const struct spi_nor_fixups evervision_nor_fixups = {
+	.default_init = evervision_nor_default_init,
+};
+
 const struct spi_nor_manufacturer spi_nor_everspin = {
 	.name = "everspin",
 	.parts = everspin_nor_parts,
 	.nparts = ARRAY_SIZE(everspin_nor_parts),
+	.fixups = &evervision_nor_fixups,
 };
-- 
2.39.2


