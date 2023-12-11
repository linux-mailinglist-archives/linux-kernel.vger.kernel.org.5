Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2580C046
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjLKEID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjLKEIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:08:01 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC77F2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:08:08 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4b2d64a368aso2252151e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702267687; x=1702872487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTd+fEPmXY/+K0C4daC2dwAWjvpJ1oG4S1yMkL+8DtM=;
        b=a5tiSCGGJSQi6zYoydG/chv1IUM2PKow30jCOQPBid5mux2cJydGqc0dYHYeWGfzGE
         fQV7OCCBzjOVxPhY2Cx1h6uckZl2QANYkvwUmcMoWu2s9yuGaxTnL1U10u2x5J/sBB5E
         POhd2SLaZClsqe0w/P3hYumcQZD2sGBPvy/XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702267687; x=1702872487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTd+fEPmXY/+K0C4daC2dwAWjvpJ1oG4S1yMkL+8DtM=;
        b=wBXrEse2dTBRoxb3lALUiAuc4TGeSizWGz/OmuQ2rpAqttFn1E4A7wXOrvSwgB+tQQ
         /dkYcqE2bwoFRsaUnqszJnh1yk8CrtMnbQPgC6rS/tmyan7xkruCMAwsb0nGhOABEIkB
         nzqKj2O150+c+Fq9l/B1Wl/QBO6Oym92CnUFtFty/eZNuhjpS2K27WG021eZ6i5uH0Xx
         kw6jrxy/g/Zx3jHXXkQ71OBZs8UcCwpLiGx358zbrNYjd71R97qBZdsTMFxuN0UNAmOF
         TVRb4H5tvM5cDJYsI5DujuqW/woVS9WnuV4hqHHDJ7PH5c0LRNrmlVQxCUDS/R/L8hhY
         YCBw==
X-Gm-Message-State: AOJu0YyVAbuptwbru0eFBZz9d4BdPRQsDtjaVzmUPx771lOK7GASj868
        dYK9Se/NSu/969EwfjXlTG5cgxArQGvkaHuGKjM=
X-Google-Smtp-Source: AGHT+IHhYyV3ArFO2os00f6Lew6B/Yr5kg6GGUzqIOJL8VZWWNjt4d4LBnKp/F6BltcdebSEUngcLQ==
X-Received: by 2002:a1f:ee89:0:b0:4b2:c554:ccfd with SMTP id m131-20020a1fee89000000b004b2c554ccfdmr2528721vkh.9.1702267687039;
        Sun, 10 Dec 2023 20:08:07 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id o189-20020a1f73c6000000b004b2bf0a3e95sm885948vkc.31.2023.12.10.20.08.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 20:08:06 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b2d64a368aso2252134e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:08:05 -0800 (PST)
X-Received: by 2002:a05:6102:5114:b0:464:3f78:3cbe with SMTP id
 bm20-20020a056102511400b004643f783cbemr2701028vsb.4.1702267684761; Sun, 10
 Dec 2023 20:08:04 -0800 (PST)
MIME-Version: 1.0
References: <98491ec78ab671f5a14fce42d10f9745ebddb112.1702258360.git.daniel@makrotopia.org>
In-Reply-To: <98491ec78ab671f5a14fce42d10f9745ebddb112.1702258360.git.daniel@makrotopia.org>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 11 Dec 2023 12:07:27 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh6twyqoSgeEXDsW=+FZRUxMN=Pkrw45KFq-z5XaGpFtw@mail.gmail.com>
Message-ID: <CAC=S1nh6twyqoSgeEXDsW=+FZRUxMN=Pkrw45KFq-z5XaGpFtw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt7986: silence error in case of -EPROBE_DEFER
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maso Huang <maso.huang@mediatek.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Dec 11, 2023 at 9:33=E2=80=AFAM Daniel Golle <daniel@makrotopia.org=
> wrote:
>
> If probe is defered no error should be printed. Mute it.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  sound/soc/mediatek/mt7986/mt7986-wm8960.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/mediatek/mt7986/mt7986-wm8960.c b/sound/soc/mediat=
ek/mt7986/mt7986-wm8960.c
> index c1390b3734101..24a4b943030d7 100644
> --- a/sound/soc/mediatek/mt7986/mt7986-wm8960.c
> +++ b/sound/soc/mediatek/mt7986/mt7986-wm8960.c
> @@ -144,7 +144,9 @@ static int mt7986_wm8960_machine_probe(struct platfor=
m_device *pdev)
>
>         ret =3D devm_snd_soc_register_card(&pdev->dev, card);
>         if (ret) {
> -               dev_err(&pdev->dev, "%s snd_soc_register_card fail: %d\n"=
, __func__, ret);
> +               if (ret !=3D -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "%s snd_soc_register_card fai=
l: %d\n", __func__, ret);
> +
Please consider using dev_err_probe() instead.

Regards,
Fei

>                 goto err_of_node_put;
>         }

>
> --
> 2.43.0
>
>
