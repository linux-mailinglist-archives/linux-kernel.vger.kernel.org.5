Return-Path: <linux-kernel+bounces-146642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E38A68B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62155B2101D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D36128378;
	Tue, 16 Apr 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bszwTc6D"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728FE6BB30
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264015; cv=none; b=pp1SN/02NtI7YmBUemmWlCNc5nfTU2gJm/QJ/8XPCdMP5HyNvrSwsYHD8bqfqIPFOj09q/bdoEhczlY+Id0zrB/a6UCRoB4BUznoPArrshyyPyTmBK+/+A8Dvvk8gtaN9NSS36JqFAYTY2Ro3Ye1scnNTTjip75B6NAzS/nwawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264015; c=relaxed/simple;
	bh=JeEpQglRVkCPotl8Biax9CF54rtqlydCuXYo3Z4B5/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFz/1Zd60TEZ+HSBvVMrMjvyqcwTrwRPE8jmh9xqNGcyDSpAaD5lK8U8lyzU4aYZVV46MIWkjtmEe/Fv89vXIMsJ4y2x2NCaokJJaaoYYSoC9TKKwmpDgzykrFg+L1qMFK8HrHeu+1zxe8+qwifjTNXzNPi3dxrziatkhw/4C7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bszwTc6D; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a523524e5baso503353566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713264012; x=1713868812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHTLqtmJofb3OW9dwP60b9IkbybIqw6tzFbVJdsjmeU=;
        b=bszwTc6Dwkmhu5N8+Y+bSR9RqV79yolSHX4piEBvFNNs53Q/4KX7vlgKJswWqomNh7
         h0dGFClxwmkbVE2CoFcgW5YaW8XpNKhELMYvQPOMxiSI6JWs5TZ9dUWx5VqdEnT52day
         /kEce4nsL8s7pCN/7VoZSl3CsCg1qYRZR1pWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264012; x=1713868812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHTLqtmJofb3OW9dwP60b9IkbybIqw6tzFbVJdsjmeU=;
        b=gcRkuNdiApgfxXdlWoNZvquzeCiEF7qoaX6LJDGIGx+P3V7upEe/2/HLN089NkAVoy
         jOlVbGIx4VrgHWqhChhn0gVs0fZ4iGssUU1+q79tHg6ssxtSHMKPH4Uk+oMXLgdOIgCp
         uSoLp2sB8rGaQt+tcB8fIM1BacHrjK7Y8zK5P/9T+XyM55Mf12lNyaRPiTfIMAqljb1v
         iipjOX44OWbYZeQGWHpn8LdXEHYrIwnRZ7ibn0s98Ywv866in/0zpBEi0dyYW7zCJBYC
         tCNJ8MebIAL0Nto9yjsN6wHXqd8ztMyVYNDSbixLoYpWMOsytzF1ewY9zpHF9v6Ym85Q
         BPjA==
X-Forwarded-Encrypted: i=1; AJvYcCVmeyXS7qEwIUn6UikGfWYdD336XdfXA4T6edZU/+p3/QY6JlADvD4Eu1pJ6dmHIPN1w+738/eIcl3caAKXCLeFm0nUbPvLReVtQkO8
X-Gm-Message-State: AOJu0YyqewKFFB+rByJT67ixM1N/vgWywcleszCf2qOIltUe0bBZbtu2
	U/nMH1gjfEh5+Lr4XJ5wlim3qVmmftCGNceTKHwUFEZouEieT2IBJg3bPAZi9OLPGxm3UzVJyk7
	nLtyT
X-Google-Smtp-Source: AGHT+IEr1nYlx7oGjMj7K01JN6JOzbx7dfTfxUoWJaXy49jMi7A3cTpC/zWZcqdnLzLGleQKiB4O5Q==
X-Received: by 2002:a17:906:abce:b0:a53:ed1b:f3ba with SMTP id kq14-20020a170906abce00b00a53ed1bf3bamr3293506ejb.28.1713264011649;
        Tue, 16 Apr 2024 03:40:11 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id q5-20020a170906360500b00a51da296f66sm6623065ejb.41.2024.04.16.03.40.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 03:40:11 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41551639550so26220375e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:40:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUT0MO3BezcxxQtsS1+RfJPT6mKCqARRGPaUOhjlSke4fGK26iJZSwF7ptkj2sMz2XW7t3bVIuN7g/mdyAAnMkaFNxZe5N/Xs4nEkP4
