Return-Path: <linux-kernel+bounces-83648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9268869CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C17B2B13C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F918487BF;
	Tue, 27 Feb 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD90jN7Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A8487A5;
	Tue, 27 Feb 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052536; cv=none; b=eDV9cmQ2MhkLLj/WUr1YD8E9h4Z7YZy1kc8b9xiHgL9SwVvkZK9z2E7p2z8Vu7sJtxijKqf78h/m+b8pJrcfV8q2WNYe9mlTxwm/JLimwq6/gQdj02MVh/nHaj0ShW7xMfzi2wauhoxaN3ka7kwmvzEj+4uEmyYnFzc0KdFHR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052536; c=relaxed/simple;
	bh=6DJ8zNycy4XqO4nhbI6pzWZYZ6PRv0j+XW33IcU7Q/k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yyp3TiitmmJQh95HTmKZoa6Jfbb0XRSlViOAgEvNt7ZEpk+YL3SW7u70DPPtkMNf78Vq96TxBlkaPQ9YYgj++hn4zWxxfuIP9Y57reSMFKvnjBadw7vF8BtV4N02FQY+s1V6wvNtQUNEA5G+wT+y+XAg4SNOBF8BelJxMZB4OLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD90jN7Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709052535; x=1740588535;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DJ8zNycy4XqO4nhbI6pzWZYZ6PRv0j+XW33IcU7Q/k=;
  b=HD90jN7QyymSen/a5MM+f/Y+2wjP/BQi+UrWr3lnZDFdi6JDSY9EwTSn
   VOuFDfhG3QleuUtJlsLyaeFA8ONFA1SLhe5lMrpJNqZsAGYeWaMOglTb+
   mfCenKCyPTexOZTiSoQyWFGoNX1WbCJyf1Sokgw2ctQwuIm219BvoszYu
   3yQFkM8jQNuQWJNkx4GbAoHfkJ7r2QfFTLFduYe/Urt+N9JaFL4gk2tBH
   5TIImFSLvEGW+rbN+vt/wj4op44jTJaKoOeC0wwZCP3ZaeFHxMqSU5hvq
   JmYTVtxFL9RlUcCGEJX6dJdf0xA9Sg7QJBFVZZfjm9uJQqKHvLG36vLnR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20948825"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20948825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7536097"
Received: from sshaik-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.88.67])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:48:54 -0800
Subject: [PATCH 1/3] cleanup: Add cond_guard() to conditional guards
From: Dan Williams <dan.j.williams@intel.com>
To: torvalds@linux-foundation.org, peterz@infradead.org,
 gregkh@linuxfoundation.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Date: Tue, 27 Feb 2024 08:48:53 -0800
Message-ID: <170905253339.2268463.9376907713092612237.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Add cond_guard() macro to conditional guards.

cond_guard() is a guard to be used with the conditional variants of locks,
like down_read_trylock() or mutex_lock_interruptible().

It takes a statement (or statement-expression) that is passed as its
second argument. That statement (or statement-expression) is executed if
waiting for a lock is interrupted or if a _trylock() fails in case of
contention.

Usage example:

	cond_guard(mutex_intr, return -EINTR, &mutex);

Consistent with other usage of _guard(), locks are unlocked at the exit of
the scope where cond_guard() is called. This macro can be called multiple
times in the same scope.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/cleanup.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..602afb85da34 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,19 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(name, fail, args...):
+ *	a guard to be used with the conditional variants of locks, like
+ *	down_read_trylock() or mutex_lock_interruptible(). 'fail' is a
+ *	statement or statement-expression that is executed if waiting for a
+ *	lock is interrupted or if a _trylock() fails in case of contention.
+ *
+ *	Example:
+ *
+ *		cond_guard(mutex_intr, return -EINTR, &mutex);
+ *
+ * 	This macro can be called multiple times in the same scope, for it
+ * 	declares unique instances of type 'name'.
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -165,6 +178,13 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
 
+#define __cond_guard(__unique, _name, _fail, args...) \
+	CLASS(_name, __unique)(args); \
+	if (!__guard_ptr(_name)(&__unique)) _fail; \
+	else { }
+#define cond_guard(_name, _fail, args...) \
+	__cond_guard(__UNIQUE_ID(scope), _name, _fail, args)
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)


