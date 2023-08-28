Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500E278B736
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjH1SZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjH1SZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:25:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A113D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:25:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso5361153e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693247111; x=1693851911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YYQjGDw6zrjA4gHYIkErDzKVOCQS4WllI1Xx3Q7eP4=;
        b=AbLTto9YaaycJ6PseRR/9rn/3LeY1lrSFUOsVXEZ0Vg7k5UOTza0jIYpCa8BcKfTcc
         5PzdKf+Ze5kABNb34m64J7b1dy80iKIBKHfCROKIcoB59I9jB++1blIfNmnYCh3Mj1sQ
         NyhJT6rl3n4Ra0infY5+Q3KPwU8AOFdTsU8Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247111; x=1693851911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YYQjGDw6zrjA4gHYIkErDzKVOCQS4WllI1Xx3Q7eP4=;
        b=hYAI5epkSkFgB33VQ/jrz2RZEqDShrEEBH8piZs81en2fmaUyJ8+qdN1y9t2sb/D9L
         o10+QePE6ypciFd/RBPbu9IubKwRyWJxEkkIFwlcFDDlh9xdk97ZzLxmOL4gSb95yQmm
         MVViH2cVdrDG/CN0Gvi4KN0SkBhnJaXXOo4FdG37HKDxUKUEUX7YClvXD84UG3TAeEDf
         wk+R7yM6O2YeckP8CNikc22iHCyKNPNDzJXX3cwqxCWGwo8p6CuQ2NPRpS/VTbRwn5cq
         UV6Jb8SJG5juWURsHZGGdfZc07e3POHN28++PldjHvPTtQbTHpSv1hibCvj1HBuoZqh6
         /vaA==
X-Gm-Message-State: AOJu0YzPc76y3QGTu2RxDz8vE42rmEvUWtGGzziDtNQaaRPIzUyvKBdY
        BD1msI998Tt4ZcsuHvvOHgUGJedknT0fRWOOROceww==
X-Google-Smtp-Source: AGHT+IEMcilJ1s1j3g0jmCLJqFw2xR9M6VkORKD+hin/R4MT+d8BxA6mL/wJXhUXUHWeM6UIRUvZqw==
X-Received: by 2002:a05:6512:704:b0:4ff:a25b:bca1 with SMTP id b4-20020a056512070400b004ffa25bbca1mr17396356lfs.33.1693247110978;
        Mon, 28 Aug 2023 11:25:10 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b00992ea405a79sm4934059ejd.166.2023.08.28.11.25.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:25:10 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bf1f632b8so474180866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:25:10 -0700 (PDT)
X-Received: by 2002:a17:907:a04d:b0:9a1:e758:fc6e with SMTP id
 gz13-20020a170907a04d00b009a1e758fc6emr11440118ejc.10.1693247109830; Mon, 28
 Aug 2023 11:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
 <CAGudoHGGXNP5dBpZLadBUTVeD-JPEuikQXONruJzvnRJrp5+KA@mail.gmail.com>
In-Reply-To: <CAGudoHGGXNP5dBpZLadBUTVeD-JPEuikQXONruJzvnRJrp5+KA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 11:24:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrsfz4HmJE2fgdHrh-xUuVqk7t08=k2scz8Cgix0hBwg@mail.gmail.com>
Message-ID: <CAHk-=wgrsfz4HmJE2fgdHrh-xUuVqk7t08=k2scz8Cgix0hBwg@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
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

On Mon, 28 Aug 2023 at 11:04, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Other files do it (e.g., see __copy_user_nocache), but I have no
> strong opinion myself.

So the __copy_user_nocache() thing is a case of that second issue -
see my comment about "some sane visually sensible grouping" of the
numbers.

Look closer, and you'll notice that they aren't actually sequential.
They are of the form XY where the X is the grouping, and Y is the
local number within that grouping.

That case also comes with a fair amount of comments about each group
for the extable entries.

But yes, we also do have a number of thos e"sequential labels". See
for example arch/x86/lib/getuser.S, where we then end up having all
the exception handling at the end because it is mostly shared across
cases. It's ugly.

We also have a lot of ugly cases that probably shouldn't use numbers
at all, eg csum_partial(). I think that goes back to some darker age
when things like "assembly is so trivial that it doesn't need any
fancy explanatory labels for code" was ok.

See also arch/x86/lib/memmove_64.S for similar horrors. I wonder if it
is a case of "use compiler to get almost the right code, then massage
things manually". Nasty, nasty. That should use legible names, not
random numbers.

I also suspect some people really thought that the numbers need to be
unique, and just didn't know to use local numbering.

             Linus
