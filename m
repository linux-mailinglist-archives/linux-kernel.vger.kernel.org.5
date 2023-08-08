Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE977422B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjHHRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjHHRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE1097D5E;
        Tue,  8 Aug 2023 09:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6760F625A6;
        Tue,  8 Aug 2023 14:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26319C433CA;
        Tue,  8 Aug 2023 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691506432;
        bh=uwQnu9f4p3k5CfpSJXtgO6zZRF7NC7rvvkAoWiX73N0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kWWVkBumS+i71Op3410bY/vV7U4C2J0z4eah/iV9yVXuMEHBAInHVfSo4Vr8Nn/ho
         Ux2la/urUI7czt+QMS6s1RA5yhJPj7y0SZpiKrz1ARokPd2lWBarZnEnFD71VVQ83w
         3jM0Ns1O5gvK/o5iGJKSf8W3tipPUS2Z3zzGfX78wzMqXx+iNmGCNpXGRE1yfT7zlj
         rgCrpabu2SiqpwN5eryt+ZL2AzRMU4o+rcCAt8jVFMbe8cqhvIH/tCW64EBDMl67O4
         jzw74Yy57/LlxPOXFlUY7vCvPCt6B6mQiU/Z6g6xF6pZjhURJr+Z6ASCpAsb7ZIn3l
         t6SApgn6cNcWw==
Date:   Tue, 8 Aug 2023 23:53:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
Message-Id: <20230808235346.fdd76875c71f0806773fad74@kernel.org>
In-Reply-To: <CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 16:29:27 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > Florent, feel free to add your rethook for arm64, but please do not remove
> > kretprobe trampoline yet. It is another discussion point. We may be possible
> > to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
> > allows nest probe. (maybe we can skip that case?)
> 
> Ack :)
> 
> >  arch/Kconfig                    |    1 +
> >  arch/arm64/include/asm/ftrace.h |   11 ++++++
> >  arch/loongarch/Kconfig          |    1 +
> >  arch/s390/Kconfig               |    1 +
> >  arch/x86/Kconfig                |    1 +
> >  arch/x86/kernel/rethook.c       |    9 +++--
> >  include/linux/fprobe.h          |    4 +-
> >  include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
> >  include/linux/rethook.h         |   11 +++---
> >  kernel/kprobes.c                |    9 ++++-
> >  kernel/trace/Kconfig            |    9 ++++-
> >  kernel/trace/bpf_trace.c        |   14 +++++--
> >  kernel/trace/fprobe.c           |    8 ++--
> >  kernel/trace/rethook.c          |   16 ++++----
> >  kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------------
> >  kernel/trace/trace_probe_tmpl.h |    2 +
> >  lib/test_fprobe.c               |   10 +++--
> >  samples/fprobe/fprobe_example.c |    4 +-
> 
> I believe that Documentation/trace/fprobe.rst should also be modified
> following the API change

Indeed. Let me update it.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
