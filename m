Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741ED775721
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjHIKbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHIKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:31:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD2210B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:31:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26928c430b2so2739313a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691577072; x=1692181872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQfIsHY5NEOAQ1OhrWSDUQtlAV+UbCmzK5iCvrQ5LSM=;
        b=IHf6FjyBrHygMbNwjb8Y/eareC9GpNDdG5vfVWnA4OOVfUtzSd/7mzUUM8Dwt5pjTE
         H1DCjwnQJGk5v0Sw5Z/aR+tjNFQ1+RXbhZYD0nJqtJ08j3TIa1xHJRiNoiBiepHnnx/l
         GIkUgxubIOcbbmEOyJmbp8nTkXt/UpUJXf9gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577072; x=1692181872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQfIsHY5NEOAQ1OhrWSDUQtlAV+UbCmzK5iCvrQ5LSM=;
        b=XY9LYb3Z//3PXh5Y+XjbCi4P4isMFgiQTVc9qhR+9QlVgIobmi6A2feAjlsx76Zl+y
         bUStiZPS66i5c9EaT1Y4q6eUB9SKSdYRMIjE4+VQ2lGCQNKKxWo4lIKh6QLO+AvbIeu9
         klm0ljbC4w9UpKVNtv1drrr8ABNq28DEezSECFoWU3Z0prlxfiwEVobdCdWzqBOlWM/Z
         xldA/sj+mOLIk29AQxoVTJElZNXdwUwcrffa6QBaPTfT/PWdVXyDY78MBIRt1Rx52U+A
         0Aygu06AiBJvqOkO6ENr1GkQOhvqEuzeFWP1IX7J0zDGR6SWUEfBDAh/8v1BviTfnFe9
         8asQ==
X-Gm-Message-State: AOJu0Yx4OIoTv4qaonk3OAtRYEmUX1RBc7eYnm4PX8lXf/d1jLRF0Y1j
        r+a/PRMpqSRKEk1hl7YdV8+qVHLoowXvmfx/v2jkvQ==
X-Google-Smtp-Source: AGHT+IGt4EGmUEJug2nEf8tGVkzTEo/UX5avAbzyw42k+XHz9vAI5SZrU/cRjcAgiPDxDS+CZsNiPIi02EaK3R7qkVA=
X-Received: by 2002:a17:90a:ea0a:b0:268:b66b:d9f6 with SMTP id
 w10-20020a17090aea0a00b00268b66bd9f6mr1476419pjy.18.1691577071857; Wed, 09
 Aug 2023 03:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139095066.324433.15514499924371317690.stgit@devnote2>
In-Reply-To: <169139095066.324433.15514499924371317690.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 12:31:00 +0200
Message-ID: <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:49=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Allow fprobe events to be enabled with CONFIG_DYNAMIC_FTRACE_WITH_ARGS.
> With this change, fprobe events mostly use ftrace_regs instead of pt_regs=
.
> Note that if the arch doesn't enable HAVE_PT_REGS_COMPAT_FTRACE_REGS,
> fprobe events will not be able to use from perf.

nit: "to be used from perf" ?

> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -132,25 +132,30 @@ static int
>  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>                    void *base)
>  {
> -       struct pt_regs *regs =3D rec;
> -       unsigned long val;
> +       struct ftrace_regs *fregs =3D rec;
> +       unsigned long val, *stackp;
>         int ret;
>
>  retry:
>         /* 1st stage: get value from context */
>         switch (code->op) {
>         case FETCH_OP_STACK:
> -               val =3D regs_get_kernel_stack_nth(regs, code->param);
> +               stackp =3D (unsigned long *)ftrace_regs_get_stack_pointer=
(fregs);
> +               if (((unsigned long)(stackp + code->param) & ~(THREAD_SIZ=
E - 1)) =3D=3D
> +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))

Maybe it'd be worth extracting a local
"ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
"ftrace_regs_within_kernel_stack" ?
