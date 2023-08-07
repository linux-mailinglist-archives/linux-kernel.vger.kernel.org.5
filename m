Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A077257E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjHGNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHGNXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD31BF5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9539D61B0E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4CDC433C7;
        Mon,  7 Aug 2023 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414555;
        bh=1nkVQlo/pntUPcuI8tZ3St9xyXgZLdanptrUEPEewkQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BG1TQ70GI+gpRihh8XnlP2KHjfXnD/irqFQ0ogYgWsqvSdITnF0fIGh528xRQ2st0
         a5NQVNb4OYQszDBl8LGsKzm+HSNSx1Y49AXX2ngIpURrFoOldb2OBanv2lcI5s3E12
         O5YNfx+Cs1KJd7+4eygBzXN0/eROY3q2occ13ad6xPPw12tU3iN1Ugx7NGZWQdNt8y
         uwT78lLQ/JaIFGDz3avZjJ5E0kxDBsdEhhRWHNldrTmkZ5n/pzuPtv+5ZTiMm5XCPl
         28ijbKIEj6tZNAtFHHpQgGa0rlrMzygtxkVO2NgvOSyt4FYhnSETbNCigdmILAlk0E
         4HtCig4nXM1Zg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:14 +0200
Subject: [PATCH 20/41] mtd: spi-nor: everspin: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-20-3d3d5bef4ba4@kernel.org>
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

The INFOx() macros are going away. Convert the flash_info database to
the new format.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/everspin.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index d02c32f2f7ad..46776bc10b27 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -9,10 +9,35 @@
 #include "core.h"
 
 static const struct flash_info everspin_nor_parts[] = {
-	{ "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
-	{ "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
-	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
-	{ "mr25h40",  CAT25_INFO(512 * 1024, 1, 256, 3) },
+	{
+		.name = "mr25h128",
+		.size = SZ_16K,
+		.sector_size = SZ_16K,
+		.page_size = 256,
+		.addr_nbytes = 2,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.name = "mr25h256",
+		.size = SZ_32K,
+		.sector_size = SZ_32K,
+		.page_size = 256,
+		.addr_nbytes = 2,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.name = "mr25h10",
+		.size = SZ_128K,
+		.sector_size = SZ_128K,
+		.page_size = 256,
+		.addr_nbytes = 3,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.name = "mr25h40",
+		.size = SZ_512K,
+		.sector_size = SZ_512K,
+		.page_size = 256,
+		.addr_nbytes = 3,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}
 };
 
 const struct spi_nor_manufacturer spi_nor_everspin = {

-- 
2.39.2

