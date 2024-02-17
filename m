Return-Path: <linux-kernel+bounces-69816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A068A858EE2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F621F22284
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2CB605D8;
	Sat, 17 Feb 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ei9bSHA5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5B5EE78;
	Sat, 17 Feb 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167566; cv=none; b=pPZvrvH4/F9w5QxG4huKE4QH4PH3qLH9ON9GyfAqYoZtVB5DsSU7fBDtuHIkpta/zxmoB4BOjHdq+5TAQkoRwQsa0YPw9kTV1ZV3Z0JMHa/01VD0Tpz2ltNpwGEAGS3OoN5f7qen/4h3KnJ+tLmbkw9zM7WIT4mtAld2CSL4GJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167566; c=relaxed/simple;
	bh=tReqAs6fZ7zrpLVpBj5aMUSuggIHwZZRptD6FzY8tlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AigoqT3cYoeqZzX2YPn0JHMOd8Mjt25G1mYSX7/yaqfcdtuIu5PYJ2LEilQlSUlHZ8cQaJRe6UQK9WKLViOuDzH309+W9WJhH8acP8q8HMQi8/N0fO/oIU4xJSGOyXqnHA0HQk0ur8aL+gWVNKvGystjtSgHq+qr/Z6zV6T5yrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ei9bSHA5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708167565; x=1739703565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tReqAs6fZ7zrpLVpBj5aMUSuggIHwZZRptD6FzY8tlA=;
  b=ei9bSHA5SrZ//3K2d8100vpikATXFyYliYcfHnoxkfn2IFP3vOzM5YNk
   EOvwchIA1pimOsMGarVyJI8tIXvGrMm8yjbX36He+dHBhFQu+i6yB/NpU
   Z6GpcEWLGHourpLIwNMM1iaQLA4ZO1GK3WiC9xgpOjGe1dO/wRQ1rnbWK
   3CzNZbQ+VEhMhVyIjw9Pgn+869+D8v38NHKF1gKX44Y8vcBHByDh1/sVC
   8BFrKJdq3PqnbspDQ80CSOnYgjP/YUkZUv0ixWoGTxVuHIzZsGPr5+ROj
   nksGxW8iBfrByxIvlsWaS4Ut9r20CNupEhlSIRxpj8a46X5nyxOJUHzoz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="27746710"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="27746710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="4348726"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.3.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:21 -0800
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
Subject: [PATCH 2/3 v5] cxl/region: Use cond_guard() in show_targetN()
Date: Sat, 17 Feb 2024 11:59:03 +0100
Message-ID: <20240217105904.1912368-3-fabio.maria.de.francesco@linux.intel.com>
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
---
 drivers/cxl/core/region.c | 16 ++++------------
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
-- 
2.43.2


