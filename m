Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D34786B40
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjHXJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjHXJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:11:36 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD93199A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:11:30 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48d08a812c0so1792914e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692868290; x=1693473090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKDQmEavV9r7yC0aswW0EHwjQsHDSNxrluX3ZRmyHbc=;
        b=QUtazsd0FFtGG3fYA77/a2id7ds4aYIPEQJFcikZuHiwpPK3BeHPe5j3qJtkdHcga+
         c2Q43nugAizYKtxGHFDV+5WBl7DH9bS6YElnZ+S/uswaybM/IZv3zD4Xnfa23oalx8Ee
         etJ03XvFJglMefL9PZOcYdBZyV4SvrWXJvLJ/7Dv5afu1raPVksbX7adeBi+I/r878tt
         3pGL2iCgxWJ9Arez3tsmzvEcghxVNBC6ETmrsamQgdp3jRWZedPHVuhP4Rtixf25ABaV
         RZwc9hEnFu4ZpwgqxXALgAV8RbqVDfx9yEjYKcsb0zsvs8AjvNqLYIZ71JkPPfxKErtC
         gTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868290; x=1693473090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKDQmEavV9r7yC0aswW0EHwjQsHDSNxrluX3ZRmyHbc=;
        b=TIqPFUMYgHtukG+JHt8xW7m73p712csY1E0D46rWTsHdikuvTTQQ864p3wMoyWDOz3
         G6V6gNEBIwY5buNNLsOaqQk4QtkOP27w+sU19B7UfiVPRAwPlJlmXICb6c4CZ8CAgbG9
         Nzl3TQ63xTgkTtN3kIG3leePrPgXZu6vCSAhTxOZSBm//gLY6n1mP00e0PSop9Cn9srQ
         rpomIfanT3BXdZleYQKQ6jhT/5W1ZzocP5qUfDTYy3c3f45ghwDzV14YDvogz1nLvlaw
         W5GRv1EhjsJaxVfe12TQiYevZj2cUPV6pS8D9iQyPrDdN09SapT1sD2jsy8/aGvKDabT
         UlPw==
X-Gm-Message-State: AOJu0YyF7X1VQpDz7/Uv4Ortu2ApiQHNchdswd3knHiD3aP7HrpgI7Q8
        gCLANwupSkkZ244p9BxOLolc9AQI0pq/CKzPL89NaZy6Mrc8Q/DS
X-Google-Smtp-Source: AGHT+IF45+Hlo2+p4IBs/zgdGxtt/0SZserNbdGTZJ/5bN7n/JfLZ0cA0pBZ1fD2k75NVf8SFD+yzeNuG+ia2NXtFRg=
X-Received: by 2002:a1f:ddc3:0:b0:48f:b24d:21d3 with SMTP id
 u186-20020a1fddc3000000b0048fb24d21d3mr3351570vkg.15.1692868289740; Thu, 24
 Aug 2023 02:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230824085544.110417-1-brgl@bgdev.pl> <ZOceEeBuX+Nh7DJo@sol>
In-Reply-To: <ZOceEeBuX+Nh7DJo@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 11:11:18 +0200
Message-ID: <CAMRc=MdEqm2U9AfPiw5kerJpB1hXyvEQ1_m7EhgoFZ+G3UyDAA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: notify user-space about line state changes
 triggered by kernel
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Aug 24, 2023 at 11:08=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Thu, Aug 24, 2023 at 10:55:44AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We currently only emit CHANGED_CONFIG events when the user-space change=
s
> > GPIO config. We won't be notified if changes come from in-kernel. Let's
> > call the notifier chain whenever kernel users change direction or any o=
f
> > the active-low, debounce or consumer name settings. We don't notify the
> > user-space about the persistence as the uAPI has no notion of it.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > v1 -> v2:
> > - use the gpiod_line_state_notify() helper
> > - reorder the code in gpiod_set_debounce() for better readability
> >
> >  drivers/gpio/gpiolib.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 40a0022ea719..1cb7731550ca 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2439,6 +2439,7 @@ int gpiod_direction_input(struct gpio_desc *desc)
> >       }
> >       if (ret =3D=3D 0) {
> >               clear_bit(FLAG_IS_OUT, &desc->flags);
> > +             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> >               ret =3D gpio_set_bias(desc);
> >       }
> >
>
> gpiod_direction_input() is called by cdev when a line is requested.
> So requesting a line now creates two events - REQUESTED and
> HANGED_CONFIG? Even worse - it calls gpiod_direction_input() first, so we
> will get CHANGED_CONFIG then REQUESTED??
>
> And a config change from cdev can call this and then generate a
> CHANGED_CONFIG event itself, so again double events.
>
> Same for output and probably debounce too (that one is a bit more
> convoluted).

Ah, should have tested it with user-space too...

Back to the drawing board I guess. May be the reason why we're not
doing it in the first place yet.

Bart

>
> Cheers,
> Kent.
>
> > @@ -2484,8 +2485,10 @@ static int gpiod_direction_output_raw_commit(str=
uct gpio_desc *desc, int value)
> >               gc->set(gc, gpio_chip_hwgpio(desc), val);
> >       }
> >
> > -     if (!ret)
> > +     if (!ret) {
> >               set_bit(FLAG_IS_OUT, &desc->flags);
> > +             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> > +     }
> >       trace_gpio_value(desc_to_gpio(desc), 0, val);
> >       trace_gpio_direction(desc_to_gpio(desc), 0, ret);
> >       return ret;
> > @@ -2672,9 +2675,16 @@ EXPORT_SYMBOL_GPL(gpiod_set_config);
> >  int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
> >  {
> >       unsigned long config;
> > +     int ret;
> >
> >       config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, de=
bounce);
> > -     return gpiod_set_config(desc, config);
> > +     ret =3D gpiod_set_config(desc, config);
> > +     if (ret)
> > +             return ret;
> > +
> > +     gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> > +
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
> >
> > @@ -2723,6 +2733,7 @@ void gpiod_toggle_active_low(struct gpio_desc *de=
sc)
> >  {
> >       VALIDATE_DESC_VOID(desc);
> >       change_bit(FLAG_ACTIVE_LOW, &desc->flags);
> > +     gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> >  }
> >  EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
> >
> > @@ -3330,6 +3341,7 @@ int gpiod_set_consumer_name(struct gpio_desc *des=
c, const char *name)
> >
> >       kfree_const(desc->label);
> >       desc_set_label(desc, name);
> > +     gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> >
> >       return 0;
> >  }
> > --
> > 2.39.2
> >
