Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7079049E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbjIBBKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 21:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjIBBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 21:10:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BB710FB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 18:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0AA3B826BA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 01:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEE8C433C7;
        Sat,  2 Sep 2023 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693617038;
        bh=3ledYNfx0rFH+3SmgAIrDL5FhgpDPWXgDOM5AjS5QCc=;
        h=Date:From:To:Cc:Subject:From;
        b=KEAr87H5IKAIqF/3P6thPZ7VjKaMqtYyh89p/pWZI4ozW2y4MJXhkykT7rxXA6uRG
         lD1M+6Opu70kAOwD8wgev5XhOt6i9vJLDASSzgfRLqYorfIVeA36yaercN1sMbFvOl
         /lGNqb5e+3cDmiw3kXOCSCbUK4H2vwRYf2t7nqonY9t9jW7cZvw8x/5L7QL+MIkbTH
         9qAIvkDFSRw3/yamki1uJp1PikmjM/EoYMnPEgjWRjcf+mVoP2mGV5mWuuUCBcnpqG
         4we3jwP380fYwH0CHrMx9XcP2672GxA0GhwQFlBvvjmGTh0WJFg3Rw+93PHaaIYhpq
         mX/w5Hg7/h8rA==
Date:   Sat, 2 Sep 2023 10:10:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Masami Hiramatsu (Google) <mhiramat@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] probes: Updates for 6.6
Message-Id: <20230902101034.907ddc22407d9117e432e28c@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes updates for v6.6:

- kprobes: use struct_size() for variable size kretprobe_instance
  data structure.

- eprobe: Simplify trace_eprobe list iteration.

- probe events: Data structure field access support on BTF argument.
  . Update BTF argument support on the functions in the kernel loadable
    modules (only loaded modules are supported).
  . Move generic BTF access function (search function prototype and get
    function parameters) to a separated file.
  . Add a function to search a member of data structure in BTF.
  . Support accessing BTF data structure member from probe args by
    C-like arrow('->') and dot('.') operators. e.g.
    't sched_switch next=next->pid vruntime=next->se.vruntime'
  . Support accessing BTF data structure member from $retval. e.g.
      'f getname_flags%return +0($retval->name):string'
  . Add string type checking if BTF type info is available.
    This will reject if user specify ":string" type for non "char
    pointer" type.
  . Automatically assume the fprobe event as a function return event
    if $retval is used.

- selftests/ftrace: Add BTF data field access test cases.

- Documentation: Update fprobe event example with BTF data field.


Please pull the latest probes-v6.6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.6

Tag SHA1: 4c8c72dd0aff704689952eb31931fefcb6337801
Head SHA1: a2439a4c90856b83657aec4600c19551aa9501ff


Chuang Wang (1):
      tracing/eprobe: Iterate trace_eprobe directly

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

Ruan Jinjie (1):
      kernel: kprobes: Use struct_size()

----
 Documentation/trace/fprobetrace.rst                |  64 ++-
 include/linux/btf.h                                |   1 +
 kernel/bpf/btf.c                                   |   2 +-
 kernel/kprobes.c                                   |   6 +-
 kernel/trace/Makefile                              |   1 +
 kernel/trace/trace.c                               |   3 +-
 kernel/trace/trace_btf.c                           | 122 +++++
 kernel/trace/trace_btf.h                           |  11 +
 kernel/trace/trace_eprobe.c                        |  22 +-
 kernel/trace/trace_fprobe.c                        |  59 ++-
 kernel/trace/trace_kprobe.c                        |   1 +
 kernel/trace/trace_probe.c                         | 499 +++++++++++++++------
 kernel/trace/trace_probe.h                         |  27 +-
 kernel/trace/trace_uprobe.c                        |   1 +
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |  20 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  10 +-
 16 files changed, 661 insertions(+), 188 deletions(-)
 create mode 100644 kernel/trace/trace_btf.c
 create mode 100644 kernel/trace/trace_btf.h

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
