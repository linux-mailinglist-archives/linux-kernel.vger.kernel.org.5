Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB74772591
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHGNYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHGNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13B2738
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247D961AB6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66B1C433C8;
        Mon,  7 Aug 2023 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414565;
        bh=jKxDZT+qryyIWW++zQGnQdmrNqAzQRffxtMJjsy7a/M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QFh+Ql016qz9TwuDvDry0MMiDxx2Ih/sIl4sKcDeqqZXGKLLTh5+shX+rEwao3TRW
         AkcKno/AXD3dPHMAkmkz9di9vHoq27ZfxJH4rKtuGRYeaI1lJSJQmgw20I/fk+BUPs
         ivzvHUsCE2ECTT9GoQn62VvHhoW8Q8YVwkMOlg8t00Y8YxLkHcIOn6EwC20zD/9d87
         YJ9IKnjau7wsliL0f3qCaceW8DMZMewqWASIQq9Kvd3BKlYjOV9Gy0oZD034m1Tbju
         XVVzP5mN7/MEmukVGgEmyM2U0s17jq0Yb4pLq5UiZKLyyFalAEfuP9pnPoDkz0jUZU
         fHFJJ3FGwLPzQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:19 +0200
Subject: [PATCH 25/41] mtd: spi-nor: micron-st: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-25-3d3d5bef4ba4@kernel.org>
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

The INFOx() macros are going away. Convert the flash_info database to
the new format.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/micron-st.c | 405 ++++++++++++++++++++++++++--------------
 1 file changed, 268 insertions(+), 137 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 229c951efcce..720fd2fbd0ad 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -159,148 +159,279 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 };
 
 static const struct flash_info micron_nor_parts[] = {
-	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ |
-			   SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE)
-		MFR_FLAGS(USE_FSR)
-		.fixups = &mt35xu512aba_fixups
-	},
-	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		MFR_FLAGS(USE_FSR)
+	{
+		.id = SNOR_ID(0x2c, 0x5b, 0x1a),
+		.name = "mt35xu512aba",
+		.sector_size = SZ_128K,
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ |
+				 SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP,
+		.mfr_flags = USE_FSR,
+		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixups = &mt35xu512aba_fixups,
+	}, {
+		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
+		.name = "mt35xu02g",
+		.sector_size = SZ_128K,
+		.size = SZ_256M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ,
+		.mfr_flags = USE_FSR,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	},
 };
 
 static const struct flash_info st_nor_parts[] = {
-	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64)
-		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
-	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64)
-		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
-	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
+	{
+		.id = SNOR_ID(0x20, 0xbb, 0x15),
+		.name = "n25q016a",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x16),
+		.name = "n25q032",
+		.size = SZ_4M,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x16),
+		.name = "n25q032a",
+		.size = SZ_4M,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x17),
+		.name = "n25q064",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x17),
+		.name = "n25q064a",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x18),
+		.name = "n25q128a11",
+		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x18),
+		.name = "n25q128a13",
+		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x19, 0x10, 0x44, 0x00),
+		.name = "mt25ql256a",
+		.size = SZ_32M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x19),
+		.name = "n25q256a",
+		.size = SZ_32M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x19, 0x10, 0x44, 0x00),
+		.name = "mt25qu256a",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x19),
+		.name = "n25q256ax1",
+		.size = SZ_32M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x20, 0x10, 0x44, 0x00),
+		.name = "mt25ql512a",
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x20),
+		.name = "n25q512ax3",
+		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
+		.name = "mt25qu512a",
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x20),
+		.name = "n25q512a",
+		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x21),
+		.name = "n25q00",
+		.size = SZ_128M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6 | NO_CHIP_ERASE,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x21),
+		.name = "n25q00a",
+		.size = SZ_128M,
+		.flags = NO_CHIP_ERASE,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x22),
+		.name = "mt25ql02g",
+		.size = SZ_256M,
+		.flags = NO_CHIP_ERASE,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x22),
+		.name = "mt25qu02g",
+		.size = SZ_256M,
+		.flags = NO_CHIP_ERASE,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_FSR,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x10),
+		.name = "m25p05",
+		.sector_size = SZ_32K,
+		.size = SZ_64K,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x11),
+		.name = "m25p10",
+		.sector_size = SZ_32K,
+		.size = SZ_128K,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x12),
+		.name = "m25p20",
+		.size = SZ_256K,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x13),
+		.name = "m25p40",
+		.size = SZ_512K,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x14),
+		.name = "m25p80",
+		.size = SZ_1M,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x15),
+		.name = "m25p16",
+		.size = SZ_2M,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x16),
+		.name = "m25p32",
+		.size = SZ_4M,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x17),
+		.name = "m25p64",
+		.size = SZ_8M,
+	}, {
+		.id = SNOR_ID(0x20, 0x20, 0x18),
+		.name = "m25p128",
+		.sector_size = SZ_256K,
+		.size = SZ_16M,
+	}, {
+		.name = "m25p05-nonjedec",
+		.sector_size = SZ_32K,
+		.size = SZ_64K,
+	}, {
+		.name = "m25p10-nonjedec",
+		.sector_size = SZ_32K,
+		.size = SZ_128K,
+	}, {
+		.name = "m25p20-nonjedec",
+		.size = SZ_256K,
+	}, {
+		.name = "m25p40-nonjedec",
+		.size = SZ_512K,
+	}, {
+		.name = "m25p80-nonjedec",
+		.size = SZ_1M,
+	}, {
+		.name = "m25p16-nonjedec",
+		.size = SZ_2M,
+	}, {
+		.name = "m25p32-nonjedec",
+		.size = SZ_4M,
+	}, {
+		.name = "m25p64-nonjedec",
+		.size = SZ_8M,
+	}, {
+		.name = "m25p128-nonjedec",
+		.sector_size = SZ_256K,
+		.size = SZ_16M,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x11),
+		.name = "m45pe10",
+		.size = SZ_128K,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x14),
+		.name = "m45pe80",
+		.size = SZ_1M,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x15),
+		.name = "m45pe16",
+		.size = SZ_2M,
+	}, {
+		.id = SNOR_ID(0x20, 0x80, 0x12),
+		.name = "m25pe20",
+		.size = SZ_256K,
+	}, {
+		.id = SNOR_ID(0x20, 0x80, 0x14),
+		.name = "m25pe80",
+		.size = SZ_1M,
+	}, {
+		.id = SNOR_ID(0x20, 0x80, 0x15),
+		.name = "m25pe16",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x20, 0x71, 0x15),
+		.name = "m25px16",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x20, 0x71, 0x16),
+		.name = "m25px32",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x20, 0x73, 0x16),
+		.name = "m25px32-s0",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x20, 0x63, 0x16),
+		.name = "m25px32-s1",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x20, 0x71, 0x17),
+		.name = "m25px64",
+		.size = SZ_8M,
+	}, {
+		.id = SNOR_ID(0x20, 0x71, 0x14),
+		.name = "m25px80",
+		.size = SZ_1M,
 	},
