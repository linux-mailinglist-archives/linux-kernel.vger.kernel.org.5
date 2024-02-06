Return-Path: <linux-kernel+bounces-54935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303CE84B527
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C156F1F2592A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632612FF73;
	Tue,  6 Feb 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJcRQtsp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87781EA7A;
	Tue,  6 Feb 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221597; cv=none; b=qUyq1sCu/rfVhtfC0g40JKhxGoi+8tCeVQv/6LJrM+gfkXg9WujhUMYWeMO6f2xU7KoVwmFsoRg8mQDf5y6hU3j7koLZ4vFwYk0mHrG6Zt4Th46PD41RlrTxEKcBRRcMr4o5Lkt3GuLdO59ZN/4WUw9hgxSXQq3VGNOGeEqNGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221597; c=relaxed/simple;
	bh=Wim/IsJK6tra2KU9v5LTN8HrI8504obd37/zUH9YMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp6Dia5sEQmi2QVEmDDVpYwSRNmsDDUC049G/6m8KfDV+wJ5hOqkUzJ6qamKgTuPnE9BJaK+xqSyRbC1p5+p6JzPh171A2AbrsZ9Ctg9Dm27BFux25PLOhCY1rHIqkImhTRfyihCQOfrNY9R5PKwSPntfSnixL5CbMUZz6YX0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJcRQtsp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707221594; x=1738757594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wim/IsJK6tra2KU9v5LTN8HrI8504obd37/zUH9YMYQ=;
  b=DJcRQtsp2VAhMnHEIJasEz7HbNTjQw7ejyL4S/48wsDW4T+WnexJ+RlE
   J+EBHHlLsur1d9H5jEb1+A0cU+3h8S/yJfcQLMd4MQ3tqUXtU2l/oatbX
   xYS1p4U+gSg/V+CFrNCj4JlQWfSzN7br67wclXhfXujPtMFus1HkLjWob
   Gmho7vb72Zdfk6nu3rFCIpV2q5aHF7TyqGdk9D5ovu2D6UJylZ9JkM7G1
   AAmnCs/j+4EnSmib6htJ8HP5Wb1xkKkE1myOKCdoySQLLpX+W8tWikbMC
   NUPpE40X4J/0+N7KUmIYiHqjBSppwTohmA8SEv4Ji1X0E4vrc4SLk+2w8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="998426"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="998426"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="24247467"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.2.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:13:10 -0800
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
Subject: [PATCH 1/2 v3] cleanup: Add cond_guard() to conditional guards
Date: Tue,  6 Feb 2024 13:13:00 +0100
Message-ID: <20240206121301.7225-2-fabio.maria.de.francesco@linux.intel.com>
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

Add cond_guard() macro to conditional guards.

cond_guard() is a guard to be used with the conditional variants of locks,
like down_read_trylock() or mutex_lock_interruptible().

It takes a statement (or statement-expression) that is passed as its
second argument. That statement (or statement-expression) is executed if
waiting for a lock is interrupted or if a _trylock() fails in case of
contention.

Usage example:

	cond_guard(mutex_intr, return -EINTR, &mutex);

Consistent with other usage of _guard(), locks are unlocked at the exit of the
scope where cond_guard() is called.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 include/linux/cleanup.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..d70454e9f8dc 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(name, fail, args...):
+ *	a guard to be used with the conditional variants of locks, like
+ *	down_read_trylock() or mutex_lock_interruptible. 'fail' is a
+ *	statement or statement-expression that is executed if waiting for a
+ *	lock is interrupted or if a _trylock() fails in case of contention.
+ *
+ *	Example:
+ *
+ *		cond_guard(mutex_intr, return -EINTR, &mutex);
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +175,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define cond_guard(_name, _fail, args...) \
+	CLASS(_name, scope)(args); \
+	if (!__guard_ptr(_name)(&scope)) _fail; \
+	else
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


