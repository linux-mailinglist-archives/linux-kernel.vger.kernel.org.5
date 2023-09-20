Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96937A89E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjITQ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjITQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:58:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5764129
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:58:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5310a63cf7bso4700168a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695229123; x=1695833923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VBATFQF6dlOmh7K8WWAThqiY1eLo2LHS4t8VOlA1EXQ=;
        b=gl1fHrMtnNE1ac77kGMYF1kmi9ir61fLOOA69jVMaOLtOPB9MrvYQ3j8hSRX3Fw7ho
         IGSrC97oPk5QdLyI/YihvkmKxB7u2vQXvO9jfgcAePh++uq/owuSXHdMFJ/+/4UhbSfo
         fbHgVsK7OwtZBWI6JACu/fP+Kt08g1cK7tXOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229123; x=1695833923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBATFQF6dlOmh7K8WWAThqiY1eLo2LHS4t8VOlA1EXQ=;
        b=sqfbNWWHGohK2AdWHc8K4oPWTpPHeM5wCr3JIqwaeLprKBHu3Awt/q0hwn18foqPvn
         k6SnVz2CEnLONv5SCq+QT52aW0FURXp1cXHL+fxCyl4y3YynpzemQt7o6MMRouCTTsSf
         eS9Lb2x/GSEL73W5eBgTM8bqlrcsBFNV4orxCicYY5X94OmajXuR4NH9HwpJnIJ+IHnV
         d0Zxw4fbu9c2WmHRyYEf7yoJBhfJAXZW3ln8sGmq+bZGvUguTJuOzZqxuuw/w7Nt+iaY
         8OL5V9DP6GskvNLv6eIEaVG0EaSUZIJihs7thd2ZXJkeSwTCF/H0BiCAaTUlEwDqZBEV
         yfWg==
X-Gm-Message-State: AOJu0YxMy1ZbsbSUwiG8+nG+Cs6WvPjbhnDgvdJHI1pkUGvH57lEwNRX
        5dia6yWod4SC1/1v7XCLPj1qOYQqLOEQHTsiarK4pqM9
X-Google-Smtp-Source: AGHT+IGPZBJbrJeUGKNl2d0Hw7zSWdX5p9PZFdPRn8sf1w9urven3EyJApKHDGkQdVm9ueu+2YsTvA==
X-Received: by 2002:aa7:cfc1:0:b0:522:1f09:dde3 with SMTP id r1-20020aa7cfc1000000b005221f09dde3mr2756425edy.3.1695229122990;
        Wed, 20 Sep 2023 09:58:42 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7c150000000b0052fe12a864esm9151989edp.57.2023.09.20.09.58.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 09:58:42 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so9080121a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:58:42 -0700 (PDT)
X-Received: by 2002:a05:6402:164e:b0:52f:34b3:7c4 with SMTP id
 s14-20020a056402164e00b0052f34b307c4mr2539957edx.39.1695229121693; Wed, 20
 Sep 2023 09:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au> <ZQW849TfSCK6u2f8@casper.infradead.org>
 <cb763591-a697-ab74-171e-fcd7f4e70137@westnet.com.au> <5add8ae8-d746-b254-7559-b96aa72d3523@westnet.com.au>
In-Reply-To: <5add8ae8-d746-b254-7559-b96aa72d3523@westnet.com.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 09:58:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-C5S0zx4uSyzfJDZzG3g7U9ZMkZMQbbFyCnywtKW5qA@mail.gmail.com>
Message-ID: <CAHk-=wg-C5S0zx4uSyzfJDZzG3g7U9ZMkZMQbbFyCnywtKW5qA@mail.gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
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

On Wed, 20 Sept 2023 at 00:45, Greg Ungerer <gregungerer@westnet.com.au> wrote:
>
> The problem with this C implementation is that need to use loal_irq_save()
> which results in some ugly header dependencies trying top include irqflags.h.
>
> This version at least compiles and run, though we can probably do better still.

I was going to say "can't you use CAS?" but apparently coldfire
doesn't have that either. What a horrible thing.

I do wonder if we should just say "let's use the top bit instead"?

The reason we used bit #7 is that

 - only x86 used to do the clear_bit_unlock_is_negative_byte

 - it was easy with a simple "andb".

 - it was just a trivial "move two bits around".

but honestly, on x86, doing it with "andl/andq" shouldn't be any
worse, and we can still use a (sign-extended) 8-bit immediate value to
xor the low seven bits and test the high bit at the same time - so it
should be basically exactly the same code sequence.

There's a question about mixing access widths - which can be deadly to
performance on x86 - but generally this op should be the only op on
the page flags in that sequence, and doing a byte access isn't
necessarily better.

Of course, using the top bit then screws with all the
zone/node/section/lru_gen bits that we currently put in the high bits.
So it's absolutely *not* just a trivial "move this bit" operation.

It would change all the <linux/page-flags-layout.h> games we do.

That might be enough for any sane person to go "this is not worth it",
but *if* Willy goes "I like the bit twiddling games", maybe he'd be
willing to look at that.

I mean, he wrote alpha assembler for this, that certainly says
*something* about WIlly ;)

Willy?

                  Linus
