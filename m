Return-Path: <linux-kernel+bounces-57465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B297B84D96B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73331C239FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596B67A0C;
	Thu,  8 Feb 2024 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wee279AO"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5C679F3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707367289; cv=none; b=rAOWdTKJX3ccmbClcBkKXHQdRo7L1BcchfUYMTcUMbwkdhy6z0K6Urm5meonfziVGi2sgFBkX1NfgRzhZvaHLTbCjdbmhTV/lSc4T3H6VrXoi2DdoYYYZrpl9MDPvWVUd0JpS99c6arFzDdLkYQVHqD0OAO1F1T3530mR/erBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707367289; c=relaxed/simple;
	bh=ZvtyxYWya+wbuYBYSpD4VHH2sAUm44ABxbRFDJDlGxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USdrr0RcbVgmFVbHt+KBlJmryd3tFZwtEXpddOWI6u0brrheQ8Xiwq3bXyyDH0+WH6dit9OnA99BaEJZ/OKXCyLaxhyVgL2LnynOznMjf/3e8KLQzyYSvHsSs3dr+tNxp/f+iSrHYGgD/pkjUXmPl/awzBluxrNWvZFKnZzpkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wee279AO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so1520664276.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707367287; x=1707972087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnvR63Y2d9K/OauKoSp07LpPBFE6lE2yL13br/QXiw8=;
        b=wee279AOJ7poez5BZtuHnENAtQgbOfqZnlnGuSs6oWphJGTXkY0s5Rk2md+4SvVrwT
         KkcgU7vdEGAWeOcMqAEdMPeO0G1+YnAFTs3n+HyRSxwFsuddcwrAlzc49uANujrE2i6l
         fRHKIt9PBmo0voarzOvMXueduQvZz3BHYqWsW9iulG1G4taI7B/0qzBgdrnA7C4NqNHf
         YvIy27Pu+74dPUIF2ulathRBKDDbe56QwKmgy3bH0k20ebzgBr7/ae/v0g678USKRBtz
         hGBK66ydxV40PHqWO0sge/2FEuP27xkn0RHn2CmbbdSwxSSkBBpKlbw/5a13XzzrmKCN
         9tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707367287; x=1707972087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnvR63Y2d9K/OauKoSp07LpPBFE6lE2yL13br/QXiw8=;
        b=l/Ke4+MO6QNPmg3Eb+pajiV6a5Z4kQUer2M+hLUGXoxisqB4YDGRaJCLlnZ/dOmmLI
         4+SvS+Qw18+N2jaL2lSFKGqS0pT0yqCzS8L2fT232TvA2QsjPmGKpBheeYnqs5/7Um6L
         t6kMfOzzl/+XVAX0OP/GcyEROat396xz5mHJScPDtqEGwDnKoJHPinbLtFnNjIjLRa0R
         KCs4swqM3/T4K1FKzbckp/tFg5MndD/DT9bIsRR69Wvo0lmdhXKPeSUNt9l35IYpOO0O
         S0fd9DIIQjyA1rUGr1C+cmUFEgzHEW8wkxICMow2ldu1fvibDpnOnZ3rkso+ml6xQSUg
         qC1w==
X-Forwarded-Encrypted: i=1; AJvYcCXkdR22lpHw5rV/PD0bgqaDQVAiYD0jzWC/y9NhBERRvNTCxjSXEQwJNPP1VvAUQGJQ8SRXk6IarDza1yYrzJUO+tmCcN7lYXLcXvok
X-Gm-Message-State: AOJu0Yxdv4WomeS1GuT9u9/qmmJ+kvWFUKNnytN8W2fVRqtzd03c4Hm6
	HuOLqqJqZB/3quITvUHB8wkiSRnPlLpwY079vIo1zISZFz4qXzPtEVB56Vly2NLEvx46+l0O53+
	9bDiy2WjF6I+Mrud4zZS1rH7YdbeQFmJImPd3ww==
X-Google-Smtp-Source: AGHT+IFyIfiERypsPyOsKP4GiURnOSp2fv8byw+YAU+w/NrwcQ8VHreen9gwnKuUT3xt9N4tfsUsTEiLPRfNj9j4oso=
X-Received: by 2002:a25:8244:0:b0:dc6:7247:5d94 with SMTP id
 d4-20020a258244000000b00dc672475d94mr6533523ybn.55.1707367287033; Wed, 07 Feb
 2024 20:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com> <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com> <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
 <fd4f4cc8-3366-485b-b540-b05ef59dd5d4@quicinc.com>
In-Reply-To: <fd4f4cc8-3366-485b-b540-b05ef59dd5d4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 8 Feb 2024 06:41:15 +0200
Message-ID: <CAA8EJppi+3cJqzkhcaDR_3w_Qhy_AzLBJsW7-dtugzE1egM3Kg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 04:40, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
> On 2/6/2024 6:54 PM, Dmitry Baryshkov wrote:
> > On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
> > <quic_kriskura@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
> >>> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
> >>>>
> >>>> Enable tertiary controller for SA8295P (based on SC8280XP).
> >>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
> >>>
> >>> These are not just pinctrl entries. They hide VBUS regulators. Please
> >>> implement them properly as corresponding vbus regulators.
> >>>
> >>
> >> Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
> >> implementation was fine as Konrad reviewed it in v13 [1]. I removed his
> >> RB tag as I made one change of dropping "_state" in labels.
> >
> > My comment is pretty simple: if I'm not mistaken, your DT doesn't
> > reflect your hardware design.
> > You have actual VBUS regulators driven by these GPIO pins. Is this correct?
> > If so, you should describe them properly in the device tree rather
> > than describing them just as USB host's pinctrl state.
> >
>
> Hi Dmitry,
>
>   I have very little idea about the gpio controller regulators. I will
> go through it and see how I can implement it. I just found this :
> https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/gpio-regulator.txt

Much simpler, it can be found at
Documentation/devicetree/bindings/regulator/fixed-regulator.yaml

> One query. If we model it as a regulator, do we need to add it as a
> supply and call regulator_enable in dwc3_qcom probe again ?

Not in probe(), but yes. It needs to be enabled when the VBUS has to
be powered up, when the device is initialised or switched to the host
mode, and disabled when the VBUS has to be powered down, if the device
is being switched to the device mode.

-- 
With best wishes
Dmitry

