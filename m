Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7529077F292
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbjHQI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349188AbjHQI5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4E2724
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56546b45f30so5778004a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262657; x=1692867457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3047fudLxdi1mO3onS+rLwsUyqFYfYLDKfiuZG4YUJM=;
        b=HJi/DlthHTk4VrLUlzPyhRI7bxeadkjObc5oNJKYFy9eYWno7RTr7MkHbC7AqqRrQy
         WIf23ddt+p8PwFW92IqOejdVm01tJw2gdu54JH9Q2z1EuuuNF7KoqL9bYtfHq+DR/Lg4
         NV6asjA8HFr/zxWH2ZacRMwaJ9YlT5KSrj8mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262657; x=1692867457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3047fudLxdi1mO3onS+rLwsUyqFYfYLDKfiuZG4YUJM=;
        b=evB0OGuo9rH14uGXhcYsy00cbS3HPdl2m9OFQdseONktjRZR7lypfsl0kMe8I/+ukv
         IcGMUlYa2GVybu+W+4fGDw7FyLT+j+ieF4cN2MymfztY20B3MYLirjNu2jY62jx3KJ8r
         H9vtkcLojcWNeJVTt8Hr66uJ4DOlRQ5CYfuBU5SnQ5ZJ4W5EpzUpHGRso/WJgvKf/2Qx
         Dpvpa8iHJUml1L9axutJRnKT/T9DMniJ35obppN2pZBGPTI9u02I4M5gSUFQ2d8QxtTY
         Y/CyqY5BPw5AS9gpWfiwLc3LD/xX1FULZUDiXCjAQY3EfFLhKwWrPU6/Whiy6kGbnAkf
         gWBQ==
X-Gm-Message-State: AOJu0Yz3xfJ0/l8IJ7zTCQz4oJS51KjoqWLNr5d4lK6ZefzA5HtKxsYm
        KX2/CdSonGs8CgR7c5bF4rnDy62nIlYnX/hU9l1ZXw==
X-Google-Smtp-Source: AGHT+IHvsMZnwwNnaI1QyczKPAq0kpcZmxmcPZ8yv+5Kpilk9edjm2psrQLXI4TMLyfn8Fm/yzzYV0A8bXR9NKZIihk=
X-Received: by 2002:a17:90a:c086:b0:269:1e3f:a54d with SMTP id
 o6-20020a17090ac08600b002691e3fa54dmr3685525pjs.10.1692262657084; Thu, 17 Aug
 2023 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181861911.505132.8322840504168319403.stgit@devnote2>
In-Reply-To: <169181861911.505132.8322840504168319403.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:26 +0200
Message-ID: <CABRcYmLhVxRwMYWjTE855WMg5fV+O1tLz8HJmy_6G6LK5ZEtVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] fprobe: Use fprobe_regs in fprobe entry handler
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2467,7 +2467,7 @@ static int __init bpf_event_init(void)
>  fs_initcall(bpf_event_init);
>  #endif /* CONFIG_MODULES */
>
> -#ifdef CONFIG_FPROBE
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

Shouldn't this be #if defined(CONFIG_FPROBE) &&
defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) ?

I believe one could build a kernel with FTRACE_WITH_REGS and without
FPROBE and then this code would have undefined references to fprobe
functions, wouldn't it ?

And then patch 7 should be "Enable kprobe_multi feature even if
FTRACE_WITH_REGS is disabled"
