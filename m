Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D8781A58
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHSPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHSPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 11:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE6E5F;
        Sat, 19 Aug 2023 08:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 525F661F4C;
        Sat, 19 Aug 2023 15:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55FAC433C8;
        Sat, 19 Aug 2023 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692458584;
        bh=/e9z6LgegEFmy9SM9L3YdCv7XOOtHVi0ffVZVDcOmks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hyfcUfDLo8imtVG779gYrwtRbkZLBTPUTOmbu7xT1aAdyuGkbSx7g/43BLyKrNcvC
         7+xauHDHNl3oQAZES3V3HaR3UdLKrXsoPemSKa9Zlqt0gfEcOPpJUYpmovHvWpK+Q9
         gwf6Z2FEPKl2+G8KxJ6q7eomRriPsq1ruIZ6AwFyBSlKBs7goy7RKRp62NzvFQCUOK
         TB+nSB8AYK0qVWN5goHK0virc1HRHMycnodNjzwLWGUbNwj4WaUDUxtJSXtdQ7D93d
         x4SeAvM4oMiLnrr6GVGjMJOMONiXpLqTs9eiND9aIJ+UJGLZBjdxUHhltpzxNBVOWR
         RZ8/Gy8ejRmpg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so2767743e87.3;
        Sat, 19 Aug 2023 08:23:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yybst3IzEGtrWVFtR4dWYN3ShOZX8xjdJHMXEneWAGW+CGvHgO5
        +8auJLRt8UhFY04kQSfi59j/oB3ZVyqfQ46ybKs=
X-Google-Smtp-Source: AGHT+IFq/z/fy2n3Dt01DOzcdL/TgWsWOPcrdHYBRTt7RgiPVKxoUsXump95/jKLwhwG6+fgolARZKuOkpOXUtP9hgQ=
X-Received: by 2002:a05:6512:2110:b0:4f8:6ac4:84 with SMTP id
 q16-20020a056512211000b004f86ac40084mr1439941lfr.8.1692458582739; Sat, 19 Aug
 2023 08:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
 <20230818213705.b4f5e18b392c4837068cba6f@kernel.org> <20230818114141.2a3a75ee@gandalf.local.home>
 <4853240.31r3eYUQgx@pwmachine> <20230818142033.1d7685e9@gandalf.local.home> <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
In-Reply-To: <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Sat, 19 Aug 2023 08:22:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
Message-ID: <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 6:16=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 18 Aug 2023 14:20:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Fri, 18 Aug 2023 20:13:43 +0200
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> >
> > > Hi.
> > >
> > > Le vendredi 18 ao=C3=BBt 2023, 17:41:41 CEST Steven Rostedt a =C3=A9c=
rit :
> > > > On Fri, 18 Aug 2023 21:37:05 +0900
> > > >
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > > That's why perf probe uses the offset from '_text'. Normal KASLR =
will just
> > > > > moves all symbols. (Finer one will move all symbols randomely)
> > > > > This should not need to access /proc/kallsyms but vmlinux or Syst=
emMap.
> > > >
> > > > We could just pass in: "_text+offset" too.
> > >
> > > So, the idea would be to change the existing create_local_trace_kprob=
e() and
> > > above functions to indicate the user's offset is to be used against _=
text and
> > > not address?
> >
> > No, not to modify that function, but if you know the offset from _text =
(via
> > the vmlinux), you can easily calculate it for that function.
>
> Note that the kprobe-event PMU interface itself allows you to specify
> FUNC+OFFSET style;
>
> https://lore.kernel.org/lkml/20171206224518.3598254-5-songliubraving@fb.c=
om/
>
> perf_event_attr::kprobe_func =3D "_text";
> perf_event_attr::probe_offset =3D OFFSET;
>
> Then, it should be able to specify the correct one. Of course you can use
> other unique symbols around the target symbol.

Trying to catch up with the thread.

Besides the CAP_* issue, we can do this with

perf_event_attr::kprobe_func =3D NULL;
perf_event_attr::kprobe_addr =3D address;

Then for the CAP_*, I think we should give CAP_PERFMON access to
/proc/kallsyms. Would this work?

Thanks,
Song
