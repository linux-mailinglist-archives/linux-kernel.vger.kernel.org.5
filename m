Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B583772577
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjHGNXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjHGNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60319AB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5C661AD8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08ABC433C8;
        Mon,  7 Aug 2023 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414548;
        bh=yRymFxs0ZgCRKKfeCO93P0NNgII3piuTmdoZV/3f5XU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=olllZq88iDLzskVOUa+X7jTz7y9olhhD4f5hPoUo024ZPQ+f8ncO0seR8aPleWC0K
         yir906/w5x0AMMX5Bgx6W556jMfHr3bfzwqZPEOM1aFjA9l0ipmr+/hYtbUj0/5TL5
         0NS4UmYPv2qO11z5gWwNDDDg2PTe5OaxakeRB0V3jO5jqKz6OCwlQFezcs7tlf8+EB
         nMeR3u6zp64BZHXHwIfG4KB9s4nXOFPCQ5e8vtMfmXk+kR16l/TvbrJ8SxM4maQAp5
         Qi29sox6N/lew8UrQI2+NqsSKgtXCwqytyOkIzITGIGwVJ34OMdkYZ7ubqSm9z/z5R
         yTFYSDd2uUJWg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:11 +0200
Subject: [PATCH 17/41] mtd: spi-nor: atmel: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-17-3d3d5bef4ba4@kernel.org>
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

