Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6A772565
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjHGNWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjHGNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5ECF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D6B61ADA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CBAC433CB;
        Mon,  7 Aug 2023 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414516;
        bh=STumF2jMsmMQs/u4xKVFJG5rdn3FbACDuOxzTY6McdY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=A6jw1DWkL1XRwjkzsFQQed2z4amOdfyxiI6nE6Chb1jk8m9Wf0redWf6B8PRSwkH/
         njtC+XxwJUWgUSTFlkEs+JqbWTnQVEs3itCYvKrCw7Ue/Mi2YC+dwPpqyjT2Lp8BxE
         twCciWXrZKkQJiqC9R4sef/PSTMuNjl1aIG8s1DdtYI9sKXw4JNKSE3/c8amY3Ssy8
         meZeWmH6OY9yXU6wsQubc2svPlIo7VSK82h/3NffKrkUL4I2q3NQfVCwYh+5gcS4b4
         JpVivunn1tLR9jM6Qf8+YDbiD6FvAz4JFLjV5iLT22zVDR3TxulxXF/lyRddL6HVrE
         Jjsyz4c68cG6Q==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:20:56 +0200
Subject: [PATCH 02/41] mtd: spi-nor: remove Fujitsu MB85RS1MT support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-2-3d3d5bef4ba4@kernel.org>
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

This part is not a flash but an EEPROM like FRAM. It is even has a DT
binding for the (correct) driver (at25), see
Documentation/devicetree/bindings/eeprom/at25.yaml. Just remove it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c    |  1 -
 drivers/mtd/spi-nor/core.h    |  1 -
 drivers/mtd/spi-nor/fujitsu.c | 21 ---------------------
 3 files changed, 23 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8e43d171ffd0..a9ad55aab821 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2001,7 +2001,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
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

