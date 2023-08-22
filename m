Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA49783A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjHVHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjHVHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF13E6F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA3B62EEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BFEC433C8;
        Tue, 22 Aug 2023 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688230;
        bh=FnqvsVEt1dn/8eNY7lxm1PrsElAnzNiLYIyWKyfbLlM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AQXsXtIdoRlO6RP41uerEsp+RT8pjiEleA7EOBOXekY+xpg5Y3A5OGZ3mWTj//EcI
         E9YcdLHyLg6bmroV9IWnYtm60kORf5NkmE1ylpaYksr9PA7AGtHscY1weFgzmcWsXt
         3py7J1hhyKTeJBIPWh3mMbZ/8j4y64cTzZrrC9MxqPLNwtKb1oJYwTZ18HEh3vHsWK
         OphjKxlQgQcFHas1liaME8w0W6ImO7KN8QGmh21vBtYMJpWD2wNAEBz0QfQhwFTXZx
         fVmwMk3NSzimabUESkze7+lcL6FnIcKeArjLb6tcKl3SmRiwhjn2ZyFNauLn0i7jyf
         oQh6NmvMbiLGQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:43 +0200
Subject: [PATCH v2 27/41] mtd: spi-nor: sst: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-27-291a0f39f8d8@kernel.org>
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
 drivers/mtd/spi-nor/sst.c | 162 +++++++++++++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 58 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 1e06c6841a18..77b271abd342 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -61,64 +61,110 @@ static const struct spi_nor_fixups sst26vf_nor_fixups = {
 };
 
 static const struct flash_info sst_nor_parts[] = {
-	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP |
-		      SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8)
-		FLAGS(SPI_NOR_HAS_LOCK)
-		NO_SFDP_FLAGS(SECT_4K) },
-	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K)
-		MFR_FLAGS(SST_WRITE) },
-	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "sst26vf032b", INFO(0xbf2642, 0, 0, 0)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		.fixups = &sst26vf_nor_fixups },
-	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128)
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-		.fixups = &sst26vf_nor_fixups },
+	{
+		.id = SNOR_ID(0xbf, 0x25, 0x8d),
+		.name = "sst25vf040b",
+		.size = SZ_512K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x8e),
+		.name = "sst25vf080b",
+		.size = SZ_1M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x41),
+		.name = "sst25vf016b",
+		.size = SZ_2M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x4a),
+		.name = "sst25vf032b",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x4b),
+		.name = "sst25vf064c",
+		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x01),
+		.name = "sst25wf512",
+		.size = SZ_64K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x02),
+		.name = "sst25wf010",
+		.size = SZ_128K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x03),
+		.name = "sst25wf020",
+		.size = SZ_256K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0x62, 0x16, 0x12),
+		.name = "sst25wf020a",
+		.size = SZ_256K,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x62, 0x16, 0x13),
+		.name = "sst25wf040b",
+		.size = SZ_512K,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x04),
+		.name = "sst25wf040",
+		.size = SZ_512K,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x25, 0x05),
+		.name = "sst25wf080",
+		.size = SZ_1M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K,
+		.mfr_flags = SST_WRITE,
+	}, {
+		.id = SNOR_ID(0xbf, 0x26, 0x51),
+		.name = "sst26wf016b",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0xbf, 0x26, 0x41),
+		.name = "sst26vf016b",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ,
+	}, {
+		.id = SNOR_ID(0xbf, 0x26, 0x42),
+		.name = "sst26vf032b",
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.fixups = &sst26vf_nor_fixups,
+	}, {
+		.id = SNOR_ID(0xbf, 0x26, 0x43),
+		.name = "sst26vf064b",
+		.size = SZ_8M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixups = &sst26vf_nor_fixups,
+	}
 };
 
 static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,

-- 
2.39.2

