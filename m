Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC07FDD47
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjK2Qhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjK2Qhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:37:37 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4154D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4108C000C;
        Wed, 29 Nov 2023 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701275862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/YNgCWPKxHY49wBO0+94oHV863lvdF8QP5nwMeh4Ks=;
        b=Swke5rHgsw9rKPOlVP+ptkMkixWITnj2HDGZCjEC5/PJ0IolndzKGQiWwkuHoEx4KDbNDL
        VlzAsgWoxZMvvGR/H7RmJBoJhq+jxS70svG1+axlRz3WXbNZEwwiUa4PsxoEVTVBTV3EUl
        P6laxC9jKEy8Uh4NKf4XsQWYeFOEuIR2zye/MBALTgQLiVN5L0fuhzal4gn1QL6mHtAith
        wXdA6VNibGkVgMcmUKIvlJebJamwBdHsp3wSACOh3CGjxthrv0wyDuiwje2/4Dx7y7uH3B
        N6BTK0yoqcFDYupaVHm/wF/AQqZeIf2U5PfA4lFPlMiM4S35fW5BFrpYJxtuIg==
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
Subject: [PATCH v14 4/8] nvmem: Simplify the ->add_cells() hook
Date:   Wed, 29 Nov 2023 17:37:33 +0100
Message-Id: <20231129163737.698317-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The layout entry is not used and will anyway be made useless by the new
layout bus infrastructure coming next, so drop it. While at it, clarify
the kdoc entry.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c             | 2 +-
 drivers/nvmem/layouts/onie-tlv.c | 3 +--
 drivers/nvmem/layouts/sl28vpd.c  | 3 +--
 include/linux/nvmem-provider.h   | 8 +++-----
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5e5ce67398f..f63db5e01fca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -816,7 +816,7 @@ static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
 	int ret;
 
 	if (layout && layout->add_cells) {
-		ret = layout->add_cells(&nvmem->dev, nvmem, layout);
+		ret = layout->add_cells(&nvmem->dev, nvmem);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 59fc87ccfcff..defd42d4375c 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -182,8 +182,7 @@ static bool onie_tlv_crc_is_valid(struct device *dev, size_t table_len, u8 *tabl
 	return true;
 }
 
-static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem,
-				struct nvmem_layout *layout)
+static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem)
 {
 	struct onie_tlv_hdr hdr;
 	size_t table_len, data_len, hdr_len;
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 05671371f631..26c7cf21b523 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -80,8 +80,7 @@ static int sl28vpd_v1_check_crc(struct device *dev, struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem,
-			     struct nvmem_layout *layout)
+static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem)
 {
 	const struct nvmem_cell_info *pinfo;
 	struct nvmem_cell_info info = {0};
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e5de21516387..3939991b3c5f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -156,9 +156,8 @@ struct nvmem_cell_table {
  *
  * @name:		Layout name.
  * @of_match_table:	Open firmware match table.
- * @add_cells:		Will be called if a nvmem device is found which
- *			has this layout. The function will add layout
- *			specific cells with nvmem_add_one_cell().
+ * @add_cells:		Called to populate the layout using
+ *			nvmem_add_one_cell().
  * @fixup_cell_info:	Will be called before a cell is added. Can be
  *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
@@ -172,8 +171,7 @@ struct nvmem_cell_table {
 struct nvmem_layout {
 	const char *name;
 	const struct of_device_id *of_match_table;
-	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
-			 struct nvmem_layout *layout);
+	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem);
 	void (*fixup_cell_info)(struct nvmem_device *nvmem,
 				struct nvmem_layout *layout,
 				struct nvmem_cell_info *cell);
-- 
2.34.1

