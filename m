Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8F772580
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjHGNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHGNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085401FCD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C9D61B0D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F211CC43391;
        Mon,  7 Aug 2023 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414567;
        bh=7Ax3pkPo6UX4EijR1qZKMW+2WThEdBs7d0bv6XlTilA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZIXavo8inivGQGgIa7DIw2gNALvxkr4SxrLjASzTjpUDnTneC7oFnP/hDBAakLOsi
         Pm0nS+0UGyATXdYUaA4i8L2F/FGsUTjb3O1fTOIMwaJlKamJmj7jO71mebxiBTwzkn
         q0xBFOR1z4ITo24tvq0ObVMTgIUq1ZhmAGXRr8jjOnLhj84zxirjkv7qqoUUzOv5bN
         TsWIBjnAxWg9JlIhoQg7T81V6+daD1aKuwKI9H64kPYjAblEWQrfxw2W53MndIBE5f
         p6Y2ONdyEvsgNDAPsxaqJrNbIrQ8vW6/gldEe8+LU5HmSkTHYjDtood8FdUk+wjPrx
         uCH4JYn5Q6/Qg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:20 +0200
Subject: [PATCH 26/41] mtd: spi-nor: spansion: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-26-3d3d5bef4ba4@kernel.org>
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
 drivers/mtd/spi-nor/spansion.c | 370 +++++++++++++++++++++++++++--------------
 1 file changed, 241 insertions(+), 129 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 1a1d2368c462..5953df6aff93 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -756,140 +756,252 @@ static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 };
 
 static const struct flash_info spansion_nor_parts[] = {
-	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "s25fl128s0", INFO6(0x012018, 0x4d0080, 256 * 1024, 64)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fl128s1", INFO6(0x012018, 0x4d0180, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fl256s0", INFO6(0x010219, 0x4d0080, 256 * 1024, 128)
-		NO_SFDP_FLAGS(SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fl256s1", INFO6(0x010219, 0x4d0180, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fl512s",  INFO6(0x010220, 0x4d0080, 256 * 1024, 256)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fs128s1", INFO6(0x012018, 0x4d0181, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-		.fixups = &s25fs_s_nor_fixups, },
-	{ "s25fs256s0", INFO6(0x010219, 0x4d0081, 256 * 1024, 128)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fs256s1", INFO6(0x010219, 0x4d0181, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-		.fixups = &s25fs_s_nor_fixups, },
-	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64) },
-	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256) },
-	{ "s25fl129p0", INFO(0x012018, 0x4d00, 256 * 1024,  64)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256)
-		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		MFR_FLAGS(USE_CLSR)
-	},
-	{ "s25sl004a",  INFO(0x010212,      0,  64 * 1024,   8) },
-	{ "s25sl008a",  INFO(0x010213,      0,  64 * 1024,  16) },
-	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32) },
-	{ "s25sl032a",  INFO(0x010215,      0,  64 * 1024,  64) },
-	{ "s25sl064a",  INFO(0x010216,      0,  64 * 1024, 128) },
-	{ "s25fl004k",  INFO(0xef4013,      0,  64 * 1024,   8)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "s25fl008k",  INFO(0xef4014,      0,  64 * 1024,  16)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "s25fl116k",  INFO(0x014015,      0,  64 * 1024,  32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "s25fl132k",  INFO(0x014016,      0,  64 * 1024,  64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "s25fl164k",  INFO(0x014017,      0,  64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "s25fl204k",  INFO(0x014013,      0,  64 * 1024,   8)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "s25fl208k",  INFO(0x014014,      0,  64 * 1024,  16)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "s25fl064l",  INFO(0x016017,      0,  64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "s25fl128l",  INFO(0x016018,      0,  64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-	{ "s25fs256t",  INFO6(0x342b19, 0x0f0890, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		.fixups = &s25fs256t_fixups },
-	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		.fixups = &s25hx_t_fixups },
-	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		.fixups = &s25hx_t_fixups },
-	{ "s25hl02gt",  INFO6(0x342a1c, 0x0f0090, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		FLAGS(NO_CHIP_ERASE)
-		.fixups = &s25hx_t_fixups },
-	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		.fixups = &s25hx_t_fixups },
-	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		.fixups = &s25hx_t_fixups },
-	{ "s25hs02gt",  INFO6(0x342b1c, 0x0f0090, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
-		FLAGS(NO_CHIP_ERASE)
-		.fixups = &s25hx_t_fixups },
-	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
-		FLAGS(SPI_NOR_NO_ERASE) },
-	{ "s28hl512t",   INFO(0x345a1a,      0, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
+	{
+		.id = SNOR_ID(0x01, 0x02, 0x15, 0x4d, 0x00),
+		.name = "s25sl032p",
+		.size = SZ_4M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x16, 0x4d, 0x00),
+		.name = "s25sl064p",
+		.size = SZ_8M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x00, 0x80),
+		.name = "s25fl128s0",
+		.size = SZ_16M,
+		.sector_size = SZ_256K,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x80),
+		.name = "s25fl128s1",
+		.size = SZ_16M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x80),
+		.name = "s25fl256s0",
+		.size = SZ_32M,
+		.sector_size = SZ_256K,
+		.no_sfdp_flags = SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x01, 0x80),
+		.name = "s25fl256s1",
+		.size = SZ_32M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x80),
+		.name = "s25fl512s",
+		.size = SZ_64M,
+		.sector_size = SZ_256K,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x81),
+		.name = "s25fs128s1",
+		.size = SZ_16M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+		.fixups = &s25fs_s_nor_fixups,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x81),
+		.name = "s25fs256s0",
+		.size = SZ_32M,
+		.sector_size = SZ_256K,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x01, 0x81),
+		.name = "s25fs256s1",
+		.size = SZ_32M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x81),
+		.name = "s25fs512s",
+		.size = SZ_64M,
+		.sector_size = SZ_256K,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+		.fixups = &s25fs_s_nor_fixups,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x03, 0x00),
+		.name = "s25sl12800",
+		.size = SZ_16M,
+		.sector_size = SZ_256K,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x03, 0x01),
+		.name = "s25sl12801",
+		.size = SZ_16M,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x00),
+		.name = "s25fl129p0",
+		.size = SZ_16M,
+		.sector_size = SZ_256K,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01),
+		.name = "s25fl129p1",
+		.size = SZ_16M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x12),
+		.name = "s25sl004a",
+		.size = SZ_512K,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x13),
+		.name = "s25sl008a",
+		.size = SZ_1M,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x14),
+		.name = "s25sl016a",
+		.size = SZ_2M,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x15),
+		.name = "s25sl032a",
+		.size = SZ_4M,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x16),
+		.name = "s25sl064a",
+		.size = SZ_8M,
+	}, {
+		.id = SNOR_ID(0xef, 0x40, 0x13),
+		.name = "s25fl004k",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x40, 0x14),
+		.name = "s25fl008k",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x40, 0x15),
+		.name = "s25fl016k",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x40, 0x17),
+		.name = "s25fl064k",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x40, 0x15),
+		.name = "s25fl116k",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x40, 0x16),
+		.name = "s25fl132k",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x01, 0x40, 0x17),
+		.name = "s25fl164k",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x01, 0x40, 0x13),
+		.name = "s25fl204k",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x40, 0x14),
+		.name = "s25fl208k",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x60, 0x17),
+		.name = "s25fl064l",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0x01, 0x60, 0x18),
+		.name = "s25fl128l",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0x01, 0x60, 0x19),
+		.name = "s25fl256l",
+		.size = SZ_32M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0x34, 0x2b, 0x19, 0x0f, 0x08, 0x90),
+		.name = "s25fs256t",
+		.mfr_flags = USE_CLPEF,
+		.fixups = &s25fs256t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2a, 0x1a, 0x0f, 0x03, 0x90),
+		.name = "s25hl512t",
+		.mfr_flags = USE_CLPEF,
+		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2a, 0x1b, 0x0f, 0x03, 0x90),
+		.name = "s25hl01gt",
+		.mfr_flags = USE_CLPEF,
+		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2a, 0x1c, 0x0f, 0x00, 0x90),
+		.name = "s25hl02gt",
+		.mfr_flags = USE_CLPEF,
+		.flags = NO_CHIP_ERASE,
+		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2b, 0x1a, 0x0f, 0x03, 0x90),
+		.name = "s25hs512t",
+		.mfr_flags = USE_CLPEF,
+		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2b, 0x1b, 0x0f, 0x03, 0x90),
+		.name = "s25hs01gt",
+		.mfr_flags = USE_CLPEF,
+		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2b, 0x1c, 0x0f, 0x00, 0x90),
+		.name = "s25hs02gt",
+		.mfr_flags = USE_CLPEF,
+		.flags = NO_CHIP_ERASE,
+		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x04, 0x2c, 0xc2, 0x7f, 0x7f, 0x7f),
+		.name = "cy15x104q",
+		.size = SZ_512K,
+		.sector_size = SZ_512K,
+		.flags = SPI_NOR_NO_ERASE,
+	}, {
+		.id = SNOR_ID(0x34, 0x5a, 0x1a),
+		.name = "s28hl512t",
+		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
-	},
-	{ "s28hl01gt",   INFO(0x345a1b,      0, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
+	}, {
+		.id = SNOR_ID(0x34, 0x5a, 0x1b),
+		.name = "s28hl01gt",
+		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
-	},
-	{ "s28hs512t",   INFO(0x345b1a,      0, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
+	}, {
+		.id = SNOR_ID(0x34, 0x5b, 0x1a),
+		.name = "s28hs512t",
+		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
-	},
-	{ "s28hs01gt",   INFO(0x345b1b,      0, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
+	}, {
+		.id = SNOR_ID(0x34, 0x5b, 0x1b),
+		.name = "s28hs01gt",
+		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
-	},
-	{ "s28hs02gt",   INFO(0x345b1c,      0, 0, 0)
-		MFR_FLAGS(USE_CLPEF)
+	}, {
+		.id = SNOR_ID(0x34, 0x5b, 0x1c),
+		.name = "s28hs02gt",
+		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
-	},
+	}
 };
 
 /**

-- 
2.39.2

