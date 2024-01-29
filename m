Return-Path: <linux-kernel+bounces-43380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE38412ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58FA1C25323
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371C2C1A2;
	Mon, 29 Jan 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uz4fF7tL"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C4101CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554871; cv=none; b=JYe1wqAcrMsGuo7FGhPPjOOAJFYgrSgBa3Gy0bSVYIXKgZv2T6mBCNwg14ozI4cfAXpDpazzYDxINj9UiuBnM3v3ofxUZhP0Mko9HA2/jE30vIbuJQ/rkRH4ZUqJNPxV1lrIoauxO1QEF6q8fbiVY3C7mmVR2kkUZ6bihebsaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554871; c=relaxed/simple;
	bh=EGwiQ4p1vYieugVbWg78iLa7GA3A68534GyysP3s9mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cr4TRMRju7YL0hzELVc0bMAqqetpvmoxLrA5v5UHGzWVQUFWcEI+OfOfS/TaFOCk8QvVrN6HrSVPiQCp5Zy74x1K+4/a3xcU1JuFGxle7xa1e4OgMYfw9QzHYqlwOTAjgowZ/6vzabG6mzsJCqxXRHDj49/ZnQA3hybpDXpKfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz4fF7tL; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706554869; x=1738090869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EGwiQ4p1vYieugVbWg78iLa7GA3A68534GyysP3s9mI=;
  b=Uz4fF7tL7foOnKUjtQ39nsL6GqkudEttDVvslhejqSfOCr/9VBzG+YGX
   cKgxwU97BC7D1029etFO88nclt3O8ESfKChwwrh1orE0GReXKabCayGG6
   zInSgfjZ63XPWStSzLqFKg5G5Yck9cP/TCPVDtF/gNZPmO/N7meTSZNmO
   A59dHbG8TZqcbcHFwUGzi+Nnv3rrdpgCq2VDF1mAksDEyfQell1s4ELoH
   ZicRvbhWze1icrRekkl6m5KILgiLUzRiEztYoJd1lcOWBLVL5mQJdyaPk
   rLYixsDPREaysIXoxmrdnE8nt5y/rWZHKk71n5R0aizOOXzgrV6SO6Qnd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434233556"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="434233556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858194431"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="858194431"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.23])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:01:06 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH] cleanup: Add cond_guard() to conditional guards
Date: Mon, 29 Jan 2024 20:00:55 +0100
Message-ID: <20240129190100.329791-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cond_guard() to conditional guards.

cond_guard() stores the return value from _interruptible(), _killable(),
and _try versions of locks to a variable whose address is passed as the
second parameter, so that the value can later be checked and an action
be taken accordingly (e.g., calling printk() in case of failure).

As the other guards, it avoids to open code the release of the lock
after a goto to an 'out' label.

This is an RFC at least for two reasons...

1) I'm not sure that this guard is needed unless we want to avoid the
use of scoped_cond_guard() with its necessary indentation of the code
in the successful path and/or we want to check the return value of the
conditional lock.

2) By using cond_guard() it is not possible to release the lock before
calling other functions from the current one. The lock is held until the
current function exits. This is not always desirable.

The changes for cxl/region are only added to show a possible use case for
cond_guard().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 7 ++-----
 include/linux/cleanup.h   | 9 +++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..4a72a8d161f0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -668,15 +668,14 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
+	cond_guard(rwsem_read_intr, &rc, &cxl_region_rwsem);
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
@@ -684,8 +683,6 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 		rc = sysfs_emit(buf, "\n");
 	else
 		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..550d21a425d3 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(_name, _retp, args...):
+ * 	this assigns *_retp with the return values from conditional locks like
+ * 	down_read_trylock() or mutex_lock_interruptible(). *_retp can then be
+ * 	checked and actions can be taken accordingly.
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +170,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define cond_guard(_name, _ret, args...) \
+	CLASS(_name, scope)(args); \
+	*_ret = (!__guard_ptr(_name)(&scope))
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


