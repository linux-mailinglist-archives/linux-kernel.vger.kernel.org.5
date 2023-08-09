Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E28775713
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjHIK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHIK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:28:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC31FFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:28:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a7a180c3faso1970570b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691576929; x=1692181729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q8MkAHQ4z//oNqFY2MVENDhG30E0OZjbLf49uqOaBk=;
        b=crMbapozPwtjeNppbjAxpjpuLGNgFYD9emI6UusfTFZYXC/sp6pXc9xnok3zJTqSgr
         D7E22VtBhnYZIMc5IeWUOTWbm3fQkafC00OZVVnU3trR9jrCtMSJTDkK/QZvMPqfD4jG
         jb4tVCQ9nDPf6zKfQ/TGYPFEKZ9dTG78Ooeqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576929; x=1692181729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q8MkAHQ4z//oNqFY2MVENDhG30E0OZjbLf49uqOaBk=;
        b=Pjf8vFUTaFEXcc2Y990VzrPuY1+8KSfLPbjaw+ccLTaOi8fpSSF3B27P7aj3efjl2u
         Re6cFYRwiYx7389B0IiJTnkfV9o8JxlOnYq2jL18WiVz1onWY9YnXWMD+z7vbFX9RySa
         yIleTTNYI9FcQk92vCKFXW40AJb9E7TrCl4Xdi6k4v/h77Dc5YguehzdvVMtamLX56JP
         KryRGHIAem6H7lfs2IaIbFx0/PooHfFcwtkMcq/pxS7S867HWgXgjA6htg4SXIrPES3K
         E258gn490GmAaal5sq+fbfuvmwyEz+OFXY3+1f8nacACwCoCONzpdNXpJ5w7pY/A9x07
         VUpw==
X-Gm-Message-State: AOJu0YzrQEmrgRgGNp2iK8RcO3oI++jlUwea/VRH4WsI0KpBOFDF1vqE
        nqSxsmD+PKBNkLmj9ViwEQrzF7z32rbFqe/HQvRAew==
X-Google-Smtp-Source: AGHT+IEby5BA1Rb3TBNtuipAvYfV2qs3Uz9qjee9oiSSDipAwzSRR3crVDKQeJvAjzfmcMJMfmyvZreaIidOcz+N0dQ=
X-Received: by 2002:a05:6808:23c7:b0:3a7:8e1b:9d65 with SMTP id
 bq7-20020a05680823c700b003a78e1b9d65mr2647100oib.47.1691576929466; Wed, 09
 Aug 2023 03:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139091575.324433.13168120610633669432.stgit@devnote2>
In-Reply-To: <169139091575.324433.13168120610633669432.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 12:28:38 +0200
Message-ID: <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry handler
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> on arm64.

This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
but fprobe wouldn't run on these builds because fprobe still registers
to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
!WITH_REGS. Shouldn't we also let the fprobe_init callers decide
whether they want REGS or not ?

>  static int
>  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> -                         unsigned long ret_ip, struct pt_regs *regs,
> +                         unsigned long ret_ip, struct ftrace_regs *fregs=
,
>                           void *data)
>  {
>         struct bpf_kprobe_multi_link *link;
> +       struct pt_regs *regs =3D ftrace_get_regs(fregs);
> +
> +       if (!regs)
> +               return 0;

(with the above comment addressed) this means that BPF multi_kprobe
would successfully attach on builds WITH_ARGS but the programs would
never actually run because here regs would be 0. This is a confusing
failure mode for the user. I think that if multi_kprobe won't work
(because we don't have a pt_regs conversion path yet), the user should
be notified at attachment time that they won't be getting any events.
That's why I think kprobe_multi should inform fprobe_init that it
wants FTRACE_OPS_FL_SAVE_REGS and fail if that's not possible (no
trampoline for it for example)
