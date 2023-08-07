Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C326B77256C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHGNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjHGNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE319A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0D361AB6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA7EC433CD;
        Mon,  7 Aug 2023 13:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414527;
        bh=XCnlYb+na/0VxaPkBA8d090WtxQfh60ZWSm4AhLeiK0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lm+TRtxDDlqNgRjhBOrkxAYFV06TLlaaJeXExcYSfPKCr5BLujJM7KrBD2eI07de+
         PdSKjvuauQDNfccs3LbxLvm2hrMILLYO4qZOK1Dw/ZUftYSniLKP5Oe/G58vgIarxM
         f74/vhIGqauPWq08IXp2vt01mOYUzQ9NKgH+dxfO44RU+2jQosvSoxI5nhN7aUwOTp
         mwI/xx4mjHf6hmkNN2DDjR4MRN2dDvL2tOnz7e/NYwvF8FV/4Rdvd3Sdr5nK2If9Kz
         4tamEpUySMNIWAaLnYyOx0LW0YQCvLep2BJ/kHNboJgDrGXSRB9x/ZAnmDMh0bSD9q
         7dcBYwYRa5b3w==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:01 +0200
Subject: [PATCH 07/41] mtd: spi-nor: store .n_banks in struct
 spi_nor_flash_parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-7-3d3d5bef4ba4@kernel.org>
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

First, fixups might want to replace the n_banks parameter, thus we need
it in the (writable) parameter struct. Secondly, this way we can have a
default in the core and just skip setting the n_banks in the flash_info
database. Most of the flashes doesn't have more than one bank.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 7 ++++---
 drivers/mtd/spi-nor/core.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 138bc1e0a67c..ea94fb0da1e5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2861,7 +2861,7 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 	if (flags & NO_CHIP_ERASE)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 
-	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
+	if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
 	    !nor->controller_ops)
 		nor->flags |= SNOR_F_RWW;
 }
@@ -2925,8 +2925,8 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
 
-	if (nor->info->n_banks > 1)
-		params->bank_size = div64_u64(params->size, nor->info->n_banks);
+	if (params->n_banks > 1)
+		params->bank_size = div64_u64(params->size, params->n_banks);
 
 	return 0;
 }
@@ -2996,6 +2996,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	params->size = info->size;
 	params->bank_size = params->size;
 	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
+	params->n_banks = info->n_banks;
 
 	if (!(info->flags & SPI_NOR_NO_FR)) {
 		/* Default to Fast Read for DT and non-DT platform devices. */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 25bc18197614..fe1ce232a6c8 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -358,6 +358,7 @@ struct spi_nor_otp {
  *			in octal DTR mode.
  * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
  *			command in octal DTR mode.
+ * @n_banks:		the number of banks.
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

