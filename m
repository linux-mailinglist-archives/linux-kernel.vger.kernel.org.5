Return-Path: <linux-kernel+bounces-139748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B58A0735
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9151C230E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2E13B5B0;
	Thu, 11 Apr 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JVxuBK12"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104195CBD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810546; cv=none; b=OdXk6G2MMrAD2dhzZSnznDkY/Wfv0rpsqLZAbjm3W496+rn4WL6CZ/P0RxMCrz0t66I4Z5oZsvtPWfPKxDgiU07Jf6n0jzEmS8AzS23BxRI8SwLHKbv/gpNJIm90nr1IeMf0+/4XSn/2fjelq31epFhWV6rq1ohRHuk21cxLQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810546; c=relaxed/simple;
	bh=OBIk8lPJRozM4qkxr3lM/HszMCOpGOf9NuDPsF+XcK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD/tdtWfImpuBE+YkpTutOwhbnjobM55xiuuBXeapVN7/bNqd46Jkq9dum4ND0cMzDqiveTA7vUkztRTZu5YYPrTgGNTO/muWftjxQOjyhpshdDuB7g5GBMTWrPW3POUYRkKtiNvugC/S+IxczOL+bHNf3rJp2HeHEvErnjNzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JVxuBK12; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78d5f0440d3so317386685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712810541; x=1713415341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQKdlV+ay3gMLnnYt6AkOPG1L2MnkbXIzuX0mw97TKE=;
        b=JVxuBK129ON5E6+4l+CwB99Ejdw50mLenpJ40fQ9wx14coqbNffJkR8fFIr2byD7qQ
         35gdMFNyymBeYMm37Re1oYv0wWIX11td82J5AlHZVI68Lq6idbHF2qtURl346zie63vd
         nhBK0o7Kx+7RZFjQXsM1PRF8zuGFD/7VUUCL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712810541; x=1713415341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQKdlV+ay3gMLnnYt6AkOPG1L2MnkbXIzuX0mw97TKE=;
        b=QqTxFchTjWGzHd8VfC4a/gWH+YwebbDbdKcZOA4hs/3I/DA5pO7RlKpdzWfz3OPeAh
         lsuT4r7IWoHHRDgi6zRuaZIFAEAIWLzXTahVdatNSpd1pGQhQPLOtAjJyx9bQel/1UuO
         7bQlLbEun8x1+kW4doeLm9xDh7ExlrVIS1Lcp1fCXMHthIxDnsDTb14d08vg2ku6rtYg
         pdJK6Ci3qFdAHkjiJgNI6qgyzz+YkY8T8bBFyUhIn0splEmwpiqvG2IBe+FLzhLjvAdP
         7SKJDFdZ5I9FSVgzTY7f0q+5g5bmZCHl/2uPiMjKgca+cvjC4iSjX2n14pPOWdgUVwTF
         I3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUZz8L+azCZPtXENWM97FQds9g3WPUHTky/+p3I7XiKBvghEc/4ATjuQgOq0+FtMX81/IXEUbWAQtwSBgskyYFI9wa6y/MnHs6mska9
X-Gm-Message-State: AOJu0Yy0WZHVnlSImytKstorodnzIAgqVlwS0q5J5UPqkPu/qd8qQnFI
	F0f/hW8AknnjBBtdLPF/2SLo5PQYPvLZNi0HxPbVkyrvrCuUDf4Y+wzd2pKhNekmTsTURYSt4o0
	=
X-Google-Smtp-Source: AGHT+IGN8nqgBPtgBvPOzuKH36fBPzMNCFOvDHV9eeGwI/7mO9HZ8fxIyfl+ckEblAtrfaqxu6sgIA==
X-Received: by 2002:a05:620a:1184:b0:78d:735a:216b with SMTP id b4-20020a05620a118400b0078d735a216bmr4587043qkk.18.1712810541112;
        Wed, 10 Apr 2024 21:42:21 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id a15-20020a05620a16cf00b0078d5f2924e1sm507881qkn.63.2024.04.10.21.42.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 21:42:19 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4348110e888so138451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:42:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWtl5x36g19dynyeBUGaGFO2QzcirUvmaZbyk7wz1F+GJk5TMlneZFVTm7TCtU8oaiY4YESqk7OL/NNt4YR1Ty/vojTP8fYFBiGWmA
X-Received: by 2002:a05:622a:4c0b:b0:431:f7fb:1c77 with SMTP id
 ey11-20020a05622a4c0b00b00431f7fb1c77mr197018qtb.22.1712810539067; Wed, 10
 Apr 2024 21:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408073623.186489-1-j-choudhary@ti.com> <CAD=FV=V6vUgcPn0zhA+9k4cHVpqqeSVCSJG23XEE5KMAHUCCoQ@mail.gmail.com>
 <279a1467-9ba4-449c-9076-9b2acef9336c@ti.com>
In-Reply-To: <279a1467-9ba4-449c-9076-9b2acef9336c@ti.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Apr 2024 21:42:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVs56wPGMVwuuwvHN8ob2bUeX1U-G=Zt_xGeGMyuchQA@mail.gmail.com>
Message-ID: <CAD=FV=VVs56wPGMVwuuwvHN8ob2bUeX1U-G=Zt_xGeGMyuchQA@mail.gmail.com>
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

