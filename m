Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A3783A60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjHVHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjHVHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF102CC7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A59164D4C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5360C433CB;
        Tue, 22 Aug 2023 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688190;
        bh=2ZHDvbq3+3zLWqFwJBCT9nsnQo0T+nMGUO9QmyxfUBo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SAmXAVz6nj0bs8b2qLxVSXEdd2MX/4RP2Ymem5Sq9Lp9T6soqnOby52kDxVxiqy7R
         mt50w4imKBuCYRrMRYwD5F+zVH4q34tYlrPolxb7mV5Fq2sMY5s5P2pqS/aA5ybpXk
         wM3PVFIRX3DVfK3bgjvtvelxRUeKy/kG4uNqY8p7EU0s7jDNpEWsRm8azeBfzI8iHq
         YZ+ToT3ng98XIjC+9rm7J14qKZS3uxQJkIk2o0J8OiyIhV9biakXsIWBFDNr3vhMkg
         4RaFjulGPKrTEtp2kkcQ/YTsDCONzVyoGv+YJjLoY1PFLzzUZWvY+uD7cjA0AUIXvK
         HjV7qp1Dpx1uw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:23 +0200
Subject: [PATCH v2 07/41] mtd: spi-nor: store .n_banks in struct
 spi_nor_flash_parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-7-291a0f39f8d8@kernel.org>
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

First, fixups might want to replace the n_banks parameter, thus we need
it in the (writable) parameter struct. Secondly, this way we can have a
default in the core and just skip setting the n_banks in the flash_info
database. Most of the flashes doesn't have more than one bank.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