-	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-		      SPI_NOR_BP3_SR_BIT6 | NO_CHIP_ERASE)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048)
-		FLAGS(NO_CHIP_ERASE)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096)
-		FLAGS(NO_CHIP_ERASE)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096)
-		FLAGS(NO_CHIP_ERASE)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_FSR)
-	},
-
-	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2) },
-	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4) },
-	{ "m25p20",  INFO(0x202012,  0,  64 * 1024,   4) },
-	{ "m25p40",  INFO(0x202013,  0,  64 * 1024,   8) },
-	{ "m25p80",  INFO(0x202014,  0,  64 * 1024,  16) },
-	{ "m25p16",  INFO(0x202015,  0,  64 * 1024,  32) },
-	{ "m25p32",  INFO(0x202016,  0,  64 * 1024,  64) },
-	{ "m25p64",  INFO(0x202017,  0,  64 * 1024, 128) },
-	{ "m25p128", INFO(0x202018,  0, 256 * 1024,  64) },
-
-	{ "m25p05-nonjedec",  INFO0( 32 * 1024,   2) },
-	{ "m25p10-nonjedec",  INFO0( 32 * 1024,   4) },
-	{ "m25p20-nonjedec",  INFO0( 64 * 1024,   4) },
-	{ "m25p40-nonjedec",  INFO0( 64 * 1024,   8) },
-	{ "m25p80-nonjedec",  INFO0( 64 * 1024,  16) },
-	{ "m25p16-nonjedec",  INFO0( 64 * 1024,  32) },
-	{ "m25p32-nonjedec",  INFO0( 64 * 1024,  64) },
-	{ "m25p64-nonjedec",  INFO0( 64 * 1024, 128) },
-	{ "m25p128-nonjedec", INFO0(256 * 1024,  64) },
-
-	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2) },
-	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16) },
-	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32) },
-
-	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4) },
-	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16) },
-	{ "m25pe16", INFO(0x208015,  0, 64 * 1024, 32)
-		NO_SFDP_FLAGS(SECT_4K) },
-
-	{ "m25px16",    INFO(0x207115,  0, 64 * 1024, 32)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "m25px32",    INFO(0x207116,  0, 64 * 1024, 64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "m25px32-s0", INFO(0x207316,  0, 64 * 1024, 64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "m25px32-s1", INFO(0x206316,  0, 64 * 1024, 64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "m25px64",    INFO(0x207117,  0, 64 * 1024, 128) },
-	{ "m25px80",    INFO(0x207114,  0, 64 * 1024, 16) },
 };
 
 /**

-- 
2.39.2

