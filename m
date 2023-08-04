Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868C76F87B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjHDDsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDDsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:48:04 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35103AA4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:48:02 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-799a451ca9cso573569241.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691120882; x=1691725682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+t/HonaVoWzmjCN2vKrohh+X2mnS21wD/73jjSfFPw=;
        b=gPMS9kXOSEC57SZyWO9OqYOW2W0WoScwyiKZG6BkS5Og7VultoRaKpQkIjocn9ViIK
         opTgk1IvCoNb+JLQAqWDkcQqLR6au611KWn1V63n6ZegVBL26YsDAyFIal6atsQ7FIc/
         u5eEDUR0Rg+Vg7VBYIVnLrqrcFcpcz1Y2N/gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691120882; x=1691725682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+t/HonaVoWzmjCN2vKrohh+X2mnS21wD/73jjSfFPw=;
        b=A2IX9F5hOLpkNUGAAFGtGT1faO2H87QHf+rwPp15BYKOU9o8o3OmpqY3Ucj5E1Vjob
         l35zB46l1wJs5zCkKYTa5I6i6VAaRovHlVw+gzr5LvBBCoHPyw5FmdvpmxaawsAvfMNQ
         ljdznlsz+kvxmBehGkPEb1KH0vFAdqY/hSa6f0b1BfP5JuD2FIuNwMksC1ks4APyLQdT
         KNnl8kapR8pLkZ6+V4AAI3oWnQhWdsaWDO8hDV3y3qPTfjHysh3O1JvGdTmpN+SyTvcc
         Cz4oYNMdSDdG5Z91j1pKVATeLk8SmKUu4ZLuJBSn/jkOlDriw77D3VRALIiixEesCXJJ
         XooQ==
X-Gm-Message-State: AOJu0YyAwkunK2KZeUndqoWR4qbAKdUdrQEvmR3kfxCkomXBUjDrQt4m
        e+dmamYlZjfxta7uwlrYo5B7f3V258QTGtq06ndvHQ==
X-Google-Smtp-Source: AGHT+IE0JrneMuDwCDfIF7LG9FYsde1kPnC7QcFEApmoZ63I9xCwDh3ekdDL3ZnP/i4RkyjMLJAwzYsJDtB0/2+uWEY=
X-Received: by 2002:a1f:c14b:0:b0:481:4b85:4298 with SMTP id
 r72-20020a1fc14b000000b004814b854298mr353450vkf.1.1691120881803; Thu, 03 Aug
 2023 20:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230803074249.3065586-1-wenst@chromium.org> <20230803074249.3065586-4-wenst@chromium.org>
 <aa8f232f-701a-5b4c-eda8-89fc0e6fe5a8@collabora.com>
In-Reply-To: <aa8f232f-701a-5b4c-eda8-89fc0e6fe5a8@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 4 Aug 2023 11:47:50 +0800
Message-ID: <CAGXv+5EAR9Q5gGzkw=5UEEMOHbp56oKD5m_FyiHfZ3em8QwVAQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: mt6397: Split MediaTek MT6366 PMIC out of MT6358
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:01=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 03/08/23 09:42, Chen-Yu Tsai ha scritto:
> > The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It ha=
s
> > a different set of regulators. Specifically, it lacks the camera relate=
d
> > VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
> >
> > Add a separate compatible for the MT6366 PMIC. The regulator cell for
> > this new entry uses a new compatible string matching MT6366.
> >
> > Fixes: c47383f84909 ("mfd: Add support for the MediaTek MT6366 PMIC")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> I agree in that the LDOs are a bit different, but that's handled by the
> mt6358-regulator driver regardless of the actual devicetree compatible,
> as that's selected through a chip_id check.
>
> Finally, looking at the driver implementation itself, the addition of a
> specific mt6366 compatible here seems redundant, because the actual HW is
>   - Handled by drivers, but
>   - Described by bindings
>
> Any other opinions on this?

Well, on the bindings side, we can't have MT6366 fall back to MT6358,
neither for the whole PMIC nor just for the regulators. For the latter
it's because neither is a subset of the other, which a) makes them not
fallback compatible as required by the spirit of fallback compatibles,
and b) cannot be described with a fallback compatible, as the fallback
one will have properties/nodes that are not valid for the other, and
vice versa.

Without a fallback compatible to lean in for the regulator driver, we
will need to split out the compatible at the mfd level as well. AFAIU
the mfd core matches mfd-cells based on the compatible strings it is
given in the driver.

ChenYu

> Regards,
> Angelo
>
> > ---
> >   drivers/mfd/mt6397-core.c | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index f6c1f80f94a4..3f8dfe60a59b 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -206,6 +206,26 @@ static const struct mfd_cell mt6359_devs[] =3D {
> >       },
> >   };
> >
> > +static const struct mfd_cell mt6366_devs[] =3D {
> > +     {
> > +             .name =3D "mt6358-regulator",
> > +             .of_compatible =3D "mediatek,mt6366-regulator"
> > +     }, {
> > +             .name =3D "mt6358-rtc",
> > +             .num_resources =3D ARRAY_SIZE(mt6358_rtc_resources),
> > +             .resources =3D mt6358_rtc_resources,
> > +             .of_compatible =3D "mediatek,mt6358-rtc",
> > +     }, {
> > +             .name =3D "mt6358-sound",
> > +             .of_compatible =3D "mediatek,mt6358-sound"
> > +     }, {
> > +             .name =3D "mt6358-keys",
> > +             .num_resources =3D ARRAY_SIZE(mt6358_keys_resources),
> > +             .resources =3D mt6358_keys_resources,
> > +             .of_compatible =3D "mediatek,mt6358-keys"
> > +     },
> > +};
> > +
> >   static const struct mfd_cell mt6397_devs[] =3D {
> >       {
> >               .name =3D "mt6397-rtc",
> > @@ -280,6 +300,14 @@ static const struct chip_data mt6359_core =3D {
> >       .irq_init =3D mt6358_irq_init,
> >   };
> >
> > +static const struct chip_data mt6366_core =3D {
> > +     .cid_addr =3D MT6358_SWCID,
> > +     .cid_shift =3D 8,
> > +     .cells =3D mt6366_devs,
> > +     .cell_size =3D ARRAY_SIZE(mt6366_devs),
> > +     .irq_init =3D mt6358_irq_init,
> > +};
> > +
> >   static const struct chip_data mt6397_core =3D {
> >       .cid_addr =3D MT6397_CID,
> >       .cid_shift =3D 0,
> > @@ -358,6 +386,9 @@ static const struct of_device_id mt6397_of_match[] =
=3D {
> >       }, {
> >               .compatible =3D "mediatek,mt6359",
> >               .data =3D &mt6359_core,
> > +     }, {
> > +             .compatible =3D "mediatek,mt6366",
> > +             .data =3D &mt6366_core,
> >       }, {
> >               .compatible =3D "mediatek,mt6397",
> >               .data =3D &mt6397_core,
>
>
