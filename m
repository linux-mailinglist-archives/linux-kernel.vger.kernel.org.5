Return-Path: <linux-kernel+bounces-86089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477AC86BF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B421F25122
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927A374F5;
	Thu, 29 Feb 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a8l7mT89"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6737705
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177023; cv=none; b=UN2XQIbRq40Tv9z+SwF9Qpyle83ReXzIOhotCDKnc+2+3SvcOXDUwTLMByPXh+H/gIz/VJggwXFVz/PkGLqfC7Wj8SN6vc9qIZXRhw+HRhfWe+oRDOwQPl+s/SY5mMMQnO6/ci/4vmG9wad8nNOltupFFv3FE4LY+icp9+1I1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177023; c=relaxed/simple;
	bh=xk46Jj9RTgh6RKQqAdSGUAO0/eL7vnDByFfZswoFJd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXo94ClICOvHkxSFzYyaqUArNWmmsr8I82S0L6Xfp1CXHnsi+A1FIWvZt8piDHdOPXiMtb1LPLJn7VyKiQgd4jyASU7HeglaDXOlx20JI5SuISknnFuLLIrTDDZmWDU7tfYjc6PmVXPUfHD1jH2d891RpiaXMEPdSeNCqGaKZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a8l7mT89; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51320536bddso330091e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709177019; x=1709781819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnhjCqHLFxHzCoP56tcAkpXqMN7ULXn2w3/bj8hdCI8=;
        b=a8l7mT89P+l06KxPgW8Bb9RmGL5GpI5Cmgu7NP3gnh6HeJUcgQtWu9mCrn+MQ85WAq
         9Z3TdvuBb3eJzztkioph4ATeVoQnzTsECKMlz1LVDOKEojOMhZhkAc7o0LyQVcSxsYpB
         hpfNJb6omIwdAUQHfYChFyRZW4l3A5JafvRjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709177019; x=1709781819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnhjCqHLFxHzCoP56tcAkpXqMN7ULXn2w3/bj8hdCI8=;
        b=exbe5npzFUwlD0u5Fwfgt+Lwxq+WobdeM4Vml+6m94/tIDVQW2u8Vr02RhlBQZ3Zrm
         5BWHkCzswXvdPyyGgWTz67QF0ETkpeApfeD7yxbsLvsr9OP0+6Ky2Ce7zJXkjoHUCAwD
         hnY1LTCMxDRXrp/US1GIOYaUiaytdn0c2uvUJt62iAO5RshGg0friS709GhU06rW7p0m
         ICe2OIvdokN0q7nnpXW9L8ytb6rdXk+3Uo7TS9Q+NovD1uSX3owJirUz96W9j1zh0b3z
         iBqxwt4zPTTKgMxhlRxPi895CfnTW41KWjS55EPyaZXlqc5J+w65JsL/YynDMC1eOvVy
         aHGw==
X-Forwarded-Encrypted: i=1; AJvYcCWy+GEEIim7JLAJnChY3tYQDeWgIyPglpNjglaVqMLe2wJPrV4ayrp06j4jdbetocSfvA4O2y177bnY30YwXWbli4QH7zJenFMMitfd
X-Gm-Message-State: AOJu0YyP8wchPHMS3gpTH8IfKMpUPIGgSG6M3Rq3h+KKESwDNK7Zb/K/
	3P7/p+WCpQql1nmqueXAUEb/kvrhnQ509ojf96B1LPNlqb29/xMIjerIHtY/9dB2ghHbqNtwYjh
	fh0eTCXG/8qlZs+I+6xBH2OlbbdUIr0V600cE
X-Google-Smtp-Source: AGHT+IGoyjlA5d3MJxIU0XjajX2pLjnv5bjpGNpsYoZpp5aPB53ISOzz1U7B/7xmRxLHgmDVXHiCd+RpSMsLvGtFTsY=
X-Received: by 2002:a05:6512:3d04:b0:513:25b9:6cf8 with SMTP id
 d4-20020a0565123d0400b0051325b96cf8mr294868lfv.19.1709177019347; Wed, 28 Feb
 2024 19:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com> <20240227120939.290143-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240227120939.290143-2-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 29 Feb 2024 11:23:28 +0800
Message-ID: <CAGXv+5Edk5tCmE87DCOjVmMsiMcKeRw50=mx8=z1ZacJYd6L1Q@mail.gmail.com>
Subject: Re: [PATCH 01/22] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, 
	trevor.wu@mediatek.com, maso.huang@mediatek.com, 
	xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de, 
	kuninori.morimoto.gx@renesas.com, shraash@google.com, amergnat@baylibre.com, 
	nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de, 
	dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com, 
	eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev, 
	jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com, 
	ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com, 
	nfraprado@collabora.com, alsa-devel@alsa-project.org, 
	shane.chien@mediatek.com, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:10=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Switch from pm_runtime_enable() to devm_pm_runtime_enable(), allowing
> to remove all gotos from the probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

This also fixes the unwinding order during driver unbinding.


