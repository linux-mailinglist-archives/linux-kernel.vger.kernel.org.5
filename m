Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE178474B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbjHVQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjHVQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:25:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD78137;
        Tue, 22 Aug 2023 09:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E3386154D;
        Tue, 22 Aug 2023 16:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F15C433C7;
        Tue, 22 Aug 2023 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692721536;
        bh=Q+r3oxlYBxRghMxUbHFTOIiX5XSGjgru9PagyxC488w=;
        h=From:To:Cc:Subject:Date:From;
        b=Fh1dty56cRg3F7Cqr2mULpE6ISouwiRnFi0CVfvcb8G3CdvsD321Q/bTb2sGtx0s9
         xGExByW+BJJfwaauZfEKyY2naTOZjdLesa1OXqgT3N6Hpi7uw9H+ZaDcVquz1zOM3o
         g3PLEbWhXggJ1+AUO+dJ3nscQe+VxWAfR7reHk7KG7kV32fMGusWiG/Rq4IiRkgIB/
         vzKzEnQROIIxojdgZungWqdSCPR7UZwS3W5SS3W0RQmX91KeJK4L1+OTRNGNHyr1mY
         TrQvRMuTn7oGeLJay7PzbHZRokzcsUIYVL0sBpfb/suC5eaDJ2Wj72osI4c8gSGd0u
         8QPVcUG2XiMNw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 0/9] tracing: Improbe BTF support on probe events
Date:   Wed, 23 Aug 2023 01:25:31 +0900
Message-Id: <169272153143.160970.15584603734373446082.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 6th version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/all/169137686814.271367.11218568219311636206.stgit@devnote2/

This version is adding Steve's Ack and allocate the struct btf_anon_stack
from heap.

This series can be applied on top of "probes/core" branch of
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

Thank you,

---

Masami Hiramatsu (Google) (9):
      tracing/probes: Support BTF argument on module functions
      tracing/probes: Move finding func-proto API and getting func-param API to trace_btf
      tracing/probes: Add a function to search a member of a struct/union
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from $retval
      tracing/probes: Add string type check with BTF
      tracing/fprobe-event: Assume fprobe is a return event by $retval
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   64 ++-
 include/linux/btf.h                                |    1 
 kernel/bpf/btf.c                                   |    2 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    3 
 kernel/trace/trace_btf.c                           |  122 +++++
 kernel/trace/trace_btf.h                           |   11 
 kernel/trace/trace_eprobe.c                        |    4 
 kernel/trace/trace_fprobe.c                        |   59 ++
 kernel/trace/trace_kprobe.c                        |    1 
 kernel/trace/trace_probe.c                         |  499 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   27 +
 kernel/trace/trace_uprobe.c                        |    1 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   20 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   10 
 15 files changed, 650 insertions(+), 175 deletions(-)
 create mode 100644 kernel/trace/trace_btf.c
 create mode 100644 kernel/trace/trace_btf.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
