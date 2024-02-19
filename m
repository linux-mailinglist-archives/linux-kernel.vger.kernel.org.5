Return-Path: <linux-kernel+bounces-70679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49630859B11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF68281F31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A0F9FA;
	Mon, 19 Feb 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNi0CWEk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE5567A;
	Mon, 19 Feb 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313940; cv=none; b=se9K3nmXuTr3rlmSNrwz6YgLKNEzSpvwPGjzDL25fX0HqVEkFxx9meINx9L9MQIHJLsjOAyz2/f74gqwtGbwHse7/imLKXkjFEqlNJtVGFIlg2YUHVJRo9Rz866ZM8pCmGradVBZfDVgOz/37TyavuNgUTfjs2m2Ze1DoQkoqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313940; c=relaxed/simple;
	bh=KW3Rg0hKJSlekLEkpQDUS0ofXFzF55PYH45WySuASc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/XONEwqP9oQm6qkSxAuS2cdwpY1ihLjkHSGWz/kZYujjTeqz7CRVetPGw7XrJvakzF0xPulA1fxpzVIKtH297pzOL3NL9JrpCLYxVnoOy9wUbDDC2pOiuWR0NFXYzffdgV0x9/WTiVrBNNKgn4H4tcWy9krs4CcvzME7CYLAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNi0CWEk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708313939; x=1739849939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KW3Rg0hKJSlekLEkpQDUS0ofXFzF55PYH45WySuASc8=;
  b=TNi0CWEk6xm+S+41ucxbmeNGFts0WZK62fFQ6RrlppT2/xV4saVm9LPP
   BTm+By3Iv0qMqy2R2Uti99j7pJ3x1mWAmJA2IdmdodeklGlmiU/GxWE/0
   PeF5Gpe9xSMCEisD9yN3CtENJrFLEfa1/K1OZcZzkHKERdKh5tQlBbcZi
   Zwnbzh/fb28GC3k4g9dICI+yP68AR9icc92vvsgyl7pIstzFYuP/dG4S1
   DjGLzZWy7jkJRn1ZX53zrpX3oosywpG864yr76sqrd8i47E9UFoO3iIRx
   EEwmnMfyWQgyHiZpso++oV38SnetccTV/1qiRo10Fso8+Naj7hOoIM8VX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24838178"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24838178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 19:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4281850"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2024 19:38:47 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id C89BF72DF7;
	Mon, 19 Feb 2024 09:08:45 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id C387A1600104; Mon, 19 Feb 2024 09:08:45 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 4/4] pwm: dwc: simplify error handling
Date: Mon, 19 Feb 2024 09:08:35 +0530
Message-Id: <20240219033835.11369-5-raag.jadav@intel.com>
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

Simplify error handling in ->probe() function using dev_err_probe() helper
and while at it, drop error codes from the message to prevent duplication.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index de95352081fa..676eaf8d7a53 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -53,18 +53,14 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	int i, ret;
 
 	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable device\n");
 
 	pci_set_master(pci);
 
 	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret) {
-		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");
 
 	info = (const struct dwc_pwm_info *)id->driver_data;
 
-- 
2.35.3


