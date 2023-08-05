Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8D771122
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHERtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHERte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:49:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675E115
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691257773; x=1722793773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9t4+UHB5bV6ky/Acf0xEikn59MqZgagOLuXamRB5Rw0=;
  b=PxSrXk2jjMjoRUK+6Z/XTpumOW/8SiD/OwZIvQtEVE6n5fCf0UdnL1qh
   mscqpilvz6bLkwiCspLsijBZEbkAbhQjqrKmRDV1N1cWY/9Plr8eWsN0c
   pAp2GAzQxa9MthRN+P0ulpqdaeycIXO15FvVvRg8CWdSvUyrjarfYdZH6
   gf0QD9O04VNeLtD3XFEtOaJbNNfxqpx9FmIE76TST8TAJWwTKhaZE6vsQ
   29e6dTS4/LcbaIoUwCKeN8ul541IvyderNZd6iArFy5Avhe1eKCu7WhSC
   Isy5HQgQL1ytF+mMy4s66i9kYG9PmiX+JRwbEWUZZ4/WWiPkqoso2UuFp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="401292537"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="401292537"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 10:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="820494258"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="820494258"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2023 10:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA2F4F12; Sat,  5 Aug 2023 20:50:29 +0300 (EEST)
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
Subject: [PATCH v2 3/3] lib/vsprintf: Declare no_hash_pointers in sprintf.h
Date:   Sat,  5 Aug 2023 20:50:27 +0300
Message-Id: <20230805175027.50029-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse is not happy to see non-static variable without declaration:
lib/vsprintf.c:61:6: warning: symbol 'no_hash_pointers' was not declared. Should it be static?

Declare respective variable in the sprintf.h. With this, add a comment
to discourage its use if no real need.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/sprintf.h | 2 ++
 lib/test_printf.c       | 2 --
 mm/kfence/report.c      | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 9ca23bcf9f42..33dcbec71925 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -20,6 +20,8 @@ __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list
 __scanf(2, 3) int sscanf(const char *, const char *, ...);
 __scanf(2, 0) int vsscanf(const char *, const char *, va_list);
 
+/* These are for specific cases, do not use without real need */
+extern bool no_hash_pointers;
 int no_hash_pointers_enable(char *str);
 
 #endif	/* _LINUX_KERNEL_SPRINTF_H */
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 5adca19d34e2..cf861dc22169 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -39,8 +39,6 @@ KSTM_MODULE_GLOBALS();
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
 
-extern bool no_hash_pointers;
-
 static int __printf(4, 0) __init
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 197430a5be4a..c509aed326ce 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -13,6 +13,7 @@
 #include <linux/printk.h>
 #include <linux/sched/debug.h>
 #include <linux/seq_file.h>
+#include <linux/sprintf.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
 #include <trace/events/error_report.h>
@@ -26,8 +27,6 @@
 #define ARCH_FUNC_PREFIX ""
 #endif
 
-extern bool no_hash_pointers;
-
 /* Helper function to either print to a seq_file or to console. */
 __printf(2, 3)
 static void seq_con_printf(struct seq_file *seq, const char *fmt, ...)
-- 
2.40.0.1.gaa8946217a0b

