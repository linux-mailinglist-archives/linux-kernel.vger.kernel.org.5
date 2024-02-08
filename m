Return-Path: <linux-kernel+bounces-57545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD1784DA8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CE01C24068
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDCB6A039;
	Thu,  8 Feb 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxjZ4aN+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04869964;
	Thu,  8 Feb 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375949; cv=none; b=lthHGhk275qum1ymrjGBZT7wwcAuF8C9dIkJ3Vsh8WLcBULBGpxVfJr64ZUFZUgtSSa5K9PhEoN175icvKFxUy+GB9H2j1kPN9nVYFJB/Hvpkkk43SKaFQgFV8sKuyoZlVhcxmT5n0Y5Uf79+IOSBtcyh+AA2LP+9bC0+TCl3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375949; c=relaxed/simple;
	bh=SLcziUGV3wn1pdz6JlsUPS3h94i8kBpVxgL2aMtWd88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxEEiXObbavEq7uL05ltwupftHbV5NPa+RzjhKhZjQ6z/Mq7SByn59GU+zVYyOSOmRWGfcKQ1h/QLTvI24j33Lx8YVk+ShiVPVe2k35OtSKqYwN/D/e7XxRKDv6VwhScOHs+ynZ+J7osIZwuppQ2jwsXG0Rleq9Op0gsVoTACkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxjZ4aN+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707375948; x=1738911948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLcziUGV3wn1pdz6JlsUPS3h94i8kBpVxgL2aMtWd88=;
  b=SxjZ4aN+vAVuTrJuTlArZV7DBQaEJwoCymTNU/jQQGya7w9z3UPVnd8I
   6A2m1QgLh9NsTxJEAM3quEh0HNCELEG8zCYvZR2hRinVi1Bs00VMKul5s
   OSzPRkd0OZQywGyZITcF/RDl01PZbpDed7sOrWJJ/1p/NJqK0VJqy5e5g
   X27ySGCbXyWZPZCH6s765QIdOmKty4fdZksnCIHfkIO/zQsB6UWxQDJhR
   1lR/lx0ZaPqG+E7EloRPmdXahuSjkDkMVI0HbbfEyMZ9BawjPRBpXrGxT
   jRKjJDZOiTn4oW3OZszbPGnUhaOJ8b5XfDPJfTcgc70PVoTaGI7yA6E1L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12525872"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12525872"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1573966"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2024 23:05:36 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 4E9CB14320;
	Thu,  8 Feb 2024 12:35:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 4C6131600101; Thu,  8 Feb 2024 12:35:35 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Date: Thu,  8 Feb 2024 12:35:25 +0530
Message-Id: <20240208070529.28562-2-raag.jadav@intel.com>
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

pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
check for failure if the latter is already successful.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 4929354f8cd9..596a0bb35c40 100644
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


