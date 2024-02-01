Return-Path: <linux-kernel+bounces-47481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F52844E79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAA21F2BEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F3171B1;
	Thu,  1 Feb 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUvzNQ+G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009922C1A7;
	Thu,  1 Feb 2024 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749867; cv=none; b=ej2+zB8sBi2NTjEd/fpcON8NTp1qEXx9BIcoRxR5s2cUxRsdVkzn5VQHfjArnJLTiUjvSLoUtorL/JbNDFSSQvxSr2MRdNAvYJ38lQPK9gnIfzdx5ot4JPhXaISIAPsfjQDNWLyIWrO95F4Z7NHnagVZnQ3Jb3ZIJwP6ve3DwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749867; c=relaxed/simple;
	bh=L32ltv4g2uOGoYGmH9JgTrOWs6BXkXHAwaeCLPaMu+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLCT+M/uSQB8KIzD42EbqN0mR+hWjEiDY9bJgM4agVmGxTM1C8nrD18GCCQtDD+VYuXUpEiLhfau14GcDqZrcpDD84uQft+ziyiZcM5H0ZL59nk0oxKYMDQwjDu3dpM+cEUt9VLKkuuVGv5uRdDeFeQtxTbtDWg//73JF1dJm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUvzNQ+G; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749866; x=1738285866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L32ltv4g2uOGoYGmH9JgTrOWs6BXkXHAwaeCLPaMu+c=;
  b=hUvzNQ+G+ReD/LFTKej8cj8mxdNRKwdXETGwMzrhzWP8rvZo3TFcQjQU
   OyaPio2nwp7S1wo8yGB9+BIqQyGWiR1GdNgnBNsOcbTnxaoQ3V75Bt54Q
   rNGgkA3kaPU8PribeDGKkfTCQwjVkLCdkRgpmCwvmxT40p4OGoog2qzaV
   EHdP/RlXs0k5xEPQ6rcPewK2b8zxa6rrvDl2bb2o11ekT/gC07///kep0
   3omGE26Uet1fYQxvAdbQBLEOMBGufVuhogai/riCypiEfUO1+a83Tnn6f
   vFoKWrgVk+unMLe0ME1PvhMLM2viVuV8V0chXL0zXY+l61MXZXT+M4qIs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2714091"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="2714091"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:11:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961770473"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="961770473"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:10:57 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	linux-cxl@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v4] cleanup: Add cond_guard() to conditional guards
Date: Thu,  1 Feb 2024 02:09:31 +0100
Message-ID: <20240201011052.474129-1-fabio.maria.de.francesco@linux.intel.com>
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
_interruptible() variant). It stores both success and failure to
always overwrite any old value which is possibly contained in the
return variable.

As the other guards, it avoids to open code the release of the lock
after a goto to an 'out' label.

This remains an RFC because Dan suggested a slightly different syntax.
Furthermore, I've only been able to set the return variable by
dereferencing its address. "_ret = _err" fails my tests. Any hint on why
it doesn't work for me is welcome.

The changes to the CXL code are provided only to show the use of this
macro. If consensus is gathered on this macro, the cleanup of
show_targetN() will be submitted later in a separate patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---

Changes from v1 and v2:
	Addressed Dan's comments (thanks).

Changes from v3:
	Fixed a grammar error in macro.

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
index c2d09bc4f976..a72c52430665 100644
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
+	if (!__guard_ptr(_name)(&scope)) *_ret = -1; \
+	else *_ret = 0
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


