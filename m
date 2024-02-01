Return-Path: <linux-kernel+bounces-48201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E984588E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A881C22A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DC5B671;
	Thu,  1 Feb 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhNcqcKZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934585338C;
	Thu,  1 Feb 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793047; cv=none; b=kEuH1pXEGoJZ9dS3ozU3VoEeF37F5x1eexb7le62RPyEBo+oVcXg4zC/aIuIbXgJque+XD7e/+gDoRLyPEeXDNsdGxtx8vfKuOZTKeorS2aI5TyWEfOv9RfjcT8HvRegk2OAP85eH6o/xJGIl/NH0fs8/L8s9cTl+ny0MXd9gAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793047; c=relaxed/simple;
	bh=5AhN+56yyPZ/UPaJHZIX7QR4zt1xAGI4R1FdhndMxKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVqs1Tjmkv9rsYSN5QuBMJl6nbCNTZQFEd+3+/x8DNcmgfjxTHzMLUczv90dyl3r0wrC4hPeqvxumc7mgGNZVNFQZlKUCyQ5G0yQJwHW9y2yl7ZBo/Abu0XFCr4AcFzh8/BU95pj/Z9DUIEfO050aQ0aTDSmHbK2ksfkMuDH7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhNcqcKZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706793046; x=1738329046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5AhN+56yyPZ/UPaJHZIX7QR4zt1xAGI4R1FdhndMxKE=;
  b=jhNcqcKZtBLY+hFklhzSQ4o4H01ULXLIr1hdDHASj5P0Th/xC9t06aSH
   WryG8G4kjfRYu+5BsuhC8kEOw3bkkBITuGcKC2xEFkOy4zymaUSowaL0b
   Qb5pu0p5O/nDfWwd+1aq+b6MCugIpdQGXJXM1tVLgVmgAdsklmYn3AKOn
   ySPEIPCjdkBkTxLoO3AN1yjmBgbNka5WI+bDUPuaXD4NvqnkSU3NaApct
   hT90bDwnqcKys4di/e3Swu1YHwq6hBJ2x0cxqZCU/Ru0ts2JcxW08+OsW
   2j9DYZSncdZV4ijhaf4qLhcNB9rcQgQil6B3S8sn5KaG8M+g5Bhce/1HM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="71086"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="71086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="79456"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.1.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:10:42 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v5] cleanup: Add cond_guard() to conditional guards
Date: Thu,  1 Feb 2024 14:10:33 +0100
Message-ID: <20240201131033.9850-1-fabio.maria.de.francesco@linux.intel.com>
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

It stores a return value to a variable that is given to its second
argument. In case of success it stores the third argument, whereas in case
of failure it stores the fourth.

The returned value can be checked to act accordingly. cond_guard() always
stores either success or failure codes because certain functions, e.g.
down_read_trylock(), return 1 on success and 0 on contention. By storing 1
to ret, an 'if (!ret)' after a successful down_read_trylock() will correctly
evaluate false and so the failure path is not executed.

As the other guards, it avoids to open code the release of the lock after a
goto to an 'out' label.

This remains an RFC because Dan suggested a different syntax.

The changes to the CXL code are provided only to show the use of this
macro. If consensus is reached on this macro, the cleanup of show_targetN()
will be submitted later with a separate patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---

Changes from v1-4:
	Addressed Dan's requests (thanks) to change cond_guard() interface.

 drivers/cxl/core/region.c | 13 ++++---------
 include/linux/cleanup.h   | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..15e03edce7af 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -668,26 +668,21 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
+	cond_guard(rwsem_read_intr, rc, 0, -EINTR, &cxl_region_rwsem);
 	if (rc)
 		return rc;
 
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
index c2d09bc4f976..63d7d5bc374f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,21 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(name, ret, scs, err, args...):
+ * 	for conditional locks like mutex_trylock() or down_read_interruptible().
+ * 	'ret' is a variable where this macro stores 'scs' on success and 'err'
+ * 	on failure to acquire a lock.
+ *
+ * 	Example:
+ *
+ * 	int ret;
+ * 	// down_read_trylock() returns 1 on success, 0 on contention
+ * 	cond_guard(rwsem_read_try, ret, 1, 0, &sem);
+ * 	if (!ret) {
+ * 		dev_dbg("down_read_trylock() failed to down 'sem')\n");
+ * 		return ret;
+ * 	}
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +180,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define cond_guard(_name, _ret, _scs, _err, args...) \
+	CLASS(_name, scope)(args); \
+	if (!__guard_ptr(_name)(&scope)) _ret = _err; \
+	else _ret = _scs
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


