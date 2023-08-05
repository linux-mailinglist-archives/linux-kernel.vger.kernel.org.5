Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F93771041
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHEO56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHEO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 10:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DEEB;
        Sat,  5 Aug 2023 07:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D876360AFD;
        Sat,  5 Aug 2023 14:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93288C433C7;
        Sat,  5 Aug 2023 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691247474;
        bh=QPz0WJ8gkkpNP4jYse4D55wibDJnHIsbjKLA3YfAOig=;
        h=From:To:Cc:Subject:Date:From;
        b=oVI0qUR9BhKMYGTuSivMfL/WkxXNliEtSuekiFj0+r6GdIy6inD/B/lEFwhoDWJLw
         6NHswGCCWYJRRCRIKm/3V213UZvtN+/62LlAMeekPcEpTNPPXVwnzpbxGn1EvlmbVr
         qzUKMr8Q41QZ++e3Q9olfJBjCmlrAeFmVbixVoGQWS8X5ZmvPbEwmug71RxtzbHUb0
         fP5mAfhUfLVlAdeW+3bhyRgETpnvsEM9Voa1i2Twxn3zwLJ3Vqt60MYi3lnW7nigOI
         cy3uplaerAzu9B4KuASbLCZCdAqmG3lVs/ahOASyYQcbSJ/cvqzjeNuiETmQgM9h9G
         rgB8P3XqXR60g==
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
Subject: [RFC PATCH 0/5] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date:   Sat,  5 Aug 2023 23:57:47 +0900
Message-Id: <169124746774.186149.2326708176801468806.stgit@devnote2>
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

Here is RFC series to use ftrace_regs instead of pt_regs. But this includes
the generic part and minimum modifications of arch dependent code. (e.g. not
including rethook for arm64.) This series is based on the discussion at

https://lore.kernel.org/all/20230801112036.0d4ee60d@gandalf.local.home/

This has 5 patches,

 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
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

Thank you,

---

Masami Hiramatsu (Google) (5):
      fprobe: Use fprobe_regs in fprobe entry handler
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
 include/linux/ftrace.h          |   11 ++++++
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
 18 files changed, 130 insertions(+), 68 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
