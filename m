Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB977258E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjHGNYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjHGNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC72697
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7542F6192E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384C8C433CA;
        Mon,  7 Aug 2023 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414590;
        bh=8w3XDg6OtHsIPMEmA3w/5H7T3yQdVD+fVZ/p/srxbKw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QWRZcR6c3bYQlYJPKpDOX33/eecQRgdPRF3GpqdLxrBV3pHlCEFO7mmYCxKfihfLT
         IucUEANYxfLhRw6uC0W6sCwK6QufZZY5V68eEgmhYIxC35UZZRJOueuYkTAbWWf8fn
         DdmExs4V38bTWKao9gag9wqXaGj283x0N6wizFYFIs8myF13AVFvJiWFrTrvNJvvVH
         Soq/Ds8c68HQcS5QFNqdouVFkgkkSt67vW8Q4xcD4mJpTk7QAwDveVN0NonOaQxtWf
         yBmD3Jeai5NphSrrSu0ugd5MPDTwmPhbjLbPWF4GAs4FOPuxbnS8ZQmEDqpHc8Ci5d
         j4erZ/FxXfEnA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:31 +0200
Subject: [PATCH 37/41] mtd: spi-nor: spansion: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-37-3d3d5bef4ba4@kernel.org>
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

The flash ID is the new primary key into our database. Sort the entry by
it. Keep the most specific ones first, because there might be ID
collisions between shorter and longer ones.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/spansion.c | 174 ++++++++++++++++++++---------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 5953df6aff93..fd2652aa6c1e 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -757,28 +757,35 @@ static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 
 static const struct flash_info spansion_nor_parts[] = {
 	{
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
 		.id = SNOR_ID(0x01, 0x02, 0x15, 0x4d, 0x00),
 		.name = "s25sl032p",
 		.size = SZ_4M,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x15),
+		.name = "s25sl032a",
+		.size = SZ_4M,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x16, 0x4d, 0x00),
 		.name = "s25sl064p",
 		.size = SZ_8M,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x00, 0x80),
-		.name = "s25fl128s0",
-		.size = SZ_16M,
-		.sector_size = SZ_256K,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_CLSR,
-	}, {
-		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x80),
-		.name = "s25fl128s1",
-		.size = SZ_16M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_CLSR,
+		.id = SNOR_ID(0x01, 0x02, 0x16),
+		.name = "s25sl064a",
+		.size = SZ_8M,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x80),
 		.name = "s25fl256s0",
@@ -787,31 +794,16 @@ static const struct flash_info spansion_nor_parts[] = {
 		.no_sfdp_flags = SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
 	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x01, 0x80),
-		.name = "s25fl256s1",
+		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x81),
+		.name = "s25fs256s0",
 		.size = SZ_32M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_CLSR,
-	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x80),
-		.name = "s25fl512s",
-		.size = SZ_64M,
 		.sector_size = SZ_256K,
-		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
 	}, {
-		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x81),
-		.name = "s25fs128s1",
-		.size = SZ_16M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.mfr_flags = USE_CLSR,
-		.fixups = &s25fs_s_nor_fixups,
-	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x81),
-		.name = "s25fs256s0",
+		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x01, 0x80),
+		.name = "s25fl256s1",
 		.size = SZ_32M,
-		.sector_size = SZ_256K,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
 	}, {
@@ -820,6 +812,14 @@ static const struct flash_info spansion_nor_parts[] = {
 		.size = SZ_32M,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x80),
+		.name = "s25fl512s",
+		.size = SZ_64M,
+		.sector_size = SZ_256K,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x00, 0x81),
 		.name = "s25fs512s",
@@ -837,6 +837,13 @@ static const struct flash_info spansion_nor_parts[] = {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x03, 0x01),
 		.name = "s25sl12801",
 		.size = SZ_16M,
+	}, {
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x00, 0x80),
+		.name = "s25fl128s0",
+		.size = SZ_16M,
+		.sector_size = SZ_256K,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
 	}, {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x00),
 		.name = "s25fl129p0",
@@ -845,51 +852,34 @@ static const struct flash_info spansion_nor_parts[] = {
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
 	}, {
-		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01),
-		.name = "s25fl129p1",
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x80),
+		.name = "s25fl128s1",
 		.size = SZ_16M,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
 	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x12),
