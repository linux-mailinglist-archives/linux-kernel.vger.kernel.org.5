Return-Path: <linux-kernel+bounces-48793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C3846184
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15F41C24D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF285645;
	Thu,  1 Feb 2024 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdS04626"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B185639;
	Thu,  1 Feb 2024 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817259; cv=none; b=kdfOPrxivdJoLlF5wStSFJ/eGLHSPIRTogynUCwmveLP9IFa+bEZc/ZcEUsS8/3DXIfdd04Q0+4PY2zhy+oGG3XzWTqRp0kL0zZnfe2rSw4CHeahcbWvrVHBb7n0BoMq9rVOqE174K7Ab4kqZHOt805HFT09ZHg/EL8seSVZQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817259; c=relaxed/simple;
	bh=igWepZJuJ7/NxlfTBcvat+93tyRHyJ7CtS8SToYFt88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuT0G204YM4NdlbyLqHY5FpSibrhaPskX0/wW3nih7h60+Qp8ca1iCQH80cEHHz+ACLn47RvbYf/MULKhnNTbRXOgsPZGsub5k7OsJSSLMWSBNee9L5EXZNJT3t86fC0S3gbGYkf+07qEwoZxtKHkLI68tjhrrvxwnsuEtpMHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdS04626; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso11361575e9.0;
        Thu, 01 Feb 2024 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706817255; x=1707422055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw0ii54g50YM0TTuIh98HIpGP8lHOO7kLQ/jqdmdMzg=;
        b=TdS04626BAnPz7e+SzFyfM0zwf4n+7EOtW9jQoMtN+hXw+GMYH6yEVmVq1s3zJmFni
         +PdA1Is6XgSL2FW8hvvMmcETWF+q70OmCmSjaxvwWKLmNkpx0g3keFh+64BFQAaIW+Qv
         Q1nY7L+bIxZyVXcTCOvYsiUfC90I4lwDn+w/d8QmSBJpalBGOXtlD3WuNplg/+I5mVcB
         gWT6VINX/TW+YAXauYjMg/vMtNF7jZ22UdzKNeBi8wh0x1RQxS2rgcc7levF24Zlt//X
         s65l82XLTmkE9bZgzFXHHdI+jcXv/SWJFwPNACi0dD+NYPFCJmeBK3rNFMutIKclqSfd
         a6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817255; x=1707422055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw0ii54g50YM0TTuIh98HIpGP8lHOO7kLQ/jqdmdMzg=;
        b=shfY+4VOnuCZJGkcAegkLC6CtYeO/cGGd5MWA58tFKu8KxBbNJYbftcGOypeBWtq29
         +quTcQy1Z1bstManfu/5FBaiB1lfxYpj0XeH8OyIAyhji9j0yfkG4jA/78zqB8KQeG7z
         VFPfK4Nh5/39Cpvjergw6sCEwdIBFO2TPz9SZCCG7WZ+bp1fGlonwdMJy2nN5a/dMzFT
         uSlX8dmKy+yAKg0XLtDjnYhR5U/08QDfbQn62NCO3vrMomB0oB4W6lkTlAmMcYisCRSX
         h6sa5WN+UvL1Qu1hBgfxioOTXzqgP+JQAIM2Pp+48mV03Wqlf6yb/ySRMpPT3OLW5mUa
         YJJw==
X-Gm-Message-State: AOJu0Yxbc1bI041AhZP0oDt1b31dsWtvpEaofVSFeKEvI4lb5KsgHrlm
	h7c4NFj6b7rluX39gU+GE4PhzW651n5pj23NWvlb+yivjffPj5kC
