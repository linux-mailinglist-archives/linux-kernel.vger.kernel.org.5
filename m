Return-Path: <linux-kernel+bounces-95458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F7F874DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765061C22054
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBB12881C;
	Thu,  7 Mar 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pu5WJbmY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3D126F39;
	Thu,  7 Mar 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811836; cv=none; b=FjdZf2MslTcwfMwqf3+NetMAObtx5ddMkHxl4CBOXkpbEqMONGC/TtFcW8rmkTUXpolVVpUFTmSjEGV/Ku4yDRkPa8W3KC/GKkn9rOTMKg1uLeCi9Qfo6ucQfksMGrVfahTAuA7NrtBOvgJn1N7QvI1cETvthqcjWSWUSzFb8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811836; c=relaxed/simple;
	bh=/WKZb4T8n+V6qspYzWiivDs83Rn6EvfqGQ+VXYpTh3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuq0t9hENFdSxaJkSzrKHr8pgPYDrhW69xTyKHnHGndp7ZuO5GlUJgHPqI5E+6e1VayPA2CyNDKf2Vgn4ov7XJRgE7Qq2c/6le6s0i/yjltiYjHUuQzBEV8v0MvItTgqCjHGl+2IP10HJJ0/Ob6haXz5r94rq0zLKD9CZjODC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pu5WJbmY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811835; x=1741347835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/WKZb4T8n+V6qspYzWiivDs83Rn6EvfqGQ+VXYpTh3U=;
  b=Pu5WJbmYwTNtI5CNmKqteRsLs3aUhT5e4AEICPpEoEb77xDWdUVXkpbc
   aIHBBk9CiRXhkWc+uyyCSC3QH2mjagC0dmYP2HopQc07UESi7EsnIMIbl
   H79GDCC/aBPs8wLQuRpbYEkVO0obN3whoUA/BfjwfyBaI7j0WYGx7CdMS
   /7yPVjGjFXQKBkAXIVH4jWTPS04EsWYC1jtJRkBWngVe2Gb4rvCir9wfr
   J1gCvFdWTLCSHGaeF2P7iFQoG0QhwWahv8J4EsJlCe/PdPJycM0l1PVX0
   cnS678lkWYeAzsvRxZA6bqPBAUVRixe+EE56Tq/UKaeHBPswV0dOLt9/K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15119964"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15119964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045880"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045880"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:43:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C2AAE193; Thu,  7 Mar 2024 13:43:49 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Axe Yang <axe.yang@mediatek.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: mtk-sd: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:43:48 +0200
Message-ID: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
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
 drivers/mmc/host/mtk-sd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 1634b1f5d201..a94835b8ab93 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -13,7 +13,6 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
-- 
2.43.0.rc1.1.gbec44491f096


