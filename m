Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38307EB74F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjKNUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjKNUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3861A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:06:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0514EC433C7;
        Tue, 14 Nov 2023 20:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699992401;
        bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Uxh8I9pcemFU+yGRtS7Vuo8DeS1M2BfZvhrOG5xhsC6Vl9YyuKMKsy6cEUNGdNfiv
         YmA3bhEelh6LltyPaU9bt3Zc3Lg3i0sjQu9Zwd7nzaVlur7sQZ70zDACZyeTab0nm2
         dYQCYAY7bxQ6e77mhy4d2sMZjrl3x4mjjvQgv6fqT1RWKnja7bFeIBoZBnfkz79M8t
         pahN+VpPRyQrkpJSMfwLojoddj2xVk0MDgpJlE5I3DF5TQ9lHSxgt94f8gOmTvIjLR
         XTiOU+i0gIO0xfAHPC7G4I7x3lpMx865OJ2rAlENPzHA48GKK10BLFPoG2+w92sY3P
         zU/cCwv7UzeQg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 20:05:57 +0000
Subject: [PATCH RFC RFT v2 4/5] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-clone3-shadow-stack-v2-4-b613f8681155@kernel.org>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU9MvjU45KxHk6MXI07uEtQfGL2f1juaDoVQx1uQt
 jstsNW6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVPTLwAKCRAk1otyXVSH0Cn2B/
 9NNiANJ4S5XcTNlqQbxd9WuKQLoSseYwhfB+36m1g1HI6ZznOzMdea9h1Mw5JQ4ab4pNSnRgZSJ+uX
 7ViidqykpVO08D3UL5GDOfiTf+5qsshyDTU822KPe4CV40HJlVyaS/hHqiT5b1V7f0j/X501W+iEBi
 N2c9NmMSgFTMPwbfDm078r34xcxrNsRq2PnhO7RsS4aC461EufZRU4KhF3FqI+tGBgEdGW4gAlVBOD
 AaCdWmgGOc3CuiDQK33lkd06u7bHZAGM1J96SbZAmWcAbXHizTMc5jCafHbgNWM+Kkdbb+m0oMStL7
 bRS0J5f9pVElfhbFo0IcbtqUrqkZJD
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

