Return-Path: <linux-kernel+bounces-48407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2F845B8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF436B2CD2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A0161B4E;
	Thu,  1 Feb 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqKQSyWa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBB779E7;
	Thu,  1 Feb 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801207; cv=none; b=R/eCpKOU75h7cOOU1l1Ll9TJLh6/2dx2VLiDdj9a9wdkUzSm4IoaL28QCxKU5njXu5J4wivwuvb4UOAOla4fj/96puz721DC4gBHlzbJmRAmNUTD1eFuQVEBQE+/7anjiMjmSFFIxgih57k/PddCClaRIV2drKadIF/g817Tz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801207; c=relaxed/simple;
	bh=Crj2Xd5+sjM/WF1/AU2C24hHxy1FDdrAbIh7Rfeop1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH1rQ+HSHNfaxl3Dd6xLv/YBR8ggJ3sTzf3Zis3p+UE3AynCl0Bs1mzq9XJHsrRrIdHNu1seu6igmzt8bQJNOeIOl+19A8fO51Xe9JiQHn09K8AhckMjeZQ/Lp/VMCkGLpk2FJcWCL64mRHm4cJBy9/vyHpLTqvqW/tNoRT7gLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqKQSyWa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706801206; x=1738337206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Crj2Xd5+sjM/WF1/AU2C24hHxy1FDdrAbIh7Rfeop1M=;
  b=BqKQSyWamktiLj9I8CL2YP6m5jb7RZdMsINHVYxz5k0x0JM+IwFkCrX9
   rIYqZMvL9IsoY5R3HIw8QRQpl22P0XIbVJIrrcUzpXYN4F3wdTERD66Rd
   2zJVk8Ef44rBZhCr7/LrptbF7uM4UmIaXjJy4e/Nwrh1BBPpqqVo+NFCW
   /kKKAIhAW9oVPEg0ubgAIC7F1U6kmiY4fgLCfxfyUbszaXrMAZbnVGj2V
   loMwC5LDt/4OOrBTJC/3TJ4CSSWaJU7ClXdWaL/f2SjZjuzOcN9XjRZgH
   A6YM/PWBBWREytR9a9VorZDtvVTDieUYh+8VqYRGqKXS5dzwAcYN1WHSG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="140716"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="140716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908275361"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908275361"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2024 07:26:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F2F7CA8A; Thu,  1 Feb 2024 16:49:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 2/4] backlight: hx8357: Move OF table closer to its consumer
Date: Thu,  1 Feb 2024 16:47:43 +0200
Message-ID: <20240201144951.294215-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move OF table near to the user.

While at it, drop comma at terminator entry.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index ac65609e5d84..81d0984e9d8b 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -566,19 +566,6 @@ static struct lcd_ops hx8357_ops = {
 
 typedef int (*hx8357_init_fn)(struct lcd_device *);
 
-static const struct of_device_id hx8357_dt_ids[] = {
-	{
-		.compatible = "himax,hx8357",
-		.data = hx8357_lcd_init,
-	},
-	{
-		.compatible = "himax,hx8369",
-		.data = hx8369_lcd_init,
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
-
 static int hx8357_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -640,6 +627,19 @@ static int hx8357_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id hx8357_dt_ids[] = {
+	{
+		.compatible = "himax,hx8357",
+		.data = hx8357_lcd_init,
+	},
+	{
+		.compatible = "himax,hx8369",
+		.data = hx8369_lcd_init,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
+
 static struct spi_driver hx8357_driver = {
 	.probe  = hx8357_probe,
 	.driver = {
-- 
2.43.0.rc1.1.gbec44491f096


