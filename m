Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0679F294
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjIMUF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjIMUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:05:57 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21841BC3;
        Wed, 13 Sep 2023 13:05:53 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-572a7141434so144223eaf.2;
        Wed, 13 Sep 2023 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694635553; x=1695240353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgnusj9WNYseansm6Kr1sUnhgtykfnbfz9TfjOoUKuQ=;
        b=sg5+CtQlyAZLRAB1atZXHOqxCJhSBMUrLUYpr7pZsxwMqaelYwbMlwGTBHk2F0I2Vi
         BDrUn96udFImnQhLJZCgSacjwq/LJfKgbypS4RBZqp/M2PoGOrY0DLHtfDYhOU3q4QOr
         6aR+RxllmvJ4qw2cVjyYBDMQrCibxqPF8jU5vAFG1X0rRxz+ADV5nd17XWvyruGRCLjx
         jFCCjpSlw/VEuFp5A/LdqA9rbsDkbtU6eHkK4tS7LIsNl3eBzmBkOB47IeP/U3OGCrli
         rLVWKDC2zv3xwyNrK3VgRvNhb8VbxWLB4WJb9lOIsXXny4VkroyQzUUHZiKaUYSiD+IR
         s2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694635553; x=1695240353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgnusj9WNYseansm6Kr1sUnhgtykfnbfz9TfjOoUKuQ=;
        b=mU6lBT4ngu67aBfmB17Dv7pdDmIGCvRpoyX3Z3aYb0d/tPvvxmW2lIDzzB/nTvKiX+
         5tgv+N3ve3fTsCnYkIqMrKZwx85mGyGl11Wj4oMptqx33/Firdq6fdL3iZSxFGm5ZifF
         7/OeEQ2XjjeQXSDF6K6CXApMvkR5MMgtZ1e4hid+tA/n4H+9bJlTZOHvWEC4rM9GIlEJ
         RHElSLFq9QyZIxznkLCJE26+Pm2OhOfPzxy+PgZUYmvnuMDUMUrYf0BlY4oN/MDdpLIZ
         2O/DSzLf+Z+rfdZL7tw9RppuoIfoGPRoa795arypEA/butbyK/lSF/cimQPzzmvirzIC
         G9cQ==
X-Gm-Message-State: AOJu0Yz9WbjXAWKQBJ2PAITsX/9d/PEeWU5pcYZo5ZvMezQ1jDSB6zqx
        8HPFoD6pQKLfTTfnHHS3qnD6goRWdIXoBCBIeB8=
X-Google-Smtp-Source: AGHT+IHLm6apn4O09uKTNNT9VekVtTLxkHf0LthInAJoGoVn7WoUR/7/0i7XlogpEbA/UKANyFR7+IGCoBQWnFUT1bg=
X-Received: by 2002:a05:6870:90d5:b0:1c1:e6da:f88d with SMTP id
 s21-20020a05687090d500b001c1e6daf88dmr3607766oab.56.1694635553050; Wed, 13
 Sep 2023 13:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-3-brgl@bgdev.pl>
In-Reply-To: <20230913115001.23183-3-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Sep 2023 23:05:16 +0300
Message-ID: <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
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

On Wed, Sep 13, 2023 at 2:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use the new, less cumbersome interface for setting the GPIO as
> active-high that doesn't require first checking the current state.

...

>          * here for older DTs so we can re-use the generic nand_gpio_wait=
rdy()
>          * helper, and be consistent with what other drivers do.
>          */
> -       if (of_machine_is_compatible("qi,lb60") &&
> -           gpiod_is_active_low(nand->busy_gpio))
> -               gpiod_toggle_active_low(nand->busy_gpio);
> +       if (of_machine_is_compatible("qi,lb60"))
> +               gpiod_set_active_high(nand->busy_gpio);

Why not moving this quirk to gpiolib-of.c?

--=20
With Best Regards,
Andy Shevchenko
