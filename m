Return-Path: <linux-kernel+bounces-69815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B81858EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CABE1C211B7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B215D729;
	Sat, 17 Feb 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+MpTSB+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A159B6C;
	Sat, 17 Feb 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167563; cv=none; b=iJbEN3xHJlwZHTY/CWgi50MhBnQsRmf70SkDiGe3N/ZJ1l4E1wyekyG21aom99LrzIkJ7iCjQPtIO/hNi95Au43ujVnITKvkBykwpeoRRVYjPMZOOxMFoks03bv9ivz+9alNaVhPyxjwcICDzr7uYCmUoHamVuuYaagQi40h3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167563; c=relaxed/simple;
	bh=XF+WjLg4KIqsngigqVAPUzNcgTjwiRifxdEA0ayezwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyJxdjDF+6rh2PUWKw0s7z0WMEPYjeKnlkXvTL++MUecfcJQH1aAyMX3UrgPfx1uNqR/WAjoRujnnQXoxouVlom1ZBhhaSaRq7cUqG11NRXmd1YtByGYDJq+/fGjHyBSyRBumFS60LaC1o9p81ZbZa7I9Yrhu5pSqng+fmIpHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+MpTSB+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708167561; x=1739703561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XF+WjLg4KIqsngigqVAPUzNcgTjwiRifxdEA0ayezwg=;
  b=H+MpTSB+GsqBssNOGC8aQYTz+CJXwIXdmpFEWVwO5mhPP2PMpBlrL2Wj
   QrmtPbIPtiJSwlkZUELavPjaTbth9Fx2J6uoZC49B9/BLuk8Djp+3Sog9
   w/WsyVmjY07/ir3wnjRtRlsvEC5/srBFfnW6yEr4kkCpv/9pwgEUVitaA
   EkRQYfZ5M+ClGgor4wR3Z/P65YBXNgo71tZIsy7M2wEIkH27E+utmGzRr
   Vk7xIfgcI3f7stLND9DtTWvQq6inn/ZBqR3+mgQdkWs1Cz2ipcZQeBdAI
   OonjokmdGz0zlmQLD+cbK57iQWjw8t0R/J2mAGTmRje92PnyEmB3HHFYh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="27746704"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="27746704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="4348712"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.3.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:59:18 -0800
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
Subject: [PATCH 1/3 v5] cleanup: Add cond_guard() to conditional guards
Date: Sat, 17 Feb 2024 11:59:02 +0100
Message-ID: <20240217105904.1912368-2-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240217105904.1912368-1-fabio.maria.de.francesco@linux.intel.com>
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

Consistent with other usage of _guard(), locks are unlocked at the exit of
the scope where cond_guard() is called. This macro can be called multiple
times in the same scope.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 include/linux/cleanup.h | 20 ++++++++++++++++++++
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
-- 
2.43.2


