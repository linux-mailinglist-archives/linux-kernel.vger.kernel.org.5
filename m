Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152667A29CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbjIOVvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjIOVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:51:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910610E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:51:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso330414166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694814666; x=1695419466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M/1H/23B2pkin+rn0KDXQiysBhZl0AsbvPleWos4qKQ=;
        b=I1skia3iXZPN5fOujj4G0hpY/pFPaeK9a3BZfbe7r53ycatMMpo3wkbmz4bvQfKTm7
         XMDtm+lJS4LJT/psmmPZ2hEmMLQb5RO73JfRgun/DJ0ORr6WwPh5vV7439V4oZkbXu63
         rqa6qvVqD49H05Fr+DvDzrmokZNFSM+EmX+Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694814666; x=1695419466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/1H/23B2pkin+rn0KDXQiysBhZl0AsbvPleWos4qKQ=;
        b=XX6iS8u12VT6olWZS6OZB+BbeHEeoU5BIALy6w5CESxklrXW+A/gtFDjNmLv1Nn7i6
         bsE+w4qY3I0II4osVEqAhaB1jAQOXz3PQkK6sfRSzQEe5P/0HwY4oJAELQmDw3aFUgEP
         eyXY6DGx6S7kHBNmuJkwRBdehNe4Jfu0e3HJRknUTi5dAK73JSgafBhjvdTFqngqLe3t
         yjJhJZXxPtTBbSoqbIaZzhiObA8MN8JZHD/wWR/gzPVI5Yc7WvQ32i1WliDsL8cdhB+h
         QZJodEs6UVCFRu7KbcX8h8e2zsOnxbItv5IXGc/JP4ZEbRADi7fYsQO/Uv4Xf1cTvDUJ
         IebA==
X-Gm-Message-State: AOJu0YxZmaGZQtqQ7sy6YRHbAf/j5EIcoJNOVprkoBTNaUqdP8mUOnXb
        ARzeV4/09o6ofIffJQlbkhUTmrwHvRP7EvKsLYzWT6g5
X-Google-Smtp-Source: AGHT+IFxEnNDEw/jONckUh9M4AifHB/zBR3wLZacSiL7D29j4hF/GQVlLgJbRT0kb6Rs+sVNJkRLcw==
X-Received: by 2002:a17:906:844a:b0:9a2:225a:8d01 with SMTP id e10-20020a170906844a00b009a2225a8d01mr2686503ejy.7.1694814666290;
        Fri, 15 Sep 2023 14:51:06 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709066c9600b00993a9a951fasm2955715ejr.11.2023.09.15.14.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 14:51:05 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c3c8adb27so331997366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:51:05 -0700 (PDT)
X-Received: by 2002:a17:906:3146:b0:9a1:cbe4:d033 with SMTP id
 e6-20020a170906314600b009a1cbe4d033mr2412770eje.53.1694814665221; Fri, 15 Sep
 2023 14:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net> <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
In-Reply-To: <20230915213231.GB23174@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 14:50:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
Message-ID: <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
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

On Fri, 15 Sept 2023 at 14:32, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> It also got me thinking about named_guard() for the myriad of
> conditional locks we have.
>
>         named_guard(try_mutex, foo_guard)(&foo->lock);
>         if (foo_guard) {
>                 // we got the lock, do our thing
>         }

Hmm. It looks ugly to me. I really hate the "named_guard" thing. One
of the reasons I liked the guard/scoped_guard() macros was because how
it created _anonymous_ guards, and made it completely unnecessary to
make up a pointless name.

If trylock ends up being a common pattern, I think we should strive to
make it a lot easier to use.

Can we make it act like "scoped_guard()", except the lock function is
fundamentally conditional?

Call it "cond_guard()", and make the syntax otherwise be the same as
"scoped_guard()", iow, using a unique ID for the guard name.

So

        cond_guard(try_mutex)(&foo->lock) {
                .. this is the "we got the lock" region ..
        }

would I think be a much better syntax.

Could we live with that?

               Linus
