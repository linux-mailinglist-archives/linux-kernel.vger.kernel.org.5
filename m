Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE96783A63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjHVHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjHVHKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB806E4B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCAA64CC7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B06C433C8;
        Tue, 22 Aug 2023 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688197;
        bh=1OgNf4tLGuQwWEt84lEgtGRwADQcaJNsRP1fBfkjLdU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fDpOxO4Ik24Xe7vxK2z6dOcGjSqHT6jk8Pow/2BzPxi65Xj0cJcr8RTivJqhzcfte
         x6zve5TIbhGL6YrPGcTuD+4GLy1IuZD1s9K47TavY+gW8VfEzUwysgzsiFpPUnHGJT
         k1129GaPAivTh1Sakcre1M5l4aXmALsJTQYTTIr42CtqsDNEAmNcishkTuSwrrbvnV
         Ri5GCYJqPTT2kwirlfsXsME2j6S3BRkx02XZQWEnblv8p2ZUq9tEyrEAG2O+EzZ3n6
         +JR7QoSwiH9plyflFbNCRqhGsLi8f/Hjde5sYfz9I/Y3qu9QfCGnrRr4puWs4UrZ1W
         HZcD9ML3TNBMA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:26 +0200
Subject: [PATCH v2 10/41] mtd: spi-nor: make sector_size optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-10-291a0f39f8d8@kernel.org>
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

Most of the (old, non-SFDP) flashes use a sector size of 64k. Make that
a default value so it can be optional in the flash_info database.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 6 ++++--
 drivers/mtd/spi-nor/core.h | 8 +++++---
 drivers/mtd/spi-nor/swp.c  | 6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c84be791341e..368851ff9f40 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2756,7 +2756,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_erase_map *map = &params->erase_map;
-	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
+	const struct flash_info *info = nor->info;
+	const u8 no_sfdp_flags = info->no_sfdp_flags;
 	u8 i, erase_mask;
 
 	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
@@ -2810,7 +2811,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 		i++;
 	}
 	erase_mask |= BIT(i);
-	spi_nor_set_erase_type(&map->erase_type[i], nor->info->sector_size,
+	spi_nor_set_erase_type(&map->erase_type[i],
+			       info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
 }
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8627d0b95be6..fba3ea8536a5 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -16,6 +16,7 @@
  */
 #define SPI_NOR_DEFAULT_PAGE_SIZE 256
 #define SPI_NOR_DEFAULT_N_BANKS 1
+#define SPI_NOR_DEFAULT_SECTOR_SIZE SZ_64K
 
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
@@ -452,8 +453,9 @@ struct spi_nor_fixups {
  *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly older chips).
  * @id_len:         the number of bytes of ID.
  * @size:           the size of the flash in bytes.
- * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
- *                  isn't necessarily called a "sector" by the vendor.
+ * @sector_size:    (optional) the size listed here is what works with
+ *                  SPINOR_OP_SE, which isn't necessarily called a "sector" by
+ *                  the vendor. Defaults to 64k.
  * @n_banks:        (optional) the number of banks. Defaults to 1.
  * @page_size:      (optional) the flash's page size. Defaults to 256.
  * @addr_nbytes:    number of address bytes to send.
@@ -565,7 +567,7 @@ struct flash_info {
 
 #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
 	.size = (_sector_size) * (_n_sectors),				\
-	.sector_size = (_sector_size),					\
+	.sector_size = (_sector_size == SZ_64K) ? 0 : (_sector_size),	\
 	.n_banks = (_n_banks)
 
 /* Used when the "_ext_id" is two bytes at most */
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 40bf52867095..585813310ee1 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -34,7 +34,11 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
 static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 {
 	unsigned int bp_slots, bp_slots_needed;
-	unsigned int sector_size = nor->info->sector_size;
+	/*
+	 * sector_size will eventually be replaced with the max erase size of
+	 * the flash. For now, we need to have that ugly default.
+	 */
+	unsigned int sector_size = nor->info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE;
 	u64 n_sectors = div_u64(nor->params->size, sector_size);
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 

-- 
2.39.2

