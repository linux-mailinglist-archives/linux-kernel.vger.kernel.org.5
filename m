Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08D87A2A40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbjIOWLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjIOWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:11:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5041FD7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:11:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so3099549a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694815873; x=1695420673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzSWhVtYsIPnekLep1Vu6G/lb1VGtq/P5+5k7BGz5R8=;
        b=bk4JZ3gRoBvhm+9zchkoW6J24LihPOu1cqsd+qAZPjxlsdtEk/99qyc5MJmssIrjjj
         SuZ76DwlG6gKJYNfN7ZMybOFZSTwfkXPhUkDHeCQ6USP2JSjIVnvZSVvZw9Ke/EFmyxn
         jKYA/A9VOtAidDw5XnVWgkVP7j3XniYsPWANU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694815873; x=1695420673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzSWhVtYsIPnekLep1Vu6G/lb1VGtq/P5+5k7BGz5R8=;
        b=MCg+65BN6zFzgbkiawA6uWzHjVDz6K8IWzpnyfZWhaUlvsvbk5zN5b1y0BWStCXkzS
         M0Vitrcs5uX+15mQDHvIjzBgOzlQk06QD7mhUScySoZ4ffnM+gLBk+aseobQR2gDYRnA
         IY/VZBPmYBeLJmDXntvm7y31hGb3HbnJCjUeihJsyDZagCs2kO2YH70fNaZdIDz8nzDN
         gXYF3hlBoxGzoGP118+knHzd+oyXx+wQO1XOYQWpvzwGMLYPBYhSKykcpKxZx31EYmS5
         w/anVPtWt5cgJwZJCcv7jfJMQCJGa9wu4d5NK5hGh4YyCZSQWqQdmiBiFfEAPNT5Yvhf
         QoOQ==
X-Gm-Message-State: AOJu0Yy5q9UNKOSpT38Lg30AEGlzmiomZZZ+m2LsD0q4K4hSafAEryiB
        8Z8/ur7WzAlvac8o8pmVJoebSkYZJ9+W1ddqP5o1tKUr
X-Google-Smtp-Source: AGHT+IGjrWIzyDha6vgO171kSsW5/ItGx2AL3VTZXtU43fqd2jMUbzu6oyoxQfDZyvgVEQxVeEjEEQ==
X-Received: by 2002:a17:906:3d29:b0:9a1:c42e:5e5e with SMTP id l9-20020a1709063d2900b009a1c42e5e5emr2311881ejf.42.1694815872904;
        Fri, 15 Sep 2023 15:11:12 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b0099bd7b26639sm2957164ejb.6.2023.09.15.15.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 15:11:12 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso25156445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:11:12 -0700 (PDT)
X-Received: by 2002:a5d:5a97:0:b0:31f:fa1d:898 with SMTP id
 bp23-20020a5d5a97000000b0031ffa1d0898mr1900059wrb.47.1694815871830; Fri, 15
 Sep 2023 15:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net> <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net> <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 15:10:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiq_0O+KT0x8OL5_rV2FkvxHNOWNxU=HKknmDGXin_r_w@mail.gmail.com>
Message-ID: <CAHk-=wiq_0O+KT0x8OL5_rV2FkvxHNOWNxU=HKknmDGXin_r_w@mail.gmail.com>
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

On Fri, 15 Sept 2023 at 14:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Call it "cond_guard()", and make the syntax otherwise be the same as
> "scoped_guard()", iow, using a unique ID for the guard name.

I *think* you don't even need a new "cond_guard()" macro.

This might be as simple as having our current scoped_guard() macro
have the conditional

  "scope.lock && !done"

instead of just the current "!done".

Then you introduce "trylock" variants that conditionally set "lock = 1".

I dunno. Maybe there's something really obvious I'm missing, but I
really think that gives us the option to literally do just

        scoped_guard(try_mutex, ..somelock..) {
                ...
        }

and all it requires is for us to declare a "try_mutex" lock guard class.

Ok, so the current DEFINE_LOCK_GUARD_x() macros clearly set .lock to 1
unconditionally, so there's a small matter of extending the lock side
to be conditional...

"SMOP".

                 Linus
