Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16342771ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjHGGty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHGGtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85504172E;
        Sun,  6 Aug 2023 23:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C23BF61535;
        Mon,  7 Aug 2023 06:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159A7C433C7;
        Mon,  7 Aug 2023 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691390968;
        bh=r1kiR+KjqDLtmOAaDSQxCBhtcw9dswgV4izZmdOM1Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZDp5Q6Wc+6KhxpUkYKmxmFvUpByimb9llAXebgNNuupQGPEAI73hjF15B+SGXeYR
         xbiL91BtegOzZizqd50E+XPsCxISnYG5R8HxXdjeHO0+hZDp0mHRL43/EYJdozzSoB
         OH3DRLY7EHvRKizBb4LHgkdoVBj+HzF6n+nWobsEyeeMS0baw4I6OAN2lY0nX7Eggs
         VNnq6lhODI4Jsn2yx8VvwX3Txdp2ULYbVf1PuEs15t9p4dsWsElNP2HTk8Nwx/jI5X
         QObZVxaZFoPUqiJzbk1lP9cYJRwNY3ukbjRlpC1stvH9JIiY+5YtQnrI3olkQehEir
         WyB+RAl2R8+RA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH v2 5/6] ftrace: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date:   Mon,  7 Aug 2023 15:49:22 +0900
Message-Id: <169139096244.324433.7237290521765120297.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169139090386.324433.6412259486776991296.stgit@devnote2>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add ftrace_partial_regs() which converts the ftrace_regas to pt_regs.
If the architecture defines its own ftrace_regs, this copies partial
registers to pt_regs and returns it. If not, ftrace_regs is the same as
pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/arm64/include/asm/ftrace.h |   11 +++++++++++
 include/linux/ftrace.h          |   11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ab158196480c..b108cd6718cf 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
 	fregs->pc = fregs->lr;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	memcpy(regs->regs, fregs->regs, sizeof(u64) * 10);
+	regs->sp = fregs->sp;
+	regs->pc = fregs->pc;
+	regs->x[29] = fregs->fp;
+	regs->x[30] = fregs->lr;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 3fb94a1a2461..7f45654441b7 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -155,6 +155,17 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
+	defined(CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS)
+
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	return arch_ftrace_get_regs((struct ftrace_regs *)fregs);
+}
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS */
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.