-		.name = "s25sl004a",
-		.size = SZ_512K,
-	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x13),
-		.name = "s25sl008a",
-		.size = SZ_1M,
-	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x14),
-		.name = "s25sl016a",
-		.size = SZ_2M,
-	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x15),
-		.name = "s25sl032a",
-		.size = SZ_4M,
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x81),
+		.name = "s25fs128s1",
+		.size = SZ_16M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+		.fixups = &s25fs_s_nor_fixups,
 	}, {
-		.id = SNOR_ID(0x01, 0x02, 0x16),
-		.name = "s25sl064a",
-		.size = SZ_8M,
+		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01),
+		.name = "s25fl129p1",
+		.size = SZ_16M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
 	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x13),
-		.name = "s25fl004k",
+		.id = SNOR_ID(0x01, 0x40, 0x13),
+		.name = "s25fl204k",
 		.size = SZ_512K,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x14),
-		.name = "s25fl008k",
+		.id = SNOR_ID(0x01, 0x40, 0x14),
+		.name = "s25fl208k",
 		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x15),
-		.name = "s25fl016k",
-		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x17),
-		.name = "s25fl064k",
-		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
 	}, {
 		.id = SNOR_ID(0x01, 0x40, 0x15),
 		.name = "s25fl116k",
@@ -905,16 +895,6 @@ static const struct flash_info spansion_nor_parts[] = {
 		.name = "s25fl164k",
 		.size = SZ_8M,
 		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0x01, 0x40, 0x13),
-		.name = "s25fl204k",
-		.size = SZ_512K,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
-	}, {
-		.id = SNOR_ID(0x01, 0x40, 0x14),
-		.name = "s25fl208k",
-		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
 	}, {
 		.id = SNOR_ID(0x01, 0x60, 0x17),
 		.name = "s25fl064l",
@@ -934,10 +914,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
-		.id = SNOR_ID(0x34, 0x2b, 0x19, 0x0f, 0x08, 0x90),
-		.name = "s25fs256t",
-		.mfr_flags = USE_CLPEF,
-		.fixups = &s25fs256t_fixups
+		.id = SNOR_ID(0x04, 0x2c, 0xc2, 0x7f, 0x7f, 0x7f),
+		.name = "cy15x104q",
+		.size = SZ_512K,
+		.sector_size = SZ_512K,
+		.flags = SPI_NOR_NO_ERASE,
 	}, {
 		.id = SNOR_ID(0x34, 0x2a, 0x1a, 0x0f, 0x03, 0x90),
 		.name = "s25hl512t",
@@ -954,6 +935,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		.mfr_flags = USE_CLPEF,
 		.flags = NO_CHIP_ERASE,
 		.fixups = &s25hx_t_fixups
+	}, {
+		.id = SNOR_ID(0x34, 0x2b, 0x19, 0x0f, 0x08, 0x90),
+		.name = "s25fs256t",
+		.mfr_flags = USE_CLPEF,
+		.fixups = &s25fs256t_fixups
 	}, {
 		.id = SNOR_ID(0x34, 0x2b, 0x1a, 0x0f, 0x03, 0x90),
 		.name = "s25hs512t",
@@ -970,12 +956,6 @@ static const struct flash_info spansion_nor_parts[] = {
 		.mfr_flags = USE_CLPEF,
 		.flags = NO_CHIP_ERASE,
 		.fixups = &s25hx_t_fixups
-	}, {
-		.id = SNOR_ID(0x04, 0x2c, 0xc2, 0x7f, 0x7f, 0x7f),
-		.name = "cy15x104q",
-		.size = SZ_512K,
-		.sector_size = SZ_512K,
-		.flags = SPI_NOR_NO_ERASE,
 	}, {
 		.id = SNOR_ID(0x34, 0x5a, 0x1a),
 		.name = "s28hl512t",
@@ -1001,6 +981,26 @@ static const struct flash_info spansion_nor_parts[] = {
 		.name = "s28hs02gt",
 		.mfr_flags = USE_CLPEF,
 		.fixups = &s28hx_t_fixups,
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
 	}
 };
 

-- 
2.39.2

