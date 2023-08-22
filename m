Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E278408B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjHVMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjHVMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:17:03 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A4CE7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:16:57 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79b4d2c0621so1111418241.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692706616; x=1693311416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR8csb+pfbfmMWIfz29AGSv8lUUOlaxU8/bfAatlZTA=;
        b=HbXpqb/1BjS2BkfrAbGPVMSmFbvDAaUxhEXyC0hsXdDddBZj9cLsZ0HsgHLLoEtV8C
         y0Mo2mr8fa7tia5sU8oGxKCbTWapq+GPDXNSEsk5VdLRgNoXvhyFooJrMNhmadNoQuB7
         kVIxNF9ow3hkz1QJMkhYMLid9XpVyK9StCPm6wiJ3nAi8UZHFoF555CZRcCXU3XQpx3M
         tm51MdX5b/j7FGKZCC9nBPrLegSQHYSRtPXJ/nc3pxVZWooYDU72F/APCgZ/k8Lcdqmc
         HESsurWvQtYUeeNP4O+S9VUpsbnkO0tsy4bqkytqsYAtEoot4u2ENtEEYdDpTAip75ht
         fvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692706616; x=1693311416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR8csb+pfbfmMWIfz29AGSv8lUUOlaxU8/bfAatlZTA=;
        b=BLSBWIC6JTQWHatX5wS/yk9lOto0x/JiW0Vdn2pE2YaZdBZ4BnGIbCDUTb36jgJXTL
         wDjfhNTXZwxhNEdpwmQv5a3toViG6C/SI6wyBS3IEpfvTXgPzP2XHdte97WC7d2wrgTr
         1eszpTrOt085SKUK8l0cjdy6dANzDl7PC4S7ZFyt4yQHsrvrg2CNYNGeabblnSAPXseT
         5RzKfe584QnNe+Z+WTcpFGu2/YrBF8c0HT6bI42U7OHGxr+ynYZZcoPXeEZyjtfIzMk1
         oFm+xkIPKzPBzf/VlzLMv/obSjC8rAbpkZ5Bc4syduD1JmR7gw6FeSglLT6YfgY+Sn8V
         pRxQ==
X-Gm-Message-State: AOJu0YxUtmOWl+Ohq9ZRYbBuen2fLod7cDy+wD7ktEQDKjmzmregm1Hn
        A0N/1Ei202OW+V6Vvuh9xlT4cHL6ESaYXVmvvCpMsQ==
X-Google-Smtp-Source: AGHT+IEvZD5dKlUJQSqC05PoFL/paEsxxejYH4Qf7pxXk4/CJ7DGKb5wRHcAgvBpJZbjWmONFze1qEGP/AN57bzpXXo=
X-Received: by 2002:a67:eb92:0:b0:443:8034:be4b with SMTP id
 e18-20020a67eb92000000b004438034be4bmr4098876vso.35.1692706615188; Tue, 22
 Aug 2023 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230822075122.6900-1-brgl@bgdev.pl> <ZOSmFGZHrLq3I+zF@smile.fi.intel.com>
In-Reply-To: <ZOSmFGZHrLq3I+zF@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 22 Aug 2023 14:16:44 +0200
Message-ID: <CAMRc=MenZDhrVb9BgJ3R+NqyvoHJR2stjeXouSRWTkecgo160g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sim: dispose of irq mappings before destroying
 the irq_sim domain
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

On Tue, Aug 22, 2023 at 2:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 22, 2023 at 09:51:21AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > If a GPIO simulator device is unbound with interrupts still requested,
> > we will hit a use-after-free issue in __irq_domain_deactivate_irq(). Th=
e
> > owner of the irq domain must dispose of all mappings before destroying
> > the domain object.
>
> ...
>
> > +static void gpio_sim_dispose_mappings(void *data)
> > +{
> > +     struct gpio_sim_chip *chip =3D data;
> > +     unsigned int i, irq;
> > +
> > +     for (i =3D 0; i < chip->gc.ngpio; i++) {
> > +             irq =3D irq_find_mapping(chip->irq_sim, i);
>
> > +             if (irq)
>
> This duplicates check in the following call.
>

Ah so it can be a direct call:

    irq_dispose_mapping(irq_find_mapping(chip->irq_sim, i));

?

Bart

> > +                     irq_dispose_mapping(irq);
> > +     }
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
