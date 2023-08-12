Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F0A77A1C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHLScd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHLScb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:32:31 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1401735
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:32:34 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-447684c4283so1078343137.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691865154; x=1692469954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM7SL1CGtAcQNB76zNyrZW3MpWnx6szP9BMz50lMDR0=;
        b=bmhexv86dnSerLJmBpquZF0ASTZOXZDLabKfF/4ls0uO1bktHYqR+Z5silBc/eG09O
         uuEaC1BbMkLmxTCGab1oGC8YlU5WvZ4m4MzkYa8G+SErCrDQzZKNto8QZaBME2R2THm4
         jO/0s65SblHdxhuhjhDTxHnV/5s/r1CEotGhDXl4uBQLKtYzfSG9etsNb5/Vo9TkprMO
         haEdLPjeYbKrT3/zxAmQVIK9+k27iFxEQloldiV+zCMIfxxEYy8BfyPpbrlpZ/j9cic9
         r1C/4kzWYifEzAIHDsNEocEofA4TfjLxPN7Af5ZoVuum7SFi52nzVnLImoUTj/aB04aM
         a+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691865154; x=1692469954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM7SL1CGtAcQNB76zNyrZW3MpWnx6szP9BMz50lMDR0=;
        b=ADOpN0WmRwKyfJWEklnYfVM/evIjpWV/kpo8PfFXiMiu5MaMH7v5KtS9uLBoZsT3sO
         oskPutfE8yqcJoAn9ZspZflTMxzbw426YqaQu8mciLAvtbe1QWj/VDsVuBcx2OORexef
         2/Sg6+vhJ/skkFqHpGnA2HBMGgC0GbWwQuNeuymqP67qh0J3Dq0alkxYbxD/SVe05I1M
         dt9hHvmPB9fjgS3MHUnB+PFt04ryuk111dqC0f7T73X7L1T0A9pqPidvK+DuVbDzm+9G
         QA6uBg1Ue4MC909J1E5BW4HZUMORXp+dJj+avPj9xagNp8yLRn1aaWgdnIqdamJ4Vzrc
         iI4A==
X-Gm-Message-State: AOJu0YwkFAfAFzdBKp46MgU3lF1dbNB2/C+eXdqsN9WlVP8cvilZGaRv
        ZubKl7tsJr/q/TtwopbtBGy6TVZM+9fHL4EDKoDWpg==
X-Google-Smtp-Source: AGHT+IEuWMrqQjxQveELsIl+8I61Ix4zO4MpstizsYYNCtBdyR/1BiUiexZSXWAWJibBWW+h+Yl5hQVdCJ10kXTTuXY=
X-Received: by 2002:a67:ee46:0:b0:447:6947:24dc with SMTP id
 g6-20020a67ee46000000b00447694724dcmr4641167vsp.9.1691865153906; Sat, 12 Aug
 2023 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230811131427.40466-1-brgl@bgdev.pl>
In-Reply-To: <20230811131427.40466-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 12 Aug 2023 20:32:23 +0200
Message-ID: <CAMRc=Mdh6EGK9hbRgEKdz_tFGDk5uqWD6E+XpJqhoXLLi8ECpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sim: simplify gpio_sim_device_config_live_store()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 3:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Simplify the logic when checking the current live value against the user
> input.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This is the same as what Andy suggested for gpio-consumer. Let's save a
> line.
>
>  drivers/gpio/gpio-sim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index dc4097dc0fbc..0177b41e0d72 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -986,8 +986,7 @@ gpio_sim_device_config_live_store(struct config_item =
*item,
>
>         mutex_lock(&dev->lock);
>
> -       if ((!live && !gpio_sim_device_is_live_unlocked(dev)) ||
> -           (live && gpio_sim_device_is_live_unlocked(dev)))
> +       if (live =3D=3D gpio_sim_device_is_live_unlocked(dev))
>                 ret =3D -EPERM;
>         else if (live)
>                 ret =3D gpio_sim_device_activate_unlocked(dev);
> --
> 2.39.2
>

Applied.

Bart
