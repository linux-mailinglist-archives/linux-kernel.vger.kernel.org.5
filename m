Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77B75A240
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGSWrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGSWrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0D2100;
        Wed, 19 Jul 2023 15:47:31 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=l4RWhdAWwsWIa+mFZoxytst7jOZo6c9Bbjl4iU8esLI=;
        b=VGLkbx8baCev3l2k0sZMtCq2NIRl7h7ilf90PliOJk3Gc/RPxC/5jArSeQQTd1nf01+T2I
        GZKT3hsA82gcv+UVSflsRyz6H63+DkC+ANrEso9oN6QvEo1hzwOlLSvX0Cctubm0/Zt36k
        VaPWYvU/6k6W0mtj4fewrbvbQ4gTGb+MkD6rJDQJfhsBYLTt4ntxE7bF0lcBYmePGxTHtr
        0KmdRUcBa98IktxvmYk6GkrN65xRBlb55ei7QhHoBnwtBMhQc6oa2TqpV+WlStir947QSf
        ZgRWnPNIK/wgfVx3KxQbww2mvYq2nldX0N2jL56NbYysJl6PA7mL/ZYlolI81A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=l4RWhdAWwsWIa+mFZoxytst7jOZo6c9Bbjl4iU8esLI=;
        b=AKvzT7gRTnPseYdiAv0ZPYWMU5CWRSTaMghqrNiRLyw6WY5egFzcAw4XpONxa1T4e7EH+b
        rOHlqfOK38hRrsBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Support WRSS for userspace
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980684880.28540.2080492141070689370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     6f0f8bc06e6a0da3b5e23423fe9633820d99bf95
Gitweb:        https://git.kernel.org/tip/6f0f8bc06e6a0da3b5e23423fe9633820d99bf95
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:01 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:13:24 -07:00

x86/shstk: Support WRSS for userspace

For the current shadow stack implementation, shadow stacks contents can't
easily be provisioned with arbitrary data. This property helps apps
protect themselves better, but also restricts any potential apps that may
want to do exotic things at the expense of a little security.

The x86 shadow stack feature introduces a new instruction, WRSS, which
can be enabled to write directly to shadow stack memory from userspace.
Allow it to get enabled via the prctl interface.

Only enable the userspace WRSS instruction, which allows writes to
userspace shadow stacks from userspace. Do not allow it to be enabled
independently of shadow stack, as HW does not support using WRSS when
shadow stack is disabled.

>From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a #PF err code perspective.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-36-rick.p.edgecombe%40intel.com
---
 arch/x86/include/uapi/asm/prctl.h |  1 +-
 arch/x86/kernel/shstk.c           | 43 +++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 6a8e0e1..eedfde3 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -36,5 +36,6 @@
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+#define ARCH_SHSTK_WRSS			(1ULL <<  1)
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 04c37b3..ea0bf11 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -390,6 +390,47 @@ void shstk_free(struct task_struct *tsk)
 	unmap_shadow_stack(shstk->base, shstk->size);
 }
 
+static int wrss_control(bool enable)
+{
+	u64 msrval;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Only enable WRSS if shadow stack is enabled. If shadow stack is not
+	 * enabled, WRSS will already be disabled, so don't bother clearing it
+	 * when disabling.
+	 */
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return -EPERM;
+
+	/* Already enabled/disabled? */
+	if (features_enabled(ARCH_SHSTK_WRSS) == enable)
+		return 0;
+
+	fpregs_lock_and_load();
+	rdmsrl(MSR_IA32_U_CET, msrval);
+
+	if (enable) {
+		features_set(ARCH_SHSTK_WRSS);
+		msrval |= CET_WRSS_EN;
+	} else {
+		features_clr(ARCH_SHSTK_WRSS);
+		if (!(msrval & CET_WRSS_EN))
+			goto unlock;
+
+		msrval &= ~CET_WRSS_EN;
+	}
+
+	wrmsrl(MSR_IA32_U_CET, msrval);
+
+unlock:
+	fpregs_unlock();
+
+	return 0;
+}
+
 static int shstk_disable(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -406,7 +447,7 @@ static int shstk_disable(void)
 	fpregs_unlock();
 
 	shstk_free(current);
-	features_clr(ARCH_SHSTK_SHSTK);
+	features_clr(ARCH_SHSTK_SHSTK | ARCH_SHSTK_WRSS);
 
 	return 0;
 }
