Return-Path: <linux-kernel+bounces-144689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F9C8A493E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514671F21815
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185D364A0;
	Mon, 15 Apr 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKAnEkZh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885672EAE6;
	Mon, 15 Apr 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166858; cv=none; b=Q7WKSqGsSUlzJ79Ly7aSrgD4DXyIoTWuEUYkRxr7IUBCaxiiIj96/ip4W3OonqcVfayckjULVlnz7EouE11c35w141aTzzlSSUsk+jTf74Fv1cmb7PXWLIsc8YYZ3ymFh22vsSPruPr2Z31OdS8IV0mhAjkdKt3mlfiO6IbbQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166858; c=relaxed/simple;
	bh=KV3WZcxZWeAs613SkdTfKfp+L1qJ8Fy4gMkHGkuUPe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DP5kDgyM65VX+DZsz1418y/8BCZPIL6QFHt35nmBVdJ5nPR3fiv6/hFsz57awXJhRECe3afeQBlE8bXHjV2zqY3A40xWBemNFFNgm3IerAG0J/VfCnNxm8G5PeI0JmUtusRBUzjNXU5pojhBfyafBieQbhUxREYAGOpWdhPs974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKAnEkZh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713166857; x=1744702857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KV3WZcxZWeAs613SkdTfKfp+L1qJ8Fy4gMkHGkuUPe0=;
  b=JKAnEkZhbd8NvEtzy3RBiZHuTvuQvU+tamB0H9phJa3SgbvU85ILwIgm
   XaueTcbTQZZgH51taqlckmLRNxGWXjLQopai20LxD33tQYlNeyoG8xVbr
   KfGZsiCWeWCtiLxW1JdcQtn/mGUYgJQnjmmNWoGPKVRP+Rp4VccKGzeZ/
   /W9Q8mXJqSC/xFur7gDf6dbwuBmFK8mKfyB/tjR4bkEywoUGr+o823Fhr
   SiTIN4O9Di8E1uCbXxHzt6yx6yYOiwOqJ66eUWBHvPDE8mmYhw/Ltpq4m
   /NHgzFVOLwpq0pmWDFoyJXVz0+Pgi+O7bvgjLngPsICjgPoxSH092QXg3
   A==;
X-CSE-ConnectionGUID: Sd3eIBN2R+mhGNpeWO5gDw==
X-CSE-MsgGUID: Hdc6R8JhTnC6G8lSNY0HGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8665715"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8665715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:40:56 -0700
X-CSE-ConnectionGUID: ZgGAJXOMTkqj8j8DED4pOw==
X-CSE-MsgGUID: NX9oNU9cTkOg23OUyyMsgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52781267"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 15 Apr 2024 00:40:54 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 5459F72AA6;
	Mon, 15 Apr 2024 13:10:53 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 4F5131600100; Mon, 15 Apr 2024 13:10:53 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2] pwm: dwc: allow suspend/resume for 16 channels
Date: Mon, 15 Apr 2024 13:10:51 +0530
Message-Id: <20240415074051.14681-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 16 channel pwm support, we're registering two instances of pwm_chip
with 8 channels each. We need to update PM functions to use both instances
of pwm_chip during power state transitions.

Introduce struct dwc_pwm_drvdata and use it as driver_data, which will
maintain both instances of pwm_chip along with dwc_pwm_info and allow us
to use them inside suspend/resume handles.

Fixes: ebf2c89eb95e ("pwm: dwc: Add 16 channel support for Intel Elkhart Lake")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
Changes since v1:
- Drop error message for -ENOMEM
- s/data/ddata/

 drivers/pwm/pwm-dwc-core.c |  1 -
 drivers/pwm/pwm-dwc.c      | 82 +++++++++++++++++++++++++-------------
 drivers/pwm/pwm-dwc.h      |  6 +++
 3 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 043736972cb9..c8425493b95d 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -172,7 +172,6 @@ struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 	dwc->clk_ns = 10;
 	chip->ops = &dwc_pwm_ops;
 
-	dev_set_drvdata(dev, chip);
 	return chip;
 }
 EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 676eaf8d7a53..fb3eadf6fbc4 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -31,26 +31,34 @@ static const struct dwc_pwm_info ehl_pwm_info = {
 	.size = 0x1000,
 };
 
