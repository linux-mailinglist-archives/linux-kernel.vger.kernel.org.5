Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E245079EAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbjIMOYp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbjIMOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:24:30 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D32716;
        Wed, 13 Sep 2023 07:13:18 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59b8f5b6c0aso31953027b3.0;
        Wed, 13 Sep 2023 07:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614397; x=1695219197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRpbpxG9eEjGpyBn7Kr+3oxPttjTha6vURJi3KhijJQ=;
        b=Uau3NgWSGCkQ1+x31JG3pmeIX3d41+gO7alrOVH1u+V3Pof4PUwxqcK38OC/bHXhmM
         1XS0npU56eSkKmKMCl9dJCN4kL9+Sg6Z+lURtTOba2CT/j1bM+Tu3d5RX4/YS9sYh3Pg
         tYk1Iv0AFwCygf34zZ0g8SriNT+S9GICmlOtnnLlPdH1Dcpr3mOBhWq1YSU/Dfw+hwZK
         TNoOHhqWzJ8GHVswExzEKIb3mvmd32Am75T8QMvA57OZyugBB9KH1dmMK8QXyutKtv3x
         HOBs2CNKH3lp1BhvD2i31F3rXyVRs43Y0Z+hD6d8l7z+A1lmqIJgefKltarYdWOzdUNF
         OP1g==
X-Gm-Message-State: AOJu0Yy+iAmrk8xpABm9MRGXT7/zcYAhJXVDDiiPolQNzMKy5rZGrdpV
        ibvn+pYUdxY3QM3yCll241hFAjTC0OnNUw==
X-Google-Smtp-Source: AGHT+IHaxE1vFJ+272ldJhzTtPcpmgXRoJny6sCrqdKLc0zizQ2XED8qC2dTaG8bEJeZ/jjNxR49rg==
X-Received: by 2002:a0d:d752:0:b0:59b:b894:eb98 with SMTP id z79-20020a0dd752000000b0059bb894eb98mr2852057ywd.19.1694614397583;
        Wed, 13 Sep 2023 07:13:17 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i190-20020a0dc6c7000000b0057a0e5b18e0sm3125175ywd.142.2023.09.13.07.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:13:17 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d7b8d2631fdso6551415276.3;
        Wed, 13 Sep 2023 07:13:17 -0700 (PDT)
X-Received: by 2002:a25:4217:0:b0:d78:26a0:ab8b with SMTP id
 p23-20020a254217000000b00d7826a0ab8bmr2248584yba.55.1694614397158; Wed, 13
 Sep 2023 07:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230802184849.1019466-1-arnd@kernel.org> <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com> <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
In-Reply-To: <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 16:13:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
Message-ID: <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Sep 13, 2023 at 4:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 13, 2023, at 14:32, Geert Uytterhoeven wrote:
> > On Wed, Aug 2, 2023 at 8:49 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> These functions were only used on the microdev
> >> board that is now gone, so remove them to simplify
> >> the ioport handling.
> >>
> >> This could be further simplified to use the generic
> >> I/O port accessors now.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> >> --- a/arch/sh/include/asm/io.h
> >> +++ b/arch/sh/include/asm/io.h
> >> @@ -181,7 +181,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)  \
> >>  {                                                                      \
> >>         volatile type *__addr;                                          \
> >>                                                                         \
> >> -       __addr = __ioport_map(port, sizeof(type));                      \
> >> +       __addr = (void __iomem *)sh_io_port_base + port;                \
> >
> > Note that this adds unconditional users of sh_io_port_base, while
> > sh_io_port_base is provided by arch/sh/kernel/ioport.c, which is
> > currently only built if CONFIG_GENERIC_IOMAP=n.
> >
> > This is not a problem yet, as the final part to enable GENERIC_IOMAP
> > on SH never made it upstream.  However, Sato-san's series enables
> > GENERIC_IOMAP for SH_DEVICE_TREE=y builds, leading to a link failure.
>
> Do you have a link to that series? I don't understand why you'd
> want to enable GENERIC_IOMAP on sh, given that its PIO accesses
> are always memory mapped in the end.

"[RESEND RFC PATCH 00/12] DeviceTree support for SH7751 based boards."
https://lore.kernel.org/linux-sh/cover.1693444193.git.ysato@users.sourceforge.jp/

In the meantime, there is a v2, which I wasn't aware of when I wrote
my previous email, so perhaps my comment is no longer valid.
"[RFC PATCH v2 00/30] Device Tree support for SH7751 based board"
https://lore.kernel.org/linux-sh/cover.1694596125.git.ysato@users.sourceforge.jp

> Is this needed for the trapped_io CF stuff?

I don't know.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
