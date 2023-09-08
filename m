Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A855B798599
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbjIHKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjIHKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:17:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC884213E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:17:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB932C433C8;
        Fri,  8 Sep 2023 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168231;
        bh=1nkVQlo/pntUPcuI8tZ3St9xyXgZLdanptrUEPEewkQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JCO3juMKBKUHreqa3eAsFhZSIp8EJtJQpDyoZHrs8QtrcMXaZPJ09k8HrNIhKTYII
         1a9jbmadN0qCrcBsA9t4rH3NXE/1oVUlMAVqgKkIN0j/VxGvFc0XE8OLcXjGuvx1D/
         4k0fVQ1sRKYYbMFRzs4/VSsBqugKutx1rGtMoD/zZ4eP4JXvupTTCp9+9PiKd5MWAr
         Iw6rawcMGddXHenu046HpSSWsczv2sV5Jz+P9sO1xTh3kp4e2VkPuGNcMlfA4kXWEi
         kblFuL34U33tWIpxLbWq9zUq7IGFHrU+V2M806d9FT5kpzJlH6ohNE5d0fVr320cjP
         vxJ9Vx2emWHRA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:38 +0200
Subject: [PATCH v3 20/41] mtd: spi-nor: everspin: convert flash_info to new
 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-20-e60548861b10@kernel.org>
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
 drivers/mtd/spi-nor/everspin.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index d02c32f2f7ad..46776bc10b27 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -9,10 +9,35 @@
 #include "core.h"
 
 static const struct flash_info everspin_nor_parts[] = {
-	{ "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
-	{ "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
-	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
-	{ "mr25h40",  CAT25_INFO(512 * 1024, 1, 256, 3) },
+	{
+		.name = "mr25h128",
+		.size = SZ_16K,
+		.sector_size = SZ_16K,
+		.page_size = 256,
+		.addr_nbytes = 2,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.name = "mr25h256",
+		.size = SZ_32K,
+		.sector_size = SZ_32K,
+		.page_size = 256,
+		.addr_nbytes = 2,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.name = "mr25h10",
+		.size = SZ_128K,
+		.sector_size = SZ_128K,
+		.page_size = 256,
+		.addr_nbytes = 3,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.name = "mr25h40",
+		.size = SZ_512K,
+		.sector_size = SZ_512K,
+		.page_size = 256,
+		.addr_nbytes = 3,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}
 };
 
 const struct spi_nor_manufacturer spi_nor_everspin = {

-- 
2.39.2

