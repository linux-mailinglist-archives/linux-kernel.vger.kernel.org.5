Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942107FD9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjK2Onq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjK2Onn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:43:43 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662CD5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:43:44 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49618e09f16so1737930e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701269023; x=1701873823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rmkMM8ESI5mrgpY+hyRZPX+eOseClGKdO3wFuBysPw=;
        b=BwzzGAyGcJvMYxbZHk3Fw6C4CIfcTu4ipU9hvvs0/LWuEljUjTWFRI82IAoZrbEURW
         VD63Ac0nQRGahWdOxWbjruPFtDz4i/Ys0OactYBFWwUQvWtALaj3yYTVO45SjmC9Vjrc
         isutxXfzGaKOn8LNLEAalcDUUSbdiIo8hNnR3Jz+D/CC8J8psRoN6SAgVuGmd/Hidkfv
         w2ZOE/gAjaqy2N0GWNd70t1p/Yt+i/209DMJo2RNuV8ba79mDHUxXkMRXqymrPo8GkBA
         yjgMFhlZs21+vBygzvakvKKhOEtY+AHY1bRoNDVfbs1BVjVqGO6nSLAKCIz/isKHXgrc
         THVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269023; x=1701873823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rmkMM8ESI5mrgpY+hyRZPX+eOseClGKdO3wFuBysPw=;
        b=Z2gHYjDnbHZcNoW4XNcMfkhm+u7hA/gnib45aC6MKqeTNNtPB3w21KX3KXcfAAWRK3
         CsXYPxurbunQ5M5z0Ufw/Va6Ba9eLH107BFcZ9kAdDTL99FsEOBqYb3QXJ1QpABOXrF0
         /5w8gDBgFbIKn9kkNbZguaY4ossgy8kiieL5iSC8RPfnqhfIUQfxefabWfi+siJMJOtC
         MO/wdoRGx6Q3/sZ7g1fXEyN3WTE6fm1wWDXukcecTT3F3/oR10TkNHxFFcKIsnh2em6o
         CeJ4Jd3wUhqk2ViAE1DyOqdrgtZ02GJ9orRLp61Wf7pHqip+g/lcoav/jchT5wETWHaV
         loxg==
X-Gm-Message-State: AOJu0YyGp1Vt1ygN653zIeN/YXn4kzJKiPCtDaybcZIGhDEQzUkkaKgn
        kyTpsHMz4yFWjiklYcHhOOfHdRSpFrvMMm85L4p1X93hPGk7a8RWETg=
X-Google-Smtp-Source: AGHT+IGg4feXHlqH1k+LS1haHX894DfH+rp+1nlOgEZHI0wBa6s1+9a8a7exhdIV/QguwIGDn8v54ioBMnVhi7rKoho=
X-Received: by 2002:a05:6122:3106:b0:4ac:22c7:89d5 with SMTP id
 cg6-20020a056122310600b004ac22c789d5mr14312769vkb.2.1701269023361; Wed, 29
 Nov 2023 06:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20231129142411.76863-1-brgl@bgdev.pl> <20231129142411.76863-10-brgl@bgdev.pl>
In-Reply-To: <20231129142411.76863-10-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 15:43:32 +0100
Message-ID: <CAMRc=MfL2nHF78TUmRjRSUC-2zyMjWotzU7Tv_27mVJPLET40Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] gpiolib: use gpiochip_dup_line_label() in for_each helpers
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 3:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Rework for_each_requested_gpio_in_range() to use the new helper to
> retrieve a dynamically allocated copy of the descriptor label and free
> it at the end of each iteration.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/gpio/driver.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 9796a34e2fee..6405f6d454af 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -543,8 +543,10 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, =
unsigned int offset);
>   * @label:     label of current GPIO
>   */
>  #define for_each_requested_gpio_in_range(chip, i, base, size, label)    =
               \
> -       for (i =3D 0; i < size; i++)                                     =
                 \
> -               if ((label =3D gpiochip_is_requested(chip, base + i)) =3D=
=3D NULL) {} else
> +       for (i =3D 0; i < size; i++, kfree(label))                       =
                 \
> +               if ((label =3D gpiochip_dup_line_label(chip, base + i)) =
=3D=3D NULL) {}       \
> +               else if (IS_ERR(label)) {}                               =
               \
> +               else
>

Ah, cr*p, it will leak if we break out of the loop, why did I think it
was correct?

Any ideas how to handle this one? I was thinking something like:

    for (i =3D 0, char *p __free(kfree) =3D label; i < size; i++)

would work but it doesn't.

Bart

>  /* Iterates over all requested GPIO of the given @chip */
>  #define for_each_requested_gpio(chip, i, label)                         =
                       \
> --
> 2.40.1
>
