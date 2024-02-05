Return-Path: <linux-kernel+bounces-52817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C763849D01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4A51C23DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5A2C6AC;
	Mon,  5 Feb 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipme4T/P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593B2CCB4;
	Mon,  5 Feb 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143192; cv=none; b=XvKZ/nN4VcgYdULTp7VqUQ1rBpNnCpqawAp7d7sgfDh/8sl72WoXTuRP9qJMdt3ooGBKDN2riPPoIzeypftMFbH+kCR717Gso6Ox/Nu0Syb5pGi/UHd/gLn9C1tcCve22UfM4aUz31CU81IGINDMSxPo9PKyi2WlMK52+JMQTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143192; c=relaxed/simple;
	bh=4ANXw9Eev2vDRjyUFpbniMCxexDvyqi2W5ezLzeVHOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDU2Qxq910u2KRGDXODTVo428sA/fpDKLJ2PYBdkMFbMZPyRHsBuQmNUVoagIFQBRKCuazNxj8o/LbOkWrYGltT4LkE0I6olVkOYpgC55ROpoE3w71ta/B4Y2yWdAOagNIPXxkfu3TMrN21SRXH5xrw8WH1iCdgrLGZ38Sr+tMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipme4T/P; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707143190; x=1738679190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ANXw9Eev2vDRjyUFpbniMCxexDvyqi2W5ezLzeVHOk=;
  b=ipme4T/P5QSwK3TFYBMPutdyv+6TqVGZ+5HlW24qMba/xHlUxcaWO/qb
   KQQSHm02NZQgXc+NjHBjdfg2faRRfNokx2/7tnqqJVy3kcuamqM54DVbS
   HBO2iQyUVOFqfViZEeydMlCdX03dZDMdBSoavKExNPdUCuVHwvMGhyOhG
   rrsN893Ncd6nduTS6ChEdDpbofcMef+0Y4JllGbf0UhukxsEbS1dyug6x
   OMxIh4QPccQUEy1SZjMxjXnHfzMzzPyBAhKXF2iLYLWFfeIacs5GChgDa
   Iujw1IqQMf1l3WYmQG371DH/YQdXLzgY52YVIy9JXLnxf63EE2bNwvT2b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="787675"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="787675"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5473019"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.219])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:26:27 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/2 v2] cxl/region: Use cond_guard() in show_targetN()
Date: Mon,  5 Feb 2024 15:26:13 +0100
Message-ID: <20240205142613.23914-3-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


