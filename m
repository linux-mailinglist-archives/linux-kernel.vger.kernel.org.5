Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A093A772582
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjHGNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjHGNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491411FEF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEECC61AF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E518C433CA;
        Mon,  7 Aug 2023 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414576;
        bh=qrtlb3Inp+0PAFufVQ6/JFPnxSSyzXyjdaLgPSqbaiA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NsR9qDDkaxORpZBJiKsta+1/GDmhp6GK5QJQzBO5BYofQPVspWIV4sKjVRJ3KSGZn
         84Gn3Xke2SL/S3sMIoYYvJIKCpMnguwiYYxJ5odVcjQvGYhBLAfwE+i1BNfLr8G7yj
         JHuV1NoEKkGHIi0ZFaymdqu0dHOVJfz+C0oPrCDQbQwTN26kpCw1W0uPLj7J6cGZCR
         3PnBxVYlfbOpe3G0QbUdobR0T6oKcMZM/kzzOlJbfQHQiZIcb7ba9ml+BqBG8nz2oq
         c2OIuDIC9NbBvShiKX7TLR2JabhafBhyxJaandhllpN8QGhzvC/xt5G02xJjM5LYYN
         dDypKC/z8C1dg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:24 +0200
Subject: [PATCH 30/41] mtd: spi-nor: xmc: convert flash_info to new format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-30-3d3d5bef4ba4@kernel.org>
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

