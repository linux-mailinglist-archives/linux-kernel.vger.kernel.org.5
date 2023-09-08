Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7F7985A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbjIHKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjIHKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1EB1FD5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:18:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D03C43140;
        Fri,  8 Sep 2023 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168265;
        bh=uBLUgzG+Qr84SJ0zH/c3GfOsYhPI41nZW9Idjp3TdLA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dPUcg4BHwryIXcOoR9syr/JWRq5X0t0zcQuw/kGbadHXABNYYt1A/KMb3ER9anFqK
         V+AOhbSE1y6oj8pqvMkYZ4GtW/GhkCHq+bxXgBYVSU+/bXsn/bHngIklYoBbmGu5zW
         4frKjz2vUIEoSb4xVtuNDsNX7ANcdG/rZYepebkXZ/b/NUN1yI07TIhfZbinkhhTKt
         P4EJugDI/LlhZRLlF/vfHvZzfup1ztYKjzFb+KPKL5yXhuDwVcQo9cF3rpS17/HWLe
         quH1q8NXoE5/IzDJ6jBpzUBFPGtPzzG1EEY+HGje4KIXtQbpMiGFbATd4W6EvoJ5Yk
         vWvksIXv4Kzlw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:54 +0200
Subject: [PATCH v3 36/41] mtd: spi-nor: micron-st: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-36-e60548861b10@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flash ID is the new primary key into our database. Sort the entry by
it. Keep the most specific ones first, because there might be ID
collisions between shorter and longer ones.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/micron-st.c | 336 ++++++++++++++++++++--------------------
 1 file changed, 168 insertions(+), 168 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 720fd2fbd0ad..4afcfc57c896 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -182,133 +182,35 @@ static const struct flash_info micron_nor_parts[] = {
 
 static const struct flash_info st_nor_parts[] = {
 	{
-		.id = SNOR_ID(0x20, 0xbb, 0x15),
-		.name = "n25q016a",
-		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x16),
-		.name = "n25q032",
-		.size = SZ_4M,
-		.no_sfdp_flags = SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x16),
-		.name = "n25q032a",
-		.size = SZ_4M,
-		.no_sfdp_flags = SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x17),
-		.name = "n25q064",
-		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x17),
-		.name = "n25q064a",
-		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x18),
-		.name = "n25q128a11",
-		.size = SZ_16M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
-	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x18),
-		.name = "n25q128a13",
-		.size = SZ_16M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
-	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x19, 0x10, 0x44, 0x00),
-		.name = "mt25ql256a",
-		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
-		.mfr_flags = USE_FSR,
-	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x19),
-		.name = "n25q256a",
-		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
-	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x19, 0x10, 0x44, 0x00),
-		.name = "mt25qu256a",
-		.size = SZ_32M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
-		.mfr_flags = USE_FSR,
-	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x19),
-		.name = "n25q256ax1",
-		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p05-nonjedec",
+		.sector_size = SZ_32K,
+		.size = SZ_64K,
 	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x20, 0x10, 0x44, 0x00),
-		.name = "mt25ql512a",
-		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
-		.mfr_flags = USE_FSR,
+		.name = "m25p10-nonjedec",
+		.sector_size = SZ_32K,
+		.size = SZ_128K,
 	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x20),
-		.name = "n25q512ax3",
-		.size = SZ_64M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p20-nonjedec",
+		.size = SZ_256K,
 	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
-		.name = "mt25qu512a",
-		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
-		.mfr_flags = USE_FSR,
+		.name = "m25p40-nonjedec",
+		.size = SZ_512K,
 	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x20),
-		.name = "n25q512a",
-		.size = SZ_64M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-			 SPI_NOR_BP3_SR_BIT6,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p80-nonjedec",
+		.size = SZ_1M,
 	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x21),
-		.name = "n25q00",
-		.size = SZ_128M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
-			 SPI_NOR_BP3_SR_BIT6 | NO_CHIP_ERASE,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p16-nonjedec",
+		.size = SZ_2M,
 	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x21),
