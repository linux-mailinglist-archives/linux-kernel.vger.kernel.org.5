Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0502C80A0AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573530AbjLHKYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjLHKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:24:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703EE1735
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:24:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F860C433B6;
        Fri,  8 Dec 2023 10:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031086;
        bh=dL9JJoim7F8avDTUtPFPrZxdt2I1oZt3h3FTr1Er5xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1qtLnmkzVzJGf0osX0F12HxdVVw+NsXi2ETuaEW+Vz/DfKMewGmRL7Fvb2Ri+Fjv
         ciQRh6HAg2Osg+ZER/FXXcvdgZqoaU7nNFurOKXbs7nXWH9wy9s54C/+NY0gGHD+Be
         aEir0/6kjg3bry8iScjBIT5Ug9+bI1Jq5Zz2lSpf+bm7pNZswA7dUI1sPmBrQWYvs1
         53FaxmB8citwzqOC/gB9fOw9dXAPp6usb07ti03TlfE1Azzq6QJUoAWzTDudPw2vnh
         8GFYigF5sX+lLqyIDVNjQCODLbrJ0lUTJfsysbIeOdy8yniMQjPxpMcwsYr9UpTzYZ
         yYeTcddH76ZpQ==
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
Subject: [PATCH v4 02/33] x86: tracing: Add ftrace_regs definition in the header
Date:   Fri,  8 Dec 2023 19:24:40 +0900
Message-Id: <170203107969.579004.12737392554145840949.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add ftrace_regs definition for x86_64 in the ftrace header to
clarify what register will be accessible from ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add rip to be saved.
 Changes in v2:
  - Newly added.
---
 arch/x86/include/asm/ftrace.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..415cf7a2ec2c 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -36,6 +36,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_regs {
+	/*
+	 * On the x86_64, the ftrace_regs saves;
+	 * rax, rcx, rdx, rdi, rsi, r8, r9, rbp, rip and rsp.
+	 * Also orig_ax is used for passing direct trampoline address.
+	 * x86_32 doesn't support ftrace_regs.
+	 */
 	struct pt_regs		regs;
 };
 

