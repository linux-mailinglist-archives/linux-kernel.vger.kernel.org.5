Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2429078CA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjH2ROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbjH2ROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:14:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634DCDC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:13:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977e0fbd742so598428566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693329218; x=1693934018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/strmF9ozBLaK9gIhpGDpKRH8crNC81h2H/fp7mNSI=;
        b=H0JWVDk2/D+JfeNGlc/04n+v/cpaJGri9YHvWfZdyYrSpJ7PywS/wRQd9mb7jePhP5
         lB49vgeSu3HC/Y809JflFxI8rSr5OCC4jDKpAidt75qLLoLZxzV0iQBJkXskWgGWzSul
         iaaTTmlVR9D6HiOR//APNlMs/s+b9VUQCheQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329218; x=1693934018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/strmF9ozBLaK9gIhpGDpKRH8crNC81h2H/fp7mNSI=;
        b=ExF+YwZBH4rXORdqqw6bkxelB4AxAHTsnMa/vUxdbTqdNIak067QIpLRDUdC+HQs6O
         V7WCTfl5rK0ZR/MuUrvNU7uCFyMBsuOiwoRxDBnr2qGI5WOUGr6m9jg5vFvHAGVTZ5DN
         dSHnYaAfdYRpbepQ6Vxnmed+E/+hse1fTRVXzF+vUpeppbKTy23eJtp8tQG/PfK5jope
         tmaEs8fq0wSl0VblV+JuV3WcxXkrBSHho/pU0u0pb86E2b+NPeejIoHQc1p+InxUFFCM
         cPPwWWoIMIXrbl7Tz0p5qtDQ2xDrZMZS0vwkjnrrvwwcFhB+9/1RYiK8+z5XPinyuWYc
         0wlw==
X-Gm-Message-State: AOJu0YyAUo5FnyoVeuF1uN6CgjVV0W3odOLohj44ADmOK0JLJY440Lzo
        G8leGvpZmr1xr0nkFLOiuC3enDYHYEaeiclABDcAqIJx
X-Google-Smtp-Source: AGHT+IFD15tRv0zc1PPZiLFYvhG+3kbv0wsp6iX8H5GyDrB6zUi8iA47cGgl+ip26Qp7PsAqXScs1Q==
X-Received: by 2002:a17:906:7391:b0:9a1:c659:7c62 with SMTP id f17-20020a170906739100b009a1c6597c62mr14677169ejl.66.1693329218670;
        Tue, 29 Aug 2023 10:13:38 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906379300b009a1082f423esm6089948ejc.88.2023.08.29.10.13.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:13:37 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98377c5d53eso601782066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:13:37 -0700 (PDT)
X-Received: by 2002:a17:907:b11:b0:9a4:88af:b77 with SMTP id
 h17-20020a1709070b1100b009a488af0b77mr9102528ejl.60.1693329216897; Tue, 29
 Aug 2023 10:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org> <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook>
In-Reply-To: <202308282035.5AFD431B@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 10:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
Message-ID: <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 20:44, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Aug 28, 2023 at 06:44:02PM -0700, Linus Torvalds wrote:
> > The only thing that is new is the kernel pstore implementation. Why
> > was this not a problem before? The warning existed back then too, but
> > I never actually got it.
>
> Right -- if the compression method from before was different, it'll fail
> now. (i.e. we removed everything but zlib.)

I don't think that was the case.

Looking back in my logs, I see lines like this:

  Aug 07 16:59:29 ryzen kernel: pstore: Using crash dump compression: deflate

and while it appears F37 used to support other formats, it does have

  CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y

so it should all be zlib-compatible from what I can tell.

                  Linus
