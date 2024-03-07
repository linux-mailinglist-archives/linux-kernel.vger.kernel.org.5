Return-Path: <linux-kernel+bounces-95750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BE875208
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4C1B2726A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700A12FB17;
	Thu,  7 Mar 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYlvR/cZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA912F397
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822214; cv=none; b=HjRjXlPBF8qdsFK8yXcJbV4E5UghGo0Rr84o56SL7h3Hv+326puURmEdcUM99nh3E9jNiAs5JmG49rFd5CvOHYXpBQTK2kURdQtDmZbXJ8fosbXw8Vm0OJRZ88BtRzLU0mgazlTZW1oT4Z5Z3e1QAwaExgvYhttAsEP3W5edMTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822214; c=relaxed/simple;
	bh=LDu4puO2jg3EmAwgaFHCzMT+TSTj8LnwhcOMFJ2MMsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAtoRHT23UDGEASorZ5GFmuhCF0AJyo+hOxzABVJnY3sAXR4Iw38qGHfC9wq3RJ9FWlkWJtwMkI0Zz/kQhIhcgKvA3IiomUHL1+g+3Om93ps3D+H0ZPVbQYdUnMFswVnzvK6knxhYdlSC6xgN/YsN03jZS9dB83ziOj6zNCvPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYlvR/cZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822213; x=1741358213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LDu4puO2jg3EmAwgaFHCzMT+TSTj8LnwhcOMFJ2MMsE=;
  b=YYlvR/cZ+/k0bPbHlO/kzU3NaMOnMtlPqmzVaYZCUNedbhkU2G8ADxFl
   PW7oFae4FnyanVpqNUvQji/woVJ/VEsFx3xmTu66X4yakO0pabYvZCboy
   ZmV/Cp5/AffGrurczbc1fLUgs0cYg+yehiSP4S5UmFsMcO4GHWleMaaQC
   FSpjzko/9N9lx9AIWHJIJF+QhG4sFDTRgNsMvxiAepeuPZH1alz4bCRgY
   SC8s/a20Sk4i1DVwYy8Eikpc5v4Cjb9a1+CY4PJLSCdAWRRW1sdPQvX40
   lCy7Qrn3RXdwz7O4SwlSuGbBKpxlIR9Yw0ogMjtxO5cZ/UhwAaY9Zbl6E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348210"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046241"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046241"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 06:36:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 17877697; Thu,  7 Mar 2024 16:36:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] w1: gpio: Use sizeof(*pointer) instead of sizeof(type)
Date: Thu,  7 Mar 2024 16:35:49 +0200
Message-ID: <20240307143644.3787260-4-andriy.shevchenko@linux.intel.com>
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

It is preferred to use sizeof(*pointer) instead of sizeof(type).
The type of the variable can change and one needs not change
the former (unlike the latter). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/w1/masters/w1-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index a5ac34b32f54..3881f2eaed2f 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -85,8 +85,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	if (device_property_present(dev, "linux,open-drain"))
 		gflags = GPIOD_OUT_LOW;
 
-	master = devm_kzalloc(dev, sizeof(struct w1_bus_master),
-			GFP_KERNEL);
+	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
 	if (!master)
 		return -ENOMEM;
 
-- 
2.43.0.rc1.1.gbec44491f096


