Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77AC762CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjGZHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjGZHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:10:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB5D2727
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:07:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6726011FB;
        Wed, 26 Jul 2023 00:07:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587463F5A1;
        Wed, 26 Jul 2023 00:07:03 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v1] tools/nolibc/stdio: add setvbuf() to set buffering mode
Date:   Wed, 26 Jul 2023 08:06:55 +0100
Message-Id: <20230726070655.2713530-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a minimal implementation of setvbuf(), which error checks the mode
argument (as required by spec) and returns. Since nolibc never buffers
output, nothing needs to be done.

The kselftest framework recently added a call to setvbuf(). As a result,
any tests that use the kselftest framework and nolibc cause a compiler
error due to missing function. This provides an urgent fix for the
problem which is preventing arm64 testing on linux-next.

Example:

clang --target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=aarch64-linux-gnu -fintegrated-as
-fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
-include ../../../../include/nolibc/nolibc.h -I../..\
-static -ffreestanding -Wall za-fork.c
build/kselftest/arm64/fp/za-fork-asm.o
-o build/kselftest/arm64/fp/za-fork
In file included from <built-in>:1:
In file included from ./../../../../include/nolibc/nolibc.h:97:
In file included from ./../../../../include/nolibc/arch.h:25:
./../../../../include/nolibc/arch-aarch64.h:178:35: warning: unknown
attribute 'optimize' ignored [-Wunknown-attributes]
void __attribute__((weak,noreturn,optimize("omit-frame-pointer")))
__no_stack_protector _start(void)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from za-fork.c:12:
../../kselftest.h:123:2: error: call to undeclared function 'setvbuf';
ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
        setvbuf(stdout, NULL, _IOLBF, 0);
        ^
../../kselftest.h:123:24: error: use of undeclared identifier '_IOLBF'
        setvbuf(stdout, NULL, _IOLBF, 0);
                              ^
1 warning and 2 errors generated.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: ecb7fe2cd610 ("selftests: line buffer test program's stdout")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/linux-kselftest/CA+G9fYus3Z8r2cg3zLv8uH8MRrzLFVWdnor02SNr=rCz+_WGVg@mail.gmail.com/
---
 tools/include/nolibc/stdio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 0eef91daf289..a3778aff4fa9 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -21,6 +21,11 @@
 #define EOF (-1)
 #endif

+/* Buffering mode used by setvbuf.  */
+#define _IOFBF 0	/* Fully buffered. */
+#define _IOLBF 1	/* Line buffered. */
+#define _IONBF 2	/* No buffering. */
+
 /* just define FILE as a non-empty type. The value of the pointer gives
  * the FD: FILE=~fd for fd>=0 or NULL for fd<0. This way positive FILE
  * are immediately identified as abnormal entries (i.e. possible copies
@@ -350,6 +355,25 @@ void perror(const char *msg)
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
 }

+static __attribute__((unused))
+int setvbuf(FILE *stream, char *buf, int mode, size_t size)
+{
+	/*
+	 * nolibc does not support buffering so this is a nop. Just check mode
+	 * is valid as required by the spec.
+	 */
+	switch (mode) {
+	case _IOFBF:
+	case _IOLBF:
+	case _IONBF:
+		break;
+	default:
+		return EOF;
+	}
+
+	return 0;
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"

--
2.25.1

