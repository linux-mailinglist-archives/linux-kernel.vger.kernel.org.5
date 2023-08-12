Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581E3779D53
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjHLFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjHLFiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A41712;
        Fri, 11 Aug 2023 22:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E24486430F;
        Sat, 12 Aug 2023 05:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8381C433C8;
        Sat, 12 Aug 2023 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691818696;
        bh=nAPla5bM8WSnDqOSNz1wS0JqUKaETcUf6cGd53WZP3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIyseh5+5Iingx8OnLvN6kaJ7wrl4oBRajbwJKbZugplFLx7LonBLHuGJaNAidhln
         Qj456vP1yYN9RTIN1KuRcN1+7BD2igrXkl02vy+9zwYogTG1qgfV9HKHQjlGtrmyRk
         7F3XE+M124rLYmw3dNQ+yLvjS+4/VIV0NVZmZYodOkndN7GRRi1pjqquI0UCwfICEA
         oMtY+DIpevdQU/qN/LntUD3J3ZAHzGhhrRsKDfHB2WpivcowDRu1nwtpEhigKlCUxd
         VbiOauyMb0KjEINJ82tB7NfWPNNOduLNqjb/NTr8azbs51dA96LmNmw/uL73Jlv6Lt
         WbQlYsCxikycQ==
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
Subject: [PATCH v3 8/8] Documentations: probes: Update fprobe document to use ftrace_regs
Date:   Sat, 12 Aug 2023 14:38:10 +0900
Message-Id: <169181869006.505132.4695602314698748304.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
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
---
 Documentation/trace/fprobe.rst |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index a6d682478147..8eee88eda4e6 100644
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
         This is the return address of the traced function. This can be used
         at both entry and exit.
 
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

