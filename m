Return-Path: <linux-kernel+bounces-83649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F5869CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871CC1C2319B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF024E1CE;
	Tue, 27 Feb 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8VI4qwy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5E4DA11;
	Tue, 27 Feb 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052542; cv=none; b=KdnjMZPFVsUhDTajleaucKbVXdBixZOZUi3Eicni3zdGPdlxkRZCQbtcrzJ1pkRAAWZ4BX0VuqWqwpFyHVo7v77BmwYxYsjZbI3EYPy2lJvM+cEoN14Cw30nOrs/ymSPpTTB6r+TN7Yswp0kMxPjXTDsL0BuVoSp8k2Khsy7f5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052542; c=relaxed/simple;
	bh=t/V8GK7RDHUwml/a0vpcMATYt5kJT3OlTetC2L+ouw4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfwXkm9Y0k2axf9zZstx0cWOYN6EY8naLrtCAukqBUBlevFiNDYID11c/BD1nA6CZ/kydlCWci1LaqnjKfE78bPiUvjTKl5rVhb5TETMvUqExsm1zbsoDNhQ18F9GnJ8xC9jzKl0Kgh24MNy6iPhPkLv9Y9CmVs0mH2ydlPMfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8VI4qwy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709052540; x=1740588540;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t/V8GK7RDHUwml/a0vpcMATYt5kJT3OlTetC2L+ouw4=;
  b=C8VI4qwy/r37qbvdSrK5gTmjjbXey5sgA+uPM0BKvD/dnGeSdeKq/8P2
   xDUecFLSVExXRp32aONwVHv2AUohhJXUAKePyC0WLN9arRM+Ag4LH/zTb
   sneUMerhMNIBf7Bxt5k/8EJo2Hv3y2PL3FR5paBdF1P1lHTIioK8435Pr
   28o8Xkmy6Et1IKXRA4nfxLtKCl6h52MriG34mc5nR501jKoWVZzQsmmi3
   lasOTJbNTqe3bmYZ4qH64Yi+6Hxl5LeEZMGXg+j+IzDsCB4WZH5vRbCIo
   Pspzkg0+1jqhaKE+FTRA+GPfeLOBD2HV/puennYv305tPjgSR7rBsWy4a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20948834"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20948834"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7536108"
Received: from sshaik-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.88.67])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:49:00 -0800
Subject: [PATCH 2/3] cleanup: Introduce cond_no_free_ptr()
From: Dan Williams <dan.j.williams@intel.com>
To: torvalds@linux-foundation.org, peterz@infradead.org,
 gregkh@linuxfoundation.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Date: Tue, 27 Feb 2024 08:48:59 -0800
Message-ID: <170905253897.2268463.13371523233762430828.stgit@dwillia2-xfh.jf.intel.com>
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

The no_free_ptr() helper cancels automatic cleanup for cases where
assigning the pointer transfers ownership for freeing it. However, it
gets awkward to use when multiple allocations need to be cancelled in
response to one registration call. For example:

    1/ name = kasprintf(...);
    2/ res = kmalloc(...);
    3/ res->name = name;
    4/ rc = insert_resource(..., res);
    5/ if (rc) return rc;

no_free_ptr() cannot be used for 3 since insert_resource() does not
cleanup on failure. no_free_ptr() could be used at 4, but if
insert_resource() fails, the no_free_ptr() was premature. After 5 is
when it is known that it is safe to free @res and @name. However,
no_free_ptr() is awkward there as well because of __must_check().

The options are:
 * Just open code @res = NULL and @name = NULL, but that is a
   non-idiomatic way to use the cleanup helpers.
 * Introduce a no_free_ptr() variant that drops the __must_check, but
   that defeats the purpose of mandating that the caller understands
   that responsibility for freeing has been handed off.
 * Introduce a new helper that combines a condition check to supersede
   the __must_check of no_free_ptr()

So, per that last option, line 5/ from the example becomes:

    5/ cond_no_free_ptr(rc == 0, return rc, res, name);

..and that handles calling no_free_ptr() while also mandating the
negative condition be handled. It is inspired by scoped_cond_guard()
which also takes a statement for the negative condition case.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/cleanup.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 602afb85da34..a6d593a60611 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -77,6 +77,28 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+#define __cond_no_free_ptrs(p) ({__auto_type __always_unused __ptr = no_free_ptr(p);})
+#define __cond_no_free_ptrs1(p, ...) __cond_no_free_ptrs(p)
+#define __cond_no_free_ptrs2(p, ...) \
+	__cond_no_free_ptrs(p), __cond_no_free_ptrs1(__VA_ARGS__)
+#define __cond_no_free_ptrs3(p, ...) \
+	__cond_no_free_ptrs(p), __cond_no_free_ptrs2(__VA_ARGS__)
+
+/*
+ * When an object is built up by an amalgamation of multiple allocations
+ * each of those need to be cleaned up on error, but there are occasions
+ * where once the object is registered all of those cleanups can be
+ * cancelled.  cond_no_free_ptr() arranges to call no_free_ptr() on all
+ * its arguments (up to 3) if @condition is true and runs @_fail
+ * otherwise (typically to return and trigger auto-cleanup).
+ */
+#define cond_no_free_ptr(condition, _fail, ...)                           \
+	if (condition) {                                                  \
+		CONCATENATE(__cond_no_free_ptrs, COUNT_ARGS(__VA_ARGS__)) \
+		(__VA_ARGS__);                                            \
+	} else {                                                          \
+		_fail;                                                    \
+	}
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):


