Return-Path: <linux-kernel+bounces-70675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB56859B09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CC3B2131F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD95234;
	Mon, 19 Feb 2024 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKzljqlJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D84C75;
	Mon, 19 Feb 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313936; cv=none; b=Hz1rC99ZdrVvZmyyP/aNQF74erhbiHF08+CHJWHkbzVQZx99rSy8XLlo3c/E3sk60qHBg8QFGLSV/2pkMRBHg1zjiAItwKWzOFSYvHoJlR+gAHcVuI3rJQSLGlURBuN9a0kpY0Ec3iRnM/Hyffgdo5/Y4S5R8Se/dA1i1jQPD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313936; c=relaxed/simple;
	bh=RIlqr5IIc2NcV+R4QbrZ4SeTtXAfOYhjo+jbzFUSD3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Et7QhdS9ubzWRqfEwynEeTRtQJFmRhc60h+RsJB7i8rD+In9YuAtPz9pTac2xxR2PzqwCJSWAsfOu/M8G8KzKFirRJC4/vm34LM0dNKM2+IQ8sVNEjL2S9ktl1VpGF+xsuvmDZo5fFJOJqMhT1om1pfD/HQq+W6jhLLkz9xpmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKzljqlJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708313935; x=1739849935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RIlqr5IIc2NcV+R4QbrZ4SeTtXAfOYhjo+jbzFUSD3o=;
  b=aKzljqlJeRDBAEmSHE/MnO6HUXmaKvMbpuC128fAQhQaRYP8iEC5iAGv
   xFSDZ8z9b8eUPthtuvqst7kBtFN5TfnOS8KJEMRHrOWM+27DFlUhQWzVm
   xhwzLrRO3VvkTkz4t760RAX79lDd+VKehDUVLM+yFjRlT8igSYikjVCrA
   0dM7ffQP0+vG+m90gmpGQDASKhVzcFC/NqeSKYB8GpaBMpK6IVCfSpIox
   AhJ6wB2mrmT3fI9KTZfP/AM6bKfNWrh6oFBlXPSM2yMGbGvGxiQ0rG80w
   SoSmzTgwjo29rSoXKO3CSXwVifC1lpkwnfOoqJLLj61JmgvhbhlrlEr9p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24838171"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24838171"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 19:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4281846"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2024 19:38:47 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id C76AA72ADC;
	Mon, 19 Feb 2024 09:08:45 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id C30251600102; Mon, 19 Feb 2024 09:08:45 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 2/4] pwm: dwc: drop redundant error check
Date: Mon, 19 Feb 2024 09:08:33 +0530
Message-Id: <20240219033835.11369-3-raag.jadav@intel.com>
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

pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
check for failure if the latter is already successful.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c0e586688e57..7dbb72c80ef5 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -51,11 +51,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return ret;
 	}
 
+	/* No need to check for failure, pcim_iomap_regions() does it for us. */
 	dwc->base = pcim_iomap_table(pci)[0];
-	if (!dwc->base) {
-		dev_err(dev, "Base address missing\n");
-		return -ENOMEM;
-	}
 
 	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
-- 
2.35.3


