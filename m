Return-Path: <linux-kernel+bounces-61594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AFC851406
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42321F273C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915F3B194;
	Mon, 12 Feb 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DINeFvUH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64063A8D8;
	Mon, 12 Feb 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742978; cv=none; b=kDNfbQ84feT7OYivBWAeVTVpYcAkoGHD5Owm4bYDYDxDVLnXt1rG160XLGy6xUKgMHzv+1oM2e16e2CZHSZTMu681V+Jz8EqN1a/859SnYO7ZBlGT04qj2XK5l7RnguvrRxNIWKegl+uYIKMrzDSxvn5iF1/2K0zeuDVvRjI6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742978; c=relaxed/simple;
	bh=FOjkuLNdMv7J4yMpAY56PojaEyEBEaN6z3QYgOvwO2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAznzhktiIXrPo7Q3rpMuLpH9ve7wVadFYhV0Rl5LPzxmb0Ugv6K7el+Ob0ldvgT3kEiR3ZW113Aucm+7l7LjQh9eSygi0tldPXZgzoFcp2axUsTyw7gTBIoxjmX66d9sqvMOifjv9YDuP8ecY9cX9MvTbpZwXwCqiRiQ0tAp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DINeFvUH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742977; x=1739278977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOjkuLNdMv7J4yMpAY56PojaEyEBEaN6z3QYgOvwO2s=;
  b=DINeFvUHtG1mPYSJOWIomQz4ZHG/ROVL2nmmD2px5mxlb2YSolm1hVV7
   mUQfvf5vlOgnR4bCv188axvJQd7Q/PKczpWXigrYc9IJjT4XbmgPCzShR
   kpgtcq73V0emfrWovv/u0GfctziYGgO7IQpMLyBlHumqcwyjLl0z5eIZC
   1r6+plvCRVszUAZT+f2/044uBiWQpLmpmkKFvDV53Im4TqETsKVYmI6s2
   J6RMgmCXCG+TFDAjukh7NPLcLc/zr/zMITG+FKQq62KS4nNhBy7MCa4dH
   N2c14ytor43IvtWLoZGFjJEz1Nbphtu/xaV+M0ZAwbMWEpm297aFnPfQP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1594837"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1594837"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33378393"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 05:02:50 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 5854D1CAD0;
	Mon, 12 Feb 2024 18:32:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 546041600102; Mon, 12 Feb 2024 18:32:49 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 2/5] pwm: dwc: drop redundant error check
Date: Mon, 12 Feb 2024 18:32:44 +0530
Message-Id: <20240212130247.9985-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240212130247.9985-1-raag.jadav@intel.com>
References: <20240212130247.9985-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
check for failure if the latter is already successful.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index a4a057ae03ea..b9e18dbf7493 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -50,10 +50,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	}
 
 	dwc->base = pcim_iomap_table(pci)[0];
-	if (!dwc->base) {
-		dev_err(dev, "Base address missing\n");
-		return -ENOMEM;
-	}
 
 	ret = devm_pwmchip_add(dev, &dwc->chip);
 	if (ret)
-- 
2.35.3


