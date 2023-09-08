Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75B7985DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbjIHK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbjIHK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A21FF9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0794CC43391;
        Fri,  8 Sep 2023 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168235;
        bh=pG2FdGd2bZ50xpBr1ZIaO+fF4bmW9tYC4LsRjQC4xQA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=STicWmLv7g3D+Mkn6PXX7F3isoqBQJY4vugZUQ6V4DD78LcyI0U///6ZZzVbt04Hp
         1VPKN7w8BA60yHQHKAGhquU49/Ks04f5FRaKO/xBkwOMxQXoakpG3ccRpwlDUZ8CG5
         a9KAm7dTW9bYvpEH1QrWbVorP5oft5JcR8eKvuB1nRjj4KAU6FfebiLj9pfyf2dwE5
         x8z8U3oEfGuZ/AmgtUqNHRqp3KIcHFCFIcjqnCQFjy1W1n76vfWRUrgqcAYW8u2WXw
         DlBS/LD/tZhdjWp6W4apRqFC7mew1dnJ1vUdHA8slC/lB6vLHh9PTBW3d/IN21aihe
         3VEz6UAdmT+lw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:40 +0200
Subject: [PATCH v3 22/41] mtd: spi-nor: intel: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-22-e60548861b10@kernel.org>
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

The INFOx() macros are going away. Convert the flash_info database to
the new format.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/intel.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index aba62759a02e..f647359fee7a 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -9,12 +9,22 @@
 #include "core.h"
 
 static const struct flash_info intel_nor_parts[] = {
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
+	{
+		.id = SNOR_ID(0x89, 0x89, 0x11),
+		.name = "160s33b",
+		.size = SZ_2M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+	}, {
+		.id = SNOR_ID(0x89, 0x89, 0x12),
+		.name = "320s33b",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+	}, {
+		.id = SNOR_ID(0x89, 0x89, 0x13),
+		.name = "640s33b",
+		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+	}
 };
 
 const struct spi_nor_manufacturer spi_nor_intel = {

-- 
2.39.2

