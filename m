Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71711772571
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjHGNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjHGNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8CB1993
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C446561AFD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818A0C433B7;
        Mon,  7 Aug 2023 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414540;
        bh=OYqXpiJfD7CKOYsMEMU35VDN0K2sBcJl5m0KTqbgYPU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LYk7Lff110rJSCILP0lNlbGpJrrElUprFw8OGJ11c2CQWSYeg38erO9cWZ9B8b0Yf
         Dsz40bx+wf9K511K/JRex461RO0F82ceeqRc/ju9kY14DfwzT60kd/XxJ1Jx8Xsb4f
         sI8lLnl1esYjpOBdVfTBL8EYV+ZkvHxuLKGXiHqhbyWucLHFKEgCmqCIo4EGriJqgU
         XpgSsv1uaQ5ERAYjsYnJyPcz39Y0O4tJgeEBEklqRlO700i10POAvkCX9+Ez+xNe/Y
         xH8SQnTMu7yUNFhUrYCJlrmQ41q1WC+1N9hl4dnQTSNhzBrvCQu5FRQPi6wYs9R9JJ
         ROYLfAcFFsqog==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:07 +0200
Subject: [PATCH 13/41] mtd: spi-nor: move the .id and .id_len into an own
 structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-13-3d3d5bef4ba4@kernel.org>
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

Create a new structure to hold a flash ID and its length. The goal is to
have a new macro SNOR_ID() which can have a flexible id length. This way
we can get rid of all the individual INFOx() macros.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c      |  6 +++---
 drivers/mtd/spi-nor/core.h      | 33 ++++++++++++++++++++++++---------
 drivers/mtd/spi-nor/micron-st.c |  4 ++--
 drivers/mtd/spi-nor/spansion.c  |  4 ++--
 drivers/mtd/spi-nor/sysfs.c     |  6 +++---
 drivers/mtd/spi-nor/winbond.c   |  1 -
 6 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 41612b9f1098..1319fcb97e16 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2027,8 +2027,8 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
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
@@ -3369,7 +3369,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	 * If caller has specified name of flash model that can normally be
 	 * detected using JEDEC, let's verify it.
 	 */
-	if (name && info->id_len) {
+	if (name && info->id) {
 		const struct flash_info *jinfo;
 
 		jinfo = spi_nor_detect(nor);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index eec14733c233..57272bb51eff 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -446,12 +446,22 @@ struct spi_nor_fixups {
 	int (*late_init)(struct spi_nor *nor);
 };
 
+/**
+ * struct spi_nor_id - SPI NOR flash ID.
+ *
+ * @bytes: the flash's ID bytes. The first three bytes are the JEDIC ID.
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
@@ -510,8 +520,7 @@ struct spi_nor_fixups {
  */
 struct flash_info {
 	char *name;
-	u8 id[SPI_NOR_MAX_ID_LEN];
-	u8 id_len;
+	const struct spi_nor_id *id;
 	size_t size;
 	unsigned sector_size;
 	u16 page_size;
@@ -554,12 +563,18 @@ struct flash_info {
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
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index c21fed842762..7873cc394f07 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -121,7 +121,6 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q128", INFO(0xef4018, 0, 0, 0)
-		PARSE_SFDP
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)

-- 
2.39.2

