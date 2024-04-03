Return-Path: <linux-kernel+bounces-129606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96E896D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA40F28E314
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC41411DA;
	Wed,  3 Apr 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EO1b2UZs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563D1419B0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141319; cv=none; b=kt8BwfoL/eaFNmYE7nPHalP/ncK6MvFLEbzhtFicYO/u/t7Xi5Ea25a2yo8ontsF3FLPivCJNNIBK7Hu13dJDwwmhJ2N91gsqoLwXDvDDLuqG2bkavFY1c36Fld++TGkUPzLHQLYM7pj+fuF2Xb+SXP8b2i+M4y3tkWu/WS0HgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141319; c=relaxed/simple;
	bh=1t6+gvF/y1g4r3/uIO4V9puoZcuC9KmFRjleUIoiJJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se0DpdWfzZabs73qhaoOPz2MMl7V+e50ilGnKhaHPrAzEJzfAQGU6QAxpD/WLaKKfAc5ObMKCdiNFDts36Ele4koWLgDYsSPqqpo8yH/RUJKNeA4k8dZexMT0j7Uwg/yvgGm1E+38jVsMweYygUbf8+YFbG/dkkM3cu2QJ5PqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EO1b2UZs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141318; x=1743677318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1t6+gvF/y1g4r3/uIO4V9puoZcuC9KmFRjleUIoiJJg=;
  b=EO1b2UZsXpdYHpKdWtS5ZT8LRQMJUoAStIiEFOH8muJKSnpBjYFHmQxG
   JdkNB7P97J2wQe/aCakSKRS4jG1WuszaO53RNaSjvrRpa5dKtv/TKT+Cl
   Kf+NmkVW9vUSlNEsmCVb9ZEf8gi/oa27w6uqH/8nuEowApyTKc9GzMODt
   Sm551X5hUA8xrBGO9pqUbUjqPmhDilnPzKNspDoreNKPJo2Pi7LbY2TLd
   ajLSTojCny3k5r0MAY/q4oxrV3OtJlUSU+ruu1Qd7oMg1hZa7B/SqQg9o
   fu0rbqW69lxTuPfyMLp8ap9SPL6CdbrbebPLNRv/WifBC53ZuKJlWVyeI
   w==;
X-CSE-ConnectionGUID: fOqb0LdoRaeQu9LqFc+qfQ==
X-CSE-MsgGUID: 8jW4hTBqRMaX2So10ofJHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10333419"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10333419"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084884"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084884"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 03:48:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5DE9357D; Wed,  3 Apr 2024 13:48:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 1/2] devres: Switch to use dev_err_probe() for unification
Date: Wed,  3 Apr 2024 13:46:56 +0300
Message-ID: <20240403104820.557487-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
References: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_*() APIs are supposed to be called during the ->probe() stage.
Many drivers (especially new ones) have switched to use dev_err_probe()
for error messaging for the sake of unification. Let's do the same in
the devres APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/devres.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index fe0c63caeb68..27f280a39dca 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -125,12 +125,13 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 	resource_size_t size;
 	void __iomem *dest_ptr;
 	char *pretty_name;
+	int ret;
 
 	BUG_ON(!dev);
 
 	if (!res || resource_type(res) != IORESOURCE_MEM) {
-		dev_err(dev, "invalid resource %pR\n", res);
-		return IOMEM_ERR_PTR(-EINVAL);
+		ret = dev_err_probe(dev, -EINVAL, "invalid resource %pR\n", res);
+		return IOMEM_ERR_PTR(ret);
 	}
 
 	if (type == DEVM_IOREMAP && res->flags & IORESOURCE_MEM_NONPOSTED)
@@ -144,20 +145,20 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 	else
 		pretty_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
 	if (!pretty_name) {
-		dev_err(dev, "can't generate pretty name for resource %pR\n", res);
-		return IOMEM_ERR_PTR(-ENOMEM);
+		ret = dev_err_probe(dev, -ENOMEM, "can't generate pretty name for resource %pR\n", res);
+		return IOMEM_ERR_PTR(ret);
 	}
 
 	if (!devm_request_mem_region(dev, res->start, size, pretty_name)) {
-		dev_err(dev, "can't request region for resource %pR\n", res);
-		return IOMEM_ERR_PTR(-EBUSY);
+		ret = dev_err_probe(dev, -EBUSY, "can't request region for resource %pR\n", res);
+		return IOMEM_ERR_PTR(ret);
 	}
 
 	dest_ptr = __devm_ioremap(dev, res->start, size, type);
 	if (!dest_ptr) {
-		dev_err(dev, "ioremap failed for resource %pR\n", res);
 		devm_release_mem_region(dev, res->start, size);
-		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+		ret = dev_err_probe(dev, -ENOMEM, "ioremap failed for resource %pR\n", res);
+		return IOMEM_ERR_PTR(ret);
 	}
 
 	return dest_ptr;
-- 
2.43.0.rc1.1.gbec44491f096


