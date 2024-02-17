Return-Path: <linux-kernel+bounces-69817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E22858EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C52B21B68
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C460DD4;
	Sat, 17 Feb 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVlyEtFs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BC60BBA;
	Sat, 17 Feb 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167570; cv=none; b=XI1DVRfoU9nkW0QReMmctT+U57FxtvM/sLtQUTg+nx+hTQNa4vrGDARsAmUKCcS+uYpmuE4E07YyjsWIZEmPy1s0QfulNJrW/DPyuO7D/47DSMjPj2nEbP5e34/sRIHOr9Ca0SXnTrzZCNkZ8juPDW3k2vGLNUW1cw2rsJNeO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167570; c=relaxed/simple;
	bh=Rg9lLhRXKxcDqABXuFQf8jwhkLJkiGL2KthCj4b7KB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP593LR5z1vEDAcPEOsPokPXC6HcuhMff8pFFl377rNCBRfqltOZhIpuFuwmvjxdZJVKR1PstblBv0EFYmUEjvsNvI1oTCZIw8xHIXPSfKMUNxkcko9yqtLU5xeJHZPbFD1Z8or/QTyEjqv2iWftiT5zsA/N/GS7zdfbwrRcjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVlyEtFs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708167569; x=1739703569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rg9lLhRXKxcDqABXuFQf8jwhkLJkiGL2KthCj4b7KB8=;
  b=XVlyEtFsdA8o+E4MI0HYNcLutkco/64tCA6bLq7ZxqRY0zZcd7m4UKc7
   EGMaZhuy8qAOnGO6MBVcLfPtmpT3fik3HqrX0qWA9El/FhP3DCORtsjIX
   yNMe3er52pPvqeKY9fWP8nPntnLDZ+IEBsKM4T+z7q6cctEvUSbTjkQJ3
   i9CeDN4Udy9/mLBJKkah+G9caSCgBTTOUb8VeQUqzY0VXlpWKYKX11EEz
   pWULYGvimmy+NivjuTrnXtLzgFqHBrasXDiQLMvTn0LYwFBK7BuaqX1YN
   ojGiZK/oZZS1ne1bzbhgAlPxYeQhGvsGjgVCRSFwMmN5K1aHagESWo3Oj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="27746715"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="27746715"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="4348739"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.3.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:25 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: [PATCH 3/3 v5] cxl/memdev: Use cond_guard() in cxl_inject_poison()
Date: Sat, 17 Feb 2024 11:59:04 +0100
Message-ID: <20240217105904.1912368-4-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cond_guard() in cxl_inject_poison() to not open code two up_write()
in an 'out' block. If the down_read_interruptible() fail, the statements
passed as the second argument of cond_guard() return -EINTR.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 drivers/cxl/core/memdev.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dae8802ecdb0..bd97eea65bb0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -331,19 +331,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	cond_guard(rwsem_read_intr, return -EINTR, &cxl_dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	inject.address = cpu_to_le64(dpa);
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -353,7 +347,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -366,11 +360,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
 
-- 
2.43.2


