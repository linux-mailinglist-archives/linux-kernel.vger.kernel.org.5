Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F37ABAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjIVVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIVVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:12:10 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8BE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:12:03 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 9BCBFC60DC4E; Fri, 22 Sep 2023 14:11:50 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 2/2] mm/ksm: Test case for prctl fork/exec workflow
Date:   Fri, 22 Sep 2023 14:11:41 -0700
Message-Id: <20230922211141.320789-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922211141.320789-1-shr@devkernel.io>
References: <20230922211141.320789-1-shr@devkernel.io>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 66 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/te=
sting/selftests/mm/ksm_functional_tests.c
index 901e950f9138..fbff0dd09191 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -26,6 +26,7 @@
=20
 #define KiB 1024u
 #define MiB (1024 * KiB)
+#define FORK_EXEC_CHILD_PRG_NAME "ksm_fork_exec_child"
=20
 static int mem_fd;
 static int ksm_fd;
@@ -479,6 +480,64 @@ static void test_prctl_fork(void)
 	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
 }
=20
+static int ksm_fork_exec_child(void)
+{
+	/* Test if KSM is enabled for the process. */
+	return prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0) =3D=3D 1;
+}
+
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
+		char *prg_name =3D "./ksm_functional_tests";
+		char *argv_for_program[] =3D { prg_name, FORK_EXEC_CHILD_PRG_NAME };
+
+		execv(prg_name, argv_for_program);
+		return;
+	}
+
+	if (waitpid(child_pid, &status, 0) > 0) {
+		if (WIFEXITED(status)) {
+			status =3D WEXITSTATUS(status);
+			if (status) {
+				ksft_test_result_fail("KSM not enabled\n");
+				return;
+			}
+		} else {
+			ksft_test_result_fail("program didn't terminate normally\n");
+			return;
+		}
+	} else {
+		ksft_test_result_fail("waitpid() failed\n");
+		return;
+	}
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0)) {
+		ksft_test_result_fail("PR_SET_MEMORY_MERGE=3D0 failed\n");
+		return;
+	}
+
+	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
+}
+
 static void test_prctl_unmerge(void)
 {
 	const unsigned int size =3D 2 * MiB;
@@ -536,9 +595,13 @@ static void test_prot_none(void)
=20
 int main(int argc, char **argv)
 {
-	unsigned int tests =3D 7;
+	unsigned int tests =3D 8;
 	int err;
=20
+	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
+		exit(ksm_fork_exec_child() =3D=3D 1 ? 0 : 1);
+	}
+
 #ifdef __NR_userfaultfd
 	tests++;
 #endif
@@ -576,6 +639,7 @@ int main(int argc, char **argv)
=20
 	test_prctl();
 	test_prctl_fork();
+	test_prctl_fork_exec();
 	test_prctl_unmerge();
=20
 	err =3D ksft_get_fail_cnt();
--=20
2.39.3

