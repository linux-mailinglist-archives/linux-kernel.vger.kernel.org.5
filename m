Return-Path: <linux-kernel+bounces-63421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94817852F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C124B24945
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A13838B;
	Tue, 13 Feb 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8iiNON/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B63D0CF;
	Tue, 13 Feb 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823271; cv=none; b=uO0ieIpvjUeVlRztqVuSPIAhd/0XQ+l0NfLPHeMN6kYyHnwcHB0VdeWbpkxwMz2HKcsbeyQVyV1RnAZP8GRvuLKtSXG3bT3apcfSETLPLDGTeOv1eRrz4NP78xUVEvLfAxX18nFLo7t+0/rSocsgxk5qW4OzGEkVxHl9EH4yHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823271; c=relaxed/simple;
	bh=apWDkq5UWa2/rq4RKT0gRUNLpFJ/ic8YN3fzb53M4BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRtua3p6RWov8Yo8O3Y7kqyyis4ZhRrtQiRfnY2EKg36O8yvd3LYMJtpkS+kPGgcUs7q1ZW1MWmrojmASHdkuaDxdtY/YrImMdDf1wanubAG7aAlPK2Q1StSOw54tZcp8x3dCcunqyf8A93moaKL2kijEN/rMuzV6edQG9/ZqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8iiNON/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBECC43394;
	Tue, 13 Feb 2024 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823270;
	bh=apWDkq5UWa2/rq4RKT0gRUNLpFJ/ic8YN3fzb53M4BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8iiNON/PKYoaHOEgU0RAZy1iXMcgF4jia66l7NOm67Zz1NBwkdb34ScYMuomOWfZ
	 EBxxmQWN1MyzdbKHuioyP4ZPrGvxBxIifT6H2Rj4egqx6QblDvEugDN+Vaj+oAU1DE
	 j/uecMiSxK/VuVvABh++9pL5motJWETIXyq4ssD63snz7Sz26gOHWLmSljQqwgGbZm
	 aDghLzUfVw4b1djxA8Ngp6nAgpr1veS1PAW3y/Xulhka6dGt6Gbfjoaee8pI3ldTmc
	 4V8BXiBL3mLdAG3t3u6zXt3xnk6AUbPueMjrF5KumxT1wczgabKUDcBJHsKia7p8A9
	 PiemlODuTaRkA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Jan Luebbe <jlu@pengutronix.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-edac@vger.kernel.org
Subject: [PATCH 4/7] EDAC: Remove dynamic attributes from edac_device_alloc_ctl_info()
Date: Tue, 13 Feb 2024 12:20:48 +0100
Message-ID: <20240213112051.27715-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic attributes are not passed from any caller of
edac_device_alloc_ctl_info(). Drop this unused/untested functionality
completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Jan Luebbe <jlu@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Khuong Dinh <khuong@os.amperecomputing.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/altera_edac.c      |  8 ++----
 drivers/edac/amd8111_edac.c     |  3 +-
 drivers/edac/armada_xp_edac.c   |  2 +-
 drivers/edac/cpc925_edac.c      |  2 +-
 drivers/edac/edac_device.c      | 50 ++-------------------------------
 drivers/edac/edac_device.h      |  4 ---
 drivers/edac/highbank_l2_edac.c |  2 +-
 drivers/edac/mpc85xx_edac.c     |  2 +-
 drivers/edac/octeon_edac-l2c.c  |  2 +-
 drivers/edac/octeon_edac-pc.c   |  2 +-
 drivers/edac/qcom_edac.c        |  1 -
 drivers/edac/sifive_edac.c      |  3 +-
 drivers/edac/thunderx_edac.c    |  6 ++--
 drivers/edac/xgene_edac.c       | 10 +++----
 drivers/edac/zynqmp_edac.c      |  2 +-
 15 files changed, 20 insertions(+), 79 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index ae17ce4d9722..fe89f5c4837f 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -737,8 +737,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	}
 
 	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
