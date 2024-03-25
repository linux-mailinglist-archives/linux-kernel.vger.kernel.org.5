Return-Path: <linux-kernel+bounces-117015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0E88A6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D0ACC6037
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612C13F44B;
	Mon, 25 Mar 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjevTs3M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22D146A8B;
	Mon, 25 Mar 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370097; cv=none; b=Qqs+ZOaOVubKT4e9iSz+uqlYoRonD4iJMLOt/4djdxJa5lb7jSh30T1I9eqyaF3umNSjTkruY/KC2mv9ws1Y50Rb2sc246cWWUibbMlPSeVDms54a9DHbqVb6SrMQtrd3LOH1zQpPdsVgQcHMNfXcqbg08ygVG/tsli8aAsRI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370097; c=relaxed/simple;
	bh=90eQ8H9NeVyKRfnXGj9oSY32Oak16lSvywalPic9hkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh/1udhLijKMYwx5NQn1Zayx3XVFLbT6BsuBmVaZ3Lv549CQ4E4Pdxt8C/bH2YD44YgnyF5eX3guz6EoFVx2wH8cy0OfmZYVEOvUnkcbiXj2cqyEi6pyrNX4VjmMOK7eRjyHKjw7Gix7Ggr//y7nuJCXLBJIV9PRI2SwKUqCAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjevTs3M; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370096; x=1742906096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=90eQ8H9NeVyKRfnXGj9oSY32Oak16lSvywalPic9hkA=;
  b=DjevTs3MYG+E+Huf+t2BOqld0Ak4KIxElfWzEOGphxUrE6tSnhF8nZHS
   Sd3BvhOj7uVDhACWTEqCNYDLCknIk/w0m1Kde+YWmymMHznlWpL8NqHAu
   5CxfpDE3hvqmj2a+vX2DVVEcjaqRLiPH3j3ZVTfI+/OCleOX5LYY4s1vG
   vSmXBNrCKp8Q+RJV9SHg/GolYUh0c1ICH52iVFNQnnvUsWrRlSYJ5LR4Y
   GIjzD7L7G0jubu0D4eAsg5D381Ix15qCr5mTNGk41UkEgkS070+JfNNwa
   cDuBoh9nfk/ZG2eMW9JvAGlzXHo5gVl90cw+/r7z9zgG3zHHczDnvp4hd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549707"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549707"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070342"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070342"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F1090524; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 6/7] ACPI: scan: Use standard error checking pattern
Date: Mon, 25 Mar 2024 14:33:02 +0200
Message-ID: <20240325123444.3031851-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for an error and return it as it's the usual way to handle this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b2785a036a68..45f7ec3b6548 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1579,12 +1579,13 @@ int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode,
 			   const struct iommu_ops *ops)
 {
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
+	int ret;
 
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &id, 1);
+	ret = iommu_fwspec_init(dev, fwnode, ops);
+	if (ret)
+		return ret;
 
-	return ret;
+	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
 static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-- 
2.43.0.rc1.1.gbec44491f096


