Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3F80A0BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573596AbjLHK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573726AbjLHK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:26:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF01FE4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:26:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4EAC433C8;
        Fri,  8 Dec 2023 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031183;
        bh=6ERBwQiaxIIDNTVWPQkxDhl1p/zo1tlsKma+ZLC6cPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGQ5K1W971s+MC8xP9/LxQdkaHOiHnfgk/icKi5ZJGXIe9pv0HE2mtuVnmgTTf0LK
         +Mg5P/tMiJCUNfxZHEFB3rLHRTNZEf0XY1Fg9nur6vtPB0N0kHTU+Ez2xvqL9CGaVa
         F0AeU2oqMCZKXGaQlaTmHYeHTFjdFvBXFfCWSJG+pgaovzd5cYoVQ8YyBlqeg8L0cI
         5U0vE53REDc/LnaWQkH4TgiQEom4WsQBG3GybRytkNUigmV7+TX8kMI3BpYCwYvRtU
         j2UXOH44qRsk6bTWbv2bzLmL1uWHwrS2mNipDxui3epimDdQcKqSaPXxz5pLKDLh82
         ZyK6Es3/iqzDw==
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
Subject: [PATCH v4 10/33] ftrace: Allow ftrace startup flags exist without dynamic ftrace
Date:   Fri,  8 Dec 2023 19:26:18 +0900
Message-Id: <170203117769.579004.5659514449783521216.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170203105427.579004.8033550792660734570.stgit@devnote2>
References: <170203105427.579004.8033550792660734570.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0955baccbb87..7b08169aa51d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -538,6 +538,15 @@ static inline void stack_tracer_disable(void) { }
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
@@ -632,15 +641,6 @@ void ftrace_set_global_notrace(unsigned char *buf, int len, int reset);
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

