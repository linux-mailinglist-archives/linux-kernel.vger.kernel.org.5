Return-Path: <linux-kernel+bounces-87035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D286CE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0161F2179A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DC4AEE1;
	Thu, 29 Feb 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeJYU+0P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4694AEC7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222118; cv=none; b=KZqRXEyY0TMoqVdXPfqirkAM/Rh4l3kz+xHAST/LXCFan1S+cHwI/TgUvF4OAa0UAZscSEbiK7W/rryaz+myB48Iey+hvKwPnggN6aoXGukVqlGLJAwvE6pwG3sYz04OelKDxcU45YHsM3TiqNQBhfKar2/BLqtPwioXtGaDGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222118; c=relaxed/simple;
	bh=1t6+gvF/y1g4r3/uIO4V9puoZcuC9KmFRjleUIoiJJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG6tpE4+6s1OI2Wa3fcimSlVWdlsBSmVQddezBKqnri7QsDEp/kl6pbMDWUI2p5AV/9NDE8l2VwVn1Vs9PSfPNyvDQ8otjgSdCc6a5vvhD/0GK7JRraIqouZkmPuteYFCbKgrII+VCEO03OkFwrEM8nAYmHnOMR0aZSAmVD5aoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeJYU+0P; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709222117; x=1740758117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1t6+gvF/y1g4r3/uIO4V9puoZcuC9KmFRjleUIoiJJg=;
  b=CeJYU+0PmF98m1ZDgTv85dncJEAFxO1njmBE1JabwShN+arLE2jw25/E
   Ze6LvBlI/htKmzOZ+gNalb9vlXS4+waLNRtFW/w6grfwJdMv1BCL1oEzp
   UL/76H8y9ut7l/U9WQtZVfB0E3Q6WSvtftDVpIolCPZ9yRDA047Ix9zbg
   Sgcjdiei+Q2h9ZzHTystqAt4QHJSF2g6o6IdAwCBuECbmexZhSj1hRLEj
   nL62bosV5fjCt/PMay8TjN3ZhbFh5SyS0yAAtxVGB+WvBUEeQxSemXR7Y
   JxV5n98yfGRut+JWPH/9CEak9g08RAvjtah0zwtWWOX53G+dWLxN3Tdv+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7479283"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7479283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036109"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036109"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 07:55:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A9EFC3BC; Thu, 29 Feb 2024 17:55:12 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 1/2] devres: Switch to use dev_err_probe() for unification
Date: Thu, 29 Feb 2024 17:53:39 +0200
Message-ID: <20240229155507.3853059-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
References: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
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


