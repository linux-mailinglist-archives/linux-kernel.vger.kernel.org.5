Return-Path: <linux-kernel+bounces-51828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A896848FC0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4FD1C21BB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB6250EA;
	Sun,  4 Feb 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQXBhZxB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F424205;
	Sun,  4 Feb 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067879; cv=none; b=NuEzr8g4gS5OUkptRgPh9oZ5l2odzXYqTxvK8DPQnSqPwhtzcPJ4sGmjEOq9xYhME2or9hQiU3jTrTFUqys12r6dTwek9Y79RiLX6O0cZY4HuEWgNcQ+VpiQsl5X2mqVezbFQd7x8S5FtWgOKJhHy7eR8NslITOSnlZTZIrMYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067879; c=relaxed/simple;
	bh=p7G9lDJWvB8+q1rJ6NP2F0RKeAhxis7arnOWlFYNUv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9MTH/DTdUMxSDtJd+oR9I5i8dMioGWzL1byykEm+74p5xgTxSQNEndgeMMWguP2L5xVRr9kYdfuXZ2wmZcTsKD5gWk/RZwAq8JtWKmAR8OJXdyEAhHxn9/RFJFz0VQpvCfR5zElQW3tRozuLBzM8w3zl8pSMGFbj84e5Vrs5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQXBhZxB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707067878; x=1738603878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7G9lDJWvB8+q1rJ6NP2F0RKeAhxis7arnOWlFYNUv4=;
  b=MQXBhZxBCG91LWkCi+TZggWjilUPfljdMBCBdwSoWijEhmeYJwejSJyR
   6BuYhwcPLRX+z7zeUyp0mNPPxqzKDW/qcSNoD+LTM+m8jqY0Muu7g3hq1
   k1DBN8UQ30Kf474K5FNEf/CTkJJE5+qTBBj7ESRjQp2EaUqoyYdPvkldy
   60K9sJjQrzAdV8nvSGNF+rO0RaTEeS8UGST2ku99W5A/KKJ7rE4XgD9nz
   uWb+32zTI145RUVCysHoWrVv5d/3nDM1G52dV7UMbhb7875Axup3f0Suq
   grtY3RU+7VDkQSZ4ici8N20I01YzJhCl+KVdTM4ntSm2+e1SBhuIrwdGt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4225903"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4225903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 09:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31626383"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.213.2.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 09:31:15 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 1/2] cleanup: Add cond_guard() to conditional guards
Date: Sun,  4 Feb 2024 18:31:04 +0100
Message-ID: <20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
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

Consistenly with the other guards, locks are unlocked at the exit of the
scope where cond_guard() is called.

Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 include/linux/cleanup.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..3826e8ed4e09 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * cond_guard(name, fail, args...):
+ *	a guard to be used with the conditional variants of locks, like
+ *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
+ *	statements that are executed if waiting for a lock is interrupted or
+ *	if a _trylock() fails in case of contention.
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
 
+#define cond_guard(_name, _ret, args...) \
+	CLASS(_name, scope)(args); \
+	if (!__guard_ptr(_name)(&scope)) _ret
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
 	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-- 
2.43.0


