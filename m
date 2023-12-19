Return-Path: <linux-kernel+bounces-4667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E4818072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DC9B235B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7705CB9;
	Tue, 19 Dec 2023 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RC1W39pB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112E5380;
	Tue, 19 Dec 2023 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702959752; x=1734495752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i+FYFJiM4zhGNpeoB/MCinogOJYpyspa/zpz16xcJNY=;
  b=RC1W39pBSbAjG5pNRn6rC3qRnWrTIKC8u7B0IkZwQci7n2Dbj1XSdp1P
   yTykm7RgIbb5/S0bUqvaCEFK/20cJCFkYpnaN4taVFwsY5cGGE3m6a1n6
   p5iT6xtCtV0A8sXPFJbgEIteP/DkDWuONMxKN9XLYXKMxVZTR7t2/xFI5
   GM6FlYV+kxBRhg+G+CsdDMb3HRy+LCmR35FO3+bYufay1/MymUHkjQJ3N
   EJMQSxhYeBKPgSdazIhJ4CAko/YqFbde5H0BCZqF0R0VT8oZNURIO6e90
   Hx62t1SrurowJ8dgFrNcBKX1+hs3LvaCird+tYthK7u54Se8XGcL/+eL7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2455971"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2455971"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919503094"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="919503094"
Received: from mnichels-mobl1.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.212.29.225])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:30 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com,
	"David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 1/8] platform/x86/intel/pmc: Fix in mtl_punit_pmt_init()
Date: Mon, 18 Dec 2023 20:22:09 -0800
Message-Id: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

pci_get_domain_bus_and_slot() increases the reference count on the pci
device that is used to register the endpoint. In case of failure in
registration, decrease reference count using pci_dev_put(pcidev) before
returning.

Fixes: 6e7964855381 ("platform/x86/intel/pmc: Show Die C6 counter on Meteor Lake")
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/mtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 38c2f946ec23..fb59dffccf28 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -985,6 +985,7 @@ static void mtl_punit_pmt_init(struct pmc_dev *pmcdev)
 	}
 
 	ep = pmt_telem_find_and_register_endpoint(pcidev, MTL_PMT_DMU_GUID, 0);
+	pci_dev_put(pcidev);
 	if (IS_ERR(ep)) {
 		dev_err(&pmcdev->pdev->dev,
 			"pmc_core: couldn't get DMU telem endpoint, %ld\n",
@@ -992,7 +993,6 @@ static void mtl_punit_pmt_init(struct pmc_dev *pmcdev)
 		return;
 	}
 
-	pci_dev_put(pcidev);
 	pmcdev->punit_ep = ep;
 
 	pmcdev->has_die_c6 = true;
-- 
2.34.1


