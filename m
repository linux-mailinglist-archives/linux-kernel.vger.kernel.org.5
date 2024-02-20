Return-Path: <linux-kernel+bounces-73492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4676485C36F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA55D1F21F13
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A4178B4E;
	Tue, 20 Feb 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0AbwjYf"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9AA77652
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452727; cv=none; b=NxicmujlrgrYSxwSceXPCjqVDLhnf5JYM/0bxiXktgLEiomn90d1WRZecwBpb6qvENMVpRGBkHwrMJw+u9Be86MUb5aIMUXDnlKsJvePaOCf8cvR3tSC+uk558B69v6rLczuYgS06HsM5LeHYS9VdHLrRdpkm3cb9TRlBF0zsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452727; c=relaxed/simple;
	bh=rjveohCfD9DoiAvzq+saEkgFPozVXBVhdv/x0A4BBfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czrHrUMg2EezDRI9JFqUuX9Nq1/9/yuGfNIYFGn42wWnYl4iTLjQArjmXBUU+M/+RBT4Qw8rE1fB7kyOvUhqmrVBqNSi043B7+ze1iUhKDkf18wOSdevbvKDHTs2GpglxnVknLqsYovjKKPya7axAjXO4oxEAmdGg2VkS3Cii8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0AbwjYf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso5687306276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708452725; x=1709057525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMSzyoiSjnYCnePo8ENrWusi8lV7YAbt8CP9L8ksezU=;
        b=I0AbwjYfcDTA541kvjowtyYwZzKJQGneLQsdx0crP9BdJ9irNzap9srVvFZHe+n7HZ
         gmLo46SeHTsl71FvGUeDhZsF8efx6nZRdJGlQjS48j3CYJMfDiVB7dN+RS0JIVRtzcmA
         CtFXaBEnDOs3r9BSISgAfRznbROR9iVGpSYX1KVlylyQ11xazWhx+eu5rt5v5pfumih8
         aLZbqmzySBHXVBm2TARjnDLk1tFWHsMNe2/PSFFl+wM64xRxR6tYbHccpYKYg0+b+JYv
         2fF4MMhEh496x6E6WfpxrGx5KOBTZ6iPdYu+uelOfi7+qAzY5L3wXaFXYOl5q0qbNsr5
         82Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452725; x=1709057525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMSzyoiSjnYCnePo8ENrWusi8lV7YAbt8CP9L8ksezU=;
        b=FBukBzwk6sI1zn2XE1Tz7ROeCMIMQJvjE7C16PftWFD6A1y0uIHr8SGck0yEJFreY8
         zd6Ae/fPnyDvn+hDjAUXm0cvQGQQmwqFziYKxX+4rIPxQheKPSpHW9dS5ePbzEQZ5+b2
         yG83D2hz81Jwxq/0O34ZhiGW6oxlbmA6Waqgp2M1l5W7w4TZw0OLZRFiVIozhNNjBQSM
         hO7jkuvn8aqISqCp3iS6ctb+2q27pG0NCYxel7R2Yvi5MZvUzO0vd+V0nFIw5u/6fTh3
         EI6R4rnncgeb9aIypBVAX8yqhY2EQG2DEIBSjiPdp1awduXahzV5zYxy9bJeVvuouUO/
         7bmA==
X-Forwarded-Encrypted: i=1; AJvYcCWdGMrlhO3rAovT0lcf/r6mpuvwUPHtKDZO7/YtCuGAAOEHx7ZJ3H2YBskmngvLThFXEKwiMIz591BSniuWMpKZThdcU8aV1Sw+TZpA
X-Gm-Message-State: AOJu0Yzi/9ngQ8ptI+5atStuKP8LO2SOSMnsZsoCSfjGT8sE2l5gBCDe
	f8seTd7974P9ZKpGrzKmnR50IenBjFiSA4G4Ef9HHZV6T1+9+ZwUo9TqH8PbmiCetG9PfMUje6R
	Ns9PAZLbFVz6aorfJp3YZZFPX7kLJrqeffV0m2A==
X-Google-Smtp-Source: AGHT+IFsAA0lKvQyArywji1QvO8GzVrKQIsgi7vwTu+7xayCOaldYPKMZ3USNT1VRYNim9WqHs2PSU1hSI0+O4KEIvA=
X-Received: by 2002:a25:c7d0:0:b0:dc3:7041:b81b with SMTP id
 w199-20020a25c7d0000000b00dc37041b81bmr16520405ybe.36.1708452724211; Tue, 20
 Feb 2024 10:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk> <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
 <CAA8EJppzkuH=YTAHuJ3Og2RLHB93PSas004UDvpqepYbGepVPg@mail.gmail.com> <CAMRc=MfXkG1bqGrtFWpoZo3fTY49TvU3sHOnX-zc2kjUiRfp3w@mail.gmail.com>
In-Reply-To: <CAMRc=MfXkG1bqGrtFWpoZo3fTY49TvU3sHOnX-zc2kjUiRfp3w@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 20:11:53 +0200
Message-ID: <CAA8EJpoY_2uNLXtC+xB9cOV5Tc5Bn5mEtJTf+sniWrN9HoEx4Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Brown <broonie@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 19:53, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Feb 20, 2024 at 5:30=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 20 Feb 2024 at 13:16, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kerne=
l.org> wrote:
> > > > > > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski w=
rote:
> > > >
> > > > > > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > > > > > +                             regulator-name =3D "vreg_pmu_ao=
n_0p59";
> > > > > > > +                             regulator-min-microvolt =3D <54=
0000>;
> > > > > > > +                             regulator-max-microvolt =3D <84=
0000>;
> > > > > > > +                     };
> > > >
> > > > > > That's a *very* wide voltage range for a supply that's got a na=
me ending
> > >
> > > Because it's an error, it should have been 640000. Thanks for spottin=
g it.
> >
> > According to the datasheet, VDD08_PMU_AON_O goes up to 0.85V then down
> > to 0.59V, which is the working voltage.
> >
>
> Hmm indeed this is what figure 3.4 says but table 3-2 says the maximum is=
 0.64V.
>
> > VDD08_PMU_RFA_CMN is normally at 0.8V, but goes to 0.4V during sleep.
> >
>
> Again figure 3.4 and table 3-2 disagree unless I'm missing something.

I suspect that the table you have mentioned provides normal working
conditions for the PMU, while power-up and sleep might be outside of
'normal' conditions.

I suppose that these outputs are underspecified in the datasheet. I
think we can omit the values here.

--=20
With best wishes
Dmitry

