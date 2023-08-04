Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2376FBF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjHDI0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjHDI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:26:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8695730E0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691137585; x=1722673585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOKhR2UGvbPRHxNgYwLaRfSIwQ0Gyd6LYZcMKMFhKWQ=;
  b=ResE7mYAXbqhbH0c3BBb9SaOuQIeXhH9h3nAgnc/kpTMlgkIgOJ1OeBe
   N6x3p6yscqtG+Tm6K6DLlkH0/Wnfn3puSUJld+6p/NBECV+tzOte3A1CU
   /TGBbeVNELxROIDrQK8eRX9qczFA4D0ozhX1D8lvgLDY4sueuw+SDi4uu
   WE2F1K5An4IQGoFOrx2hd0bgMv07UA0ZDj7/M2inj9hQLGJaHV6Jq3YP1
   QaTv1CqK9SAcieZBvOSRzX/93lfJPsPZPkkRMQdqKdoQbLhy3gkN9BaGu
   IeKWf3762c0juWNkivmehS30w/k4HKPO26C+m+oC4D60M6fz4JlMkJ1pu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370090212"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370090212"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="733132237"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="733132237"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 01:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99899F12; Fri,  4 Aug 2023 11:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 4/4] lib/vsprintf: Split out sprintf() and friends
Date:   Fri,  4 Aug 2023 11:26:19 +0300
Message-Id: <20230804082619.61833-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
sprintf() and friends are used in many drivers without need of the full
kernel.h dependency train with it.

Here is the attempt on cleaning it up by splitting out sprintf() and
friends.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h  | 30 +-----------------------------
 include/linux/sprintf.h | 24 ++++++++++++++++++++++++
 lib/vsprintf.c          |  1 +
 3 files changed, 26 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/sprintf.h

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b9e76f717a7e..cee8fe87e9f4 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -29,6 +29,7 @@
 #include <linux/panic.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
+#include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
 #include <asm/byteorder.h>
@@ -203,35 +204,6 @@ static inline void might_fault(void) { }
 
 void do_exit(long error_code) __noreturn;
 
-extern int num_to_str(char *buf, int size,
-		      unsigned long long num, unsigned int width);
-
-/* lib/printf utilities */
-
-extern __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
-extern __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
-extern __printf(3, 4)
-int snprintf(char *buf, size_t size, const char *fmt, ...);
-extern __printf(3, 0)
-int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
-extern __printf(3, 4)
-int scnprintf(char *buf, size_t size, const char *fmt, ...);
-extern __printf(3, 0)
-int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
-extern __printf(2, 3) __malloc
-char *kasprintf(gfp_t gfp, const char *fmt, ...);
-extern __printf(2, 0) __malloc
-char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
-extern __printf(2, 0)
-const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
-
-extern __scanf(2, 3)
-int sscanf(const char *, const char *, ...);
-extern __scanf(2, 0)
-int vsscanf(const char *, const char *, va_list);
-
-extern int no_hash_pointers_enable(char *str);
-
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
new file mode 100644
index 000000000000..00d1fdc70a3e
--- /dev/null
+++ b/include/linux/sprintf.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_SPRINTF_H_
+#define _LINUX_KERNEL_SPRINTF_H_
+
+#include <linux/types.h>
+
+int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
+
+__printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
+__printf(2, 0) int vsprintf(char *buf, const char *, va_list);
+__printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
+__printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
+__printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
+__printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
+__printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
+
+__scanf(2, 3) int sscanf(const char *, const char *, ...);
+__scanf(2, 0) int vsscanf(const char *, const char *, va_list);
+
+int no_hash_pointers_enable(char *str);
+
+#endif	/* _LINUX_KERNEL_SPRINTF_H */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index eb0934d02722..e553bc9e18f3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -34,6 +34,7 @@
 #include <linux/property.h>
 #include <linux/rtc.h>
 #include <linux/siphash.h>
+#include <linux/sprintf.h>
 #include <linux/stdarg.h>
 #include <linux/string_helpers.h>
 #include <linux/time.h>
-- 
2.40.0.1.gaa8946217a0b

