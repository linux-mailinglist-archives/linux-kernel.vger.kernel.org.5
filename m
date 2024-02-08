Return-Path: <linux-kernel+bounces-58104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497C84E157
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA311F2153D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9D76412;
	Thu,  8 Feb 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx+aWCBT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB74763E4;
	Thu,  8 Feb 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397479; cv=none; b=GNIcQOfsl8B/cYq18mQFzByP9Nu5EDOCY8hL6x00jZOmZYG7yukJQAIp50XC+4RPyHLTRmiu9tbTMsEWu4+BPwtSSP86gxiUN4tKbpBxwDXFcX78wYMGWhp85ZUiS10zyTpkGHWKj1vSSC98z1AN2KD35JMmqlnzRre2+EWy0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397479; c=relaxed/simple;
	bh=3nWZ+AvAgVTv540Fkbwwjic5kaTrkMjBgX1KoIMMW1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPPpyuKg+isfndO3LMaEI8USeL78xHkH1A8H+t5A05wTPjF3B9tOlvlK8YEgQihzl3Zp3ZzycOe91qLI+jWIxjgwrQBW9TtnNn+lbpLDLNbFgYFZPSxOFV4Oj4lCaxN1LoWwpRTCM57NXrc1ruDfphlniSCg6aSPqbHN/yzuT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx+aWCBT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707397478; x=1738933478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3nWZ+AvAgVTv540Fkbwwjic5kaTrkMjBgX1KoIMMW1Q=;
  b=mx+aWCBTC8hOCtoDOM2eNnhBsChuiOtAUb4y8Skro4HM016hMhOM+tG+
   GCM6ekEcYFaR0wuqXKHLIyGv8XmO4qZpoGiRRH5JLLMqojdSozdlxlcNC
   /VvPYuaOxb3tZWHQvfnClAhgZ3ZHMeazDYegiZxcfqVl9aQNJ3AW6uunR
   UWBlpjsUvpycg4OhHVHrlcBQVjOAk4V2dvRL16ur/KA0lcr8XjA3MH5lE
   20mb787Mjzn4w0o03U5s12CYS9SuAl6/qZaopKjv1WwFE4fVIaY2YfJJz
   k4RwHhJI1npnk51cDNT9uIeJjdFRs0QY7645UX5Gk2xutJ+evp+ghyk1R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1354950"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1354950"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1884034"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.2.200])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:04:33 -0800
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
Subject: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Date: Thu,  8 Feb 2024 14:04:23 +0100
Message-ID: <20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
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

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 include/linux/cleanup.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..7b54ee996414 100644
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
+	else { }
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


