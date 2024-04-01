Return-Path: <linux-kernel+bounces-126960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6252894500
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F092822DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E24CB4A;
	Mon,  1 Apr 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YE8JTLwS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0A29CFA;
	Mon,  1 Apr 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997366; cv=none; b=jt3B9tsVYwHzlwA2eGVjUq9beUCqCDCWej1QvyxmU+/Vc2ILcwB0VC6OraQegi0Qkuwq9RzSCBct6UJxtQ8WE6yAA5fBZTsILH2ySySqbAr7oBPhuXSfmcN19rR866gTcRxnAa+UvXoE9JKLU2mT59pEUwzucV4Fzy3egvfBLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997366; c=relaxed/simple;
	bh=dhzgP5tGqsDZAqQpV2ACbY9ZWCO+7+2cvORqMJH8bb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJnjXdqrHUot0AbNWzFcK/HZcOWeh5CyNSxH3d2HCZkYT1xpKgSCJo0L7j6BMh+M2IjcE2MFhb58CQDRUaB92eUpxWazoPXGUyMhPtDSSbfu3ohv1TgRdgudH+fCwbiaAOQsIGCNEeL2J5lnNkPJOhjoM4xCuASvJlkg5tWBjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YE8JTLwS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711997365; x=1743533365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dhzgP5tGqsDZAqQpV2ACbY9ZWCO+7+2cvORqMJH8bb0=;
  b=YE8JTLwSQbWMtUITfXfmxZnMqBxHG/J644VZ6e43eYfO3aB48eDFWI+V
   GEIcvi3JxWy8F0F9X0ybjArO2qVKasVbyVgF9LZn8XxtvMPYDWjiaI1UM
   WZ9hcBa9IyQqqCrriDmop7JetuYzhEhCfWD2y7N3vzDJ1XoSAZuBDGdp8
   nfkoNgeBXyWpi9+mWXpoSjqms2ptiDb6z0gr91oXK4Ct5ALDGjF1GaBJq
   /rJu2CiNRZsZfmn51XGSnF6z+Jt1KPQ4o9aLUR6wACGYyugOTUA/fXWHD
   sEK5RC9gVuX3i9xoeo25mERW+uY693sR1bTXC4ijACWWZAmmaj1e4cAj5
   g==;
X-CSE-ConnectionGUID: stVCNAONRwm0BfWu1k5TXw==
X-CSE-MsgGUID: DQz9P4tYR1qVpKVpwAdOag==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="6972767"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="6972767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18426873"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:49:24 -0700
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
Subject: [PATCH v2] fpga: dfl: remove unused member pdata from struct dfl_{afu,fme}
Date: Mon,  1 Apr 2024 14:49:15 -0400
Message-ID: <20240401184915.714603-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The member pdata was added to struct dfl_afu in commit 857a26222ff7 ("fpga:
dfl: afu: add afu sub feature support") and to struct dfl_fme in commit
29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature
support"). It is set in function {afu,fme}_dev_init() but never used.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
- Remove unused member pdata from struct dfl_fme, too.
---
 drivers/fpga/dfl-afu-main.c | 2 --
 drivers/fpga/dfl-afu.h      | 3 ---
 drivers/fpga/dfl-fme-main.c | 2 --
 drivers/fpga/dfl-fme.h      | 2 --
 4 files changed, 9 deletions(-)

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
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index a2b5da0093da..864924f68f5e 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -679,8 +679,6 @@ static int fme_dev_init(struct platform_device *pdev)
 	if (!fme)
 		return -ENOMEM;
 
-	fme->pdata = pdata;
-
 	mutex_lock(&pdata->lock);
 	dfl_fpga_pdata_set_private(pdata, fme);
 	mutex_unlock(&pdata->lock);
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index 4195dd68193e..a566dbc2b485 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -24,13 +24,11 @@
  * @mgr: FME's FPGA manager platform device.
  * @region_list: linked list of FME's FPGA regions.
  * @bridge_list: linked list of FME's FPGA bridges.
- * @pdata: fme platform device's pdata.
  */
 struct dfl_fme {
 	struct platform_device *mgr;
 	struct list_head region_list;
 	struct list_head bridge_list;
-	struct dfl_feature_platform_data *pdata;
 };
 
 extern const struct dfl_feature_ops fme_pr_mgmt_ops;
-- 
2.44.0


