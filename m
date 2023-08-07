Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BD772579
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjHGNXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjHGNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D138170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7604261ADE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3417AC433C8;
        Mon,  7 Aug 2023 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414552;
        bh=Oyq3JU+jD6JnYKUuJ4JBwmfio4ODb3qr1zJ7EbxtHwc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pyGC3wWwYpeTwX1wpG/fpIN6DMYOL6kpV3zHPUD+oOcs3G5vrT2f6nWcy94OghXLb
         a9fvVUgEniVCZZoOokoczqryBpzs04TQvEs/8cDbyVwvk9IigihigedwjjHCw8FLPd
         8PkxljVEyEwFI6Ihcz4YmUVjFXSEZtlANPnZCSGQkzpU845LND6/k6Uucwn5hCxqdv
         OTHLvgzPli07wHWHHm3ZII1y/XYMXFg8Jq9NS3JDYGnm+GC0k9HciO9j7FFI+YOpJj
         Q2NFbCtHINEjEpEDxgG6F1+BJsGdhlTC2ACRv04x+LzyYNKA7gFnrlvxjVgaYAZWVK
         WemcKX7BcF6dQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:13 +0200
Subject: [PATCH 19/41] mtd: spi-nor: esmt: convert flash_info to new format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-19-3d3d5bef4ba4@kernel.org>
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
 drivers/mtd/spi-nor/esmt.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
index 12779bec5f99..089fcd1aa794 100644
--- a/drivers/mtd/spi-nor/esmt.c
+++ b/drivers/mtd/spi-nor/esmt.c
@@ -9,15 +9,25 @@
 #include "core.h"
 
 static const struct flash_info esmt_nor_parts[] = {
-	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "f25l32qa-2s", INFO(0x8c4116, 0, 64 * 1024, 64)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SECT_4K) },
+	{
+		.id = SNOR_ID(0x8c, 0x20, 0x16),
+		.name = "f25l32pa",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x8c, 0x41, 0x16),
+		.name = "f25l32qa-2s",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x8c, 0x41, 0x17),
+		.name = "f25l64qa",
+		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
+	}
 };
 
 const struct spi_nor_manufacturer spi_nor_esmt = {

-- 
2.39.2

