Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B67FDD49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjK2Qhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjK2Qhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:37:38 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E21D66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93395C000F;
        Wed, 29 Nov 2023 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701275863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0YsLzvbE9fekXIAP2xv8c6ISu9IRksqX2H+fVGPhYA=;
        b=jg4AMwhu8UsZFBS15P+yPubjAgX/mYadHelmx0N6dyMOqd1riEjD/xcgtJFDLhOmsw65Ly
        HMp4aiV6sucWhw1/5gcO7jEawTs6uKK2bNJanT2RhasmKlz43vwHC84BMn58l8VUHhUZxv
        dhb4Fl7/mRWVI7QZ4+ebozaEjeM8w32YDYdL6tcoZBgRHtWCNFfayPbaKs9VwhNUCMW3EO
        dEY+Tim2xf+gncNPMJHQAKt+KVkFaiVoSjxdk6UQVMwn9ieOyMhnVUuK+NfS6c8lTO5IuU
        hLc2L4mgx29aODMUFfvPdenmKIg7jz8Dq8dAlum1IW3SnTPAfmd6AY8/Mcgqkg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v14 5/8] nvmem: Move and rename ->fixup_cell_info()
Date:   Wed, 29 Nov 2023 17:37:34 +0100
Message-Id: <20231129163737.698317-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hook is meant to be used by any provider and instantiating a layout
just for this is useless. Let's instead move this hook to the nvmem
device and add it to the config structure to be easily shared by the
providers.

While at moving this hook, rename it ->fixup_dt_cell_info() to clarify
its main intended purpose.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           |  6 +++---
 drivers/nvmem/imx-ocotp.c      | 11 +++--------
 drivers/nvmem/internals.h      |  2 ++
 drivers/nvmem/mtk-efuse.c      | 11 +++--------
 include/linux/nvmem-provider.h |  9 ++++-----
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f63db5e01fca..a885713d6b4b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -675,7 +675,6 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 {
-	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
 	struct device_node *child;
 	const __be32 *addr;
@@ -705,8 +704,8 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 
 		info.np = of_node_get(child);
 
-		if (layout && layout->fixup_cell_info)
-			layout->fixup_cell_info(nvmem, layout, &info);
+		if (nvmem->fixup_dt_cell_info)
+			nvmem->fixup_dt_cell_info(nvmem, &info);
 
 		ret = nvmem_add_one_cell(nvmem, &info);
 		kfree(info.name);
@@ -895,6 +894,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
+	nvmem->fixup_dt_cell_info = config->fixup_dt_cell_info;
 
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index f1e202efaa49..79dd4fda0329 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -583,17 +583,12 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 
-static void imx_ocotp_fixup_cell_info(struct nvmem_device *nvmem,
-				      struct nvmem_layout *layout,
-				      struct nvmem_cell_info *cell)
+static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
+					 struct nvmem_cell_info *cell)
 {
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-static struct nvmem_layout imx_ocotp_layout = {
-	.fixup_cell_info = imx_ocotp_fixup_cell_info,
-};
-
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -619,7 +614,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
-	imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
+	imx_ocotp_nvmem_config.fixup_dt_cell_info = &imx_ocotp_fixup_dt_cell_info;
 
 	priv->config = &imx_ocotp_nvmem_config;
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index ce353831cd65..893553fbdf51 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -23,6 +23,8 @@ struct nvmem_device {
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
 	struct list_head	cells;
+	void (*fixup_dt_cell_info)(struct nvmem_device *nvmem,
+				   struct nvmem_cell_info *cell);
 	const struct nvmem_keepout *keepout;
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 87c94686cfd2..84f05b40a411 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -45,9 +45,8 @@ static int mtk_efuse_gpu_speedbin_pp(void *context, const char *id, int index,
 	return 0;
 }
 
-static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
-				      struct nvmem_layout *layout,
-				      struct nvmem_cell_info *cell)
+static void mtk_efuse_fixup_dt_cell_info(struct nvmem_device *nvmem,
+					 struct nvmem_cell_info *cell)
 {
 	size_t sz = strlen(cell->name);
 
@@ -61,10 +60,6 @@ static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
 		cell->read_post_process = mtk_efuse_gpu_speedbin_pp;
 }
 
-static struct nvmem_layout mtk_efuse_layout = {
-	.fixup_cell_info = mtk_efuse_fixup_cell_info,
-};
-
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -91,7 +86,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.priv = priv;
 	econfig.dev = dev;
 	if (pdata->uses_post_processing)
-		econfig.layout = &mtk_efuse_layout;
+		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3939991b3c5f..36415a602d9e 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -83,6 +83,8 @@ struct nvmem_cell_info {
  * @cells:	Optional array of pre-defined NVMEM cells.
  * @ncells:	Number of elements in cells.
  * @add_legacy_fixed_of_cells:	Read fixed NVMEM cells from old OF syntax.
+ * @fixup_dt_cell_info: Will be called before a cell is added. Can be
+ *		used to modify the nvmem_cell_info.
  * @keepout:	Optional array of keepout ranges (sorted ascending by start).
  * @nkeepout:	Number of elements in the keepout array.
  * @type:	Type of the nvmem storage
@@ -113,6 +115,8 @@ struct nvmem_config {
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
 	bool			add_legacy_fixed_of_cells;
+	void (*fixup_dt_cell_info)(struct nvmem_device *nvmem,
+				   struct nvmem_cell_info *cell);
 	const struct nvmem_keepout *keepout;
 	unsigned int		nkeepout;
 	enum nvmem_type		type;
@@ -158,8 +162,6 @@ struct nvmem_cell_table {
  * @of_match_table:	Open firmware match table.
  * @add_cells:		Called to populate the layout using
  *			nvmem_add_one_cell().
- * @fixup_cell_info:	Will be called before a cell is added. Can be
- *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
  * @node:		List node.
  *
@@ -172,9 +174,6 @@ struct nvmem_layout {
 	const char *name;
 	const struct of_device_id *of_match_table;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem);
-	void (*fixup_cell_info)(struct nvmem_device *nvmem,
-				struct nvmem_layout *layout,
-				struct nvmem_cell_info *cell);
 
 	/* private */
 	struct module *owner;
-- 
2.34.1

