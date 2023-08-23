Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768D785BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbjHWPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbjHWPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E21171A;
        Wed, 23 Aug 2023 08:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F5360E03;
        Wed, 23 Aug 2023 15:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728FDC433C8;
        Wed, 23 Aug 2023 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803745;
        bh=0drD+LQDmx/AHTKLGdH1kpL/kFKRrBczUa0Lao0mBUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHa5BB/ygXp14fJ5mlCzLHnp2z4FiKXUQhn0X611gMkzK0gRcKI25E7Ait3VmQpnF
         sEc8LFG2fmdqrcsXdRH1QKJStOcgrHyCUVEmy25sJppLkiwv6pdGS2tiSS9gI1bCrN
         1MlvLL3MGN8oSSD18gHH9xqd6pIH79L51VL78zeon27+Nhq/vhXTNSuBWw2zAVbmNg
         nI8dPLPSnPshg70iA4RjBdVG0nml2s+LGyxuDEkYhK24dN5J9bSTzZ8cuUFD3QCfGQ
         sMXoF6ewCGSHdSeeh3KjBPriZwUeQagYnxgFxfj40Uh5gNSIxfHf3nAGvc9Yix0XDW
         R5qDiyorawPjw==
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
Subject: [PATCH v4 1/9] Documentation: probes: Add a new ret_ip callback parameter
Date:   Thu, 24 Aug 2023 00:15:40 +0900
Message-Id: <169280373992.282662.14835192462715188987.stgit@devnote2>
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

Add a new ret_ip callback parameter description.

Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Update ret_ip description (Thanks Florent!)
---
 Documentation/trace/fprobe.rst |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 40dd2fbce861..5851a14eb893 100644
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

