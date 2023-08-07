Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0154A772570
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHGNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjHGNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29431FE8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFAE61A91
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A259C433C8;
        Mon,  7 Aug 2023 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414536;
        bh=2LSNh1CL/QIV2fp5aEOR8agOGXE7ARnjMMxkvP9cqpM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qwfiwWQOsJkCQceip/EnBC5AkHBz1s36170dEGCozboqKj7G0Y3j/RUjdLu192JjQ
         80B8IZizUjdhclfEXtNN2fc02KUgUS9jVIJYgTK6qyzgTd1e3w9LdGFBPYgmrsE1ep
         q2C1ZbDfQWX6KKo7FVZv4IdY3qS7o0dtyZyTNXTAraZnmjb14QGUdaDdvbFVGpUlUQ
         L3PhRPPE/wWIYOcvXo6KhUApph3GV+afKQhk1bnNohZsMrnrwnkcYhp91iHg/j+EIE
         OWnLY/NsCjIIT7XM4ttFJphMWsZbwpKNoUabTOWNgBNn1yl66ilPV9KYSaLYGd81RM
         9rW22MOM6tptg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:05 +0200
Subject: [PATCH 11/41] mtd: spi-nor: drop .parse_sfdp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-11-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the size parameter to indicate we need to do SFDP, we can do that
because it is guaranteed that the size will be set by SFDP and because
PARSE_SFDP forced the SFDP parsing it must be overwritten.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c       |  3 +--
 drivers/mtd/spi-nor/core.h       | 23 ++++++++++++++++-------
 drivers/mtd/spi-nor/eon.c        |  3 +--
 drivers/mtd/spi-nor/gigadevice.c |  3 +--
 drivers/mtd/spi-nor/issi.c       |  4 +---
 drivers/mtd/spi-nor/macronix.c   |  1 -
 drivers/mtd/spi-nor/spansion.c   | 12 ------------
 drivers/mtd/spi-nor/winbond.c    |  7 ++-----
 8 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cf0e25b4f9a9..41612b9f1098 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2016,7 +2016,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 
 static const struct flash_info spi_nor_generic_flash = {
 	.name = "spi-nor-generic",
-	.parse_sfdp = true,
 };
 
 static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
@@ -3068,7 +3067,7 @@ static int spi_nor_init_params(struct spi_nor *nor)
 
 	spi_nor_init_default_params(nor);
 
-	if (nor->info->parse_sfdp) {
+	if (spi_nor_needs_sfdp(nor)) {
 		ret = spi_nor_parse_sfdp(nor);
 		if (ret) {
 			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP when declaring the flash\n");
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 734aedd4d62c..d9bf7a24ae1f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -460,9 +460,6 @@ struct spi_nor_fixups {
  * @page_size:      (optional) the flash's page size. Defaults to 256.
  * @addr_nbytes:    number of address bytes to send.
  *
- * @parse_sfdp:     true when flash supports SFDP tables. The false value has no
- *                  meaning. If one wants to skip the SFDP tables, one should
- *                  instead use the SPI_NOR_SKIP_SFDP sfdp_flag.
  * @flags:          flags that indicate support that is not defined by the
  *                  JESD216 standard in its SFDP tables. Flag meanings:
  *   SPI_NOR_HAS_LOCK:        flash supports lock/unlock via SR
@@ -521,7 +518,6 @@ struct flash_info {
 	u8 n_banks;
 	u8 addr_nbytes;
 
-	bool parse_sfdp;
 	u16 flags;
 #define SPI_NOR_HAS_LOCK		BIT(0)
 #define SPI_NOR_HAS_TB			BIT(1)
@@ -598,9 +594,6 @@ struct flash_info {
 			.n_regions = (_n_regions),			\
 		},
 
-#define PARSE_SFDP							\
-	.parse_sfdp = true,						\
-
 #define FLAGS(_flags)							\
 		.flags = (_flags),					\
 
@@ -740,6 +733,22 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 	return container_of(mtd, struct spi_nor, mtd);
 }
 
+/**
+ * spi_nor_needs_sfdp() - returns true if SFDP parsing is used for this flash.
+ *
+ * Return: true if SFDP parsing is needed
+ */
+static inline bool spi_nor_needs_sfdp(const struct spi_nor *nor)
+{
+	/*
+	 * The flash size is one property parsed by the SFDP. We use it as an
+	 * indicator whether we need SFDP parsing for a particular flash. I.e.
+	 * non-legacy flash entries in flash_info will have a size of zero iff
+	 * SFDP should be used.
+	 */
+	return nor->info->size;
+}
+
 #ifdef CONFIG_DEBUG_FS
 void spi_nor_debugfs_register(struct spi_nor *nor);
 void spi_nor_debugfs_shutdown(void);
diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index 50a11053711f..434aaf155856 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -25,8 +25,7 @@ static const struct flash_info eon_nor_parts[] = {
 	{ "en25qh64",   INFO(0x1c7017, 0, 64 * 1024,  128)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
 	{ "en25qh128",  INFO(0x1c7018, 0, 64 * 1024,  256) },
-	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512)
-		PARSE_SFDP },
+	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  0) },
 	{ "en25s64",	INFO(0x1c3817, 0, 64 * 1024,  128)
 		NO_SFDP_FLAGS(SECT_4K) },
 };
diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index d57ddaf1525b..7cf142c75529 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -62,8 +62,7 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
-	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
-		PARSE_SFDP
+	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 0)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &gd25q256_fixups },
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index accdf7aa2bfd..9d22b799ce94 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -62,8 +62,7 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
 	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512)
-		PARSE_SFDP
+	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 0)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64)
@@ -73,7 +72,6 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 0, 0)
-		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		FLAGS(SPI_NOR_QUAD_PP)
 		.fixups = &is25lp256_fixups },
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index eb149e517c1f..0f3bd3ed8eff 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -83,7 +83,6 @@ static const struct flash_info macronix_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx25uw51245g", INFOB(0xc2813a, 0, 0, 0, 4)
-		PARSE_SFDP
 		FLAGS(SPI_NOR_RWW) },
 	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 709822fced86..e6468569f178 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -849,59 +849,47 @@ static const struct flash_info spansion_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "s25fs256t",  INFO6(0x342b19, 0x0f0890, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25fs256t_fixups },
 	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hl02gt",  INFO6(0x342a1c, 0x0f0090, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		FLAGS(NO_CHIP_ERASE)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
 	{ "s25hs02gt",  INFO6(0x342b1c, 0x0f0090, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		FLAGS(NO_CHIP_ERASE)
 		.fixups = &s25hx_t_fixups },
 	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
 	{ "s28hl512t",   INFO(0x345a1a,      0, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hl01gt",   INFO(0x345a1b,      0, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hs512t",   INFO(0x345b1a,      0, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hs01gt",   INFO(0x345b1b,      0, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
 	{ "s28hs02gt",   INFO(0x345b1c,      0, 0, 0)
-		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index cd99c9a1c568..c21fed842762 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -126,8 +126,7 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		.fixups = &w25q256_fixups },
-	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512)
-		PARSE_SFDP },
+	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 0) },
 	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
@@ -135,10 +134,8 @@ static const struct flash_info winbond_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
 			      SPI_NOR_DUAL_READ) },
 	{ "w25q512nwq", INFO(0xef6020, 0, 0, 0)
-		PARSE_SFDP
 		OTP_INFO(256, 3, 0x1000, 0x1000) },
-	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
-		PARSE_SFDP
+	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 0)
 		OTP_INFO(256, 3, 0x1000, 0x1000) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |

-- 
2.39.2

