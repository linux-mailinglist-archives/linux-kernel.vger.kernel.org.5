Return-Path: <linux-kernel+bounces-9878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A517481CCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA25F1C222B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C524203;
	Fri, 22 Dec 2023 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAqu7p39"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AC241E2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703261999; x=1734797999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5sWPu/QE2BZjrUa//e2v0OlJLwu4bI+cyGCK9XgPseo=;
  b=ZAqu7p39RUJ4dk7isVSrYN/uUrZTkPJIkFYrsDOnvbgOY+8LONx/QuFO
   HYHwFjG0gY3A6sHaVOhd+hQ4LdC3u/Cuc56j5cJAMsESmoN8Nm2SAovwN
   sicPkV4IyFJ8NleVtOBSe55X5r1lOoNze4EM4e/7zOdTyt6/eHUfHaW0o
   Le3fncS8IRUiZCi3oP/R6rEyrGouLMghsqLbJFS7G3IWbCBHAxDRwXOVa
   6yhPsg50u5oc/buHnf9O9WUhrRs/so4xJ2eHm+Hp5YhsMEGNy6MR+Ro0G
   uix6bNFY3NyA95JzaohOkUON/Hv5Ww+9BlSPpLDvUFZ/ORCebkxl5gFob
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="376273895"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="376273895"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 08:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024233392"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="1024233392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Dec 2023 08:19:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 66DB7291; Fri, 22 Dec 2023 18:19:55 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use dev_err_probe()
Date: Fri, 22 Dec 2023 18:19:54 +0200
Message-ID: <20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-mrfld.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
index 2ee738f844ab..8414222d6597 100644
--- a/drivers/extcon/extcon-intel-mrfld.c
+++ b/drivers/extcon/extcon-intel-mrfld.c
@@ -250,24 +250,18 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
 		return PTR_ERR(data->edev);
 
 	ret = devm_extcon_dev_register(dev, data->edev);
-	if (ret < 0) {
-		dev_err(dev, "can't register extcon device: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "can't register extcon device\n");
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_extcon_interrupt,
 					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
 					data);
-	if (ret) {
-		dev_err(dev, "can't register IRQ handler: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "can't register IRQ handler\n");
 
 	ret = regmap_read(regmap, BCOVE_ID, &id);
-	if (ret) {
-		dev_err(dev, "can't read PMIC ID: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "can't read PMIC ID\n");
 
 	data->id = id;
 
-- 
2.43.0.rc1.1.gbec44491f096


