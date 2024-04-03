Return-Path: <linux-kernel+bounces-129616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586DE896D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E671C20A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3814386F;
	Wed,  3 Apr 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9JMqndl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0C136989;
	Wed,  3 Apr 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141718; cv=none; b=QWPyfKefLta1MnOFvHlbwiRDmOWFyyjjWm9t5jq2HF2NJlAtbHWMq5ZdWTCeIhf7LIK5MIIvJ7JvZ/us7DlHaPLw79zEfqbijY1l+RLE3dG/Nnos6ppET06mTvTw70phW7GFlh8RRvD8NtwMAl7c/4lj1IIskJnJrf61PFNL5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141718; c=relaxed/simple;
	bh=lrJ50ChqWjiafdbnGjnP1GXQZSC7KNkvDUoe1E9xguc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWnV+vk3/D5eWtoHjM8QBSPzI+OklLqujoGPs69w0lFyBuMQI7hpBWtmsh/fEvylvi/WR00N9iub+QNnBpsjpNYcqSwKPEMXHUBNTyOyEde0wJBIX+7rT6KK2Z8lJXoWD2N+TiZ+ETOy4RSA2+oUs9XFrZs1AsGbzHQ7691wK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9JMqndl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141717; x=1743677717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lrJ50ChqWjiafdbnGjnP1GXQZSC7KNkvDUoe1E9xguc=;
  b=O9JMqndlTOdhPqc3eqyF+I4ysJdzgP2tc4ZymLxojX23VYrpZmehBJO/
   wzth97j1lca02Oss8Z+Gs9VOphMz5+zCn1fWrXeEV/eGWhdIdzvRLwN/2
   7NQ0Ox/EfOQdJQqlG0ABZk13FhtrN15K8X8RmsVNz50RP8q96WVyK9eYb
   /X4YD5XlHhqxUX7crC7QKcFkYku+vBnon+piSkcF3hxHsaUS4By8eyfh6
   rFY8BORYAHFm9CJ09QheqpLDV/rINYXAFWoJsKZ0PNFaflYuDdj0LSoIZ
   KptZpSV1OT+1Hokek/JsJXXtOsvuYcIn++g2Np6vziSzEul198UrGSIfL
   g==;
X-CSE-ConnectionGUID: +ro0M6pDRpSLMJkZbXAFFw==
X-CSE-MsgGUID: S7gZBttxQuC1vIEwMgTNgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10334263"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10334263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084887"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084887"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 03:55:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3A4A83E5; Wed,  3 Apr 2024 13:55:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86/intel: atomisp2: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Wed,  3 Apr 2024 13:55:11 +0300
Message-ID: <20240403105511.558395-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UNIVERSAL_DEV_PM_OPS() macro is deprecated. Replace it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/atomisp2/pm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/atomisp2/pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
index 805fc0d8515c..1081b632bd5e 100644
--- a/drivers/platform/x86/intel/atomisp2/pm.c
+++ b/drivers/platform/x86/intel/atomisp2/pm.c
@@ -118,8 +118,7 @@ static int isp_pci_resume(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend,
-			    isp_pci_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend, isp_pci_resume, NULL);
 
 static const struct pci_device_id isp_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0f38), },
@@ -133,7 +132,7 @@ static struct pci_driver isp_pci_driver = {
 	.id_table = isp_id_table,
 	.probe = isp_probe,
 	.remove = isp_remove,
-	.driver.pm = &isp_pm_ops,
+	.driver.pm = pm_ptr(&isp_pm_ops),
 };
 
 module_pci_driver(isp_pci_driver);
-- 
2.43.0.rc1.1.gbec44491f096


