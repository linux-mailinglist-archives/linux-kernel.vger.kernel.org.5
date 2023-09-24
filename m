Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE017AC9C6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjIXNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIXNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:38:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61ADE4D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:38:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C1CC433C9;
        Sun, 24 Sep 2023 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562688;
        bh=CLUahLECFFMThaMlg6kBR2ihukQ2SmAsdwcA4AdH8rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pV93df4UU5q1m05W20xMqKCAie39MI7vyF8y2HIqDTWOsxFBvDzv2eP9xz/EzI0oF
         e0r4Iuz1rqZhPm2sX88w62J6AMOUShFxf9hVU3p8esqhejBVuWBiqvGfDkIsyv8cdz
         V02/uAiHnmVFhuk0yj086D+g54+ycpHy3bAB3VryqWXWYY/mxSa66sxl400CIEnKNH
         tHNbC2rokwrO5AowIFkrUaC4WenWq9wlV/3DYfIR5XkbfMCb0g0IcWm9n45dsLd5Mb
         4bF04iwvGb3sWZPighPuFFn7s7wBq6B5nrMjhIYKf1I0uJ+RR6vuiW51e7xhy4OvoC
         ghBfS8cf5aNOA==
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
Subject: [PATCH v5 11/12] Documentation: probes: Update fprobe document to use ftrace_regs
Date:   Sun, 24 Sep 2023 22:38:01 +0900
Message-Id: <169556268150.146934.2968626447452628416.stgit@devnote2>
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

Update fprobe document so that the entry/exit handler uses ftrace_regs
instead of pt_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Documentation/trace/fprobe.rst |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 196f52386aaa..64ef522f7a64 100644
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
-        pointer of @regs is set to the current return address.
+@fregs
+        This is the `ftrace_regs` data structure at the entry and exit. Note that
+        the instruction pointer of @fregs may be incorrect in entry handler and
+        exit handler, so you have to use @entry_ip and @ret_ip instead.
 
 @entry_data
         This is a local storage to share the data between entry and exit handlers.

