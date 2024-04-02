Return-Path: <linux-kernel+bounces-128194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F88957EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C47B2ACD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3A12C544;
	Tue,  2 Apr 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0kqj66T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A35132464;
	Tue,  2 Apr 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069134; cv=none; b=cS/TMeohMzFaSWU9b/O6wcl8jLchYfChZM2irCHDvSixxJ3q/n6M/ABhDo4Vasvsb/C1N7y5hTSqSZvb8SKo8wwyp+EIICE/gZHNLgX/Z041cMp0GhTeq4m3GwXXkRS4+9rOsz2sQ72+a3oJk4EmHqOnfRcWPHEkSZ/n4/ucS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069134; c=relaxed/simple;
	bh=U8zDJrGwvowmpbloCTeIyqdQQakbZMEd/jFHCNTTLss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WX3xxzl9d2Fset36uElg/McBY1R/mZJ+WTv3DNxfpCKJ5yp2Kh24BPrER8IAeIHYGOffXQHBBTOwXuAO0d+ggxu0t5uKCSVlW/F3XEXsxl2+NFzm68E4YQt4pU1is3oC52Dk9zQTRsB1TgrWO+/xN6LKBazYTI1UBSAuQg+1F6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0kqj66T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712069132; x=1743605132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U8zDJrGwvowmpbloCTeIyqdQQakbZMEd/jFHCNTTLss=;
  b=S0kqj66TeD1781/tm/7XMBx0BXWIeEPs7X5JdCJ/LV/2KCgrCSdXZsDn
   01W6kNUV74jaU2t52/oFCrm+CDsLKIGsRuDMXxKvhROb4MuVuxec4o4iV
   Rxxo6p6g409WaoOeca5vpDJdhXMjxt/+pFenoW8C7MhYPBY+YCrKBJwKn
   DK9ISR/6FIgFTKwvd5ltnE+GlmS3jjRfpv6SiXxmGtL4npMFx6y4x/7iy
   b66+Po1E1Q27vBnONZnEWY+fMv9eomZ2dHTH8+dgQ+0Lj2VGkuVL2HbOW
   ryhALfBc1ZfxHmrGax4Q0w4JdVtRticZl/xzQyGKdWLaOzjJVnELmj/G3
   A==;
X-CSE-ConnectionGUID: QE11SRfWT2SN+1+kTMkQPQ==
X-CSE-MsgGUID: nAy9J8YQTTCLK+gYGDkhKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24735380"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="24735380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083583"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083583"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 07:45:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D756E1C5; Tue,  2 Apr 2024 17:45:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: pxa2xx: Call pxa_ssp_free() after getting the SSP type
Date: Tue,  2 Apr 2024 17:45:23 +0300
Message-ID: <20240402144523.3402063-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxa_ssp_request() implies a reference counting, hence the pxa_ssp_free()
must be called when we are done. Add missed call.

Fixes: bb77c99ee6d3 ("spi: pxa2xx: Skip SSP initialization if it's done elsewhere")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 86d0f1064a45..1348249f8178 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1379,8 +1379,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		type = (enum pxa_ssp_type)value;
 	} else {
 		ssp = pxa_ssp_request(pdev->id, pdev->name);
-		if (ssp)
+		if (ssp) {
 			type = ssp->type;
+			pxa_ssp_free(ssp);
+		}
 	}
 
 	/* Validate the SSP type correctness */
-- 
2.43.0.rc1.1.gbec44491f096


