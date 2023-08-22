Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB1783A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjHVHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjHVHJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973711AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E6CB649DF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA44AC433C7;
        Tue, 22 Aug 2023 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688188;
        bh=LgVMUtw1CM1hDbEFLUFoQErg4cNgw+t9IA0MTKH/DNQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jBsWh4AbN5xuoP2VMKu92lKhW32mdi+Sy37q5FxcJXuSONJCFCsZ5jzXbrtcMEXM2
         ASWrF2AUDhx6mKaT/5f6q0YPGyqFISys9zjBGBwC6kSr3sK0a/fjbxezqpRXBynHco
         KGdEuxM5OBY5boVl+ad9CrJTwMbgcInZN+GAGACX0xkk766AiJzoynMNSsjAYVCMok
         Y+RkoVMxHcP0/w7TU2wXBEyBXdpa4lLRjOn/VJdj9m+5S6CvalHZfzJ1Hqb2kD523f
         7A3oapaq/LjPciswfkjTpKitcIRj2qm8xWIisGuwistihrwVHahmxG+OZ5YPx1GHjB
         ZWxu8aFo4s3wA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:22 +0200
Subject: [PATCH v2 06/41] mtd: spi-nor: default page_size to 256 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-6-291a0f39f8d8@kernel.org>
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

The INFO() macro always set the page_size to 256 bytes. Make that an
optional parameter. This default is a sane one for all older flashes,
newer ones will set the page size by its SFDP tables anyway.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/spi-nor/core.c | 7 +------
 drivers/mtd/spi-nor/core.h | 8 ++++++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f4cc2eafcc5e..d27ad1295ee0 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2018,11 +2018,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 static const struct flash_info spi_nor_generic_flash = {
 	.name = "spi-nor-generic",
 	.n_banks = 1,
-	/*
-	 * JESD216 rev A doesn't specify the page size, therefore we need a
-	 * sane default.
-	 */
-	.page_size = 256,
 	.parse_sfdp = true,
 };
 
@@ -3001,7 +2996,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->writesize = 1;
 	params->size = info->size;
 	params->bank_size = params->size;
-	params->page_size = info->page_size;
+	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
 
 	if (!(info->flags & SPI_NOR_NO_FR)) {
 		/* Default to Fast Read for DT and non-DT platform devices. */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 12c35409493b..25bc18197614 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -10,6 +10,11 @@
 #include "sfdp.h"
 
 #define SPI_NOR_MAX_ID_LEN	6
+/*
+ * 256 bytes is a sane default for most older flashes. Newer flashes will
+ * have the page size defined within their SFDP tables.
+ */
+#define SPI_NOR_DEFAULT_PAGE_SIZE 256
 
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
@@ -447,7 +452,7 @@ struct spi_nor_fixups {
  * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
  *                  isn't necessarily called a "sector" by the vendor.
  * @n_banks:        the number of banks.
- * @page_size:      the flash's page size.
+ * @page_size:      (optional) the flash's page size. Defaults to 256.
  * @addr_nbytes:    number of address bytes to send.
  *
  * @parse_sfdp:     true when flash supports SFDP tables. The false value has no
@@ -558,7 +563,6 @@ struct flash_info {
 #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
 	.size = (_sector_size) * (_n_sectors),				\
 	.sector_size = (_sector_size),					\
-	.page_size = 256,						\
 	.n_banks = (_n_banks)
 
 /* Used when the "_ext_id" is two bytes at most */

-- 
2.39.2

