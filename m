Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77B57C60F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjJKXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjJKXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:13:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A6AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697066029;
        bh=3Asz/9K6lSQ6yuDvssERdpNPh6T7AlEfx+cPmP4YpDg=;
        h=From:Date:Subject:To:Cc:From;
        b=MULKEnwlv15MaNKqkDGlRLb49Xpw6Mbr8k3+vMD3CNxmmKokwGbSkcV8TqKIBNAmq
         JgaFdXivAt2mqG58YiUfsf7qBbLGZaVXcOuYJ4/0eq3hH9+G9JNBt9TkhEvNQ6LQpW
         atqHzG625nnVLXocrFm+FV3KsAI+DSceBWrSLmTI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 12 Oct 2023 01:13:37 +0200
Subject: [PATCH] selftests/nolibc: add tests for multi-object linkage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACAsJ2UC/x2MTQqAIBQGrxJvneBPRHSVaJH2VY/CQiMC8e5Jy
 2GYSRQRGJH6KlHAw5FPX0DVFblt8isEz4VJS22UVFr482DrxMF+n4q9EW/RdLBodWsWWCrlFbD
 w+1+HMecPUqCcuGUAAAA=
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697066028; l=4748;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3Asz/9K6lSQ6yuDvssERdpNPh6T7AlEfx+cPmP4YpDg=;
 b=EkUqZysYQqZ1VQVIDDAqlColxK3SI2GI84lPgdHwc/SngVc1Ld2I4BBpjCC6x+jpdeLFBy6Qc
 hPofArPJkCLAtGi81kaLmbykG5QIlM3arSPiRBfpmlCxloaPya+OK1u
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While uncommon, nolibc executables can be linked together from multiple
compilation units.
Add some tests to make sure everything works in that case.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Note:

This depends on path "tools/nolibc: mark start_c as weak".
https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
---
 tools/testing/selftests/nolibc/Makefile            | 12 ++++-----
 .../testing/selftests/nolibc/nolibc-test-linkage.c | 30 ++++++++++++++++++++++
 .../testing/selftests/nolibc/nolibc-test-linkage.h |  9 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c       |  4 +++
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index af60e07d3c12..2600b4f3bed3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -171,17 +171,17 @@ sysroot/$(ARCH)/include:
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
 ifneq ($(NOLIBC_SYSROOT),0)
-nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
+nolibc-test: nolibc-test.c nolibc-test-linkage.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include $< -lgcc
+	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include nolibc-test.c nolibc-test-linkage.c -lgcc
 else
-nolibc-test: nolibc-test.c
+nolibc-test: nolibc-test.c nolibc-test-linkage.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $< -lgcc
+	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $< -lgcc nolibc-test.c nolibc-test-linkage.c -lgcc
 endif
 
-libc-test: nolibc-test.c
-	$(QUIET_CC)$(HOSTCC) -o $@ $<
+libc-test: nolibc-test.c nolibc-test-linkage.c
+	$(QUIET_CC)$(HOSTCC) -o $@ nolibc-test.c nolibc-test-linkage.c
 
 # local libc-test
 run-libc-test: libc-test
diff --git a/tools/testing/selftests/nolibc/nolibc-test-linkage.c b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
new file mode 100644
index 000000000000..871db3d22713
--- /dev/null
+++ b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "nolibc-test-linkage.h"
+
+#ifndef NOLIBC
+#include <stdio.h>
+#ifndef _NOLIBC_STDIO_H
+/* standard libcs need more includes */
+#include <errno.h>
+#endif
+#endif
+
+void *linkage_test_errno_addr(void)
+{
+	return &errno;
+}
+
+int linkage_test_constructor_test_value;
+
+__attribute__((constructor))
+static void constructor1(void)
+{
+	linkage_test_constructor_test_value = 2;
+}
+
+__attribute__((constructor))
+static void constructor2(void)
+{
+	linkage_test_constructor_test_value *= 3;
+}
diff --git a/tools/testing/selftests/nolibc/nolibc-test-linkage.h b/tools/testing/selftests/nolibc/nolibc-test-linkage.h
new file mode 100644
index 000000000000..c66473070d73
--- /dev/null
+++ b/tools/testing/selftests/nolibc/nolibc-test-linkage.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NOLIBC_TEST_LINKAGE_H
+#define _NOLIBC_TEST_LINKAGE_H
+
+void *linkage_test_errno_addr(void);
+extern int linkage_test_constructor_test_value;
+
+#endif /* _NOLIBC_TEST_LINKAGE_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8da7f15d010e..2f10541e6f38 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -41,6 +41,8 @@
 #endif
 #endif
 
+#include "nolibc-test-linkage.h"
+
 /* for the type of int_fast16_t and int_fast32_t, musl differs from glibc and nolibc */
 #define SINT_MAX_OF_TYPE(type) (((type)1 << (sizeof(type) * 8 - 2)) - (type)1 + ((type)1 << (sizeof(type) * 8 - 2)))
 #define SINT_MIN_OF_TYPE(type) (-SINT_MAX_OF_TYPE(type) - 1)
@@ -647,6 +649,8 @@ int run_startup(int min, int max)
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
 		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
+		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
+		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 6); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

---
base-commit: e76716696ba0c5c41667a11caa092cd619a79c5b
change-id: 20231012-nolibc-linkage-test-48ebe6263feb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

