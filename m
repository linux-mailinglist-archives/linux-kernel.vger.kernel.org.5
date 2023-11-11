Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899017E8975
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjKKGJS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Nov 2023 01:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjKKGJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:09:17 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E21BD;
        Fri, 10 Nov 2023 22:09:14 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2155512a12.3;
        Fri, 10 Nov 2023 22:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699682954; x=1700287754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLyHIF2sCw7nQSeRTMUd8HSyAjmMPKzWdw6MTGsmvp4=;
        b=hoaQxctW0dlPmq9ugD81D0vXwznAvOwFuhup9YbGQ6YFFpS75VM35Bwuh3jg1Wb0xi
         VWeMSbEw7Yd2iNCJ0M7oxz2w1EIRXbDKC/pbFCR+akHYZZcTNfvNq2ycU0Dj5TzH0YJE
         XX5G3vfMJ7DQV9i86AaE4Hq/OBklqiFXzK6DabG6RI6qrmI5/fwyTEqWp27UNjP1dp0t
         HIPz5Qbdm21ViuPhWhsLzj1pwnjQdKOU2ggfegOsrp/qpGJ4Rs1xq3iXXQwqODRjPFZT
         cgFp73SUzDBcbASpnmzrU/Rjy0yIxVkiVg71LeSUPXx2HQ018FXQDWLt9qzfqubXUWeg
         4IZA==
X-Gm-Message-State: AOJu0YzcxADnYEQnpiF1+DRa9iaACyzSbMrmlO3RmvIO6ouNJfjW8LkG
        VeDLi58LQ+3BuXz2t3MPfEEx6Kst+9mwqzm8y2skyjLk
X-Google-Smtp-Source: AGHT+IGJNodZdJLQqA2A931sioIB4RTDQaczO2VEBUB7SDOaXoIV+md3fBzl9ATAnUbsBrLf7O+ykT0Z258YNTh1Zts=
X-Received: by 2002:a05:6300:8081:b0:181:8e2:ba3c with SMTP id
 ap1-20020a056300808100b0018108e2ba3cmr1468367pzc.19.1699682953923; Fri, 10
 Nov 2023 22:09:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <b9e939c77fa74baec8d1b2d3001958f12ef16eb9.1699487758.git.jpoimboe@kernel.org>
In-Reply-To: <b9e939c77fa74baec8d1b2d3001958f12ef16eb9.1699487758.git.jpoimboe@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Nov 2023 22:09:02 -0800
Message-ID: <CAM9d7cj8d_ckRzp8O=NOpHOK50My6QVcUxoRaEAcFTTgO296cQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] perf: Remove get_perf_callchain() 'init_nr' argument
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 8, 2023 at 4:43 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The 'init_nr' argument has double duty: it's used to initialize both the
> number of contexts and the number of stack entries.  That's confusing
> and the callers always pass zero anyway.  Hard code the zero.

IIRC it was used to skip a number of first stack entries in BPF.
I changed the code to not use init_nr but forgot to update
the perf code.

Acked-by: Namhyung Kim <Namhyung@kernel.org>

Thanks,
Namhyung

>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/perf_event.h |  2 +-
>  kernel/bpf/stackmap.c      |  4 ++--
>  kernel/events/callchain.c  | 12 ++++++------
>  kernel/events/core.c       |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index afb028c54f33..f4b05954076c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1533,7 +1533,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>  extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>  extern struct perf_callchain_entry *
> -get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> +get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                    u32 max_stack, bool crosstask, bool add_mark);
>  extern int get_callchain_buffers(int max_stack);
>  extern void put_callchain_buffers(void);
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index d6b277482085..b0b0fbff7c18 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -294,7 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth = sysctl_perf_event_max_stack;
>
> -       trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
> +       trace = get_perf_callchain(regs, kernel, user, max_depth,
>                                    false, false);
>
>         if (unlikely(!trace))
> @@ -420,7 +420,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>         else if (kernel && task)
>                 trace = get_callchain_entry_for_task(task, max_depth);
>         else
> -               trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
> +               trace = get_perf_callchain(regs, kernel, user, max_depth,
>                                            false, false);
>         if (unlikely(!trace))
>                 goto err_fault;
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1273be84392c..1e135195250c 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -177,7 +177,7 @@ put_callchain_entry(int rctx)
>  }
>
>  struct perf_callchain_entry *
> -get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> +get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                    u32 max_stack, bool crosstask, bool add_mark)
>  {
>         struct perf_callchain_entry *entry;
> @@ -188,11 +188,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
>         if (!entry)
>                 return NULL;
>
> -       ctx.entry     = entry;
> -       ctx.max_stack = max_stack;
> -       ctx.nr        = entry->nr = init_nr;
> -       ctx.contexts       = 0;
> -       ctx.contexts_maxed = false;
> +       ctx.entry               = entry;
> +       ctx.max_stack           = max_stack;
> +       ctx.nr                  = entry->nr = 0;
> +       ctx.contexts            = 0;
> +       ctx.contexts_maxed      = false;
>
>         if (kernel && !user_mode(regs)) {
>                 if (add_mark)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 683dc086ef10..b0d62df7df4e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7600,7 +7600,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>         if (!kernel && !user)
>                 return &__empty_callchain;
>
> -       callchain = get_perf_callchain(regs, 0, kernel, user,
> +       callchain = get_perf_callchain(regs, kernel, user,
>                                        max_stack, crosstask, true);
>         return callchain ?: &__empty_callchain;
>  }
> --
> 2.41.0
>
