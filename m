Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10483781D54
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHTKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjHTKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BB4F0;
        Sun, 20 Aug 2023 03:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B070360DFA;
        Sun, 20 Aug 2023 10:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1510CC433C7;
        Sun, 20 Aug 2023 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692525753;
        bh=whLSHn+VoRRAck8v3j3Zfrs67sqU8jHElhntki+13r4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VRIhCWWvpSMEoZXgTTmPvtJIo6cO0EUTBlWKYb6GvObPfM9+hl1ip3yb0Q71UENXE
         7eyoasePBio10+sMuPyL1uPofVJPeXBZ0GPirLJcP6q4eLr4aMhMJRlMNqJ712jec8
         ckVYzHr95ANe5LO18hh6+EEeL6u1zY+zqVIW3OlSYLG71Nr0CalzZgr+8DXaQORvYk
         jyOAMbZP7iW7d69FsezOL4JsgYEt6SnyrjtJXe/i1Qbx2QcmF+xtkHC8fOB79bWIyW
         iq2xqrsYrKLiLFVryhFkEAceoB7mNk8nO/bC1TKoBuyR7M0sxxA1hKBHY1dE8zMvzP
         8kQV6K6vlqFEA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso3480228e87.1;
        Sun, 20 Aug 2023 03:02:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YwD2MxT7XCKTAwgvmY+lvePO1HJa6Q9dlnY/GzV4DcIxtUKF0nf
        WWBoLbW7vGSC2rZNWtUmxbNpMoK78S5+DMn30Mw=
X-Google-Smtp-Source: AGHT+IE3Nl6HhQbImCc7HNzmXASVxJI6AlnLeAyTTLfsyTQqm8VdRyDu8xZbz1y0VAAQ8i8FgwAcSqXzr2yBpbv203U=
X-Received: by 2002:ac2:465b:0:b0:4f6:29cf:c0dd with SMTP id
 s27-20020ac2465b000000b004f629cfc0ddmr2826750lfo.8.1692525751081; Sun, 20 Aug
 2023 03:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
 <20230818213705.b4f5e18b392c4837068cba6f@kernel.org> <20230818114141.2a3a75ee@gandalf.local.home>
 <4853240.31r3eYUQgx@pwmachine> <20230818142033.1d7685e9@gandalf.local.home>
 <20230819101519.568d658fbb6461cc60d348e5@kernel.org> <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
 <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
In-Reply-To: <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Sun, 20 Aug 2023 03:02:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
Message-ID: <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

On Sun, Aug 20, 2023 at 2:32=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
[...]
> > >
> > > perf_event_attr::kprobe_func =3D "_text";
> > > perf_event_attr::probe_offset =3D OFFSET;
> > >
> > > Then, it should be able to specify the correct one. Of course you can=
 use
> > > other unique symbols around the target symbol.
> >
> > Trying to catch up with the thread.
>
> Thanks for your reply :)
>
> >
> > Besides the CAP_* issue, we can do this with
> >
> > perf_event_attr::kprobe_func =3D NULL;
> > perf_event_attr::kprobe_addr =3D address;
>
> As I pointed, you don't need actual address, instead, you can specify the
> probe point via "unique symbol" + offset.

Technically, this works. But it is weird to me.

> >
> > Then for the CAP_*, I think we should give CAP_PERFMON access to
> > /proc/kallsyms. Would this work?
>
> For the "unique symbol" + offset, you don't need the kallsyms, but need t=
o
> access the System.map or vmlinux image. In this case, we don't need to ex=
pand
> the CAP_PERFMON capabilities.

I agree this is not needed in this case. But I wonder whether it makes sens=
e
to give CAP_PERFMON access to /proc/kallsyms. Will this change make
CAP_PERFMON less secure?

Thanks,
Song
