Return-Path: <linux-kernel+bounces-32289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E383598C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB04F1F22315
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE51215CB;
	Mon, 22 Jan 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2KiHTHh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA41368;
	Mon, 22 Jan 2024 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892574; cv=none; b=rhYu1gEBJOyfyAYi/Q4UXwxdeyBBi5gO3MRLLGCHcCwvKl6Ej/Zb5LYuBYqCuTM/Cts5kMTFLy9Tva0PsSuPh9r8+tN3xZsqXqgNyRpeG4XRQkiqTrRujuLhedHkK06+YDa33EyhcNd9GGgGiAYy44nG3adGNm8PnkoqMekThlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892574; c=relaxed/simple;
	bh=2he2Sh8f6FAIu+UM7iGZ5ZCP6Sfos+wDd/YvS0hJKqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz5Atkp+ayzi2y6Nhts4HVTMwmbQ64N3NVl5lSTRU7+zDVDnhMFMwnfB3BIFh56yz1KFofN/mz6iTpQTakEJ8F+3G0PVlAHhQ86qV/NQv7L4AU7ozmcCIFki1JP1bW67xqST9RKa0Sn2tnmDywtk75rVfekSBAE6LE33Ss7qqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2KiHTHh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705892573; x=1737428573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2he2Sh8f6FAIu+UM7iGZ5ZCP6Sfos+wDd/YvS0hJKqQ=;
  b=P2KiHTHhyOxelkMfo8uGMNT67wp3mZ5PpqnApJoazN9NGFINbjNnC0K8
   OiCFH/d43mxyEz8bt43rUV5vwgTY8S9ttm9bPkoqvQsI174BK2WtB8IYE
   gXNC696Ni6Tc414QZE3fFRjKzsDWFtcz1F39FI7FbSOP2TBrJo+SAHGiW
   adTHO2Ox8cKs0UoA7MCdEBFtkJIrpGTNPeXSMIidmGbwS0SesMGvGP44J
   fSsD+n/fKKc0p5/KiYQvwC6FevcrPD/TN5ATMqmnkkQt3jsisA26Fr4TA
   83CcobzUjd/BG3I4yG16PN3ry4Orgue554yOr68hcJGgdIvqcNiKwtgTU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14607317"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14607317"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 19:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1085517"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2024 19:02:42 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 1C517484B;
	Mon, 22 Jan 2024 08:32:41 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 196331600101; Mon, 22 Jan 2024 08:32:41 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel Elkhart Lake
Date: Mon, 22 Jan 2024 08:32:36 +0530
Message-Id: <20240122030238.29437-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122030238.29437-1-raag.jadav@intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
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
---
 drivers/pwm/pwm-dwc.c | 51 +++++++++++++++++++++++++++++++++++--------
 drivers/pwm/pwm-dwc.h |  5 +++++
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 4929354f8cd9..fd64313cb38d 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -25,16 +25,48 @@
 
 #include "pwm-dwc.h"
 
+/* Elkhart Lake */
+static const struct dwc_pwm_info ehl_pwm_info = {
+	.nr = 2,
+	.size = 0x1000,
+};
+
+static int dwc_pwm_init(struct device *dev, const struct dwc_pwm_info *info, void __iomem *base)
+{
+	/* Default values for single instance devices */
+	unsigned int nr = 1, size = 0;
+	int i, ret;
+
+	/* Fill up values from driver_data, if any */
+	if (info) {
+		nr = info->nr;
+		size = info->size;
+	}
+
+	for (i = 0; i < nr; i++) {
+		struct dwc_pwm *dwc;
+
+		dwc = dwc_pwm_alloc(dev);
+		if (!dwc)
+			return -ENOMEM;
+
+		dwc->base = base + (i * size);
+
+		ret = devm_pwmchip_add(dev, &dwc->chip);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
+	const struct dwc_pwm_info *info;
 	struct device *dev = &pci->dev;
-	struct dwc_pwm *dwc;
+	void __iomem *base;
 	int ret;
 
-	dwc = dwc_pwm_alloc(dev);
-	if (!dwc)
-		return -ENOMEM;
-
 	ret = pcim_enable_device(pci);
 	if (ret) {
 		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
@@ -49,13 +81,14 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return ret;
 	}
 
-	dwc->base = pcim_iomap_table(pci)[0];
-	if (!dwc->base) {
+	base = pcim_iomap_table(pci)[0];
+	if (!base) {
 		dev_err(dev, "Base address missing\n");
 		return -ENOMEM;
 	}
 
-	ret = devm_pwmchip_add(dev, &dwc->chip);
+	info = (const struct dwc_pwm_info *)id->driver_data;
+	ret = dwc_pwm_init(dev, info, base);
 	if (ret)
 		return ret;
 
@@ -109,7 +142,7 @@ static int dwc_pwm_resume(struct device *dev)
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


