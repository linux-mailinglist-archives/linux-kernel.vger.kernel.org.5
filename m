Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A287E6191
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjKIAoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjKIAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A7B268E;
        Wed,  8 Nov 2023 16:43:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E910C433A9;
        Thu,  9 Nov 2023 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490623;
        bh=xJB21L9dDRQHhaZpwIhtN50CQs4Yf0e5zt5k2dhu4QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUaiXTRL250n6iKIIJWJgFX2BYYc8xHMB8dBKSHWAYgeFFfMXWc1wbELVb7AerlRU
         /1Nm0Bgv24Pip5qHxFO8F8rbh8yBeh+OnfDyYhJwNhdHtkfBUqNvyUMtBKQkALh6uw
         0npc149H7tDMPAZE/ipZa4Vq0j9G2DrraSAu1ynTWnu/s41xBCCEwn8NUFNPODCHhN
         B1KMe4XsBailE7Un+C9aCSEuJLRt+LzB9cgBXjCrA7gmAJoJHj+cROTo57wPzsiPKj
         /dFq2WSeudFYMGr1bTRo2LB/qtMg3+WkUHfZcRIeggimNvJp4gNPbgIxDA6B+8k0/a
         xoCOax2EjJGPw==
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
Subject: [PATCH RFC 07/10] unwind/x86: Add HAVE_USER_UNWIND
Date:   Wed,  8 Nov 2023 16:41:12 -0800
Message-ID: <28efef61435d2fbb42bf26277adae0c630e05cf4.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable HAVE_USER_UNWIND accordinlgy so the user unwind
interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/user_unwind.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/x86/include/asm/user_unwind.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cacf11ac4b10..95939cd54dfe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -278,6 +278,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
+	select HAVE_USER_UNWIND
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
diff --git a/arch/x86/include/asm/user_unwind.h b/arch/x86/include/asm/user_unwind.h
new file mode 100644
index 000000000000..caa6266abbb4
--- /dev/null
+++ b/arch/x86/include/asm/user_unwind.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_USER_UNWIND_H
+#define _ASM_X86_USER_UNWIND_H
+
+#define ARCH_INIT_USER_FP_FRAME						\
+	.ra_off		= sizeof(long) * -1,				\
+	.cfa_off	= sizeof(long) * 2,				\
+	.fp_off		= sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_USER_UNWIND_H */
-- 
2.41.0

