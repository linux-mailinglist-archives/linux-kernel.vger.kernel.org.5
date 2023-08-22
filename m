Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D232C783A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjHVHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjHVHLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356A10D5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 807BE62672
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA06C433C9;
        Tue, 22 Aug 2023 07:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688251;
        bh=okMtOA67tLTz4yJHrFPDvuTyPVGqwS1/Z6lXCh+PJbY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VKoLIhnJPhlGeq7O5f8UPN8I0wAFfIpdQPLkSDMXYuLnihDDpfmzZRbpnWBog24z3
         KQXav1i/FKv44yFJLWF8T7RLhuvuUK0vDJs7MzT/EkcCVfpqI473+Paw/6cHE4boyx
         KOHhguVfHpXG9cLQIaSIgG94bVsZ8ldP4zYVIEKt0CITkL0I0SVGsUOAcbAM8toYhr
         DAz2ug+dcaCU6v2VHWITwtXlgCgEyUWipBQ2XrlFQPzXWikl5qX7gELhbLP1HKIKKl
         OGSL/l+kRSmG83Cm1FuGm5NEVr2OMyYdNtnrkIz4SuAAyvhVJWIR7BJG19GntIElHA
         JX91GsFL058bw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:54 +0200
Subject: [PATCH v2 38/41] mtd: spi-nor: sst: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-38-291a0f39f8d8@kernel.org>
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

