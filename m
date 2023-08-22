Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53156783A73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjHVHLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjHVHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337EE61
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A8F64D7B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DB6C433CB;
        Tue, 22 Aug 2023 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688212;
        bh=FMrL+V9+pSz441pre2fqIuiBhaXySkpsxmO1V8C9qk8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NnnND7hT7KN2mCxrnEse4O7hVa7RnICLH8m3d9nH0sbVyS0JrElMUbNV0mNjuGTzi
         svpDGG4GbupBmUdFAtjrj6iKuV+xEbyJ4y0RVMBiSTZEI77geG/SDg7neD0CUikUPv
         y6ConZFZNzIDfvR0QaPRLKLyvRHd16JD8dFzm2/2rJfcexglGOCsLbneWwdKvYZtxN
         apZWjA4FJR+TtDhwr1naDJpx0eAgjzRdw0h2W5pFRFmF9irg7TgObzrbKaS7maBq23
         aeAw3bVRWMEsNLpLFRP+9ITIEZ792fjeD3qs46MhEF8btSF2zPwGn8e1DVcG0EOZCb
         UBHLFXcMKVz2g==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:34 +0200
Subject: [PATCH v2 18/41] mtd: spi-nor: eon: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-18-291a0f39f8d8@kernel.org>
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

The INFOx() macros are going away. Convert the flash_info database to
the new format.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/eon.c | 72 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index 4848ffe8b38f..ba09cb6c2abd 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -9,24 +9,60 @@
 #include "core.h"
 
 static const struct flash_info eon_nor_parts[] = {
-	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64) },
-	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64) },
-	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128) },
-	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "en25q80a",   INFO(0x1c3014, 0, 64 * 1024,   16)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "en25qh16",   INFO(0x1c7015, 0, 64 * 1024,   32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "en25qh32",   INFO(0x1c7016, 0, 64 * 1024,   64) },
-	{ "en25qh64",   INFO(0x1c7017, 0, 64 * 1024,  128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "en25qh128",  INFO(0x1c7018, 0, 64 * 1024,  256) },
-	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  0) },
-	{ "en25s64",	INFO(0x1c3817, 0, 64 * 1024,  128)
-		NO_SFDP_FLAGS(SECT_4K) },
+	{
+		.id = SNOR_ID(0x1c, 0x31, 0x16),
+		.name = "en25f32",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x1c, 0x20, 0x16),
+		.name = "en25p32",
+		.size = SZ_4M,
+	}, {
+		.id = SNOR_ID(0x1c, 0x30, 0x16),
+		.name = "en25q32b",
+		.size = SZ_4M,
+	}, {
+		.id = SNOR_ID(0x1c, 0x20, 0x17),
+		.name = "en25p64",
+		.size = SZ_8M,
+	}, {
+		.id = SNOR_ID(0x1c, 0x30, 0x17),
+		.name = "en25q64",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x1c, 0x30, 0x14),
+		.name = "en25q80a",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x1c, 0x70, 0x15),
+		.name = "en25qh16",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x1c, 0x70, 0x16),
+		.name = "en25qh32",
+		.size = SZ_4M,
+	}, {
+		.id = SNOR_ID(0x1c, 0x70, 0x17),
+		.name = "en25qh64",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x1c, 0x70, 0x18),
+		.name = "en25qh128",
+		.size = SZ_16M,
+	}, {
+		.id = SNOR_ID(0x1c, 0x70, 0x19),
+		.name = "en25qh256",
+	}, {
+		.name = "en25s64",
+		.id = SNOR_ID(0x1c, 0x38, 0x17),
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
+	},
 };
 
 const struct spi_nor_manufacturer spi_nor_eon = {

-- 
2.39.2

