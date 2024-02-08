Return-Path: <linux-kernel+bounces-57543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E3884DA88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC11D1C235CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7A69E0E;
	Thu,  8 Feb 2024 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaetkHb0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3169305;
	Thu,  8 Feb 2024 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375947; cv=none; b=WuFoJu9sY5HspJXXTcyNQdePGOErgDIIvJPEHpZ4ATGlC7ZzWAgwP4KiMBypAPfoaTTndpBo0yktRkVubvmv2tkCLU35w2g15OuLW+6eQPsdz61ECbMbbGKb3pPq176aINoqJFXlEAUst8qABjLZhT+SKE0n6YsvxeSsrYkZpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375947; c=relaxed/simple;
	bh=Eq6BsNBRtBO2MQjyFEfYn5pR3BjbzZoHasX7K4WnV5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmCbjZgypClPpks43HcGMb+gySZgP6CXU13SntnM0/TXJgcnQfmgqPWrFwKsGd1MydduIzGgIFmch86P/g1bKv07TWu2fgUjrYv7VFeg8ZYuBgmbMI/2S/uHC6W54TmAwP87USxflcTmvptP9ymcnqubHKk7NQ072JU27Xafd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaetkHb0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707375947; x=1738911947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eq6BsNBRtBO2MQjyFEfYn5pR3BjbzZoHasX7K4WnV5Q=;
  b=AaetkHb0tgPlx2qsaH5wLTWvy/kirZcxzOutRu0wbuYekGu17GAPlE+l
   USjL6Ad5VLOFdMJl0D8FmqUonUz2F/9sQGH5qF9bY/ReY2473/lZN23t5
   Y8n1d6fNtWFe4+tR1Z+aXIS+nMnFVLfFWB2xIp0KOdg6CByj9vlBWq+CG
   +rQr7BXhsWd08btcgc664Wz5pm+6OG/ZJhx5E0PHCPW0exBZzBMTXd/yF
   0hqbxgyu7RtK2lsh0w8nprwFXZef3cizdHKkgjBz5i/9wgB2/xwiuNAY0
   oPQG/1Wq1G/OjduIFbvXm/dG+WeX8OhWVbxUYtv3FQO3uWjXtyw7dEswB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12525868"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12525868"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1573962"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2024 23:05:36 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 523D314354;
	Thu,  8 Feb 2024 12:35:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 5220E1600100; Thu,  8 Feb 2024 12:35:35 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 3/5] pwm: dwc: simplify error handling
Date: Thu,  8 Feb 2024 12:35:27 +0530
Message-Id: <20240208070529.28562-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208070529.28562-1-raag.jadav@intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify error handling in ->probe() function using dev_err_probe() helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 47d76f5367fe..e1e3c62ecc56 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -51,18 +51,14 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	int i, ret;
 
 	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable device (%pe)\n", ERR_PTR(ret));
 
 	pci_set_master(pci);
 
 	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret) {
-		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
 
 	info = (const struct dwc_pwm_info *)id->driver_data;
 
-- 
2.35.3


