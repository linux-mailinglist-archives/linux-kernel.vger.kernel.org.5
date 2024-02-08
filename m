Return-Path: <linux-kernel+bounces-57472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53284D97B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521E3281C96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423567A0F;
	Thu,  8 Feb 2024 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leZK4o2a"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9767C42
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707368880; cv=none; b=qKKlHjt2ZBawrsGD9WcyRe3PaBH4EJ4rHnep8XpOfudEbs7KJtu77kuX8/bVz+EW46DV1oIIn5we+fUDAxxPRt1b3Ud262084rLMUZ5Nu2akNhgPgjtTsL44Mm8rWd2LMPvqC0iCdgf3aLeFU+tGi4AMwhsO02jQ04NepfDwUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707368880; c=relaxed/simple;
	bh=necreP3eDdbdyn4Oyfj+vwKf7/O6xo4o+M2OSyCOT5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyeF+BYbTLU3TJ5ez1BP3R2oWlsVV5JoXzwABSpfmddy20tBsaQ+/swxMQEiXi+H+DjaBNJVOZY7fN5hKOzwPyavQz4+ffbsaHLOKwa6tiPcfoEM30fEsaVWv4Ojqp5gTyRdkyiykNQVgU8NrAWGOuuml2zuRhL1SD8CaqaJXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=leZK4o2a; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6049fc02a19so6907687b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 21:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707368878; x=1707973678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGl5cCJqjAfFyHTLaY0IIsvguW7hmHHJY6/Dv3YRAjc=;
        b=leZK4o2a5AP0SpV2/Tl4aKqKI5pFs+2qbaN6cFe6FXFJtpvVPfYUcT+1YdimXnrCdC
         l3BoP6tlz2qKrHUnL2H++74C4S09PgAaa+5Wz7o2zda5VA4gHwwmrHJhb6D9osWq8d8w
         ZPKI2v8gy7eS4n9pGXx2+amNeW0UT4Gkh6wrfEWgm/M+vXfFw37DYpGZD5jS+HSu/LL+
         vD5Rxxa4pp9n/m+qATQkczuq6WVQHGzeW3hLso93++qjzqC66gDQwgIwVw8y6ZnIvcPi
         nTEYR4ATmGQtAgm9xuUkfG7GbdhauSe1sxDToqlOmt34AIcQaxY88phoiaGuX0m/6JE/
         kwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707368878; x=1707973678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGl5cCJqjAfFyHTLaY0IIsvguW7hmHHJY6/Dv3YRAjc=;
        b=BuDRXqMybsYoFARFEH+5MWm5/zjkSHxrfAySn4IaUwOStHLs1T77TwvUphX5+zPVFQ
         Af+4DuIX8XGunCwQjlKiVWETryjBmR9gldHNJGwvhKiFcWnYP9gn2K6L20LeW34x8C2p
         PNS85HnxlSk3JyTqqbYSN0+seq9KOCXv9PkXkBiCIlk7YpUcbjbwk9bRa2nL5BByEnb1
         qxDds+GVRPhpv39LbogsSxahnpc+JSw9BhNMsdmOGxkIG8zeijZ2Z98erckoY8Dlci48
         xvZyw18ciBARQXW4Aph6pZ11SYyCelG5j/WEwY11ITxR2wbLqnv6hDqTBA9VgMS33oJD
         X/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8WwXkYblqmOoTmBiwxsrH4jLj8/mSIkO+HMu4V7Bsy4dfempKhlhwpG71qpo36xR3i6/Fuz3at1Os+8mtgMyEwUMLCsN8ZoHoe61F
X-Gm-Message-State: AOJu0Yw6iz80ARA3GklEiI4pbI7oEgidvNxJOdwhynIThu9yk5W8pjPO
	HGJ4ADgFnShdVRca8AdYboqpNEKbXronms9DfJZ1K8zKaqZjRkDzFGGFeSXB6BQ08yMuSzil2XG
	QfSv2mXeNks+1iLi8Q2T2EwGqp+i2kGiqJO8QGg==
X-Google-Smtp-Source: AGHT+IG8TR0EY9noCvhpJmwaKoeeoVfLPlOXfYdHiMXIHDnkabCiJ0QcgVdVyJecGruzpZ3bJX1b+CvKsZiwbbxxKg4=
X-Received: by 2002:a0d:f701:0:b0:604:4e77:f291 with SMTP id
 h1-20020a0df701000000b006044e77f291mr7649124ywf.32.1707368877919; Wed, 07 Feb
 2024 21:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com> <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com> <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
 <fd4f4cc8-3366-485b-b540-b05ef59dd5d4@quicinc.com> <CAA8EJppi+3cJqzkhcaDR_3w_Qhy_AzLBJsW7-dtugzE1egM3Kg@mail.gmail.com>
 <7500f1f8-1d97-4fa9-a7cd-7dea0ad52e00@quicinc.com>
In-Reply-To: <7500f1f8-1d97-4fa9-a7cd-7dea0ad52e00@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 8 Feb 2024 07:07:46 +0200
Message-ID: <CAA8EJpoe-gaSgD_HruYSUAPgfBNCw9-G9wnEnvpkiCtmrqFQ7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 06:48, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 2/8/2024 10:11 AM, Dmitry Baryshkov wrote:
> > On Thu, 8 Feb 2024 at 04:40, Krishna Kurapati PSSNV
> > <quic_kriskura@quicinc.com> wrote:
> >> On 2/6/2024 6:54 PM, Dmitry Baryshkov wrote:
> >>> On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
> >>> <quic_kriskura@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
> >>>>>>
> >>>>>> Enable tertiary controller for SA8295P (based on SC8280XP).
> >>>>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
> >>>>>
> >>>>> These are not just pinctrl entries. They hide VBUS regulators. Please
> >>>>> implement them properly as corresponding vbus regulators.
> >>>>>
> >>>>
> >>>> Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
> >>>> implementation was fine as Konrad reviewed it in v13 [1]. I removed his
> >>>> RB tag as I made one change of dropping "_state" in labels.
> >>>
> >>> My comment is pretty simple: if I'm not mistaken, your DT doesn't
> >>> reflect your hardware design.
> >>> You have actual VBUS regulators driven by these GPIO pins. Is this correct?
> >>> If so, you should describe them properly in the device tree rather
> >>> than describing them just as USB host's pinctrl state.
> >>>
> >>
> >> Hi Dmitry,
> >>
> >>    I have very little idea about the gpio controller regulators. I will
> >> go through it and see how I can implement it. I just found this :
> >> https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> >
> > Much simpler, it can be found at
> > Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
>
> Thanks for the reference.
>
> >
> >> One query. If we model it as a regulator, do we need to add it as a
> >> supply and call regulator_enable in dwc3_qcom probe again ?
> >
> > Not in probe(), but yes. It needs to be enabled when the VBUS has to
> > be powered up, when the device is initialised or switched to the host
> > mode, and disabled when the VBUS has to be powered down, if the device
> > is being switched to the device mode.
> >
>
> Actually since we never go to device mode, can't we just stick to this
> pinctrl approach and skip turning on regulator in driver ?

Scroll several emails back. DT should describe the hardware. Hardware
has VBUS regulators.

-- 
With best wishes
Dmitry

