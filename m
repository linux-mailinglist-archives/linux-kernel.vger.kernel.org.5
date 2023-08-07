Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC677257B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjHGNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjHGNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97A2702
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40B361ACC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A015BC433C8;
        Mon,  7 Aug 2023 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414561;
        bh=u3h1HEnFV5TaycBrs44qWUZVzeJsRZVGR9YPZRIQPdw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JWojkmy7iPB7nkJT6BfUN1QiFICIUIq1Ze2n6hFI8yWiXENND4ujjXiGyZiaEuT/h
         yrYukSoIjJ/mjLdbUvxhweIHWnHgwjJW/TX+79Fz1/5ylWGDMd77VGvkdWbtcUbrf+
         VE1sr5SuEsHQGzGrhinjkOoyL6lxVLYfai+M8EtOfYwd7I6y6fDm/lXJcLbAj2+ogh
         Ukd8Gg4hRpRROEOL2SkGaqUmwXeZDseEV1mvhhGFcyu8I4DJ7ZxdG3NSuqiZkr8czg
         LGHVq0Wzab2QAU/6coKKFDEGuVE5qxFb0PGorVYu116azgQoPmCLWGYK/Z+f9nbRhu
         f6STgbLWTh25g==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:17 +0200
Subject: [PATCH 23/41] mtd: spi-nor: issi: convert flash_info to new format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-23-3d3d5bef4ba4@kernel.org>
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
 drivers/mtd/spi-nor/issi.c | 114 +++++++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index d31401bcab64..9478f1e61626 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -47,44 +47,86 @@ static const struct spi_nor_fixups pm25lv_nor_fixups = {
 };
 
 static const struct flash_info issi_nor_parts[] = {
-	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "is25lq040b", INFO(0x9d4013, 0, 64 * 1024,   8)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "is25lp016d", INFO(0x9d6015, 0, 64 * 1024,  32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "is25lp080d", INFO(0x9d6014, 0, 64 * 1024,  16)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "is25lp032",  INFO(0x9d6016, 0, 64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "is25lp064",  INFO(0x9d6017, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 0)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		.fixups = &is25lp256_fixups },
-	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "is25wp256", INFO(0x9d7019, 0, 0, 0)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		FLAGS(SPI_NOR_QUAD_PP)
-		.fixups = &is25lp256_fixups },
-
-	{ "pm25lv512",   INFO0(32 * 1024,    2)
-		NO_SFDP_FLAGS(SECT_4K)
+	{
+		.id = SNOR_ID(0x7f, 0x9d, 0x20),
+		.name = "is25cd512",
+		.sector_size = SZ_32K,
+		.size = SZ_64K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x9d, 0x40, 0x13),
+		.name = "is25lq040b",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x15),
+		.name = "is25lp016d",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x14),
+		.name = "is25lp080d",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x16),
+		.name = "is25lp032",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x17),
+		.name = "is25lp064",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x18),
+		.name = "is25lp128",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x19),
+		.name = "is25lp256",
+		.fixups = &is25lp256_fixups,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0x9d, 0x70, 0x16),
+		.name = "is25wp032",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x70, 0x17),
+		.size = SZ_8M,
+		.name = "is25wp064",
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x70, 0x18),
+		.name = "is25wp128",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x70, 0x19),
+		.name = "is25wp256",
+		.flags = SPI_NOR_QUAD_PP,
+		.fixups = &is25lp256_fixups,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.name = "pm25lv512",
+		.sector_size = SZ_32K,
+		.size = SZ_64K,
+		.no_sfdp_flags = SECT_4K,
 		.fixups = &pm25lv_nor_fixups
-	},
-	{ "pm25lv010",   INFO0(32 * 1024,    4)
-		NO_SFDP_FLAGS(SECT_4K)
+	}, {
+		.name = "pm25lv010",
+		.sector_size = SZ_32K,
+		.size = SZ_128K,
+		.no_sfdp_flags = SECT_4K,
 		.fixups = &pm25lv_nor_fixups
-	},
-	{ "pm25lq032",   INFO(0x7f9d46, 0, 64 * 1024,   64)
-		NO_SFDP_FLAGS(SECT_4K) },
+	}, {
+		.id = SNOR_ID(0x7f, 0x9d, 0x46),
+		.name = "pm25lq032",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}
 };
 
 static void issi_nor_default_init(struct spi_nor *nor)

-- 
2.39.2

