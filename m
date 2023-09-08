Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E698798590
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbjIHKRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjIHKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:16:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383C2116
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:16:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD80C433BF;
        Fri,  8 Sep 2023 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168203;
        bh=T89/S72zev0zM3PT2bX1H7LCoqUelnfRBWMuWQbSpiM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YKajqh5qmxfm8nRsoN1FgIipGx2iCrFppuPf/DxZbAcBhVeGaRwjzX3AEBBYenNkK
         aZDaYugUFP92MQHjOgRzov2uSRTEtW/pZwydnMsgLPXR199a5Yyq1p1+5PlAB8g73E
         gcYvVwud1LI1T0ShgGsKVXFnsJBdO5Owzg36ThikTtsBY9zPsjeQ/qPLEPB2LA4kfa
         5k0eJTORSdtQuKKj6wK9H4RIhp4N1fIqHlfbPnP4CPOYR/dLwH9DHwQSURQfM7ijrx
         zPlpThaNzWV6JF2/gigpA/zvk3NaepHd63gDIW2aQwYmf9gCC8SevQSSuE1wAnYTtD
         66COMI8oRimUg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:25 +0200
Subject: [PATCH v3 07/41] mtd: spi-nor: store .n_banks in struct
 spi_nor_flash_parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-7-e60548861b10@kernel.org>
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

First, fixups might want to replace the n_banks parameter, thus we need
it in the (writable) parameter struct. Secondly, this way we can have a
default in the core and just skip setting the n_banks in the flash_info
database. Most of the flashes doesn't have more than one bank.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 7 ++++---
 drivers/mtd/spi-nor/core.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d27ad1295ee0..e27f1323fa0b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2862,7 +2862,7 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 	if (flags & NO_CHIP_ERASE)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 
-	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
+	if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
 	    !nor->controller_ops)
 		nor->flags |= SNOR_F_RWW;
 }
@@ -2926,8 +2926,8 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
 
-	if (nor->info->n_banks > 1)
-		params->bank_size = div64_u64(params->size, nor->info->n_banks);
+	if (params->n_banks > 1)
+		params->bank_size = div64_u64(params->size, params->n_banks);
 
 	return 0;
 }
@@ -2997,6 +2997,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->size = info->size;
 	params->bank_size = params->size;
 	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
+	params->n_banks = info->n_banks;
 
 	if (!(info->flags & SPI_NOR_NO_FR)) {
 		/* Default to Fast Read for DT and non-DT platform devices. */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 25bc18197614..2fc999f2787c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -358,6 +358,7 @@ struct spi_nor_otp {
  *			in octal DTR mode.
  * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
  *			command in octal DTR mode.
+ * @n_banks:		number of banks.
  * @n_dice:		number of dice in the flash memory.
  * @vreg_offset:	volatile register offset for each die.
  * @hwcaps:		describes the read and page program hardware
@@ -394,6 +395,7 @@ struct spi_nor_flash_parameter {
 	u8				addr_mode_nbytes;
 	u8				rdsr_dummy;
 	u8				rdsr_addr_nbytes;
+	u8				n_banks;
 	u8				n_dice;
 	u32				*vreg_offset;
 

-- 
2.39.2

