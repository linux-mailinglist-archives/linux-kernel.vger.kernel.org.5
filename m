Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85003771AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHGGsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHGGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571571B5;
        Sun,  6 Aug 2023 23:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7893614DD;
        Mon,  7 Aug 2023 06:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0513C433C7;
        Mon,  7 Aug 2023 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691390910;
        bh=dbLyRNDw66rtMco9Z3macc8TBfHCjdg7YPc5a5Rum2s=;
        h=From:To:Cc:Subject:Date:From;
        b=ESMIgjjLZ6TVNFPZDm+7nkFhf40Hl1mivSWSwCUSdT5ajD52CJDQYYbPKvKYVONZb
         p2tJb3bHYV0AEgIaG5AKhm2gIfRUM4o0GPZYLyC11VjWhjCzgZghvZbQxZPRXnUJxl
         A8IqYz6BHjoQdO7U0R8ICJVFUEvJiSJiCim5fjGqXVR9boCHx2GjOdXxqmgthNpPel
         NU40+dugZoH9tZs6Ll74Qow1RFULjnX1LhOGO4r2RnFqMnoHUyURwkrRkmDWmTjlFX
         KS12lgGVH39v4Vfn5kvTVJswUByK3Jt3jK8cqkP/pIA5eDqxb4ATN39/nr3WHQeMZO
         dGS2CqPUGz/ag==
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
Subject: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date:   Mon,  7 Aug 2023 15:48:24 +0900
Message-Id: <169139090386.324433.6412259486776991296.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of RFC series to use ftrace_regs instead of pt_regs.
But this includes the generic part and minimum modifications of arch
dependent code. (e.g. not including rethook for arm64.) This series is based
on the discussion at

https://lore.kernel.org/all/20230801112036.0d4ee60d@gandalf.local.home/

This version includes 1 patch to expose ftrace_regs. so

 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
 - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
 - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. This
   introduce a new HAVE_PT_REGS_COMPAT_FTRACE_REGS which means ftrace_regs is
   just a wrapper of pt_regs (except for arm64, other architectures do this)
 - Update fprobe-events to use ftrace_regs natively.
 - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
   implementation)
 - Update bpf multi-kprobe handler use ftrace_partial_regs().

Florent, feel free to add your rethook for arm64, but please do not remove
kretprobe trampoline yet. It is another discussion point. We may be possible
to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
allows nest probe. (maybe we can skip that case?)

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-ftrace-regs

Thank you,

---

Masami Hiramatsu (Google) (6):
      fprobe: Use fprobe_regs in fprobe entry handler
      tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
      fprobe: rethook: Use fprobe_regs in fprobe exit handler and rethook
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      ftrace: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled


 arch/Kconfig                    |    1 +
 arch/arm64/include/asm/ftrace.h |   11 ++++++
 arch/loongarch/Kconfig          |    1 +
 arch/s390/Kconfig               |    1 +
 arch/x86/Kconfig                |    1 +
 arch/x86/kernel/rethook.c       |    9 +++--
 include/linux/fprobe.h          |    4 +-
 include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
 include/linux/rethook.h         |   11 +++---
 kernel/kprobes.c                |    9 ++++-
 kernel/trace/Kconfig            |    9 ++++-
 kernel/trace/bpf_trace.c        |   14 +++++--
 kernel/trace/fprobe.c           |    8 ++--
 kernel/trace/rethook.c          |   16 ++++----
 kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------------
 kernel/trace/trace_probe_tmpl.h |    2 +
 lib/test_fprobe.c               |   10 +++--
 samples/fprobe/fprobe_example.c |    4 +-
 18 files changed, 154 insertions(+), 89 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
