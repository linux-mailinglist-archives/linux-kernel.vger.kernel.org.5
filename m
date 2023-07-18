Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC487584FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGRSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:45:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF1B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:45:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9540031acso14257721fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689705928; x=1692297928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQcjDzMAzlRozW1RPujrpQZ4VH1P5tCP35WnE5FcHBE=;
        b=r1k7qnUmhCTSWZGAs71mSrDWoBX/Fdfp8ciPXPeO79WEvaW14u2V2twf8H8hPmlrwq
         v7XOvVUuIH5xSIvMoXKzrpO9pfxG9Ll9caqXglrV6tB0s4I7PWvWpmyi6TlfHvMq4yb7
         fxujR2cDW42G0RZwaYhCmMyyaRdQe8UtnKA4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705928; x=1692297928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQcjDzMAzlRozW1RPujrpQZ4VH1P5tCP35WnE5FcHBE=;
        b=i2pnknk1BwK0WMefhO13Rufcai8R+Kv0yR/tWIL/Hpv/Yhz/I9Rxtv1qBfNOeTAD18
         MZENSstduTQMpEEgskqK+nHkv2+MucDAHuKLZX5AETt/gVLUuy1bn5aX8NH8+/s0YNC8
         QAkciinTiWB+Sc08fzH/EwM24gAF6n+dH7YbFwwCCkgw0LawOAWHdeNFHKriUIVc/mEY
         tD89PkZ2rz7HVwos5KTROJ5VLNfh5S/kQqRE2qwhwviszsiQy6C6GrufmpVTAG+9TF1t
         WskUh3FUK4De3FawaXKRbJukcZBhatZ2ImYD+jAtI7ZcfEmjzEMktClanTmx5qRnftZs
         88Xg==
X-Gm-Message-State: ABy/qLYTipDoRv/lwmfcRwEN7f/Boe0i8Mr0cGfaY+xb7XmdMvk4HZ5k
        dX3/Ubxjk4Ql+Two3tyufSYR02/fKYH8DyPLef3n
X-Google-Smtp-Source: APBJJlHLou947zMltu5m9xW4Za9OZOwIq/iPUwzG6P9FaszY4ZwbDsZ0RuUADIU6B09s7vukUf9+BkUVhiPNJSdUFQA=
X-Received: by 2002:a2e:2c19:0:b0:2b6:ad79:a4fb with SMTP id
 s25-20020a2e2c19000000b002b6ad79a4fbmr11475404ljs.1.1689705927456; Tue, 18
 Jul 2023 11:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <DDB4EEB8-12A0-4E66-8E96-808E84A82078@remlab.net> <CAOnJCU+ee=FXWp7mz_Tn07TbRBb3eXLFBqyRBAJbhQTO-Jxvrw@mail.gmail.com>
 <4761144.fSbbhVQpq0@basile.remlab.net>
In-Reply-To: <4761144.fSbbhVQpq0@basile.remlab.net>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 18 Jul 2023 11:45:15 -0700
Message-ID: <CAOnJCUJreDYWZcSRr-pb1vwRg_LyU7TBG+b_9Ys8rVmM8_fvgA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
To:     =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Mathieu Malaterre <malat@debian.org>,
        Jan Newger <jannewger@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:06=E2=80=AFAM R=C3=A9mi Denis-Courmont <remi@rem=
lab.net> wrote:
>
>         Hi,
>
> Le tiistaina 18. hein=C3=A4kuuta 2023, 2.22.54 EEST Atish Patra a =C3=A9c=
rit :
> > > AFAIK, if the default settings breaks user space, the patchset is
> > > considered to break user space. That being the case, either this case=
 is
> > > deemed special enough that breaking user space is OK, or it is not.
>
> > This case is a special case as the usage was incorrect in the first
> > place.
>
> I agree that it's not only insecure but also incorrect. However it mostly
> works. In fact I don't disagree with the change as such, but I think that=
 the
> commit messages are misleading and confusing. For a start, in one place i=
t
> says that it is not breaking user space and in another it says basically =
the
> opposite.
>

Agreed. We will improve the commit message to clarify that. That's also the
reason I started this whole thread :)

> (Unfortunately, not everybody agrees with the change. I can't seem to get
> FFmpeg's checkasm tool fixed:
> http://ffmpeg.org/pipermail/ffmpeg-devel/2023-July/312245.html )
>

Why can't rdtime(equivalent of rdtsc) be used instead of rdcycle ?
What does it use in x86 ? It also doesn't allow reading cycle counter
by default.

The perf syscall overhead is just one time setup thing during the
start of the application.
For counting the cycles before/after a loop, it still provides a
direct CSR access in user mode.

> Also this is not the first time somebody argues that an API should be rem=
oved
> because it's broken. That's not special.
>
> > Any application that genuinely requires rdcycle can always get
> > it now via the perf interface.
>
> Sure. But the question is whether it breaks user space and if so, whether
> that's acceptable. Existing apps that call RDCYCLE will now fail, presumb=
ly
> receive SIGILL(?).
>

Yes. With this changes it will receive SIGILL if the default is NO ACCESS.
You can change the sysctl parameter to enable the direct access though
and make it work though.

> > If the insecure and incorrect behavior is allowed, we suspect the user
> > space behavior will never be fixed as it is hard to put a future flag
> > date in these cases.
>
> For better or worse, I can only agree there. But then adding an option to
> preserve the broken behaviour is begging for people to (ab)use it, and in=
deed
> never fix the problem, and never be able to remove the option.
>

x86 still carries that option. So I don't think once get down path, it
will very difficult to remove it.

> > > If it is not OK, then the only way out that I can think of, consists =
of
> > > trapping and emulating the counters, returning the same sanitised val=
ues
> > > that Linux perf would return. Then you can add a kernel config option=
 to
> > > disable that trap-and-emulation code in the future.
> > What do you mean by "sanitised" value ?
>
> I mean whatever avoids creating a security issue. Presumably report the n=
umber
> of cycles spent in the calling thread and in user mode since the first ti=
me
> that the process called RDCYCLE?
>
> Maybe it's not reasonable for complexity or performance reasons, but then=
 IMO,
> it deserves a little bit better explaining in the commit message.
>

Yes. I believe the complexities and throwaway code (assuming we should
stop doing that in the long run)
is not worth it given that we have a perfectly valid interface via
perf without any performance sacrifice.
RISC-V is not the first one to do it. It is disabled by default for
ARM64/x86 as well.

If the application usage was legal and we have years of software
development relying on that, it might have
made sense (e.g. x86 legacy usage). However, RISC-V is still young to
avoid those pitfalls.

> --
> =E9=9B=B7=E7=B1=B3=E2=80=A7=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99
> http://www.remlab.net/
>
>
>


--=20
Regards,
Atish
