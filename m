Return-Path: <linux-kernel+bounces-35074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A174A838B86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44741C220DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44AB5BAFA;
	Tue, 23 Jan 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Srg7250C"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12E5A10C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005004; cv=none; b=nLik6Pn2gOXr1vPyxLWZB7r4D0oiJ+JeDbSd65y4A3FzI7VnmYFausKZ6X/emLcnu74oZW65gR8qWbh4JZd0pW28w1o8IzJItvDCZTGBrboHuxxj7AVuTmWTBigH4RrF87WXKnkp4lmwZPGC5Tbk7rtNOcUkN5Y+qPE+wMoVC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005004; c=relaxed/simple;
	bh=AiXwTUVe86OareBY7spE66J6j1tHQF1SwknBobuOe+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ou1sSLvvouEDwsoTdLyXM/wXLD+dHefxrS4rydW7/VszUAzHY97l+c/U/2PVLUcCGIts/nL6t+FkbZvLPkxEoJx/IxiZQPVsALLn8z9ct/8UyDqlKKKo0A9mGmAvDTrkexIQsFDa8r20ZXtBgP17A+kiK8wCKqvHe6xb4AwV3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Srg7250C; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706005002; x=1737541002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiXwTUVe86OareBY7spE66J6j1tHQF1SwknBobuOe+g=;
  b=Srg7250Csic02if+mvntG9x40U+rRgFqD47vAL6FA8OW/tpHHoN3voT1
   O4TNhhCZVIl9Jx+s4K21sjlDPkAFCOtLcGTODhj+VcWhVlQ7FIi93R3Tu
   fowyidu1VaZR61yXzSqWuDoLa+FeTb42sanGHXBR7KXFgYJ6Sb3H2ZLOq
   ZSjN/Im+hUHrBTPCPEgcqqbL+x2CPWAGus3qVjObiGxqzNKeDNcloorl4
   iGsmUqgXYfsr6YdkGh9cKyXNsXJQ3L6EM00S0+RI0SZpSgFZvb7akEumS
   BF7rATIqlaGGDLGuerVyKH9EaTAldktLz3Chok0AGJ4YOSKlEYSLeuhza
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391900167"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391900167"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1549607"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:39 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/5] mei: hdcp: match without driver name
Date: Tue, 23 Jan 2024 12:16:22 +0200
Message-ID: <20240123101625.220365-2-tomas.winkler@intel.com>
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
 drivers/misc/mei/hdcp/mei_hdcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 51359cc5ece9a109d1d3dc96..f8759a6c9ed331f2316cb6bd 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
@@ -781,9 +782,18 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
 				    void *data)
 {
 	struct device *base = data;
+	struct pci_dev *pdev;
 
-	if (!dev->driver || strcmp(dev->driver->name, "i915") ||
-	    subcomponent != I915_COMPONENT_HDCP)
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+
+	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) ||
+	    pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return 0;
+
+	if (subcomponent != I915_COMPONENT_HDCP)
 		return 0;
 
 	base = base->parent;
-- 
2.43.0


