Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA62B7985A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbjIHKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbjIHKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:19:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B32117
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:18:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F29C433BD;
        Fri,  8 Sep 2023 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168274;
        bh=4j+TSHZz8J89KqW87Ge8U9T1z6cX77wZsqqm1rpBNGc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gCrrcjBtCHPcW0MqwcCQSyqJCCr/IM2WK9noO9v7+Ffg+8ZytdElTVATRNCabPVZf
         prjvbWxn3jQp/DH5uir5V8GSkncC0ixgn/r/Fen7u79HN1EUqdpdu8b9bnVByJZ09F
         +S028TnBhioz+6Ceu/QOFIu2aANAofBQKNeVsSnf7PwavJ6Cfux6jWGcC+JpxPpJuD
         b39QNGR6PvH0CgOK99z1UWUJyaiKbT1KTvS82CVg6K1r1Ozyh6CnTR60ZHeQLb8Azn
         KcOnfS7/Tu+Xgq748ZUS8wCk7JnHFnT3bSLrFCkIr2Mm7IcOT5woM29xJnGbKRShrW
         YF02VSA0Wngaw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:58 +0200
Subject: [PATCH v3 40/41] mtd: spi-nor: atmel: drop duplicate entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-40-e60548861b10@kernel.org>
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

The Atmel AT26DF321 and AT25DF321 have the same ID. Both were just
discovered by reading their IDs, that is, there is no probing by name.
Thus only the first one (the AT25DF321) in the list was ever probed.
Luckily, the AT25DF is also the newer series. Drop the AT26DF321.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v3:
 - double checked that at26df321 was last in the list
---
 drivers/mtd/spi-nor/atmel.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 18e904962d0e..95f0e139284e 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -206,13 +206,6 @@ static const struct flash_info atmel_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
-	}, {
-		.id = SNOR_ID(0x1f, 0x47, 0x00),
-		.name = "at26df321",
-		.size = SZ_4M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
-		.no_sfdp_flags = SECT_4K,
-		.fixups = &atmel_nor_global_protection_fixups
 	}, {
 		.id = SNOR_ID(0x1f, 0x47, 0x01),
 		.name = "at25df321a",

-- 
2.39.2

