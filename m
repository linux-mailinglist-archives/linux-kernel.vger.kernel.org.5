Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9177BDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjHNQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHNQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:27:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FDA8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692030419; x=1723566419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LZQOx7C238eM5ntkHv1oYly7+slLbIPiN9FmjDzt/5w=;
  b=OZtFS995ela5AfMPt3G+Nf33d9jQtR2i7BmCGzcg6yPLewDPuInWzfzU
   +gJYu/Wb+l98RqRKYhLjYpS6KdhIHbFqct3+lWFPqQaJve6zIn1zbBMVj
   hzgjJIJP/7yzJp1ixMQJxr4Ymh6vzaBZ6RJK/rDt6t/qoaCfYJvCGobeL
   tIT1lFu5L8P3U4w+dTRhJNILEZbf72cXpbITo1eYDBrNHwHJB8pQcPFXz
   BY/BVV4BAsodi/9PUYM7v0oDZxTM1fZkraM0NVhNCF/Ywm2ctZdDfRnxU
   S9o1vcYgPSEStBiAEMyflX2sApAS+coisDfCbJsKGj6A5ybXp900GZX6l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438415049"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438415049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736565824"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736565824"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 09:26:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 62A54370; Mon, 14 Aug 2023 19:33:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/2] lib/vsprintf: Split out sprintf() and friends
Date:   Mon, 14 Aug 2023 19:33:43 +0300
Message-Id: <20230814163344.17429-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230814163344.17429-1-andriy.shevchenko@linux.intel.com>
References: <20230814163344.17429-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/sprintf.h | 25 +++++++++++++++++++++++++
 lib/test_printf.c       |  1 +
 lib/vsprintf.c          |  1 +
 4 files changed, 28 insertions(+), 29 deletions(-)
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
index 000000000000..9ca23bcf9f42
--- /dev/null
+++ b/include/linux/sprintf.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_SPRINTF_H_
+#define _LINUX_KERNEL_SPRINTF_H_
+
+#include <linux/compiler_attributes.h>
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
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7677ebccf3c3..ce749cfac033 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -12,6 +12,7 @@
 #include <linux/random.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
+#include <linux/sprintf.h>
 #include <linux/string.h>
 
 #include <linux/bitmap.h>
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40f560959b16..afb88b24fa74 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -34,6 +34,7 @@
 #include <linux/dcache.h>
 #include <linux/cred.h>
 #include <linux/rtc.h>
+#include <linux/sprintf.h>
 #include <linux/time.h>
 #include <linux/uuid.h>
 #include <linux/of.h>
-- 
2.40.0.1.gaa8946217a0b

