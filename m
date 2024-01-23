Return-Path: <linux-kernel+bounces-35075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E464838B88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B120F1C22299
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7835C60B;
	Tue, 23 Jan 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWpbcT8j"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64785A784
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005005; cv=none; b=oVJ3ZyYEYLHqxoOAnEOsyFo07D9L/MLehENIpR6//553nPLKOZ+aNB56cCMm9vW991e0ZxcKfs/EioJQV9qraJYOlmV1xkEmxpZueIJRCOwjcRnzrtqNyV08ECzdXjxmc+pLGUstGXUlN6TS1ULQUGzUKC/u1CtchEYQaneINRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005005; c=relaxed/simple;
	bh=7muHkE1cUkSSeR+RpQkM/dqAaGPD92XQ9cr6XmMCYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agfgD0XyfTV4U92Zcbf7rFtho5bXddiXuD3FTJ+7M1T5QGwz43jl3DI37831CWxVokj4UbES7u2VTGUN68L2VjB152GOcljVhQ5+Se8pQ/+rnn7rV01cjDxJ/mkLBBUSudTWQnKZBB/QbeK35EBoCimodVSDK4wBq3oAahwvAiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWpbcT8j; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706005003; x=1737541003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7muHkE1cUkSSeR+RpQkM/dqAaGPD92XQ9cr6XmMCYOo=;
  b=GWpbcT8j/eItoNAEEL4vAFvPBTIzUu3QJtH+K43bW+sVR/vUOcQjvrKq
   /MaeKaSCxZaeizt00UinHBmKvnFKH+aZKEtvRXj8isY8nntnXIGCN+TX1
   bDvdYvd3PdLJQvv606Gu6FVhF20m+9J1vr9yxHII0XUttkmClmBOuJtZT
   qrbjTZ7Eq3WbJZ05EKhu9zsf8tcJXYbOLQNV/9WXIj4GtaVlG7cSSLt9g
   5MyqX8IGRwtR63S/gz/ZyeoDVIO6uSKsEPs9f0IYdlviu/iScGoENjjou
   V9LEoe+XiZCFOSevGc96MaJY93y0LkEPfw1jLh0TkspsQ3n1lcoGBTqWa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391900193"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391900193"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1549616"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:41 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/5] mei: pxp: match without driver name
Date: Tue, 23 Jan 2024 12:16:23 +0200
Message-ID: <20240123101625.220365-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123101625.220365-1-tomas.winkler@intel.com>
References: <20240123101625.220365-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Xe driver uses this component too, but current match function
matches by i915 driver name.
Remove dependency on i915 driver name in component_match function.
Use PCI header information to match Intel graphics device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 787c6a27a4be60f9322c6aad..b1e4c23b31a32957c616f0ed 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -13,6 +13,7 @@
 
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
@@ -225,12 +226,21 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
 				   void *data)
 {
 	struct device *base = data;
+	struct pci_dev *pdev;
 
 	if (!dev)
 		return 0;
 
-	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
-	    subcomponent != I915_COMPONENT_PXP)
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+
+	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) ||
+	    pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return 0;
+
+	if (subcomponent != I915_COMPONENT_PXP)
 		return 0;
 
 	base = base->parent;
-- 
2.43.0


