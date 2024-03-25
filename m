Return-Path: <linux-kernel+bounces-117385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C002F88AABD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C24A341ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3313048C;
	Mon, 25 Mar 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP8b42En"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7112EBC0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381013; cv=none; b=j2DqAvKT4+KR++HequSbqpT5BhNb5kMCiLRxTetw4Xqd9laGuGH9bU+HZSC6wTC/9az3s2IMIJaggL8NiYtLasP2d76NoYtRBzly3IMt/dmlGmLN/AN1iNk5VF+hdsjvYLA88ZZj1TZTXt7awIF17Hezx/tb+aVZRiNAUC4r5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381013; c=relaxed/simple;
	bh=ZSTkalsFKnRIcJYK2kiX5ohZP7T+Nr/VG9RYwgkXnBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpcYFvGk9HxDwWG4W8kWcoBxjZG87cGwA0YA9m/fZBUS+/j2SrljdlHj8PSHmPy9rOwrd11hvmY3pBCHgWcpjdigZcURMOMOW2CkFGLy06/5x17h5fu0ug7I3JA/e0mJk7eavgzuhqVwGfY9bhQNMh+gTFVJ2JQU8EWJcepSDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP8b42En; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381011; x=1742917011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSTkalsFKnRIcJYK2kiX5ohZP7T+Nr/VG9RYwgkXnBw=;
  b=eP8b42EnSp80EcA2nXsoeNn4QBzrXVS6marpubZfw/NIMoJxMoEnEINb
   mOxzuTJO0Kpq2Wx4i9igt/Jn/e1MN+mJ3rZDUqhc55Zo6ObaCng6ZXX1a
   7XkIAxMEBf5oDwyf0u1bw5ItN5kViDIdz9NPinEgBBBLDUVgCGdu2Ikxr
   Vm2Qhrf4lDKJeiGm33othjLCP0qjE8lCilkvJoYhZk+UVvNJ22K4V9sJJ
   aKtG94XePhRGrYdrj3dwYvOioH+hT8agmRQghEqHb76KuWfJ4vgBR0kL1
   Fmp2AQLtPCcQIB0Ytm80bQEh9AoMUf8QYVe47e9ufM9n96jMbX+huDTj1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17125068"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17125068"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15523911"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:48 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [RFC 2/4] kernel/panic: convert print_tainted() to use struct seq_buf internally
Date: Mon, 25 Mar 2024 17:36:33 +0200
Message-Id: <aeed348204d6729e95eedb0766349ec30c0f162c.1711380724.git.jani.nikula@intel.com>
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

Convert print_tainted() to use struct seq_buf internally in order to be
more aware of the buffer constraints as well as make it easier to extend
in follow-up work.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/panic.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index b6d4d1da1eaa..d2d5f0a4b514 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -35,6 +35,7 @@
 #include <linux/debugfs.h>
 #include <linux/sysfs.h>
 #include <linux/context_tracking.h>
+#include <linux/seq_buf.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -498,6 +499,25 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_TEST ]			= { 'N', ' ', true },
 };
 
+static void print_tainted_seq(struct seq_buf *s)
+{
+	int i;
+
+	if (!tainted_mask) {
+		seq_buf_puts(s, "Not tainted");
+		return;
+	}
+
+	seq_buf_printf(s, "Tainted: ");
+	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
+		const struct taint_flag *t = &taint_flags[i];
+		bool is_set = test_bit(i, &tainted_mask);
+		char c = is_set ? t->c_true : t->c_false;
+
+		seq_buf_putc(s, c);
+	}
+}
+
 /**
  * print_tainted - return a string to represent the kernel taint state.
  *
@@ -509,25 +529,15 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 const char *print_tainted(void)
 {
 	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
-	char *s;
-	int i;
+	struct seq_buf s;
 
 	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
 
-	if (!tainted_mask) {
-		snprintf(buf, sizeof(buf), "Not tainted");
-		return buf;
-	}
+	seq_buf_init(&s, buf, sizeof(buf));
 
-	s = buf + sprintf(buf, "Tainted: ");
-	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		const struct taint_flag *t = &taint_flags[i];
-		*s++ = test_bit(i, &tainted_mask) ?
-			t->c_true : t->c_false;
-	}
-	*s = 0;
+	print_tainted_seq(&s);
 
-	return buf;
+	return seq_buf_str(&s);
 }
 
 int test_taint(unsigned flag)
-- 
2.39.2


