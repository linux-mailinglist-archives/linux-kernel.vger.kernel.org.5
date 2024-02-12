Return-Path: <linux-kernel+bounces-61593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15DF851404
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86B1B21F79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BB3A8E9;
	Mon, 12 Feb 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrL6v1wH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA743A292;
	Mon, 12 Feb 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742976; cv=none; b=nqdIVrX2x6G6RgoWRmwHeVb/3iuQvSDNxs9E0oP70Kz5P5uHTb//SNnvVY/e1goYS9ewtiAC+bG4c8Lnie35ovySLC8gNb6YW4p7sh/gnlHUcIio28GW4d7QDyPgyPWvDKjpHD++ZSqppuLCB0++F79ng1XdyxVRY93J78Zhxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742976; c=relaxed/simple;
	bh=v0mOMqEEhZI5Srf3XL6JSewIp0AoLiBxxHafw44lB8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXkwHKacsPuWxdQET5+kA+vocNwzFhR1ahVyjP4a+O5xdURdbX17dSNMBpjij/2CiDsR5Ku1/iMPUdLJwNz61ITdn7MDfbaWv3cVM3aV/VtlCvT1u58TXyLjqbnqS/BsdfaO2u3oi/d+sBuJ9mDv+DbCbO0uhkgTTpoeku4yQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrL6v1wH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742975; x=1739278975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0mOMqEEhZI5Srf3XL6JSewIp0AoLiBxxHafw44lB8E=;
  b=UrL6v1wHPUfvfomnhS5ZqEzEOAbn+pRqXZJFrrd2Ph4nuIM0B5jNgVOI
   uc0Zak3RVDr0ea2Kj9fVih3mzmhmOHOAbMs74m6vrASvO5moqdNcfdQpA
   yIf9aqxlw706EAq2YGiB8a+14JW/bjXBIlI0RDhKKn1n3b6CxLrPqp/C6
   02ssmI4KNm43W0UJE3/kTK4GOCKFnlNrs8CeOxBMYgm+Mo8K2Xdf+CWrr
   yoS02rWg4HcDxxIKeE+JZ7rEB88PtXUm2N6OLLcAgPDXHzfdtCAVTga5D
   YY4IU4X5broMfmSmV29tRP6cuvNzO0Wy5yPsMuQ13NaPnQC37gY4R1GbF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1594834"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1594834"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33378389"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 05:02:50 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 59E7A1CAFE;
	Mon, 12 Feb 2024 18:32:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 54A401600103; Mon, 12 Feb 2024 18:32:49 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 3/5] pwm: dwc: Add 16 channel support for Intel Elkhart Lake
Date: Mon, 12 Feb 2024 18:32:45 +0530
Message-Id: <20240212130247.9985-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240212130247.9985-1-raag.jadav@intel.com>
References: <20240212130247.9985-1-raag.jadav@intel.com>
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
Tested-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 33 +++++++++++++++++++++++++--------
 drivers/pwm/pwm-dwc.h |  5 +++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index b9e18dbf7493..6d922afcb20a 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -25,16 +25,31 @@
 
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
 	struct dwc_pwm *dwc;
-	int ret;
 
 	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
+	dwc->base = base + offset;
+
+	return devm_pwmchip_add(dev, &dwc->chip);
+}
+
+static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	const struct dwc_pwm_info *info;
+	struct device *dev = &pci->dev;
+	int i, ret;
+
 	ret = pcim_enable_device(pci);
 	if (ret) {
 		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
@@ -49,11 +64,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return ret;
 	}
 
-	dwc->base = pcim_iomap_table(pci)[0];
+	info = (const struct dwc_pwm_info *)id->driver_data;
 
-	ret = devm_pwmchip_add(dev, &dwc->chip);
-	if (ret)
-		return ret;
+	for (i = 0; i < info->nr; i++) {
+		ret = dwc_pwm_init_one(dev, pcim_iomap_table(pci)[0], i * info->size);
+		if (ret)
+			return ret;
+	}
 
 	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
@@ -105,7 +122,7 @@ static int dwc_pwm_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
 
 static const struct pci_device_id dwc_pwm_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
+	{ PCI_VDEVICE(INTEL, 0x4bb7), (kernel_ulong_t)&ehl_pwm_info },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 64795247c54c..c9bbfc77b568 100644
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


