Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB977644F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjHIPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjHIPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:45:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5069268E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:45:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5650ec45a7cso2513a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691595940; x=1692200740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lHU70UFZyVAuqrHVgw5FV5NyicmTtalyDZ2DL/xB2w=;
        b=g2Rd9S7zT+idb4+47/ERHXouRZBGGOCRT73xhqFGwMP6fyjn+TW12P8qJf7k/gkzsZ
         qC+W+EGEm+lTfjfiAxZHImGpnz5xkd8u3O+bVyrp7enLupSgiue0ZfeOWelvCA8L2j4c
         KuDJtiR16TYtdY5pM+6ZP5azoRI4F7RwNiM3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595940; x=1692200740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lHU70UFZyVAuqrHVgw5FV5NyicmTtalyDZ2DL/xB2w=;
        b=DM+NeiGIsgBgBMJ6u8M/YmP6v8kjnPdVlA9IZrbIessqbDNNVfIhT0X77DtVT9nRFN
         omjTsdFPYRZNGqSRZHnJ5Tp4YdolPQ7N7AQYG5Thua/2/0TkWnggmMB+IC1Sl9rQIuBQ
         67g95qQqmWxCyzHfKyfbJ4G6+xOlXuTg7lzuotUvPdm5AHgjOoQo1kvNwn6QIzsQJiND
         Lu0A7OGo7L9779QpnqdPheT3+5Bz261x+5OUFGL7QNggaVCTnh5RZNkppwgMO84n+GlH
         UD5601qvOhv9pmfr35rheNkri1aQ5ER/FYnPNtHZAMHzKmOyd6U8AKzkRdl70wI1cE7Y
         rKzA==
X-Gm-Message-State: AOJu0YxC3oyHTlj8257iCykrEY1xlbC9cZmo2oAhNDyz6hlaIf/TE41N
        Nm3DRQ+z/xjsx7GE7PAAf0A6pbCbsOhQfPlgMgYXMQ==
X-Google-Smtp-Source: AGHT+IHBZ4kYatHyLUGoLTHddPeNNj7sZ1QQclLt+arjVPf9Gkn4NPvdYAJ+X39a6ovMtsxWY04+thZMWC7k84sDJso=
X-Received: by 2002:a17:90a:6c05:b0:268:c5c7:f7ed with SMTP id
 x5-20020a17090a6c0500b00268c5c7f7edmr2316230pjj.30.1691595940141; Wed, 09 Aug
 2023 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139093899.324433.3739544465888158332.stgit@devnote2> <CABRcYmK6X6okNKNu9ZjgLEO+JMGL42j7idE8QPZ_EpYA9S9UZQ@mail.gmail.com>
 <20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
In-Reply-To: <20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 17:45:29 +0200
Message-ID: <CABRcYmLe05UiK+-mCq5LA0d1Xomdpb+R_5A5HLBLbuBqfBCwUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fprobe: rethook: Use fprobe_regs in fprobe
 exit handler and rethook
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 4:43=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> > I think there are two things that can be meant with "rethook uses ftrac=
e_regs":
> >
> > - rethook callbacks receive a ftrace_regs (that's what you do further d=
own)
> > - rethook can hook to a traced function using a ftrace_regs (that's
> > what you use in fprobe now)
> >
> > But I think the second proposition shouldn't imply that rethook_hook
> > can _only_ hook to ftrace_regs. For the kprobe use case, I think there
> > should also be a rethook_hook_pt_regs() that operates on a pt_regs. We
> > could have a default implementation of rethook_hook that calls into
> > the other (or vice versa) on HAVE_FTRACE_REGS_COMPATIBLE_WITH_PT_REGS
> > but I think it's good to separate these two APIs
>
> Yeah, so for simplying the 2nd case, I added this dependency.
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..e321bdb8b22b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
>         def_bool y
>         depends on HAVE_RETHOOK
>         depends on KRETPROBES
> +       depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS || !HAVE_DYNAMIC_FTRAC=
E_WITH_ARGS
>         select RETHOOK
>
> This is the point why I said that "do not remove kretprobe trampoline".
> If there is arch dependent kretprobe trampoline, kretprobe does not use
> the rethook for hooking return. And eventually I would like to remove
> kretprobe itself (replace it with fprobe + rethook). If so, I don't want
> to pay more efforts on this part, and keep kretprobe on rethook as it is.

What are your thoughts on kprobe + rethook though ?

If that's something you think is worth having, then in this case, it
seems that having a rethook_hook_pt_regs() API would help users.

If that's a frankenstein use case you don't want to support then I
agree we can live without this API and get away with the cast
protected by the depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS...
