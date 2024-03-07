Return-Path: <linux-kernel+bounces-95751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B456875209
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA731C24040
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71612FB24;
	Thu,  7 Mar 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwJteYJG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151412F39D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822214; cv=none; b=OrJljjtb9RHq//mYNFVC7Uw0y9UAXzYe550RWmi0ZyqUg9pPfwEhUxxm3jyW9c/+pNHGulLVOWp30MjVPPdfQJbKE8VaJyDA5nhyhtopCINTy9WRre64NtzBmJdk1lDtv1CCYMpvcejfPEWXFRzRWk8NtFKS1MjWtdBAFtWEm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822214; c=relaxed/simple;
	bh=xvcS3U4WyCuC99KlUMtUZiggvZqD/+Lbdgm2gFxqUiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1q+32Xtx9Y4KW6tyciCwivESrErbRpYGyrEJvAaZfvQMbOr8fQ8gG4R9QU/YHI/wItzk+L4d4IpqRaQO0Gc8ZOhaUoT63FLnumxswevTjP7aG/TIfSaKeC7QQw0kG0pNYHkr/nMn6YBX32moPyF152/+ZSDANWJfOGMw20f9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwJteYJG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822213; x=1741358213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvcS3U4WyCuC99KlUMtUZiggvZqD/+Lbdgm2gFxqUiM=;
  b=FwJteYJGJ0R35s8xlUE8942rI4bUFLu5c8YHknqNbNejJXbQdXKhmCKK
   xu+sELQg2YquukODnO7CgpIyZzWBK8wbmMnpTRRsDaOrzvZknt1jYafFC
   k9aaPj/ittst5ftdrWDHAC6amor35ig0mq6icTTrzmqE6utk/TZV8PkNJ
   WbD0XuaWKD/OegbLExsGN0u7euYrcSCS6ot1/ou/9U42Ij6mOP7VujBBL
   RA/6/Fweq9xBC3A1H+0NU5olv6+fldMjGE3k7PfEsZP/bQC+wQPN3875t
   HSG1LZEZcl+GWYdFF2Gs3mvAuMWdxCgXk06MM8NyTK9Yj5PrpaGrz+O1B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348216"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046242"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046242"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 06:36:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 021CC4E9; Thu,  7 Mar 2024 16:36:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] w1: gpio: Switch to use dev_err_probe()
Date: Thu,  7 Mar 2024 16:35:48 +0200
Message-ID: <20240307143644.3787260-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
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
 drivers/w1/masters/w1-gpio.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 8ea53c757c99..a5ac34b32f54 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -91,18 +91,14 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddata->gpiod = devm_gpiod_get_index(dev, NULL, 0, gflags);
-	if (IS_ERR(ddata->gpiod)) {
-		dev_err(dev, "gpio_request (pin) failed\n");
-		return PTR_ERR(ddata->gpiod);
-	}
+	if (IS_ERR(ddata->gpiod))
+		return dev_err_probe(dev, PTR_ERR(ddata->gpiod), "gpio_request (pin) failed\n");
 
 	ddata->pullup_gpiod =
 		devm_gpiod_get_index_optional(dev, NULL, 1, GPIOD_OUT_LOW);
-	if (IS_ERR(ddata->pullup_gpiod)) {
-		dev_err(dev, "gpio_request_one "
-			"(ext_pullup_enable_pin) failed\n");
-		return PTR_ERR(ddata->pullup_gpiod);
-	}
+	if (IS_ERR(ddata->pullup_gpiod))
+		return dev_err_probe(dev, PTR_ERR(ddata->pullup_gpiod),
+				     "gpio_request (ext_pullup_enable_pin) failed\n");
 
 	master->data = ddata;
 	master->read_bit = w1_gpio_read_bit;
@@ -119,10 +115,8 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		master->set_pullup = w1_gpio_set_pullup;
 
 	err = w1_add_master_device(master);
-	if (err) {
-		dev_err(dev, "w1_add_master device failed\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "w1_add_master device failed\n");
 
 	if (ddata->pullup_gpiod)
 		gpiod_set_value(ddata->pullup_gpiod, 1);
-- 
2.43.0.rc1.1.gbec44491f096


