Return-Path: <linux-kernel+bounces-48361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C24845AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2061C29046
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D457F62172;
	Thu,  1 Feb 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeU8em/U"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741E5F49E;
	Thu,  1 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800008; cv=none; b=n7PRdFvyhyN4dg5cw4/NCHYq0mZErVsoW+vZRH5DfxpqtyfevctH0PlvWI0vVYLLQfGxIr0Jo+Q9Enzrcj+ce2bw8aqg8yZo8EQqsgVLfhJWHLF1CywWRq3ooYcixHiYe5//6EAeCRgKG9oakYsyY4yYQCmCoTtDmVScmxJSErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800008; c=relaxed/simple;
	bh=/1j+vi+oEj44XXlvg/40fPSK2wRNZe9074gxBAtD/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcaLaXNnBsRVIKRfA7pFwFvmFgit8x5tTvs6RuiHm4laIgaJZFzwR9MCUxv3vIQzVQ7qbJtUbZdn1hRq5Nx2LcXq4FalFumFYzxpcrUqPfjsSsSVBbEa/UHXfRXw2sm/pXzXjEfWm+NrmmwtNmRt+Dl9X6118fFbseWv6hBkYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeU8em/U; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800006; x=1738336006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1j+vi+oEj44XXlvg/40fPSK2wRNZe9074gxBAtD/qk=;
  b=WeU8em/UrI0EG4w4hlJjI8uxR2C1YOf6+4hjvT6lhbZbbZFOB+NLbxKr
   WcCfKxr1K3gOjt7l9rH1vqefNpPIPQpEtLOyQw6mt38fKxfk4biMulH8/
   lTx00jlnNkWvFl71LIlAFhdRBkNz/PVBBKeNYtL0YT3Th+NNgtX0F4Cr7
   GPU7q95uACqBlQtjjNPayznVKHOgSM1jsvdhNqBxwWs5q0OT4cQOVbb+Y
   vmAcJpgFGgC3GXrljChQKUY54OZtRh+aiT3jCZUOoPV8zWjka1n5NYe0g
   6f5NpfAWgrZ0tzEsqLVOhH+0WViUzmP7YPz05LwUgKstl9yWqutLLXIR1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403525495"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="403525495"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="859168147"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="859168147"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2024 07:06:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0E35EB84; Thu,  1 Feb 2024 16:49:53 +0200 (EET)
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
Subject: [PATCH v2 3/4] backlight: hx8357: Make use of dev_err_probe()
Date: Thu,  1 Feb 2024 16:47:44 +0200
Message-ID: <20240201144951.294215-4-andriy.shevchenko@linux.intel.com>
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

Simplify the error handling in probe function by switching from
dev_err() to dev_err_probe().

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/hx8357.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 81d0984e9d8b..70a62755805a 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -579,10 +579,8 @@ static int hx8357_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(&spi->dev, "SPI setup failed.\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "SPI setup failed.\n");
 
 	lcd->spi = spi;
 
@@ -617,10 +615,8 @@ static int hx8357_probe(struct spi_device *spi)
 	hx8357_lcd_reset(lcdev);
 
 	ret = init_fn(lcdev);
-	if (ret) {
-		dev_err(&spi->dev, "Couldn't initialize panel\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't initialize panel\n");
 
 	dev_info(&spi->dev, "Panel probed\n");
 
-- 
2.43.0.rc1.1.gbec44491f096


