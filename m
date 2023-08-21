Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1A782ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjHUQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjHUQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:51:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD7184
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:51:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bed101b70so465160766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692636667; x=1693241467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjzd+fSCL+R20OAcRpQyLo14Qr7E7n5zqxoYWNbyqEM=;
        b=dOXKRVdF9+P3SNADdlbZshfwcjxQqf7LjXq/PyQBgXwSlee49f7vjB69G56IRk3G22
         DDfv+HyTBkoABeTDbstgI0UC446OpM/wjUt4wddJfJAB/0q2IxOEm8+Q266es/IeD0n8
         9CR486L7bXY5K1/wsIj65yj8ugXqpmBAN3XOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636667; x=1693241467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjzd+fSCL+R20OAcRpQyLo14Qr7E7n5zqxoYWNbyqEM=;
        b=UWYK4GdOQUvU5a8NA5mOxbTLvPnOzTDFHxDedeU9WXWkMr0L0WkkVgrli2JEHEHUvr
         16t1205sGkb37grtNCjSLx5Xx1PQxaYo7yrxC3kIiB3B0wQ/+SIKGQAa+7UgHi4oZuUP
         1TcG6ZDgiQSHgSC/7W2uLyBRxmfuXsrLCb/oYHnLgFmXU+vCt1E0sjlIMNOYJ3bb75gu
         gI99qBu96VO/znpL9ujR1aLoSoPFNPEuJb1yn2P9bdBjCXpebYjp5RCFnkR2O+6x6MtD
         G2JDuntj21HRcayNcZRlqPdI6yF1Lnn9Y+XPWtj8aZ/bAnM+VX3klZhvuXpyw8c8AhCs
         G5Fg==
X-Gm-Message-State: AOJu0YxR47WK+qwOb/x2nogZZJ9umf0VQChmupV/pv31M7mNpzAPAJBb
        1ovte5SZvfc8OXWpg+NDQbuQ+NAtxvu9CxSAv9KKd+bs
X-Google-Smtp-Source: AGHT+IG2nIsEZSlHl7cX5/GeygovY25uQZZ5u/3yFP55bWjAKqnhFuwoK4hjQDw43N2JigfJM2U3/A==
X-Received: by 2002:a17:906:55cf:b0:99c:8906:4b25 with SMTP id z15-20020a17090655cf00b0099c89064b25mr5586856ejp.74.1692636666948;
        Mon, 21 Aug 2023 09:51:06 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906a21900b00992f309cfe8sm6789774ejy.178.2023.08.21.09.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:51:06 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so2765e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:51:05 -0700 (PDT)
X-Received: by 2002:a05:600c:511d:b0:3f7:e4d8:2569 with SMTP id
 o29-20020a05600c511d00b003f7e4d82569mr366wms.5.1692636665703; Mon, 21 Aug
 2023 09:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <b6fa0cfae0072c2fbc0591d619f328324bfbe1ad.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <b6fa0cfae0072c2fbc0591d619f328324bfbe1ad.1692484240.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 09:50:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XftP6icTWK-xEPJvBiuXLeCDpy1ORiwedxNtw7z2Rp6w@mail.gmail.com>
Message-ID: <CAD=FV=XftP6icTWK-xEPJvBiuXLeCDpy1ORiwedxNtw7z2Rp6w@mail.gmail.com>
Subject: Re: [PATCH 5/6] regulator: core: propagate error out ouf regulator_lock_two()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 19, 2023 at 3:46=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:
>
> Fix up error paths from regulator_lock_two(): although it should not
> fail, returning with half-locked state after issuing a WARN() asks
> for even more trouble.
>
> Fixes: cba6cfdc7c3f ("regulator: core: Avoid lockdep reports when resolvi=
ng supplies")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index de434d550937..d8c2277cea36 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -197,9 +197,9 @@ static void regulator_unlock(struct regulator_dev *rd=
ev)
>   *
>   * Locks both rdevs using the regulator_ww_class.
>   */
> -static void regulator_lock_two(struct regulator_dev *rdev1,
> -                              struct regulator_dev *rdev2,
> -                              struct ww_acquire_ctx *ww_ctx)
> +static int regulator_lock_two(struct regulator_dev *rdev1,
> +                             struct regulator_dev *rdev2,
> +                             struct ww_acquire_ctx *ww_ctx)

Please update the kerneldoc to talk about the return value.


>  {
>         struct regulator_dev *held, *contended;
>         int ret;
> @@ -208,10 +208,13 @@ static void regulator_lock_two(struct regulator_dev=
 *rdev1,
>
>         /* Try to just grab both of them */
>         ret =3D regulator_lock_nested(rdev1, ww_ctx);
> -       WARN_ON(ret);
> +       if (WARN_ON(ret))
> +               goto exit;
>         ret =3D regulator_lock_nested(rdev2, ww_ctx);
> -       if (ret !=3D -EDEADLOCK) {
> -               WARN_ON(ret);
> +       if (!ret)
> +               return 0;

Aren't you missing the "ww_acquire_done()" in this case? I know it's
optional, but nice to call it anyway...


> +       if (WARN_ON(ret !=3D -EDEADLOCK)) {
> +               regulator_unlock(rdev1);
>                 goto exit;
>         }
>
> @@ -225,15 +228,15 @@ static void regulator_lock_two(struct regulator_dev=
 *rdev1,
>                 contended->mutex_owner =3D current;
>                 swap(held, contended);
>                 ret =3D regulator_lock_nested(contended, ww_ctx);
> -
> -               if (ret !=3D -EDEADLOCK) {
> -                       WARN_ON(ret);
> +               if (!ret)
> +                       return 0;

Aren't you missing the "ww_acquire_done()" in this case?


Overall, I guess I'm OK with this. I agree that we'd be in pretty bad
shape if we exited the routine and left one of the mutexes acquired,
which the old code could have done. However, at the same time these
error cases really shouldn't happen anyway. In that sense, I guess
they really should be BUG_ON(), but IIRC that's discouraged. Thus, I
think your patch is the right direction.


-Doug
