Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B77985AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjIHKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjIHKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:19:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6622122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:19:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FECC433C7;
        Fri,  8 Sep 2023 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168252;
        bh=qrtlb3Inp+0PAFufVQ6/JFPnxSSyzXyjdaLgPSqbaiA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DYxVNw2n5ACTgyEoxTzZ9Gf4qW625HO4uRskm+x+dDOZoyrZ8YbRg8Jg1Jsy/ApZH
         n2L+hQ/EggbK1KymH5orwnBB8AKmOVdDcD6FcAEA4cBGZ5J0tyBqEc4or9YesO6x3V
         tnULKFbsdrXg8mGEJKkC69OvNBAoyaSLQG/6bWr7hjS/xgIoARfM2e8f3JO+jUhr6J
         HqCgjrPMkmd0Y+A6rkaQpnAGisZT2IsiV/6cH5iSKQny7bH70S6BzgX0wzAISW1hnX
         BYfXdllxaWW/14bUNT7NDf2eNVi7n6Qi+8awYHxDh/EknL3qCHQRw+4h6+Vo/ZL+kT
         z4qkyaTGzZysQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:48 +0200
Subject: [PATCH v3 30/41] mtd: spi-nor: xmc: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-30-e60548861b10@kernel.org>
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
 drivers/mtd/spi-nor/xmc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 48062ccb22fa..d5a06054b0dd 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -9,12 +9,17 @@
 #include "core.h"
 
 static const struct flash_info xmc_nor_parts[] = {
-	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+	{
+		.id = SNOR_ID(0x20, 0x70, 0x17),
+		.name = "XM25QH64A",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x20, 0x70, 0x18),
+		.name = "XM25QH128A",
+		.size = SZ_16M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	},
 };
 
 /* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */

-- 
2.39.2

