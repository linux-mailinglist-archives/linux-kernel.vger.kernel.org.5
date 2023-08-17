Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B177F293
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349212AbjHQI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349201AbjHQI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979926A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26813478800so4425205a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262672; x=1692867472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd4pXZRJFepy7HbsMJqodX8ExP3gHP5syyoC+b4r7r8=;
        b=EF395AAkyWIxDY8M9y7l3rJFiqK21IwFJmg7Gip1v96Zyqbw7JqaV9W+YJ7BzMn1/m
         hAgNUlzwu/uz0+/2X8LwSeb2UweioCieQg84unNtz+3Vr0OJf/IuTZRmMvlpHc45wJRQ
         YcxAemoQfb64LOZQ3p0bD69uZlhUQhL7lb46g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262672; x=1692867472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd4pXZRJFepy7HbsMJqodX8ExP3gHP5syyoC+b4r7r8=;
        b=QUJcFyOdtEiDSq/dvu+U6zCAa7vKGjX3dl4oyExTX6VSiMehTYO/8zqug0x9A7nAHz
         90kv0jAaO75IYU58zUZuNjFsrD8fzGFrJ06SjP66vt0wCjgiGQ6Zw2rSuAxg9G7Wb8Ju
         jdgoYbgr+dIT67IqeZJZJ0WttR9Z/ThQibGR8HBkrXELRAtUhXGh8/GwHvcVq/9We95K
         m6mYMbg44osI+lWuKlfIyj5bsVKk4IyNKM+H8kchsTAPnejq/v7dagqSzewCSwWaLDpM
         nfoYL7Ptlsd8Tu5oHNsftTubhJADMIEuWCHHdSkiIJNf+wwQ+E0lOR3cgxK0+sWFbV3U
         FBDw==
X-Gm-Message-State: AOJu0YymZdldBcHe/YL5OBTDIeV2PW9JvEnfP19GDg3/ibXWO4lU97PX
        f6RZxkqTVnNDke488vYutrRlIiXyMgaRs2Kik/4QGJgNpV+lw+4v
X-Google-Smtp-Source: AGHT+IHCS6EaPpJKh3OX0fWBxFrZ2fH45kKnSc5tSKg0I+jNCBcSeZpbCvNQyUQX09GibYeF9xVGhxwvDo2mdyH4AKo=
X-Received: by 2002:a17:90a:d145:b0:26c:f6db:ad77 with SMTP id
 t5-20020a17090ad14500b0026cf6dbad77mr3281951pjw.2.1692262671688; Thu, 17 Aug
 2023 01:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181864347.505132.7098838654251139622.stgit@devnote2>
In-Reply-To: <169181864347.505132.7098838654251139622.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:40 +0200
Message-ID: <CABRcYmK2-jiDOrTqjgg41t0T2-Uf1jbsuiV0xT37M=5cVCB+Zw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
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
> index 976fd594b446..d56304276318 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
>          This allows for use of ftrace_regs_get_argument() and
>          ftrace_regs_get_stack_pointer().
>
> +config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> +       bool
> +       help
> +        If this is set, the memory layout of the ftrace_regs data struct=
ure
> +        is the same as the pt_regs. So the pt_regs is possible to be cas=
ted
> +        to ftrace_regs.

What would you think of introducing a:

#ifdef HAVE_PT_REGS_TO_FTRACE_REGS_CAST
static_assert(sizeof(struct pt_regs) =3D=3D sizeof(struct ftrace_regs);
#endif // HAVE_PT_REGS_TO_FTRACE_REGS_CAST

somewhere in ftrace.h just as a small extra safety net ? It doesn't
exactly guarantee all we want but it should give an early warning of
mistakes.