-		.name = "n25q00a",
-		.size = SZ_128M,
-		.flags = NO_CHIP_ERASE,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p32-nonjedec",
+		.size = SZ_4M,
 	}, {
-		.id = SNOR_ID(0x20, 0xba, 0x22),
-		.name = "mt25ql02g",
-		.size = SZ_256M,
-		.flags = NO_CHIP_ERASE,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p64-nonjedec",
+		.size = SZ_8M,
 	}, {
-		.id = SNOR_ID(0x20, 0xbb, 0x22),
-		.name = "mt25qu02g",
-		.size = SZ_256M,
-		.flags = NO_CHIP_ERASE,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_FSR,
+		.name = "m25p128-nonjedec",
+		.sector_size = SZ_256K,
+		.size = SZ_16M,
 	}, {
 		.id = SNOR_ID(0x20, 0x20, 0x10),
 		.name = "m25p05",
@@ -348,36 +250,6 @@ static const struct flash_info st_nor_parts[] = {
 		.name = "m25p128",
 		.sector_size = SZ_256K,
 		.size = SZ_16M,
-	}, {
-		.name = "m25p05-nonjedec",
-		.sector_size = SZ_32K,
-		.size = SZ_64K,
-	}, {
-		.name = "m25p10-nonjedec",
-		.sector_size = SZ_32K,
-		.size = SZ_128K,
-	}, {
-		.name = "m25p20-nonjedec",
-		.size = SZ_256K,
-	}, {
-		.name = "m25p40-nonjedec",
-		.size = SZ_512K,
-	}, {
-		.name = "m25p80-nonjedec",
-		.size = SZ_1M,
-	}, {
-		.name = "m25p16-nonjedec",
-		.size = SZ_2M,
-	}, {
-		.name = "m25p32-nonjedec",
-		.size = SZ_4M,
-	}, {
-		.name = "m25p64-nonjedec",
-		.size = SZ_8M,
-	}, {
-		.name = "m25p128-nonjedec",
-		.sector_size = SZ_256K,
-		.size = SZ_16M,
 	}, {
 		.id = SNOR_ID(0x20, 0x40, 0x11),
 		.name = "m45pe10",
@@ -391,18 +263,14 @@ static const struct flash_info st_nor_parts[] = {
 		.name = "m45pe16",
 		.size = SZ_2M,
 	}, {
-		.id = SNOR_ID(0x20, 0x80, 0x12),
-		.name = "m25pe20",
-		.size = SZ_256K,
+		.id = SNOR_ID(0x20, 0x63, 0x16),
+		.name = "m25px32-s1",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0x20, 0x80, 0x14),
-		.name = "m25pe80",
+		.id = SNOR_ID(0x20, 0x71, 0x14),
+		.name = "m25px80",
 		.size = SZ_1M,
-	}, {
-		.id = SNOR_ID(0x20, 0x80, 0x15),
-		.name = "m25pe16",
-		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0x20, 0x71, 0x15),
 		.name = "m25px16",
@@ -413,25 +281,157 @@ static const struct flash_info st_nor_parts[] = {
 		.name = "m25px32",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x20, 0x71, 0x17),
+		.name = "m25px64",
+		.size = SZ_8M,
 	}, {
 		.id = SNOR_ID(0x20, 0x73, 0x16),
 		.name = "m25px32-s0",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0x20, 0x63, 0x16),
-		.name = "m25px32-s1",
-		.size = SZ_4M,
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
 		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0x20, 0x71, 0x17),
-		.name = "m25px64",
+		.id = SNOR_ID(0x20, 0xba, 0x16),
+		.name = "n25q032",
+		.size = SZ_4M,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xba, 0x17),
+		.name = "n25q064",
 		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0x20, 0x71, 0x14),
-		.name = "m25px80",
-		.size = SZ_1M,
-	},
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
+		.id = SNOR_ID(0x20, 0xba, 0x21),
+		.name = "n25q00",
+		.size = SZ_128M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6 | NO_CHIP_ERASE,
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
+		.id = SNOR_ID(0x20, 0xbb, 0x15),
+		.name = "n25q016a",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0xbb, 0x16),
+		.name = "n25q032a",
+		.size = SZ_4M,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ,
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
+		.id = SNOR_ID(0x20, 0xbb, 0x21),
+		.name = "n25q00a",
+		.size = SZ_128M,
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
+	}
 };
 
 /**

-- 
2.39.2

