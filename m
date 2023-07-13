Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64217752B59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjGMUIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjGMUIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:08:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A12D59
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:08:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so2018973e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689278894; x=1691870894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u34z4glnpomRSBgQT4bG9FMnp1Iswj4TV0WEYU0qNmY=;
        b=bGAOyWilVBc09A647WYrJIumc8/YjY9sDp7NZmrDXwn0qDQePWLh48nO+TUBh17Nyd
         oAZaLPLVA3isDJw+AFba5SDOaoss9qxBaPUEcpwUyJidSkzjW597ngchDC+z4On+1MLl
         qpQNF7M4LVHZEjzaIgrfTqO6Er9Rt8vLyUfeakjL8xAe4DyhfkdgzCuH25atPcQ9c9l2
         U1JOfQeyh41hNp5fDzYnvHyv1M+6E3m4hnOVAQFythTWRv9+El6F/xFe7SVJvMaF81A9
         3CK6INwNak3gSfnX+PMAEi41qYy7mz1rsh8fWjPvG87glYP8j7fwB1odhk+62U2CXrXL
         Wjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689278894; x=1691870894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u34z4glnpomRSBgQT4bG9FMnp1Iswj4TV0WEYU0qNmY=;
        b=YmVUMIdFoxRtWJZTwoFx09AS8Vy0aHmXHXmr2MkDW/VyO7NCZd2ajpdVXw9KKzdSej
         S6zdEjLG/+3SvX9pHvSQdHEFQD9mxv9j3GVPXT4J1Fwq9UP+YolspVLMXBQm4Vg+ZQ6r
         XE9/Gbmv4f5IvLq8KWSBNcS9UGYmVF4qE13lKq0iofQ28pFm9SpqGNvD812EGuaGP515
         09ly/9KJzBHJINu5LtFyN+S9aqLT/BHCqW3+vonYAEuXIwE2u7bh5IfZ+KBXtbFK2Cs9
         ZBSgHc0568A5SqcjV362aqCPDN/cq/yMBZlqrgvGaYLHBuYff8SrzeOKv9Z0FO3N4gqn
         hKog==
X-Gm-Message-State: ABy/qLZwXYdm83MeTEPU6y0NvTDIKLws5WJygB5pP4vM0/ZlRCT8zmgH
        zcDG0tH8sJVzPgJkdBK4AiJZvugCj15PWM4nU0kp/w==
X-Google-Smtp-Source: APBJJlGlntgpNzb8aiVWjVCNIX8MNjnI9Q/oyemXLvfjZeeUxu+YH3q9dZLCcmqm9qyQ/BtiGwjjzA8vEIa/9mrKxiY=
X-Received: by 2002:ac2:5dd4:0:b0:4fa:a217:1e76 with SMTP id
 x20-20020ac25dd4000000b004faa2171e76mr1911934lfq.9.1689278894303; Thu, 13 Jul
 2023 13:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230516164416.11616-1-alex@shruggie.ro>
In-Reply-To: <20230516164416.11616-1-alex@shruggie.ro>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 13 Jul 2023 23:08:03 +0300
Message-ID: <CAH3L5QpmPrHZPKVSapPtgDNORb8hj2AhCLGP0Fx7p5ZX++qOOA@mail.gmail.com>
Subject: Re: [PATCH] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        Bogdan Togorean <bogdan.togorean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 7:44=E2=80=AFPM Alexandru Ardelean <alex@shruggie.r=
o> wrote:
>
> From: Bogdan Togorean <bogdan.togorean@analog.com>
>
> For ADV7533 and ADV7535 low refresh rate is selected using
> bits [3:2] of 0x4a main register.
> So depending on ADV model write 0xfb or 0x4a register.
>

Ping on this patch :)

> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/gpu/drm/i2c/adv7511.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.=
c
> index 61aa824d45d2..e016105a8fbe 100644
> --- a/drivers/gpu/drm/i2c/adv7511.c
> +++ b/drivers/gpu/drm/i2c/adv7511.c
> @@ -729,8 +729,13 @@ static void adv7511_encoder_mode_set(struct drm_enco=
der *encoder,
>         else
>                 low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_NONE;
>
> -       regmap_update_bits(adv7511->regmap, 0xfb,
> -               0x6, low_refresh_rate << 1);
> +       if (adv7511->type =3D=3D ADV7511)
> +               regmap_update_bits(adv7511->regmap, 0xfb,
> +                       0x6, low_refresh_rate << 1);
> +       else
> +               regmap_update_bits(adv7511->regmap, 0x4a,
> +                       0xc, low_refresh_rate << 2);
> +
>         regmap_update_bits(adv7511->regmap, 0x17,
>                 0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
>
> --
> 2.40.1
>
