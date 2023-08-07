Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAEE772572
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjHGNXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjHGNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B2211F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7FD661AB6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B9EC433BC;
        Mon,  7 Aug 2023 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414538;
        bh=oe7aMV5rIYZGzkefnYjB3oJt+ZI8q8he9pIR1JwkW+w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Zbd+HJ1L+eHI30TFQRB8B6NnhcBAKMJHoaYjc4FGlC9ozLo3u7ofyypq1IpUMdGXb
         dZmH35mgts3sOgWrJMcuTkbTG5ZIOkBDNfl3YcPMRRJhwmn5GLUL1TF+lRTPbWX7TS
         LG3bX/SXZQbAnCkNQDJO6ecJDaKQca1EjFVWnhCgTrjn3K0JUHGb54Nx4t5+GUoGzj
         HvpinalJ32epIs8E3qNGO4DbUYcbrcZoYvIjiVbck/gEmO5i6in8GJ0kXlriYd1K/J
         2hf/Io2lVGbe47LzllkK3pZ4xY936Wgq7XUgCgaVu96t2okbRG3XqKEdYnjx8WzEF9
         bFPO4EqmZDJ2A==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:06 +0200
Subject: [PATCH 12/41] mtd: spi-nor: introduce (temporary) INFO0()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-12-3d3d5bef4ba4@kernel.org>
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

The id will be converted to an own structure. To differentiate between
flashes with and without IDs, introduce a temporary macro INFO0() and
convert all flashes with no ID to use it. After the flash_info
conversion, that macro will be removed along with all the other INFOx()
macros.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.h      |  3 +++
 drivers/mtd/spi-nor/issi.c      |  4 ++--
 drivers/mtd/spi-nor/micron-st.c | 18 +++++++++---------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d9bf7a24ae1f..eec14733c233 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -571,6 +571,9 @@ struct flash_info {
 	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
 	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
 
+#define INFO0(_sector_size, _n_sectors)					\
+	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
+
 #define INFOB(_jedec_id, _ext_id, _sector_size, _n_sectors, _n_banks)	\
 	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
 	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), (_n_banks)),
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 9d22b799ce94..b936a28a85df 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -77,11 +77,11 @@ static const struct flash_info issi_nor_parts[] = {
 		.fixups = &is25lp256_fixups },
 
 	/* PMC */
-	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)
+	{ "pm25lv512",   INFO0(32 * 1024,    2)
 		NO_SFDP_FLAGS(SECT_4K)
 		.fixups = &pm25lv_nor_fixups
 	},
-	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4)
+	{ "pm25lv010",   INFO0(32 * 1024,    4)
 		NO_SFDP_FLAGS(SECT_4K)
 		.fixups = &pm25lv_nor_fixups
 	},
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6ad080c52ab5..5406a3af2ce0 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -272,15 +272,15 @@ static const struct flash_info st_nor_parts[] = {
 	{ "m25p64",  INFO(0x202017,  0,  64 * 1024, 128) },
 	{ "m25p128", INFO(0x202018,  0, 256 * 1024,  64) },
 
-	{ "m25p05-nonjedec",  INFO(0, 0,  32 * 1024,   2) },
-	{ "m25p10-nonjedec",  INFO(0, 0,  32 * 1024,   4) },
-	{ "m25p20-nonjedec",  INFO(0, 0,  64 * 1024,   4) },
-	{ "m25p40-nonjedec",  INFO(0, 0,  64 * 1024,   8) },
-	{ "m25p80-nonjedec",  INFO(0, 0,  64 * 1024,  16) },
-	{ "m25p16-nonjedec",  INFO(0, 0,  64 * 1024,  32) },
-	{ "m25p32-nonjedec",  INFO(0, 0,  64 * 1024,  64) },
-	{ "m25p64-nonjedec",  INFO(0, 0,  64 * 1024, 128) },
-	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64) },
+	{ "m25p05-nonjedec",  INFO0( 32 * 1024,   2) },
+	{ "m25p10-nonjedec",  INFO0( 32 * 1024,   4) },
+	{ "m25p20-nonjedec",  INFO0( 64 * 1024,   4) },
+	{ "m25p40-nonjedec",  INFO0( 64 * 1024,   8) },
+	{ "m25p80-nonjedec",  INFO0( 64 * 1024,  16) },
+	{ "m25p16-nonjedec",  INFO0( 64 * 1024,  32) },
+	{ "m25p32-nonjedec",  INFO0( 64 * 1024,  64) },
+	{ "m25p64-nonjedec",  INFO0( 64 * 1024, 128) },
+	{ "m25p128-nonjedec", INFO0(256 * 1024,  64) },
 
 	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2) },
 	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16) },

-- 
2.39.2

