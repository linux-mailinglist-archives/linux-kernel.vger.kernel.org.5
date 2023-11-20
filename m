Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D507F21C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjKTX4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjKTXz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:55:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C8CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:55:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05943C433C7;
        Mon, 20 Nov 2023 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700524551;
        bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Pt33pMEF/POpoykTVCH0esLyYbbCA2/MuiuNDDhdvAugx8KFmw1tKn0bSGo7z/oz+
         uTpvArUvH/uYX6qe3ShTmgtb/T6RI1JePjh5tg6z8p4WQUWyFTWhQGtSjDAQi6USTW
         qKzFTWEAc1f0yTUnxW2TqUOqSj/TDffFDIrcVSJSKvu2b/rm32KMmTLetFUaxI2qal
         zzcfIzZ92zr1qyK6uxLuX4aO0Furel8hX3pF/t4W7FuxsrDGCs2C30kEhECaAG59Vm
         kYB+l7BGTqAm8k9FyACmKx1cePKJkZg6iGWC2yRou1kXBfFGtINk7Ro4mDGyALeYtE
         TEMF/bL6tIPNg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 20 Nov 2023 23:54:32 +0000
Subject: [PATCH RFT v3 4/5] selftests/clone3: Allow tests to flag if -E2BIG
 is a valid error code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-clone3-shadow-stack-v3-4-a7b8ed3e2acc@kernel.org>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
In-Reply-To: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        bsegall@google.com, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlW/Hhnma1u0qT3kkylcajBZLZYCk8NKYNAoP26I5f
 MjRNpjiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVvx4QAKCRAk1otyXVSH0GubB/
 930Z/P0fuK5MX34Cy4dkfAwusyWEBKeRlq5NwdEPpqMld6z0jmCDctq4ZM5xWaF1ZYbS+rLB1ZAuHU
 OWz4yL3h9ZysR3RtjxxJCdN+91hooUs0KMPMZjkwQ6b5Zlxd9VIP1oOqU1cyZCEEidqERh2jRelK+E
 bF31tT3a+VziuPw1P7FBseViqvx+pKNyUIkdof/DR2OnHkxe0578uGYGat1WoJnmImpaoO/qV7mJVy
 HcGbCOl/Djx4qpYi5WjVW0f6UgWHpRjRIqfxCLzpwG5+O7EMUGTWuh3ngitrCL7rb4jJnZ/QqDNu2I
 +xNCeJWCK33IoNahE8vywB6sFw8MZH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clone_args structure is extensible, with the syscall passing in the
length of the structure. Inside the kernel we use copy_struct_from_user()
to read the struct but this has the unfortunate side effect of silently
accepting some overrun in the structure size providing the extra data is
all zeros. This means that we can't discover the clone3() features that
the running kernel supports by simply probing with various struct sizes.
We need to check this for the benefit of test systems which run newer
kselftests on old kernels.

Add a flag which can be set on a test to indicate that clone3() may return
-E2BIG due to the use of newer struct versions. Currently no tests need
this but it will become an issue for testing clone3() support for shadow
stacks, the support for shadow stacks is already present on x86.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 1108bd8e36d6..6adbfd14c841 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -39,6 +39,7 @@ struct test {
 	size_t size;
 	size_function size_function;
 	int expected;
+	bool e2big_valid;
 	enum test_mode test_mode;
 	filter_function filter;
 };
@@ -141,6 +142,11 @@ static void test_clone3(const struct test *test)
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, test->expected);
 	if (ret != test->expected) {
+		if (test->e2big_valid && ret == -E2BIG) {
+			ksft_print_msg("Test reported -E2BIG\n");
+			ksft_test_result_skip("%s\n", test->name);
+			return;
+		}
 		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
 			getpid(), ret, test->expected);

-- 
2.30.2

