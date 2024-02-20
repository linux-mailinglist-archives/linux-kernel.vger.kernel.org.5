Return-Path: <linux-kernel+bounces-73632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414385C558
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1974285DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48714A4D8;
	Tue, 20 Feb 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIjbzs4q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F014A0B7;
	Tue, 20 Feb 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459235; cv=none; b=d/IdyTdzuzPPDnCnD1DGrfT/n1BNt61EH2WHUMbsq2u/QdYR4DC+GWVrnd+2szyq+/UVheTnzb72eqp4/COR7Mvj2xUMOeXoqVSNTsAVk3bQP6veyu2TY/kv0A9DMMtyEEljazBfuJMUv4ixQL65+yxty8NwV/4ZrDRdZUryQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459235; c=relaxed/simple;
	bh=URWZUOhNI0sexKyZTlxTZyLbnP+v/ASOl1Dy/F0ps98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFn0srJI5M7yAlCtFpMJocUwbAIMO8n04pTgkISH6eDOvnw/E/xsL2bOC25iDyvXIw4VWIfP9AKS6XzC//KcpAWnOdimm5Jsfy+Vw4/KU90FEV29jyoaQZGJXyAt/ziLZnlXMdNK+CvKpERGkK/N5wVy3zDWl0BDfLCwrVOiwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIjbzs4q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708459233; x=1739995233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=URWZUOhNI0sexKyZTlxTZyLbnP+v/ASOl1Dy/F0ps98=;
  b=nIjbzs4qRKEyTrWDV/i79ppuwsQBj6dyH5m7j/kDq/EiR10obwBoTmwm
   Gc7WLn8OW6mCi3Fq5J2rpFU+B4HClue9Xpd2VpGFHp2QomqD2yW1GNmmH
   htySgMNUKrRTWcBTql89XPdKinlQeyg+IofFxBDnB/IwvIWZc6pCOjWpU
   nmkvVO2jm39y/dQCsZH2GNdL6oinNPFt7DZ8bOscKQCRDLQHOL4nq8Emk
   24kiyl70bQkzWo+ej3OGHo8L3Ij38nSiIc/WWbN1KBnIpS7GhaUInQkBN
   DSeSpbF5qxQx8sR9Gai2rbJw0hEGE2vLv5L6dYKQrus7XngFQkGFXsP9y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2449882"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2449882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5043148"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:00:30 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2] mei: gsc_proxy: match component when GSC is on different bus
Date: Tue, 20 Feb 2024 22:00:20 +0200
Message-ID: <20240220200020.231192-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

On Arrow Lake S systems, MEI is no longer strictly connected to bus 0,
while graphics remain exclusively on bus 0. Adapt the component
matching logic to accommodate this change:

Original behavior: Required both MEI and graphics to be on the same
bus 0.

New behavior: Only enforces graphics to be on bus 0 (integrated),
allowing MEI to reside on any bus.
This ensures compatibility with Arrow Lake S and maintains functionality
for the legacy systems.

Fixes: 1dd924f6885b ("mei: gsc_proxy: add gsc proxy driver")
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: Add reference to fixed commit
Requires 'mei: me: add arrow lake point S DID'
https://lore.kernel.org/lkml/20240211103912.117105-1-tomas.winkler@intel.com/

 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
index be52b113aea937c7c658e06c..89364bdbb1290f5726a34945 100644
--- a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
+++ b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
@@ -96,7 +96,8 @@ static const struct component_master_ops mei_component_master_ops = {
  *
  *    The function checks if the device is pci device and
  *    Intel VGA adapter, the subcomponent is SW Proxy
- *    and the parent of MEI PCI and the parent of VGA are the same PCH device.
+ *    and the VGA is on the bus 0 reserved for built-in devices
+ *    to reject discrete GFX.
  *
  * @dev: master device
  * @subcomponent: subcomponent to match (I915_COMPONENT_SWPROXY)
@@ -123,7 +124,8 @@ static int mei_gsc_proxy_component_match(struct device *dev, int subcomponent,
 	if (subcomponent != I915_COMPONENT_GSC_PROXY)
 		return 0;
 
-	return component_compare_dev(dev->parent, ((struct device *)data)->parent);
+	/* Only built-in GFX */
+	return (pdev->bus->number == 0);
 }
 
 static int mei_gsc_proxy_probe(struct mei_cl_device *cldev,
@@ -146,7 +148,7 @@ static int mei_gsc_proxy_probe(struct mei_cl_device *cldev,
 	}
 
 	component_match_add_typed(&cldev->dev, &master_match,
-				  mei_gsc_proxy_component_match, cldev->dev.parent);
+				  mei_gsc_proxy_component_match, NULL);
 	if (IS_ERR_OR_NULL(master_match)) {
 		ret = -ENOMEM;
 		goto err_exit;
-- 
2.43.0


