Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6C76FBF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjHDI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjHDI01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:26:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07C468C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691137586; x=1722673586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uw2Ld+AeDxNhMI9Z37vKGF4a6VjahNfcrZb6asDNsiE=;
  b=mC848biGolxTU//b5meWB1Si295wqlpxTsgNzpPxOWQuNK8qmhZNl3m1
   +NbiUoebLllBnC3c+h7/6X77HYD+Mqyf13croL4qJUS3JSuqDCY27lWWl
   Lwl0DBuMVJuN456tDHuLpLY1SSGFVkMeztR7s5CcVmRPDpoFtRFg4zySH
   9Zx0l+ui1hwbmYdCQ/Gz/kc4Y0X2Rr0ve9ZXdjCw9UcQsK8pXHxTildHJ
   lEMmIdJqJaX0HuEzVsb8c8wtVk1eBOVuJaFOO0yxZj39uyHm7dA7Py1yu
   FwPwGvC1VwMV/3LX9ayBbiR3rCmrEt4eUZKu7TMEwDTTFFWVcn+xu4y8H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433952152"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="433952152"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706907756"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="706907756"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2023 01:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 78DB16A6; Fri,  4 Aug 2023 11:26:32 +0300 (EEST)
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
Subject: [PATCH v1 1/4] lib/vsprintf: Declare no_hash_pointers in a local header
Date:   Fri,  4 Aug 2023 11:26:16 +0300
Message-Id: <20230804082619.61833-2-andriy.shevchenko@linux.intel.com>
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

Sparse is not happy to see non-static variable without declaration:
lib/vsprintf.c:61:6: warning: symbol 'no_hash_pointers' was not declared. Should it be static?

Declare respective variable in the local header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c  | 4 ++--
 lib/vsprintf.c     | 1 +
 lib/vsprintf.h     | 7 +++++++
 mm/kfence/report.c | 3 +--
 4 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 lib/vsprintf.h

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7677ebccf3c3..9e04b5f7244a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -24,6 +24,8 @@
 
 #include <linux/property.h>
 
+#include "vsprintf.h"
+
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define BUF_SIZE 256
@@ -41,8 +43,6 @@ KSTM_MODULE_GLOBALS();
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
 
-extern bool no_hash_pointers;
-
 static int __printf(4, 0) __init
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 40f560959b16..6774cf84e623 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -54,6 +54,7 @@
 
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
+#include "vsprintf.h"
 
 /* Disable pointer hashing if requested */
 bool no_hash_pointers __ro_after_init;
diff --git a/lib/vsprintf.h b/lib/vsprintf.h
new file mode 100644
index 000000000000..ddffde905824
--- /dev/null
+++ b/lib/vsprintf.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LIB_VSPRINTF_H
+#define _LIB_VSPRINTF_H
+
+extern bool no_hash_pointers;
+
+#endif
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 197430a5be4a..fb28c6abd58e 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -19,6 +19,7 @@
 
 #include <asm/kfence.h>
 
+#include "../../lib/vsprintf.h"
 #include "kfence.h"
 
 /* May be overridden by <asm/kfence.h>. */
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

