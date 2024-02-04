Return-Path: <linux-kernel+bounces-51829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26702848FC1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F1B1C22146
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318525558;
	Sun,  4 Feb 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMxkc0Bj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064522555F;
	Sun,  4 Feb 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067882; cv=none; b=h751M6A+pLhtNhw+v9oePFwFjMJp/BH64EdcBu8WlmeOcSWMmj7QDDFLyt0wJge7ca414HhVkB6tMD2tZzRjebG8uoVcxdEAUFh22A6mWBKZ2DW0p+hJXU2Opfz9LExCUyOz7g9DFhS413WRCVl//Ef00iKBEH8Ecdp2G/HpEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067882; c=relaxed/simple;
	bh=FPf3c+XFlSNb7MJJi6PdgXBeD5uKtm42qLdX4zSVwgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hov32Us3IJxqWeReI0HuelDWSzx4yklBPVyaFcTHp65rcxUMCV8SMWLwBZ0X97EG5g/ai16+kiVCYYCIXES5MxVRXXquv3roquXsTwid9DI7N7N4XPmBE9hpkKasOlKN2opsg2D3/SU92oorZfhGx6FkhvUQxlA0D/pSz0ohY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMxkc0Bj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707067881; x=1738603881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPf3c+XFlSNb7MJJi6PdgXBeD5uKtm42qLdX4zSVwgw=;
  b=ZMxkc0Bj8IwXyGhz+drDD2xmCxXDcKcMNa2mK+C+XhlilrP626tYWYzB
   ZmFcOnXjgmosD0TTTy9KSza+w80ZRUbUOdvQpG0Qkz/BMTuAh+SjCX29V
   56//Dlu+TqHu/Aqwgi9GeDN3dzu5/fc0rXXhEMepdj63xRuMN+VCmWmre
   G/q+2+7jZX0fZ7zYdlVxCP7REmDy0pkkMyVC4lvQ5GSvKzJCXqzPqaP+b
   u2ni8EeKIhs/fp67gPwF6jMuzZ15TYktAvro36iqIfHzya7NWe6HO0zL2
   mKlq882bWWPIBCMHHbD1nElG9P/iMcrMo4DNVVM7VPFswhoUZ97hHQzZC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4225908"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4225908"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 09:31:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31626386"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.2.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 09:31:18 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/2] cxl/region: Use cond_guard() in show_targetN()
Date: Sun,  4 Feb 2024 18:31:05 +0100
Message-ID: <20240204173105.935612-3-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cond_guard() in show_target() to not open code an up_read() in an 'out'
block. If the down_read_interruptible() fails, the statement passed to the
second argument of cond_guard() returns -EINTR.

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..bd3236786a25 100644
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
+		return sysfs_emit(buf, "\n");
 	else
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
 }
 
 static int match_free_decoder(struct device *dev, void *data)
-- 
2.43.0


