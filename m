Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DAF7AC9B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjIXNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjIXNhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:37:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42FCC2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:36:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48650C433C8;
        Sun, 24 Sep 2023 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562578;
        bh=+UQOaXyf7wYEVeoHCkzfXpWdvixzMC9xY2Nvd7e4ziM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmvhuVJMBb4WW8ut2rEFn6UqOgvJDGGewzA/jDlUL48jPr1c/bNobdkx2NKnlo7Jh
         lB9eKDPuxclzehBqTqfcTwjLmnEf9wRDc2SmVrkIecey2MC6t/4LCd1sjEkTRPeNBX
         bwHYgiQagiGiYzkqeV1iTB8DaunYCY6ephxg16OGbHls7bo9Ng0r5CcWbHScWgp0eW
         h/0EMkw1VNjh7Gsh4nlyJglbvbbtB0QKLVHb/B5iX9tGvJ+nnEodkvqM6AKs1B3S0y
         0/FECAJYwyA9GXlPDxNsMBaHSxvg0rhn12xppztVkaGfeU70D8ksb+2iRyocUnNab6
         VbbnhtgTPd/Eg==
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
Subject: [PATCH v5 02/12] Documentation: probes: Add a new ret_ip callback parameter
Date:   Sun, 24 Sep 2023 22:36:11 +0900
Message-Id: <169556257133.146934.13560704846459957726.stgit@devnote2>
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

Add a new ret_ip callback parameter description.

Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v4:
  - Update ret_ip description (Thanks Florent!)
---
 Documentation/trace/fprobe.rst |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 7a895514b537..196f52386aaa 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -91,9 +91,9 @@ The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- int entry_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
 
- void exit_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
 
 Note that the @entry_ip is saved at function entry and passed to exit handler.
 If the entry callback function returns !0, the corresponding exit callback will be cancelled.
@@ -108,6 +108,10 @@ If the entry callback function returns !0, the corresponding exit callback will
         Note that this may not be the actual entry address of the function but
         the address where the ftrace is instrumented.
 
+@ret_ip
+        This is the return address that the traced function will return to,
+        somewhere in the caller. This can be used at both entry and exit.
+
 @regs
         This is the `pt_regs` data structure at the entry and exit. Note that
         the instruction pointer of @regs may be different from the @entry_ip

