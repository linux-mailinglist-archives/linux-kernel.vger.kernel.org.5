Return-Path: <linux-kernel+bounces-38164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B615D83BBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF581F21DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7EF1947E;
	Thu, 25 Jan 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4swk/Qy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A217BAE;
	Thu, 25 Jan 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171007; cv=none; b=oUJnI4I1l/ru8Qn8yX5zHcs8r1yG3EOTkGR8mJ6SA11uEfQxR0R5lWTh4nKCwi3XpD6uxETQevJS/NvKK5uVK/gMIqISQt+BlCE+G7/k1ghACnZAZSvsoE9KD5FT6zos602EqGvpT1TqI2xrCKj0pSS4HDvn36vhRo+b6fyZiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171007; c=relaxed/simple;
	bh=33Nygko1fox8iV52wVuBrn97aPDqalW86iUYduaw+zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0hicEPRmZhojbaok5MRkzK3Bksn6BfJnZl6xErLDGgRpoPwyPxHm60cWUDI0ZVn8J/EmT0213SZ0me+YyBU3h3V29s2BeAtm6sgXctoL4aIiXeQ5sb1L8dL2iOICoNWkrJsrXZ6QLQhyBuQFa06P/124cEy8rPtSZ+YF7TKnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4swk/Qy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706171006; x=1737707006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=33Nygko1fox8iV52wVuBrn97aPDqalW86iUYduaw+zg=;
  b=m4swk/QyswG6OJZzdpQHvtqnJSDsn/+jM8LDJLcLTwnaQUSbSt9qqr+j
   r6o/VZAvabX7CldQhzu7PYwfls5nHwov6YIXEIqmC5QmsGB/jqqckwv9/
   xESNgeBHrIJm0DPhPa0skS+0xqU4P7/Bk9XSH+vhYmh5iyGUiTVKkjP9b
   5WVu8EetH7aYX3qnO19UJ6bXue4tYSnSc+0b+/eC7IqR6c+xJD0hhiJzp
   +mmm2KlCADWJTY0hqLg0GEBJbosKytlUQcDWPsLouPegCMo8LEiigRWtM
   x5q3Iu6lq7UVdvoCKiI03iPw0wY4PfkOA+rvYz2EzlOO+VsJd5O7leJ5Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1987179"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1987179"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876975929"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="876975929"
Received: from araj-ucode.jf.intel.com ([10.23.0.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:23 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	markgross@kernel.org
Cc: Jithu Joseph <jithu.joseph@intel.com>,
	rostedt@goodmis.org,
	ashok.raj@intel.com,
	tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	patches@lists.linux.dev,
	pengfei.xu@intel.com
Subject: [PATCH 3/5] platform/x86/intel/ifs: Add current batch number to trace output
Date: Thu, 25 Jan 2024 00:22:52 -0800
Message-Id: <20240125082254.424859-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125082254.424859-1-ashok.raj@intel.com>
References: <20240125082254.424859-1-ashok.raj@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the current batch number in the trace output. When there are failures,
it's important to know which test content resulted in failure.

#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
     migration/0-18      [000] d..1. 527287.084668: ifs_status: batch: 02, start: 0000, stop: 007f, status: 0000000000007f80
   migration/128-785     [128] d..1. 527287.084669: ifs_status: batch: 02, start: 0000, stop: 007f, status: 0000000000007f80

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/intel_ifs.h         | 9 ++++++---
 drivers/platform/x86/intel/ifs/runtest.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index 8462dfb7a020..8ce2de120f2d 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -10,23 +10,26 @@
 
 TRACE_EVENT(ifs_status,
 
-	TP_PROTO(int start, int stop, u64 status),
+	TP_PROTO(int batch, int start, int stop, u64 status),
 
-	TP_ARGS(start, stop, status),
+	TP_ARGS(batch, start, stop, status),
 
 	TP_STRUCT__entry(
+		__field(	int,	batch	)
 		__field(	u64,	status	)
 		__field(	u16,	start	)
 		__field(	u16,	stop	)
 	),
 
 	TP_fast_assign(
+		__entry->batch	= batch;
 		__entry->start	= start;
 		__entry->stop	= stop;
 		__entry->status	= status;
 	),
 
-	TP_printk("start: %.4x, stop: %.4x, status: %.16llx",
+	TP_printk("batch: %.2d, start: %.4x, stop: %.4x, status: %.16llx",
+		__entry->batch,
 		__entry->start,
 		__entry->stop,
 		__entry->status)
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index c8352ffb9195..21dc0046fd9b 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -176,7 +176,7 @@ static int doscan(void *data)
 	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
 	rdmsrl(MSR_SCAN_STATUS, status.data);
 
-	trace_ifs_status(start, stop, status.data);
+	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
 
 	/* Pass back the result of the scan */
 	if (cpu == first)
-- 
2.39.2


