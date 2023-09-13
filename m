Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DE79E7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjIMMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjIMMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:24:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099219B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:24:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d8164e661abso412672276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607879; x=1695212679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCKxnDesqkrsZ7yc2N/Fu7/OJ4drr6VqYcEJHvcodks=;
        b=vxKbfQLARYe7n9PhA60DoNm/TpOCGp1cbwa8vsAyFYwt9+QX0e6Rd/v+qcx90xwS0v
         /ujR3QhO8OqxjR4ovDwYatXhXKB2Yy0ePiL5I6TXJoSd/YtaseNrqvQWZ//ABUlwyD1C
         4Pcr8elDKTrFT2MXB9jlVcAwLArzWqeBYhMzsLW39lBZFtcDBN48j9tR+fzUqB4KEiQe
         H4CVs6zQeYvQQig6UMoWR8O0KRXyd7Aalk6wcYsMisQlzsCjewZCxDar6d0vNik/cuhY
         HR8UcOebcA7eJdyy9Z0HDsCoNCzbQCK666ysqUjaN/mYdF057B8glJaRp+JUuGTq5BMl
         Q5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607879; x=1695212679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCKxnDesqkrsZ7yc2N/Fu7/OJ4drr6VqYcEJHvcodks=;
        b=sSuONxpUclqjkP1TWCM+uliB3DOWh572wOiiIH1nsOleWpDGqEaNfEaK99fl/vOKLx
         PO6AQPYOoUjsh9Vp0cQajlZC6rgr2brxZSnvfDYgCXeGos3+k3HSKp25AsQUdpveOEQT
         XLChd2M+Shf5zrr0/zr6NtJj1/y3pLUbvef1es9SC3c0BXM+06h849IihYC7RO28duBC
         YdQFAbf77F9UXq00Ge1Su4rrqkUnpMcrHWAmbdGVyuZLgdhqNZzfiToRGI3f4fMtjPgf
         GatAZZNZYMDkZqAbkpSq8pd4Id2TikrEE+Xp+RlVVTTGx37/pDEhX2uawq9/7LRIlAjT
         LqNg==
X-Gm-Message-State: AOJu0YwjU8akku4wrRsuCRIKnug2BCjYkdk0TYbgthuM1XaLS2JjvVym
        Uuam5xjJzC3xnN2yyP5edgWqaFw/hmuu8U9R+haV/Q==
X-Google-Smtp-Source: AGHT+IE8wHWtBHQhWxeImNTh2xHB8xY4DlJAz5zyhEtTpEQcIyhnt6SupOHKd7UVSyFDSlkPFcRI5nGIciiQMYVkWDE=
X-Received: by 2002:a25:da06:0:b0:d81:70b6:c24b with SMTP id
 n6-20020a25da06000000b00d8170b6c24bmr686830ybf.19.1694607878656; Wed, 13 Sep
 2023 05:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-4-brgl@bgdev.pl>
In-Reply-To: <20230913115001.23183-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 14:24:27 +0200
Message-ID: <CACRpkdax-CrB42LeQ1bs3E7VqMncsgEwMs7b_v7J6R5AE+BjAg@mail.gmail.com>
Subject: Re: [PATCH 3/5] mmc: slot-gpio: use gpiod_set_active_[low|high]()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 1:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have new, less cumbersome and clearer interfaces for controlling GPIO
> polarity. Use them in the MMC code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I like the looks of the code better, obviously but this looks like this for
a reason unfortunately.

See the following from
Documentation/devicetree/bindings/mmc/mmc-controller.yaml:

  # CD and WP lines can be implemented on the hardware in one of two
  # ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or
  # as dedicated pins. Polarity of dedicated pins can be specified,
  # using *-inverted properties. GPIO polarity can also be specified
  # using the GPIO_ACTIVE_LOW flag. This creates an ambiguity in the
  # latter case. We choose to use the XOR logic for GPIO CD and WP
  # lines.  This means, the two properties are "superimposed," for
  # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
  # respective *-inverted property property results in a
  # double-inversion and actually means the "normal" line polarity is
  # in effect.

Will you still provide the desired "double inversion" after this patch?

Yours,
Linus Walleij
