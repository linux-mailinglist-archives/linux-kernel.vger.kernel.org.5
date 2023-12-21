Return-Path: <linux-kernel+bounces-8551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3E81B949
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79782B21DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97306D6E2;
	Thu, 21 Dec 2023 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lrq/D0C6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D053A08;
	Thu, 21 Dec 2023 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703167582; x=1734703582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KwEyfYTQR1NbPVQsohEkV2RHgj/9+6Ry7VEJomez00U=;
  b=Lrq/D0C6Y6/9vZz3K1xFaaxTV3S7kY/YAdGTyJhlCSWj6hczw0VXyg6o
   lSkmUhvRdt2PS+z39Wk09H/IVHXoWB8lM7J0Q4PxiY1RLShiWKc/M0a48
   0i9PLXH+tacREIhjc1oPKE9IA7SqikiPFDMRxE2Y5xYwAuVC3BhFEJ69a
   UHP6qDuP98aJheoucdiE6HmwSnTxGDq5ZqpwrGAYNuChVOCJskDTwCX39
   vEV4QESTlF3PONJsGkZSb+ozLNEaU55C9uKy4MCSMUefnp1cLesZzUeWJ
   lYAgcew/7eAr/+m4tC4RQnAGglgO0nbyw4JlvyHAtu36P3Z6vK3F6g3Q+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="398762962"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="398762962"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 06:06:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805612857"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="805612857"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Dec 2023 06:06:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9D6ACE6; Thu, 21 Dec 2023 16:06:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadfed@fb.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] ptp: ocp: Use DEFINE_RES_*() in place
Date: Thu, 21 Dec 2023 16:06:07 +0200
Message-ID: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to have an intermediate functions as DEFINE_RES_*()
macros are represented by compound literals. Just use them in place.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4021d3d325f9..306353a69231 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1716,20 +1716,6 @@ ptp_ocp_get_mem(struct ptp_ocp *bp, struct ocp_resource *r)
 	return __ptp_ocp_get_mem(bp, start, r->size);
 }
 
-static void
-ptp_ocp_set_irq_resource(struct resource *res, int irq)
-{
-	struct resource r = DEFINE_RES_IRQ(irq);
-	*res = r;
-}
-
-static void
-ptp_ocp_set_mem_resource(struct resource *res, resource_size_t start, int size)
-{
-	struct resource r = DEFINE_RES_MEM(start, size);
-	*res = r;
-}
-
 static int
 ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
 {
@@ -1741,15 +1727,15 @@ ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
 	int id;
 
 	start = pci_resource_start(pdev, 0) + r->offset;
-	ptp_ocp_set_mem_resource(&res[0], start, r->size);
-	ptp_ocp_set_irq_resource(&res[1], pci_irq_vector(pdev, r->irq_vec));
+	res[0] = DEFINE_RES_MEM(start, r->size);
+	res[1] = DEFINE_RES_IRQ(pci_irq_vector(pdev, r->irq_vec));
 
 	info = r->extra;
 	id = pci_dev_id(pdev) << 1;
 	id += info->pci_offset;
 
 	p = platform_device_register_resndata(&pdev->dev, info->name, id,
-					      res, 2, info->data,
+					      res, ARRAY_SIZE(res), info->data,
 					      info->data_size);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -1768,11 +1754,11 @@ ptp_ocp_i2c_bus(struct pci_dev *pdev, struct ocp_resource *r, int id)
 
 	info = r->extra;
 	start = pci_resource_start(pdev, 0) + r->offset;
-	ptp_ocp_set_mem_resource(&res[0], start, r->size);
-	ptp_ocp_set_irq_resource(&res[1], pci_irq_vector(pdev, r->irq_vec));
+	res[0] = DEFINE_RES_MEM(start, r->size);
+	res[1] = DEFINE_RES_IRQ(pci_irq_vector(pdev, r->irq_vec));
 
 	return platform_device_register_resndata(&pdev->dev, info->name,
-						 id, res, 2,
+						 id, res, ARRAY_SIZE(res),
 						 info->data, info->data_size);
 }
 
-- 
2.43.0.rc1.1.gbec44491f096


