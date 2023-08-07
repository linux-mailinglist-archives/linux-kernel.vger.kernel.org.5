Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5677256F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjHGNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjHGNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2531FCC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8FA61AD8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3A8C433C7;
        Mon,  7 Aug 2023 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414533;
        bh=E+JQZfu4pGNJ17JtSl9cUW7fdM1ZGLxtIJz2xDbEL5Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HocVn6R8oh/wEBD6MuYjxhKp90BmGCd6Xstbp6QGG3g81zq7MrbOBlnw7m0Eb0tsx
         KV2Q7qmdG1ehiFrKyWA+lFG/jpwIL2h4/oLo6QjHlwHh0cNpQK0MQWlGFsobajHCXX
         4ceG0P6O1ABPY0D4xFl89RkFQihhTg2AP2hbUBwX/WKfoIdxQOpQr+GEXg/mZfq7Bg
         uxNUuz464iz9o9P2BbK+K9a/+fI+XUKcHAzUjdc32FNVqiJSf2adezaTiA0Ox56Zo3
         1LWEGbn0QeJ7X8i40re7lkncyHgM2/aC3W4DvKI3E8nbYgSCEtTVNqjPSbOrpTLZKp
         KpwytaPfneXmg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:04 +0200
Subject: [PATCH 10/41] mtd: spi-nor: make sector_size optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-10-3d3d5bef4ba4@kernel.org>
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

Most of the (old, non-SFDP) flashes use a sector size of 64k. Make that
a default value so it can be optional in the flash_info database.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 6 ++++--
 drivers/mtd/spi-nor/core.h | 8 +++++---
 drivers/mtd/spi-nor/swp.c  | 6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5c6a0edafae2..cf0e25b4f9a9 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2755,7 +2755,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_erase_map *map = &params->erase_map;
-	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
+	const struct flash_info *info = nor->info;
+	const u8 no_sfdp_flags = info->no_sfdp_flags;
 	u8 i, erase_mask;
 
 	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
@@ -2809,7 +2810,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
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
index c90445e186c0..734aedd4d62c 100644
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

