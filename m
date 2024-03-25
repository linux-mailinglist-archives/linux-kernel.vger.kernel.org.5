Return-Path: <linux-kernel+bounces-117387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF8588AABE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405381C392F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110256E61D;
	Mon, 25 Mar 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCpXN8qz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327F1304AD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381023; cv=none; b=hikvVHxyIuZGonjCot+zwXc/uCxrDJd6PICYIs9viHN+in7/QgXOgE/25iS+hik3QjKVPE+JESiqVnr0vjjlQhG0qz4qIwoCf+RbZt62TKDimg+Cmb78Y54NDHxGAlV9ABYDrzd1qwW9dghfGvI8s34g6fk3p/ZYmKi6ofeCWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381023; c=relaxed/simple;
	bh=wb4kr08JDH+NnZLnT1A79izRE8BGA+Rpd9wAnH4wDR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGN9KUxf80VkhZlu8Jc9AyiZjr0XIyKAq3krlLVNIzF7yMwMo5D+eG+z1FjmURdK/37LIyVfYaVDUVd3h6a3eBSWfuZr6GthnNs5EMBNJLWj++KdVYhk/6GvXTzOxt2lq4VLRTIKXV5G1/MjD69Wm872C1Q+gZ0Wpek3RazWa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCpXN8qz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381021; x=1742917021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wb4kr08JDH+NnZLnT1A79izRE8BGA+Rpd9wAnH4wDR8=;
  b=eCpXN8qzYwjjjQdWacQxyybs6iu3GBIE3pUnuThRqotjYRyiwMb5QEvY
   e11B5Da38PQ5m95E11bLmIYTxslyorBGgs8Dz1iYsES4J0uDweBG9eYpm
   M6N7VZ/4hCce+eFMwnFmUmy+W3FIJY75Ts2pFGpEUI1EqHrqqtTNoxJFB
   Xze0bJpwDxTvX/hN7v1zoiQAanj3SA7vlhWIh7OQy2o/GwWsE9n6zUL1M
   dL/QZrzTJucAYutVWZ28NlElll6SJE0emdj5ZNJybJO/C3946Xnkwn4Sl
   3uU4CKSGG3y7AUPr8x2iLayRtc1SNQA5lGc0G9+zx9S/ncctARqH2Rqkz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6221664"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6221664"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:37:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="38758551"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:59 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [RFC 4/4] kernel/panic: add verbose logging of kernel taints in backtraces
Date: Mon, 25 Mar 2024 17:36:35 +0200
Message-Id: <e0d275c30e97ddf943c2d797c4004673fbc82002.1711380724.git.jani.nikula@intel.com>
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

With nearly 20 taint flags and respective characters, it's getting a bit
difficult to remember what each taint flag character means. Add verbose
logging of the set taints in the format:

Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN

in dump_stack_print_info() when there are taints.

Note that the "negative flag" G is not included.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/panic.h |  8 +++++---
 kernel/panic.c        | 45 ++++++++++++++++++++++++++++++++-----------
 lib/dump_stack.c      |  3 +++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6717b15e798c..3130e0b5116b 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -77,9 +77,10 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
-	char c_true;	/* character printed when tainted */
-	char c_false;	/* character printed when not tainted */
-	bool module;	/* also show as a per-module taint flag */
+	char c_true;		/* character printed when tainted */
+	char c_false;		/* character printed when not tainted */
+	bool module;		/* also show as a per-module taint flag */
+	const char *desc;	/* verbose description of the set taint flag */
 };
 
 extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
@@ -90,6 +91,7 @@ enum lockdep_ok {
 };
 
 extern const char *print_tainted(void);
+extern const char *print_tainted_verbose(void);
 extern void add_taint(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index e1f87ba51ba1..ed270d3b5f2b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -477,6 +477,7 @@ EXPORT_SYMBOL(panic);
 	[ TAINT_##taint ] = {						\
 		.c_true = _c_true, .c_false = _c_false,			\
 		.module = _module,					\
+		.desc = #taint,						\
 	}
 
 /*
@@ -507,8 +508,9 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 
 #undef TAINT_FLAG
 
-static void print_tainted_seq(struct seq_buf *s)
+static void print_tainted_seq(struct seq_buf *s, bool verbose)
 {
+	const char *sep = "";
 	int i;
 
 	if (!tainted_mask) {
@@ -522,10 +524,32 @@ static void print_tainted_seq(struct seq_buf *s)
 		bool is_set = test_bit(i, &tainted_mask);
 		char c = is_set ? t->c_true : t->c_false;
 
-		seq_buf_putc(s, c);
+		if (verbose) {
+			if (is_set) {
+				seq_buf_printf(s, "%s[%c]=%s", sep, c, t->desc);
+				sep = ", ";
+			}
+		} else {
+			seq_buf_putc(s, c);
+		}
 	}
 }
 
+static const char *_print_tainted(bool verbose)
+{
+	/* FIXME: what should the size be? */
+	static char buf[sizeof(taint_flags)];
+	struct seq_buf s;
+
+	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
+
+	seq_buf_init(&s, buf, sizeof(buf));
+
+	print_tainted_seq(&s, verbose);
+
+	return seq_buf_str(&s);
+}
+
 /**
  * print_tainted - return a string to represent the kernel taint state.
  *
@@ -536,16 +560,15 @@ static void print_tainted_seq(struct seq_buf *s)
  */
 const char *print_tainted(void)
 {
-	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
-	struct seq_buf s;
-
-	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
-
-	seq_buf_init(&s, buf, sizeof(buf));
-
-	print_tainted_seq(&s);
+	return _print_tainted(false);
+}
 
-	return seq_buf_str(&s);
+/**
+ * print_tainted_verbose - A more verbose version of print_tainted()
+ */
+const char *print_tainted_verbose(void)
+{
+	return _print_tainted(true);
 }
 
 int test_taint(unsigned flag)
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 222c6d6c8281..8b6b70eaf949 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -62,6 +62,9 @@ void dump_stack_print_info(const char *log_lvl)
 	       (int)strcspn(init_utsname()->version, " "),
 	       init_utsname()->version, BUILD_ID_VAL);
 
+	if (get_taint())
+		printk("%s%s\n", log_lvl, print_tainted_verbose());
+
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
 		       log_lvl, dump_stack_arch_desc_str);
-- 
2.39.2


