Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AB7826B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjHUKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHUKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:00:44 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD42A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:00:42 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-48d0239cb67so534829e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692612042; x=1693216842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t3uCIPsl1iINeIMvwEyX0kxSd+RFCfqpS5u/vlUKTQ=;
        b=t55VeJ/+tl1wh7B287pa9FXc2OHka2rWMvVFuHyILMs5Ik9VUahnTgvzKclhS296T9
         o0xAZMLlirNMP2KYgrle9qm55MBnaGzIC9J3d1h4EYBCVndHGQS62ImhjotXvacA66sl
         sjsECUvm6tTadybO5nFVTiUwrercN8FREu0gh/j+6gSoQqZIN7GyknXUzyaufqVP1QLs
         5rzhRGqLXXJxSRdndWR4RsVedTeStu8N9kXOLK3mSpZTzNrX1YWeBfKI0yTs1rZpy0ZF
         PDb1bSwuPKO0E6TA+36ZFLGwaiFeAkTLsHfG6/DbxBfQvurr8GeUCikU4n5Sd18x8Y/3
         PKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612042; x=1693216842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t3uCIPsl1iINeIMvwEyX0kxSd+RFCfqpS5u/vlUKTQ=;
        b=bc79ucmt4E6E4oTemjBtFtE4ifIDQ39XsQ/4o66zMRbfTi8LghE5kcznG8ORxfi9E0
         WCdvBiIWmWcWlZFWp1dZPsPjdBO3kUasXryoJ492tTVaeGgZZoj036btq4CfBdCBic4t
         /HcA9SK8d5j/FsV+iOLkimNntQkAwtBxDfqsIcKtLZMeYwepSIW7V+50M6BEs2MG7xDQ
         bmSTt+M/+2mU3UguNeqSVZrChElNpHxEFBNi4jmtKBzKq6ZDHlS04v/vYxOEzx9dyxx8
         iQJ71ZFsWsAHrhBSLjslLZZQQ6riA28egcqonmUfdDZtKmUOEh0ueEV7OiN7MD4FPL57
         tnqQ==
X-Gm-Message-State: AOJu0Yyn+2+OR4kJyMfFC39jNwCYVuX1wEENQlIdyF5Pj5jApcciyoAO
        UqLPu5i5J5TJdT1Srtiu0RgJ6osIxnMWfBMVK1nCdg==
X-Google-Smtp-Source: AGHT+IGYXmGhN/DODmuPopOeFVUxe6RUYwsmZ0blG+xptOBAK7cMQAC1nDdxg7BVHqE47I4Q0NOl9ooyPHIcPtYcS48=
X-Received: by 2002:a05:6122:98c:b0:48d:b7c:56c8 with SMTP id
 g12-20020a056122098c00b0048d0b7c56c8mr3877386vkd.0.1692612041871; Mon, 21 Aug
 2023 03:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230818190108.22031-1-brgl@bgdev.pl> <ZOMxue7lvHFWMCCb@smile.fi.intel.com>
In-Reply-To: <ZOMxue7lvHFWMCCb@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 12:00:30 +0200
Message-ID: <CAMRc=Mci-HjN8-Gta7G604grUCzDKmOYDxJ1PJU=x=AmfHohKA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: tie module references to GPIO devices, not
 requested descs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:43=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 18, 2023 at 09:01:08PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > After a deeper look at commit 3386fb86ecde ("gpiolib: fix reference
> > leaks when removing GPIO chips still in use") I'm now convinced that
> > gpiolib gets module reference counting wrong.
> >
> > As we only take the reference to the owner module when a descriptor is
> > requested and put it when it's freed, we can easily trigger a crash by
> > removing a module which registered a driver bound to a GPIO chip which
> > is unused as nothing prevents us from doing so.
> >
> > For correct behavior, we should take the reference to the module when
> > we're creating a GPIO device and only put it when that device is
> > released as it's at this point that we can safely remove the module's
> > code from memory.
>
> Two cases to consider:
> 1) legacy gpio_*() APIs, do they suppose to create a GPIO device?

Legacy uses descriptors under the hood so there must be a GPIO device.

> 2) IRQ request without GPIO being requested, is it the case?

I need to double-check and also test this but it seems to me that
right now if you do this (request an irq from a GPIO irqchip), the
reference count of the module will not be increased. With this change
it will have already been at 1 until the GPIO device backing this irq
will go down. So it should actually fix another use-after-free bug.
But don't take my word for it, I will test it later when I have the
time.

There's another issue that will become visible with this patch -
namely the modules that register devices from their init functions,
will no longer allow unloading until the device is unbound first. This
is not wrong wrong as module's init is not the place to register
devices, platform or otherwise but I'm wondering if it counts as
breaking someone's setup?

Bart

>
> Seems to me that the 1) is the case, while 2) is not.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
