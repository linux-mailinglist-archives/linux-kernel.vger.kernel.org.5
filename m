Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252978926F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHYXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHYXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:35:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92863213C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:35:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a2185bd83cso179063266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693006505; x=1693611305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrGn7GzwpGyAxPMQSvPbrYNKw3I7cF4DEEkS0WkvjsE=;
        b=KmV1FT3T5UmtvEcMI44OGQ6gj6XSTDsqetlqoD3vTUwHDT8V/hVB3pF2ZKN/D6DLAM
         X/Dfa5iK438X6jzPqMYTGPMph3H5mQlYdkq7I1gOq7X2GmFOL/1S+L+AV3nqQkudmI6J
         Q59Ve0WYSpfT3TONdOlaoQv5IaKK8GBR4iVOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006505; x=1693611305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrGn7GzwpGyAxPMQSvPbrYNKw3I7cF4DEEkS0WkvjsE=;
        b=f/JvpLwpmEvKWnTxp7Nv1i7cSJX9ws/lnoPe/Yh97eokw5wmgNJsgNixpTQPD/unxc
         mTQbh5xfMKuLn7JrnPWtRQ5xT16tHaYCfBvXA1VAXRzwbqSZeIw7k8bUFeOAcLCg4KYG
         R5lURWXP9DEGezpa/Q+wdNfRuZ3nAcK2DBzGYZ2KViCgEGtDv5d223u0/TWXB1Ru15eB
         TS3+jpQ4wG2Z5EbAbNXPOSz0z92z5Ng++Ji/IDCYatF/Do2uUlFWM5Dualop+3xiFi9Z
         3EMfjs4d388ihI8SIO/OIMyfTqQHMPMCl4n3wLUIZpkTGIN/Bk+OH91o+7vCJFsgllwR
         pvOQ==
X-Gm-Message-State: AOJu0Yy2/VY3DNaU7zlZxQN9FfzN5iu1u7ztKjTmm2qZ8kGuvMraDCes
        7G8JpnbwvgSwa2VifS0g6/Zo0RLqg6nywXj+C987AQ==
X-Google-Smtp-Source: AGHT+IG5oHfm8JmlZmp3UQF5eKyu4TEpkz1niZ7u7eH7Cg6keb683VtQF8UR5ThwdyzJ/OaWuNSRTw==
X-Received: by 2002:a17:907:7629:b0:9a1:f4e8:87b9 with SMTP id jy9-20020a170907762900b009a1f4e887b9mr5646528ejc.45.1693006504661;
        Fri, 25 Aug 2023 16:35:04 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b0099ddc81903asm1435191ejb.221.2023.08.25.16.35.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 16:35:03 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so2024687a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:35:03 -0700 (PDT)
X-Received: by 2002:a17:907:7758:b0:9a1:f10d:9751 with SMTP id
 kx24-20020a170907775800b009a1f10d9751mr6046396ejc.23.1693006503012; Fri, 25
 Aug 2023 16:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com> <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
In-Reply-To: <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Aug 2023 16:34:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
Message-ID: <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Bill Wendling <morbo@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 15:57, Bill Wendling <morbo@google.com> wrote:
> >
> Another idea is that there are __builtin_* functions for a lot of
> functions that are currently in inline asm

No. We've been through this before. The builtins are almost entirely
untested, and often undocumented and buggy.

> The major issue with the
> `__builtin_ia32_readeflags_*` was its inability to take unrelated MSRs
> into account during code motion. That may not be the same worry here?

No, the problem with __builtin_ia32_readeflags_*() was that it was
literally completely buggy and generated entirely broken code:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104971

but that's really more of a symptom than anything else.

It's a symptom of the fact that unlike inline asm's, those builtins
are often undocumented in what compiler version they appeared, and are
of very questionable quality. They often don't have many users, and
the test suites are non-existent.

For example, we *do* use __builtin_ffs() on x86 for constant values,
because the compiler does the right thing.

But for non-constant ones, the inline asm actually generates better
code: gcc generatea some disgusting mess with a 'bsf' followed by a
'cmov' for the zero case, when we know better.

See for example

   https://godbolt.org/z/jKKf48Wsf

I don't understand why compiler people prefer a builtin that is an
untested special case that assumes that the compiler knows what is
going on (and often doesn't), over a generic escape facility that is
supported and needed anyway (inline asm).

In other words: the statement "builtins generate better code" is
simply PROVABLY NOT TRUE.

Builtins have often generated *worse* code than using inline asms, to
the point where "worse" is actively buggy crap.

At least inline asms are reliable. That's a *big* deal.

               Linus
