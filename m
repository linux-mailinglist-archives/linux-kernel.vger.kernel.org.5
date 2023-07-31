Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E1768ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGaHbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGaHb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4F1A2;
        Mon, 31 Jul 2023 00:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DF860F0B;
        Mon, 31 Jul 2023 07:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D2CC433C8;
        Mon, 31 Jul 2023 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690788608;
        bh=aViYjhHwbZtY5aBTs3TkoJnQJ5YBfz5b0B+HKWNFQow=;
        h=From:To:Cc:Subject:Date:From;
        b=aZZURDXIAq2KKy3/Ab7ggwg2OuV/OXMnT0oo+ypOk0G8Kprom/dhLJWcSYlr1tqxb
         kN60zV6Or2TSkn4FUB+yG6vwlWtczVMBRaVpwId8WAPvPGvQJJeS1qU3RLWWltF673
         oHLYNwvq9002UcQHluTL/6ds5aNym5BIIEjLvuCu+NeBJx2xEg+FXFRq8a8esg4S7G
         3jey/KaNE+1RKuLMQWbQTbHpXlunHGI4aksBtYhibG7a+9Y3xbFHcnhJgRisBFMTJS
         dwFtW0U+UooPBQqqbVu06cTB258/IyPSL6D1BohWYbty6SIPT9vACfKrzR0evAf75n
         ocV5Uju9H8BEw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 0/9] tracing: Improbe BTF support on probe events
Date:   Mon, 31 Jul 2023 16:30:04 +0900
Message-Id: <169078860386.173706.3091034523220945605.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Hi,

Here is the 4th version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/all/169037639315.607919.2613476171148037242.stgit@devnote2/

This version updates the btf_find_struct_member() to use a simple stack
to walk through the anonymous unions/structures instead of recursive call.
Also, returning int error code from query_btf_context()
if !CONFIG_PROBE_EVENTS_BTF_ARGS.

This series enables {f,k}probe events to access the members of data
structures using BTF from arguments and return value. This also adds
some new APIs to BTF so that other users can use BTF to find function
prototypes and the members of data structures.

This series can be applied on top of "probes/core" branch of
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

Thank you,

---

Masami Hiramatsu (Google) (9):
      tracing/probes: Support BTF argument on module functions
      bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
      bpf/btf: Add a function to search a member of a struct/union
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from $retval
      tracing/probes: Add string type check with BTF
      tracing/fprobe-event: Assume fprobe is a return event by $retval
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   64 ++-
 include/linux/btf.h                                |    8 
 kernel/bpf/btf.c                                   |   89 ++++
 kernel/trace/trace_eprobe.c                        |    4 
 kernel/trace/trace_fprobe.c                        |   59 ++
 kernel/trace/trace_kprobe.c                        |    1 
 kernel/trace/trace_probe.c                         |  494 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   27 +
 kernel/trace/trace_uprobe.c                        |    1 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   14 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 11 files changed, 593 insertions(+), 174 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