-					 1, ecc_name, 1, 0, NULL, 0,
-					 dev_instance++);
+					 1, ecc_name, 1, 0, dev_instance++);
 
 	if (!dci) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -1514,7 +1513,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	/* Create the PortB EDAC device */
 	edac_idx = edac_device_alloc_index();
 	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name, 1,
-					 ecc_name, 1, 0, NULL, 0, edac_idx);
+					 ecc_name, 1, 0, edac_idx);
 	if (!dci) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate PortB EDAC device\n",
@@ -1921,8 +1920,7 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 
 	edac_idx = edac_device_alloc_index();
 	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name,
-					 1, ecc_name, 1, 0, NULL, 0,
-					 edac_idx);
+					 1, ecc_name, 1, 0, edac_idx);
 
 	if (!dci) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
index ca718f63fcbc..a6d3013d5823 100644
--- a/drivers/edac/amd8111_edac.c
+++ b/drivers/edac/amd8111_edac.c
@@ -366,8 +366,7 @@ static int amd8111_dev_probe(struct pci_dev *dev,
 	dev_info->edac_idx = edac_device_alloc_index();
 	dev_info->edac_dev =
 		edac_device_alloc_ctl_info(0, dev_info->ctl_name, 1,
-					   NULL, 0, 0,
-					   NULL, 0, dev_info->edac_idx);
+					   NULL, 0, 0, dev_info->edac_idx);
 	if (!dev_info->edac_dev) {
 		ret = -ENOMEM;
 		goto err_dev_put;
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index 25517c99b3ea..589bc81f1249 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -523,7 +523,7 @@ static int aurora_l2_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "data ECC is not enabled\n");
 
 	dci = edac_device_alloc_ctl_info(sizeof(*drvdata),
-					 "cpu", 1, "L", 1, 2, NULL, 0, 0);
+					 "cpu", 1, "L", 1, 2, 0);
 	if (!dci)
 		return -ENOMEM;
 
diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 5075dc7526e3..eb702bc3aa29 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -797,7 +797,7 @@ static void cpc925_add_edac_devices(void __iomem *vbase)
 		dev_info->edac_idx = edac_device_alloc_index();
 		dev_info->edac_dev =
 			edac_device_alloc_ctl_info(0, dev_info->ctl_name,
-				1, NULL, 0, 0, NULL, 0, dev_info->edac_idx);
+				1, NULL, 0, 0, dev_info->edac_idx);
 		if (!dev_info->edac_dev) {
 			cpc925_printk(KERN_ERR, "No memory for edac device\n");
 			goto err1;
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 8c2aa5bcf1b7..621dc2a5d034 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -56,14 +56,12 @@ static void edac_device_dump_device(struct edac_device_ctl_info *edac_dev)
 struct edac_device_ctl_info *
 edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instances,
 			   char *blk_name, unsigned nr_blocks, unsigned off_val,
-			   struct edac_dev_sysfs_block_attribute *attrib_spec,
-			   unsigned nr_attrib, int device_index)
+			   int device_index)
 {
-	struct edac_dev_sysfs_block_attribute *dev_attrib, *attrib_p, *attrib;
 	struct edac_device_block *dev_blk, *blk_p, *blk;
 	struct edac_device_instance *dev_inst, *inst;
 	struct edac_device_ctl_info *dev_ctl;
-	unsigned instance, block, attr;
+	unsigned instance, block;
 	void *pvt;
 	int err;
 
@@ -85,15 +83,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 
 	dev_ctl->blocks = dev_blk;
 
-	if (nr_attrib) {
-		dev_attrib = kcalloc(nr_attrib, sizeof(struct edac_dev_sysfs_block_attribute),
-				     GFP_KERNEL);
-		if (!dev_attrib)
-			goto free;
-
-		dev_ctl->attribs = dev_attrib;
-	}
-
 	if (pvt_sz) {
 		pvt = kzalloc(pvt_sz, GFP_KERNEL);
 		if (!pvt)
@@ -132,41 +121,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 
 			edac_dbg(4, "instance=%d inst_p=%p block=#%d block_p=%p name='%s'\n",
 				 instance, inst, block, blk, blk->name);
-
-			/* if there are NO attributes OR no attribute pointer
-			 * then continue on to next block iteration
-			 */
-			if ((nr_attrib == 0) || (attrib_spec == NULL))
-				continue;
-
-			/* setup the attribute array for this block */
-			blk->nr_attribs = nr_attrib;
-			attrib_p = &dev_attrib[block*nr_instances*nr_attrib];
-			blk->block_attributes = attrib_p;
-
-			edac_dbg(4, "THIS BLOCK_ATTRIB=%p\n",
-				 blk->block_attributes);
-
-			/* Initialize every user specified attribute in this
-			 * block with the data the caller passed in
-			 * Each block gets its own copy of pointers,
-			 * and its unique 'value'
-			 */
-			for (attr = 0; attr < nr_attrib; attr++) {
-				attrib = &attrib_p[attr];
-
-				/* populate the unique per attrib
-				 * with the code pointers and info
-				 */
-				attrib->attr = attrib_spec[attr].attr;
-				attrib->show = attrib_spec[attr].show;
-
-				edac_dbg(4, "alloc-attrib=%p attrib_name='%s' attrib-spec=%p spec-name=%s\n",
-					 attrib, attrib->attr.name,
-					 &attrib_spec[attr],
-					 attrib_spec[attr].attr.name
-					);
-			}
 		}
 	}
 
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index a39752432c90..55be019c12ca 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -208,7 +208,6 @@ struct edac_device_ctl_info {
 	u32 nr_instances;
 	struct edac_device_instance *instances;
 	struct edac_device_block *blocks;
-	struct edac_dev_sysfs_block_attribute *attribs;
 
 	/* Event counters for the this whole EDAC Device */
 	struct edac_device_counter counters;
@@ -236,8 +235,6 @@ extern struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 		char *edac_device_name, unsigned nr_instances,
 		char *edac_block_name, unsigned nr_blocks,
 		unsigned offset_value,
-		struct edac_dev_sysfs_block_attribute *block_attributes,
-		unsigned nr_attribs,
 		int device_index);
 
 /* The offset value can be:
@@ -347,7 +344,6 @@ static inline void __edac_device_free_ctl_info(struct edac_device_ctl_info *ci)
 {
 	if (ci) {
 		kfree(ci->pvt_info);
-		kfree(ci->attribs);
 		kfree(ci->blocks);
 		kfree(ci->instances);
 		kfree(ci);
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index 5646c049a934..282ca6535f8f 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -54,7 +54,7 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 	int res = 0;
 
 	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), "cpu",
-		1, "L", 1, 2, NULL, 0, 0);
+					 1, "L", 1, 2, 0);
 	if (!dci)
 		return -ENOMEM;
 
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index c1bc53f4e184..e8945d4adbad 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -496,7 +496,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	edac_dev = edac_device_alloc_ctl_info(sizeof(*pdata),
-					      "cpu", 1, "L", 1, 2, NULL, 0,
+					      "cpu", 1, "L", 1, 2,
 					      edac_dev_idx);
 	if (!edac_dev) {
 		devres_release_group(&op->dev, mpc85xx_l2_err_probe);
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index 4015eb9af6fe..919095d10528 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -138,7 +138,7 @@ static int octeon_l2c_probe(struct platform_device *pdev)
 
 	/* 'Tags' are block 0, 'Data' is block 1*/
 	l2c = edac_device_alloc_ctl_info(0, "l2c", num_tads, "l2c", 2, 0,
-					 NULL, 0, edac_device_alloc_index());
+					 edac_device_alloc_index());
 	if (!l2c)
 		return -ENOMEM;
 
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index ea8a8e337b1e..b8404cc7b65f 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -92,7 +92,7 @@ static int co_cache_error_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	p->ed = edac_device_alloc_ctl_info(0, "cpu", num_possible_cpus(),
-					   "cache", 2, 0, NULL, 0,
+					   "cache", 2, 0,
 					   edac_device_alloc_index());
 	if (!p->ed)
 		goto err;
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 5539917c01dd..d3cd4cc54ace 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -349,7 +349,6 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	/* Allocate edac control info */
 	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
 					      llcc_driv_data->num_banks, 1,
