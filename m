Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B97E618F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjKIAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjKIAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA60C6;
        Wed,  8 Nov 2023 16:43:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B19DC433D9;
        Thu,  9 Nov 2023 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490622;
        bh=bFP5wZvQMY9wapcWbDmX8LVc7sfYwfgWM4sJBg6/eKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knFtUxnN6wPG6xhBZpvn0uI8m+GEtw2VjZm+LwHUtH0oFHjlAD9dg2IJQe92+LJVo
         i/zpKNYoU8p5Sp3TMuCWpT8yCJ79V+rCwu1t8S2oaP/09oNux8k0RcklZUJZMcnrTT
         T+7ENIjRESkNZmZNEiCI3Y/AHs7BDLJMAKhOA7pUr3h+URDmu9Zfh7JS7xwo3NKtTA
         S6CxrAXWXae4L/xmchd4/l5dNbNLGruDqq2cUKzGgMyYDKllUxM++1MnWN4JKWByTD
         35wxRDx3MZmsAuKQlRQ7zaOICgNgGOwkcFVfqCSA1a+P6L3Hy3OlocmxzvmlZ7aIAt
         asSagC/Kat+sw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 05/10] perf/x86: Add HAVE_PERF_CALLCHAIN_DEFERRED
Date:   Wed,  8 Nov 2023 16:41:10 -0800
Message-ID: <f19cd074272c3fd160c2d637cc0f65cfffad1e81.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable deferred user space unwinding on x86.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig       |  1 +
 arch/x86/events/core.c | 47 ++++++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..cacf11ac4b10 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -256,6 +256,7 @@ config X86
 	select HAVE_PERF_EVENTS_NMI
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PCI
+	select HAVE_PERF_CALLCHAIN_DEFERRED
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 40ad1425ffa2..ae264437f794 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2816,8 +2816,8 @@ static unsigned long get_segment_base(unsigned int segment)
 
 #include <linux/compat.h>
 
-static inline int
-perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
+static inline int __perf_callchain_user32(struct pt_regs *regs,
+					  struct perf_callchain_entry_ctx *entry)
 {
 	/* 32-bit process in 64-bit kernel. */
 	unsigned long ss_base, cs_base;
@@ -2831,7 +2831,6 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	ss_base = get_segment_base(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
-	pagefault_disable();
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2844,19 +2843,18 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 		perf_callchain_store(entry, cs_base + frame.return_address);
 		fp = compat_ptr(ss_base + frame.next_frame);
 	}
-	pagefault_enable();
 	return 1;
 }
-#else
-static inline int
-perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
+#else /* !CONFIG_IA32_EMULATION */
+static inline int __perf_callchain_user32(struct pt_regs *regs,
+					  struct perf_callchain_entry_ctx *entry)
 {
-    return 0;
+	return 0;
 }
-#endif
+#endif /* CONFIG_IA32_EMULATION */
 
-void
-perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			   struct pt_regs *regs, bool atomic)
 {
 	struct stack_frame frame;
 	const struct stack_frame __user *fp;
@@ -2876,13 +2874,15 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 
 	perf_callchain_store(entry, regs->ip);
 
-	if (!nmi_uaccess_okay())
+	if (atomic && !nmi_uaccess_okay())
 		return;
 
-	if (perf_callchain_user32(regs, entry))
-		return;
+	if (atomic)
+		pagefault_disable();
+
+	if (__perf_callchain_user32(regs, entry))
+		goto done;
 
-	pagefault_disable();
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2895,7 +2895,22 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		perf_callchain_store(entry, frame.return_address);
 		fp = (void __user *)frame.next_frame;
 	}
-	pagefault_enable();
+done:
+	if (atomic)
+		pagefault_enable();
+}
+
+
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
+{
+	return __perf_callchain_user(entry, regs, true);
+}
+
+void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry,
+				  struct pt_regs *regs)
+{
+	return __perf_callchain_user(entry, regs, false);
 }
 
 /*
-- 
2.41.0

