Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB71783A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjHVHJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHVHJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72A130
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C9B649D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB24EC433C8;
        Tue, 22 Aug 2023 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688178;
        bh=BtFMSSMS+Ge1Ld7dIKb08UtH8RdD+UZ/1ZtM9xiCV4U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u0Ol46gEyBfiDsoZFjf0xjhLBjciINSBkapT8D+OLIMHq0jFpBUh/F3NdYHfjHCTq
         FYzFCw55NrCB7ZHgGqwiC6IXGzaFBqU8NgmeC2e8WnUUcKYyUUdnAv2rOOIl9xptLu
         NApEGphJdDxQMgyQl4OHCFZ6czMBW4F5Ey2fzmPWLXOA1SfW9VdlZPLrqXBaD10kAh
         TdyznxQuHDdT0dTvHxr+cpA75Gwyy+x6kNrBqRoTNpSxgkl89UC/cg5iPR7bIvSl1f
         Lk3KmfZer6CVsjOSliNtFU1HuVZSf3F6E/OGtaZG3Melp48px7UWABWxvw+I1M5en4
         d2XoZpSxbQBGw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:17 +0200
Subject: [PATCH v2 01/41] mtd: spi-nor: remove catalyst 'flashes'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-1-291a0f39f8d8@kernel.org>
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

CAT25xx are actually EEPROMs manufactured by Catalyst. The devices are
ancient (DS are from 1998), there are not in-tree users, nor are there
any device tree bindings. Remove it. The correct driver is the at25.

Signed-off-by: Michael Walle <mwalle@kernel.org>
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

