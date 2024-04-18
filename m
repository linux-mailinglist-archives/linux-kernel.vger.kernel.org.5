Return-Path: <linux-kernel+bounces-150422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87428A9F01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9291A2829FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0716F84D;
	Thu, 18 Apr 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKJdUx2H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CB16ABC2;
	Thu, 18 Apr 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455375; cv=none; b=XZjUEzY2EnLkrv1yrbM+dAFiGWBjR+ogmPRbAA0Fdu/I9i9szcITPCnr3EKaN13T3fIemDTqm1UGUons5Z46xgZPrXy21FFkDFJlS4T6MJbfn9dV0OiHf9noIlCwiC3h3QPOevsOurxENwJj3qMLCHNsmTOlvbxmRTeIpcbjdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455375; c=relaxed/simple;
	bh=85KU2zcRBg9J5fZ2/uRgbGWYg14VpgeLBrh4C2KSRZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yba9/xCmrepLpF2LmvCOy+oIHboKjXSiEUcqyOvCu3fKKskKZA6V+gsb+QUQvObWqH6o6boDBoZTpBeQiU2ZcBuJwPf9BzQnI+z8GOQi/Jixxe3q9IcJWZzH9dAUiOg30YaBAmzfnZnuXhkUMNzf1shNYUjvE9L9EwnvPjKucrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKJdUx2H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713455374; x=1744991374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85KU2zcRBg9J5fZ2/uRgbGWYg14VpgeLBrh4C2KSRZA=;
  b=GKJdUx2H0r/uSo3tcukO8TMs6E191DOfTN/k9jEWp3ySwh8lFgefktJF
   a0f1cZyVJwyytF06COJ4+TFDjF2p/lZWraeOLiotzMbGXsKX1qDRft0+I
   p7zkMlxPOUYXtG77ARAPlzFrHsoAwShRCJLczrMbzgU9S/JBAZJjC/dug
   l+A6TKPtUH3uelMaNaG3NTmMHWIH9z2E9A/gfqhJI5W4CfSt4jI2HeyJr
   +uR4WGoKbnLT5Cw6vo6O/mHyD947ubjXrQHQ5v/NgkaPeygUWcWy23Uj8
   YJrPzmTr+NUTiOtV9s6QadCRT6yrCzqcfiP8QnEMgH6y0kR4H+wm89yo+
   Q==;
X-CSE-ConnectionGUID: Y2ZFUzJ8ROK4IKMGHR+/7Q==
X-CSE-MsgGUID: ePyTDbxFSxeVWNZ0lW/jEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12800837"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12800837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:49:33 -0700
X-CSE-ConnectionGUID: i3RzZeZiTRqX3lAxsmkoPQ==
X-CSE-MsgGUID: oTUSXnAqTJ2JPmEFyLNVTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23102503"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2024 08:49:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 85573E7; Thu, 18 Apr 2024 18:49:29 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Niklas Neronin <niklas.neronin@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] xhci: pci: Use full names in PCI IDs for Intel platforms
Date: Thu, 18 Apr 2024 18:48:33 +0300
Message-ID: <20240418154928.3641649-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
References: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three out of many Intel platforms that are using TLAs
instead of the full names in the PCI IDs. Modify them accordingly.

This also fixes the logic of grouping as seemed to be by an LSB
byte of the ID.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 93b697648018..70bf318fd7ef 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -45,8 +45,7 @@
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI	0x9d2f
 #define PCI_DEVICE_ID_INTEL_BROXTON_M_XHCI		0x0aa8
 #define PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI		0x1aa8
-#define PCI_DEVICE_ID_INTEL_APL_XHCI			0x5aa8
-#define PCI_DEVICE_ID_INTEL_DNV_XHCI			0x19d0
+#define PCI_DEVICE_ID_INTEL_APOLLO_LAKE_XHCI		0x5aa8
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI	0x15b6
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI	0x15c1
@@ -55,9 +54,10 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI		0x15e9
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
+#define PCI_DEVICE_ID_INTEL_DENVERTON_XHCI		0x19d0
 #define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
-#define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
 #define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
+#define PCI_DEVICE_ID_INTEL_COMET_LAKE_XHCI		0xa3af
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
@@ -356,9 +356,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		 pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
 		 pdev->device == PCI_DEVICE_ID_INTEL_BROXTON_M_XHCI ||
 		 pdev->device == PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI ||
-		 pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI ||
-		 pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI ||
-		 pdev->device == PCI_DEVICE_ID_INTEL_CML_XHCI)) {
+		 pdev->device == PCI_DEVICE_ID_INTEL_APOLLO_LAKE_XHCI ||
+		 pdev->device == PCI_DEVICE_ID_INTEL_DENVERTON_XHCI ||
+		 pdev->device == PCI_DEVICE_ID_INTEL_COMET_LAKE_XHCI)) {
 		xhci->quirks |= XHCI_PME_STUCK_QUIRK;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
@@ -367,14 +367,14 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_APOLLO_LAKE_XHCI))
 		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_APOLLO_LAKE_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_DENVERTON_XHCI))
 		xhci->quirks |= XHCI_MISSING_CAS;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-- 
2.43.0.rc1.1336.g36b5255a03ac


