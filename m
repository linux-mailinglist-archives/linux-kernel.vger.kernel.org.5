Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6143805C8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbjLEQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjLEQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:52:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000B1BC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:52:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE3C43395;
        Tue,  5 Dec 2023 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795131;
        bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZpUDsu/gGH6ZGhP9cXtxB8gBn3cxvyrnrUOintXu3ZZrSaHCs8qRIXupSINmCpfUh
         846d3+ZMad0mZykp6K+gOovMoSft79eXj1fZIg/xHlZGuWVl/tyZdZD4mNyfK4/CB0
         DPj41zC2d35OPBxDeD+tKYDVsLniqoApuWpHaCNQHrbvtPf96EP++z5ec3Ef/z1Dgq
         ArE7Q/afqcIZuAtccqiZ/8HeAT6JF1eY+K5G8T9Aej4fd26ZZ2if8PoJJyZxXtorfy
         KtmIh9NxhPvxqvLLKRN1wVpm5pdBEoxhURJYrpnXv7/T52VoIdvvY0sHLgMfnyCfv/
         PoNWHEHpRWZiQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:16 +0000
Subject: [PATCH v3 18/21] kselftest/arm64: Add basic FPMR test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-18-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=broonie@kernel.org;
 h=from:subject:message-id; bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1T3N1wZN4P2CQcVjSstLn6/YJVwzBLjLmzSxEb2
 XL6y31aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U9wAKCRAk1otyXVSH0N9BB/
 48ypUja9VhWG+STqzkQIzv+ZXUf162KBvyWlJMmXM0Rp84aagmPl6s5PPEjv5iBxffH7BOElybFarw
 glT+4XbWU838fvBGSV8HO/XvzXDxRmpF1MSMeEl6yPZa7nshi5hn7HYBoJa1YA5wZI5cPKE70EVXHG
 E/wBsEbYlXPQKaedX6GI4LBknQSSajl/3G384Lw63tJoOxZ8kSCHdwLpy8IuEhf2ZJ41yyCUKt8FxB
 xClbglVOPbCb+JEIBmI6tLF7iwyiFxKEMG2baObBfODU1ziFr1nghcshxoirGj6jy6uZeVVIQwgn2y
 W26VfUs0EM+m/Xewq//3E1Kzb7BI89
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that a FPMR frame is generated on systems that support FPMR and not
generated otherwise.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          | 82 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 839e3a252629..1ce5b5eac386 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mangle_*
 fake_sigreturn_*
+fpmr_*
 sme_*
 ssve_*
 sve_*
diff --git a/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
new file mode 100644
index 000000000000..e9d24685e741
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ *
+ * Verify that the FPMR register context in signal frames is set up as
+ * expected.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <asm/sigcontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+
+#define SYS_FPMR "S3_3_C4_C4_2"
+
+static uint64_t get_fpmr(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, " SYS_FPMR "\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
+
+int fpmr_present(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct fpmr_context *fpmr_ctx;
+	size_t offset;
+	bool in_sigframe;
+	bool have_fpmr;
+	__u64 orig_fpmr;
+
+	have_fpmr = getauxval(AT_HWCAP2) & HWCAP2_FPMR;
+	if (have_fpmr)
+		orig_fpmr = get_fpmr();
+
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	fpmr_ctx = (struct fpmr_context *)
+		get_header(head, FPMR_MAGIC, td->live_sz, &offset);
+
+	in_sigframe = fpmr_ctx != NULL;
+
+	fprintf(stderr, "FPMR sigframe %s on system %s FPMR\n",
+		in_sigframe ? "present" : "absent",
+		have_fpmr ? "with" : "without");
+
+	td->pass = (in_sigframe == have_fpmr);
+
+	if (have_fpmr && fpmr_ctx) {
+		if (fpmr_ctx->fpmr != orig_fpmr) {
+			fprintf(stderr, "FPMR in frame is %llx, was %llx\n",
+				fpmr_ctx->fpmr, orig_fpmr);
+			td->pass = false;
+		}
+	}
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "FPMR",
+	.descr = "Validate that FPMR is present as expected",
+	.timeout = 3,
+	.run = fpmr_present,
+};

-- 
2.30.2

