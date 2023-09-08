Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC8798597
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbjIHKRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjIHKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:17:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF62114
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:17:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC6AC433B6;
        Fri,  8 Sep 2023 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168225;
        bh=zgFFzyUZ+SJao/5qkE8JyiR+umnjcGflTNkQJIikt2Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KF/qjqC77zFxURonv6rzEu1JbOvtLVObDrbsW/G4XoeBdhZHlcZnl9iDy1SYjEFKF
         GNoaYyX2YVswrHAWZJqYFGukkfuOAi6wor607vqQqL+btTpxVN28k6bg4Rac80KhE0
         x0ge/MeEMosxSq0SpgV4l6c4nqgrcgThxNR2MauwlWh907PcCZAohXZTX3fPLefazP
         UdYVVb7yHklEb1f9JHeDJm69KDZYjqkX2KNYAzpJSdQb+vdlDnBul16Hg2fxovV+5E
         OQHMsJhDXivj62IVG3OVHatFnwU1npkgdu1D5ZsuJxlkaLdHd6d3wpTMw/mkDv95hW
         9nTnZ+3B4EQ6Q==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:35 +0200
Subject: [PATCH v3 17/41] mtd: spi-nor: atmel: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-17-e60548861b10@kernel.org>
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

The INFOx() macros are going away. Convert the flash_info database to
the new format.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/atmel.c | 122 +++++++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index d2de2cb0c066..ccc985c48ae3 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -163,48 +163,86 @@ static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
 };
 
 static const struct flash_info atmel_nor_parts[] = {
-	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &at25fs_nor_fixups },
-	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &at25fs_nor_fixups },
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		.fixups = &atmel_nor_global_protection_fixups },
-	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16)
-		NO_SFDP_FLAGS(SECT_4K) },
+	{
+		.id = SNOR_ID(0x1f, 0x66, 0x01),
+		.name = "at25fs010",
+		.sector_size = SZ_32K,
+		.size = SZ_128K,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x66, 0x04),
+		.name = "at25fs040",
+		.size = SZ_512K,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x44, 0x01),
+		.name = "at25df041a",
+		.size = SZ_512K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups,
+	}, {
+		.id = SNOR_ID(0x1f, 0x47, 0x00),
+		.name = "at25df321",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x47, 0x01),
+		.name = "at25df321a",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x48, 0x00),
+		.name = "at25df641",
+		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x42, 0x16),
+		.name = "at25sl321",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x1f, 0x04, 0x00),
+		.name = "at26f004",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x1f, 0x45, 0x01),
+		.name = "at26df081a",
+		.size = SZ_1M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x46, 0x01),
+		.name = "at26df161a",
+		.size = SZ_2M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x47, 0x00),
+		.name = "at26df321",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x25, 0x00),
+		.name = "at45db081d",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K,
+	},
 };
 
 const struct spi_nor_manufacturer spi_nor_atmel = {

-- 
2.39.2

