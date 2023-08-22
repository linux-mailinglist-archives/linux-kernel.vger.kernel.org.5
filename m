Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0D783A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjHVHJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjHVHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F432130
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB8F63DA4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E254DC433CB;
        Tue, 22 Aug 2023 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688180;
        bh=c/YUDEImvGBPGu1w7v7S2H4wM+XOOkWFgbu7J+r0IB4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kxw4iepq2kMmcPeZL4bDGlKpzuL/qBwEJnOP6pmJ5Yo/8tXsD/kFIGeocLtUf7+Pj
         n7v1WxkmKkl0wa4pOqoHRJDPMpOR0z50wMhGUlZH2WkSiEghvhAYTerjwm4i7CSCn9
         iJifgt4A9WRPNTpnBLTxtuaCnuRriqrIUJvsTnPbE4e2pHNZSPqlsXr0AEhwBtQbnY
         WtkAp8+VGNnmYLhuNtqdkvBcxzC4gW1Hzoc1E+UIZlhVrnJx/azaz4md/VLkP9ca2z
         koksrBYaePQKo9c/Cw6iN3tMi32Le44MiJINSvIskLWHmLNzmWocL64vwskiQEK2cp
         NLgZAAXGJVT/A==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:18 +0200
Subject: [PATCH v2 02/41] mtd: spi-nor: remove Fujitsu MB85RS1MT support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-2-291a0f39f8d8@kernel.org>
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

This part is not a flash but an EEPROM like FRAM. It is even has a DT
binding for the (correct) driver (at25), see
Documentation/devicetree/bindings/eeprom/at25.yaml. Just remove it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/Makefile  |  1 -
 drivers/mtd/spi-nor/core.c    |  1 -
 drivers/mtd/spi-nor/core.h    |  1 -
 drivers/mtd/spi-nor/fujitsu.c | 21 ---------------------
 4 files changed, 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 496dae9ca0f3..5e68468b72fc 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -5,7 +5,6 @@ spi-nor-objs			+= atmel.o
 spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
-spi-nor-objs			+= fujitsu.o
 spi-nor-objs			+= gigadevice.o
 spi-nor-objs			+= intel.o
 spi-nor-objs			+= issi.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c44de69c4353..286155002cdc 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2002,7 +2002,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_eon,
 	&spi_nor_esmt,
 	&spi_nor_everspin,
-	&spi_nor_fujitsu,
 	&spi_nor_gigadevice,
 	&spi_nor_intel,
 	&spi_nor_issi,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6d31af6c39ed..dfc20a3296fb 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -634,7 +634,6 @@ extern const struct spi_nor_manufacturer spi_nor_atmel;
 extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
-extern const struct spi_nor_manufacturer spi_nor_fujitsu;
 extern const struct spi_nor_manufacturer spi_nor_gigadevice;
 extern const struct spi_nor_manufacturer spi_nor_intel;
 extern const struct spi_nor_manufacturer spi_nor_issi;
diff --git a/drivers/mtd/spi-nor/fujitsu.c b/drivers/mtd/spi-nor/fujitsu.c
deleted file mode 100644
index 69cffc5c73ef..000000000000
--- a/drivers/mtd/spi-nor/fujitsu.c
+++ /dev/null
@@ -1,21 +0,0 @@
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
-static const struct flash_info fujitsu_nor_parts[] = {
-	/* Fujitsu */
-	{ "mb85rs1mt", INFO(0x047f27, 0, 128 * 1024, 1)
-		FLAGS(SPI_NOR_NO_ERASE) },
-};
-
-const struct spi_nor_manufacturer spi_nor_fujitsu = {
-	.name = "fujitsu",
-	.parts = fujitsu_nor_parts,
-	.nparts = ARRAY_SIZE(fujitsu_nor_parts),
-};

-- 
2.39.2

