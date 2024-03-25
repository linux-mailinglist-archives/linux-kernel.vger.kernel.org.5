Return-Path: <linux-kernel+bounces-117386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D588AABF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FA02C7016
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027DD130A54;
	Mon, 25 Mar 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3qeQ5ot"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970121304AD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381017; cv=none; b=K744/741lbUH77LEOqEwpGjYOUxvlnCvcNQsB7u4NTz8qTcVsHrF7qOLHgnibpr98vDHr79SR+nuKWGqKEfgRMo7OUddeOloB0LTD5wGIdn0X80XRhXHeLD0ZXvjdf6nXDPBmhWFBmFNkvKQ/pl0LpSE59w2DYcc1iHq2dtr9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381017; c=relaxed/simple;
	bh=wMsPr5Ua8rI3QCm1XRXIe808ikAt5n5DeLEZcsm/1xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTKKfI8tSE1UtTnavcx33x+od+7X7RhWH5ArhDEGpdyQWWO6s1gpcewI0BV3eRziMmY2zJJJzLE2xToZlVkMkOWVxIIIKGpm9tEFmaGAKk8peponm3ixw54rvU7iE8J9bEMi93/MYkOHLNmhyIYW91Yvca4iX0y5FZ+MO8tkxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3qeQ5ot; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381016; x=1742917016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMsPr5Ua8rI3QCm1XRXIe808ikAt5n5DeLEZcsm/1xw=;
  b=d3qeQ5otQonddW59pMPvmNTbyLB3gP4pu06TfJVzuKFZRH7djIo0GJYI
   rBJ/+on70+vtjduzL79AveoZC57Y25POFGzGcB3+B+OZikIdR9GJiMAyB
   /sH7AblbBKgPhcwqgRsjh8OIZRozpB+7sjed5CD1BnV7kvdUjfP7Z6cCn
   QiAIe9cCyf98TIWdz76LwSL05+d4vg/iSdOvAx8YyqZJAhGoextnD5jpt
   tP8/xB/HIX4MDOn+qpsoYGlIgcwPsae3ayy9JNasMu/6Ipn5kLUG+HU1m
   OPnHD2DDqx2FfU2y773ycFSFtGd4AYgxYPOj/LYGKQQuuK7Oyb9JLq6jU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17125100"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17125100"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15523966"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:53 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [RFC 3/4] kernel/panic: initialize taint_flags[] using a macro
Date: Mon, 25 Mar 2024 17:36:34 +0200
Message-Id: <aa0bc2c9c23debf78b6319e3d7bc73f96385125c.1711380724.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1711380724.git.jani.nikula@intel.com>
References: <cover.1711380724.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Make it easier to extend struct taint_flags in follow-up.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/panic.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d2d5f0a4b514..e1f87ba51ba1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -473,32 +473,40 @@ void panic(const char *fmt, ...)
 
 EXPORT_SYMBOL(panic);
 
+#define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
+	[ TAINT_##taint ] = {						\
+		.c_true = _c_true, .c_false = _c_false,			\
+		.module = _module,					\
+	}
+
 /*
  * TAINT_FORCED_RMMOD could be a per-module flag but the module
  * is being removed anyway.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
-	[ TAINT_PROPRIETARY_MODULE ]	= { 'P', 'G', true },
-	[ TAINT_FORCED_MODULE ]		= { 'F', ' ', true },
-	[ TAINT_CPU_OUT_OF_SPEC ]	= { 'S', ' ', false },
-	[ TAINT_FORCED_RMMOD ]		= { 'R', ' ', false },
-	[ TAINT_MACHINE_CHECK ]		= { 'M', ' ', false },
-	[ TAINT_BAD_PAGE ]		= { 'B', ' ', false },
-	[ TAINT_USER ]			= { 'U', ' ', false },
-	[ TAINT_DIE ]			= { 'D', ' ', false },
-	[ TAINT_OVERRIDDEN_ACPI_TABLE ]	= { 'A', ' ', false },
-	[ TAINT_WARN ]			= { 'W', ' ', false },
-	[ TAINT_CRAP ]			= { 'C', ' ', true },
-	[ TAINT_FIRMWARE_WORKAROUND ]	= { 'I', ' ', false },
-	[ TAINT_OOT_MODULE ]		= { 'O', ' ', true },
-	[ TAINT_UNSIGNED_MODULE ]	= { 'E', ' ', true },
-	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
-	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
-	[ TAINT_AUX ]			= { 'X', ' ', true },
-	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
-	[ TAINT_TEST ]			= { 'N', ' ', true },
+	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),
+	TAINT_FLAG(FORCED_MODULE,		'F', ' ', true),
+	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
+	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
+	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
+	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
+	TAINT_FLAG(USER,			'U', ' ', false),
+	TAINT_FLAG(DIE,				'D', ' ', false),
+	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
+	TAINT_FLAG(WARN,			'W', ' ', false),
+	TAINT_FLAG(CRAP,			'C', ' ', true),
+	TAINT_FLAG(FIRMWARE_WORKAROUND,		'I', ' ', false),
+	TAINT_FLAG(OOT_MODULE,			'O', ' ', true),
+	TAINT_FLAG(UNSIGNED_MODULE,		'E', ' ', true),
+	TAINT_FLAG(SOFTLOCKUP,			'L', ' ', false),
+	TAINT_FLAG(LIVEPATCH,			'K', ' ', true),
+	TAINT_FLAG(AUX,				'X', ' ', true),
+	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
+	TAINT_FLAG(TEST,			'N', ' ', true),
 };
 
+#undef TAINT_FLAG
+
 static void print_tainted_seq(struct seq_buf *s)
 {
 	int i;
-- 
2.39.2


