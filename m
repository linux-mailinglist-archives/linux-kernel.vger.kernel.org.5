Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A27774204
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjHHRcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjHHRbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:31:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B038DCF8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:13:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63cfd6e3835so33685966d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691511174; x=1692115974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR2OPalgZgFVCbBNZrCKIT8XHg7hgxmL/4fBXTDwklA=;
        b=mb4dt+yLCabjSk8pFaNFvc4Kfd9lB4Ioai2ytwRsoOme7yXn2D/yX6yogN3IHDLDD0
         YfdCU9LM0oKsK2/iWugjAeLnXmm7PRfoRJJedX0vDYaqvQx8aqXgRYw/0ZAxZobJrskr
         eHa1mvzJDYtAJyxrHL/pKZw6aRcaWZg6MuN+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511174; x=1692115974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR2OPalgZgFVCbBNZrCKIT8XHg7hgxmL/4fBXTDwklA=;
        b=B6ZJeTWOnxA9hH/zx9D5ZuIDA24a153rLkDZGNX7EH4ht5N7Ck2eSZH/xXD9StOeWu
         POngZT2L5UtxQsckNfdOCeCyyLPNQWZB8a0gzSxQo79UDqi3YmmQnnJ+vUA3TU/SS9e1
         y/s2NSr2s8Tr61af+Yj74x0rzhqbj9jBb8cYl2gOQzAOdPQzNvmnKsUoJNDyhdyFWIcP
         39uLsPmAsiIk0vmm3DoztbMSlR75wMbtsqb3PxYjjxLRBr3YfmsVEwrlsgJXlvyViNB9
         3EYNFLWtfd6XYiBC5PpmsUZmwNuiEtuqR06wXovvbeLfCjAGcJfjPBlbUlGIEuchxvPJ
         TR+g==
X-Gm-Message-State: AOJu0YyAD7Qu/ueg8HaP3F110LXCzuEFmDI9Tdai2F8E/46L2ZxPVUWC
        oGp49cTW8EH4J1MzVM5hP7dRtkaErr0aDn020sqstjHrcRCL49uidxU=
X-Google-Smtp-Source: AGHT+IGwh0ywunatAy5MeeHk5SP91VnhUNy/5ce/vmlO7FYlLbSHZH+fvMcUcYsWZGLmPuJjjJUiwXexkRhSyiHdIdI=
X-Received: by 2002:a17:90a:d50d:b0:268:ee6:6bdf with SMTP id
 t13-20020a17090ad50d00b002680ee66bdfmr9968391pju.47.1691504978388; Tue, 08
 Aug 2023 07:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
In-Reply-To: <169139090386.324433.6412259486776991296.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 8 Aug 2023 16:29:27 +0200
Message-ID: <CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs instead
 of pt_regs
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Florent, feel free to add your rethook for arm64, but please do not remov=
e
> kretprobe trampoline yet. It is another discussion point. We may be possi=
ble
> to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
> allows nest probe. (maybe we can skip that case?)

Ack :)

>  arch/Kconfig                    |    1 +
>  arch/arm64/include/asm/ftrace.h |   11 ++++++
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +
>  arch/x86/Kconfig                |    1 +
>  arch/x86/kernel/rethook.c       |    9 +++--
>  include/linux/fprobe.h          |    4 +-
>  include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
>  include/linux/rethook.h         |   11 +++---
>  kernel/kprobes.c                |    9 ++++-
>  kernel/trace/Kconfig            |    9 ++++-
>  kernel/trace/bpf_trace.c        |   14 +++++--
>  kernel/trace/fprobe.c           |    8 ++--
>  kernel/trace/rethook.c          |   16 ++++----
>  kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------=
------
>  kernel/trace/trace_probe_tmpl.h |    2 +
>  lib/test_fprobe.c               |   10 +++--
>  samples/fprobe/fprobe_example.c |    4 +-

I believe that Documentation/trace/fprobe.rst should also be modified
following the API change
