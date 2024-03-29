Return-Path: <linux-kernel+bounces-123850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31140890ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB32E28655F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76225EEAA;
	Fri, 29 Mar 2024 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NR8XmN/L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD233C8;
	Fri, 29 Mar 2024 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670674; cv=none; b=V/Zfkd25XhlACb2rKzp+jPcQYLuaHWuJdGZ4n3LC+aLuEkBllxmVxYgutVxIZwMoNRpALKL0cPXbqFrZt8XGfxdm6hOLknxOU5Xa+Ly0wzwqhhwAD3LctG8peLC30bFP3O6QgmYk/h4hwKW8WKdbWxEAUZ3apbcaX+65tzpwGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670674; c=relaxed/simple;
	bh=Dg9fl2DYKd1S6Bc+b39oiuE3E+1/h1EYnX105Dk0gTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5w01XkdnruQtJXxA+NS4laRFpF+7rsBOL0Li0jco0rEUb6LZm5f6PEG//ZX8TVt0xR6pOPpTjgOnrCmASmWYBaAwttuzwd8f87RcWnpOrjc64Wf1nmqk0x+UAxS1+aKNFBys3PvM1lbjgIIkEFiSi3MFnjFRl862ZStsue2Bq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NR8XmN/L; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711670673; x=1743206673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dg9fl2DYKd1S6Bc+b39oiuE3E+1/h1EYnX105Dk0gTo=;
  b=NR8XmN/LDanRfeeUItwb5wnr0NCLPsAgx8XWGemZiAxq5AIFFQ/dZMpF
   FJvljvPM1JZM5ud50jreliY9dLxe81LKtSwuftth96c1+qOlOQmaVOb+g
   HjA083HpRcAkaTA2uon6X/CRNKhCE2n6+SOsc/rGdzrgmmo9bmTbwrSG8
   r3lYJs6Ndxv45GFuWEZi4zdA0Brb/5ceTZ8dkZBEFnwq6cGFOKsg7wd2W
   uaMtaSn+aV/4sgjei5zJdV/k3od7MShy84dgXtUrS+WN/hDMAWAPfSg1Y
   xlun2lFHs87qo/lsQEwX7ihPs2J5pLgtInJx13E+lXqGe1yvf9ND2MMWP
   A==;
X-CSE-ConnectionGUID: 7aj3kUWGTna2x8EAtX5Zfg==
X-CSE-MsgGUID: kbwlP1uERQ20/jtOqHXhhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="32258456"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="32258456"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="47783336"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:04:31 -0700
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
	Peter Colberg <peter.colberg@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for dev_dbg()
Date: Thu, 28 Mar 2024 20:04:29 -0400
Message-ID: <20240329000429.7493-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Omit unneeded casts of u64 values to unsigned long long for use with
printk() format specifier %llx. Unlike user space, the kernel defines
u64 as unsigned long long for all architectures; see commit 2a7930bd77fe
("Documentation/printk-formats.txt: No casts needed for u64/s64").

These changes are cosmetic only; no functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
This is an unmodified resend of the second patch only from the series
"fpga: dfl: clean up string formatting for sysfs_emit() and dev_dbg()".

Link: https://patchwork.kernel.org/project/linux-fpga/patch/0cffb04a207a98148c61f512aa4dc90880e51251.1687301688.git.peter.colberg@intel.com/
---
 drivers/fpga/dfl-afu-dma-region.c | 14 ++++++--------
 drivers/fpga/dfl-afu-main.c       |  4 +---
 drivers/fpga/dfl-fme-mgr.c        |  5 ++---
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 02b60fde0430..71ed9d394d07 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -146,8 +146,7 @@ static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
 	struct rb_node **new, *parent = NULL;
 
-	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n",
-		(unsigned long long)region->iova);
+	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n", region->iova);
 
 	new = &afu->dma_regions.rb_node;
 
@@ -187,8 +186,7 @@ static void afu_dma_region_remove(struct dfl_feature_platform_data *pdata,
 {
 	struct dfl_afu *afu;
 
-	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
-		(unsigned long long)region->iova);
+	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n", region->iova);
 
 	afu = dfl_fpga_pdata_get_private(pdata);
 	rb_erase(&region->node, &afu->dma_regions);
@@ -210,7 +208,7 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
 		region = container_of(node, struct dfl_afu_dma_region, node);
 
 		dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
-			(unsigned long long)region->iova);
+			region->iova);
 
 		rb_erase(node, &afu->dma_regions);
 
@@ -255,7 +253,7 @@ afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
 
 		if (dma_region_check_iova(region, iova, size)) {
 			dev_dbg(dev, "find region (iova = %llx)\n",
-				(unsigned long long)region->iova);
+				region->iova);
 			return region;
 		}
 
@@ -268,8 +266,8 @@ afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
 			break;
 	}
 
-	dev_dbg(dev, "region with iova %llx and size %llx is not found\n",
-		(unsigned long long)iova, (unsigned long long)size);
+	dev_dbg(dev, "region with iova %llx and size %llx is not found\n", iova,
+		size);
 
 	return NULL;
 }
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c0a75ca360d6..4342d40a2106 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -730,9 +730,7 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	}
 
 	dev_dbg(&pdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
-		(unsigned long long)map.user_addr,
-		(unsigned long long)map.length,
-		(unsigned long long)map.iova);
+		map.user_addr, map.length, map.iova);
 
 	return 0;
 }
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index ab228d8837a0..da3cb9c35de5 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -150,7 +150,7 @@ static int fme_mgr_write_init(struct fpga_manager *mgr,
 	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
 	if (priv->pr_error)
 		dev_dbg(dev, "previous PR error detected %llx\n",
-			(unsigned long long)priv->pr_error);
+			priv->pr_error);
 
 	dev_dbg(dev, "set PR port ID\n");
 
@@ -242,8 +242,7 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
 	dev_dbg(dev, "PR operation complete, checking status\n");
 	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
 	if (priv->pr_error) {
-		dev_dbg(dev, "PR error detected %llx\n",
-			(unsigned long long)priv->pr_error);
+		dev_dbg(dev, "PR error detected %llx\n", priv->pr_error);
 		return -EIO;
 	}
 
-- 
2.44.0


