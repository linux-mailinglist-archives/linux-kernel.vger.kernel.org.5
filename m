Return-Path: <linux-kernel+bounces-123845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82360890EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FFF1F2435B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFD139D05;
	Thu, 28 Mar 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7gKyT9a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265431327E8;
	Thu, 28 Mar 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670069; cv=none; b=nfAe5oy2FThajhtCcMsfoObKMkqOrqE5kfrDnyEsyWQXFuIy0gTPIzHMNbfCwnak4cvhpYZ1wfVaOiQyMYmz3m5/YBylXBurvahuwzx0ShbOINHSofEfsAmHBcJorc4u5l0ikMvcS0mbAUTNSoa+/mZpzvYbVw4mGJRebFm+sHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670069; c=relaxed/simple;
	bh=0a/JttK+vrimsYXSmeHsRxr/Kb4SAPuXAYPxku8wU94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdON5pRkZP7AdWzE7dkTm4C9A4g8rOI3Y1MfyL9bqiUErjkexI0q+SixsaovoFxyot7CjjW0CvStSKnp7/kM6cdD/doGlCzOMI6ZOx7SGoqlJfCWrsRIZ0zwMpcJUgSoaq300QArlECjmKHcIy+hin67mQgWeRPCA6SqqlZ1bRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7gKyT9a; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711670067; x=1743206067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0a/JttK+vrimsYXSmeHsRxr/Kb4SAPuXAYPxku8wU94=;
  b=M7gKyT9a8pu0oO0Gbwf69XC/ewvjvlNPJQpBxD/d5BwhsJRwqfwEmf3F
   VEfLujGt6hHl/iAffHTdU+6sProycbjtQciId7ZtXtii+wAP0RvfSGHv0
   JLHjHctxwR27D5ifT9vrvbjknMlj9gc5+wpqQO58lr7yMGoDSV6jjcWm4
   iP5BnLe7vE9OJZWKOZvtzU3wNTBnG9etYhVx9ZBId4vu8ScgA1dpsWcwm
   M+OvKtIXScumWtOJZXH/96hgU2KGcTigKPfsRZpaJZgpkU0Ev55jwy4wx
   /Lm2IpNMF3dkp5ljQuxuSeKb2SGIR/Upm/wk5jeYMJDcIQl2EtWFIxvnX
   Q==;
X-CSE-ConnectionGUID: McMet731Siy2/7WVw47Tfg==
X-CSE-MsgGUID: Z+UrZa6MQ4KiRDLy14uNSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17579986"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17579986"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 16:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17209958"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 16:54:25 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] fpga: dfl: afu: remove unused member pdata from struct dfl_afu
Date: Thu, 28 Mar 2024 19:54:17 -0400
Message-ID: <20240328235417.7219-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The member pdata was added to struct dfl_afu in commit 857a26222ff7
("fpga: dfl: afu: add afu sub feature support") and is set in function
afu_dev_init() but otherwise never used.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-afu-main.c | 2 --
 drivers/fpga/dfl-afu.h      | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c0a75ca360d6..6b97c073849e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -858,8 +858,6 @@ static int afu_dev_init(struct platform_device *pdev)
 	if (!afu)
 		return -ENOMEM;
 
-	afu->pdata = pdata;
-
 	mutex_lock(&pdata->lock);
 	dfl_fpga_pdata_set_private(pdata, afu);
 	afu_mmio_region_init(pdata);
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 674e9772f0ea..7bef3e300aa2 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -67,7 +67,6 @@ struct dfl_afu_dma_region {
  * @regions: the mmio region linked list of this afu feature device.
  * @dma_regions: root of dma regions rb tree.
  * @num_umsgs: num of umsgs.
- * @pdata: afu platform device's pdata.
  */
 struct dfl_afu {
 	u64 region_cur_offset;
@@ -75,8 +74,6 @@ struct dfl_afu {
 	u8 num_umsgs;
 	struct list_head regions;
 	struct rb_root dma_regions;
-
-	struct dfl_feature_platform_data *pdata;
 };
 
 /* hold pdata->lock when call __afu_port_enable/disable */
-- 
2.44.0


