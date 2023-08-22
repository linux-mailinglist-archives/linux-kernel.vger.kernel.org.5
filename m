Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AA783A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjHVHMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjHVHLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5024E74
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E2764D5F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DCC433C7;
        Tue, 22 Aug 2023 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688244;
        bh=v3ofMUp8UBxPgYd5XD7XRHJNeXUWfMpXY/dIXqoAhK8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SaBpjt6h6+n3fiJPsFNOmARNmuwiDNGGpy+cJJvo7J+13rOYYAm+eJOrmtHlHuKM2
         HfGxZX7lPtX3ihxgp6aIjTsfJY2IQ83/g19mHBZ+wCSAwKVf8OxdW/ORMDeDllaS5g
         3AVhGkwKiMN/ok0pXBDBqWOylpVfb0/jZNZMOVFOTlv929UWO8/3EPznG76rdLLvhh
         ieqqTye7pAQnkRawCbbYt2GCiDE09mzJiZbwl0k4IPJW5ZhkIw648WsYWkZ+p61re/
         qhW+15lCqr1FBZiO29Md1Nqb5ie7yjA+ZSGdzhO882QKqtzQmLJ+8E8huscNv7bex6
         t1vwmfVu5l3EQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:50 +0200
Subject: [PATCH v2 34/41] mtd: spi-nor: issi: sort flash_info database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-34-291a0f39f8d8@kernel.org>
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
 drivers/mtd/spi-nor/issi.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 9478f1e61626..18d9a00aa22e 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -48,26 +48,43 @@ static const struct spi_nor_fixups pm25lv_nor_fixups = {
 
 static const struct flash_info issi_nor_parts[] = {
 	{
+		.name = "pm25lv512",
+		.sector_size = SZ_32K,
+		.size = SZ_64K,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &pm25lv_nor_fixups
+	}, {
+		.name = "pm25lv010",
+		.sector_size = SZ_32K,
+		.size = SZ_128K,
+		.no_sfdp_flags = SECT_4K,
+		.fixups = &pm25lv_nor_fixups
+	}, {
 		.id = SNOR_ID(0x7f, 0x9d, 0x20),
 		.name = "is25cd512",
 		.sector_size = SZ_32K,
 		.size = SZ_64K,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x7f, 0x9d, 0x46),
+		.name = "pm25lq032",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K,
 	}, {
 		.id = SNOR_ID(0x9d, 0x40, 0x13),
 		.name = "is25lq040b",
 		.size = SZ_512K,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	}, {
-		.id = SNOR_ID(0x9d, 0x60, 0x15),
-		.name = "is25lp016d",
-		.size = SZ_2M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0x9d, 0x60, 0x14),
 		.name = "is25lp080d",
 		.size = SZ_1M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x15),
+		.name = "is25lp016d",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}, {
 		.id = SNOR_ID(0x9d, 0x60, 0x16),
 		.name = "is25lp032",
@@ -109,23 +126,6 @@ static const struct flash_info issi_nor_parts[] = {
 		.flags = SPI_NOR_QUAD_PP,
 		.fixups = &is25lp256_fixups,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
-	}, {
-		.name = "pm25lv512",
-		.sector_size = SZ_32K,
-		.size = SZ_64K,
-		.no_sfdp_flags = SECT_4K,
-		.fixups = &pm25lv_nor_fixups
-	}, {
-		.name = "pm25lv010",
-		.sector_size = SZ_32K,
-		.size = SZ_128K,
-		.no_sfdp_flags = SECT_4K,
-		.fixups = &pm25lv_nor_fixups
-	}, {
-		.id = SNOR_ID(0x7f, 0x9d, 0x46),
-		.name = "pm25lq032",
-		.size = SZ_4M,
-		.no_sfdp_flags = SECT_4K,
 	}
 };
 

-- 
2.39.2

