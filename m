Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA44D7588B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGRWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGRWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:49:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A30130
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:49:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b74310566cso98326431fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689720541; x=1692312541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4G8i0z25JPUORewUf5NcbkzT14wHq+ZHZkM3VxrvWg=;
        b=TutWihx/ByldQVPemMfBSq0RWHlMdgdBqrUU6qj+Nb7xp5Qs/lPey9xZSHfZd3e1zO
         enGeUmcf3NEW7W6Jy4W1yGhXvEroVBz90nk0JHR0gwqGlnDh7RW7orehVw6gk10dsX/o
         8GzQONkIqJPja0IOfyV6rvUx83kc0gQyRCDWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720541; x=1692312541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4G8i0z25JPUORewUf5NcbkzT14wHq+ZHZkM3VxrvWg=;
        b=GzWYQQoVerhQgiR5llu98MUgRGXPAHbqn+VKLJurlRBUjH8rUgaCBK7Jk97ShrHj4p
         uzFfxUK9l0CLSGD8Q0dHL60GJz8TZLglyCiv+6aP+bV/K9qVJFL/Gtuzlp8QnXDSx5yb
         p8WVoaRA9sYksVC1H+W9Zml1yvnNnYP/6tPi74GUBlb3dUj5P3vIh5WtWopXMsLS8Ep8
         cZrltfPY8msvjBTS8hicKEuebgob4r0oSwqVORNSxN7JmONFwu76qv9BuAKvpVxIsMUr
         CjDMHW2DdzCS+tH9zqghy31uepO45IpW4KYENo0QCfyNIdIqfDjEO+WkxKcKR2KgQJ+h
         USYA==
X-Gm-Message-State: ABy/qLaJWuxKh1EnKKJXPE3ZCwqY8Y0+auJgR98KRIHHmn02jZ/Q6JD/
        3lHTuIvXxhmZldGJK6KOU2HicuEQlDy/XV73wVwj
X-Google-Smtp-Source: APBJJlGDK/RpNs7dyiRNzDW6ZJiyQedtPhRBV07nFoX4NeU0wURCRm2qTRS5Ad3SJ5QWR1wl6N13zuoAXzynQwqm52I=
X-Received: by 2002:a2e:84d7:0:b0:2a7:adf7:1781 with SMTP id
 q23-20020a2e84d7000000b002a7adf71781mr11501967ljh.2.1689720541250; Tue, 18
 Jul 2023 15:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <4761144.fSbbhVQpq0@basile.remlab.net> <CAOnJCUJreDYWZcSRr-pb1vwRg_LyU7TBG+b_9Ys8rVmM8_fvgA@mail.gmail.com>
 <8756384.Zvl9fuB8X0@basile.remlab.net>
In-Reply-To: <8756384.Zvl9fuB8X0@basile.remlab.net>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 18 Jul 2023 15:48:49 -0700
Message-ID: <CAOnJCU+W9u+HnMfjU_y9W7331Zx07eQs9R1twV0=KsBAeSMSjw@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 12:04=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@rem=
lab.net> wrote:
>
> Le tiistaina 18. hein=C3=A4kuuta 2023, 21.45.15 EEST Atish Patra a =C3=A9=
crit :
> > > I agree that it's not only insecure but also incorrect. However it mo=
stly
> > > works. In fact I don't disagree with the change as such, but I think =
that
> > > the commit messages are misleading and confusing. For a start, in one
> > > place it says that it is not breaking user space and in another it sa=
ys
> > > basically the opposite.
> >
> > Agreed. We will improve the commit message to clarify that. That's also=
 the
> > reason I started this whole thread :)
> >
> > > (Unfortunately, not everybody agrees with the change. I can't seem to=
 get
> > > FFmpeg's checkasm tool fixed:
> > > http://ffmpeg.org/pipermail/ffmpeg-devel/2023-July/312245.html )
> >
> > Why can't rdtime(equivalent of rdtsc) be used instead of rdcycle ?
>
> Isn't RDTIM susceptible to interference from power management and CPU
> frequency scaling? I suppose that RDCYCLE may behave differently dependin=
g on
> PM in *some* designs, but that would still be way better than RDTIME for =
the
> purpose.
>

Yes. But that's what it is probably using for other ISAs ? My point
was it should
just do whatever it does for other ISA. RISC-V is no special in that regard=
.

> As far as benchmarking is concerned (_excluding_ system security), RDTIME
> seems to have all the problems of RDCYCLE, and then some more, no?
>

Correct. If the application can deal with noisy data, it can use
rdtime similar to
other architectures. Otherwise, it should just use the perf mmap
interface in the beginning
and read the counters whenever required.

> > The perf syscall overhead is just one time setup thing during the
> > start of the application.
> > For counting the cycles before/after a loop, it still provides a
> > direct CSR access in user mode.
>
> I suppose that you allude to mmap() here? The (dumb) FFmpeg code is using=
 the
> ioctl() interface though, but that's just laziness.
>

Yeah. I agree it is more work but just one time effort to get more
reliable data without
compromising the security.

> --
> =E3=83=AC=E3=83=9F=E3=83=BB=E3=83=87=E3=83=8B-=E3=82=AF=E3=83=BC=E3=83=AB=
=E3=83=A2=E3=83=B3
> http://www.remlab.net/
>
>
>


--=20
Regards,
Atish
