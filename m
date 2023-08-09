Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D57764B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHIQKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:10:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0219E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:10:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26837895fc8so3975754a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691597402; x=1692202202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMpn6SbN2eaSRjTRTeLdDj+fif3mbbSQ4nc9edZTZdA=;
        b=VTFoUM0oS3XFRrMwLsXKltkF1VN5RVPAXlncucHEJOFf93EqFusEyKe1jrKOOIKe0c
         9mvGxd6qeO2oJoDFePnOzjXy1kGtvqGvNFrifMRnd0owBmXQHmB5sgrnFwt5mJ4ywj4H
         vyne1muga6wEAADqA/Ur2syLuagWmg6YYBAHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597402; x=1692202202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMpn6SbN2eaSRjTRTeLdDj+fif3mbbSQ4nc9edZTZdA=;
        b=JUrAf0JXxdQHiQCVIgQp+a4518NatnIxJl4v3cQp+Aka+w0IBHj/c771CnkyE2xl/V
         F8XQRgflzOkC5uAoWmt14VzwU4wg/mK+HKurpeHdXthfjv0Gcf67QYl96P/Kzlk8ZZAD
         iyAMdjdsGK+N0HD0zIeh07G9/u5d6ub24lohFlFVDOleQff/p7fMb40gG0kbWR+Hq3tP
         +bmt3hxFwLo9hpsz3XQG0++Kc2nowZCJmBHDHVI6AG8ISkqD+dKqcok8s1u7yF8acHm2
         UG6jTG67GXmNs7h9LBeb9CKMtJD3E6j0UfuHgEdVeQ3l2qQ5J+bGWR23UksmZE0KBK2Y
         FQDg==
X-Gm-Message-State: AOJu0Yy2WYMnLU8JXVVdpK3d9Kv/gOAXEflBDpLgRxPcxFushLsdIEiZ
        s64rqfqpEWJBB2Q7Psi3uYZOG6HAvGLqlind0JEiTA==
X-Google-Smtp-Source: AGHT+IEMGnO9kaOwJBUsDP9Hvg41gwbYDBnHKOGLLGQmbe/Vs8lyEc+Tx1Z5SksDYU6d5P9FVwop5V3adn3cw6RiBJQ=
X-Received: by 2002:a17:90a:db90:b0:267:fe84:6647 with SMTP id
 h16-20020a17090adb9000b00267fe846647mr2564394pjv.13.1691597402536; Wed, 09
 Aug 2023 09:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139091575.324433.13168120610633669432.stgit@devnote2> <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
 <20230809231011.b125bd68887a5659db59905e@kernel.org>
In-Reply-To: <20230809231011.b125bd68887a5659db59905e@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 18:09:51 +0200
Message-ID: <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry handler
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 4:10=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> Hi Florent,
>
> On Wed, 9 Aug 2023 12:28:38 +0200
> Florent Revest <revest@chromium.org> wrote:
>
> > On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_A=
RGS
> > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > > on arm64.
> >
> > This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> > but fprobe wouldn't run on these builds because fprobe still registers
> > to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> > !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> > whether they want REGS or not ?
>
> Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
> on it. But fprobe itself can work because fprobe just pass the ftrace_reg=
s
> to the handlers. (Note that exit callback may not work until next patch)

No, I mean that fprobe still registers its ftrace ops with the
FTRACE_OPS_FL_SAVE_REGS flag:

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/ker=
nel/trace/fprobe.c?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a2513c=
95f7ed5b5b727fb2c4#n185

Which means that __register_ftrace_function will return -EINVAL on
builds !WITH_REGS:

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/ker=
nel/trace/ftrace.c?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a2513c=
95f7ed5b5b727fb2c4#n338

As documented here:

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/inc=
lude/linux/ftrace.h?h=3Dtopic/fprobe-ftrace-regs&id=3D2ca022b2753ae0d2a2513=
c95f7ed5b5b727fb2c4#n188

There are two parts to using sparse pt_regs. One is "static": having
WITH_ARGS in the config, the second one is "dynamic": a ftrace ops
needs to specify that it doesn't want to go through the ftrace
trampoline that saves a full pt_regs, by not giving
FTRACE_OPS_FL_SAVE_REGS. If we want fprobe to work on builds
!WITH_REGS then we should both remove Kconfig dependencies to
WITH_REGS (like you've done) but also stop passing this ftrace ops
flag.

> >
> > >  static int
> > >  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip=
,
> > > -                         unsigned long ret_ip, struct pt_regs *regs,
> > > +                         unsigned long ret_ip, struct ftrace_regs *f=
regs,
> > >                           void *data)
> > >  {
> > >         struct bpf_kprobe_multi_link *link;
> > > +       struct pt_regs *regs =3D ftrace_get_regs(fregs);
> > > +
> > > +       if (!regs)
> > > +               return 0;
> >
> > (with the above comment addressed) this means that BPF multi_kprobe
> > would successfully attach on builds WITH_ARGS but the programs would
> > never actually run because here regs would be 0. This is a confusing
> > failure mode for the user. I think that if multi_kprobe won't work
> > (because we don't have a pt_regs conversion path yet), the user should
> > be notified at attachment time that they won't be getting any events.
>
> Yes, so I changed it will not be compiled in that case.

Ah ok I missed the CONFIG_DYNAMIC_FTRACE_WITH_REGS guard that you keep
between patch 1 and 6 to avoid this case. (after patch 6, it's no
longer an issue) then that's fine.
