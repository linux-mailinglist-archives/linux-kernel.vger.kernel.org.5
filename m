Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4907985A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjIHKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbjIHKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F582109
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2458AC4166B;
        Fri,  8 Sep 2023 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168269;
        bh=okMtOA67tLTz4yJHrFPDvuTyPVGqwS1/Z6lXCh+PJbY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Y6vIEsB877qKoLMqFMf3EIrZW4ZTufgV4mxKHBymDY0AstBFQzh/ZRupQrNroOOG0
         38ZUKMVKli8eGeos8n2GLh3Dz0AxoVTv7Jkg9KJtkXBmvNBW6t3lwNWUJCGhtkMHje
         XbxoqDn7+Xa0Abw4hnL54QKzTccxueHOtYer6I7+BetNpf2+rfD1+iMJ0NnuIi8sb/
         7nnG1b9kxfYe4P9ejsImWIFk6Uz7/87qdPMpbnrf100ZaumtzgJkqfgjXQQs/Hord6
         aTfgmWHD0epYkyJ8Q3XUqjVLiTfJ0eaVHfwPfvRYnuchPWiRmVhT3D5e2nZhZphHr2
         vwTcP3RWmx3tA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:56 +0200
Subject: [PATCH v3 38/41] mtd: spi-nor: sst: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-38-e60548861b10@kernel.org>
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

The flash ID is the new primary key into our database. Sort the entry by
it. Keep the most specific ones first, because there might be ID
collisions between shorter and longer ones.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/sst.c | 90 +++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 77b271abd342..44d2a546bf17 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -62,38 +62,16 @@ static const struct spi_nor_fixups sst26vf_nor_fixups = {
 
 static const struct flash_info sst_nor_parts[] = {
 	{
-		.id = SNOR_ID(0xbf, 0x25, 0x8d),
-		.name = "sst25vf040b",
-		.size = SZ_512K,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
-		.no_sfdp_flags = SECT_4K,
-		.mfr_flags = SST_WRITE,
-	}, {
-		.id = SNOR_ID(0xbf, 0x25, 0x8e),
-		.name = "sst25vf080b",
-		.size = SZ_1M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
-		.no_sfdp_flags = SECT_4K,
-		.mfr_flags = SST_WRITE,
-	}, {
-		.id = SNOR_ID(0xbf, 0x25, 0x41),
-		.name = "sst25vf016b",
-		.size = SZ_2M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
-		.no_sfdp_flags = SECT_4K,
-		.mfr_flags = SST_WRITE,
-	}, {
-		.id = SNOR_ID(0xbf, 0x25, 0x4a),
-		.name = "sst25vf032b",
-		.size = SZ_4M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.id = SNOR_ID(0x62, 0x16, 0x12),
+		.name = "sst25wf020a",
+		.size = SZ_256K,
+		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SECT_4K,
-		.mfr_flags = SST_WRITE,
 	}, {
-		.id = SNOR_ID(0xbf, 0x25, 0x4b),
-		.name = "sst25vf064c",
-		.size = SZ_8M,
-		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP | SPI_NOR_SWP_IS_VOLATILE,
+		.id = SNOR_ID(0x62, 0x16, 0x13),
+		.name = "sst25wf040b",
+		.size = SZ_512K,
+		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0xbf, 0x25, 0x01),
@@ -116,18 +94,6 @@ static const struct flash_info sst_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.mfr_flags = SST_WRITE,
-	}, {
-		.id = SNOR_ID(0x62, 0x16, 0x12),
-		.name = "sst25wf020a",
-		.size = SZ_256K,
-		.flags = SPI_NOR_HAS_LOCK,
-		.no_sfdp_flags = SECT_4K,
-	}, {
-		.id = SNOR_ID(0x62, 0x16, 0x13),
-		.name = "sst25wf040b",
-		.size = SZ_512K,
-		.flags = SPI_NOR_HAS_LOCK,
-		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0xbf, 0x25, 0x04),
 		.name = "sst25wf040",
@@ -143,10 +109,39 @@ static const struct flash_info sst_nor_parts[] = {
 		.no_sfdp_flags = SECT_4K,
 		.mfr_flags = SST_WRITE,
 	}, {
-		.id = SNOR_ID(0xbf, 0x26, 0x51),
-		.name = "sst26wf016b",
+		.id = SNOR_ID(0xbf, 0x25, 0x41),
+		.name = "sst25vf016b",
 		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
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
 	}, {
 		.id = SNOR_ID(0xbf, 0x26, 0x41),
 		.name = "sst26vf016b",
@@ -164,6 +159,11 @@ static const struct flash_info sst_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixups = &sst26vf_nor_fixups,
+	}, {
+		.id = SNOR_ID(0xbf, 0x26, 0x51),
+		.name = "sst26wf016b",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}
 };
 

-- 
2.39.2

