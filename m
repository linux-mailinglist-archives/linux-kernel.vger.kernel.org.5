Return-Path: <linux-kernel+bounces-95663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FE8750F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE521F2519C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500512EBE4;
	Thu,  7 Mar 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij369SYa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793812E1D2;
	Thu,  7 Mar 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819481; cv=none; b=FW4Ff6VRXIET+PMMhIfhmKIy5e8YdmiRcoVy6flh6tHl3zXVmZdY2XBqW3BKPILzi/XqVp1wgmxLZo9IiUczmNyNsyClZebqvQmL134WeP6zDh3nx+DCj8VG/C32Tfmx2OgQT/QiKfjSsI16ZskjH9ilWGJKJBRtth5oyh3DOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819481; c=relaxed/simple;
	bh=ygVU4Yd+yAg3WNCryrpv6ThnAM7OpsqhmDWwhxQC6j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHvMfiE2uSzFa1aFZkSZ54R3Eb3SsVuC0G7jD1Wz/6x+EsF1VA60MCWujdyQMUHhqXX7fMCPaWIJbC7bBIjQ7n8aZVypLFMuVZT2N2Ct8A4v+MZ+05l0c7QxtD7MYD3mTLhfUz5CWgHHB7lctTHeXxcXZ8qu/GwbFqt65UNU2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij369SYa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709819480; x=1741355480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ygVU4Yd+yAg3WNCryrpv6ThnAM7OpsqhmDWwhxQC6j4=;
  b=ij369SYaO2ccAUAy8iPLs2xhCRKvq1hFwXJ5u017Mu/wDXur2pibfFr3
   IwD/uBauP8QgjIqzqjmXaPMLKxNCVKEwgq4J3dIV6YqenvSMpV+/wFisC
   9b1x7aAi6by8AB583R5gIfnsfb5JYZ/8LDSrhDGob2OV5AWGzMPJPvKNO
   jQdcciWQbCM9IFR0r3eW/lAIf8D0AYjrS1YOdoZmVyWzVHZwLblvUIEM+
   sgQahTqhFDt3oUGbW5N31zWTRwlesT7iJf0YaCr1EW9wF1N7qy8EcQZzs
   yeYpyxokneQMVhGCtXQCxYUsXDVRZnEQEAGSApOHWeSwkmvM2uNj8B5UU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="26960350"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26960350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937046160"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046160"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 05:51:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 052F23C0; Thu,  7 Mar 2024 15:51:10 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 1/3] ARM: pxa: spitz: Open code gpio_request_array()
Date: Thu,  7 Mar 2024 15:49:03 +0200
Message-ID: <20240307135109.3778316-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to prerare for removal of gpio_request_array(), open code
the latter. Note, we are not using gpio_request_one() as it's also
deprecated, hence reducing legacy API usage to the very basic ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/spitz_pm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 8bc4ea51a0c1..03b4b347f11a 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -35,18 +35,20 @@
 
 static int spitz_last_ac_status;
 
-static struct gpio spitz_charger_gpios[] = {
-	{ SPITZ_GPIO_KEY_INT,	GPIOF_IN, "Keyboard Interrupt" },
-	{ SPITZ_GPIO_SYNC,	GPIOF_IN, "Sync" },
-	{ SPITZ_GPIO_AC_IN,     GPIOF_IN, "Charger Detection" },
-	{ SPITZ_GPIO_ADC_TEMP_ON, GPIOF_OUT_INIT_LOW, "ADC Temp On" },
-	{ SPITZ_GPIO_JK_B,	  GPIOF_OUT_INIT_LOW, "JK B" },
-	{ SPITZ_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
-};
-
 static void spitz_charger_init(void)
 {
-	gpio_request_array(ARRAY_AND_SIZE(spitz_charger_gpios));
+	gpio_request(SPITZ_GPIO_KEY_INT, "Keyboard Interrupt");
+	gpio_direction_input(SPITZ_GPIO_KEY_INT);
+	gpio_request(SPITZ_GPIO_SYNC, "Sync");
+	gpio_direction_input(SPITZ_GPIO_SYNC);
+	gpio_request(SPITZ_GPIO_AC_IN, "Charger Detection");
+	gpio_direction_input(SPITZ_GPIO_AC_IN);
+	gpio_request(SPITZ_GPIO_ADC_TEMP_ON, "ADC Temp On");
+	gpio_direction_output(SPITZ_GPIO_ADC_TEMP_ON, 0);
+	gpio_request(SPITZ_GPIO_JK_B, "JK B");
+	gpio_direction_output(SPITZ_GPIO_JK_B, 0);
+	gpio_request(SPITZ_GPIO_CHRG_ON, "Charger On");
+	gpio_direction_output(SPITZ_GPIO_CHRG_ON, 0);
 }
 
 static void spitz_measure_temp(int on)
-- 
2.43.0.rc1.1.gbec44491f096


