Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446D77985DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbjIHK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbjIHK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:29:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049B2112
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:28:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC93C43397;
        Fri,  8 Sep 2023 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168229;
        bh=Oyq3JU+jD6JnYKUuJ4JBwmfio4ODb3qr1zJ7EbxtHwc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rpsmNMcP4ySwZSfX81zAS+FKqk8XwpFfxfeHwmI9xvrKYLIzt2xfBiOZzFfTEBrpG
         YAhIlmO4EfBu0P/fJdaRDi+y8f8oJniZFWmr2raFgEuphUveUfzFoVPvhWGmk9bMAm
         +mo+Dxg6V7tnhjeWb+482DCavFmJsi9hFpw9TkB3/cpG+rdfkR2hnLjNMlF+rCURL8
         Jrb6wsZGr2c4CGKgpZryRzHdxfWYfYRnJwlgmE3tLe5HsVpRJG5nb3eM50uMMhP0Wg
         fJ+8FRJSyGZeBV81IQ5jBE3pHeVDYqgAn65Gkei9cH97Yp0gNRMjoIdFFHi50rlw+N
         Fr1P+wpliosiA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:37 +0200
Subject: [PATCH v3 19/41] mtd: spi-nor: esmt: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-19-e60548861b10@kernel.org>
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

