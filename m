Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C467567C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGQPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGQPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE019B1;
        Mon, 17 Jul 2023 08:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D082B60FE9;
        Mon, 17 Jul 2023 15:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9639AC433C8;
        Mon, 17 Jul 2023 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607402;
        bh=gHIJLgbVp3IPB3gkGkxy/IvawUhhWSjYF4p1wpvRtLU=;
        h=From:To:Cc:Subject:Date:From;
        b=fqXZ5t4I+z6d4b3GWRKAdh2i6bGmPXXT/2vJMQTEpeT7hjsTxU+8QV9HJS0cQbT1A
         RbscXA8m+dEco03gEfPnVgQSbTbMrxAukoOy+008DndMQz4HqGAsSFCp7voeuytUhy
         MYQSAhu7EB7Pv7F4UTIaiInLZXAUmiZm1rS3iqnRpirRbEUEK7vvmJyB737eYJpjI6
         4IrF7TEByeiIWHET1Vtrd2LK9ZJoAhPXfRdcStA7fcpRpVIbNAvmDSlv4tCXK1s+Gi
         jhNUfvREWP3N4lvl8zkVwDMgto29ttQrybvz/kmw4d5Duc5Xah9gfUkKIdke+ugdwZ
         4pPMNoRjeC4Fg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 0/9] tracing: Improbe BTF support on probe events
Date:   Tue, 18 Jul 2023 00:23:17 +0900
Message-Id: <168960739768.34107.15145201749042174448.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
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

Here is the 2nd version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/linux-trace-kernel/168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com/

In this version, I added a NULL check fix patch [1/9] (which will go to
fixes branch) and move BTF related API to kernel/bpf/btf.c [2/9] and add
a new BTF API [3/9] so that anyone can reuse it.
Also I decided to use '$retval' directly instead of 'retval' pseudo BTF
variable for field access at [5/9] because I introduced an idea to choose
function 'exit' event automatically if '$retval' is used [7/9]. With that
change, we can not use 'retval' because if a function has 'retval'
argument, we can not decide 'f func retval' is function exit or entry.
Selftest test case [8/9] and document [9/9] are also updated according to
those changes.

This series can be applied on top of "v6.5-rc2" kernel.

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext


Thank you,

---

Masami Hiramatsu (Google) (9):
      tracing/probes: Fix to add NULL check for BTF APIs
      bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
      bpf/btf: Add a function to search a member of a struct/union
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from $retval
      tracing/probes: Add string type check with BTF
      tracing/fprobe-event: Assume fprobe is a return event by $retval
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   50 ++
 include/linux/btf.h                                |    7 
 kernel/bpf/btf.c                                   |   83 ++++
 kernel/trace/trace_fprobe.c                        |   58 ++-
 kernel/trace/trace_probe.c                         |  402 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   12 +
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
 8 files changed, 503 insertions(+), 126 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
