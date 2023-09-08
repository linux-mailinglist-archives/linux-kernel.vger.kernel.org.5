Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302017985AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjIHKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjIHKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:20:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8EF210D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:19:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46467C433D9;
        Fri,  8 Sep 2023 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168271;
        bh=q62jcKfbyvw1UyVsR97jLApwSi8lfnOL5ELNif2Hl1k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dcfgBTZELeDlvRfNAxwJZ8XBsoPl3VGjKYz63YW4cuRev4tzeMsqqr2dTIQir65f1
         kISPN1HfkmlgYTsMtOaXneOxowbDlExDh/iHoxuu3o7uWGwZgiZS8+DgUvGuYHoNeN
         gFdibWX83X+LrQQRFyUJRBCg4aec/5iIOUpbuxtaYyayncO1JftcAaKJCTdyeEKlq7
         2LKAZf9X57qXdjh3ERrMGnmudavp74xQ7AN3+MvAoz8NcXR1ro6bFSvM62nOkh26Wi
         Fpm9A74/v2V/PZLw88H4s61ehzGGdAmeqGgtoqlylis7SBG3MHIFr/G041dc4EX57e
         pU/kZl7ZZFoiw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:57 +0200
Subject: [PATCH v3 39/41] mtd: spi-nor: winbond: sort flash_info entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-39-e60548861b10@kernel.org>
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
 drivers/mtd/spi-nor/winbond.c | 166 +++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index edc64c99cd81..142fb27b2ea9 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -72,37 +72,25 @@ static const struct flash_info winbond_nor_parts[] = {
 		.name = "w25x16",
 		.size = SZ_2M,
 		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x15),
-		.name = "w25q16dw",
-		.size = SZ_2M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x30, 0x16),
 		.name = "w25x32",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0xef, 0x70, 0x15),
-		.name = "w25q16jv-im/jm",
-		.size = SZ_2M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.id = SNOR_ID(0xef, 0x30, 0x17),
+		.name = "w25x64",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x12),
 		.name = "w25q20cl",
 		.size = SZ_256K,
 		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0xef, 0x50, 0x12),
-		.name = "w25q20bw",
-		.size = SZ_256K,
-		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x12),
-		.name = "w25q20ew",
-		.size = SZ_256K,
+		.id = SNOR_ID(0xef, 0x40, 0x14),
+		.name = "w25q80bl",
+		.size = SZ_1M,
 		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0xef, 0x40, 0x16),
@@ -110,57 +98,84 @@ static const struct flash_info winbond_nor_parts[] = {
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x16),
-		.name = "w25q32dw",
-		.size = SZ_4M,
+		.id = SNOR_ID(0xef, 0x40, 0x17),
+		.name = "w25q64",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x40, 0x18),
+		.name = "w25q128",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+	}, {
+		.id = SNOR_ID(0xef, 0x40, 0x19),
+		.name = "w25q256",
+		.size = SZ_32M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
+		.fixups = &w25q256_fixups,
 	}, {
-		.id = SNOR_ID(0xef, 0x70, 0x16),
-		.name = "w25q32jv",
-		.size = SZ_4M,
+		.id = SNOR_ID(0xef, 0x40, 0x20),
+		.name = "w25q512jvq",
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x50, 0x12),
+		.name = "w25q20bw",
+		.size = SZ_256K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xef, 0x50, 0x14),
+		.name = "w25q80",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xef, 0x60, 0x12),
+		.name = "w25q20ew",
+		.size = SZ_256K,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xef, 0x60, 0x15),
+		.name = "w25q16dw",
+		.size = SZ_2M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x80, 0x16),
-		.name = "w25q32jwm",
+		.id = SNOR_ID(0xef, 0x60, 0x16),
+		.name = "w25q32dw",
 		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
 	}, {
-		.id = SNOR_ID(0xef, 0x80, 0x17),
-		.name = "w25q64jwm",
+		.id = SNOR_ID(0xef, 0x60, 0x17),
+		.name = "w25q64dw",
 		.size = SZ_8M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x80, 0x18),
-		.name = "w25q128jwm",
+		.id = SNOR_ID(0xef, 0x60, 0x18),
+		.name = "w25q128fw",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x80, 0x19),
-		.name = "w25q256jwm",
+		.id = SNOR_ID(0xef, 0x60, 0x19),
+		.name = "w25q256jw",
 		.size = SZ_32M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x30, 0x17),
-		.name = "w25x64",
-		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K,
+		.id = SNOR_ID(0xef, 0x60, 0x20),
+		.name = "w25q512nwq",
+		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
 	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x17),
-		.name = "w25q64",
-		.size = SZ_8M,
+		.id = SNOR_ID(0xef, 0x70, 0x15),
+		.name = "w25q16jv-im/jm",
+		.size = SZ_2M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x17),
-		.name = "w25q64dw",
-		.size = SZ_8M,
+		.id = SNOR_ID(0xef, 0x70, 0x16),
+		.name = "w25q32jv",
+		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
@@ -168,64 +183,49 @@ static const struct flash_info winbond_nor_parts[] = {
 		.name = "w25q64jvm",
 		.size = SZ_8M,
 		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x18),
-		.name = "w25q128fw",
-		.size = SZ_16M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x70, 0x18),
 		.name = "w25q128jv",
 		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xef, 0x50, 0x14),
-		.name = "w25q80",
-		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x14),
-		.name = "w25q80bl",
-		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x18),
-		.name = "w25q128",
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
-	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x19),
-		.name = "w25q256",
-		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixups = &w25q256_fixups,
 	}, {
 		.id = SNOR_ID(0xef, 0x70, 0x19),
 		.name = "w25q256jvm",
-	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x19),
-		.name = "w25q256jw",
-		.size = SZ_32M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x71, 0x19),
 		.name = "w25m512jv",
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xef, 0x60, 0x20),
-		.name = "w25q512nwq",
+		.id = SNOR_ID(0xef, 0x80, 0x16),
+		.name = "w25q32jwm",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
+	}, {
+		.id = SNOR_ID(0xef, 0x80, 0x17),
+		.name = "w25q64jwm",
+		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x80, 0x18),
+		.name = "w25q128jwm",
+		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xef, 0x80, 0x19),
+		.name = "w25q256jwm",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xef, 0x80, 0x20),
 		.name = "w25q512nwm",
 		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
-	}, {
-		.id = SNOR_ID(0xef, 0x40, 0x20),
-		.name = "w25q512jvq",
-		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	},
 };
 

-- 
2.39.2

