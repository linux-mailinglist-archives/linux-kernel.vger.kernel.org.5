Return-Path: <linux-kernel+bounces-70676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C582F859B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69AE1C213AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86FB610C;
	Mon, 19 Feb 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMaEw+r/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AE5220;
	Mon, 19 Feb 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313938; cv=none; b=F/liB8MPTv0RXupzGjg+Dl5JYbk6H5zONtQZI3IgjBmaDvi2Tb6x2lAZkRzQkEkuK5paSRtBhgsJ2mXb3mY+NRmEqw4Zgbbvzu0ALImd7UNkSSGjrHQfIEV+NOVLoSlkLL4tLvDcvkIICpVf9BeEQk/Rrd4lQoIyjhOpQGqhTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313938; c=relaxed/simple;
	bh=IdENPDV8Ed3IxJBmvwAplc7Nj3XPC3wlnxCHbUH17Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwAzeW0fZOIRxWDnaD23jqQtqBKc44TOUqqvlVtSbnb/2sYqFs1ycrCIJgFRgw7O+iSGeF22GbOzltDNfJ+pHKyrsXtBJGY5dCLbWzqjgidYez6MDgSr9IlPrmWshbt/wg3C8zNSXFj3Z0pfAUvfLu11R91ESx2mWIoN9quqUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMaEw+r/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708313937; x=1739849937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IdENPDV8Ed3IxJBmvwAplc7Nj3XPC3wlnxCHbUH17Uk=;
  b=lMaEw+r/6C//tX4SV90OZr8PniIh3H2iwSAnKOZ1XxGFklTKkJp3Cv/T
   OAT2GiFcqImTEH1WINsyGSyjLolNXtvnijq+vnKUiyJyt4CiLgt7QwUmy
   kzz2ZGpcOq8Jt5u37NXnfU+2DaM1pPWS/gxTv+Q0dUejKBqrZZMXhPs6d
   FkkwCIHBCdzNs1WHq36s08/BiZAaGm0aFokydKrY4Aqx7BVbYTPAaGVJ4
   K9YiLPelYkuJf8jXXY4JE0EpiaWA3KOXwcSCpVF+tbNXv2LLxDQQCFfps
   GLiAIi2MRtiBQwujHpAyb7U4sduXcXsR1Wrka0nUFlZjmIj9di9EdUOH1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24838167"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24838167"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 19:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4281849"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2024 19:38:47 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id C557071913;
	Mon, 19 Feb 2024 09:08:45 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id C2BE11600101; Mon, 19 Feb 2024 09:08:45 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 1/4] pwm: dwc: Fix PM regression
Date: Mon, 19 Feb 2024 09:08:32 +0530
Message-Id: <20240219033835.11369-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240219033835.11369-1-raag.jadav@intel.com>
References: <20240219033835.11369-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While preparing dwc driver for devm_pwmchip_alloc() usage, commit
df41cd8bbcad ("pwm: dwc: Prepare removing pwm_chip from driver data")
modified ->suspend() handle to use the pwm_chip as driver_data for
accessing struct dwc_pwm, but didn't modify ->resume() handle with
relevant changes. This results into illegal memory access during
device wakeup and causes a PM regression.

Fix this by correctly accessing struct dwc_pwm in ->resume() handle.

Fixes: df41cd8bbcad ("pwm: dwc: Prepare removing pwm_chip from driver data")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 8ca1c20a6aaf..c0e586688e57 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -95,7 +95,8 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct dwc_pwm *dwc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-- 
2.35.3


