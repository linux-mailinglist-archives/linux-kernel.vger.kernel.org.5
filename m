Return-Path: <linux-kernel+bounces-52816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F714849D00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6961F289DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67E2C84C;
	Mon,  5 Feb 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beHC2N0g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF172C1A8;
	Mon,  5 Feb 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143188; cv=none; b=R46QM5RqzFif66z227iOX4mIyKOCQBe/pmTvMYFbw55YBA1LBbyGg1sLM9bQCMg7VyxE5sgB3MCrhDeQstAzEAEKW4bNH//UGHRrfL6UTOzxIXQdq/roMwoQSyXpX0UbHOu6m39+T5XoRE1AJ1iIVKUPiJW+H/e0Mf4UfvQ+z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143188; c=relaxed/simple;
	bh=um9Vx8F751cSpatd8MK+ZXL+bVntzFGdFOdjUXLJBqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGVIfXEliShsjCw682ahaXt0WPepX2DibaCoV0pLvpkrgt1WeOGOXTPqg9y9aXSvPRKpLVcHc1CjdZiKoVmx0AUnSuP3VIjj0E+pvL3J8G0jPgL8tJ/pcbvaaODdjo4JE8hQVf7GiaJcDn+XAXMr00+TLyx6vQs3i8+hsD8/RgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beHC2N0g; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707143187; x=1738679187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=um9Vx8F751cSpatd8MK+ZXL+bVntzFGdFOdjUXLJBqg=;
  b=beHC2N0gV7fYZXUuf54+uLUjNrekzE6YuC+rTX+9vMDO7vN6SkkxfGS3
   BlkIv0dZJWUdOGnaQuxhE1L/0IyHz+87icibP0nwKYxAG4+2usOAkc7Zt
   bm9hDPJvzS7p62kcU4kTRG2WjkBBQHd/Tv3JzHjMn7k+f4CHSm7DQsq1W
   iPYXMbTCaHRbVx+m58WtgzZrTXZDYwWyqxgakZv62YnCX05tiIkNUK7XD
   W8uRkydQroJ8KxKultIo2PZiehbbCXDdd3XtmDnP+U+BVU2HS2ev+8vvd
   ELnDiJsQbOj4du3J48YxsUPC4YO7R+sGVp1gufaSryVVO4jj+KBW0j3QS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="787668"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="787668"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5473011"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.21.219])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:26:23 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Date: Mon,  5 Feb 2024 15:26:12 +0100
Message-ID: <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
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

Add cond_guard() macro to conditional guards.

cond_guard() is a guard to be used with the conditional variants of locks,
like down_read_trylock() or mutex_lock_interruptible().

It takes a statement (or more statements in a block) that is passed to its
second argument. That statement (or block) is executed if waiting for a
lock is interrupted or if a _trylock() fails in case of contention.

Usage example:

	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);

Consistently with the other guards, locks are unlocked at the exit of the
scope where cond_guard() is called.

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 include/linux/cleanup.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..88af56600325 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(name, fail, args...):
+ *	a guard to be used with the conditional variants of locks, like
+ *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
+ *	statements that are executed when waiting for a lock is interrupted or
+ *	when a _trylock() fails in case of contention.
+ *
+ *	Example:
+ *
+ *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define cond_guard(_name, _fail, args...) \
+	CLASS(_name, scope)(args); \
+	if (!__guard_ptr(_name)(&scope)) _fail
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


