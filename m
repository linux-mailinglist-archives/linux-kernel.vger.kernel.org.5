Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD9785BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjHWPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbjHWPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAD10D9;
        Wed, 23 Aug 2023 08:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4733E61B2F;
        Wed, 23 Aug 2023 15:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCA5C433C7;
        Wed, 23 Aug 2023 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803734;
        bh=ASbMdCajbcDHLaUjdYxqw9oJ/MlOFQjowbpMQ9Bc3tQ=;
        h=From:To:Cc:Subject:Date:From;
        b=J/RefnlCaBda4PdVcYjWR3IbDkE0mG0vxMvz2hnYhaO5ClKwcm8lxO8AxJ9QLMb6M
         rtJob9vFs8qgToO6kK5Il5NEih4ib2W7YWYUin/fXvjMP6HA1j506H7RaDep9iBJe9
         ns7w6p2NE9KVLQ/SjxN5Fo4kbp0OubH5AX2S9lPI9mF5rniZWQvjMunjnZWgdIYgWP
         +Ubu8PvJvB+kL2TCM1MUl8N2womMJJpFI8Q/lsmDEKaYAu/CcIaZWuqTmGrQ16wAf5
         JqYe/pEWty1UTjOl5LcooD8WSdvS7+tjGwGbmwOpJo7j3E6yYbkSW5CqkRV+vvO9xZ
         1UMN8/6fuWVZA==
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
Subject: [PATCH v4 0/9] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date:   Thu, 24 Aug 2023 00:15:28 +0900
Message-Id: <169280372795.282662.9784422934484459769.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Hi,

Here is the 4th version of the series to use ftrace_regs instead of pt_regs
in fprobe.
The previous version is here;

https://lore.kernel.org/all/169181859570.505132.10136520092011157898.stgit@devnote2/

This version fixes the issues pointed in the previous series; fix document
description, keep CONFIG_FPROBE dependency for multi-kprobe, add
static_assert check for ftrace_regs size, reorder the ftrace_partial_regs()
patch for perf fprobe event support, introduce per-cpu pt_regs stack for
perf fprobe event and add Florent's Ack (Thanks!). Also this adds a new
documentation patch to clarify that the $argN and $retval is best effort.

 - Document fix for the current fprobe callback prototype
 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
 - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
 - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
   implementation)
 - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. This
   introduce a new HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means ftrace_regs is
   just a wrapper of pt_regs (except for arm64, other architectures do this)
 - Update fprobe-events to use ftrace_regs natively.
 - Update bpf multi-kprobe handler use ftrace_partial_regs().
 - Update document for new fprobe callbacks.
 - Add notes for the $argN and $retval.

This series can be applied against the probes/core branch on linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-ftrace-regs

Thank you,

---

Masami Hiramatsu (Google) (9):
      Documentation: probes: Add a new ret_ip callback parameter
      fprobe: Use fprobe_regs in fprobe entry handler
      tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
      fprobe: rethook: Use ftrace_regs in fprobe exit handler and rethook
      ftrace: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      Documentations: probes: Update fprobe document to use ftrace_regs
      Documentation: tracing: Add a note about argument and retval access


 Documentation/trace/fprobe.rst      |   18 +++--
 Documentation/trace/fprobetrace.rst |    8 ++
 Documentation/trace/kprobetrace.rst |    8 ++
 arch/Kconfig                        |    1 
 arch/arm64/include/asm/ftrace.h     |   11 +++
 arch/loongarch/Kconfig              |    1 
 arch/s390/Kconfig                   |    1 
 arch/s390/include/asm/ftrace.h      |    4 +
 arch/x86/Kconfig                    |    1 
 arch/x86/kernel/rethook.c           |   13 ++-
 include/linux/fprobe.h              |    4 +
 include/linux/ftrace.h              |   89 ++++++++++++++++++------
 include/linux/rethook.h             |   11 ++-
 kernel/kprobes.c                    |   10 ++-
 kernel/trace/Kconfig                |    9 ++
 kernel/trace/bpf_trace.c            |   14 ++--
 kernel/trace/fprobe.c               |   10 +--
 kernel/trace/rethook.c              |   16 ++--
 kernel/trace/trace_fprobe.c         |  131 ++++++++++++++++++++++++++---------
 kernel/trace/trace_probe_tmpl.h     |    2 -
 lib/test_fprobe.c                   |   10 +--
 samples/fprobe/fprobe_example.c     |    4 +
 22 files changed, 267 insertions(+), 109 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