X-Google-Smtp-Source: AGHT+IEnh5hwCXXTj+jcR1g0I5bM3FN4GQ3RUZkTBdSNXXRnJnKzpnLqx2ztJH2PVqejHm+eHD5rlg==
X-Received: by 2002:adf:f64d:0:b0:33a:ed59:c13f with SMTP id x13-20020adff64d000000b0033aed59c13fmr2215794wrp.53.1706817254477;
        Thu, 01 Feb 2024 11:54:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkIqDqfPVesemdoaqG1j9jyMLDsyXZci7qdN4rwuZyTnBZy4P9GdwzPQDb4Y97RzDb7Nt0/KTkiYHc51OSLbBILSGHypTjb1PDb72ZoN4kaiS2TT38IIny9hPv2qk7pbyB11bBj5eswJ+oqt6ESrIo8PmhujbvmHrZ92DidVXSYCIjxN1acjdlenKmkXnSfu++c+dj/Av8asn0HmbyqnJOHJwIvOONyMQz7F09oEWk0jsg4Qs3a3TqQFxA5SUAaxlPo2IJXN4OUMn6+DxZIgdQzBM6KWGu35l4Soq52r7+Zd0QERbzokhqf2Tb42N3SFmMLFs+a7yMc+7eTw7Al8QKIOgIa0u0jl1oDEI1AB6rPSle+MxY1/QtbLL8
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b0033afce63fd0sm211781wrq.53.2024.02.01.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:54:14 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Aren <aren@peacevolution.org>
Cc: linux-kernel@vger.kernel.org, Miles Alan <m@milesalan.com>,
 Ondrej Jirman <megi@xff.cz>, Chen-Yu Tsai <wens@csie.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH 2/4] arm64: dts: sun50i-a64-pinephone: Retain leds state in
 suspend
Date: Thu, 01 Feb 2024 20:54:12 +0100
Message-ID: <10409647.nUPlyArG6x@jernej-laptop>
In-Reply-To: <sbcg74hktwv5x7hookeb4su27xut7swarl3d5mbs3i5cqxtq4g@4evugu43ctiv>
References:
 <20240128204740.2355092-1-aren@peacevolution.org>
 <4892315.31r3eYUQgx@jernej-laptop>
 <sbcg74hktwv5x7hookeb4su27xut7swarl3d5mbs3i5cqxtq4g@4evugu43ctiv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 01. februar 2024 ob 02:36:46 CET je Aren napisal(a):
> On Tue, Jan 30, 2024 at 08:06:24PM +0100, Jernej =C5=A0krabec wrote:
> > Dne nedelja, 28. januar 2024 ob 21:45:08 CET je Aren Moynihan napisal(a=
):
> > > From: Miles Alan <m@milesalan.com>
> > >=20
> > > Allows user to set a led before entering suspend to know that
> > > the phone is still on (or could be used for notifications etc.)
> > >=20
> > > Signed-off-by: Miles Alan <m@milesalan.com>
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> >=20
> > Where is patch 1 and possibly cover letter? Please resend with all patc=
hes.
>=20
> Oops, sorry about that, I'm still getting used to get_maintainer.pl.
> I'll resend this properly when I have time this weekend, until then the
> patch you missed is available at
> https://lore.kernel.org/lkml/20240128204740.2355092-1-aren@peacevolution.=
org/

When sending patch series it's customary to send all patches to all
maintainers and mailing lists (to have a context). In case of large patch
series, you can send only selected patches to each maintainer and mailing
lists, but then send cover letter to all involved and explain general idea
behind the series.

Best regards,
Jernej

>=20
> > However, this particular patch is:
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Thanks
>  - Aren
>=20
> > Best regards,
> > Jernej
> >=20
> > > ---
> > >=20
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi =
b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > index 87847116ab6d..ad2476ee01e4 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > @@ -43,18 +43,21 @@ led-0 {
> > >  			function =3D LED_FUNCTION_INDICATOR;
> > >  			color =3D <LED_COLOR_ID_BLUE>;
> > >  			gpios =3D <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> > > +			retain-state-suspended;
> > >  		};
> > > =20
> > >  		led-1 {
> > >  			function =3D LED_FUNCTION_INDICATOR;
> > >  			color =3D <LED_COLOR_ID_GREEN>;
> > >  			gpios =3D <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> > > +			retain-state-suspended;
> > >  		};
> > > =20
> > >  		led-2 {
> > >  			function =3D LED_FUNCTION_INDICATOR;
> > >  			color =3D <LED_COLOR_ID_RED>;
> > >  			gpios =3D <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> > > +			retain-state-suspended;
> > >  		};
> > >  	};
> > > =20
> > >=20
> >=20
> >=20
> >=20
> >=20
>=20





