Return-Path: <linux-kernel+bounces-32290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4883598F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539DAB21A12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BB1FC1;
	Mon, 22 Jan 2024 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3n6ufZI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49867139B;
	Mon, 22 Jan 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892575; cv=none; b=SUxoWODzqaCm8StZOLHU7O4f1XKXExj7PzNuUAMOoOUxF/zFoclYY9CrrYCAelsnI8iw05EtUcaPMDcxl2awE4QtefIa5alhykLn//9TSITqxb9emzN4nlEOiR0Rye1feRGa6khnxS+klQ3ac3TJs0SSyKVvWxeZ/+EwMMVdlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892575; c=relaxed/simple;
	bh=xXgc14YVJHCCXERS4eQXjRO7DnYkSw+VIjrQ5G10S6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6aIGh8y3BRuE9qIQJottR8RuW4y2HfnHiy1qGthxEEI4xUpPOSZ8VY+G9DxmYF+AnmSz+BG5vsGOM1XYH0dwl2UifD22Q/+Tn14depvgmQZkpY3pIONA3uX8HKVvnNsCoDY7TtmeYUG8K5BzW6Dja6z50CLXJyMxlYHuFAL67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3n6ufZI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705892575; x=1737428575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXgc14YVJHCCXERS4eQXjRO7DnYkSw+VIjrQ5G10S6o=;
  b=l3n6ufZIdeWo6updMVGtFHJhY8qibh7qlaUyv+wmdOZmsLewhLIwh4AR
   fMjTXDm5b9gkNdq5zR8qQvG4hVFqnY69BO7x8vM/0PcyjZL9QvrhqcSD8
   yBuvqZmodR0cybDY/iwFMR3auM1qs2tHI51CDIAfM6ChqaiqDL0nHEoSu
   NBIOjR62P4ALaeBpAW/oMAjosp+WcUutGUownejUVub0bnjjnSEQwgRQB
   d0QeRtyx+nvMKwco2FsTJLnLmfVGdIrbUms9YspfmWYETx492Eme0XxxE
   UhKKPeJzDx2iCl0Pga06WuCB1xfalJ6XXRjpUrwo57tNUbwSH5lHIo+Ch
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14607323"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14607323"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 19:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1085521"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2024 19:02:42 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 218854851;
	Mon, 22 Jan 2024 08:32:41 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 1C4E11600102; Mon, 22 Jan 2024 08:32:41 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/3] pwm: dwc: simplify error handling
Date: Mon, 22 Jan 2024 08:32:37 +0530
Message-Id: <20240122030238.29437-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122030238.29437-1-raag.jadav@intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
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
 drivers/pwm/pwm-dwc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index fd64313cb38d..8f8035b047c1 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -68,24 +68,18 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	int ret;
 
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
 
 	base = pcim_iomap_table(pci)[0];
-	if (!base) {
-		dev_err(dev, "Base address missing\n");
-		return -ENOMEM;
-	}
+	if (!base)
+		return dev_err_probe(dev, -ENOMEM, "Base address missing\n");
 
 	info = (const struct dwc_pwm_info *)id->driver_data;
 	ret = dwc_pwm_init(dev, info, base);
-- 
2.35.3


