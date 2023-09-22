Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D17AAF08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjIVKBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjIVKBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:01:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8630192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:01:29 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=localhost)
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1qjcyN-0002V0-3t; Fri, 22 Sep 2023 12:01:19 +0200
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>
Cc:     kernel@pengutronix.de,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: check nand support for cache reads
Date:   Fri, 22 Sep 2023 12:01:13 +0200
Message-ID: <20230922100116.145090-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the JEDEC and ONFI specification say that read cache sequential
support is an optional command. This means that we not only need to
check whether the individual controller implements the command, we also
need to check the parameter pages for both ONFI and JEDEC NAND flashes
before enabling sequential cache reads.

This fixes support for NAND flashes which don't support enabling cache
reads, i.e. Samsung K9F4G08U0F or Toshiba TC58NVG0S3HTA00.

Sequential cache reads are no only available for ONFI and JEDEC devices,
if individual vendors implement this, it needs to be enabled per vendor.

Tested on i.MX6Q with a Samsung NAND flash chip that doesn't support
sequential reads.

Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
@Martin, Måns:
I would appreciate if you could test this on your hardware.

@Miguel:
I didn't have the time to test this on ONFI/JEDEC devices with support
yet, I'd be fine if you hold off merging this.

 drivers/mtd/nand/raw/nand_base.c  | 3 +++
 drivers/mtd/nand/raw/nand_jedec.c | 3 +++
 drivers/mtd/nand/raw/nand_onfi.c  | 3 +++
 include/linux/mtd/jedec.h         | 3 +++
 include/linux/mtd/onfi.h          | 1 +
 include/linux/mtd/rawnand.h       | 1 +
 6 files changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d4b55155aeae..1fcac403cee6 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5110,6 +5110,9 @@ static void rawnand_check_cont_read_support(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
+	if (!chip->parameters.supports_read_cache)
+		return;
+
 	if (chip->read_retries)
 		return;
 
diff --git a/drivers/mtd/nand/raw/nand_jedec.c b/drivers/mtd/nand/raw/nand_jedec.c
index 836757717660..e6ecbc4b2493 100644
--- a/drivers/mtd/nand/raw/nand_jedec.c
+++ b/drivers/mtd/nand/raw/nand_jedec.c
@@ -94,6 +94,9 @@ int nand_jedec_detect(struct nand_chip *chip)
 		goto free_jedec_param_page;
 	}
 
+	if (p->opt_cmd[0] & JEDEC_OPT_CMD_READ_CACHE)
+		chip->parameters.supports_read_cache;
+
 	memorg->pagesize = le32_to_cpu(p->byte_per_page);
 	mtd->writesize = memorg->pagesize;
 
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
index f15ef90aec8c..bf79bf2b5866 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -303,6 +303,9 @@ int nand_onfi_detect(struct nand_chip *chip)
 			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
 	}
 
+	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_READ_CACHE)
+		chip->parameters.supports_read_cache;
+
 	onfi = kzalloc(sizeof(*onfi), GFP_KERNEL);
 	if (!onfi) {
 		ret = -ENOMEM;
diff --git a/include/linux/mtd/jedec.h b/include/linux/mtd/jedec.h
index 0b6b59f7cfbd..56047a4e54c9 100644
--- a/include/linux/mtd/jedec.h
+++ b/include/linux/mtd/jedec.h
@@ -21,6 +21,9 @@ struct jedec_ecc_info {
 /* JEDEC features */
 #define JEDEC_FEATURE_16_BIT_BUS	(1 << 0)
 
+/* JEDEC Optional Commands */
+#define JEDEC_OPT_CMD_READ_CACHE	BIT(1)
+
 struct nand_jedec_params {
 	/* rev info and features block */
 	/* 'J' 'E' 'S' 'D'  */
diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
index a7376f9beddf..55ab2e4d62f9 100644
--- a/include/linux/mtd/onfi.h
+++ b/include/linux/mtd/onfi.h
@@ -55,6 +55,7 @@
 #define ONFI_SUBFEATURE_PARAM_LEN	4
 
 /* ONFI optional commands SET/GET FEATURES supported? */
+#define ONFI_OPT_CMD_READ_CACHE		BIT(1)
 #define ONFI_OPT_CMD_SET_GET_FEATURES	BIT(2)
 
 struct nand_onfi_params {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 90a141ba2a5a..766856fcaba8 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -233,6 +233,7 @@ struct nand_parameters {
 	/* Generic parameters */
 	const char *model;
 	bool supports_set_get_features;
+	bool supports_read_cache;
 	DECLARE_BITMAP(set_feature_list, ONFI_FEATURE_NUMBER);
 	DECLARE_BITMAP(get_feature_list, ONFI_FEATURE_NUMBER);
 
-- 
2.42.0

