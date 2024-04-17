Return-Path: <linux-kernel+bounces-148338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8388A8120
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB5B1F21F56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477BF13C912;
	Wed, 17 Apr 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDyVyMiR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860B13C81C;
	Wed, 17 Apr 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350318; cv=none; b=lc5eYdOrWk4v7GMN9d3x03qZyXVXgvXyBOd2NN8zt4VXF/pK2Z8zkzq5YmaEuJucyvrw5hylBZPOpMDsDGBrjcPuZkL8X+YESv5L5j/t2vgM1yiihNm3DW8RP/rcP8jBlpT8rmZ2Ci65AtFcQyiDcQ9PIp4NXEqsOl0M3J9rFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350318; c=relaxed/simple;
	bh=aymlhITIYRfBYJcXpouBx8T2TCewuPCFC4Acl0FuqQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/+TfX+YJF4TdrVkiOVSnVMbqNCN3RLr6sJEDekVytBs+5AYbh87HswliyudYMpIxutblVxzwJZpfdhzEO7LcClpfPQoetm1AlkuGxL0iXcvGH64vSwbRiKOAfD3u+NaOG/vEDuBAr3SmkcGLhpyeC9kKARqjLIGnPNn13AUJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDyVyMiR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713350317; x=1744886317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aymlhITIYRfBYJcXpouBx8T2TCewuPCFC4Acl0FuqQk=;
  b=IDyVyMiRk9mk1KKscshzE3nqkBd/mmTQqsMLtTOC4JYEGDaHMMwqS9Tm
   kko3lasm+m0Dfe8XK391WUxewnhK9hKk8CTJvnlgbSnRxtAP4PbASkgKE
   9Vv1y3bE0DlUga+zaOA/YEOFHyLz1sS+Fq9esdqiMf/ePoc9KGWXe9rvO
   0XcVclZyIaXDu3GTWudkTV4vURHSPX8ijUpbC78+KZjX/8DSwwCI2uWP9
   qOMiiFOhj2j/xRYAX5PizKS2jbsuppnnu2MQ7sQ5mBIiujDnoYUCe2n+i
   +UaJNUZe+Mc5dazXRxPRHFgOPcMJMbaVRB+hRjGlr2HBNyqCfiVwvKsUs
   Q==;
X-CSE-ConnectionGUID: ZQJwm657SraP0SP/SwLzDw==
X-CSE-MsgGUID: RDPH5BMnQFGj8+3fWwAGGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9384045"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9384045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:38:34 -0700
X-CSE-ConnectionGUID: OGHSCL+ISH2et9QRmcE5pA==
X-CSE-MsgGUID: VGVs0J7LRryQZmLtw+XHoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27257839"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Apr 2024 03:38:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A03DCBCD; Wed, 17 Apr 2024 13:38:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpiolib: acpi: Set label for IRQ only lines
Date: Wed, 17 Apr 2024 13:37:28 +0300
Message-ID: <20240417103829.2324960-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When line locked as IRQ it has no label assigned. Assign
the meaningful value to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 0b0c8729fc6e..553a5f94c00a 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1066,6 +1066,10 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 			acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
 
 			snprintf(label, sizeof(label), "%pfwP GpioInt(%d)", fwnode, index);
+			ret = gpiod_set_consumer_name(desc, con_id ?: label);
+			if (ret)
+				return ret;
+
 			ret = gpiod_configure_flags(desc, label, lflags, dflags);
 			if (ret < 0)
 				return ret;
-- 
2.43.0.rc1.1336.g36b5255a03ac


