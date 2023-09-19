Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC407A6C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjISUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjISUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:52:21 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD4B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:52:15 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 5FCBEC361C1F; Tue, 19 Sep 2023 13:51:59 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/2] mm/ksm: Test case for prctl fork/exec workflow
Date:   Tue, 19 Sep 2023 13:51:58 -0700
Message-Id: <20230919205158.1897353-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230919205158.1897353-1-shr@devkernel.io>
References: <20230919205158.1897353-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new test case to the ksm functional tests to make sure that
the KSM setting is inherited by the child process when doing a
fork/exec.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/testing/selftests/mm/Makefile           |  2 +
 .../selftests/mm/ksm_fork_exec_child.c        |  9 ++++
 .../selftests/mm/ksm_functional_tests.c       | 50 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/ksm_fork_exec_child.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
index 6a9fc5693145..9ab6aa402544 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -73,6 +73,8 @@ ifneq ($(ARCH),arm64)
 TEST_GEN_PROGS +=3D soft-dirty
 endif
=20
+TEST_GEN_PROGS +=3D ksm_fork_exec_child
+
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_=
32bit_program.c -m32)
 CAN_BUILD_X86_64 :=3D $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivia=
l_64bit_program.c)
diff --git a/tools/testing/selftests/mm/ksm_fork_exec_child.c b/tools/tes=
ting/selftests/mm/ksm_fork_exec_child.c
new file mode 100644
index 000000000000..298439f0d55f
--- /dev/null
+++ b/tools/testing/selftests/mm/ksm_fork_exec_child.c
@@ -0,0 +1,9 @@
+#include <sys/prctl.h>
+#include <stdlib.h>
+
+int main()
+{
+	/* Test if KSM is enabled for the process. */
+	int ksm =3D prctl(68, 0, 0, 0, 0);
+	exit(ksm =3D=3D 1 ? 0 : 1);
+}
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/te=
sting/selftests/mm/ksm_functional_tests.c
index 901e950f9138..4dc0bb522c07 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -479,6 +479,53 @@ static void test_prctl_fork(void)
 	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
 }
=20
+static void test_prctl_fork_exec(void)
+{
+	int ret, status;
+	pid_t child_pid;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	ret =3D prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
+	if (ret < 0 && errno =3D=3D EINVAL) {
+		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
+		return;
+	} else if (ret) {
+		ksft_test_result_fail("PR_SET_MEMORY_MERGE=3D1 failed\n");
+		return;
+	}
+
+	child_pid =3D fork();
+	if (child_pid =3D=3D -1) {
+		ksft_test_result_skip("fork() failed\n");
+		return;
+	} else if (child_pid =3D=3D 0) {
+		char *filename =3D "./ksm_fork_exec_child";
+		char *argv_for_program[] =3D { filename, NULL };
+
+		execv(filename, argv_for_program);;
+	} else {
+		if (waitpid(child_pid, &status, 0) > 0) {
+			if (WIFEXITED(status)) {
+				status =3D WEXITSTATUS(status);
+				if (status) {
+					ksft_test_result_fail("KSM not enabled\n");
+					return;
+				}
+
+			} else {
+				ksft_test_result_fail("program didn't terminate normally\n");
+				return;
+			}
+		} else {
+			ksft_test_result_fail("waitpid() failed\n");
+			return;
+		}
+	}
+
+	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
+}
+
 static void test_prctl_unmerge(void)
 {
 	const unsigned int size =3D 2 * MiB;
@@ -536,7 +583,7 @@ static void test_prot_none(void)
=20
 int main(int argc, char **argv)
 {
-	unsigned int tests =3D 7;
+	unsigned int tests =3D 8;
 	int err;
=20
 #ifdef __NR_userfaultfd
@@ -576,6 +623,7 @@ int main(int argc, char **argv)
=20
 	test_prctl();
 	test_prctl_fork();
+	test_prctl_fork_exec();
 	test_prctl_unmerge();
=20
 	err =3D ksft_get_fail_cnt();
--=20
2.39.3

