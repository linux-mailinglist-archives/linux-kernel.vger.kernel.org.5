Return-Path: <linux-kernel+bounces-135100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7489BB28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280ED1F21876
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB04AEE6;
	Mon,  8 Apr 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6CTGSD2"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFC4AED5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567018; cv=none; b=NAlFE4NsgfCgfHgXuJvdG4ELthyCpiJAJneFoNsa+iaHCrFGvfplAKtOJs45zLhH560K3WLq/NK+VdqdtlZ3X+RvVSTuF9F/AlLDlkxa0+ebuSTYofq60xIGju7qm1+FhSVCfGR4yXFCwfC4BiESIOLV/mplYDsOaQ0LtvW6c7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567018; c=relaxed/simple;
	bh=bWMSFVGugZGOnvnLzz03sLUXN4vk0ElaagwLHbjL4es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyTX4ea9qcs3KAB7LVNUccRcr4EVWV1fRy7JuJleJ8ymV7YgvdS/a3lFNdR9haFaoPJdDj//3kaDPvPHfo0TMgJqXMBYLlo5CGkoSNcVnU3/Y+gCB4I0aqlkDD+dgEo2qyvJeamwlk+bva0sDJFFk6MRKtotJFhsekEWKKWfbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g6CTGSD2; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e406cf6263so998575241.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712567014; x=1713171814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IC/HIheh5QVM3Z0m3XyNIldq+Pet/IJYQah2gajnbg=;
        b=g6CTGSD2tryr2n6LIRZ4Iaaisvk8XY5aToMZs+X8mMdPCWdVrjLwZdqvK3E+DVDBTm
         RrNBLDFf4m3J+LRMK9bmqZ+72Fc38kJszgSdGYhmOgj/Zdkudt1b6whc8e/kngyZH/tW
         pOFMvCD+vsDjips2yTk09I3g2XqmE4wUjiWAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567014; x=1713171814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IC/HIheh5QVM3Z0m3XyNIldq+Pet/IJYQah2gajnbg=;
        b=q1h4/8C4Zmfd8aF/QOIlGYAtIRYK8plGaKWu9eCyHACOdzpKrchicg0kcsV4KgBVO0
         vD2FvJYO7F9GhhbERlnJWY9UhrESff3vuNJ3H5sr4rGVtmZdBkS8pKgiKTgLu9tmVB5t
         zUssmv4JFfkfgCWRv9zZyN3+6B0S0xnvTkYUsqRibTdkERPPB/RcxnGhYkmLeRLD6+Ne
         pdmVENcIkeylxUatmyoouDgV3Hl0Nk39ytM4CVjkNy+WgHECFN3OWu/wJBWJUGHOiUWe
         opWz8aAuiMBfE1LwyTA3bvKaTq3GM6m4Wwa5H1xjKbohsAj3b/1rXrkO3eH/c8y+3RjY
         nBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5+IYv4MVmw17G+U4FTG5hHGY6bdCpodMaek+AN5yZ49rtm+7PIgwmEkZBZRHZC9Blarc2e24CI8EppjV0wHOq32Orv3gZJJG5MdEX
X-Gm-Message-State: AOJu0Yyy4lnu/VTyRiprI5o7owSVeQxWpZNRZi1fXw19l144cMMoES31
	YOULQsZd9Rm/oh086fI3YwUMD0KrW3TfaQmv8aO8SZU5xR3Uj8/o7jUDZyT9HlKG7obhXwl7hJ7
	RYQ==
X-Google-Smtp-Source: AGHT+IF6M9eGRGirfExlxrJJBFT8sf/Ct0XlyR2WUbJr2c95/YWO0QDeJlw9enKuGhQw9RDpgNyb0Q==
X-Received: by 2002:a05:6102:ccd:b0:47a:cfd:95e0 with SMTP id g13-20020a0561020ccd00b0047a0cfd95e0mr313298vst.12.1712567013825;
        Mon, 08 Apr 2024 02:03:33 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id p13-20020a0cf54d000000b0069903961336sm3026598qvm.21.2024.04.08.02.03.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:03:33 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43477091797so287411cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:03:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGdEV8E/a0BWnPzHqKmxDHeLx4HPiiyJiDobn+FQEdeHyhMqoJd/IqSlQLyQ24l0YH5UiEzeNJgeRp2kqExpCgyPGEq0vrpoKcJ6xa
X-Received: by 2002:a05:622a:4812:b0:434:7bb9:f231 with SMTP id
 fb18-20020a05622a481200b004347bb9f231mr289728qtb.12.1712567012530; Mon, 08
 Apr 2024 02:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408073623.186489-1-j-choudhary@ti.com>
In-Reply-To: <20240408073623.186489-1-j-choudhary@ti.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Apr 2024 02:03:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V6vUgcPn0zhA+9k4cHVpqqeSVCSJG23XEE5KMAHUCCoQ@mail.gmail.com>
Message-ID: <CAD=FV=V6vUgcPn0zhA+9k4cHVpqqeSVCSJG23XEE5KMAHUCCoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix ti_sn_bridge_set_dsi_rate function
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, mripard@kernel.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, andersson@kernel.org, 
	robdclark@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 8, 2024 at 12:36=E2=80=AFAM Jayesh Choudhary <j-choudhary@ti.co=