X-Received: by 2002:a05:6512:114b:b0:518:d5c4:b47f with SMTP id
 m11-20020a056512114b00b00518d5c4b47fmr7177225lfg.13.1713263990804; Tue, 16
 Apr 2024 03:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-23-477afb23728b@chromium.org> <97f51ae8-6672-4bd4-b55b-f02114e3d8d0@moroto.mountain>
In-Reply-To: <97f51ae8-6672-4bd4-b55b-f02114e3d8d0@moroto.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 16 Apr 2024 12:39:33 +0200
X-Gmail-Original-Message-ID: <CANiDSCvp9gBo6Oh31GghvcHmgBY1cYqq4uM_njFTTvQOcS1mbw@mail.gmail.com>
Message-ID: <CANiDSCvp9gBo6Oh31GghvcHmgBY1cYqq4uM_njFTTvQOcS1mbw@mail.gmail.com>
Subject: Re: [PATCH 23/35] media: dvb-frontends: tda10048: Use the right div
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hugues Fruchet <hugues.fruchet@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Osipenko <digetx@gmail.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

What about going the safe way?

--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -341,7 +341,7 @@ static int tda10048_set_wref(struct dvb_frontend
*fe, u32 sample_freq_hz,
        /* t *= 2147483648 on 32bit platforms */
        t *= (2048 * 1024);
        t *= 1024;
-       z = 7 * sample_freq_hz;
+       z = (u64)7 * sample_freq_hz;
        t = div64_u64(t, z) + 5;
        do_div(t, 10);

@@ -409,6 +409,7 @@ static int tda10048_set_if(struct dvb_frontend *fe, u32 bw)
        struct tda10048_config *config = &state->config;
        int i;
        u32 if_freq_khz;
+       u64 sample_freq;

        dprintk(1, "%s(bw = %d)\n", __func__, bw);

@@ -450,9 +451,10 @@ static int tda10048_set_if(struct dvb_frontend *fe, u32 bw)
        dprintk(1, "- pll_pfactor = %d\n", state->pll_pfactor);

        /* Calculate the sample frequency */
-       state->sample_freq = state->xtal_hz * (state->pll_mfactor + 45);
-       state->sample_freq /= (state->pll_nfactor + 1);
-       state->sample_freq /= (state->pll_pfactor + 4);
+       sample_freq = (u64)state->xtal_hz * (state->pll_mfactor + 45);
+       do_div(sample_freq, state->pll_nfactor + 1);
+       do_div(sample_freq, state->pll_pfactor + 4);
+       state->sample_freq = sample_freq;
        dprintk(1, "- sample_freq = %d\n", state->sample_freq);

        /* Update the I/F */

I will add a extra patch to fix tda10048_set_if

Thanks

PS: Thanks a lot for your reviews, really appreciate! I have a v2 with
your changes, I am giving it a couple of days before re-submitting

On Tue, 16 Apr 2024 at 12:10, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Mon, Apr 15, 2024 at 07:34:40PM +0000, Ricardo Ribalda wrote:
> > z does not fit in 32 bits.
> >
>
> z has to fit in 32 bits otherwise there is a different bug.
>
> > Found by cocci:
> > drivers/media/dvb-frontends/tda10048.c:345:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/dvb-frontends/tda10048.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
> > index 5d5e4e9e4422..b176e7803e5b 100644
> > --- a/drivers/media/dvb-frontends/tda10048.c
> > +++ b/drivers/media/dvb-frontends/tda10048.c
> > @@ -342,8 +342,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
> >       t *= (2048 * 1024);
> >       t *= 1024;
> >       z = 7 * sample_freq_hz;
>
> sample_freq_hz is a u32 so z can't be more than U32_MAX.  Perhaps there
> is an integer overflow bug on this line.
>
> The sample frequency is set in tda10048_set_if().
>
>         state->sample_freq = state->xtal_hz * (state->pll_mfactor + 45);
>
> ->xtal_hz is set earlier in tda10048_set_if() and it goes up to
> 16,000,000.  So if ->pll_mfactor is non-zero this line will have an
> integer overflow.  16million * 46 > U32_MAX.  Maybe when .clk_freq_khz
> is TDA10048_CLK_16000 then ->pll_mfactor is zero?  Ugh...
>
> > -     do_div(t, z);
> > -     t += 5;
> > +     t = div64_u64(t, z) + 5;
> >       do_div(t, 10);
>
> regards,
> dan carpenter
>


-- 
Ricardo Ribalda

