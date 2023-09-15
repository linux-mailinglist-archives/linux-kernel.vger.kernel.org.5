Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75BF7A295B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjIOV0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjIOV0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:26:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849DC101
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:26:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bfbd7d49e7so42093721fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694813166; x=1695417966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yePpIdQ7WZGAqEgEwzbub2QYZTvPnhatZu9Hi1ymeRU=;
        b=VE5g7ClR/ct5me5mLRm/Qdgli8EsMioaKNBE4BPIcOpeIUSYtgiRD4IoZ9pq2EIkDV
         5BQKSRh82Cnr4P1FSFK5DX2aU2Cmgme+32pcwfo/bE2xaQlsQZp3c6U+la3HsUvZuXva
         N0/uQdnNqVIC53U6F1NynDd4GPEsSk9kaV8qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694813166; x=1695417966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yePpIdQ7WZGAqEgEwzbub2QYZTvPnhatZu9Hi1ymeRU=;
        b=kQZaSg3D0/gLNNmnXt8cI/hV3d5qQGc8eO0yohgumKjd1zpXljqVh+QDOoLc7mAnSy
         KmCOHuMjAPjqhsOg/4EQjuCSt9ohqengQbkIBzMGZgZExoZ/GpYhGMvtpY4CM8LONsVn
         MjFaoWFnDvN8YX4wUox5xsVhBMW8aWMhHpM84LzDfxCvQs6wCaGKW8bz1gS7A/ST2tID
         aizv+PwYAKFxcx/N53WD2jB5B/9PM/GdQ0SAVmkxpw8iH5mKE0ZMnhV+EGWShZY0mj/o
         O81BAIfNuzj0nMBwxaRrOkMXolD/MBfsCyBdyy/UYmBAbBUGKR0833CB0z7TKKuruRWI
         rB3w==
X-Gm-Message-State: AOJu0YwVcTBfqTPFBrSuW9yt63GOOBtk4rTi2Hruz1gXmQp3l3v8HBqf
        T0mkS7Le3MlA5bzeYhq8USSyPhuFez/9yjYnR/+ZfBAj
X-Google-Smtp-Source: AGHT+IGuYrmo4NgEqirNDEJGV2aS0sIpfoa6NNog0az2GM00lBf0iunirxCdUHIBuqEau1MQnMXeaA==
X-Received: by 2002:a2e:a0cb:0:b0:2bc:b6b0:1c4d with SMTP id f11-20020a2ea0cb000000b002bcb6b01c4dmr2521123ljm.10.1694813166705;
        Fri, 15 Sep 2023 14:26:06 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709060acf00b0098d2d219649sm2918391ejf.174.2023.09.15.14.26.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 14:26:05 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso3063130a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:26:05 -0700 (PDT)
X-Received: by 2002:aa7:d416:0:b0:525:7d81:71ee with SMTP id
 z22-20020aa7d416000000b005257d8171eemr2220876edq.15.1694813165215; Fri, 15
 Sep 2023 14:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net> <20230915211815.GA34041@noisy.programming.kicks-ass.net>
In-Reply-To: <20230915211815.GA34041@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 14:25:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix3KGMBAR52LexxvJA4b6aSbsh8b60JFXig2Rdvp_2qQ@mail.gmail.com>
Message-ID: <CAHk-=wix3KGMBAR52LexxvJA4b6aSbsh8b60JFXig2Rdvp_2qQ@mail.gmail.com>
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

On Fri, 15 Sept 2023 at 14:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hmm, perhaps I can do a class for it and write the thing like:

.. crossed emails.

Yes.

Except I think a full-fledged class thing is overkill for a one-time
use, and I think you really could just write it out as plain "this is
the constructor, this is the cleanup".

Yes, yes, that is obviously what our CLASS() thing *is*, but at least
my personal mental model is that a "class" is for when you really
export it to other uses.

If you just have a one-off, you don't need the class abstraction to
export to anybody else.  You just do a one-off "alloc like this, free
like this".

Again, this I think is really just a "mental model" rather than any hard rule.

               Linus