On Wed, Apr 10, 2024 at 4:42=E2=80=AFAM Jayesh Choudhary <j-choudhary@ti.co=
m> wrote:
>
> Hello Doug,
>
> Thanks for the review.
>
> On 08/04/24 14:33, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Apr 8, 2024 at 12:36=E2=80=AFAM Jayesh Choudhary <j-choudhary@t=
i.com> wrote:
> >>
> >> Due to integer calculations, the rounding off can cause errors in the =
final
> >> value propagated in the registers.
> >> Considering the example of 1080p (very common resolution), the mode->c=
lock
> >> is 148500, dsi->lanes =3D 4, and bpp =3D 24, with the previous logic, =
the DSI
> >> clock frequency would come as 444 when we are expecting the value 445.=
5
> >> which would reflect in SN_DSIA_CLK_FREQ_REG.
> >> So move the division to be the last operation where rounding off will =
not
> >> impact the register value.
> >
> > Given that this driver is used on a whole pile of shipping Chromebooks
> > and those devices have been working just fine (with 1080p resolution)
> > for years, I'm curious how you noticed this. Was it actually causing
> > real problems for you, or did you notice it just from code inspection?
> > You should include this information in the commit message.
>
> I am trying to add display support for TI SoC which uses this particular
> bridge. While debugging, I was trying to get all the register value in
> sync with the datasheet and it was then that I observed this issue while
> inspecting the code.
> Maybe Chromebooks are using different set of parameters which does not
> expose this issue. Since parameters for my display (mentioned in commit
> message) yields the frequency at the border, I saw this issue. My debug
> is still ongoing but since the value is not in sync with the
> documentation, I sent out this patch.

OK, sounds good. It would be good to include some of this type of into
in the patch description for the next version.


> > I'm travelling for the next two weeks so I can't actually check on a
> > device to see if your patch makes any difference on hardware I have,
> > but I'd presume that things were working "well enough" with the old
> > value and they'll still work with the new value?
> >
> >
>
> Yes, ideally they should still work well with this change.

OK, I can validate it in a few weeks.


> >> Also according to the SN65DSI86 datasheet[0], the minimum value for th=
at
> >> reg is 0x08 (inclusive) and the maximum value is 0x97 (exclusive). So =
add
> >> check for that.
> >
> > Maybe the range checking should be a separate patch?
>
> Check should be done before propagating the register value so I added it
> in the same function and hence in the same patch.

I was thinking you could have patch #1 add the checks. ...then patch
#2 could fix the math.


> >> -#define MIN_DSI_CLK_FREQ_MHZ   40
> >> +/*
> >> + * NOTE: DSI clock frequency range: [40MHz,755MHz)
> >> + * DSI clock frequency range is in 5-MHz increments
> >> + * So minimum frequency 40MHz translates to 0x08
> >> + * And maximum frequency 755MHz translates to 0x97
> >> + */
> >> +#define MIN_DSI_CLK_RANGE      0x8
> >> +#define MAX_DSI_CLK_RANGE      0x97
> >
> > It's a little weird to call this min/max and have one be inclusive and
> > one be exclusive. Be consistent and say that this is the minimum legal
> > value and the maximum legal value. I think that means the MAX should
> > be 0x96.
>
> The comment above does specify the inclusive/exclusive behavior.
> Since a value corresponds to 5MHz range, associating the value with
> the range makes more sense if I keep it 0x97 (0x97 * 5 -> 755MHz)
> 0x96 corresponds to the range of [750Mz,755MHz).
>
> If this argument does not make sense, I can change it to 0x96 and handle
> it with the inequalities in the function call.

Right that the comment is correct so that's good, but I'd still like
to see the constants changing. For instance, if I had code like this:

/*
 * I know 2 * 2 is not really 5, but it makes my math work out
 * so we'll just define it that way.
 */
#define TWO_TIMES_TWO 5

..and then later you had code:

if (x * y >=3D TWO_TIMES_TWO)

When you read the code you probably wouldn't go back and read the
comment so you'd be confused. AKA the above would be better as:

#define TWO_TIMES_TWO 4

if (x * y > TWO_TIMES_TWO)

Better to make the name of the #define make sense on its own. In this
case "min" and "max" should be the minimum legal value and the maximum
legal value, not "one past".


> >> +        */
> >> +       bit_rate_khz =3D mode->clock *
> >> +                      mipi_dsi_pixel_format_to_bpp(pdata->dsi->format=
);
> >> +
> >> +       /*
> >> +        * For each increment in val, frequency increases by 5MHz
> >> +        * and the factor of 1000 comes from kHz to MHz conversion
> >> +        */
> >> +       val =3D (bit_rate_khz / (pdata->dsi->lanes * 2 * 1000 * 5)) & =
0xFF;
> >> +
> >> +       if (val >=3D MAX_DSI_CLK_RANGE || val < MIN_DSI_CLK_RANGE) {
> >> +               drm_err(pdata->bridge.dev,
> >> +                       "DSI clock frequency not in the supported rang=
e\n");
> >> +               return -EINVAL;
> >> +       }
> >
> > Shouldn't the above be in atomic_check()? There's a reason why
> > atomic_enable() can't return error codes.
>
> Oops.
> I will handle it how we are handling errors in case of link_training:
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/ti-s=
n65dsi86.c#L1152
>
> That should be okay I guess?

I'm pretty sure it should be in atomic_check(). The atomic_check() is
supposed to confirm that all parameters are within valid ranges and
the enable function shouldn't fail because the caller passed bad
parameters. Specifically this could allow the caller to try different
parameters and see if those would work instead.

In the case of the link training failure it's not something we could
have detected until we actually tried to enable, so there's no choice.

-Doug

