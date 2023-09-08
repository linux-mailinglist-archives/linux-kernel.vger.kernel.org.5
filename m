Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224E879858E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjIHKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbjIHKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:16:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216671FEB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:16:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3269C433CC;
        Fri,  8 Sep 2023 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168199;
        bh=FEz+x044HaJXIEP12prthCCwYdEPCM16pe3GigXUbHQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JCOPQ9gcZMk4ozxWiA6kCSjxYrzGS/SvPIumplKcZ22KjBYEAv2wU/hzF3OLo2nZg
         5faV8jVMK4l2BUAfv12wZGWCijcvYDHl5IFZuTWy/JLAl3GozLMwhyfCX2t0syw3mP
         CRj+IVE+IhFvHk3Du5oUMItSoJOcXpmK3EHad9CEFUDXfdmYp+A9+DFYRWAzCrOh3T
         zHmVsauGl7gj2qYOuSsGVtWIBKhyly0ttxKDItLCanI42P7fR6SZyBxHMHAiM7fSBW
         zKTHinHC9nB9ww5bF9b+cUrB2raqwNSFEt2z9UOMa0fbl/o3WSl2YbhnkGMAnOHLR4
         8lRtzudFGh34A==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:23 +0200
Subject: [PATCH v3 05/41] mtd: spi-nor: convert .n_sectors to .size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-5-e60548861b10@kernel.org>
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

.n_sectors is rarely used. In fact it is only used in swp.c and to
calculate the flash size in the core. The use in swp.c might be
converted to use the (largest) flash erase size. For now, we just
locally calculate the sector size.

Simplify the flash_info database and set the size of the flash directly.
This also let us use the SZ_x macros.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c   | 2 +-
 drivers/mtd/spi-nor/core.h   | 8 ++++----
 drivers/mtd/spi-nor/swp.c    | 9 +++++----
 drivers/mtd/spi-nor/xilinx.c | 4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 286155002cdc..f4cc2eafcc5e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2999,7 +2999,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 
 	/* Set SPI NOR sizes. */
 	params->writesize = 1;
-	params->size = (u64)info->sector_size * info->n_sectors;
+	params->size = info->size;
 	params->bank_size = params->size;
 	params->page_size = info->page_size;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index dfc20a3296fb..12c35409493b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -443,9 +443,9 @@ struct spi_nor_fixups {
  * @id:             the flash's ID bytes. The first three bytes are the
  *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly older chips).
  * @id_len:         the number of bytes of ID.
+ * @size:           the size of the flash in bytes.
  * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
  *                  isn't necessarily called a "sector" by the vendor.
- * @n_sectors:      the number of sectors.
  * @n_banks:        the number of banks.
  * @page_size:      the flash's page size.
  * @addr_nbytes:    number of address bytes to send.
@@ -505,8 +505,8 @@ struct flash_info {
 	char *name;
 	u8 id[SPI_NOR_MAX_ID_LEN];
 	u8 id_len;
+	size_t size;
 	unsigned sector_size;
-	u16 n_sectors;
 	u16 page_size;
 	u8 n_banks;
 	u8 addr_nbytes;
@@ -556,8 +556,8 @@ struct flash_info {
 	.id_len = 6
 
 #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
+	.size = (_sector_size) * (_n_sectors),				\
 	.sector_size = (_sector_size),					\
-	.n_sectors = (_n_sectors),					\
 	.page_size = 256,						\
 	.n_banks = (_n_banks)
 
@@ -575,8 +575,8 @@ struct flash_info {
 	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
 
 #define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
+		.size = (_sector_size) * (_n_sectors),			\
 		.sector_size = (_sector_size),				\
-		.n_sectors = (_n_sectors),				\
 		.page_size = (_page_size),				\
 		.n_banks = 1,						\
 		.addr_nbytes = (_addr_nbytes),				\
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 5ab9d5324860..40bf52867095 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -34,17 +34,18 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
 static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 {
 	unsigned int bp_slots, bp_slots_needed;
+	unsigned int sector_size = nor->info->sector_size;
+	u64 n_sectors = div_u64(nor->params->size, sector_size);
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 
 	/* Reserved one for "protect none" and one for "protect all". */
 	bp_slots = (1 << hweight8(mask)) - 2;
-	bp_slots_needed = ilog2(nor->info->n_sectors);
+	bp_slots_needed = ilog2(n_sectors);
 
 	if (bp_slots_needed > bp_slots)
-		return nor->info->sector_size <<
-			(bp_slots_needed - bp_slots);
+		return sector_size << (bp_slots_needed - bp_slots);
 	else
-		return nor->info->sector_size;
+		return sector_size;
 }
 
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 34267591282c..284e2e4970ab 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -23,8 +23,8 @@
 
 #define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
 		SPI_NOR_ID(_jedec_id, 0),				\
+		.size = 8 * (_page_size) * (_n_sectors),		\
 		.sector_size = (8 * (_page_size)),			\
-		.n_sectors = (_n_sectors),				\
 		.page_size = (_page_size),				\
 		.n_banks = 1,						\
 		.flags = SPI_NOR_NO_FR
@@ -138,7 +138,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 		page_size = (nor->params->page_size == 264) ? 256 : 512;
 		nor->params->page_size = page_size;
 		nor->mtd.writebufsize = page_size;
-		nor->params->size = 8 * page_size * nor->info->n_sectors;
+		nor->params->size = nor->info->size;
 		nor->mtd.erasesize = 8 * page_size;
 	} else {
 		/* Flash in Default addressing mode */

-- 
2.39.2

