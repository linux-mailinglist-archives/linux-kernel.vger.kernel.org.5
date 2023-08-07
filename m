Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECED77257C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjHGNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjHGNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5641BC3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0693761AE3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF1CC433C9;
        Mon,  7 Aug 2023 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414563;
        bh=oMgc1/5JxnhtyDALEk/TOuQOpIC5QJP7tEpRGwFyIfU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YN26U12FUtoacJoAz5S0XgPU8FCpDFvKgiV81SUbMxTEIPMyvRrf+7X7nzwtKpUGf
         c6wnwPyPi+zY3wrbK+xq6qqRl0qUW3aEBHlkUXixIzKecor8TSlYrVi/Tl/DGmQNC4
         PrIGG9937j3b+xi1d73l4PG3TCGBfXArttsQ+F3CBJZmAZnSjKv1z0ix682dknrUPC
         sTlJV3ukSucaJMH2QI7qfpH6JusqRC2hlQsCQEYGzyZ3iDokbnSzvEv0LVzz38aEco
         +69MRGhfWu1PFYSCnYVf9pwVHFegw018BLjPHg1v1ZojeJ3pRF5tI67pzoXsSIh25e
         fvRtVdTgvBATQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:18 +0200
Subject: [PATCH 24/41] mtd: spi-nor: macronix: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-24-3d3d5bef4ba4@kernel.org>
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
 drivers/mtd/spi-nor/macronix.c | 218 ++++++++++++++++++++++++++++-------------
 1 file changed, 150 insertions(+), 68 deletions(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index b21e688fe056..0508a207e9df 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -33,74 +33,156 @@ static const struct spi_nor_fixups mx25l25635_fixups = {
 };
 
 static const struct flash_info macronix_nor_parts[] = {
-	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16) },
-	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256) },
-	{ "mx25r1635f",  INFO(0xc22815, 0, 64 * 1024,  32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25r3235f",  INFO(0xc22816, 0, 64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25u12835f", INFO(0xc22538, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		.fixups = &mx25l25635_fixups },
-	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "mx25u51245g", INFO(0xc2253a, 0, 64 * 1024, 1024)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "mx25uw51245g", INFOB(0xc2813a, 0, 0, 0, 4)
-		FLAGS(SPI_NOR_RWW) },
-	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512) },
-	{ "mx66l51235f", INFO(0xc2201a, 0, 64 * 1024, 1024)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
-		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
-	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{
+		.id = SNOR_ID(0xc2, 0x20, 0x10),
+		.name = "mx25l512e",
+		.size = SZ_64K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x12),
+		.name = "mx25l2005a",
+		.size = SZ_256K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x13),
+		.name = "mx25l4005a",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x14),
+		.name = "mx25l8005",
+		.size = SZ_1M,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x15),
+		.name = "mx25l1606e",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x16),
+		.name = "mx25l3205d",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x9e, 0x16),
+		.name = "mx25l3255e",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x17),
+		.name = "mx25l6405d",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x32),
+		.name = "mx25u2033e",
+		.size = SZ_256K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x36),
+		.name = "mx25u3235f",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x33),
+		.name = "mx25u4035",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x34),
+		.name = "mx25u8035",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x37),
+		.name = "mx25u6435f",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.name = "mx25l12805d",
+		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x26, 0x18),
+		.name = "mx25l12855e",
+		.size = SZ_16M,
+	}, {
+		.id = SNOR_ID(0xc2, 0x28, 0x15),
+		.name = "mx25r1635f",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x28, 0x16),
+		.name = "mx25r3235f",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x38),
+		.name = "mx25u12835f",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x19),
+		.name = "mx25l25635e",
+		.size = SZ_32M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixups = &mx25l25635_fixups
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x39),
+		.name = "mx25u25635f",
+		.size = SZ_32M,
+		.no_sfdp_flags = SECT_4K,
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x3a),
+		.name = "mx25u51245g",
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x81, 0x3a),
+		.name = "mx25uw51245g",
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x23, 0x14),
+		.name = "mx25v8035f",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x26, 0x19),
+		.name = "mx25l25655e",
+		.size = SZ_32M,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x1a),
+		.name = "mx66l51235f",
+		.size = SZ_64M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x3a),
+		.name = "mx66u51235f",
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x1b),
+		.name = "mx66l1g45g",
+		.size = SZ_128M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x26, 0x1b),
+		.name = "mx66l1g55g",
+		.size = SZ_128M,
+		.no_sfdp_flags = SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x3c),
+		.name = "mx66u2g45g",
+		.size = SZ_256M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	},
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)

-- 
2.39.2