-static int dwc_pwm_init_one(struct device *dev, void __iomem *base, unsigned int offset)
+static int dwc_pwm_init_one(struct device *dev, struct dwc_pwm_drvdata *ddata, unsigned int idx)
 {
 	struct pwm_chip *chip;
 	struct dwc_pwm *dwc;
+	int ret;
 
 	chip = dwc_pwm_alloc(dev);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
 	dwc = to_dwc_pwm(chip);
-	dwc->base = base + offset;
+	dwc->base = ddata->io_base + (ddata->info->size * idx);
 
-	return devm_pwmchip_add(dev, chip);
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return ret;
+
+	ddata->chips[idx] = chip;
+	return 0;
 }
 
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	const struct dwc_pwm_info *info;
 	struct device *dev = &pci->dev;
-	int i, ret;
+	struct dwc_pwm_drvdata *ddata;
+	unsigned int idx;
+	int ret;
 
 	ret = pcim_enable_device(pci);
 	if (ret)
@@ -63,17 +71,25 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");
 
 	info = (const struct dwc_pwm_info *)id->driver_data;
+	ddata = devm_kzalloc(dev, struct_size(ddata, chips, info->nr), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
 
-	for (i = 0; i < info->nr; i++) {
-		/*
-		 * No need to check for pcim_iomap_table() failure,
-		 * pcim_iomap_regions() already does it for us.
-		 */
-		ret = dwc_pwm_init_one(dev, pcim_iomap_table(pci)[0], i * info->size);
+	/*
+	 * No need to check for pcim_iomap_table() failure,
+	 * pcim_iomap_regions() already does it for us.
+	 */
+	ddata->io_base = pcim_iomap_table(pci)[0];
+	ddata->info = info;
+
+	for (idx = 0; idx < ddata->info->nr; idx++) {
+		ret = dwc_pwm_init_one(dev, ddata, idx);
 		if (ret)
 			return ret;
 	}
 
+	dev_set_drvdata(dev, ddata);
+
 	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
 
@@ -88,19 +104,24 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 
 static int dwc_pwm_suspend(struct device *dev)
 {
-	struct pwm_chip *chip = dev_get_drvdata(dev);
-	struct dwc_pwm *dwc = to_dwc_pwm(chip);
-	int i;
+	struct dwc_pwm_drvdata *ddata = dev_get_drvdata(dev);
+	unsigned int idx;
 
-	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-		if (chip->pwms[i].state.enabled) {
-			dev_err(dev, "PWM %u in use by consumer (%s)\n",
-				i, chip->pwms[i].label);
-			return -EBUSY;
+	for (idx = 0; idx < ddata->info->nr; idx++) {
+		struct pwm_chip *chip = ddata->chips[idx];
+		struct dwc_pwm *dwc = to_dwc_pwm(chip);
+		unsigned int i;
+
+		for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+			if (chip->pwms[i].state.enabled) {
+				dev_err(dev, "PWM %u in use by consumer (%s)\n",
+					i, chip->pwms[i].label);
+				return -EBUSY;
+			}
+			dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
+			dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
+			dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
 		}
-		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
-		dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
-		dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
 	}
 
 	return 0;
@@ -108,14 +129,19 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct pwm_chip *chip = dev_get_drvdata(dev);
-	struct dwc_pwm *dwc = to_dwc_pwm(chip);
-	int i;
+	struct dwc_pwm_drvdata *ddata = dev_get_drvdata(dev);
+	unsigned int idx;
 
-	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
-		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
-		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
+	for (idx = 0; idx < ddata->info->nr; idx++) {
+		struct pwm_chip *chip = ddata->chips[idx];
+		struct dwc_pwm *dwc = to_dwc_pwm(chip);
+		unsigned int i;
+
+		for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+			dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
+			dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
+			dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
+		}
 	}
 
 	return 0;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index a8b074841ae8..c6e2df5a6122 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -38,6 +38,12 @@ struct dwc_pwm_info {
 	unsigned int size;
 };
 
+struct dwc_pwm_drvdata {
+	const struct dwc_pwm_info *info;
+	void __iomem *io_base;
+	struct pwm_chip *chips[];
+};
+
 struct dwc_pwm_ctx {
 	u32 cnt;
 	u32 cnt2;
-- 
2.35.3


