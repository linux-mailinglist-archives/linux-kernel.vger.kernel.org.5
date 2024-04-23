Return-Path: <linux-kernel+bounces-155529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45018AF394
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACE4B24E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B313CA98;
	Tue, 23 Apr 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCTq3ph+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9413C66C;
	Tue, 23 Apr 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888676; cv=none; b=Tu/daoEUfN/Lt/GVUoher226ybqsF95/0TPa7Mn/3k0qqperuRLCX8lTUKm+ReOIZEV87C/cQb6NzeWe+aJYNAiolkOL/hRGAvKutD5XCTrCL2x+CFjg8jh3zyeaBN9tkstfx2SEkUblUBx1YeK/RTV6/9bYTH6Xmkwu2GaMx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888676; c=relaxed/simple;
	bh=uEH3no9t++z1xFSJQIOH7n+SYQJxYhyMCfAnzUjmRiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7XbxYaVNPtpNj5Dd4qvtVSku9N4H1Fogji7sZdtdrfwitR4a2+7iJ2rpMkdbhuyD3CCBvMjTjUQl6j+uxo8tmuJrBMfjgPiiefzsmP5zMn6o5g95+iltImNsJX2hpbdxiix1n5R4OvuB9Z6v37ltC/6pwQ5AwXcbTVITKKZJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCTq3ph+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888675; x=1745424675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uEH3no9t++z1xFSJQIOH7n+SYQJxYhyMCfAnzUjmRiM=;
  b=GCTq3ph+VUsIrt+/eO3INSwN8tj+RmgUkhfDi/rVznuGoVjB7XaMdynD
   GSmEjVhdPz3xaGEht2uk3/V2LoNbAX+zmmD/2+QDepx3vEXAeSl2H6JZ5
   3xrYYVojxmLlsO1k6VtQTr+5GBcBDVPlViODRDWbx8y17EN612wfC3tuo
   Me7ENZydVwUqyWeBwpXwGxtduFLhggjkMtBOSqUPibJCbwizNkLZbzXO8
   I/0YDIwTkxxb1+1SpNpKtg3crPDSYkHBFMkaDSSN7zscb1jdOiIl2awiS
   MvzuAeEWTamsFDhvnexW5cNFHuD2VrFQomC835aF73hQqhKFticW2X02C
   A==;
X-CSE-ConnectionGUID: QK/xEWAGR0KRmzjDIdKzgg==
X-CSE-MsgGUID: DmRUgBC6QT+V8kewQ3Iftw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26941098"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26941098"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:11:15 -0700
X-CSE-ConnectionGUID: gNhNYmRkTwCrInkPMY4zdA==
X-CSE-MsgGUID: k46LZnUxRvWPWItLF72aPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24933923"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 23 Apr 2024 09:11:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 09222192; Tue, 23 Apr 2024 19:11:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] platform/x86: classmate-laptop: Add missing MODULE_DESCRIPTION()
Date: Tue, 23 Apr 2024 19:09:51 +0300
Message-ID: <20240423161108.2636958-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o

because there is a missing module description.

Add it to the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: alinged text with Kconfig entry (Thadeu Lima)
 drivers/platform/x86/classmate-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 87462e7c6219..cb6fce655e35 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -13,8 +13,6 @@
 #include <linux/input.h>
 #include <linux/rfkill.h>
 
-MODULE_LICENSE("GPL");
-
 struct cmpc_accel {
 	int sensitivity;
 	int g_select;
@@ -1139,3 +1137,5 @@ static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
 };
 
 MODULE_DEVICE_TABLE(acpi, cmpc_device_ids);
+MODULE_DESCRIPTION("Support for Intel Classmate PC ACPI devices");
+MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1336.g36b5255a03ac


