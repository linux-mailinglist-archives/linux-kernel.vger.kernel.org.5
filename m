Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B678B565
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjH1QbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjH1Qav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:30:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26934D9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:30:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c93638322so710525966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693240247; x=1693845047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K+5N1fWI32TeY8hsmX0pN1FtWreP2KKGQj9XvCZzb4A=;
        b=LeORfmGLSvf/oOFusvXfPbr+1WDMfTqUYDN0JFN5clyfrJeg44b9q3kaILuSz+sDjy
         RebnIBwN2J26+dG9aWPpG4k129DkZpYTPIgo7Kc8j+kroVSayiAF670JZ9k06b2iLODm
         nWMHMsboGLp28UQLoCPf3ctnSemDalD680Vz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240247; x=1693845047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+5N1fWI32TeY8hsmX0pN1FtWreP2KKGQj9XvCZzb4A=;
        b=LGAGB9eCTP3tjOaFrthfQeJcDQ7CUOV7QqhZwmY6rsgGHaeGjsVPZKXjdHcJgtgnjx
         anxaW8cFDBbh8Ef60b35QublNd7ZdMSZKM2nGlbrD4ejIuAwicgwN8KukF87keb9ReXD
         DFPclsoFovugAGnExxonIvMVZwncAD/RKdonv2t51NyfooQjAPNeOj+dTf0ElE3TLXln
         pOnkk3+ClBSbdWwtP+aIBvq+Ct2HZmP66/anlJBELWGBbkgW3Gmo1+lnpwOzC0CMYMFu
         XW+5d8vcC7IgOlyVpMU01swqSedkAtoFcH54GYjKM1eOzivyXAa4ADOsMeKdOjOLlKsl
         Hv0A==
X-Gm-Message-State: AOJu0YwHlFWXxTbN7ZGPOgi6vEKBU3imeyaOOqr7zo7bKo5F5txvdSSQ
        AyqZzkTCnsnfoNC76mTlTYnWMW3SviAV5n85G/QFyg==
X-Google-Smtp-Source: AGHT+IH//6rO4+va5hQhSIajitB5Ot0eHJysB47DG66wLIQxE4xn3oRzV90VF6TkMs6MFVQH2JRqpg==
X-Received: by 2002:a17:907:3d8e:b0:982:a022:a540 with SMTP id he14-20020a1709073d8e00b00982a022a540mr177466ejc.11.1693240247532;
        Mon, 28 Aug 2023 09:30:47 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906339300b0099bc8db97bcsm4810452eja.131.2023.08.28.09.30.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:30:46 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9058964a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:30:46 -0700 (PDT)
X-Received: by 2002:a17:907:a04e:b0:9a1:eb4f:56f with SMTP id
 gz14-20020a170907a04e00b009a1eb4f056fmr164971ejc.13.1693240246530; Mon, 28
 Aug 2023 09:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com> <cc5f4f5701674b96b0009b6b9b257cc8@AcuMS.aculab.com>
In-Reply-To: <cc5f4f5701674b96b0009b6b9b257cc8@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 09:30:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieUuOd-aUz0dma6TnZ+TLVk5-ytJiwbMqLpjcvdzzvQg@mail.gmail.com>
Message-ID: <CAHk-=wieUuOd-aUz0dma6TnZ+TLVk5-ytJiwbMqLpjcvdzzvQg@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     David Laight <David.Laight@aculab.com>
Cc:     Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 03:53, David Laight <David.Laight@aculab.com> wrote:
>
> From: Linus Torvalds
> >
> > We use this:
> >
> >   static __always_inline unsigned long variable__ffs(unsigned long word)
> >   {
> >         asm("rep; bsf %1,%0"
> >                 : "=r" (word)
> >                 : "rm" (word));
> >         return word;
> >   }
> >
> > for the definition, and it looks like clang royally just screws up
> > here. Yes, "m" is _allowed_ in that input set, but it damn well
> > shouldn't be used for something that is already in a register, since
> > "r" is also allowed, and is the first choice.
>
> Why don't we just remove the "m" option?

For this particular case, it would probably be the right thing to do.
It's sad, though, because gcc handles this correctly, and always has.

And in this particular case, it probably matters not at all.

In many other cases where we have 'rm', we may actually be in the
situation that having 'rm' (or other cases like "g" that also allows
immediates) helps because register pressure can be a thing.

It's mostly a thing on 32-bit x86 where you have a lot fewer
registers, and there we've literally run into situations where we have
had internal compiler errors because of complex inline asm statements
running out of registers.

With a simple "one input, one output" case, that just isn't an issue,
so to work around a clang misfeature we could do it - if somebody
finds a case where it actually matters (as opposed to "damn, when
looking at the generted code for a function that we never actually use
on x86, I noticed that code generation is horrendous").

             Linus
