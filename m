Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6BB75FE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGXRuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGXRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:50:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CCF26B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:47:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so5253003276.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690220783; x=1690825583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGALWlWRmNXsoEbN3b+Tsx/4LBd65om9fdbI43IPJSQ=;
        b=yPju5M+Iv8zlSqSRN8NkZ/yaY4qNd5PEyKZ6GihXBTYJu4Oi5zHjrSx9mDNXxXBubD
         JAPRwFk+gjIMK8tmIdZCD2E/ZFej3XpUtcL29RiU9C9+RvxF/J0GwvqaWC7exge3Gy/e
         pH7xd9OpQt5T+s0ev/unKrdhzaX0O0uvsA9QTg3gMUo+dzD3gIsAobi0UPld+cdbsVhu
         kBykcbwzT5oFROLwGEFhbuKKF7A+tzce+wWvDetiQ6MRSK03TBFJVS1yx0QCz+nD0rgQ
         mIstMK31i5aMMLm6xu1I2Brtj8G5E0X+XOyLZIxfQYmVu4hZYGNQrDQE5sprT/8CBmsi
         kE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220783; x=1690825583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGALWlWRmNXsoEbN3b+Tsx/4LBd65om9fdbI43IPJSQ=;
        b=PZVdjIvQP1AGHos5taoNfwTZJMLLZzyncJ0pK0Nu/zyXpRabxj2NINH6zpuUEeooUQ
         tSxZGOJywhyrXXS2rUpTVXUHZ26Ih4U/Ydh8U5NRh1GMuqm7bw8l3FpdUUtCyvrBtNSZ
         qfUlWeliAGhPgt1bkCy5rhCsBK1/t51j7gpKJAmczK+U1ZOSb2RK1ug1r0/OhtasjkT6
         AZHzESg940jw0tmRYYXoSBgVs0BS/FSDvl2mtHbYttsQHbg1elqZGDl4FTtIa1zWiYmI
         BKL2U2P//9csfWAaU15ksGiDnoT10nwXeVP4yfhu3XaLxIC1/slsNbkv4fqGvPSveBqO
         XdWw==
X-Gm-Message-State: ABy/qLaQD7iDCc/YbH0I+XLoTi0D+eb4ALpf80ijYF7BO/+6knyH3jmV
        rTFXb3r++HusNZZmi0AoFblNG8glO50eLXizhxddew==
X-Google-Smtp-Source: APBJJlH8543Uiuv9stapIH1RgQRbeQXKG/JYL5CYIdoKUw61G/5g7iNnYPJzhBnZUIogAwXmNNV751ON/7/ITO3he7o=
X-Received: by 2002:a25:ab12:0:b0:d12:3108:f90f with SMTP id
 u18-20020a25ab12000000b00d123108f90fmr2934909ybi.24.1690220782953; Mon, 24
 Jul 2023 10:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230721093342.1532531-1-victor.liu@nxp.com>
In-Reply-To: <20230721093342.1532531-1-victor.liu@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Jul 2023 19:46:10 +0200
Message-ID: <CACRpkda+kWcaeF1WMetDp3ppbrbQmuFEiUbpTdq2kH7o7wN68Q@mail.gmail.com>
Subject: Re: [PATCH v4] backlight: gpio_backlight: Drop output GPIO direction
 check for initial power state
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "andy@kernel.org" <andy@kernel.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:29=E2=80=AFAM Ying Liu <victor.liu@nxp.com> wrot=
e:

> If GPIO pin is in input state but backlight is currently off due to
> default pull downs,

Oh what an interesting corner case!

> then initial power state is set to FB_BLANK_UNBLANK
> in DT boot mode with phandle link and the backlight is effectively
> turned on in gpio_backlight_probe(), which is undesirable according to
> patch description of commit ec665b756e6f ("backlight: gpio-backlight:
> Correct initial power state handling").
>
> Quote:
> ---8<---
> If in DT boot we have phandle link then leave the GPIO in a state which t=
he
> bootloader left it and let the user of the backlight to configure it furt=
her.
> ---8<---
>
> So, let's drop output GPIO direction check and only check GPIO value to s=
et
> the initial power state.
>
> Fixes: 706dc68102bc ("backlight: gpio: Explicitly set the direction of th=
e GPIO")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

The solutions seems fine.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
