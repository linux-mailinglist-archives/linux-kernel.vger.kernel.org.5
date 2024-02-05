Return-Path: <linux-kernel+bounces-52724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6E849BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0E1F247DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692112C68D;
	Mon,  5 Feb 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiDeMxQC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145372C1BA;
	Mon,  5 Feb 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140119; cv=none; b=X2CMXt+UV99a8zWqRNShlcHc1ykO0/H77HvmymO1nJm0vsSpg5LnNHWLbIC/augHk3KXIniy1W6O+u1ZvsPwKhl6HZGI4oDp5PKPoNTXHjHBOsN+fRFmD1/ZPbpEWCRoN+xcy042nQKBXS+PFHk4fdb5O92525s+ZhMQr4cVsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140119; c=relaxed/simple;
	bh=JPdk+Lb9y/P3Nc1X0LzlAL+t7jsIt4F4AidZQorL+eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbzmdGXmY3nLlMGUPnch950+TVAlEDWvC7lSXiW8bOU68cMbvnlYU0+xH5NvNysz+RULBmRoNI3l+JuGoVkwMkkzPh9u4GcCiHxIBMo4U/t58W9MZfIMesQn34oRqBsLkKZQzaII8yg+YNHo19e7TpaQzIhJJO5fgXESa9OYkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiDeMxQC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140119; x=1738676119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JPdk+Lb9y/P3Nc1X0LzlAL+t7jsIt4F4AidZQorL+eU=;
  b=WiDeMxQCxNFU6bVzFUr1v7ALuo5q5NsI6vOZ/a/s23OmLGBg62kNgAgB
   VFtcya12OImy3qgVOZ649BGVevEtkmeARsBE9K63lDRAoGz60I6HALPVd
   U1Dj+QkAX2KoaIueh7qofi0iobB9EjOT0Q+WuLD3+0tpGFWymBTENHc5W
   8WT60f1m3PJyD3FGSFfQ28IlxB5XxtZJ/y+AWZtvO0ImKvX/UOQXojBrA
   XcYVJDorwGNdx3WtF9lm3KWAQwOgQt7SFvRc7RO3iHmigFykcQVlmRvVt
   zv0czQXQfyjGcFO5w2NsVcPxYtAZ7dZckor8QXeqBzyVAIjm4zi6Znwhh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="690053"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="690053"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="923228"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
Date: Mon,  5 Feb 2024 15:34:48 +0200
Message-Id: <20240205133450.5222-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com>
References: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcibios_plat_dev_init() is called from pcibios_enable_device() that
should return normal errnos, not PCIBIOS return codes. In this case the
impact is only cosmetic because PCIBIOS_SUCCESSFUL equals 0 that is
success code with errnos as well. Nonetheless, remove the inconsistency
by replacing the PCIBIOS_SUCCESSFUL with 0.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/pci/fixup-ath79.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/fixup-ath79.c b/arch/mips/pci/fixup-ath79.c
index 09a4ce53424f..6a6c4f58f7f4 100644
--- a/arch/mips/pci/fixup-ath79.c
+++ b/arch/mips/pci/fixup-ath79.c
@@ -9,7 +9,7 @@
 
 int pcibios_plat_dev_init(struct pci_dev *dev)
 {
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-- 
2.39.2


