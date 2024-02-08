Return-Path: <linux-kernel+bounces-57544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A184DA8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0425E1C23C15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBAC6A029;
	Thu,  8 Feb 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf7R9CJR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD769318;
	Thu,  8 Feb 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375948; cv=none; b=ZbdE6xegL0/kqMvxU9na+iejnQnAs9/G+w5kO/nowd6T0opvjsKngjHrnNCozwc7dTvQTH7ky+qCNB2tRhhitgQ0lrMYH3c1xcl6BF1BpJwvlTk5u+0FEGvQqb4Sxequwsui/AzA1EB0wQUGRJ1QdEOG92nSPlqRNAMec2XigDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375948; c=relaxed/simple;
	bh=OhT4XZj8t2RtDk3NO3j6nx+lfeIyy2pDTu1PML96cWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewZn45T+/PSRMYhHCmZapqM2opwV8XSQ45jJdGaBOoaowBTH2RxGaYsOHVV2yJKjGmLZ1di91wCgFLD0NDUNNwDLf7rKNVSYsqgf5lm53XfAKMZy3/eHvMXL8ppabtspGJNatLs0GW2I0m1YGrs1CBLvWD59+wjOhnj7VdL+hhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf7R9CJR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707375947; x=1738911947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhT4XZj8t2RtDk3NO3j6nx+lfeIyy2pDTu1PML96cWQ=;
  b=Gf7R9CJRnqdUyu6opmDZP4fsPYcmWUBSz+qhtEJ6ZQeLHexFAdWntZN9
   VNp7/qU31gm0GaolbqDNBKq4NgJshKuxsB+5PJrw1xcqxJSD/RkE9/Qum
   t/zylTczLvxtnrRPI+ywoOowirrxtdLu73XH0eRn7BHjZiq/UzjCKflXt
   FsnAMpC2aPZL/HxnN6v6+5Qovazu2K/+LX3hLckvTQitG/GHIu27f7Bz8
   g99mt6+x+CKjzdQHeue21KmD3QEBfbSCaiES1MLSMIn/kMYGrn489c9aX
   zUJPP3Rj3rZ1RRksbaSg5scYX6dEL99ZqsJmo2zb9Vf0lLzg8khhw8DE7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12525870"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12525870"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1573964"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2024 23:05:36 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 513EB14353;
	Thu,  8 Feb 2024 12:35:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 4F5401600102; Thu,  8 Feb 2024 12:35:35 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/5] pwm: dwc: Add 16 channel support for Intel Elkhart Lake
Date: Thu,  8 Feb 2024 12:35:26 +0530
Message-Id: <20240208070529.28562-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208070529.28562-1-raag.jadav@intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
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
 drivers/pwm/pwm-dwc.c | 33 +++++++++++++++++++++++++--------
 drivers/pwm/pwm-dwc.h |  5 +++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 596a0bb35c40..47d76f5367fe 100644
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


