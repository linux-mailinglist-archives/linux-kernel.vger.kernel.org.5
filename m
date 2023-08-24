Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B504F786AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjHXIs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbjHXIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:48:08 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FADD1BD3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:47:42 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48d0db157efso1632306e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692866844; x=1693471644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKFe3JKt8mM9KQ1OqvkD5l+gTIC1h1Sk/GZ+WD4chOg=;
        b=u+xxknb4OpTlg8CE6woneIkAypl9bDQxY/Z3rahcb70uoUD+ziFNDBcTfrD2Zaw97a
         ndW6mjFjxqq8BuDJRyf5iOGt86R0vt05RvSK5xmKeIcZhtfXSMgkXm1USFjh7oBIZoiq
         EnwvQbnu8aeY3+YXXy5YryTVL7FdoXnl9uBVm5AXYDEdrcxn+6wBL4+ogA707RBqu9v5
         z2NHR+aGcEaan0ogYJzimFtwX05UsMr2B4y/Ge0x1PHoxeu4dqTDwZ8Go+8jx6EfgMSd
         Uo142Vn2aMZLiizavXPv/BoTR06tK3x45SyhVJMWRqS/k7uy4sqE0EUPPljg0Hvshbml
         89ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866844; x=1693471644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKFe3JKt8mM9KQ1OqvkD5l+gTIC1h1Sk/GZ+WD4chOg=;
        b=APrhDWgsCto9tawUzJEm1hvLaOsnzGM6hAZtAtqUo6RccsDSGcLG4o/62ARH6u/5jC
         bwHQ2GZgI+n4msoODXbHJLu6IfqahfswWwKG0SyRLdWrVsnBPIANQ/k1Ad4cNN8w2FDe
         AJVByOcmi25bhoWhoZkYQ+4aqTqlTtOUqEctq0r5933fHAbxB+doaPFetNFs+276zVIB
         73TrJsrpJKqfAyaTquzLJR03VnYGaoAFEYJKqqQBM9PRCWJByAXTxfEmZqO3RFMhAAvm
         DwPMDCkN66Dsh7ICjyVsL9a5DyQgfLUsx50VzCYYHCBgl1v/rzQpc49jU1Zez6efQWVF
         cKnA==
X-Gm-Message-State: AOJu0YyNuP+keZcRtmVWBNxSbufpd5XHNhvZUa8Ebsw0Z0gWGoya5q7S
        IJJxvsHDYnZRa/8hbRwMIt1AWJ9iu3INLsaCEKtXV9WU/JWDAuml
X-Google-Smtp-Source: AGHT+IGxg+kpt/Ihhz9acxRqkHWrBIP8ppbMhOfWR16qI4d7gbKUbRnI/Ydz3Djb/XRfS5mAJ/TZxoxYg+TurZgh5pw=
X-Received: by 2002:a05:6122:98c:b0:48d:b7c:56c8 with SMTP id
 g12-20020a056122098c00b0048d0b7c56c8mr13980962vkd.0.1692866844314; Thu, 24
 Aug 2023 01:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818190944.22177-1-brgl@bgdev.pl> <ZOM/59nLZwNWrha2@smile.fi.intel.com>
In-Reply-To: <ZOM/59nLZwNWrha2@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 10:47:13 +0200
Message-ID: <CAMRc=McqgWLxDWG5AveDzTabHhaLnF2f36iAyzAx8ktVUMJj+Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: notify user-space about line state changes
 triggered by kernel
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

On Mon, Aug 21, 2023 at 12:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 18, 2023 at 09:09:44PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Interestingly why you keep submitter and author different...
>
> > We currently only emit CHANGED_CONFIG events when the user-space change=
s
> > GPIO config. We won't be notified if changes come from in-kernel. Let's
> > call the notifier chain whenever kernel users change direction or any o=
f
> > the active-low, debounce or consumer name settings. We don't notify the
> > user-space about the persistence as the uAPI has no notion of it.
>
> ...
>
> > -     if (!ret)
> > +     if (!ret) {
> >               set_bit(FLAG_IS_OUT, &desc->flags);
> > +             blocking_notifier_call_chain(&desc->gdev->notifier,
> > +                                          GPIO_V2_LINE_CHANGED_CONFIG,
> > +                                          desc);
> > +     }
> >       trace_gpio_value(desc_to_gpio(desc), 0, val);
> >       trace_gpio_direction(desc_to_gpio(desc), 0, ret);
> >       return ret;
>
> The if (!ret) makes me a bit slower to understand as usual pattern to tes=
t
> for the errors first.
>
> That said, perhaps
>
>         if (ret)
>                 goto out_trace_event;
>
>         set_bit(FLAG_IS_OUT, &desc->flags);
>         blocking_notifier_call_chain(&desc->gdev->notifier,
>                                      GPIO_V2_LINE_CHANGED_CONFIG, desc);
>
> out_trace_event:
>         trace_gpio_value(desc_to_gpio(desc), 0, val);
>         trace_gpio_direction(desc_to_gpio(desc), 0, ret);
>         return ret;
>
> ...
>
> > +     ret =3D gpiod_set_config(desc, config);
> > +     if (!ret)
> > +             blocking_notifier_call_chain(&desc->gdev->notifier,
> > +                                          GPIO_V2_LINE_CHANGED_CONFIG,
> > +                                          desc);
> > +     return ret;
>
> Ditto.
>
>         ret =3D gpiod_set_config(desc, config);
>         if (ret)
>                 return ret;
>
>         blocking_notifier_call_chain(&desc->gdev->notifier,
>                                      GPIO_V2_LINE_CHANGED_CONFIG, desc);
>         return 0;
>

I agree with the latter but the former introduces an unnecessary goto
and looks worse IMO.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
