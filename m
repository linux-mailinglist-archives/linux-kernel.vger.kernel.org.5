Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2688D7985A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbjIHKTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242960AbjIHKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:19:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF532211C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:18:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91533C433BC;
        Fri,  8 Sep 2023 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168276;
        bh=kj7txFDeJ9tQUukL/6r4EPSor7IpRSkzP9xAZaIzGSA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Gmz7kJaQaG65Nu6TVzNsQigFCAr+XToCFvGJ4PAHYOpq5FmmR/+1rdVKI6u8ttRN5
         b7rw/DW+fB7eQqgREacABggQwzklzMtehumbmdVkt2myB3eRG7MKH7jChSZUSEWsVh
         BReV3Xt6kz5kDmLlwmkKsJ3eXp7G+HslhPKKW4aoJ5MVQJoqdCpx01QiLZeP5YdMwb
         SrrKGMwCT9TdW7Cc031f+kp78B77zMJD0xtQQN+DI8dt0RFZBWjlZaMZxlwDVY2246
         gJ28mmdtQnUR+LGyfjBktNAv7mENTwKxUZvaBV+wySsDL0sEfTir47Dt7XhYrMXJPE
         Hdh1T0wtS3dGg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:59 +0200
Subject: [PATCH v3 41/41] mtd: spi-nor: core: get rid of the INFOx() macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-41-e60548861b10@kernel.org>
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

Now that all flash_info tables are converted to the new format, remove
the old INFOx() macros.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.h | 65 ----------------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 14c1aa63bc51..93cd2fc3606d 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -575,71 +575,6 @@ struct flash_info {
 		.n_regions = (_n_regions),				\
 	})
 
-#define SPI_NOR_ID_2ITEMS(_id) ((_id) >> 8) & 0xff, (_id) & 0xff
-#define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
-
-#define SPI_NOR_ID(_jedec_id, _ext_id)					\
-	.id = &(const struct spi_nor_id){				\
-		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
-				       SPI_NOR_ID_2ITEMS(_ext_id) },	\
-		.len = !(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0)),	\
-	}
-
-#define SPI_NOR_ID6(_jedec_id, _ext_id)					\
-	.id = &(const struct spi_nor_id){				\
-		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
-				       SPI_NOR_ID_3ITEMS(_ext_id) },	\
-		.len = 6,						\
-	}
-
-#define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
-	.size = (_sector_size) * (_n_sectors),				\
-	.sector_size = (_sector_size == SZ_64K) ? 0 : (_sector_size),	\
-	.n_banks = (_n_banks)
-
-/* Used when the "_ext_id" is two bytes at most */
-#define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
-	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
-	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
-
-#define INFO0(_sector_size, _n_sectors)					\
-	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
-
-#define INFOB(_jedec_id, _ext_id, _sector_size, _n_sectors, _n_banks)	\
-	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
-	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), (_n_banks)),
-
-#define INFO6(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
-	SPI_NOR_ID6((_jedec_id), (_ext_id)),				\
-	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
-
-#define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
-		.size = (_sector_size) * (_n_sectors),			\
-		.sector_size = (_sector_size),				\
-		.page_size = (_page_size),				\
-		.addr_nbytes = (_addr_nbytes),				\
-		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
-
-#define OTP_INFO(_len, _n_regions, _base, _offset)			\
-		.otp = &(const struct spi_nor_otp_organization){	\
-			.len = (_len),					\
-			.base = (_base),				\
-			.offset = (_offset),				\
-			.n_regions = (_n_regions),			\
-		},
-
-#define FLAGS(_flags)							\
-		.flags = (_flags),					\
-
-#define NO_SFDP_FLAGS(_no_sfdp_flags)					\
-		.no_sfdp_flags = (_no_sfdp_flags),			\
-
-#define FIXUP_FLAGS(_fixup_flags)					\
-		.fixup_flags = (_fixup_flags),				\
-
-#define MFR_FLAGS(_mfr_flags)						\
-		.mfr_flags = (_mfr_flags),				\
-
 /**
  * struct spi_nor_manufacturer - SPI NOR manufacturer object
  * @name: manufacturer name

-- 
2.39.2

