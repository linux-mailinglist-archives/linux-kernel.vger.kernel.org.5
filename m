Return-Path: <linux-kernel+bounces-134976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052389B985
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1FC2812A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168647F47;
	Mon,  8 Apr 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1y1JihA"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459147F48
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563031; cv=none; b=XGkNbUyOjlwrsBgn0Dpjg6PfF/AbwetFEvpL/X2DkixP2b0IYV5biGm3aIrMwCVdXvHokl3vBXVLChxbFOBn5TMJlMyC0i3ZvhuzP1RX5Okwo85HBs4mZgCt3EfmlMZJ0Zjm8im0xgdRF8e+DGS8a20X49jeRmC8d8+HtI5tIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563031; c=relaxed/simple;
	bh=ztZdKzdV8XmPTCssOph+R7PEZ4rG55u2ixXVkTEs/Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhnJBijPhS/mawYwjHMKe8y6fkTQJ6mrXmbfM55AD73TSuY3R9UWBGZAgoxWNWhkS5yHbCfmWwp5RrL48JTJ1wgPWJPaSE0uwEqT6MPWHEFqBkBk/0QSUbI65hsttLHrqMUJ22PCGZEy8ihtBqHtuQeNnGivWEGq1HBm8+jSXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E1y1JihA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3671341276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712563029; x=1713167829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42INHqOz8zY6YYtdfVQ+6Fv7DiGos5maAs8ZdDGi728=;
        b=E1y1JihAyKsFBfsLIYR6FGl9DPItNCuFW039dPPfS3S4C0vrvYLeZJU5QcwTYVdSn2
         mRUbW7oRFhOV36dWd7zFdr14z63WW4UIzaXvAxgfD9lyZzmiX7OCKdXP9kMkMdSFKrDu
         wKRJCYzXDwYONxxMoVqWQ6qIJynYsuoCjDbOTVGa3Sgp6+DYXil4BbA0TYFN7Bw7APMl
         q+3QFOklomm3gv/R8uycxfx35lchfU9i5fveaTcSIk9VIkVNfGjtU8vd2prM1EIcQ15m
         wHkpZ0Zf7+vX5jJI/QMakS8ptuId4WVeOjccyR+SEFYHcB088mj7limnNsQzXaHqFD9Q
         MXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563029; x=1713167829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42INHqOz8zY6YYtdfVQ+6Fv7DiGos5maAs8ZdDGi728=;
        b=voxANpfPf78nVz/CF9HQzwvfCLYRMfK4tdYQK6aNirjk0BsAXaXX04g2cPv+64FDI0
         VNOAq2dwyyf9HcFA08wMR5V94c4L8WL1M2E0YY70sBPcphYlM5I2LG5/wpZ2RIjISIx9
         dGbRQi9z9T3zleXQ1jYeXcW+0osovw68x2uRZ7cg3sMD2X6+UDLkBqoG+SxWA8zf7BTT
         BwU2LCHDjIKUrm6vlcz1hIjGQ+XG1iM/4S1j4q/y6THXC/5jXqaZbOt1IvoxuSjXkXc4
         BDUoKcjWDW7pu2LWeqrKZRfa+HUA0fgiN7a/J1MmhfvudRGkO0za3/zCkzTbB7AaP6WI
         Q1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFASIiX41XbOmLI6pho3papoE9W5zQzKauhxKTmFblff6ha4fpwYiMoNXM9xFaGYuGrO5KnXYIcwdhw5H2sJzVPBeeonHuFCNjwSkG
X-Gm-Message-State: AOJu0YwGQF7fpT0XJq75w7IK9R1rMOo6MRDQRTz87bgDoLhr9cPAVzuP
	9SadvpRIHiRNkZEVgkVBmHtpl82ThQjkUSBboqRPJmE+DcA3fkTMFy8Di7XtdI7HEU/9Zarekbo
	4PgeIV1RIEGNWqIGcjO8GroUBktMVJ7xNljdkCw==
X-Google-Smtp-Source: AGHT+IEjAG+X891MIrzbWhd0+2h8HeWsW4dEnYTVJdLx8WQ2B0jzYicEpw8mgvZ3qBES33KYnneEc7iK5ck1iAmOOio=
X-Received: by 2002:a25:86d2:0:b0:dcd:128:ff3b with SMTP id
 y18-20020a2586d2000000b00dcd0128ff3bmr5923980ybm.38.1712563029085; Mon, 08
 Apr 2024 00:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
 <D0EJR77G6HF0.2LUJ3XY1YFG65@fairphone.com> <CAA8EJpqUz8anQ9V_Ht67DMrMXw49u9R01mHKDMxnGf-UpXrrUw@mail.gmail.com>
 <D0EJTA1YFZRW.3LWBWJC0QYQ62@fairphone.com> <D0EKRXT8JJCG.DJW8LMIPMWX5@fairphone.com>
In-Reply-To: <D0EKRXT8JJCG.DJW8LMIPMWX5@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 8 Apr 2024 10:56:58 +0300
Message-ID: <CAA8EJpo50dsXBD3bXHZQ1zGDt0KPVGJQscOb0gwYSPoSwQR2Aw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: add USB-C orientation GPIOs
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 10:50, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Mon Apr 8, 2024 at 9:04 AM CEST, Luca Weiss wrote:
> > On Mon Apr 8, 2024 at 9:03 AM CEST, Dmitry Baryshkov wrote:
> > > On Mon, 8 Apr 2024 at 10:02, Luca Weiss <luca.weiss@fairphone.com> wrote:
> > > >
> > > > On Mon Apr 8, 2024 at 4:33 AM CEST, Dmitry Baryshkov wrote:
> > > > > Populate orientation GPIOs for some of the PMIC-GLINK-based devices.
> > > > > This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP CRD
> > > > > without the orientation GPIOs declared.
> > > >
> > > > Hi Dmitry,
> > > >
> > > > How would I find this GPIO on the schematics, or downstream devicetree?
> > > > I scanned over some relevant areas but nothing jumped out at me except
> > > > for the USB_PHY_PS signal coming from PM7250B CC_OUT and going into
> > > > GPIO_140 of the QCM6490 - but I'm guessing this is something else?
> > >
> > > It is exactly that GPIO.
> >
> > Great, thanks! The PM7250B datasheet and my limited USB-C knowledge
> > didn't help me there much ;)
> >
> > I'll send a patch to add it.
>
> One thing I've noticed now is that the dt schema currently explicitly
> disallows orientation-gpios for anything that's not sm8450, sm8550 or
> x1e80100.
>
>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: pmic-glink: orientation-gpios: False schema does not allow [[84, 140, 0]]
>           from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#
>
> So I'd think also this series will cause some extra validation errors if
> the schema is not adjusted? Are you planning to do that?

I didn't check it. Yes, I will include it in v2.

>
> Regards
> Luca
>
> >
> > Regards
> > Luca
> >
> > >
> > > >
> > > > Regards
> > > > Luca
> > > >
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > > Dmitry Baryshkov (4):
> > > > >       arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
> > > > >       arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
> > > > >       arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientation GPIOs
> > > > >       arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPIOs
> > > > >
> > > > >  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        | 2 ++
> > > > >  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
> > > > >  arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 1 +
> > > > >  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 1 +
> > > > >  4 files changed, 6 insertions(+)
> > > > > ---
> > > > > base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> > > > > change-id: 20240408-hdk-orientation-gpios-141bc7fd247d
> > > > >
> > > > > Best regards,
> > > >
>


-- 
With best wishes
Dmitry

