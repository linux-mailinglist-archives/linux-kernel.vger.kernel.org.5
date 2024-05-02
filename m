Return-Path: <linux-kernel+bounces-166266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8568B9848
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29801C2124E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68958AA5;
	Thu,  2 May 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PCnEpblM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08956773
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643982; cv=none; b=u6E+B5cWwWWrif3LxB9s5+e5sPN0t1X4wtOnaRua+6bgsDOLyPwFhpLVz0oDmeWtuGZ+uMShDFFx0QAkYvA7E/wC56vicjuuTVaeVJXBTB6izkLuUdxofhHPqcV3OC1XvAJ9NnOZfCsRH3wza3Iq6FvxKpvetqIRcT50vvEvGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643982; c=relaxed/simple;
	bh=0VwrMUO3X+y6UpEoWe11LsUQtiTXlZrdy2wyBSrCHUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npVQA6HuukRtpNa2HZPfTWNlbwez7VLfI88mEfSfTtTm/Lz76r5rgy4hbSUReON99dVsPIT3buPnnhj8MPB7vXzEct+I0Gb7S1qDZyBTodwKOM4tqJkjFduq3QU6t6NMaP+Xi7WbOTOcw+QmnyuOoRLTaMPVcLr0eZLjkO2V2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PCnEpblM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so9343719e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714643979; x=1715248779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAWzFtfBZwMQoHv84/W+JImIB5vAq9WxgZXxmYPg6EU=;
        b=PCnEpblMIvnfYoI0CBfMTAacBznA4ZpfckEWfCi/HFn8+IqJAFj8dZGlrFi4bt6m/1
         0lB9E3F0FN8eII3mGwxBfPsHsN7vXZvn9vz2kpc/xQScgMN2bdINWP9up0EZTvh0Iejg
         +idOA/bY83LCw4EIkIPPZM9BKJ97hY1zBbC78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643979; x=1715248779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAWzFtfBZwMQoHv84/W+JImIB5vAq9WxgZXxmYPg6EU=;
        b=Sp0h3AC7fkFY4SvWATEY74ka0Vcz+WCwCNHnWMGA04B/uUuAJog9mMnGL9FwP8wGKQ
         nvLaJGyGk6dJgREA9amlUsj0Lo9unAAWXA4+s8+SAWIpATCIhIoR4pSTH7c3u55A87a8
         4UFuaC1vEKgGlFaLTe2B0iAMvlPaT4bAOOUiG38wvHcHw8Z1rL+WWss8BOTdG732l7w7
         uxEWLSkuEAgMR5mAU/RpWKnEuuOSIzW/MRNWhvmxe4T41tUplclm37NDGwKw2asDXfcI
         +lsTG2KarAOd/2CrMvGxpi3trmL/iMow12k3duRuKHoqMCdpvnrjVdtMhDh/QLLpkZ55
         GWyg==
X-Forwarded-Encrypted: i=1; AJvYcCW01LiDzzeeg2tXU3xnfEh6VW/8KdcgKKvHGChfZzatyaF85NFGFffe+FuXf15liH0cQVS7Kz581T7JOraNSHi4vTMlnA3jNB6AJvlP
X-Gm-Message-State: AOJu0Ywsms8MTQnCyKQ4M0xebyq+d4AsrbeYxNKiRhL0dYAqAKUrXbKl
	/8Qf3B6AGj5V/M2bTPxK8XV0CCkat/sfDGdgTOaMwFUIDesCYux2E5VHts9yqpzmJNMLU/Emw9Z
	cXUGMLkHEWNuuuLNLqnll/3BVDHcr/EKCCTMS
X-Google-Smtp-Source: AGHT+IEGkMy9wnAsRv/sjRzs/mP6zDLzjdxZZenS550ahLeLjpaIxqNlXTywDzD62yFQysa3FGIxwKwuDOr1BNgiH+Q=
X-Received: by 2002:a05:6512:3c87:b0:51c:cd8d:2865 with SMTP id
 h7-20020a0565123c8700b0051ccd8d2865mr4075910lfv.44.1714643978564; Thu, 02 May
 2024 02:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com> <20240416071410.75620-19-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240416071410.75620-19-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 2 May 2024 17:59:27 +0800
Message-ID: <CAGXv+5GddLeYr-CZBFUcpUMR_NV0=0fu6Qp71hvKO6tJdJjF6w@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] arm64: dts: mediatek: mt8186-corsola: Specify
 sound DAI links and routing
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

On Tue, Apr 16, 2024 at 3:15=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The drivers and bindings acquired support for specifying audio hardware
> and links in device tree: describe and link the sound related HW of this
> machine.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../boot/dts/mediatek/mt8186-corsola.dtsi     | 42 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8186-corsola.dtsi
> index 1807e9d6cb0e..afdab5724eaa 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -42,7 +42,7 @@ backlight_lcd0: backlight-lcd0 {
>                 default-brightness-level =3D <576>;
>         };
>
> -       bt-sco-codec {
> +       bt-sco {

I remember changing this node from "bt-sco" to "bt-sco-codec" because
of a review comment when I submitted the Corsola dts series.

>                 compatible =3D "linux,bt-sco";
>                 #sound-dai-cells =3D <0>;
>         };
> @@ -223,12 +223,44 @@ sound: sound {
>                 mediatek,adsp =3D <&adsp>;
>                 mediatek,platform =3D <&afe>;
>
> -               playback-codecs {
> -                       sound-dai =3D <&it6505dptx>, <&rt1019p>;
> +               audio-routing =3D
> +                       "Headphone", "HPOL",
> +                       "Headphone", "HPOR",
> +                       "IN1P", "Headset Mic",
> +                       "Speakers", "Speaker",
> +                       "HDMI1", "TX";
> +
> +               hs-playback-dai-link {
> +                       link-name =3D "I2S0";
> +                       dai-format =3D "i2s";
> +                       mediatek,clk-provider =3D "cpu";
> +                       codec {
> +                               sound-dai =3D <&rt5682s 0>;
> +                       };
> +               };
> +
> +               hs-capture-dai-link {
> +                       link-name =3D "I2S1";
> +                       dai-format =3D "i2s";
> +                       mediatek,clk-provider =3D "cpu";
> +                       codec {
> +                               sound-dai =3D <&rt5682s 0>;
> +                       };
>                 };
>
> -               headset-codec {
> -                       sound-dai =3D <&rt5682s 0>;
> +               spk-share-dai-link {
> +                       link-name =3D "I2S2";
> +                       mediatek,clk-provider =3D "cpu";
> +               };
> +
> +               spk-hdmi-playback-dai-link {
> +                       link-name =3D "I2S3";
> +                       dai-format =3D "i2s";
> +                       mediatek,clk-provider =3D "cpu";
> +                       /* RT1019P and IT6505 connected to the same I2S l=
ine */
> +                       codec {
> +                               sound-dai =3D <&it6505dptx>, <&rt1019p>;
> +                       };
>                 };
>         };
>
> --
> 2.44.0
>

