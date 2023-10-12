Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7996F7C76F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442249AbjJLTde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442351AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08073E6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1F2C433B7;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=9AFyv1HVznQ9AGg8+z1evlIaZ1Y1s//n3eBUqbBd0OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI0iPa9XTvj/R2EO+FAijS+buu0vUftTld0QPQNLukmPbr1X7g1Bug8ZNrXwXrmd7
         2iI7bz4ycOXbkK7Ch8gzBAy7fFUHXG4iv7HFWM1fdkonvkdTZLwlZoRZTp8R6Sn1Kn
         LTlAwVEPqMvjbZqElhLBlMKSEsdrb0vn9f0Ptog3Weh9KHNMXwSaup0HRsdwyA2y+K
         AJIMTtjcmHtU2dHLco+x3QuRYNYoqsPdKOmT2mnzPu7bA9ggSoVGvH4h02/dfkGs7Q
         SInBzRTyPIIcH4XgirxvfeeUNLSm0kiiE8d4zVzVymazvs14LnDdajfnlTR1qs34yp
         ic8flnuhLXNqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AFD6CE1059; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 19/19] selftests/nolibc: add tests for multi-object linkage
Date:   Thu, 12 Oct 2023 12:32:33 -0700
Message-Id: <20231012193233.207857-19-paulmck@kernel.org>
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

While uncommon, nolibc executables can be linked together from multiple
compilation units.
Add some tests to make sure everything works in that case.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net/
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile       | 12 ++++-----
 .../selftests/nolibc/nolibc-test-linkage.c    | 26 +++++++++++++++++++
 .../selftests/nolibc/nolibc-test-linkage.h    |  9 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c  |  4 +++
 4 files changed, 45 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test-linkage.c
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test-linkage.h

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index af60e07d3c12..a0fc07253baf 100644
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
+	  -nostdlib -static -include ../../../include/nolibc/nolibc.h nolibc-test.c nolibc-test-linkage.c -lgcc
 endif
 
-libc-test: nolibc-test.c
-	$(QUIET_CC)$(HOSTCC) -o $@ $<
+libc-test: nolibc-test.c nolibc-test-linkage.c
+	$(QUIET_CC)$(HOSTCC) -o $@ nolibc-test.c nolibc-test-linkage.c
 
 # local libc-test
 run-libc-test: libc-test
diff --git a/tools/testing/selftests/nolibc/nolibc-test-linkage.c b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
new file mode 100644
index 000000000000..5ff4c8a1db2a
--- /dev/null
+++ b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "nolibc-test-linkage.h"
+
+#ifndef NOLIBC
+#include <errno.h>
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
-- 
2.40.1

