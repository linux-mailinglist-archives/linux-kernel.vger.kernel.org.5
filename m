Return-Path: <linux-kernel+bounces-44966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5288429B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907CB1F27E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05A128391;
	Tue, 30 Jan 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C50WnOS6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0801272DE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632870; cv=none; b=es1tqEw099hrQ4Ub+JQMH73BG9IbSleI2xUKpN3qpA3d2Q5HYQuAHsHOfZPRV+Q9j8ETiuKkbofWKSWrK8kbbFthlHp8Os2fCnJ8dBo1ijrXTF1iKcAEULACV3aQh5hs88lFwMixWeUz4JzUMNneJ/2QLjSuJ4C4qEhooTQtbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632870; c=relaxed/simple;
	bh=vNxT0rsPoDbVtngAtNP78Dp8PDvbA02h15YPEkop4Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEOuH0WRePU8sTv4v8FimczUnMPYEJv1BGGN3ZGuScOuw/9Ent9CioTXYWzN+hhQt1qYAlWGsyA4QJw18rZBNT8IreuWX+ceHSNv5X1dseri/naHHtwP0t5nRPj1DD2JqJUFDqPOSBYL24IZeGLIF54/AMZtUzmfizN1SkppZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C50WnOS6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706632869; x=1738168869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vNxT0rsPoDbVtngAtNP78Dp8PDvbA02h15YPEkop4Kw=;
  b=C50WnOS6XnBZmaFW5K6DyD5BuuX4u0OvjTfqd82BOTNtVWkNOPr0hKNi
   OL9QCFaxtlBfE9AKVWss2AMnh/7DzNPm5NgOoH62jZny7TV2mibsEFZ4T
   qbTId7jvnX+LwVFEAlOOyEi6h4vMjTcwbAAhSClcSyH3Lla48xL+/mwWv
   um0nznu3rXRyPubzVO+OJiLM1RqS8qKfAm28E5Zzk93HnNkh6IA71w9vL
   Vuo1V3u1mLTEnLFz16o9LMZJlGgSXB2e03VFofZ+QLCzbu/ok+Beg1jOr
   Vjvn4JB63s4THCC/rH3yWgI3YkXl9Zkw8ROLSXOmjkP6nU7mbRnol58hc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10721606"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10721606"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3752969"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.72])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:41:06 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Date: Tue, 30 Jan 2024 17:38:14 +0100
Message-ID: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
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
versions of locks. It expects a block where the failure can be handled
(e.g., calling printk() and returning -EINTR in case of failure).

As the other guards, it avoids to open code the release of the lock
after a goto to an 'out' label.

This remains an RFC because Dan suggested a slightly different syntax:

	if (cond_guard(...))
		return -EINTR;

But the scoped_cond_guard() macro omits the if statement:

    	scoped_cond_guard (...) {
    	}

Thus define cond_guard() similarly to scoped_cond_guard() but with a block
to handle the failure case:

	cond_guard(...)
		return -EINTR;

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 17 +++++------------
 include/linux/cleanup.h   | 13 +++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..20d405f01df5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -666,28 +666,21 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
-	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	cond_guard(rwsem_read_intr, &cxl_region_rwsem)
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
index c2d09bc4f976..fc850e61a47e 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,15 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(_name, args...):
+ * 	for conditional locks like mutex_trylock() or down_read_interruptible().
+ * 	It expects a block for handling errors like in the following example:
+ *
+ * 	cond_guard(rwsem_read_intr, &my_sem) {
+ * 		printk(KERN_NOTICE "Try failure in work0()\n");
+ * 		return -EINTR;
+ * 	}
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +174,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define cond_guard(_name, args...) \
+	CLASS(_name, scope)(args); \
+	if (!__guard_ptr(_name)(&scope))
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


