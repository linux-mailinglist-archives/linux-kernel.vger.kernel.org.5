Return-Path: <linux-kernel+bounces-91023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A66870890
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBA1F22B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262861669;
	Mon,  4 Mar 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Anky6rmU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7F612F6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574560; cv=none; b=mnhkP4WWATzkbc4vBqLYaEHMcDgqvLR4s1ZpW+/mjxZ+bNILG7FthAcKnSVr8ZXiEunbgs9u0oLovlBS2lsuzxrsz98fQtGzHX6YOPOw+DaLwi+Y5v2w6bXprXdaaidKeykSkQK5/R109OuYvaokbZm4cDK3DaICYDRK50SKsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574560; c=relaxed/simple;
	bh=9Cfbvu51C5Vp1BAZIJWdCwFRnEaK07EuG47zkS+ieTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+q8oBHmaN8DBu5foBs6MlTOs6xJehFy6evO1q7iwmLKf5i3BVFc7jdtKP8lCySKXWv5HCzX/5Bm/JBYe7QEQYy3tvkn1nvO6xMgZqEugWIuMjZou0Zu6XPxjjXqM2AI7JXB0+l2EO38jPCGIbYQKvaHirtBS5eTefoLwSi5uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Anky6rmU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709574558; x=1741110558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Cfbvu51C5Vp1BAZIJWdCwFRnEaK07EuG47zkS+ieTI=;
  b=Anky6rmU+7GyS/jCHN8J7DN2+Sh6/aTOdmKyZcpLY6WhZ5rbgpOyTZ9m
   afRiOnhuYnWcDpCh6P/8Ve4Cmcf5tvR367xtOZlS5Yvh5km3B6TslSqRy
   wKbvmRi3Y7twFqKxnzfxkJAToQIvRGjID5SAeBZTxuKnI5oIE7Jqmp2Ib
   IZuvosBQ7p4g8dKIicDGuSr7kTUpBB8so0bItru/1bL02POa6HSN1mt98
   yfdtF6cy9CJEAojFYJkW8exOr68XGpZ/Q6zhYepBPYqISn5a7gddNG3jL
   yoctCTxPxoY8ohKM9BWCVy4I1jBByCTtIwvOwvKY+y2ZYmii7eDA7yB0j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4209444"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4209444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040904"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:49:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3376715C; Mon,  4 Mar 2024 19:49:15 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stanley Chang <stanley_chang@realtek.com>,
	linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] extcon: realtek: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 19:49:13 +0200
Message-ID: <20240304174913.1198974-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-rtk-type-c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index a592bab77538..19a01e663733 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/syscalls.h>
-- 
2.43.0.rc1.1.gbec44491f096


