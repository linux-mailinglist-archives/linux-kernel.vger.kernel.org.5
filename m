Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEE878236F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjHUGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHUGJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352D83;
        Sun, 20 Aug 2023 23:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E96262A2F;
        Mon, 21 Aug 2023 06:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02707C433C9;
        Mon, 21 Aug 2023 06:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692598177;
        bh=ssiMBaUr9tRVHvnV/noXb/30s/sSrHlu/s0IfSivOUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfEhz0U51L6iAMAaGStNRZSwpGvSte3tF6id4QQXaY+bhFBZOVzzZUrectD/WjuS3
         ZtFQQl+C0S6uNaTxmMye+QvcX136OXmYOzA63uwSNakPVDnQn/JU1jsnXT4q9iU3YG
         3LDWYrtdj/drTP3s3SxA9J7GtE4jZKGDMuC9fPdBEqZM0GiIUNt2q4+uT4w7frAEzH
         JrZtpz0o+lH1+1tDP3i3A+fR/l8lxLu6KetV5SF4DPXep/QK4pXQGFd6MOzM0uCqbv
         nooqUB50Ar5eB26dbARIlaFuul08bN+YK6+Y2h7p7elVuApSWAXjYWhUT02IE5g483
         Bp1QsMDcLnG3A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5007c8308c3so1176134e87.0;
        Sun, 20 Aug 2023 23:09:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx5r9ktbkqvp9mh90o8WisILvEyXl8qXcQ05c42tce6lNCJMnL0
        q8jRffI+GaKXMBReZ7y/x3V/WDyadtxAK5fLR1U=
X-Google-Smtp-Source: AGHT+IGYhSq0JxlkDg1fdU8x+6piQiRkoSNoJxpQZ8Acd/Ek6CQ9C8tByxC6/P8jv3bn7XXjbfYGyXKpcQY1qbqQ2pA=
X-Received: by 2002:a05:6512:2313:b0:4f8:6d99:f4f3 with SMTP id
 o19-20020a056512231300b004f86d99f4f3mr4449971lfu.52.1692598174973; Sun, 20
 Aug 2023 23:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
 <20230818213705.b4f5e18b392c4837068cba6f@kernel.org> <20230818114141.2a3a75ee@gandalf.local.home>
 <4853240.31r3eYUQgx@pwmachine> <20230818142033.1d7685e9@gandalf.local.home>
 <20230819101519.568d658fbb6461cc60d348e5@kernel.org> <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
 <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org> <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
 <20230820221612.33dfc3b3072f8bd8517f95b5@kernel.org>
In-Reply-To: <20230820221612.33dfc3b3072f8bd8517f95b5@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Sun, 20 Aug 2023 23:09:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7+dRddDe9XLuM2ANnGZOa2J4MnSDkWZ_xZCGVxj02bXQ@mail.gmail.com>
Message-ID: <CAPhsuW7+dRddDe9XLuM2ANnGZOa2J4MnSDkWZ_xZCGVxj02bXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 6:16=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Sun, 20 Aug 2023 03:02:18 -0700
> Song Liu <song@kernel.org> wrote:
>
> > On Sun, Aug 20, 2023 at 2:32=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > [...]
> > > > >
> > > > > perf_event_attr::kprobe_func =3D "_text";
> > > > > perf_event_attr::probe_offset =3D OFFSET;
> > > > >
> > > > > Then, it should be able to specify the correct one. Of course you=
 can use
> > > > > other unique symbols around the target symbol.
> > > >
> > > > Trying to catch up with the thread.
> > >
> > > Thanks for your reply :)
> > >
> > > >
> > > > Besides the CAP_* issue, we can do this with
> > > >
> > > > perf_event_attr::kprobe_func =3D NULL;
> > > > perf_event_attr::kprobe_addr =3D address;
> > >
> > > As I pointed, you don't need actual address, instead, you can specify=
 the
> > > probe point via "unique symbol" + offset.
> >
> > Technically, this works. But it is weird to me.
>
> It's not so weired because it is a relative address, e.g. from _text,
> this means "the address in the text section". And perf probe already
> uses it a while.
>
> > > >
> > > > Then for the CAP_*, I think we should give CAP_PERFMON access to
> > > > /proc/kallsyms. Would this work?
> > >
> > > For the "unique symbol" + offset, you don't need the kallsyms, but ne=
ed to
> > > access the System.map or vmlinux image. In this case, we don't need t=
o expand
> > > the CAP_PERFMON capabilities.
> >
> > I agree this is not needed in this case. But I wonder whether it makes =
sense
> > to give CAP_PERFMON access to /proc/kallsyms. Will this change make
> > CAP_PERFMON less secure?
>
> Yes, because /proc/kallsyms will expose the real address of the all
> symbols, which makes KASLR useless. But on the other hand, it maybe
> already useless because BPF program can read any real address, right?
> Hmm, from this point of view, is the CAP_PERFMON meaningful?
> (maybe it can avoid loading modules etc.)

kprobe BPF program has access to pt_regs, so it can read ip of the
attached function. Can we do the same with regular kprobe (no bpf)?

Thanks,
Song

>
> Thank you,
>
> >
> > Thanks,
> > Song
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
