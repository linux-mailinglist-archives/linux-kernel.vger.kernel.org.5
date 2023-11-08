Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0957E58C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjKHO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjKHO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:26:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E91FE3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:26:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC408C433C7;
        Wed,  8 Nov 2023 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453596;
        bh=kYKqzLjHb+tdl32thOrnxRAjLrF2/pPf6UROFm/9erg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjOww+q2e4icdTh7kOnha5aJCQ+xmC3qpqj6NZLwtBh/N2dKJnXoj3m27YUzqjsat
         0h63cLvuQzaokadgMJJEDZyj7W/QT2WH9vUA4Lf1kmCkROHCR72QC8bEnxQu66UOzq
         dX90q6lZxHAppOqGgjB8zaTT6Jcfc7SrOXAMMxW7e5O0FiRxEsqGV60fGwh9MmGaxm
         eRk+wCI00dxm7HjI1iWoQBBzkMD7K02x1dUzm52tWL8uU4gyciQDoSNlS5DS2LwgcK
         SE3IwjIMkWAJpyA4HFXe6BloMWhk0htdlu9K9vbZlkH0j2whS1OWR1aUK7x/7xWUne
         QPcwEarMWIpeA==
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
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 11/31] ftrace: Allow ftrace startup flags exist without dynamic ftrace
Date:   Wed,  8 Nov 2023 23:26:30 +0900
Message-Id: <169945359010.55307.16221453484650800734.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Some of the flags for ftrace_startup() may be exposed even when
CONFIG_DYNAMIC_FTRACE is not configured in. This is fine as the difference
between dynamic ftrace and static ftrace is done within the internals of
ftrace itself. No need to have use cases fail to compile because dynamic
ftrace is disabled.

This change is needed to move some of the logic of what is passed to
ftrace_startup() out of the parameters of ftrace_startup().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 80ec01e765bd..84e06ad1b121 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -537,6 +537,15 @@ static inline void stack_tracer_disable(void) { }
 static inline void stack_tracer_enable(void) { }
 #endif
 
+enum {
+	FTRACE_UPDATE_CALLS		= (1 << 0),
+	FTRACE_DISABLE_CALLS		= (1 << 1),
+	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
+	FTRACE_START_FUNC_RET		= (1 << 3),
+	FTRACE_STOP_FUNC_RET		= (1 << 4),
+	FTRACE_MAY_SLEEP		= (1 << 5),
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 void ftrace_arch_code_modify_prepare(void);
@@ -631,15 +640,6 @@ void ftrace_set_global_notrace(unsigned char *buf, int len, int reset);
 void ftrace_free_filter(struct ftrace_ops *ops);
 void ftrace_ops_set_global_filter(struct ftrace_ops *ops);
 
-enum {
-	FTRACE_UPDATE_CALLS		= (1 << 0),
-	FTRACE_DISABLE_CALLS		= (1 << 1),
-	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
-	FTRACE_START_FUNC_RET		= (1 << 3),
-	FTRACE_STOP_FUNC_RET		= (1 << 4),
-	FTRACE_MAY_SLEEP		= (1 << 5),
-};
-
 /*
  * The FTRACE_UPDATE_* enum is used to pass information back
  * from the ftrace_update_record() and ftrace_test_record()

