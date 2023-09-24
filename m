Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9107AC9C7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjIXNjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjIXNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:38:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092610E3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:38:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B3C433C7;
        Sun, 24 Sep 2023 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562700;
        bh=Ylc3TSXa5ifgz7bjH+Ib7u/kImYYyrGh5B2vMyFRLTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Noce4mwmQNAoIZUogYsYCHEBjWbN2VvgLO6lbPFKdhnc1rWxsAAm5qcB/hlWV7MzL
         6M8uaClcpljpII0+yuMjMcfoXR2E4R03fEuYY1TBanEt2HyxGqBltgcZGu2xlwMcw1
         GT1nBUt9ctylc2zKowKw8YXTloz3jhxqUqutXd+I1UwjeJr3Fz+fgwqCp1jn6obYvX
         EbnAwCmrhQ7uQFXszvaCznoy6tg4E3WMRuPOSYmv8+iowSy3I/m+5sghxqx/z/F2qm
         QL6KhyoirapL2JQ/JB64iPfjQKFoZV2VO2aGFRDutjDqBmqcL1+dhLeHtBXi9ik/4B
         gmhXMtk+X90zQ==
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
Subject: [PATCH v5 12/12] Documentation: tracing: Add a note about argument and retval access
Date:   Sun, 24 Sep 2023 22:38:14 +0900
Message-Id: <169556269377.146934.14829235476649685954.stgit@devnote2>
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

Add a note about the argument and return value accecss will be best
effort. Depending on the type, it will be passed via stack or a
pair of the registers, but $argN and $retval only support the
single register access.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |    8 ++++++--
 Documentation/trace/kprobetrace.rst |    8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 8e9bebcf0a2e..e35e6b18df40 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -59,8 +59,12 @@ Synopsis of fprobe-events
                   and bitfield are supported.
 
   (\*1) This is available only when BTF is enabled.
-  (\*2) only for the probe on function entry (offs == 0).
-  (\*3) only for return probe.
+  (\*2) only for the probe on function entry (offs == 0). Note, this argument access
+        is best effort, because depending on the argument type, it may be passed on
+        the stack. But this only support the arguments via registers.
+  (\*3) only for return probe. Note that this is also best effort. Depending on the
+        return value type, it might be passed via a pair of registers. But this only
+        accesses one register.
   (\*4) this is useful for fetching a field of data structures.
   (\*5) "u" means user-space dereference.
 
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 8a2dfee38145..bf9cecb69fc9 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -61,8 +61,12 @@ Synopsis of kprobe_events
 		  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
 
-  (\*1) only for the probe on function entry (offs == 0).
-  (\*2) only for return probe.
+  (\*1) only for the probe on function entry (offs == 0). Note, this argument access
+        is best effort, because depending on the argument type, it may be passed on
+        the stack. But this only support the arguments via registers.
+  (\*2) only for return probe. Note that this is also best effort. Depending on the
+        return value type, it might be passed via a pair of registers. But this only
+        accesses one register.
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
 

