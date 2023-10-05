Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9637B9F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjJEOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjJEOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:47 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC746EAE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:43:05 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49a885c5961so256635e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696488185; x=1697092985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGoaC1Wcp6rYPnjGJSe6VARj9bzOCTTk06EKi9+Z3hA=;
        b=ToicOkGbMDRzKJjS+3Of1B+rRcvxnOkRWFF//ulW62YXlpewLPYH7qTE5l3srgrcz9
         ogBlik5CC69N1xiChCHA1BxOTh3Y6xZjYwrY0CPqnrwYweDxPFmSszLv1mXuALHVuD6R
         /aCxVvBOG2kR165AeP3Bgayfmy7owV+OVl8oNBuuxtVhoU/X5yBS+cxd4UXNKET7Jg5H
         8F2rt8LFjSn2ADFp7QeAjkEDmPxPLkWYkyfLaQk6K6YknMr7J8kE+5NObp1EFJ1KwSRG
         Iwy2l1sSoMJPzlR8w98Q/vJvxyRUUxpHsc1Pvrgnr7lnnDMfpqBQNIZ+SmW7a9eIt7TM
         oqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696488185; x=1697092985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGoaC1Wcp6rYPnjGJSe6VARj9bzOCTTk06EKi9+Z3hA=;
        b=hKSgyw0tJ0KEJ03KvxRyjWkAVxrF9rH/+ZmXvVYM53r45BpNmC4+NXwljskDoDWRf5
         Wt69Zbzz8+sOAWLIaQCTKtauc27S+WuF311hwsdGFRlm0TvDtVeFMIpqr2Ug7XrWI0sR
         GGoSfeszoQp0MD6eyFuCWsncysbXxnK/41D06bLklxnuMXZbiUdPZapWCYrD5ZNhgheb
         9c035uJe4di3X7sX0r7qrZuZgn53qk9Xf+huwO5eam4JuvKt8XnR+yAN5Wkdw3uWZ79g
         F/d9IBVcrCLpT3H3XCSqpbFwjwnydnMNggqWqR1itiGNKIQG6dDQ62b6BAbP8qZ1yyM1
         lImA==
X-Gm-Message-State: AOJu0YyYBpa+2MoaPriMVhlu6Mzb6ylk+jdVmMaYSf55n5mToeRzZQMF
        RI29Qmq+mX4kf1RO+YTd99fGwV5cg/hAlT/BE51ZLA==
X-Google-Smtp-Source: AGHT+IF9AStF08LnnmPoyECeA01wkoJtydwGXomw/31OD+TyB0QeLcMuubWOdNucB26fwKEGuoDDyaTTHksIsQIEO8k=
X-Received: by 2002:a1f:cb42:0:b0:49b:289a:cc3f with SMTP id
 b63-20020a1fcb42000000b0049b289acc3fmr3946166vkg.3.1696488184932; Wed, 04 Oct
 2023 23:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231003073926.10771-1-brgl@bgdev.pl>
In-Reply-To: <20231003073926.10771-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Oct 2023 08:42:54 +0200
Message-ID: <CAMRc=Me9QjuM41iRJ9NjQ8kZUJ_yJ5MKXmMhViOka6j71+jVfw@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
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

On Tue, Oct 3, 2023 at 9:39=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> pinctrl_gpio_set_config() expects the GPIO number from the global GPIO
> numberspace, not the controller-relative offset, which needs to be added
> to the chip base.
>
> Fixes: 5ae4cb94b313 ("gpio: aspeed: Add debounce support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index da33bbbdacb9..58f107194fda 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *c=
hip, unsigned int offset,
>         else if (param =3D=3D PIN_CONFIG_BIAS_DISABLE ||
>                         param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN ||
>                         param =3D=3D PIN_CONFIG_DRIVE_STRENGTH)
> -               return pinctrl_gpio_set_config(offset, config);
> +               return pinctrl_gpio_set_config(chip->base + offset, confi=
g);
>         else if (param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ||
>                         param =3D=3D PIN_CONFIG_DRIVE_OPEN_SOURCE)
>                 /* Return -ENOTSUPP to trigger emulation, as per datashee=
t */
> --
> 2.39.2
>

Queued for fixes.

Bart
