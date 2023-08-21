Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6E782CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjHUPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjHUPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FEE2;
        Mon, 21 Aug 2023 08:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371A463B46;
        Mon, 21 Aug 2023 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9624EC433C8;
        Mon, 21 Aug 2023 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692630583;
        bh=FI4K6BFk3RcP+iLGylJ5QutVzletJNgfqF0MXLNwUf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCKmpbvy7HJWTMFrBCj2/oKy5v78TCPMMm8WyuM+OEI+vYqq5+RaH3CnWLF7Y+df2
         Okr8hYkNswmMkxJOH1vIFrT9YnSkvPJk818OI6D6uno1ZVz+PZpRYGoL3S+dQV+yHv
         nWXIUNBh4HZf28mqMmWviX9yTVPJDCQbxl+YN5Pk/AasnLeNmY/RUsIEzxrq9SIuoJ
         BR9kDsPsuhDTWQUq6DVp5JPiZC0iHOiuGCHvrNczDwBTEpEe47c9w849ea2lIbyrD9
         GkeedOeN6HapZAa2Bcdna2Lvakkw3i1BUzBw/ZdEJ6Ec3nWSSnvWcVuhg01AozFdyz
         dGHAukZZPMMMw==
Date:   Tue, 22 Aug 2023 00:09:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230822000939.81897c0c904934bfb9156a59@kernel.org>
In-Reply-To: <169137686814.271367.11218568219311636206.stgit@devnote2>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Can you review this series?
I would like to push this to for-next.

Thank you,

On Mon,  7 Aug 2023 11:54:28 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 5th version of series to improve the BTF support on probe events.
> The previous series is here:
> 
> https://lore.kernel.org/all/169078860386.173706.3091034523220945605.stgit@devnote2/
> 
> This version introduces kernel/trace/trace_btf.c to separate the btf generic
> functions. These functions will be moved to btf.c next merge window.
> This fixes the member-search function to return the bit-offset of the
> parent anonymous union/structure. Thus the caller can calculate the real
> bit-offset from the root data structure.
> This also fixes the ftrace selftest issue which fails if the kernel
> supports only BTF args but not support field access.
> 
> This series can be applied on top of "probes/core" branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/
> 
> You can also get this series from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (9):
>       tracing/probes: Support BTF argument on module functions
>       tracing/probes: Move finding func-proto API and getting func-param API to trace_btf
>       tracing/probes: Add a function to search a member of a struct/union
>       tracing/probes: Support BTF based data structure field access
>       tracing/probes: Support BTF field access from $retval
>       tracing/probes: Add string type check with BTF
>       tracing/fprobe-event: Assume fprobe is a return event by $retval
>       selftests/ftrace: Add BTF fields access testcases
>       Documentation: tracing: Update fprobe event example with BTF field
> 
> 
>  Documentation/trace/fprobetrace.rst                |   64 ++-
>  include/linux/btf.h                                |    1 
>  kernel/bpf/btf.c                                   |    2 
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/trace.c                               |    3 
>  kernel/trace/trace_btf.c                           |  109 ++++
>  kernel/trace/trace_btf.h                           |   11 
>  kernel/trace/trace_eprobe.c                        |    4 
>  kernel/trace/trace_fprobe.c                        |   59 ++
>  kernel/trace/trace_kprobe.c                        |    1 
>  kernel/trace/trace_probe.c                         |  499 +++++++++++++++-----
>  kernel/trace/trace_probe.h                         |   27 +
>  kernel/trace/trace_uprobe.c                        |    1 
>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   20 +
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   10 
>  15 files changed, 637 insertions(+), 175 deletions(-)
>  create mode 100644 kernel/trace/trace_btf.c
>  create mode 100644 kernel/trace/trace_btf.h
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
