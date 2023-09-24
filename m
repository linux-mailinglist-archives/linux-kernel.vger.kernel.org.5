Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26A7AC9B6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjIXNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjIXNhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:37:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4637E44
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:36:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720EFC433C9;
        Sun, 24 Sep 2023 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562590;
        bh=tVeWRc6NY/P1SVA880iIBWSSfIP1iQe2tBoTWU/xgMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjlxvWFQgaGpBMlqFwlnIZ9VGGXN02c/MIxxrj0jkjoXq5Dkp5EVjKLTiQCIZ+qQi
         t69ATsL1NxjpLZ/BSsGg23XpeCctFsJn6LLHvDohosO1KgMJ6u+R2PRBbG7L+Zaxgx
         y6+QFBBfA0LjX6LTPp5lOsuNH8U89yONdRb5wIrRKo7ESmLsGg742zPxiF2hCsAyA1
         jYMJ6u5zAyz3Zsp/OsY2JWun3v1LFrGm7TIkVPFmKVtxfg03TrJKX5ursI4EgZ+w4w
         J6bWYTBctWkELztWXwOD2byUYJswu6XGjzXsV8QRIL2Wu6TuAKKbm8K53sFgeXY1Rn
         +euG0vig0MbyQ==
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
Subject: [PATCH v5 03/12] tracing: Add a comment about the requirements of the ftrace_regs
Date:   Sun, 24 Sep 2023 22:36:23 +0900
Message-Id: <169556258347.146934.12248055282843332442.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a comment about the requirements of the ftrace_regs if it is
implemented on the arch-dependent code with
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..5da70f238645 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -118,6 +118,14 @@ extern int ftrace_enabled;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+/*
+ * The ftrace_regs will be just a wrapper of the pt_regs if
+ * CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is not set. If it is set on an
+ * architecture, it has to define the ftrace_regs data structure.
+ * The ftrace_regs is expected to save the registers for the function
+ * arguments, the registers for stack dump (e.g. stack pointer and the
+ * frame pointer) and the instruction pointer for reference.
+ */
 struct ftrace_regs {
 	struct pt_regs		regs;
 };

