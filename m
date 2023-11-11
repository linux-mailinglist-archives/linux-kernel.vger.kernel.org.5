Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCD7E8976
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjKKGLi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Nov 2023 01:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjKKGLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:11:36 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF8B1BD;
        Fri, 10 Nov 2023 22:11:33 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28010522882so2456204a91.0;
        Fri, 10 Nov 2023 22:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699683093; x=1700287893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ddHYTZTNQYfWPEsDiloeDxXlsjz6/dU2onUF8dEMH4=;
        b=raVDB8lUl0J/OHule4jY+IxJFf2rh3BH1Gk/7piN76GcRVUubasGimu7qrNMYCLs+i
         G8kcEi/MHbBPdmvr7NA3G8fS1/imAm2N38dO4Lc0qYxH0hP0gSSk2cLFUij5Gzl2O1sS
         RtJ2yasuYGM6k6LQW0pdhqkmIIhrOpIARf/+PxaypNEycV4sZXyI3hQg9kqIUHfgOyxU
         Yy3Z1DMA2xc/OzbpmcVnwfB50ndOZZqca5etTyFYl8qLWE5JdAT2RK+98aW8krAuXTlQ
         iBFf5xfz3P/Wd+v1Yqx6eMolYES8y/ziC13bVGBOATJxzO3eOBit0G4SMSsOnROuPHA+
         RlHA==
X-Gm-Message-State: AOJu0YzRpnvRhmQbvXDJWrHH+aVBemaeoW8hX/6cQCOsBLso5cMx0iUD
        WOfat9L9eO9xvFCm7If12xHeF342qVL09UJvwNU=
X-Google-Smtp-Source: AGHT+IHrdZvyEETxsbZeZ11IPqRKILjddyJxt6+H0KgNg8gE81IGF5fzs/rzc9Egb7CEM44Ke15VqCxz3oHDBpbPUfg=
X-Received: by 2002:a17:90b:4a4a:b0:27d:20ca:1156 with SMTP id
 lb10-20020a17090b4a4a00b0027d20ca1156mr836715pjb.34.1699683092874; Fri, 10
 Nov 2023 22:11:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <f2c5130322a419ad04ea328a22fc2908487a1e25.1699487758.git.jpoimboe@kernel.org>
In-Reply-To: <f2c5130322a419ad04ea328a22fc2908487a1e25.1699487758.git.jpoimboe@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Nov 2023 22:11:21 -0800
Message-ID: <CAM9d7chDdw4tMx9Vqw_P5D5K32pptHr4ncv8kQJr-bko6RLoBw@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] perf: Remove get_perf_callchain() 'crosstask' argument
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 4:44 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> get_perf_callchain() doesn't support cross-task unwinding, so it doesn't

For only user stacks, but it seems there's no place to get cross-task kernel
stacks too.

> make much sense to have 'crosstask' as an argument.  Instead, have
> perf_callchain() adjust 'user' accordingly.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  include/linux/perf_event.h | 2 +-
>  kernel/bpf/stackmap.c      | 5 ++---
>  kernel/events/callchain.c  | 6 +-----
>  kernel/events/core.c       | 8 ++++----
>  4 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f4b05954076c..2d8fa253b9df 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1534,7 +1534,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
>  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>  extern struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -                  u32 max_stack, bool crosstask, bool add_mark);
> +                  u32 max_stack, bool add_mark);
>  extern int get_callchain_buffers(int max_stack);
>  extern void put_callchain_buffers(void);
>  extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index b0b0fbff7c18..e4827ca5378d 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth = sysctl_perf_event_max_stack;
>
> -       trace = get_perf_callchain(regs, kernel, user, max_depth,
> -                                  false, false);
> +       trace = get_perf_callchain(regs, kernel, user, max_depth, false);
>
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
> @@ -421,7 +420,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>                 trace = get_callchain_entry_for_task(task, max_depth);
>         else
>                 trace = get_perf_callchain(regs, kernel, user, max_depth,
> -                                          false, false);
> +                                          false);
>         if (unlikely(!trace))
>                 goto err_fault;
>
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1e135195250c..aa5f9d11c28d 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
>
>  struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -                  u32 max_stack, bool crosstask, bool add_mark)
> +                  u32 max_stack, bool add_mark)
>  {
>         struct perf_callchain_entry *entry;
>         struct perf_callchain_entry_ctx ctx;
> @@ -209,9 +209,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                 }
>
>                 if (regs) {
> -                       if (crosstask)
> -                               goto exit_put;
> -
>                         if (add_mark)
>                                 perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>
> @@ -219,7 +216,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                 }
>         }
>
> -exit_put:
>         put_callchain_entry(rctx);
>
>         return entry;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b0d62df7df4e..5e41a3b70bcd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7592,16 +7592,16 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  {
>         bool kernel = !event->attr.exclude_callchain_kernel;
>         bool user   = !event->attr.exclude_callchain_user;
> -       /* Disallow cross-task user callchains. */
> -       bool crosstask = event->ctx->task && event->ctx->task != current;
>         const u32 max_stack = event->attr.sample_max_stack;
>         struct perf_callchain_entry *callchain;
>
> +       /* Disallow cross-task user callchains. */
> +       user &= !event->ctx->task || event->ctx->task == current;
> +
>         if (!kernel && !user)
>                 return &__empty_callchain;
>
> -       callchain = get_perf_callchain(regs, kernel, user,
> -                                      max_stack, crosstask, true);
> +       callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
>         return callchain ?: &__empty_callchain;
>  }
>
> --
> 2.41.0
>
