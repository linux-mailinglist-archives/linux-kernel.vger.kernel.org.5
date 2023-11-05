Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C77E1455
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjKEQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjKEQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:08:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C1D6D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:08:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DF3C433C7;
        Sun,  5 Nov 2023 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200506;
        bh=aOBVpVmxMVywZjrn0W2fI6F8TmfS5e1bc3XWd3NWy64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HoomEPBwPk2zxl/3w8o/aqAv3SiBAK51fqRLol7AWsu31v28TcgFujagwswHGOtpZ
         740Sm101TNG7Z0f+3hYU6FzUXb2lHTCMhTFxRZgPzl7Zt5cJ227n96DnAI3gJ1wTXg
         JLsLm1pTVpOVeswIEIVXa36y2fn1R0amZt+he7N1iNQ3unlDlBpmqzEzGVXL+1W8EN
         r9rg2fQz7j2yQF+zQVccfPNNKIDI3sUgHanLcW28jnu3ZSnX9DYUO5pda2IJPv9Iul
         NlIZddwbSMlp2z7z+Wojc0hcUAd5KPLkuCQqxTPFTkrizl69s4ytNsejtVXOk4aPlx
         WyryZYEsZIzgA==
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
Subject: [RFC PATCH 09/32] ftrace: Allow ftrace startup flags exist without dynamic ftrace
Date:   Mon,  6 Nov 2023 01:08:19 +0900
Message-Id: <169920049937.482486.15191811301005089130.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4ad587b3525e..7fd044ae3da5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -512,6 +512,15 @@ static inline void stack_tracer_disable(void) { }
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
@@ -606,15 +615,6 @@ void ftrace_set_global_notrace(unsigned char *buf, int len, int reset);
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

