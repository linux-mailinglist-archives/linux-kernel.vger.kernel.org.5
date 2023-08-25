Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69D3788D05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbjHYQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbjHYQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:20 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FA1FD0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:19 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c4cf775a14so662836fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979938; x=1693584738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLYb7dk0Mo8WnWmqBezYv61uZFgkXIPXZsPRzuku1AI=;
        b=QHPSipObj5KC8KPQ/5D9ZRw8LL6Qwm0JBTdxCotR+Hrpi4R7Ql1vOlghJ5Jen5a7Qz
         Pytcs/AksBzm/jrVuHdPhlmmfRs2hDVhBGxxJMhKabhACAo3sKNtBCncVYKeDzZF2rhZ
         Rf6CICb5wAY2CJw9YHgfyZsh86vHGlAorMC1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979938; x=1693584738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLYb7dk0Mo8WnWmqBezYv61uZFgkXIPXZsPRzuku1AI=;
        b=jOJP7YzBqcIuW+6pvbNMy2fbpUKQSrvblBhTFir6ox8XSSLbgl6XH4UekYm3irDDg2
         j+SmDJLesVcdPsAvrRIl7NllpGQ3XAs+Lt0TxkNdm7kvzSrrJf3Vp552hto3EgqaTUpi
         FqPgpyCI2HUh1EAwRyrJ39GOqNo9k1jiulSOS+qFwrRId40bKKL7XQR91fGmNWobNq+y
         ITV2y6gjLnP2GIL4uEKpYWwontLqOvOMSiKuH0pEzHOB7yj8UMtrw/UvtgHnuJYTUgJi
         jflkNDQKSiquYlUAJP8PKHBp2nczfEnpH7v9GbH87gNw5AosMn34UAGS0KwjG4YzMK1V
         691w==
X-Gm-Message-State: AOJu0YweRVu5Vhsr9hBIYZqPDr/oo+xS06iIGhHOSWHNYPrkBuhI2+EK
        aXVgATk30SJscd/07FZTJCiMCTaSyMWzsePWDIvUfg==
X-Google-Smtp-Source: AGHT+IH7rA4FZ/vJJkFxdDjuptllVaIjkNT1EtAAkwmLRfa9YBWXLp4oEqPt6Sfo7C+nW93YB3rhifY2GGNe3pH/kbs=
X-Received: by 2002:a05:6870:702b:b0:1c8:bae6:527d with SMTP id
 u43-20020a056870702b00b001c8bae6527dmr3545278oae.55.1692979938319; Fri, 25
 Aug 2023 09:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280379741.282662.12221517584561036597.stgit@devnote2>
In-Reply-To: <169280379741.282662.12221517584561036597.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:12:07 +0200
Message-ID: <CABRcYmLcTBey7QY9Ln3aVvJPV7weeTR0FA6DOU3_QObuAM8_Zg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 5:16=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index c60d0d9f1a95..90ad28260a9f 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> +#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO=
_FTRACE_REGS_CAST */
> +
> +/* Since fprobe handlers can be nested, pt_regs buffer need to be a stac=
k */
> +#define PERF_FPROBE_REGS_MAX   4
> +
> +struct pt_regs_stack {
> +       struct pt_regs regs[PERF_FPROBE_REGS_MAX];
> +       int idx;
> +};
> +
> +static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
> +
> +static __always_inline
> +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> +{
> +       struct pt_regs_stack *stack =3D this_cpu_ptr(&perf_fprobe_regs);
> +       struct pt_regs *regs;
> +
> +       if (stack->idx < PERF_FPROBE_REGS_MAX) {
> +               regs =3D stack->regs[stack->idx++];

This is missing an &:
regs =3D &stack->regs[stack->idx++];

> +               return ftrace_partial_regs(fregs, regs);

I think this is incorrect on arm64 and will likely cause very subtle
failure modes down the line on other architectures too. The problem on
arm64 is that Perf calls "user_mode(regs)" somewhere down the line,
that macro tries to read the "pstate" register, which is not populated
in ftrace_regs, so it's not copied into a "partial" pt_regs either and
Perf can take wrong decisions based on that.

I already mentioned this problem in the past:
- in the third answer block of:
https://lore.kernel.org/all/CABRcYmJjtVq-330ktqTAUiNO1=3DyG_aHd0xz=3Dc550O5=
C7QP++UA@mail.gmail.com/
- in the fourth answer block of:
https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=3DC+h+HSa5NxraPUgo63w7-iZj0C=
Xbpusg@mail.gmail.com/

It is quite possible that other architectures at some point introduce
a light ftrace "args" trampoline that misses one of the registers
expected by Perf because they don't realize that this trampoline calls
fprobe which calls Perf which has specific registers expectations.

We got the green light from Alexei to use ftrace_partial_regs for "BPF
mutli_kprobe" because these BPF programs can gracefully deal with
sparse pt_regs but I think a similar conversation needs to happen with
the Perf folks.

----

On a side-note, a subtle difference between ftrace_partial_regs with
and without HAVE_PT_REGS_TO_FTRACE_REGS_CAST is that one does a copy
and the other does not. If a subsystem receives a partial regs under
HAVE_PT_REGS_TO_FTRACE_REGS_CAST, it can modify register fields and
the modified values will be restored by the ftrace trampoline. Without
HAVE_PT_REGS_TO_FTRACE_REGS_CAST, only the copy will be modified and
ftrace won't restore them. I think the least we can do is to document
thoroughly the guarantees of the ftrace_partial_regs API: users
shouldn't rely on modifying the resulting regs because depending on
the architecture this could do different things. People shouldn't rely
on any register that isn't covered by one of the ftrace_regs_get_*
helpers because it can be unpopulated on some architectures. I believe
this is the case for BPF multi_kprobe but not for Perf.

> +       }
> +       return NULL;
> +}
> +
> +static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs=
)
> +{
> +       struct pt_regs_stack *stack =3D this_cpu_ptr(&perf_fprobe_regs);
> +
> +       if (WARN_ON_ONCE(regs !=3D stack->regs[stack->idx]))

This is missing an & too:
if (WARN_ON_ONCE(regs !=3D &stack->regs[stack->idx]))




> +               return;
> +
> +       --stack->idx;
> +}
> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_T=
O_FTRACE_REGS_CAST */
