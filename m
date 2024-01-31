Return-Path: <linux-kernel+bounces-46520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09F88440DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BD41C22009
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA37FBBC;
	Wed, 31 Jan 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoJeecfU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3880BF3;
	Wed, 31 Jan 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708479; cv=none; b=uohBbg2OvlfaorCJX6DFcLG6JzX2LM23pJ7NHkGuO1/i9T1el4zrp46wkigirhV+a4xINS9VnNHkke69uzBV6lhHnhGGxVk0tpQgx02XKl55JMNrBYiFeBxEm4dq8nHA+mzcyVNPaMxmnz6gDS93aklq6gHEjSXzaSRE6NSKs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708479; c=relaxed/simple;
	bh=kkYLtuM+W9SeG0+q5Jd57SqlE6TQt9i1wFutcTGM+js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ku7OxnUnc3DSJvyhH+dMG69fdKbq0qbebh3oxWS2IR+SskhjPsxgj1hkbCoWkjS2IHVnqFKHU5E0wEabhP+BRty4mF8ste658r1LBF3EQDP6dwToZMEbRPBwZafxiEVM4dd8Q/N5zf8LYY6TpB4AtsYY+8xTND/IMfHN3L0SOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoJeecfU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706708478; x=1738244478;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kkYLtuM+W9SeG0+q5Jd57SqlE6TQt9i1wFutcTGM+js=;
  b=YoJeecfUBTj+iSrEd3jm2Fy/4tWbPYwSx8YueC9kcrLBELCc9dKgycJ9
   /GV5zo140KwDtYtfGMh93X3ksoPU6i2JKRAvNKO7uGJOtFty1+Pzy8RSp
   XaMaQcMaLUZGEUqe9kn1982UtESmSaJeknDtSQUDrLWuT8o7cZCshRq2F
   o7pNNBKe86tP1ZrFQD7Z1+UOeHSvNsqiKBZ8+CwKeDaxNTezYe3HHcn39
   3yObPfyPLKtoM5MUhHLUJudZg9FmtL5fTQ98H+kmHFO0YsslRBVlNeRHx
   MggPdhRP//V6jqpoPwCLkK1MOfROx3QuBS5q7tZ+8HwZPkmHb9iU9UI0n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10703186"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10703186"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878785276"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878785276"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.82])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:41:14 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	linux-cxl@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Date: Wed, 31 Jan 2024 14:37:35 +0100
Message-ID: <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cond_guard() to conditional guards.

cond_guard() is used for the _interruptible(), _killable(), and _try
versions of locks.

It stores a return value to a variable whose address is given to its
second argument, that is either '-1' on failure or '0' on success to
acquire a lock. The returned value can be checked to act accordingly
(e.g., to call printk() and return -EINTR in case of failure of an
_interruptible() variant)

As the other guards, it avoids to open code the release of the lock
after a goto to an 'out' label.

This remains an RFC because Dan suggested a slightly different syntax.

The changes to the CXL code are provided only to show the use of this
macro. If consensus is gathered on this macro, the cleanup of
show_targetN() will be submitted later in a separate patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---

Changes from v1 and v2:
	I've taken into account Dan's comments (thanks).

 drivers/cxl/core/region.c | 15 +++++----------
 include/linux/cleanup.h   | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..560f25bdfd11 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -668,26 +668,21 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
+	cond_guard(rwsem_read_intr, &rc, &cxl_region_rwsem);
 	if (rc)
-		return rc;
+		return -EINTR;
 
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
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..a4b40d511f9e 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,20 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(name, ret, args...):
+ * 	for conditional locks like mutex_trylock() or down_read_interruptible().
+ * 	'ret' is a pointer to a variable where this macro stores 0 on success
+ * 	and -1 on failure to acquire a lock.
+ *
+ * 	Example:
+ *
+ * 	int ret;
+ * 	cond_guard(rwsem_read_try, &ret, &sem);
+ * 	if (ret) {
+ * 		dev_dbg("down_read_trylock() failed to down 'sem')\n");
+ * 		return 0; // down_read_trylock() returns 0 on contention
+ * 	}
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +179,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define cond_guard(_name, _ret, args...) \
+	CLASS(_name, scope)(args); \
+	if (!__guard_ptr(_name)(&scope)) *_ret = -1 \
+	else *_ret = 0
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


