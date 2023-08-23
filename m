Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6D785BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjHWPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjHWPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A410C9;
        Wed, 23 Aug 2023 08:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672EF65929;
        Wed, 23 Aug 2023 15:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74894C433C8;
        Wed, 23 Aug 2023 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803823;
        bh=HSJ8K/iEdi2nQ2WTLzit3GrsQpQ2UPYAXTJjDkiZDzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA3LsibwzfMp3dlMzWwfKnecOG42Tqh+WNSoe5Dy90DAfrZYOo2Pf92LrJqqvQeNE
         J+Mn/kZXIiTZKX22TwSTkOvqwTEuTrrzRh5qJrE/TcCwwa9IM07XkXZEOXA9aX11Ad
         SR0VvTDzvZe/QfxMc6snhmCW0M0SqchieYdSZnJEEDjT61239XmV0+ZJn37RlZCOnK
         9zXqc+4nbWaFJ4VTlsKV0j2xomPk9tdgd8Sse0XZRuzpGAbEbfUiTufxi+WvXg5+dO
         73pUCpk0s7fgpdKQpQCZbYwJjjjdxtkgXpoAbyvJmQZxxJmr7J5THs60iNU5NPRlEV
         gh3cu51HkirJQ==
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
Subject: [PATCH v4 8/9] Documentations: probes: Update fprobe document to use ftrace_regs
Date:   Thu, 24 Aug 2023 00:16:57 +0900
Message-Id: <169280381726.282662.9429943163047257398.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169280372795.282662.9784422934484459769.stgit@devnote2>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
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

Update fprobe document so that the entry/exit handler uses ftrace_regs
instead of pt_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Documentation/trace/fprobe.rst |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 5851a14eb893..64ef522f7a64 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -91,9 +91,9 @@ The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
 
- void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
 
 Note that the @entry_ip is saved at function entry and passed to exit handler.
 If the entry callback function returns !0, the corresponding exit callback will be cancelled.
@@ -112,12 +112,10 @@ If the entry callback function returns !0, the corresponding exit callback will
         This is the return address that the traced function will return to,
         somewhere in the caller. This can be used at both entry and exit.
 
-@regs
-        This is the `pt_regs` data structure at the entry and exit. Note that
-        the instruction pointer of @regs may be different from the @entry_ip
-        in the entry_handler. If you need traced instruction pointer, you need
-        to use @entry_ip. On the other hand, in the exit_handler, the instruction
-        pointer of @regs is set to the currect return address.
+@fregs
+        This is the `ftrace_regs` data structure at the entry and exit. Note that
+        the instruction pointer of @fregs may be incorrect in entry handler and
+        exit handler, so you have to use @entry_ip and @ret_ip instead.
 
 @entry_data
         This is a local storage to share the data between entry and exit handlers.