m> wrote:
>
> Due to integer calculations, the rounding off can cause errors in the fin=
al
> value propagated in the registers.
> Considering the example of 1080p (very common resolution), the mode->cloc=
k
> is 148500, dsi->lanes =3D 4, and bpp =3D 24, with the previous logic, the=
 DSI
> clock frequency would come as 444 when we are expecting the value 445.5
> which would reflect in SN_DSIA_CLK_FREQ_REG.
> So move the division to be the last operation where rounding off will not
> impact the register value.

Given that this driver is used on a whole pile of shipping Chromebooks
and those devices have been working just fine (with 1080p resolution)
for years, I'm curious how you noticed this. Was it actually causing
real problems for you, or did you notice it just from code inspection?
You should include this information in the commit message.

I'm travelling for the next two weeks so I can't actually check on a
device to see if your patch makes any difference on hardware I have,
but I'd presume that things were working "well enough" with the old
value and they'll still work with the new value?


> Also according to the SN65DSI86 datasheet[0], the minimum value for that
> reg is 0x08 (inclusive) and the maximum value is 0x97 (exclusive). So add
> check for that.

Maybe the range checking should be a separate patch?


> [0]: <https://www.ti.com/lit/gpn/sn65dsi86>
>
> Fixes: ca1b885cbe9e ("drm/bridge: ti-sn65dsi86: Split the setting of the =
dp and dsi rates")

Are you sure that's the commit you're fixing? In the commit text of
that commit I wrote that it was supposed to "have zero functional
change". Looking back at the change I still believe it had zero
functional change. The rounding error looks like it predates the
patch.

As far as I can tell the rounding error has been there since commit
a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver").


> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

It's great to see a TI engineer contributing to this driver! Awesome!


> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 48 +++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 84698a0b27a8..f9cf6b14d85e 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -111,7 +111,14 @@
>  #define  AUX_IRQ_STATUS_AUX_SHORT              BIT(5)
>  #define  AUX_IRQ_STATUS_NAT_I2C_FAIL           BIT(6)
>
> -#define MIN_DSI_CLK_FREQ_MHZ   40
> +/*
> + * NOTE: DSI clock frequency range: [40MHz,755MHz)
> + * DSI clock frequency range is in 5-MHz increments
> + * So minimum frequency 40MHz translates to 0x08
> + * And maximum frequency 755MHz translates to 0x97
> + */
> +#define MIN_DSI_CLK_RANGE      0x8
> +#define MAX_DSI_CLK_RANGE      0x97

It's a little weird to call this min/max and have one be inclusive and
one be exclusive. Be consistent and say that this is the minimum legal
value and the maximum legal value. I think that means the MAX should
be 0x96.


>  /* fudge factor required to account for 8b/10b encoding */
>  #define DP_CLK_FUDGE_NUM       10
> @@ -820,22 +827,37 @@ static void ti_sn_bridge_atomic_disable(struct drm_=
bridge *bridge,
>         regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABL=
E, 0);
>  }
>
> -static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
> +static int ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
>  {
> -       unsigned int bit_rate_mhz, clk_freq_mhz;
> +       unsigned int bit_rate_khz;
>         unsigned int val;
>         struct drm_display_mode *mode =3D
>                 &pdata->bridge.encoder->crtc->state->adjusted_mode;
>
> -       /* set DSIA clk frequency */
> -       bit_rate_mhz =3D (mode->clock / 1000) *
> -                       mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> -       clk_freq_mhz =3D bit_rate_mhz / (pdata->dsi->lanes * 2);
> +       /*
> +        * Set DSIA clk frequency
> +        * Maximum supported value of bit_rate_khz turns out to be
> +        * 6040000 which can be put in 32-bit variable so no overflow
> +        * possible in this calculation.

The way you've written this comment makes me worried. You're saying
that the only supported result of the math has to fit in 32-bits so
we're OK. ...and then _after_ you do the math you check to see if the
clock rate is within the supported range. It makes me feel like you
could still overflow.

I think your comment here should say something like:

The maximum value returned by mipi_dsi_pixel_format_to_bpp() is 24.
That means that as long as "mode->clock" is less than 178,956,971 kHz
then the calculation can't overflow and can fit in 32-bits.

If you wanted to be really good you could even put a check earlier in
the function to make sure that mode->clock wasn't something totally
crazy (could confirm it's < 100GHz maybe?) so you absolutely knew it
couldn't overflow.

> +        */
> +       bit_rate_khz =3D mode->clock *
> +                      mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> +
> +       /*
> +        * For each increment in val, frequency increases by 5MHz
> +        * and the factor of 1000 comes from kHz to MHz conversion
> +        */
> +       val =3D (bit_rate_khz / (pdata->dsi->lanes * 2 * 1000 * 5)) & 0xF=
F;
> +
> +       if (val >=3D MAX_DSI_CLK_RANGE || val < MIN_DSI_CLK_RANGE) {
> +               drm_err(pdata->bridge.dev,
> +                       "DSI clock frequency not in the supported range\n=
");
> +               return -EINVAL;
> +       }

Shouldn't the above be in atomic_check()? There's a reason why
atomic_enable() can't return error codes.

-Doug

