Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13617783A88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjHVHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjHVHLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3303E79
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A586E63441
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7748DC433CA;
        Tue, 22 Aug 2023 07:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688246;
        bh=S2VGpvolKhnaojGSg3lKj4d7SDdm9iFqv4jQmZl9diQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=r3H31Kgixm/tob7MNx9kQ3x/nGVzVA2gLIIzIz8HURmeaoLo1eHjKF9Hmaq0tXhya
         FwSX6ve6usH4LH1GOSOd9ATD9XfetrUa3SlHUIJaw2TwPe81yeSgunrgHkraIjNNr1
         0zbnP8F5eM+nLIePk/DZ4J49twZ40T9/d6LmxpLYPrH3zUaqRFIP+poZHLaQuIw32s
         hhyruXGNIhfRLN6NtTge4LRRM7O+Ptj0Sc5vtDAO2j8QpouAZbO9tD3dlJGMKWcTuE
         gn+Ft+EHiboL6xYdCc0rmGy4L8NdcYie7oQdxNf4dhLVuJe5HKJg1sERx+1N3jvPxu
         5DN5S3wBJXltg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:51 +0200
Subject: [PATCH v2 35/41] mtd: spi-nor: macronix: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-35-291a0f39f8d8@kernel.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 drivers/mtd/spi-nor/macronix.c | 130 ++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 0508a207e9df..ea6be95e75a5 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -62,26 +62,44 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25l3205d",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xc2, 0x9e, 0x16),
-		.name = "mx25l3255e",
-		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0xc2, 0x20, 0x17),
 		.name = "mx25l6405d",
 		.size = SZ_8M,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.name = "mx25l12805d",
+		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x19),
+		.name = "mx25l25635e",
+		.size = SZ_32M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixups = &mx25l25635_fixups
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x1a),
+		.name = "mx66l51235f",
+		.size = SZ_64M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x20, 0x1b),
+		.name = "mx66l1g45g",
+		.size = SZ_128M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x23, 0x14),
+		.name = "mx25v8035f",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x32),
 		.name = "mx25u2033e",
 		.size = SZ_256K,
 		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xc2, 0x25, 0x36),
-		.name = "mx25u3235f",
-		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x33),
 		.name = "mx25u4035",
@@ -92,74 +110,33 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25u8035",
 		.size = SZ_1M,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x25, 0x36),
+		.name = "mx25u3235f",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x37),
 		.name = "mx25u6435f",
 		.size = SZ_8M,
 		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xc2, 0x20, 0x18),
-		.name = "mx25l12805d",
-		.size = SZ_16M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
-		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0xc2, 0x26, 0x18),
-		.name = "mx25l12855e",
-		.size = SZ_16M,
-	}, {
-		.id = SNOR_ID(0xc2, 0x28, 0x15),
-		.name = "mx25r1635f",
-		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xc2, 0x28, 0x16),
-		.name = "mx25r3235f",
-		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x38),
 		.name = "mx25u12835f",
 		.size = SZ_16M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xc2, 0x20, 0x19),
-		.name = "mx25l25635e",
-		.size = SZ_32M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixups = &mx25l25635_fixups
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x39),
 		.name = "mx25u25635f",
 		.size = SZ_32M,
 		.no_sfdp_flags = SECT_4K,
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx25u51245g",
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
-	}, {
-		.id = SNOR_ID(0xc2, 0x81, 0x3a),
-		.name = "mx25uw51245g",
-		.n_banks = 4,
-		.flags = SPI_NOR_RWW,
-	}, {
-		.id = SNOR_ID(0xc2, 0x23, 0x14),
-		.name = "mx25v8035f",
-		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0xc2, 0x26, 0x19),
-		.name = "mx25l25655e",
-		.size = SZ_32M,
-	}, {
-		.id = SNOR_ID(0xc2, 0x20, 0x1a),
-		.name = "mx66l51235f",
-		.size = SZ_64M,
-		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx66u51235f",
@@ -167,22 +144,45 @@ static const struct flash_info macronix_nor_parts[] = {
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
-		.id = SNOR_ID(0xc2, 0x20, 0x1b),
-		.name = "mx66l1g45g",
-		.size = SZ_128M,
+		.id = SNOR_ID(0xc2, 0x25, 0x3c),
+		.name = "mx66u2g45g",
+		.size = SZ_256M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x26, 0x18),
+		.name = "mx25l12855e",
+		.size = SZ_16M,
+	}, {
+		.id = SNOR_ID(0xc2, 0x26, 0x19),
+		.name = "mx25l25655e",
+		.size = SZ_32M,
 	}, {
 		.id = SNOR_ID(0xc2, 0x26, 0x1b),
 		.name = "mx66l1g55g",
 		.size = SZ_128M,
 		.no_sfdp_flags = SPI_NOR_QUAD_READ,
 	}, {
-		.id = SNOR_ID(0xc2, 0x25, 0x3c),
-		.name = "mx66u2g45g",
-		.size = SZ_256M,
+		.id = SNOR_ID(0xc2, 0x28, 0x15),
+		.name = "mx25r1635f",
+		.size = SZ_2M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
-	},
+	}, {
+		.id = SNOR_ID(0xc2, 0x28, 0x16),
+		.name = "mx25r3235f",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xc2, 0x81, 0x3a),
+		.name = "mx25uw51245g",
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x9e, 0x16),
+		.name = "mx25l3255e",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)

-- 
2.39.2

