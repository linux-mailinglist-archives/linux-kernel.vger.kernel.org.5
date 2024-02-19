Return-Path: <linux-kernel+bounces-71195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3685A1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D0A1C22DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511233CD4;
	Mon, 19 Feb 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9rUbu3l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFB3306B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341736; cv=none; b=qtVIT0LTQB9WHd0k2e5S7LUGluQK/DmKr7X3XzfGFfuhoe9OyBmbrYhU8uBJeUr5Y+TnO9C0zyaohq0DcAryKOlYsu3xWS9Hzkv4TJslVKJ/1Cjrj+CNa0G3+ytcQOBTSfV1HQz1Nh1VX4aoOdpRyXDJ9CA4qT+9CjhsWH/QZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341736; c=relaxed/simple;
	bh=fCI8ry2QwMgfpyT/VHftog8+K3+UurzhRMpjSws+ROQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAgKo7yPd9pmWqs8kPY/V5/hm2AyB3x9hN/2zqpqb+tgrGwYA38fkzaZyvp+5GPnmOtBRVmqnzB+oMKmFeH0jJ7GNjbTxDaltp2pV3PVf53cp7pU7m3x4jyL7cV9cqb+VqmLt5kCMR7MWN9DcB4deqnpIJUAGln6FPzu5kemoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9rUbu3l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341736; x=1739877736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fCI8ry2QwMgfpyT/VHftog8+K3+UurzhRMpjSws+ROQ=;
  b=Q9rUbu3lKPUu0eElfh1wn1CmDlNipsWIkyeJe8yH204Y6lcOZbcR8Bn9
   wS3SbaZ5/JkuZEeyUkaBHiRtUzStRuEEhoZw90O2+/T1WtBY8oISp9Y3F
   Ky68iGUfEUaJnPCAmVnTi3v0Xi81xC4PS7N0q0s7Joef+0FndxVFAEcf/
   Y/OqJJCDTuoNuHskNHkN7JAmODSffOqNLB8c6O8mxCaj8u5OQrOYOTT2I
   Ac/rAulWhgNIo4pM4u2Z7mMdwjQv2csDPbxBpj6g4OSbRD//r8/7EvA8o
   f01UnuzGSlXimKTI+nfpi7y3nbiIxbFofERcF2M1KjEEMhksuQdWnp8J9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823413"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823413"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826892"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:13 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] iommu/vt-d: Fix constant-out-of-range warning
Date: Mon, 19 Feb 2024 19:16:01 +0800
Message-Id: <20240219111601.96405-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit builds, the vt-d driver causes a warning with clang:

drivers/iommu/intel/nested.c:112:13: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned long' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  112 |         if (npages == U64_MAX)
      |             ~~~~~~ ^  ~~~~~~~

Make the variable a 64-bit type, which matches both the caller and the
use anyway.

Fixes: f6f3721244a8 ("iommu/vt-d: Add iotlb flush for nested domain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240213095832.455245-1-arnd@kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index d5af5925a31c..a7d68f3d518a 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -103,7 +103,7 @@ static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
 }
 
 static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
-				     unsigned long npages, bool ih)
+				     u64 npages, bool ih)
 {
 	struct iommu_domain_info *info;
 	unsigned int mask;
-- 
2.34.1


