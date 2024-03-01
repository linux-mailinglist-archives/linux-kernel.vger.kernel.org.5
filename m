Return-Path: <linux-kernel+bounces-88876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D686E7DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CE91F2775D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169925622;
	Fri,  1 Mar 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nc9oRtRt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DEE1798F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315809; cv=none; b=P+/oSYjD8CQkShM1zAQvGPjJUXZCiLm/px5Eryhspnp/yRAfzciDn7sKHVUPFWQT7kGdH9i47puGXUezL1yVimfAcHYY4WpmlP2qLwTJiQXe28i7dzCCZvYs1RVGbWVun1DS7imd03r7V8A/NuvdH0PcAye5l78pcQsVjM3hRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315809; c=relaxed/simple;
	bh=VrL8Wgn7VCCPQmOga0aArrh/XkhN1vzXIcht0JUG/ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYBhq+Z3hd+2L0qwgXdCAIPUCGXw/ju6kzqnuOdnQj+WPGae4qptjlBdoT7VYHGURwX6kHRvb6oPQpIcwt52tAgD30YVSDpf+p1Bn/EUnyz6P2ji3tH0C03P/O53/96bCUw16ljap4GEyqspsTpfkXfxrdCD3S854clXSwkS1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nc9oRtRt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709315808; x=1740851808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrL8Wgn7VCCPQmOga0aArrh/XkhN1vzXIcht0JUG/ec=;
  b=nc9oRtRtLSdUwG9nGC3nMHDuukoKxVkVLW7cj4kUi+nK5DHRhpRjoXLX
   +Lf64mitBtwEKmdjQwHeM1r8WUKFY5wej99AKxl8bHr1pj9e+0zVpjl87
   4AhfhGlxTVVuXeFKa3/f66oYKT1aHk08zQyDmVCHNynuAyxPHneGek4Lh
   0zbgmJeNQLIuVbHNznuzv6LguV1cLuaR7NlZaZApus/VE+6u36VhiKJkA
   kVIYIj7Xz+N1vPj+aMk1/VSRa/O4uRJoSjiisqSEuEt6BNK+DJkdv70VB
   ESn3OTJ3cvPM/kqpIP2RfdmQ9HfI+PG5G9DGOXPZE0EeSEQX2px4TM1GF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684223"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037839"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037839"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 09:56:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D5BA91A5; Fri,  1 Mar 2024 19:56:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v3 1/2] devres: Switch to use dev_err_probe() for unification
Date: Fri,  1 Mar 2024 19:55:36 +0200
Message-ID: <20240301175641.270020-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240301175641.270020-1-andriy.shevchenko@linux.intel.com>
References: <20240301175641.270020-1-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/devres.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index c44f104b58d5..f38e8297ad5a 100644
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