-					      NULL, 0,
 					      edac_device_alloc_index());
 
 	if (!edev_ctl)
diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
index b844e2626fd5..a2b193dc6604 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -52,8 +52,7 @@ static int ecc_register(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	p->dci = edac_device_alloc_ctl_info(0, "sifive_ecc", 1, "sifive_ecc",
-					    1, 1, NULL, 0,
-					    edac_device_alloc_index());
+					    1, 1, edac_device_alloc_index());
 	if (!p->dci)
 		return -ENOMEM;
 
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 90d46e5c4ff0..fab9891e569a 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1365,8 +1365,7 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
 	idx = edac_device_alloc_index();
 	snprintf(name, sizeof(name), "OCX%d", idx);
 	edac_dev = edac_device_alloc_ctl_info(sizeof(struct thunderx_ocx),
-					      name, 1, "CCPI", 1,
-					      0, NULL, 0, idx);
+					      name, 1, "CCPI", 1, 0, idx);
 	if (!edac_dev) {
 		dev_err(&pdev->dev, "Cannot allocate EDAC device\n");
 		return -ENOMEM;
@@ -2004,8 +2003,7 @@ static int thunderx_l2c_probe(struct pci_dev *pdev,
 	snprintf(name, sizeof(name), fmt, idx);
 
 	edac_dev = edac_device_alloc_ctl_info(sizeof(struct thunderx_l2c),
-					      name, 1, "L2C", 1, 0,
-					      NULL, 0, idx);
+					      name, 1, "L2C", 1, 0, idx);
 	if (!edac_dev) {
 		dev_err(&pdev->dev, "Cannot allocate EDAC device\n");
 		return -ENOMEM;
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 1b50f8160013..fd87f1b2c145 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -913,8 +913,8 @@ static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np,
 
 	snprintf(edac_name, sizeof(edac_name), "l2c%d", pmd);
 	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
-					      edac_name, 1, "l2c", 1, 2, NULL,
-					      0, edac_device_alloc_index());
+					      edac_name, 1, "l2c", 1, 2,
+					      edac_device_alloc_index());
 	if (!edac_dev) {
 		rc = -ENOMEM;
 		goto err_group;
@@ -1208,8 +1208,7 @@ static int xgene_edac_l3_add(struct xgene_edac *edac, struct device_node *np,
 
 	edac_idx = edac_device_alloc_index();
 	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
-					      "l3c", 1, "l3c", 1, 0, NULL, 0,
-					      edac_idx);
+					      "l3c", 1, "l3c", 1, 0, edac_idx);
 	if (!edac_dev) {
 		rc = -ENOMEM;
 		goto err_release_group;
@@ -1748,8 +1747,7 @@ static int xgene_edac_soc_add(struct xgene_edac *edac, struct device_node *np,
 
 	edac_idx = edac_device_alloc_index();
 	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
-					      "SOC", 1, "SOC", 1, 2, NULL, 0,
-					      edac_idx);
+					      "SOC", 1, "SOC", 1, 2, edac_idx);
 	if (!edac_dev) {
 		rc = -ENOMEM;
 		goto err_release_group;
diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index 2d9a5cfd8931..c9dc78d8c824 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -381,7 +381,7 @@ static int edac_probe(struct platform_device *pdev)
 	}
 
 	dci = edac_device_alloc_ctl_info(sizeof(*priv), ZYNQMP_OCM_EDAC_STRING,
-					 1, ZYNQMP_OCM_EDAC_STRING, 1, 0, NULL, 0,
+					 1, ZYNQMP_OCM_EDAC_STRING, 1, 0,
 					 edac_device_alloc_index());
 	if (!dci)
 		return -ENOMEM;
-- 
2.43.1


