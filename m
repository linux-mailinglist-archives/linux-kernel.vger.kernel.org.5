Return-Path: <linux-kernel+bounces-83789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13278869E76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C651C23830
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2F1482FA;
	Tue, 27 Feb 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3AIRstB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058634EB46
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056763; cv=none; b=aubSFgBaiypqkDHIJvomIozE55/iSxQvayDK6fL4Gtr+BqY8wCkmfTT8OyLLh3seZKDCioPlGPkVfGHTtKGf9gY4lRSTryN5URQV7ENyRNjixt+E1shQXzj4ttKw7k5uuXS3lN2dAtztyF5WJpMhVSHTPcfALPZmPiOLPwaF+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056763; c=relaxed/simple;
	bh=S7gy7CPHZvEztwdvm1D8suyt5zFSEhNklWiuAuwuQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFlUnGNpr5De7w/f4oDtAdsLdkI2kHClIT44NBuir+c/QiUIZqe87WmP3wZ2F7PXDUSwomM9A3K5u7YnOycoS2HqbMyQxICGuCCFlUhvtfp5XQoSKLxEjt85nSISZuG8J2eqnt9agH9KJkEHngcvuV7FjbL2J1qmT2xgzrO+nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3AIRstB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709056762; x=1740592762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S7gy7CPHZvEztwdvm1D8suyt5zFSEhNklWiuAuwuQws=;
  b=g3AIRstB5Cn6n27Xu5Y7LUJYBLwWmTGiguj8wndG6iZGGXXjEJs9lrQb
   s6dwDtgBRGTOw4oyMVtBAXzN4xISHA0BCa/RaVN04DSJaognaSEetKTBv
   a8X+aNxVLaNPw0u1vXEJR8eROZb2xSGF9t5kS9BDZxXwqbtrZqg6BLlGq
   Wtegiv1ggcgP1pA+mQMWy27zpav0U7viBvWve7sTy2ExaMuRaS3zamEk5
   B8mF/RJEZc3P6xWrSvqTVv3oLDQy9QZJf+u93JbgNKFhdWAemU9biZmDe
   VwDitPwUh60OUywERN6aqr/wp3VpuFrFtXwrl8OFn9CLp90KFLgpeGy5E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20962782"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20962782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032680"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032680"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 09:59:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0A4B5192; Tue, 27 Feb 2024 19:59:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/2] devres: Switch to use dev_err_probe() for unification
Date: Tue, 27 Feb 2024 19:58:34 +0200
Message-ID: <20240227175910.3031342-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
References: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_*() APIs are supposed to be called during the ->probe() stage.
Many drivers (especially new ones) has switched to use dev_err_probe()
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


