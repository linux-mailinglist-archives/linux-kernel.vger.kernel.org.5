Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76B7A8D07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjITTnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjITTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:43:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B099E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:43:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40479f8325fso2035835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695238992; x=1695843792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=piPcn5jP84Mk94uBsWZooyBKmFjEME+EXsVwt6XYvDs=;
        b=ZtJa7m2J/ldGdabNdtcRaSb6em6ywDNYiNo2JFffeuMsXmV5pslFiH/wIzqqR4AY1a
         cXo8TtylSEXLnfftt1soRjlgew6lJVAjurpqgQ0vZfftehkAKoCgcVbyKuZVyvVgHhLY
         UGDnvvLTyPeuarDdiBOt5obScW27eldYOEWTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238992; x=1695843792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piPcn5jP84Mk94uBsWZooyBKmFjEME+EXsVwt6XYvDs=;
        b=k5YkrdiK06yl/Vo0jDgjOXlVfEJCW1HR/MQG7JQBo35ZX6nC3yv49lbw1JaMhiWQaX
         2Z5zS24CnXULn689rb8wLpJlNs5N2TRPgteI2T/n9Zbn7QPr98XXXDk5VzSkn/8CHz7x
         lbaLX3nqR9ch71467cUxIXPYFfqwi78US6IkLITjarSmsCZUb+D5wJcn3LkNLxGPBrgx
         AqU3ADhVYlMP6D/rHwthLyU3QZlor/g1rxI+KjhALq8MNjM/IvVSCcb35knSuhtMq16e
         +dwrQ4YMYO0c3R5dnttpHWvhNZ+WYgDeoUeZkC26c2Pc92v4DCP929o68axi9ByLFDnO
         Mzlw==
X-Gm-Message-State: AOJu0YznI9Mko5DFUrr+SFCSlxAcaxYZXOHqE6VjrsXz7I7BBSQkzYJa
        UM9lLGPyTUK9w++hqQot8bE32nhGBV+wl4E3aiPUrnaN
X-Google-Smtp-Source: AGHT+IE2a3Fu9RLvGs58MkDlLVx8kcLNimwuSEZhD/+13efS5lRK+r4WyMf3Z8uc8SlFGfIwrszAmQ==
X-Received: by 2002:a5d:6991:0:b0:321:5e13:3829 with SMTP id g17-20020a5d6991000000b003215e133829mr3151531wru.1.1695238992488;
        Wed, 20 Sep 2023 12:43:12 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090671ca00b00999bb1e01dfsm9746441ejk.52.2023.09.20.12.43.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 12:43:11 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so126044a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:43:11 -0700 (PDT)
X-Received: by 2002:a05:6402:184e:b0:523:3fff:5ce2 with SMTP id
 v14-20020a056402184e00b005233fff5ce2mr3044193edy.41.1695238991470; Wed, 20
 Sep 2023 12:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230920060615.GA2739@sol.localdomain> <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain>
In-Reply-To: <20230920193203.GA914@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 12:42:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
Message-ID: <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
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

On Wed, 20 Sept 2023 at 12:32, Eric Biggers <ebiggers@kernel.org> wrote:
>
> >
> > Also, are there any relevant architectures where
> > "try_to_generate_entropy()" doesn't work? IOW, why do you even care?
> >
>
> There are, as shown by the fact that the full unification of /dev/urandom and
> /dev/random failed yet again.

No, no. That only showed that such architectures exist. It didn't show
that any *relevant* architectures exist.

The ones reported on were 32-bit arm, m68k, microblaze, sparc32,
xtensa.. Maybe others.

> But similarly, that's unrelated.

They are related in the sense fo "why do you actually *care*?"

Because I don't see why any of this actually matters.

               Linus
