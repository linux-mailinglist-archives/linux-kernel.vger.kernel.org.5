Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC196798594
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjIHKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbjIHKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B281FFD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:16:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF34C433C7;
        Fri,  8 Sep 2023 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168216;
        bh=qecH0T0GVP4Tl7gmvt53qKilw5lpJzh7yyIFOhljF3s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DNMPDX0V0Vviw+yuXVEh1TDmHWqTsPxb0S4Jyh6k3stTMIp7kf35UVxcKyKiem1Vd
         cL/h85hGy60tM48R5YQRpzo7LS32MaPfUs/AZKEnTN24FY7fdL9W3/OuOE4XKjfmKk
         MhzBaBxu8HugOIoaCAAQUzLCJwfyavUK3tZ6AM1MBS30nM6nFeofTRNURwxvw08yIi
         6jnkfKpnJ9c7p7vX9r9kGlmKQB6W7iyBAgFHtGz57zGOLmD1OxxZ6LNFt2R+kpKC1z
         kkJLZ5dd0fw79YeuulbFp0olikGI8pknGJf2vS1DfR6AeKZ1APC0dYz3cbv/55ClIw
         cz50p2eXpE2+A==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:31 +0200
Subject: [PATCH v3 13/41] mtd: spi-nor: move the .id and .id_len into an
 own structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-13-e60548861b10@kernel.org>
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

Create a new structure to hold a flash ID and its length. The goal is to
have a new macro SNOR_ID() which can have a flexible id length. This way
we can get rid of all the individual INFOx() macros.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - fix parameter description
 - move leftover to correct patch
---
 drivers/mtd/spi-nor/core.c      |  6 +++---
 drivers/mtd/spi-nor/core.h      | 35 ++++++++++++++++++++++++++---------
 drivers/mtd/spi-nor/micron-st.c |  4 ++--
 drivers/mtd/spi-nor/spansion.c  |  4 ++--
 drivers/mtd/spi-nor/sysfs.c     |  6 +++---
 5 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4ba1778eda4b..80c340c7863a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2028,8 +2028,8 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
 		for (j = 0; j < manufacturers[i]->nparts; j++) {
 			part = &manufacturers[i]->parts[j];
-			if (part->id_len &&
-			    !memcmp(part->id, id, part->id_len)) {
+			if (part->id &&
+			    !memcmp(part->id->bytes, id, part->id->len)) {
 				nor->manufacturer = manufacturers[i];
 				return part;
 			}
@@ -3370,7 +3370,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	 * If caller has specified name of flash model that can normally be
 	 * detected using JEDEC, let's verify it.
 	 */
-	if (name && info->id_len) {
+	if (name && info->id) {
 		const struct flash_info *jinfo;
 
 		jinfo = spi_nor_detect(nor);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index b8226492bbd8..fc6c8ddedc2f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -446,12 +446,24 @@ struct spi_nor_fixups {
 	int (*late_init)(struct spi_nor *nor);
 };
 
+/**
+ * struct spi_nor_id - SPI NOR flash ID.
+ *
+ * @bytes: the bytes returned by the flash when issuing command 9F. Typically,
+ *         the first byte is the manufacturer ID code (see JEP106) and the next
+ *         two bytes are a flash part specific ID.
+ * @len:   the number of bytes of ID.
+ */
+struct spi_nor_id {
+	const u8 *bytes;
+	u8 len;
+};
+
 /**
  * struct flash_info - SPI NOR flash_info entry.
+ * @id:   pointer to struct spi_nor_id or NULL, which means "no ID" (mostly
+ *        older chips).
  * @name: the name of the flash.
- * @id:             the flash's ID bytes. The first three bytes are the
- *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly older chips).
- * @id_len:         the number of bytes of ID.
  * @size:           the size of the flash in bytes.
  * @sector_size:    (optional) the size listed here is what works with
  *                  SPINOR_OP_SE, which isn't necessarily called a "sector" by
@@ -510,8 +522,7 @@ struct spi_nor_fixups {
  */
 struct flash_info {
 	char *name;
-	u8 id[SPI_NOR_MAX_ID_LEN];
-	u8 id_len;
+	const struct spi_nor_id *id;
 	size_t size;
 	unsigned sector_size;
 	u16 page_size;
@@ -554,12 +565,18 @@ struct flash_info {
 #define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
 
 #define SPI_NOR_ID(_jedec_id, _ext_id)					\
-	.id = { SPI_NOR_ID_3ITEMS(_jedec_id), SPI_NOR_ID_2ITEMS(_ext_id) }, \
-	.id_len = !(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))
+	.id = &(const struct spi_nor_id){				\
+		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
+				       SPI_NOR_ID_2ITEMS(_ext_id) },	\
+		.len = !(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0)),	\
+	}
 
 #define SPI_NOR_ID6(_jedec_id, _ext_id)					\
-	.id = { SPI_NOR_ID_3ITEMS(_jedec_id), SPI_NOR_ID_3ITEMS(_ext_id) }, \
-	.id_len = 6
+	.id = &(const struct spi_nor_id){				\
+		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
+				       SPI_NOR_ID_3ITEMS(_ext_id) },	\
+		.len = 6,						\
+	}
 
 #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
 	.size = (_sector_size) * (_n_sectors),				\
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 5406a3af2ce0..229c951efcce 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -78,7 +78,7 @@ static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
 		return ret;
 	}
 
-	if (memcmp(buf, nor->info->id, nor->info->id_len))
+	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
 		return -EINVAL;
 
 	return 0;
@@ -114,7 +114,7 @@ static int micron_st_nor_octal_dtr_dis(struct spi_nor *nor)
 		return ret;
 	}
 
-	if (memcmp(buf, nor->info->id, nor->info->id_len))
+	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index e6468569f178..d7012ab3de2c 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -228,7 +228,7 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 		return ret;
 	}
 
-	if (memcmp(buf, nor->info->id, nor->info->id_len))
+	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
 		return -EINVAL;
 
 	return 0;
@@ -272,7 +272,7 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 		return ret;
 	}
 
-	if (memcmp(buf, nor->info->id, nor->info->id_len))
+	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index c09bb832b3b9..2dfdc555a69f 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -35,8 +35,8 @@ static ssize_t jedec_id_show(struct device *dev,
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_mem *spimem = spi_get_drvdata(spi);
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
-	const u8 *id = nor->info->id_len ? nor->info->id : nor->id;
-	u8 id_len = nor->info->id_len ?: SPI_NOR_MAX_ID_LEN;
+	const u8 *id = nor->info->id ? nor->info->id->bytes : nor->id;
+	u8 id_len = nor->info->id ? nor->info->id->len : SPI_NOR_MAX_ID_LEN;
 
 	return sysfs_emit(buf, "%*phN\n", id_len, id);
 }
@@ -78,7 +78,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
 		return 0;
-	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len && !nor->id)
+	if (attr == &dev_attr_jedec_id.attr && !nor->info->id && !nor->id)
 		return 0;
 
 	return 0444;

-- 
2.39.2

