Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098677F29B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbjHQI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349189AbjHQI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72052684
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc8045e09dso49362755ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262681; x=1692867481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POAewNlD9kdUICg1lGQG3PlYWuMy3Xojp9urFPwdlEk=;
        b=IgrlWgQFkAtt5JGm5sm1FANwumf2xoywP7YxePvWesmAu01lrn4ateZgbevXa4fZ5k
         EOD8zziXJPM8ETA98sHgTAwULT2vUno2nhkVEqf7FbxmCUWCuPDsJYgiIvfWLWqQAJWz
         Lj0Q/6x9hLuvZKNyY31VptHkO39tX1aThlLi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262681; x=1692867481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POAewNlD9kdUICg1lGQG3PlYWuMy3Xojp9urFPwdlEk=;
        b=X2GXKhIzGla1Bk19guf0fG1kPskmyrtzqAuvu6Pd3O6hWhfV0wxitID+MXr/Gjv6nQ
         mlYv81YFeVBvsr3r87SiaANsLgzQ1XP9SKxOeSolWB/bL6yyYwsHlNHcmotOzeGYl31p
         /Bjg7sm64M8ht2kNaU8GWq8p2jZTVCoabr+jLaMBkhD862ktVqxacmyggtZMtaJVIJxx
         h476PYV5xWwqLNmFpZUzhu/yTKpg5EpJgJa94pYtpN4haE6g40TKxOfgt5y1YZot7VFE
         3iMFpc+a3Iqrfs/gGlkj9gyw6wgNWQRXg/zLMAzJWqi8NQbVvOmLmOYQ0Yy5TKN2hp+/
         n+Zg==
X-Gm-Message-State: AOJu0YxnWSYT89chOgLIcHYOIVK1OJy5UAl0X18dN5pnIsTO3e9Kzran
        kA7tz8dUIY7Y10Y8dZwiLwxhFtCbeEooa3dqmAA6Cg==
X-Google-Smtp-Source: AGHT+IGpH+pXAk8VqxIeT35jLyW0KYHgE02yw6vcZz/n1VMizwV6Ew9p2SanWxPrmSf9km59jyqbjyFHsoS+ovVRDwM=
X-Received: by 2002:a17:90a:9bca:b0:268:a26:d9ee with SMTP id
 b10-20020a17090a9bca00b002680a26d9eemr3586278pjw.46.1692262681230; Thu, 17
 Aug 2023 01:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181865486.505132.6447946094827872988.stgit@devnote2>
In-Reply-To: <169181865486.505132.6447946094827872988.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:50 +0200
Message-ID: <CABRcYm+ayJwS+YMaKBF9pdnHYcJvioOoOrXHWOeRAg1hPacYiA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d56304276318..6fb4ecf8767d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -679,7 +679,6 @@ config FPROBE_EVENTS
>         select TRACING
>         select PROBE_EVENTS
>         select DYNAMIC_EVENTS
> -       depends on DYNAMIC_FTRACE_WITH_REGS

I believe that, in practice, fprobe events still rely on WITH_REGS:

> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index f440c97e050f..94c01dc061ec 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -327,14 +328,15 @@ static int fentry_dispatcher(struct fprobe *fp, uns=
igned long entry_ip,
>         struct pt_regs *regs =3D ftrace_get_regs(fregs);

Because here you require the entry handler needs ftrace_regs that are
full pt_regs.

>         int ret =3D 0;
>
> +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> +               fentry_trace_func(tf, entry_ip, fregs);
> +
> +#ifdef CONFIG_PERF_EVENTS
>         if (!regs)
>                 return 0;
>
> -       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> -               fentry_trace_func(tf, entry_ip, regs);
> -#ifdef CONFIG_PERF_EVENTS
>         if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> -               ret =3D fentry_perf_func(tf, entry_ip, regs);
> +               ret =3D fentry_perf_func(tf, entry_ip, fregs, regs);
>  #endif
>         return ret;
>  }
> @@ -347,14 +349,15 @@ static void fexit_dispatcher(struct fprobe *fp, uns=
igned long entry_ip,
>         struct trace_fprobe *tf =3D container_of(fp, struct trace_fprobe,=
 fp);
>         struct pt_regs *regs =3D ftrace_get_regs(fregs);

And same here with the return handler

I think fprobe events would need the same sort of refactoring as
kprobe_multi bpf: using ftrace_partial_regs so they work on build
!WITH_REGS.
