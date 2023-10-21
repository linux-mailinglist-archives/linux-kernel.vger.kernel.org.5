Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672B97D1F43
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjJUUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjJUUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:02:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C025D41
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:02:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9becde9ea7bso650399066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697918555; x=1698523355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUr0abvZCLa5ZjROveiZrf82Tea/s9MUxEcODZD/52U=;
        b=YvF2c2bCGrfnmQObIwdXtSIQWXdbVI6b7Q7UHBj9ibEYhI6Ldmt195DSB+laNO8qmC
         CpTajhZ/oHVz0XJwx3/J64ELf1zHYlsO52zrSGrqQTVOxz7tRLv1F1dch7RuksUv6vui
         4feQOKRHbEQ33Y4AfhyZ8Em0GiSjJN1L3bH4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697918555; x=1698523355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUr0abvZCLa5ZjROveiZrf82Tea/s9MUxEcODZD/52U=;
        b=husihx0stt7rUTCzMQUe+B1QqYzwURPMpbkNFIqKR5ubQU3xEeN+sT9o7HBeVAcKKE
         BfcsnPTLqy4hIkz8vW812fkqGOeG75heRLW06+EOSHCWlelCZJR3dK+cEc8qUF6145n9
         kdYtuZ+qFf9TX9QZiWCl8nkJCdt5i9xEiOkj8DAAwqonu1GBS4rbY4r0Tbe0n7czb7so
         gDM2077FgZ/ddTpADRECtat3LCU0APewOXeZwFJ6LAnflpMCyaRdVbDIK3fu5yS/eD5m
         jrXg3HjYFbt1XkHJKZUs2fhx5K1kqxi4wILfvNMTqF+YONswYME3TZlIZyHrlXZ7dpa6
         bSNQ==
X-Gm-Message-State: AOJu0YyzAil2VeLdQHXb4iqyDJ0Fq3ZhnL7FWu/XfVBQJbVNH5z5Jqcp
        2NAOLCPpspDTtqSs3pr2S15QYwWINVBDravP3HcDF+XS
X-Google-Smtp-Source: AGHT+IEJoG6stDdU2kVxK84sYhHkEv5L9KDACrpxAGCLllZH9iPZYf5xJtqpT6ZA9AT3PiBK54NhpQ==
X-Received: by 2002:a17:906:c10c:b0:9b6:3be9:a8f with SMTP id do12-20020a170906c10c00b009b63be90a8fmr4454165ejc.20.1697918555020;
        Sat, 21 Oct 2023 13:02:35 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709060e4100b009b64987e1absm4040887eji.139.2023.10.21.13.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 13:02:33 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso4179667a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:02:33 -0700 (PDT)
X-Received: by 2002:a05:6402:214e:b0:53e:1207:5b69 with SMTP id
 bq14-20020a056402214e00b0053e12075b69mr7077779edb.10.1697918553480; Sat, 21
 Oct 2023 13:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231021183925.22831-1-brgl@bgdev.pl>
In-Reply-To: <20231021183925.22831-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Oct 2023 13:02:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOJO8nfcDeUMwYXPQHLtTnngSDd4ieUWegW1Aru8TbnQ@mail.gmail.com>
Message-ID: <CAHk-=wiOJO8nfcDeUMwYXPQHLtTnngSDd4ieUWegW1Aru8TbnQ@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc7
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Sat, 21 Oct 2023 at 11:39, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>  drivers/gpio/gpio-vf610.c   | 15 ++++++++-------
>  drivers/gpio/gpiolib-acpi.c |  1 +
>  2 files changed, 9 insertions(+), 7 deletions(-)

I have no idea how you get that diffstat.

             Linus
