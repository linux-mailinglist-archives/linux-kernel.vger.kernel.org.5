Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0725C783A62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjHVHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjHVHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF7FCEF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C424B648F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D42C433C7;
        Tue, 22 Aug 2023 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688195;
        bh=mNibVHfe5bNQ3u2ZbNVsMAi+XFRvTnwGKmym/9VH1zA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HRusENO6K0UrU4wOUYDCVPQpUJnv7A+osg9fdJwYuF9tw4n1zX/Tj4vT6rD+EGZZW
         PulewcoNlc7sBZkTQTTlx6um5U3QmBz19VGEoe3vdmpnyt+8qrBbvALjRI1twq2T6q
         7zAmlgzyzTaGNtqdnWuHjgu+6dNB5WwN1foAJwel8cbcezUMnbaZim6gNlclr9eOYA
         +JWHBIHp6GNvcvL5Lsb2Z4sVNVYN0LM5FClCVAvHBfZroyzZP0MkNnOuZTuK77+jLt
         /WivawNROzcwyXKGGfrZXQKIJVQV4l3mwTZFYPuNPgIEBO0C0akOW4U/Dn89N0LzUb
         bBt1pJzoxnsow==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:25 +0200
Subject: [PATCH v2 09/41] mtd: spi-nor: push 4k SE handling into
 spi_nor_select_uniform_erase()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-9-291a0f39f8d8@kernel.org>
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

4k sector erase sizes are only a thing with uniform erase types. Push
the "we want 4k erase sizes" handling into spi_nor_select_uniform_erase().

One might wonder why the former sector_size isn't used anymore. It is
because we either search for the largest erase size or if selected
through kconfig, the 4k erase size. Now, why is that correct? For this,
we have to differentiate between (1) flashes with SFDP and (2) without
SFDP. For (1), we just set one (or two if SECT_4K is set) erase types
and wanted_size is exactly one of these.

For (2) things are a bit more complicated. For flashes which we don't
have in our flash_info database, the generic driver is used and
sector_size was already 0, which in turn selected the largest erase
size. For flashes which had SFDP and an entry in flash_info, sector_size
was always the largest sector and thus the largest erase type.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 68baf6032639..c84be791341e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2512,13 +2512,6 @@ static int spi_nor_select_pp(struct spi_nor *nor,
 /**
  * spi_nor_select_uniform_erase() - select optimum uniform erase type
  * @map:		the erase map of the SPI NOR
- * @wanted_size:	the erase type size to search for. Contains the value of
- *			info->sector_size, the "small sector" size in case
- *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined or 0 if
- *			there is no information about the sector size. The
- *			latter is the case if the flash parameters are parsed
- *			solely by SFDP, then the largest supported erase type
- *			is selected.
  *
  * Once the optimum uniform sector erase command is found, disable all the
  * other.
@@ -2526,13 +2519,16 @@ static int spi_nor_select_pp(struct spi_nor *nor,
  * Return: pointer to erase type on success, NULL otherwise.
  */
 static const struct spi_nor_erase_type *
-spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
-			     const u32 wanted_size)
+spi_nor_select_uniform_erase(struct spi_nor_erase_map *map)
 {
 	const struct spi_nor_erase_type *tested_erase, *erase = NULL;
 	int i;
 	u8 uniform_erase_type = map->uniform_erase_type;
 
+	/*
+	 * Search for the biggest erase size, except for when compiled
+	 * to use 4k erases.
+	 */
 	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
 		if (!(uniform_erase_type & BIT(i)))
 			continue;
@@ -2544,10 +2540,11 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
 			continue;
 
 		/*
-		 * If the current erase size is the one, stop here:
+		 * If the current erase size is the 4k one, stop here,
 		 * we have found the right uniform Sector Erase command.
 		 */
-		if (tested_erase->size == wanted_size) {
+		if (IS_ENABLED(CONFIG_MTD_SPI_NOR_USE_4K_SECTORS) &&
+		    tested_erase->size == SZ_4K) {
 			erase = tested_erase;
 			break;
 		}
@@ -2575,7 +2572,6 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 	struct spi_nor_erase_map *map = &nor->params->erase_map;
 	const struct spi_nor_erase_type *erase = NULL;
 	struct mtd_info *mtd = &nor->mtd;
-	u32 wanted_size = nor->info->sector_size;
 	int i;
 
 	/*
@@ -2586,13 +2582,8 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 	 * manage the SPI flash memory as uniform with a single erase sector
 	 * size, when possible.
 	 */
-#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
-	/* prefer "small sector" erase if possible */
-	wanted_size = 4096u;
-#endif
-
 	if (spi_nor_has_uniform_erase(nor)) {
-		erase = spi_nor_select_uniform_erase(map, wanted_size);
+		erase = spi_nor_select_uniform_erase(map);
 		if (!erase)
 			return -EINVAL;
 		nor->erase_opcode = erase->opcode;

-- 
2.39.2

