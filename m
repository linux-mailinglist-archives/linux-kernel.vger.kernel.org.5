Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF77A9F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjIUUQs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 16:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjIUUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:16:27 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA4BF11A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:54:30 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bdcbde9676so812751a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322465; x=1695927265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrvL93JjA1OfTIMuGz/cONlaf0wwFcM6NEpdJQ6xEag=;
        b=dGzfOYDnLAtvz2o6gJnE+qwk0W0PVPHRnVDZKnVn/ocjg6+G+v3cO5iI205ivMtp68
         A6rVg/GqrWD5tlMzxevXvaeBZbaG5CKVn28TITyBBiG1VGO8zcpJy0m45cWfTRbbYlV+
         jQHfrpocBWv+woupkBWlrHNuEqYgDATZ4dfVAseUA/SLQE2RybXVilrFdwoCsTyMZdfX
         yl0mWzJiz/JGt0NBOG01tw0D8AakcQ0Olim4wxjUaU4txqozvwE+uDHYvhnTrAq7RhRq
         0yyASS5pLQS8DUrpBxjOOGg/ZFeQdnT1Z4jv4XHWSxyVmuorxjmbuTtHrf4eLN/2jPcD
         ontA==
X-Gm-Message-State: AOJu0Yzh2vkiMuM9CXAXegxYdBMoNaPkfpvputZcch0d93gMlz2/f0l4
        snr57JA7HTrJEw3wmolbp2zBjMY4iy6jo9SZ
X-Google-Smtp-Source: AGHT+IFiiH//fzFHIRnfdIr37MFf5uK+krOwnNhvdWeRJHzlP3+9eddii6fTcgNAv7C4wXoGbPpBGg==
X-Received: by 2002:a0d:fa42:0:b0:589:f9f0:2e8c with SMTP id k63-20020a0dfa42000000b00589f9f02e8cmr4780619ywf.48.1695280124425;
        Thu, 21 Sep 2023 00:08:44 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id t186-20020a0deac3000000b00583b40d907esm194734ywe.16.2023.09.21.00.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:08:44 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59c0442a359so7858087b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 00:08:43 -0700 (PDT)
X-Received: by 2002:a81:8385:0:b0:57a:2f01:31d7 with SMTP id
 t127-20020a818385000000b0057a2f0131d7mr4953764ywf.1.1695280123148; Thu, 21
 Sep 2023 00:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <202309192013.vI4DKHmw-lkp@intel.com> <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
 <a57afd40-71a2-aa68-84cb-44d2a88a1e2b@roeck-us.net> <CAL_JsqJYPJVTxH=d5nYK78+ZWhZAfh4VhEyBLqzyg4MzMhrX0g@mail.gmail.com>
 <194e2d22-9eff-ec6c-9bc9-13b62bda870a@roeck-us.net> <CAL_JsqKcD4AttSVUEi5zuF8S1E4xNdqdZVKiHmk0r79SRW5Cqw@mail.gmail.com>
 <ad1f36ab-29a6-98b6-8782-3980323760e1@roeck-us.net>
In-Reply-To: <ad1f36ab-29a6-98b6-8782-3980323760e1@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 09:08:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXsiSfp3DGnLXfuENVLOdG91a+GXj3+g9p8Yp6aGTuqDQ@mail.gmail.com>
Message-ID: <CAMuHMdXsiSfp3DGnLXfuENVLOdG91a+GXj3+g9p8Yp6aGTuqDQ@mail.gmail.com>
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'}
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter, Rob,

CC Michael

On Wed, Sep 20, 2023 at 11:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 9/20/23 09:20, Rob Herring wrote:
> [....]
>
> >>
> >> Sure, but I still argue that this isn't worth it for drivers like this one.
> >> Are you going to submit a fix ? Because otherwise I'll submit a patch
> >> to drop COMPILE_TEST from MACHZ_WDT.

I think dropping COMPILE_TEST from MACHZ_WDT is the right thing to do
anyway.  Unlike most other drivers, this is not a driver that can be
compiled in, and doesn't do anything if the hardware is not present.
In fact it is a very dangerous driver: its probe function "reads" the
ZF version register, but that involves doing an unconditional write,
which might crash any non-X86 system.

IMHO a driver must not be enabled for compile-testing if its presence
can harm the system.

> > I honestly don't know what the fix is. There's a compiler flag to
> > allow 0 address, but that seems like a big hammer. From what I read on
> > the fix for gcc-12, we shouldn't be getting this, but I haven't
> > confirmed. I was hoping for comment from Geert as the issue doesn't
> > appear to be the driver, but the arch code.

Well, Atari ROM port ISA accesses are really weird, due to the really
weird way the bus is wired to the address/data lines...
The issue is that gcc considers accessing these addresses as "not
done"...

> > Furthermore, I just built the same HEAD and config as reported and
> > don't see this error. I'm using kernel.org nolibc gcc 13.2.0 which
> > should be the same version.
>
> Exactly my point. So now we are stuck with a report like this on a
> driver which probably has 0 users and we don't know how to fix it,
> all to get the benefit of being able to compile it for an architecture
> and platform which will never use it.
>
> I seem to recall similar errors with m68k and COMPILE_TEST last time
> I tried to enable it on watchdog drivers, so I am not sure if this is
> entirely new.

Probably not.

Michael: original build failure report in
https://lore.kernel.org/r/202309192013.vI4DKHmw-lkp@intel.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