> ---
>  sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 46 ++++++++--------------
>  1 file changed, 17 insertions(+), 29 deletions(-)
>
> diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/media=
tek/mt8192/mt8192-afe-pcm.c
> index bdd1e91824d9..794419d16b01 100644
> --- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
> @@ -2217,21 +2217,20 @@ static int mt8192_afe_pcm_dev_probe(struct platfo=
rm_device *pdev)
>                 return ret;
>         }
>
> -       pm_runtime_enable(&pdev->dev);
> -       if (!pm_runtime_enabled(&pdev->dev))
> -               goto err_pm_disable;
> +       ret =3D devm_pm_runtime_enable(&pdev->dev);
> +       if (ret)
> +               return ret;
>
>         /* regmap init */
>         afe->regmap =3D syscon_node_to_regmap(dev->parent->of_node);
>         if (IS_ERR(afe->regmap)) {
>                 dev_err(dev, "could not get regmap from parent\n");
> -               ret =3D PTR_ERR(afe->regmap);
> -               goto err_pm_disable;
> +               return PTR_ERR(afe->regmap);
>         }
>         ret =3D regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_co=
nfig);
>         if (ret) {
>                 dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
> -               goto err_pm_disable;
> +               return ret;
>         }
>
>         /* enable clock for regcache get default value from hw */
> @@ -2241,7 +2240,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform=
_device *pdev)
>         ret =3D regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_confi=
g);
>         if (ret) {
>                 dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
> -               goto err_pm_disable;
> +               return ret;
>         }
>
>         pm_runtime_put_sync(&pdev->dev);
> @@ -2254,10 +2253,8 @@ static int mt8192_afe_pcm_dev_probe(struct platfor=
m_device *pdev)
>         afe->memif_size =3D MT8192_MEMIF_NUM;
>         afe->memif =3D devm_kcalloc(dev, afe->memif_size, sizeof(*afe->me=
mif),
>                                   GFP_KERNEL);
> -       if (!afe->memif) {
> -               ret =3D -ENOMEM;
> -               goto err_pm_disable;
> -       }
> +       if (!afe->memif)
> +               return -ENOMEM;
>
>         for (i =3D 0; i < afe->memif_size; i++) {
>                 afe->memif[i].data =3D &memif_data[i];
> @@ -2271,26 +2268,22 @@ static int mt8192_afe_pcm_dev_probe(struct platfo=
rm_device *pdev)
>         afe->irqs_size =3D MT8192_IRQ_NUM;
>         afe->irqs =3D devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs=
),
>                                  GFP_KERNEL);
> -       if (!afe->irqs) {
> -               ret =3D -ENOMEM;
> -               goto err_pm_disable;
> -       }
> +       if (!afe->irqs)
> +               return -ENOMEM;
>
>         for (i =3D 0; i < afe->irqs_size; i++)
>                 afe->irqs[i].irq_data =3D &irq_data[i];
>
>         /* request irq */
>         irq_id =3D platform_get_irq(pdev, 0);
> -       if (irq_id < 0) {
> -               ret =3D irq_id;
> -               goto err_pm_disable;
> -       }
> +       if (irq_id < 0)
> +               return irq_id;
>
>         ret =3D devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
>                                IRQF_TRIGGER_NONE, "asys-isr", (void *)afe=
);
>         if (ret) {
>                 dev_err(dev, "could not request_irq for Afe_ISR_Handle\n"=
);
> -               goto err_pm_disable;
> +               return ret;
>         }
>
>         /* init sub_dais */
> @@ -2301,7 +2294,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform=
_device *pdev)
>                 if (ret) {
>                         dev_warn(afe->dev, "dai register i %d fail, ret %=
d\n",
>                                  i, ret);
> -                       goto err_pm_disable;
> +                       return ret;
>                 }
>         }
>
> @@ -2310,7 +2303,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform=
_device *pdev)
>         if (ret) {
>                 dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\=
n",
>                          ret);
> -               goto err_pm_disable;
> +               return ret;
>         }
>
>         /* others */
> @@ -2329,7 +2322,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform=
_device *pdev)
>                                               &mt8192_afe_component, NULL=
, 0);
>         if (ret) {
>                 dev_warn(dev, "err_platform\n");
> -               goto err_pm_disable;
> +               return ret;
>         }
>
>         ret =3D devm_snd_soc_register_component(&pdev->dev,
> @@ -2338,15 +2331,10 @@ static int mt8192_afe_pcm_dev_probe(struct platfo=
rm_device *pdev)
>                                               afe->num_dai_drivers);
>         if (ret) {
>                 dev_warn(dev, "err_dai_component\n");
> -               goto err_pm_disable;
> +               return ret;
>         }
>
>         return 0;
> -
> -err_pm_disable:
> -       pm_runtime_disable(&pdev->dev);
> -
> -       return ret;
>  }
>
>  static void mt8192_afe_pcm_dev_remove(struct platform_device *pdev)
> --
> 2.44.0
>

