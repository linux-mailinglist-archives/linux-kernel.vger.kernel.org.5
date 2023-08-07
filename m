Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F1772595
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjHGNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjHGNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0730E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A4561B0C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535C3C433CD;
        Mon,  7 Aug 2023 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414574;
        bh=EyuDNaE5JOFL0ZQ/K44CuNRKS87m9hVeJq1QWqZcq6Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iSKsVsqfX/2z9UasmUll/MuIlbesMuNKfOKMo+3MG6KgzrrToj8aMB31r+/uIxcNp
         T53LbfUO4pUuBTy2W0QBrwA7b3xChhZigbfOivgKBBtjgGll6V0oZZsQ2OzVQRhtiV
         UhfDDCdUoInzJS/Gbtmt5qCwvoeroVAtHV9bnuGtU2kK6NK5haUuINgfTNZLuuCuUP
         slu6CcgcOjvPBSi2QhrSPgOgk/zT8b1DJEgYdk6SnHTs4ti0m3fajd5nlZyi3CpLTp
         DRhKa4vmWqvftJ+lP7tqeucTJHBQIcfn+gBC0pK8BCW8/iUCaN6Dc4Kd279COitgIn
         uV+Ifj8wl7yUw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:23 +0200
Subject: [PATCH 29/41] mtd: spi-nor: xilinx: use new macros in S3AN_INFO()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-29-3d3d5bef4ba4@kernel.org>
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

There won't be any new entries, nor are the entries that much different
and the very odd page and sector sizes make the new format hard to read.
Therefore, convert the old S3AN_INFO() macro.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
This collides with the atmel flashes and there seems to be a typo in the
IDs. All this makes me wonder wether we shouldn't deprecate the support
for this (FPGA configuration) flash.
---
 drivers/mtd/spi-nor/xilinx.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 8d4539e32dfe..f99118c691b0 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -21,21 +21,22 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
-#define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
-		SPI_NOR_ID(_jedec_id, 0),				\
-		.size = 8 * (_page_size) * (_n_sectors),		\
-		.sector_size = (8 * (_page_size)),			\
-		.page_size = (_page_size),				\
-		.flags = SPI_NOR_NO_FR
+#define S3AN_FLASH(_id, _name, _n_sectors, _page_size)		\
+	.id = _id,						\
+	.name = _name,						\
+	.size = 8 * (_page_size) * (_n_sectors),		\
+	.sector_size = (8 * (_page_size)),			\
+	.page_size = (_page_size),				\
+	.flags = SPI_NOR_NO_FR
 
 /* Xilinx S3AN share MFR with Atmel SPI NOR */
 static const struct flash_info xilinx_nor_parts[] = {
 	/* Xilinx S3AN Internal Flash */
-	{ "3S50AN", S3AN_INFO(0x1f2200, 64, 264) },
-	{ "3S200AN", S3AN_INFO(0x1f2400, 256, 264) },
-	{ "3S400AN", S3AN_INFO(0x1f2400, 256, 264) },
-	{ "3S700AN", S3AN_INFO(0x1f2500, 512, 264) },
-	{ "3S1400AN", S3AN_INFO(0x1f2600, 512, 528) },
+	{ S3AN_FLASH(SNOR_ID(0x1f, 0x22, 0x00), "3S50AN", 64, 264) },
+	{ S3AN_FLASH(SNOR_ID(0x1f, 0x24, 0x00), "3S200AN", 256, 264) },
+	{ S3AN_FLASH(SNOR_ID(0x1f, 0x24, 0x00), "3S400AN", 256, 264) },
+	{ S3AN_FLASH(SNOR_ID(0x1f, 0x25, 0x00), "3S700AN", 512, 264) },
+	{ S3AN_FLASH(SNOR_ID(0x1f, 0x26, 0x00), "3S1400AN", 512, 528) },
 };
 
 /*

-- 
2.39.2

