Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDE7A8DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjITUc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjITUc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:32:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78268AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:32:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50300141a64so545058e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695241968; x=1695846768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5A++2mX03Hcr44T/e+yZZvTQBTnG7Z4Hfb7UlqgoOko=;
        b=Q+tf13eEfIK1ZDdhriHkszIP/K2CAz1MGYtZesaema1BQCiiQlDmVFZO9+5ySWB3e0
         mmUUl73ocIhPGPe/lWKCxhg+jcmHeQBATIxNp02HRRIWF+00233zX17fDmTpC6eMi9W9
         ZK5Xt3a4wIqNSpC8IZhW0ZkG3PbRWPLwe0OYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241968; x=1695846768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A++2mX03Hcr44T/e+yZZvTQBTnG7Z4Hfb7UlqgoOko=;
        b=NohhNqfUYew0eJp+ljqYCYON3on5keTKzfAm9tw6cIwx/tyvQFXaz0ViPYBDjpqgWP
         ycZFe9WteJDzLtKBLzfJGT8U92Vd136xdda2a69qmtX9NbtVpCqA2gRdkG2lVTPp5TCO
         ZpohznqRkhdOVIXeT3cOQOBFKiGuNJm5ev/Cy2FwlzKg6JUY5GlDVDiU4ujFyd8088bz
         fJVPuUQ4A8n9yRUND7whMuA6Dik4Usnymd+RErupo1xzbaji3aRIckbZaFs9jFYWHkTf
         XQgkvgd6Vu4bvVb5qpBItucuaGomQcSKGBc3FlQ1MuLATWrZ/xn5qIlrJyn14ANuZURX
         0/Sw==
X-Gm-Message-State: AOJu0YzkuqergElqgqIREl0U0Tdd3/IhARe7gUpaNRMn/w58BBatvNdY
        qWzJkgURgBvRU3ia8Vkb1QhqAcPxQFpjaoG2rmdRWG0e
X-Google-Smtp-Source: AGHT+IE1MKRPcyoR5fpwxdieos9/a+a3gj4ecj3SqWCyqyhSYeiBrqsUv/UYExGwjdGiuaXvB06Zgg==
X-Received: by 2002:a05:6512:3150:b0:503:38fe:4598 with SMTP id s16-20020a056512315000b0050338fe4598mr3065758lfi.64.1695241968384;
        Wed, 20 Sep 2023 13:32:48 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p5-20020a056512328500b004fe0fead9e2sm2100426lfe.165.2023.09.20.13.32.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:32:47 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-501eec0a373so503795e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:32:47 -0700 (PDT)
X-Received: by 2002:a05:6512:39ca:b0:503:7c0:ae96 with SMTP id
 k10-20020a05651239ca00b0050307c0ae96mr4520271lfu.20.1695241967063; Wed, 20
 Sep 2023 13:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230920060615.GA2739@sol.localdomain> <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain> <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
 <20230920202126.GC914@sol.localdomain>
In-Reply-To: <20230920202126.GC914@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 13:32:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
Message-ID: <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
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

On Wed, 20 Sept 2023 at 13:21, Eric Biggers <ebiggers@kernel.org> wrote:
>
> It seems that what you're claiming (in addition to the RNG always being
> initialized quickly on platforms that are "relevant", whatever that means) is
> that once the RNG is "initialized", there's no need to reseed it anymore.

No. You are literally putting words in my mouth that I at no point
even implied. You're making up an argument.

I *LITERALLY* am asking a very simple question: WHO DO YOU EVEN CARE
ABOUT THIS "IMMEDIATE" EFFECT.

Give me a real reason. Give me *any* reason.

Don't try to turn this into some other discussion. I'm asking WHY DOES
ANY OF THIS MATTER?

The immediacy has changed several times, as you yourself lined up. And
as far as I can tell, none of this matter in the least.

> The question is, given that, shouldn't the RNG also reseed right
> away when userspace explicitly adds something to it

I don't see that there is any "given" at all.

We do re-seed regularly. I'm not arguing against that.

I'm literally arguing against applying random changes without giving
any actual reason for them.

Which is why I'm asking "why do you care"? Give em a *reason*. Why
would a user space write matter at all?

It was why I also asked about entropy. Because *if* you argue that the
user-space write contains entropy, then that would be a reason.

You didn't.

You argue that the current behavior hasn't been the universal behavior. I agree.

But considering that we've switched behaviors apparently at least
three times, and at no point did it make any difference, my argument
is really that without a *REASON*, why would we switch behavior *four*
times?

Is it just "four changes is better than three"?

             Linus
