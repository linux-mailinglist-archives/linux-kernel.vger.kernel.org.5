Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91D7ACA12
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjIXOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIXOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62FF109;
        Sun, 24 Sep 2023 07:40:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF95C433CC;
        Sun, 24 Sep 2023 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695566422;
        bh=9GRsckWSSu1mlk9vmJKy9J27I3v7LoT+WjbT3ntqne0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gCcVsK/CkNAlyMVqWnN4VPt1kzjPoqNo5oo6alEewEruR12Pzpino4CvWoSEgGcO9
         /Rr00Y0Eua09CO0vZ47JpQ4ZfAewqtiIQGn/ievdlfg+l9gA/P2JsZHOpSKtYjcmOi
         Z2VSOmKGDykY20pTAlF+gU2khzpEQXGzvE14e7FGIPHLrPivhJKHpyhKUxNoN90hAI
         o+ys+PbAVXHqOPxaoUULYRreT4jz+eKeyLE6ta0PKw+hQjdRkLKw2FRyl60crpglhM
         ds1KF+m+Nz2BsZ8sDZPAq6SCGYEYWmhz3fQP7DoMYDeD7lQboBTJQR0YEZi4kMkgrs
         pkb6lmrpQ3Izg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5033918c09eso7526031e87.2;
        Sun, 24 Sep 2023 07:40:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLnoMAmopexRUOZxnLEl7ux2pgmQjwEc0QZxb3bfEg5sRXUJt3
        ytSVItkaumOpWYkaf6XaCBCzgfeJbjoUsktWzQ==
X-Google-Smtp-Source: AGHT+IHgb7dlF3spUK7WjEovMRqe4TqCew31OFnTTbuiTomARpVLNlO+VuNaMI73R08m9JXOZ3UuaIZrHQ9jk6PBkA0=
X-Received: by 2002:ac2:5f97:0:b0:503:200f:47a9 with SMTP id
 r23-20020ac25f97000000b00503200f47a9mr3453499lfe.15.1695566420722; Sun, 24
 Sep 2023 07:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131058.2472260-1-jani.nikula@intel.com>
In-Reply-To: <20230914131058.2472260-1-jani.nikula@intel.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 24 Sep 2023 22:40:04 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Vn9eN+OjSWjo=WTrSasJs6h_N93PQgVAUU-NDeQ438Q@mail.gmail.com>
Message-ID: <CAAOTY_-Vn9eN+OjSWjo=WTrSasJs6h_N93PQgVAUU-NDeQ438Q@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 error path
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jani:

Jani Nikula <jani.nikula@intel.com> =E6=96=BC 2023=E5=B9=B49=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Setting new_edid to NULL leaks the buffer.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort drive=
r")
> Cc: Markus Schneider-Pargmann <msp@baylibre.com>
> Cc: Guillaume Ranquet <granquet@baylibre.com>
> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> ---
>
> UNTESTED
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 2cb47f663756..8fc6eff68e30 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2049,6 +2049,7 @@ static struct edid *mtk_dp_get_edid(struct drm_brid=
ge *bridge,
>          */
>         if (mtk_dp_parse_capabilities(mtk_dp)) {
>                 drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
> +               kfree(new_edid);
>                 new_edid =3D NULL;
>         }
>
> --
> 2.39.2
>
