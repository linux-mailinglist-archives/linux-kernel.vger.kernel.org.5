Return-Path: <linux-kernel+bounces-54936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D284B528
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42791C23877
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096912FF9F;
	Tue,  6 Feb 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkZuS+HW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8A12FF6C;
	Tue,  6 Feb 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221599; cv=none; b=p72A/v7OGYnL6/EcnwceYh0XOw/gtIGFsuA92O4YTANIAVvNEnlxk6zvZDViPE5tegzIbEEXQcM7adyS9C4aFDN24NGSEGPKjcKFXDj7LnJI3cHu942G7S7PF5JiNQuyU8ZkAG4PZ9YYwPm1mENqDGHQuhDZjERB8NqOvTaUQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221599; c=relaxed/simple;
	bh=6kuESQ2JAAwpV9VqKvfTWaOUnZHmWcCYDi6kAH11nws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYs07CoDlobAY4g/44Ix9D8XLBIDe+voIYYVmYcJEXOfK6MwDQ7E6+XxJkMGFGY4SejbhIV6/FmGgkURE67BBpUzOge1eNMqevRv6ZKc1ykC2rJZ9tS5B1udywmwbSjluEnDbmnkqwoN2yeZhR1jTexY8bV7Uws9GDzfmT1XOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkZuS+HW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707221598; x=1738757598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6kuESQ2JAAwpV9VqKvfTWaOUnZHmWcCYDi6kAH11nws=;
  b=JkZuS+HW9bAtCMd2liSEWRe4iV4sJcqchVL3rQPGN3QQFIcjQAI9yeTB
   yeoXtscdWD4EIh4a8YhkzLs4RkdyXLZ10WsXD6vf9P3Vw5MMrPmh6jbZl
   ssBAWcaSIgNfGXWsOsZJ6RiULJ2BqVa/mN8rxVbe2m5zJLtAkDqB9Sch2
   RfqaV9/jPa5PWAHPznCKGMABmaMpHxL1yfEGaNijfR0ov3O1TuxXRzTLk
   oK7vLU9m57KVIY4aPb3DhtOQPfsghpp28QVy8FTid1xGwcstzOgdmXmfR
   +ht2OEkQF5Joyo7S+4HfOXDurpNiA1EjKdRzsOCV0i283lQxJmln7+Haj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="998442"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="998442"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:13:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="24247479"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.2.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:13:13 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/2 v3] cxl/region: Use cond_guard() in show_targetN()
Date: Tue,  6 Feb 2024 13:13:01 +0100
Message-ID: <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206121301.7225-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240206121301.7225-1-fabio.maria.de.francesco@linux.intel.com>
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

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..eb5c36462c0a 100644
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
-- 
2.43.0


