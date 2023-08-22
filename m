Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05B783A80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHVHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjHVHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C3E1B7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0161637BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDAAC433C7;
        Tue, 22 Aug 2023 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688240;
        bh=yf+i4Rv/o/8TXBlVhYljTJbV/eUqv5ZZTBjDmCQ4PA0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qKh+Z+JW9aXiTrSnLy2qAMQrDPCSHzFhlHX1NUPDko1ydcEAPeUS/yZX/EhpSrYXH
         bETWdtNFj2yPM6MJcT2D0/+PL2wbmq91go6N/dNgrHU77JLCGYbX46aiLust2nG48c
         x3E5v7jAVyz5p6MAQE9vgPhVnHKnTV1WRkH9MkPIBsSjxSOYCa0gZuPa/7QxAcctTA
         YKej/C6tEeo0V5dqnALnFlYCvSCbE8nc7d9zyOKTPgwb/GsH/Q4rHw6LrBelr7lq18
         aLFwRvtrcShCpLiTJuwMkaVU8t7vKoeaiWsXdlM795xwS2hnjthQVkrJHdFV9JxO1P
         w28370b99WuNA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:48 +0200
Subject: [PATCH v2 32/41] mtd: spi-nor: eon: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-32-291a0f39f8d8@kernel.org>
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

