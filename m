Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3179858C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjIHKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjIHKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:16:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D981BC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:16:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC98C433CB;
        Fri,  8 Sep 2023 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168190;
        bh=2WkrOnHvWlXDPA215PL8w6ZJpKmJU2RCQJ+cnSW9WS8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=W6+hRF+gmLirffpZE2RAPsWo8cvz56NBQO+mBhEUl6b+9m2yhivF74aUj5Xzrt03b
         SVsRHwlv+nkBEtzCOVBsYOLtlsOHYqysexLPehJMBGXXbzRdLk89WOZVS1AkwyXhNQ
         MEhnEuEuhzDAkcIrx2Qirz/q1tcTwbCQCNPHUZYMh1n1txbs6KEnGCSdijilBdG7Mm
         VdqL8TFo+PJWyp5Ac4N1u+PyXysvoIttAilq1zl1SuEJWQB6Yi25KzmHblBIFL+Ji0
         bE2cGwizw0y2pOlUS4ySUV4p5OyclDmRMk4b/vmcQoK4wmgChe/IikfVXSBI75LpXW
         4fJ/KLCz1g2Kg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:19 +0200
Subject: [PATCH v3 01/41] mtd: spi-nor: remove catalyst 'flashes'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-1-e60548861b10@kernel.org>
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

CAT25xx are actually EEPROMs manufactured by Catalyst. The devices are
ancient (DS are from 1998), there are not in-tree users, nor are there
any device tree bindings. Remove it. The correct driver is the at25.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/Makefile   |  1 -
 drivers/mtd/spi-nor/catalyst.c | 24 ------------------------
 drivers/mtd/spi-nor/core.c     |  1 -
 drivers/mtd/spi-nor/core.h     |  1 -
 4 files changed, 27 deletions(-)

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index e347b435a038..496dae9ca0f3 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -2,7 +2,6 @@
 
 spi-nor-objs			:= core.o sfdp.o swp.o otp.o sysfs.o
 spi-nor-objs			+= atmel.o
-spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
diff --git a/drivers/mtd/spi-nor/catalyst.c b/drivers/mtd/spi-nor/catalyst.c
deleted file mode 100644
index 6d310815fb12..000000000000
--- a/drivers/mtd/spi-nor/catalyst.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2005, Intec Automation Inc.
- * Copyright (C) 2014, Freescale Semiconductor, Inc.
- */
-
-#include <linux/mtd/spi-nor.h>
-
-#include "core.h"
-
-static const struct flash_info catalyst_nor_parts[] = {
-	/* Catalyst / On Semiconductor -- non-JEDEC */
-	{ "cat25c11", CAT25_INFO(16, 8, 16, 1) },
-	{ "cat25c03", CAT25_INFO(32, 8, 16, 2) },
-	{ "cat25c09", CAT25_INFO(128, 8, 32, 2) },
-	{ "cat25c17", CAT25_INFO(256, 8, 32, 2) },
-	{ "cat25128", CAT25_INFO(2048, 8, 64, 2) },
-};
-
-const struct spi_nor_manufacturer spi_nor_catalyst = {
-	.name = "catalyst",
-	.parts = catalyst_nor_parts,
-	.nparts = ARRAY_SIZE(catalyst_nor_parts),
-};
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..c44de69c4353 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1999,7 +1999,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 
 static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_atmel,
-	&spi_nor_catalyst,
 	&spi_nor_eon,
 	&spi_nor_esmt,
 	&spi_nor_everspin,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 9217379b9cfe..6d31af6c39ed 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -631,7 +631,6 @@ struct sfdp {
 
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
-extern const struct spi_nor_manufacturer spi_nor_catalyst;
 extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;

-- 
2.39.2

