Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ADA79FD45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjINHc6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:32:56 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15BCFA;
        Thu, 14 Sep 2023 00:32:52 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59b50b4556eso7064237b3.1;
        Thu, 14 Sep 2023 00:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694676771; x=1695281571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n2ubhZrp/XvWyr+KX+wmdWC0Ev8ICvzidMCC6Gicsk=;
        b=VrJUkUpZw8NvUgnvwhp9BYfJVrXve93Jx/Ov9SacXfE4+KkkSbg/Z8jKEVad42pBKz
         QSTp7rEFVzIDC22qzQmeoZrEwK9zuMfjNIaA5BGgK0g4M0OAOMQzgspGKPzaPy1IWWaB
         aBTDRaeBVqrZvFtdnP6MikDeOubT75aUJGpwI1UF8MpM73gUi/KB3qvz2BuPd86Ghje6
         cgASYv3V+aYyljAB6HoqV7SrXGaCdYVqMBQcJaVtsoIr9LCuDC1DaxQ+z+7x8fWuRlHO
         EoABK1DiFWM3NpKQpGi7spGImITjcIFguY14bWKpx6nzntqIUCsCQev6hRgSCmCMjztp
         Io1A==
X-Gm-Message-State: AOJu0YxnZPwSyGguZxdW/Gm9tTMPTPOElRo3Nr1pYOTV6OYK8Zzhg0xc
        45x+JtJPILX1BxZ7exSUXuvpGN0DKovCSw==
X-Google-Smtp-Source: AGHT+IEFNdWyBLY7RNU2MSK3PcN77mDzil3ng2zV0dBmD2qepN+MyyO1UB8oKBx/4/8AKHn3vFiv6g==
X-Received: by 2002:a81:8244:0:b0:577:21ff:4d47 with SMTP id s65-20020a818244000000b0057721ff4d47mr5325018ywf.7.1694676771046;
        Thu, 14 Sep 2023 00:32:51 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id s68-20020a0dd047000000b0059bdac3fd08sm203676ywd.48.2023.09.14.00.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:32:49 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7eccc1b8c6so743008276.0;
        Thu, 14 Sep 2023 00:32:49 -0700 (PDT)
X-Received: by 2002:a25:ea05:0:b0:d7a:d923:4493 with SMTP id
 p5-20020a25ea05000000b00d7ad9234493mr5250742ybd.64.1694676769523; Thu, 14 Sep
 2023 00:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com> <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
