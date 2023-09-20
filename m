Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE87A81F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjITMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjITMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:52:04 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782FE0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:51:57 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45290cda80aso684753137.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695214316; x=1695819116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnQhFZ0YHcf11/hXVMOAl/6rPiXEQ3EoWGpvXe1OYp8=;
        b=XJhSV3ix5WGa2tGIXkEfMYOFoqYWnIGYwKpZzXqI6MP82Yvsjyod6DFaV/xZfwBg9H
         53nFpaGjIj0WIn0gtSe9/HnJpDd0uF5WsT7M5wDhkR3Bjx2eDkgccnDfBKIu0+wunq18
         gQ8SMP+38l+GK8mE1wVDT3xGmZfkHgBckIGbBhJXVWSGwhkzmeL0g2wrLEeCOa4wsk7E
         0L7OeCnAzXiQXBAQkyMCoqUaUsQW9vAWqlzEA5PBvgPW6m/B+NGmzQyXW0VO5szk4wf5
         o0e7HLNvK6mJgqtHocsPrI0Sos2gEB6n3TyJzro14pJJA9WloESegKnMkUKBO6HRLV1f
         XKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214316; x=1695819116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NnQhFZ0YHcf11/hXVMOAl/6rPiXEQ3EoWGpvXe1OYp8=;
        b=Tdt4OWFEIIlMaCyvJXCGvk1RR6DEF+tSQ2/ESTNPGwKOGHxDv0+Ezz5NTk5AT2rxQT
         XQrha+jThWm6O8CYvWi/A3z+1JaVgpSbWFkFxb1NGLa301WVoNo9GotIZLRA+lw3dl9X
         iFDGAC5CQuxd0U3xuHKnch4lvyYpN9D/RgY3HvD0PUtyox3WAqVIel37xNx1Mo0KRG/+
         xCexYNDT3XcGyn4SCPCG3HvlvJiHslTqc6H+xmkwDqJo04zi+aOxGCDy76RC3yma170F
         gyNdyFQBpkP/0a31R8cpvfDmVNGttxMRa6Vo8A+9hn49Utg9dFaXJwyOwNUsigdiXOSH
         K7WQ==
X-Gm-Message-State: AOJu0Yxwuam+B80oXGWpBHSE2JFk8OfOi2EirZHBA9Ddvq9vDsxOc92I
        Hzgat2nHArFuFlcyRamq91Wah5jDel6A1bEHBEOpXA==
X-Google-Smtp-Source: AGHT+IE46lqafrmo+DdRxsxbz8d7zwbqGdxgFag3PP2FoPQ7myi4WRJcklh67pav8VUtyxe9rqokP4mAa7mWMYwQ/j4=
X-Received: by 2002:a05:6102:34d5:b0:44d:3d29:4940 with SMTP id
 a21-20020a05610234d500b0044d3d294940mr1520097vst.35.1695214316607; Wed, 20
 Sep 2023 05:51:56 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Sep 2023 05:51:56 -0700
From:   Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <CACRpkdYNA1rkG5wJ0+rAT9g4EyzfbN5VP2a9vuMMk_RD6bMLFA@mail.gmail.com>
MIME-Version: 1.0
References: <20230920085639.152441-1-brgl@bgdev.pl> <CACRpkdYtbGqmMqN7FNhjYJGG+e0jWQmozf9kpNHiUBJvd2c=7Q@mail.gmail.com>
 <CAMRc=McrXEQbwcsK3yrfROujezjMd1L4EcJj7GNTCE5L6zD1gw@mail.gmail.com> <CACRpkdYNA1rkG5wJ0+rAT9g4EyzfbN5VP2a9vuMMk_RD6bMLFA@mail.gmail.com>
Date:   Wed, 20 Sep 2023 05:51:56 -0700
Message-ID: <CAMRc=MeaAG5w_JzgSNs-EC5HY=2izC4W1FHZ54trEW_PvA8Yfg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: extend the critical sections of lookup tables
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 12:58:58 +0200, Linus Walleij
<linus.walleij@linaro.org> said:
> On Wed, Sep 20, 2023 at 11:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
>> On Wed, 20 Sep 2023 11:12:58 +0200, Linus Walleij
>> <linus.walleij@linaro.org> said:
>> > On Wed, Sep 20, 2023 at 10:56=E2=80=AFAM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
>
>> > Can we rename this function gpiod_find_lookup_table_locked()
>> > as per precedents in the kernel, to indicate that it needs to be
>> > called with a lock held?
>> >
>>
>> I think you mean gpiod_find_lookup_table_unlocked() as with this change =
it
>> will no longer take the lock?
>
> I think the pattern is the one I indicated: *_locked() means the function
> is to be called with the appropriate lock held, cf
> arch/arm64/kvm/hyp/nvhe/mm.c
>
> pkvm_create_mappings() takes a lock and then calls
> pkvm_create_mappings_locked() which even asserts that
> the lock is held.
>

Ha! I always though the pattern is to call the functions that *DON'T* take
the lock _unlocked(). This is what I used in gpiolib-cdev.c or gpio-sim.c.

I guess both conventions make sense in some way.

Bart
