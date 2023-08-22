Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9D7783AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHVHNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjHVHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4710EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 081F3648F5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A7C433CB;
        Tue, 22 Aug 2023 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688238;
        bh=cvOmQ4r9lT/hD8cobtpM84I53hfGaM55Wi2KKw6QCYM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MzdW72jIFXTv2uOfCLOVwgznPeKdO3r7cElkUdw7PcryfmMxKtssCWISkSt48CGeO
         UE6wOgGDGD9qoUkDoO/a9DerI3iWxcDXRL1Q494uh59uDcbPV++eUEai1cfuUdEXHt
         CqqGWKYd2KKNpcrw4cflq0nXtHcviCbJpZGPuSbH8TmUi1xxgFAxTG7sge50qpp1KB
         V60uDXnRAMcc2G4kKNG+GgrPY2myFje2Yn88vse0EvRJAqOXhBknX588WnHiQ69cPc
         dVtrD9dqQeH28f3Yg7aEszQls8l3S+8kol5jsFEhP+vzGaeml/i325lvHfyVzP0KiQ
         w/7PRJKmNibSg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:47 +0200
Subject: [PATCH v2 31/41] mtd: spi-nor: atmel: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-31-291a0f39f8d8@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
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
 drivers/mtd/spi-nor/atmel.c | 82 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index ccc985c48ae3..18e904962d0e 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -164,20 +164,20 @@ static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
 
 static const struct flash_info atmel_nor_parts[] = {
 	{
-		.id = SNOR_ID(0x1f, 0x66, 0x01),
-		.name = "at25fs010",
-		.sector_size = SZ_32K,
-		.size = SZ_128K,
-		.flags = SPI_NOR_HAS_LOCK,
+		.id = SNOR_ID(0x1f, 0x04, 0x00),
+		.name = "at26f004",
+		.size = SZ_512K,
 		.no_sfdp_flags = SECT_4K,
-		.fixups = &at25fs_nor_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x66, 0x04),
-		.name = "at25fs040",
-		.size = SZ_512K,
-		.flags = SPI_NOR_HAS_LOCK,
+		.id = SNOR_ID(0x1f, 0x25, 0x00),
+		.name = "at45db081d",
+		.size = SZ_1M,
 		.no_sfdp_flags = SECT_4K,
-		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x42, 0x16),
+		.name = "at25sl321",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0x1f, 0x44, 0x01),
 		.name = "at25df041a",
@@ -186,62 +186,62 @@ static const struct flash_info atmel_nor_parts[] = {
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups,
 	}, {
-		.id = SNOR_ID(0x1f, 0x47, 0x00),
-		.name = "at25df321",
-		.size = SZ_4M,
+		.id = SNOR_ID(0x1f, 0x45, 0x01),
+		.name = "at26df081a",
+		.size = SZ_1M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x47, 0x01),
-		.name = "at25df321a",
-		.size = SZ_4M,
+		.id = SNOR_ID(0x1f, 0x46, 0x01),
+		.name = "at26df161a",
+		.size = SZ_2M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x48, 0x00),
-		.name = "at25df641",
-		.size = SZ_8M,
+		.id = SNOR_ID(0x1f, 0x47, 0x00),
+		.name = "at25df321",
+		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x42, 0x16),
-		.name = "at25sl321",
+		.id = SNOR_ID(0x1f, 0x47, 0x00),
+		.name = "at26df321",
 		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x1f, 0x04, 0x00),
-		.name = "at26f004",
-		.size = SZ_512K,
-		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0x1f, 0x45, 0x01),
-		.name = "at26df081a",
-		.size = SZ_1M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x46, 0x01),
-		.name = "at26df161a",
-		.size = SZ_2M,
+		.id = SNOR_ID(0x1f, 0x47, 0x01),
+		.name = "at25df321a",
+		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x47, 0x00),
-		.name = "at26df321",
-		.size = SZ_4M,
+		.id = SNOR_ID(0x1f, 0x48, 0x00),
+		.name = "at25df641",
+		.size = SZ_8M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {
-		.id = SNOR_ID(0x1f, 0x25, 0x00),
-		.name = "at45db081d",
-		.size = SZ_1M,
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
 		.no_sfdp_flags = SECT_4K,
+		.fixups = &at25fs_nor_fixups
 	},
 };
 

-- 
2.39.2

