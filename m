Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73C7D728A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJYRoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjJYRn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:43:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCC138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:43:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso94985891fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698255834; x=1698860634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KvqI5bmHaI6r/r4Bh4STYH/OzlrCkqHPpu4GTwS1+V8=;
        b=OXVx2Du9VeuoBLpGr8hGnI+yHnRo1H15KqUJ3t0u1Ue2uobLcr44mIAhhwOdukrrrg
         LVs3YoANZB2J4V0WXYID/6sxWRXiWImDWi3qU571wz0aHCOc2gDHgUbT8qMt/hwt8eZ9
         8Bj7iWgbk7Icylx7RVQGOYetMVl+Wy3zZV5ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255834; x=1698860634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvqI5bmHaI6r/r4Bh4STYH/OzlrCkqHPpu4GTwS1+V8=;
        b=HMUVeiWBwfFvPl/IO5nC4jTfxcsuEpKbtpAhTnO2xqiph2pxdyulP3fywe5OKXzrRC
         +uyojykCvbhW6Vy8Dwg2Gc1lwB8M745XIXzdJcYWr0H/I7d9YrL5fD170oWod9Uv7fxA
         rr88vAQ4tYVWpsIOx1Vl2Po0nYwI1SZ4TTJs+tEgXHVxQnSplqvhEONJXIIOgLcBZwfZ
         3lW/HDf3dhRoTWTBknACFnTzUYhIFUakICIWbWnE6Q698aRt/hOLsYEyZ1OqRCoRFgjF
         MWuvNOttzQaPgJPzOEUCQC2h5A/WuDGLw0/4xaLaaPlvU5qUEsdwMSLDb+h2Y/Xf3GPu
         JoCw==
X-Gm-Message-State: AOJu0YyZ2l1mgymgiL1cICQpdrOSgKZaFHxbuRV+473qTsmcevz04xkq
        7EeYBMburZ4P7wlj9EU+9hCTP0K2ScEztJ3gTd0jwyOx
X-Google-Smtp-Source: AGHT+IEWq3w7jOxHvRk+lh0ZbMEEOREJnycjZQAQiBrWktTNVEII5JzqbzaeNZMb9gz1iOgpYSDWPQ==
X-Received: by 2002:ac2:43cc:0:b0:503:38fe:4590 with SMTP id u12-20020ac243cc000000b0050338fe4590mr10160671lfl.60.1698255834099;
        Wed, 25 Oct 2023 10:43:54 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x15-20020a19e00f000000b0050467be30ccsm2659961lfg.89.2023.10.25.10.43.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 10:43:52 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50802148be9so3615735e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:43:52 -0700 (PDT)
X-Received: by 2002:ac2:52aa:0:b0:505:6fcd:d7bf with SMTP id
 r10-20020ac252aa000000b005056fcdd7bfmr10111613lfm.19.1698255831687; Wed, 25
 Oct 2023 10:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com> <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com> <your-ad-here.call-01698246313-ext-3263@work.hours>
In-Reply-To: <your-ad-here.call-01698246313-ext-3263@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Oct 2023 07:43:34 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgs2DDdckcONG+YbB-GDH2QFCoZJ=Vm+YXxb1moZzuDgQ@mail.gmail.com>
Message-ID: <CAHk-=wgs2DDdckcONG+YbB-GDH2QFCoZJ=Vm+YXxb1moZzuDgQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
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

On Wed, 25 Oct 2023 at 05:05, Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> You probably want
>
>  #define __div_round_up(n,d) _Generic((n)+(d),          \
>         unsigned long long: __div_round_up_ull,         \
>         long long: __div_round_up_ll,                   \
>         unsigned long: __div_round_up_ul,               \
>         long: __div_round_up_l,                         \
>         unsigned int: __div_round_up_u,                 \
>         int: __div_round_up_i)(n,d)
>
> to avoid early type-checking for expressions that will be discarded
> and prevent errors like:

Ack. I noticed that later when I tried to do a bigger config build -
the compiler would warn about the implicit truncation of the integer
arguments (for the cases where they weren't used).

> Plus typos fixes below passes allyesconfig for s390, 32-bit x86 and arm.

Lovely.

It would have been even better if somebody told me that I was stupid
and there was some nice trick to it, but at least the _Generic()
approach doesn't seem broken - just a few tweaks needed.

               Linus
