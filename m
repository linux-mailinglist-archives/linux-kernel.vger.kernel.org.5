Return-Path: <linux-kernel+bounces-70678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62775859B10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D775B1F21A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107CEAE8;
	Mon, 19 Feb 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcATlxWC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592065394;
	Mon, 19 Feb 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313939; cv=none; b=SrkWssxSARvYbr1kp923z+X4HxfmVBlxpWAkU/mo/LWNwlNWz4sSSWpfK2yvaz/vQLFQ1gLnrgmnp/pv3VDpBM1j2qbSMfpXK8z7A2w/C9pj/IjjIVhZSvoWgmuFbGgTXGMd66Aeb7rocRgtzs9fSsEGd1Dqqa79tfzcoVpKgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313939; c=relaxed/simple;
	bh=3SA399l3wQi0zEkfAPZlEB2CaZPgZiYLUGDzOWweojA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzGEEGecuf3mCVeDxBuawBLYQss/n5bIUzKHYKAcAY4uHLitGR5GUS1728GzL5qoTGzRN7etYiM9USA1QdP7x4rTyDoIWcZW2toSKgOXA9ZSX/6TYmlNzruCzH8FWUjIkRXnliudUFgeg8Nqc6ePLNGust8gHkUjLLaFzlPQULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcATlxWC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708313938; x=1739849938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SA399l3wQi0zEkfAPZlEB2CaZPgZiYLUGDzOWweojA=;
  b=HcATlxWCYcLFsVDNLKZdcVNGRFEDaEwPb2xUOt5cnQxRAFUMKYwU++cE
   QxUmJqM0Fk9MSzeWxr+jOed9N8Jb+TIhbGcuzETb96RGeCz58MthvyVgS
   JoaSqZ9TzzWpy8sRfeVZm3D63tzctldLni7dzg7OuDWxtEdzldsFOVxyP
   mX/e/bXtHq3lThmGjDtQlKLZJcHbSu8B9umgM17cU13jdt0Ki96lrsdl5
   lWRvlGY+R+SuUbAh72dfDZnJATXFQuGHKPSxZsnH3Y2vb0spB/PlMAbS6
   raN6Mf8Lzqfkpl69PjGGlMRPtPQaIdFBDi0QK01+kEmAL/riLdM0d8VNy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24838177"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24838177"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 19:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4281841"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2024 19:38:47 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id C771672DD8;
	Mon, 19 Feb 2024 09:08:45 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id C34251600103; Mon, 19 Feb 2024 09:08:45 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 3/4] pwm: dwc: Add 16 channel support for Intel Elkhart Lake
Date: Mon, 19 Feb 2024 09:08:34 +0530
Message-Id: <20240219033835.11369-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240219033835.11369-1-raag.jadav@intel.com>
References: <20240219033835.11369-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
function with 8 channels each. Add support for the remaining channels.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/pwm/pwm-dwc.c | 38 +++++++++++++++++++++++++++++---------
 drivers/pwm/pwm-dwc.h |  5 +++++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 7dbb72c80ef5..de95352081fa 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -25,17 +25,32 @@
 
 #include "pwm-dwc.h"
 
-static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
+/* Elkhart Lake */
+static const struct dwc_pwm_info ehl_pwm_info = {
+	.nr = 2,
+	.size = 0x1000,
+};
+
+static int dwc_pwm_init_one(struct device *dev, void __iomem *base, unsigned int offset)
 {
-	struct device *dev = &pci->dev;
 	struct pwm_chip *chip;
 	struct dwc_pwm *dwc;
-	int ret;
 
 	chip = dwc_pwm_alloc(dev);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
+
 	dwc = to_dwc_pwm(chip);
+	dwc->base = base + offset;
+
+	return devm_pwmchip_add(dev, chip);
+}
+
+static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	const struct dwc_pwm_info *info;
+	struct device *dev = &pci->dev;
+	int i, ret;
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -51,12 +66,17 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return ret;
 	}
 
-	/* No need to check for failure, pcim_iomap_regions() does it for us. */
-	dwc->base = pcim_iomap_table(pci)[0];
+	info = (const struct dwc_pwm_info *)id->driver_data;
 
-	ret = devm_pwmchip_add(dev, chip);
-	if (ret)
-		return ret;
+	for (i = 0; i < info->nr; i++) {
+		/*
+		 * No need to check for pcim_iomap_table() failure,
+		 * pcim_iomap_regions() already does it for us.
+		 */
+		ret = dwc_pwm_init_one(dev, pcim_iomap_table(pci)[0], i * info->size);
+		if (ret)
+			return ret;
+	}
 
 	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
@@ -108,7 +128,7 @@ static int dwc_pwm_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
 
 static const struct pci_device_id dwc_pwm_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
+	{ PCI_VDEVICE(INTEL, 0x4bb7), (kernel_ulong_t)&ehl_pwm_info },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 5887371803fd..a8b074841ae8 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -33,6 +33,11 @@ MODULE_IMPORT_NS(dwc_pwm);
 #define DWC_TIM_CTRL_INT_MASK	BIT(2)
 #define DWC_TIM_CTRL_PWM	BIT(3)
 
+struct dwc_pwm_info {
+	unsigned int nr;
+	unsigned int size;
+};
+
 struct dwc_pwm_ctx {
 	u32 cnt;
 	u32 cnt2;
-- 
2.35.3


