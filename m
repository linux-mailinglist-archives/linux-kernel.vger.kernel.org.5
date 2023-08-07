Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39425772596
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjHGNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjHGNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7A19AB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AF061B06
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43F3C433C8;
        Mon,  7 Aug 2023 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414580;
        bh=yf+i4Rv/o/8TXBlVhYljTJbV/eUqv5ZZTBjDmCQ4PA0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=c7w/2nHMiI1Ih+Msu1UD6s4O38rZIEENrYqf7XuoFBaFf15Fe4+JSOfuKFujzqNm3
         A1uGMOVTB+QDlH9TKaLUmev4LBE2nFYOmK8GUlTTyu6rmIstFXbCyn6oh8uUsaf2cM
         R/65hn4+hV41m5w/416ZA8zHr1Z3ZBl3QH5s1h9AmNcDqyw00EfflTzK3EGgyi7r0q
         RpRNgQrrdLQCJT8YWwWTfnMm8CNAO8AtBzwhmCOV9drfyEUXWhpsKihRNN0AlcT0X5
         DdW+B6CkLJX0liDI1dZUsAkpaF3/yYTTIGIRaoCGj5fk4puaTCFpU2AubQgYbW7tEJ
         vKe4TutaePmgg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:26 +0200
Subject: [PATCH 32/41] mtd: spi-nor: eon: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-32-3d3d5bef4ba4@kernel.org>
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
 drivers/mtd/spi-nor/eon.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
index ba09cb6c2abd..c1ddf662f782 100644
--- a/drivers/mtd/spi-nor/eon.c
+++ b/drivers/mtd/spi-nor/eon.c
@@ -10,32 +10,37 @@
 
 static const struct flash_info eon_nor_parts[] = {
 	{
-		.id = SNOR_ID(0x1c, 0x31, 0x16),
-		.name = "en25f32",
-		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K,
-	}, {
 		.id = SNOR_ID(0x1c, 0x20, 0x16),
 		.name = "en25p32",
 		.size = SZ_4M,
-	}, {
-		.id = SNOR_ID(0x1c, 0x30, 0x16),
-		.name = "en25q32b",
-		.size = SZ_4M,
 	}, {
 		.id = SNOR_ID(0x1c, 0x20, 0x17),
 		.name = "en25p64",
 		.size = SZ_8M,
+	}, {
+		.id = SNOR_ID(0x1c, 0x30, 0x14),
+		.name = "en25q80a",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0x1c, 0x30, 0x16),
+		.name = "en25q32b",
+		.size = SZ_4M,
 	}, {
 		.id = SNOR_ID(0x1c, 0x30, 0x17),
 		.name = "en25q64",
 		.size = SZ_8M,
 		.no_sfdp_flags = SECT_4K,
 	}, {
-		.id = SNOR_ID(0x1c, 0x30, 0x14),
-		.name = "en25q80a",
-		.size = SZ_1M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+		.id = SNOR_ID(0x1c, 0x31, 0x16),
+		.name = "en25f32",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.name = "en25s64",
+		.id = SNOR_ID(0x1c, 0x38, 0x17),
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x15),
 		.name = "en25qh16",
@@ -57,11 +62,6 @@ static const struct flash_info eon_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x1c, 0x70, 0x19),
 		.name = "en25qh256",
-	}, {
-		.name = "en25s64",
-		.id = SNOR_ID(0x1c, 0x38, 0x17),
-		.size = SZ_8M,
-		.no_sfdp_flags = SECT_4K,
 	},
 };
 

-- 
2.39.2

