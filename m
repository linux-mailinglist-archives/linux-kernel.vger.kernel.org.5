Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C27985A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjIHKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbjIHKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:18:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7F1FEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:17:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94F0C433BA;
        Fri,  8 Sep 2023 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168250;
        bh=EyuDNaE5JOFL0ZQ/K44CuNRKS87m9hVeJq1QWqZcq6Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QK/8ylBJwg8tz4KjlIs3GYOJq7nmkCdUkJYhf1p29sOjH4dFNgjSt1WoUWpkassgw
         Zgqp5Uf0snHWZEpxub1QdL/k2MQbF8Vnq4kjB1aN9V1f/SpcVy61RTCiSQDV93MB+e
         2oLamucnp9ZFd9lLBoA+HKv8XVTqwlf/p71ohETr0TxtQ8xyS0lXKgP/pXOLZvh9oN
         DmYJ06NX6SBy5gwWycwnkFQGoQEZcFQFxHN3uiRG5Ic8xdofAoQAd5n3ex/DqwgKWl
         gSUYFJBbJS5+k8oJcc+Oxsl3r69X4GJBGVvpjStjd0rqf3zWFickCvuZXljCBoHxob
         u6Rqd8YF72z6g==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:47 +0200
Subject: [PATCH v3 29/41] mtd: spi-nor: xilinx: use new macros in
 S3AN_INFO()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-29-e60548861b10@kernel.org>
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

