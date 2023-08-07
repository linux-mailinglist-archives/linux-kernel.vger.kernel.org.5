Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9177256D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjHGNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjHGNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CB1BCA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 358A061AAC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC75CC433BC;
        Mon,  7 Aug 2023 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414529;
        bh=x81z/w7MTIXGNt4ORqQ7OIkEQ9gCB22Av++T5rIayN4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PpswHcdMJUXyczPi0T7jDCRwsch7FmOyhzHvs0POEo6JrQeXJrkM+L5BEp+4OBBfy
         I5+axJ1Bd8LOH5K6euVgc3IYqNhs9Owjkk6d7uJ+r0zgsx9VKqq2xBjGf3cDCFaMp5
         9X+vfSZYqR3d4Z8rVoNxaJ9PcovdMynvN5sh1bTipg8rSX13gknni25B6rpw248I2W
         CHU4gNAG8Nv/h1f+u3fNBGSZWPzgJkOoqVDZUScYgZmMcYbCSA/wdmJ8FJhSoIKw15
         6kcDIm9zVitjkn05TYEOIflkVwCyqxjOL2BjO1ktrF9eBuudkxA0btywbWKXozmy9m
         v3Gc3f53ycWJw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:02 +0200
Subject: [PATCH 08/41] mtd: spi-nor: default .n_banks to 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-8-3d3d5bef4ba4@kernel.org>
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

If .n_banks is not set in the flash_info database, the default value
should be 1. This way, we don't have to always set the .n_banks
parameter in flash_info.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c   | 3 +--
 drivers/mtd/spi-nor/core.h   | 8 ++++----
 drivers/mtd/spi-nor/xilinx.c | 1 -
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ea94fb0da1e5..015152ba8973 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2016,7 +2016,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 
 static const struct flash_info spi_nor_generic_flash = {
 	.name = "spi-nor-generic",
-	.n_banks = 1,
 	.parse_sfdp = true,
 };
 
@@ -2996,7 +2995,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->size = info->size;
 	params->bank_size = params->size;
 	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
-	params->n_banks = info->n_banks;
+	params->n_banks = info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
 
 	if (!(info->flags & SPI_NOR_NO_FR)) {
 		/* Default to Fast Read for DT and non-DT platform devices. */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index fe1ce232a6c8..c90445e186c0 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -15,6 +15,7 @@
  * have the page size defined within their SFDP tables.
  */
 #define SPI_NOR_DEFAULT_PAGE_SIZE 256
+#define SPI_NOR_DEFAULT_N_BANKS 1
 
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
@@ -453,7 +454,7 @@ struct spi_nor_fixups {
  * @size:           the size of the flash in bytes.
  * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
  *                  isn't necessarily called a "sector" by the vendor.
- * @n_banks:        the number of banks.
+ * @n_banks:        (optional) the number of banks. Defaults to 1.
  * @page_size:      (optional) the flash's page size. Defaults to 256.
  * @addr_nbytes:    number of address bytes to send.
  *
@@ -570,7 +571,7 @@ struct flash_info {
 /* Used when the "_ext_id" is two bytes at most */
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
 	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
-	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
+	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
 
 #define INFOB(_jedec_id, _ext_id, _sector_size, _n_sectors, _n_banks)	\
 	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
@@ -578,13 +579,12 @@ struct flash_info {
 
 #define INFO6(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
 	SPI_NOR_ID6((_jedec_id), (_ext_id)),				\
-	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
+	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
 
 #define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
 		.size = (_sector_size) * (_n_sectors),			\
 		.sector_size = (_sector_size),				\
 		.page_size = (_page_size),				\
-		.n_banks = 1,						\
 		.addr_nbytes = (_addr_nbytes),				\
 		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
 
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 284e2e4970ab..8d4539e32dfe 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -26,7 +26,6 @@
 		.size = 8 * (_page_size) * (_n_sectors),		\
 		.sector_size = (8 * (_page_size)),			\
 		.page_size = (_page_size),				\
-		.n_banks = 1,						\
 		.flags = SPI_NOR_NO_FR
 
 /* Xilinx S3AN share MFR with Atmel SPI NOR */

-- 
2.39.2

