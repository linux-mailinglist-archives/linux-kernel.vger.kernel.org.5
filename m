Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAC7C76EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442326AbjJLTcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442234AbjJLTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C881E7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073CC433C9;
        Thu, 12 Oct 2023 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139155;
        bh=hZNkroqVhoawwPACvTUVa/MKwFIx2Jxc6e1KjEDkELY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTQLpg9zucvzO538bAz31SeEGzSdtCQ1Ks+j6SgMQNejW2n32Cltc9ExlJH8aHHSz
         bAola8e+q4QN4S7IghJe7TZ3+4ZJ/l/XCgFjuP95K89Scshhsx9yxFMoN9EEnGSkZw
         yIA2WESVtGWx3yitrXO158HknH9krt5rq4G15d385OOZ9AKLeV9aVWiqd5j7krG6F+
         STl8BI/dHUM0+x3gbYUgoK+Xsot7EQ8MT0hZmb+zlcUnvy575OwrcCwgka+As1A5dF
         2NVl89fmH+S5cY36dWkkdTKS9bx+FOuZyq0CsL6wtg7tSLGJYsyFZ4TbFQcLDsl/MY
         yZTc2CrDOZl2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 45500CE0AD2; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 04/19] tools/nolibc: add stdarg.h header
Date:   Thu, 12 Oct 2023 12:32:18 -0700
Message-Id: <20231012193233.207857-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

This allows nolic to work with `-nostdinc` avoiding any reliance on
system headers.

The implementation has been lifted from musl libc 1.2.4.
There is already an implementation of stdarg.h in include/linux/stdarg.h
but that is GPL licensed and therefore not suitable for nolibc.

The used compiler builtins have been validated to be at least available
since GCC 4.1.2 and clang 3.0.0.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile |  1 +
 tools/include/nolibc/nolibc.h |  4 ++--
 tools/include/nolibc/stdarg.h | 16 ++++++++++++++++
 tools/include/nolibc/stdio.h  |  3 +--
 tools/include/nolibc/sys.h    |  2 +-
 5 files changed, 21 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/nolibc/stdarg.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 909b6eb500fe..e69c26abe1ea 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -34,6 +34,7 @@ all_files := \
 		signal.h \
 		stackprotector.h \
 		std.h \
+		stdarg.h \
 		stdint.h \
 		stdlib.h \
 		string.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 1f8d821000ac..989e707263a4 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -74,10 +74,10 @@
  *            -I../nolibc -o hello hello.c -lgcc
  *
  * The available standard (but limited) include files are:
- *   ctype.h, errno.h, signal.h, stdio.h, stdlib.h, string.h, time.h
+ *   ctype.h, errno.h, signal.h, stdarg.h, stdio.h, stdlib.h, string.h, time.h
  *
  * In addition, the following ones are expected to be provided by the compiler:
- *   float.h, stdarg.h, stddef.h
+ *   float.h, stddef.h
  *
  * The following ones which are part to the C standard are not provided:
  *   assert.h, locale.h, math.h, setjmp.h, limits.h
diff --git a/tools/include/nolibc/stdarg.h b/tools/include/nolibc/stdarg.h
new file mode 100644
index 000000000000..c628b5783da6
--- /dev/null
+++ b/tools/include/nolibc/stdarg.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Variadic argument support for NOLIBC
+ * Copyright (C) 2005-2020 Rich Felker, et al.
+ */
+
+#ifndef _NOLIBC_STDARG_H
+#define _NOLIBC_STDARG_H
+
+typedef __builtin_va_list va_list;
+#define va_start(v, l)   __builtin_va_start(v, l)
+#define va_end(v)        __builtin_va_end(v)
+#define va_arg(v, l)     __builtin_va_arg(v, l)
+#define va_copy(d, s)    __builtin_va_copy(d, s)
+
+#endif /* _NOLIBC_STDARG_H */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index cae402c11e57..d7ef43973916 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -7,13 +7,12 @@
 #ifndef _NOLIBC_STDIO_H
 #define _NOLIBC_STDIO_H
 
-#include <stdarg.h>
-
 #include "std.h"
 #include "arch.h"
 #include "errno.h"
 #include "types.h"
 #include "sys.h"
+#include "stdarg.h"
 #include "stdlib.h"
 #include "string.h"
 
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index fdb6bd6c0e2f..b478750c9004 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -7,7 +7,6 @@
 #ifndef _NOLIBC_SYS_H
 #define _NOLIBC_SYS_H
 
-#include <stdarg.h>
 #include "std.h"
 
 /* system includes */
@@ -25,6 +24,7 @@
 
 #include "arch.h"
 #include "errno.h"
+#include "stdarg.h"
 #include "types.h"
 
 
-- 
2.40.1

