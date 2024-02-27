Return-Path: <linux-kernel+bounces-83650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32326869D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA63B31B67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97354E1D3;
	Tue, 27 Feb 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mixHy/oz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD74EB43;
	Tue, 27 Feb 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052547; cv=none; b=lpMbV7OdAbvYSC1kAB1s7tUbgOVphC2gWcM3M+Cx+81Tnw3CZPb17U6PEOtzR6iMC60Clb8DwXcmFSiHKcENBHHbzBBa9neX9L1Kcxhg+vV1MU1FHgbnGOwsvsc7kbEsuFsLzgrJPZwUN9xuiWEIz4Z0VVIa0rZrC8iQ2kIP270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052547; c=relaxed/simple;
	bh=uM/i0Rm9q3ig1FjMY9O1+2SHrbYFfbfJXmzB9UyHcMg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxatextoHO4lzHWBCV9l/r4EIDXFx345nJ+nfF696rpp/f8JvUbaaX9nhQ/qlIQoVtPzYED9UDFPaEAxB71WQoJ4s0KmpMv4UAWy/7c904aQcjRnIhyIA0heI8rhpEhai+GytETYMwbvaSGUZgg3k1C/RA8tDC/rQB+AwnmXA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mixHy/oz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709052545; x=1740588545;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uM/i0Rm9q3ig1FjMY9O1+2SHrbYFfbfJXmzB9UyHcMg=;
  b=mixHy/oz9ftJbGz9Kc9p3G02My0GRO1kXjM/b1mU2bKlklqCvnYUYlNN
   jRB1VSZ6+8V7IGdg09KIFfPG4O6b0jQ0CIrWtdy4S+SZqNYq8Lxp2hCXU
   VDDR7WEyAUEa1jJXGEukffFRP7WsfIwClDLkeQEamjui21uoJ7RyDTTkH
   nlS5Gex+bV2NYEck0uW6wQdQQUUGqk2HPAvGcla4JzJz5BAjUbJbpaK40
   osxy5l+jwYyO8gyHNC6gMudixGJFzvZfadfWHuz4UY6YzzcQt+nsTEEPW
   wFSUVi4xFc93aOVAUNcCPlylyV35+YbMdh+Va4sOM4vkt5+zF5ZKNiCu+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20948840"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20948840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7536117"
Received: from sshaik-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.88.67])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:49:05 -0800
Subject: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
From: Dan Williams <dan.j.williams@intel.com>
To: torvalds@linux-foundation.org, peterz@infradead.org,
 gregkh@linuxfoundation.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Date: Tue, 27 Feb 2024 08:49:04 -0800
Message-ID: <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Use cond_guard() in show_target() to not open code an up_read() in an 'out'
block. If the down_read_interruptible() fails, the statement passed to the
second argument of cond_guard() returns -EINTR.

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ce0e2d82bb2b..704102f75c14 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -666,28 +666,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
-	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
 
 	if (pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
 			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	cxled = p->targets[pos];
 	if (!cxled)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
+		return sysfs_emit(buf, "\n");
 
-	return rc;
+	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
 }
 
 static int match_free_decoder(struct device *dev, void *data)


