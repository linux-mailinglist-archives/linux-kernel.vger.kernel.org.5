Return-Path: <linux-kernel+bounces-142751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D78A2FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425CB1C23C18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428F84FAC;
	Fri, 12 Apr 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5bW4N7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F684E1C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929461; cv=none; b=CzWEZk5f1tOv7hQ8q65wC6Nnz3ZL4kGxhlVK5bHzRUv1gVYtNX5ZjlGOC7wwcED9N0nHxYZy0ULFkaebtw5FRRsSqYhSu1j1u6vTwKDDhU60pbcc1e2AjhtezQH0WkE0aZeAXTjlIG1wdyye9qgUWBV9ynwVOpnjR2aP4g4YXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929461; c=relaxed/simple;
	bh=AWw8QbtlrB4/ifJTs50t8o18KiRdvOyj1VqAGw4riZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPp331ox/HpH2u3vuAHNC9BC24zbdGAcn5FHSpBNwOR4nGvcTftMoID0UBXiHQLSe+1eg7BnYe2XkdFktY4nos3zcgxhR3BZDaEYsQA2qIzByVKDtKVtFM0ZsLboLSciIfrvmZJ/PvaMqCTHWA5p8q/GNFiNZM757sCtSsRi2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5bW4N7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D29C113CC;
	Fri, 12 Apr 2024 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929460;
	bh=AWw8QbtlrB4/ifJTs50t8o18KiRdvOyj1VqAGw4riZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5bW4N7YtsBTPZQWSl+W7pqUwakqlNtumlkAg3tNKkn33l87kakt6DdsnqGeyuBDA
	 IrHE+Csk5ZZ2gM8lNWKZQzuL6LB/ttsAtxdBLEdBF2Mt7rHGHuEWyjwivTspBisfFh
	 XEUXOq0vPnOTHYrK+WKNRKCPtGPWFJ4W7wlEZxK3xSNsCPKUOLRdAPoHNBkXivy/tw
	 X7Cy1uEJsQSHgpFNM2OSjXW2BTJaQZ8mmnBf8fSQtME0rY4eBJq56ImlqUaRaoApWD
	 xCqwVXBclDHmA9aMU94FzT6n61R1GBQT4x1uCBKl8iLOiT1qFM2W+VnEYsdldxxyyu
	 t/lzEfqalFtwQ==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
Date: Fri, 12 Apr 2024 15:44:02 +0200
Message-Id: <20240412134405.381832-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412134405.381832-1-mwalle@kernel.org>
References: <20240412134405.381832-1-mwalle@kernel.org>
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
 drivers/mtd/spi-nor/core.c     | 12 +++++-------
 drivers/mtd/spi-nor/core.h     |  2 --
 drivers/mtd/spi-nor/everspin.c | 19 +++++++++++++++----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index fb76e0522665..65e6531ada0a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2952,14 +2952,12 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
 	params->n_banks = info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
 
-	if (!(info->flags & SPI_NOR_NO_FR)) {
-		/* Default to Fast Read for DT and non-DT platform devices. */
-		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
+	/* Default to Fast Read for DT and non-DT platform devices. */
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
 
-		/* Mask out Fast Read if not requested at DT instantiation. */
-		if (np && !of_property_read_bool(np, "m25p,fast-read"))
-			params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
-	}
+	/* Mask out Fast Read if not requested at DT instantiation. */
+	if (np && !of_property_read_bool(np, "m25p,fast-read"))
+		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
 
 	/* (Fast) Read settings. */
 	params->hwcaps.mask |= SNOR_HWCAPS_READ;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 072c69b0d06c..9aa7d6399c8a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -479,7 +479,6 @@ struct spi_nor_id {
  *                            Usually these will power-up in a write-protected
  *                            state.
  *   SPI_NOR_NO_ERASE:        no erase command needed.
- *   SPI_NOR_NO_FR:           can't do fastread.
  *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
  *   SPI_NOR_RWW:             flash supports reads while write.
  *
@@ -528,7 +527,6 @@ struct flash_info {
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