In-Reply-To: <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 09:32:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
Message-ID: <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On Wed, Sep 13, 2023 at 7:46 PM Evan Green <evan@rivosinc.com> wrote:
> On Wed, Sep 13, 2023 at 5:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Aug 18, 2023 at 9:44 PM Evan Green <evan@rivosinc.com> wrote:
> > > Rather than deferring unaligned access speed determinations to a vendor
> > > function, let's probe them and find out how fast they are. If we
> > > determine that an unaligned word access is faster than N byte accesses,
> > > mark the hardware's unaligned access as "fast". Otherwise, we mark
> > > accesses as slow.
> > >
> > > The algorithm itself runs for a fixed amount of jiffies. Within each
> > > iteration it attempts to time a single loop, and then keeps only the best
> > > (fastest) loop it saw. This algorithm was found to have lower variance from
> > > run to run than my first attempt, which counted the total number of
> > > iterations that could be done in that fixed amount of jiffies. By taking
> > > only the best iteration in the loop, assuming at least one loop wasn't
> > > perturbed by an interrupt, we eliminate the effects of interrupts and
> > > other "warm up" factors like branch prediction. The only downside is it
> > > depends on having an rdtime granular and accurate enough to measure a
> > > single copy. If we ever manage to complete a loop in 0 rdtime ticks, we
> > > leave the unaligned setting at UNKNOWN.
> > >
> > > There is a slight change in user-visible behavior here. Previously, all
> > > boards except the THead C906 reported misaligned access speed of
> > > UNKNOWN. C906 reported FAST. With this change, since we're now measuring
> > > misaligned access speed on each hart, all RISC-V systems will have this
> > > key set as either FAST or SLOW.
> > >
> > > Currently, we don't have a way to confidently measure the difference between
> > > SLOW and EMULATED, so we label anything not fast as SLOW. This will
> > > mislabel some systems that are actually EMULATED as SLOW. When we get
> > > support for delegating misaligned access traps to the kernel (as opposed
> > > to the firmware quietly handling it), we can explicitly test in Linux to
> > > see if unaligned accesses trap. Those systems will start to report
> > > EMULATED, though older (today's) systems without that new SBI mechanism
> > > will continue to report SLOW.
> > >
> > > I've updated the documentation for those hwprobe values to reflect
> > > this, specifically: SLOW may or may not be emulated by software, and FAST
> > > represents means being faster than equivalent byte accesses. The change
> > > in documentation is accurate with respect to both the former and current
> > > behavior.
> > >
> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Thanks for your patch, which is now commit 584ea6564bcaead2 ("RISC-V:
> > Probe for unaligned access speed") in v6.6-rc1.
> >
> > On the boards I have, I get:
> >
> >     rzfive:
> >         cpu0: Ratio of byte access time to unaligned word access is
> > 1.05, unaligned accesses are fast
>
> Hrm, I'm a little surprised to be seeing this number come out so close
> to 1. If you reboot a few times, what kind of variance do you get on
> this?

Rock-solid at 1.05 (even with increased resolution: 1.05853 on 3 tries)

> >     icicle:
> >
> >         cpu1: Ratio of byte access time to unaligned word access is
> > 0.00, unaligned accesses are slow
> >         cpu2: Ratio of byte access time to unaligned word access is
> > 0.00, unaligned accesses are slow
> >         cpu3: Ratio of byte access time to unaligned word access is
> > 0.00, unaligned accesses are slow
> >
> >         cpu0: Ratio of byte access time to unaligned word access is
> > 0.00, unaligned accesses are slow

cpu1: Ratio of byte access time to unaligned word access is 0.00344,
unaligned accesses are slow
cpu2: Ratio of byte access time to unaligned word access is 0.00343,
unaligned accesses are slow
cpu3: Ratio of byte access time to unaligned word access is 0.00343,
unaligned accesses are slow
cpu0: Ratio of byte access time to unaligned word access is 0.00340,
unaligned accesses are slow

> >     k210:
> >
> >         cpu1: Ratio of byte access time to unaligned word access is
> > 0.02, unaligned accesses are slow
> >         cpu0: Ratio of byte access time to unaligned word access is
> > 0.02, unaligned accesses are slow

cpu1: Ratio of byte access time to unaligned word access is 0.02392,
unaligned accesses are slow
cpu0: Ratio of byte access time to unaligned word access is 0.02084,
unaligned accesses are slow

> >     starlight:
> >
> >         cpu1: Ratio of byte access time to unaligned word access is
> > 0.01, unaligned accesses are slow
> >         cpu0: Ratio of byte access time to unaligned word access is
> > 0.02, unaligned accesses are slow

cpu1: Ratio of byte access time to unaligned word access is 0.01872,
unaligned accesses are slow
cpu0: Ratio of byte access time to unaligned word access is 0.01930,
unaligned accesses are slow

> >     vexriscv/orangecrab:
> >
> >         cpu0: Ratio of byte access time to unaligned word access is
> > 0.00, unaligned accesses are slow

cpu0: Ratio of byte access time to unaligned word access is 0.00417,
unaligned accesses are slow

> > I am a bit surprised by the near-zero values.  Are these expected?
>
> This could be expected, if firmware is trapping the unaligned accesses
> and coming out >100x slower than a native access. If you're interested
> in getting a little more resolution, you could try to print a few more
> decimal places with something like (sorry gmail mangles the whitespace
> on this):

Looks like you need to add one digit to get anything useful on half of the
systems.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
