Return-Path: <linux-kernel+bounces-58028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAF84E06E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E27B2516D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF871B47;
	Thu,  8 Feb 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW1SfG+j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142F71B41;
	Thu,  8 Feb 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394224; cv=none; b=sBxfaK5aI392R31TMTnCxIZpaDBIFTzUHQqq01h9hIvgtSLcd06WCq7qrseVD/40BGwITrPnnjYwVahNfJX0jnWSKaAtfMfs0NS7hutMYLuG1VmtbHMmIVstzGILBChhruiP47XhzBJ8VipS8qZ9xVYgbqjJZ/loXYaflXvGCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394224; c=relaxed/simple;
	bh=JPdk+Lb9y/P3Nc1X0LzlAL+t7jsIt4F4AidZQorL+eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEB6kCqdZu5yebB4xOSrDbw0SxG/DoB+S+du5eFzTKH6LtCAzM9zpo98528Rq4ppO2dLDkOjlp6scwmzuh3P2QXlUgJlk6yQs0JLWNAdhIUQ/mDHnWyCICU9b+UlOdM9ydvZr+IWlus47WV3ZJc3jQKWIZmY5SvcTBbtcDtg0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW1SfG+j; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707394223; x=1738930223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JPdk+Lb9y/P3Nc1X0LzlAL+t7jsIt4F4AidZQorL+eU=;
  b=CW1SfG+jfDU1PP14CM2wroyUCTmSr7SCkhTgBk/SaEyVQrSl8R3jD5/j
   5Pngr7RKaQNmZ95cCV84lYDJsBdQXBd7XiCJEJU9LldffxQDGXe/R7GSc
   2Nm75ZgVsSBqLyPq0gZdk5Q1gR9MWT4o0pYHTEQdyhLgkqlH7dT5uT/HI
   Ttbmi3EqGtSg3kxEW0UtVndx1fg8lLR0SdgHxOkxV0IiAqPfK0r3d+ywE
   OaypUek0AQPzw3tNABnNv56lyyBWjKVjsSPQDe2AOTvKvEVNk0gulpXZd
   V+GNG/Z3gsj8bHTMmzNqyPqeR/3IjPU6myp5wp+vchd0VpGPDWiHG2R7v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1341322"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1341322"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1625945"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/4] MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
Date: Thu,  8 Feb 2024 14:09:57 +0200
Message-Id: <20240208120959.2513-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
References: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
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


