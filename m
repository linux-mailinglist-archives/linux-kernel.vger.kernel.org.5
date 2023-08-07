Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B55772585
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjHGNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHGNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE782109
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C254861B14
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854F2C433CB;
        Mon,  7 Aug 2023 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414559;
        bh=pG2FdGd2bZ50xpBr1ZIaO+fF4bmW9tYC4LsRjQC4xQA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oU+DQXxD2tL6/hASsZsagEicjZ1QH7W4ZB4wwT6CfjqRpOixKepcpv3d/lB2A3RcJ
         gTEeIqfd9IZqK1y1v2EgvQ1/qNY6ZBKZlGXsX5+bpNvvhzgR+p9Uc2El/lYApVrBbX
         5yQ2bTvbvfK4Q4M24WDIuQ3a3VSpchsNvctQGaKlYDjZleYllxbO0a3mY98QlPz54y
         LbcbKZstMh9wHaPDcjRbEyFBLf8krEvdPVnDmH+E82OV/inrtHMXQ6T+zeExMZdhAa
         hxHFlVGez5BQfE88dIFquSGFjmSi/IXs9aVji76gO9JkNmQyG3ITNkdTUB2a6Nmmzz
         DmuhBbN6ZArfw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:16 +0200
Subject: [PATCH 22/41] mtd: spi-nor: intel: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-22-3d3d5bef4ba4@kernel.org>
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

