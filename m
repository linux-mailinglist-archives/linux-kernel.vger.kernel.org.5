Return-Path: <linux-kernel+bounces-78738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D9861815
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE3F288D81
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D95212A14C;
	Fri, 23 Feb 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiNDkNdl"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15245B1E0;
	Fri, 23 Feb 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706208; cv=none; b=jx8iGbmOzTqokk6ybd2HG5xMTozV/nrbLYzTicSF7PlW+AnD5pilTmRqLXxnfZ0fFZlu9iVnHK916E51FK9/sbNZX3lO9KqgLra8LwBED6cMMoiy18Wc+aiKVGXGjDdE3S3XLWiAPkJ20enpP15rFq0JKKv3SONmwKnObvF4kCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706208; c=relaxed/simple;
	bh=fI/IAdkB29JdV6KJtBT8ElzaQ0cLMc44qidIJ5rd/I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOD+sIZxdybL/oHena+0G1WaQwNqTsWtmZ9dfHIxtAWYW817Ttex9/AQ35prFwNTsaA/e5k/dlJDuXmIZlq0yiEm92vH+qgeGn3wfUtHO4Iz6id4V6deTnIVmJOQ7DLqEs7rJFjxnoHHdYFIg0FTvWp9ni14i4VIdMCd3D0j9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiNDkNdl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso1184902a12.1;
        Fri, 23 Feb 2024 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708706205; x=1709311005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKe39YFDJ/aeVcKQ4XcWYXwsRT9ZbN8/BAXxQxEi0rU=;
        b=XiNDkNdlxuyQwNDNNF9VokCJ/CHQ9QXF2msRHdRLZpft55JQ7+3hJkgQIIKZA0QT7P
         +bOCldm5ZOXE56ICEblyBczIBDOw6iMx9tNGE52O+1SAUvXh2duCWIKYS7/H4//0CPJL
         unLyeMvugbKSyXyOOVZCGHzK9US2kIXUi9hmYIFkcEP7rmczc4iCbGwuzJS2tc03hvK5
         xFak4JpZ7HL1Bg6Tf8pMtY08ohwK9drbxeYbIe8CIHHQPfuMACpNskSLG9ZMM4ayFSXh
         xIgzbTLR+fepoOJxU6vPZjjhMj6ORUYXeTBXwsO150nwMyjgODjM/szHLTlMEJ3RSWtV
         OEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706205; x=1709311005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKe39YFDJ/aeVcKQ4XcWYXwsRT9ZbN8/BAXxQxEi0rU=;
        b=uDBueiRoYNvUkJh9N6Uz2WrXExWnuAXKmpWpiEdSiDlftny53libt1yK9QvXPE0Hdq
         skyEXHv8lDKB1KnEnuUvuYeFOvel77g/jw4o82EmlGhX/hoGxha1tBQxDy78SaGFQdmu
         MPt7vSKDW+mxJtWw+20XTLzpjLcIlllxYSRCJADotFJe7NeGm1QZqZ1wTju77z+iC8QS
         IrB47e7Ztn2HwHVTTL3zWUEu6Tetji8XB/3nDcsv91cqqe5kXhACoW4qDVk3LdrrZXBS
         btbTZ/XuAbHJ/waSUnlOYDUADWCw4NwZj/8OwYIGNuK7RWnFr/OMrYmVo77KvM8HbWbY
         vTsg==
X-Forwarded-Encrypted: i=1; AJvYcCVxVTEjp5UR0qySWLTak7Zb5s6oFJtmzny9ZrDfZRu+3FEjYVCHrVYQHRBGaNOduKOHqMukFGQaza8C9NJJytEIM4xyWkJYH2qwnuzwReQBY+l+6u6F/hGMMNpmqP/QJMUZRcVNNVw=
X-Gm-Message-State: AOJu0YzlMReoyaepdehgu7y5eg3sRWsK2uKnq6lnX4hiit3bNu6BEI2d
	BTJf67lNNjO8vb3L6r7hFs78vNEVSdj2I5HuS/hcu2bXHxYlkuGk
X-Google-Smtp-Source: AGHT+IHVdyrN3kBkUrfWyiP7YQLML5RAlwreabe5AGh4wWZSEssVDk9CCs13QdkcRc8MkQf4ECAYfA==
X-Received: by 2002:aa7:d0ca:0:b0:564:54c6:6903 with SMTP id u10-20020aa7d0ca000000b0056454c66903mr295366edo.7.1708706204889;
        Fri, 23 Feb 2024 08:36:44 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id e10-20020a50ec8a000000b00564d6840976sm3194261edr.80.2024.02.23.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:36:44 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Aren <aren@peacevolution.org>
Cc: linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>,
 Ondrej Jirman <megi@xff.cz>, linux-sunxi@lists.linux.dev,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>,
 Samuel Holland <samuel@sholland.org>
Subject:
 Re: [PATCH v2 4/4] arm64: dts: sun50i-a64-pinephone: change led type to
 status
Date: Fri, 23 Feb 2024 17:36:42 +0100
Message-ID: <4545459.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <n5rmhx7ez7xoqainjqxpdk47e3bw2pvtsgswofnhjdxtrk72j2@debhbdxsxz4m>
References:
 <20240206185400.596979-1-aren@peacevolution.org>
 <2792937.BEx9A2HvPv@jernej-laptop>
 <n5rmhx7ez7xoqainjqxpdk47e3bw2pvtsgswofnhjdxtrk72j2@debhbdxsxz4m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne petek, 23. februar 2024 ob 17:30:00 CET je Aren napisal(a):
> On Thu, Feb 22, 2024 at 09:57:00PM +0100, Jernej =C5=A0krabec wrote:
> > Dne torek, 06. februar 2024 ob 19:13:20 CET je Aren Moynihan napisal(a):
> > > The status function is described in the documentation as being a rgb =
led
> > > used for system notifications on phones[1][2]. This is exactly what t=
his
> > > led is used for on the PinePhone, so using status is probably more
> > > accurate than indicator.
> > >=20
> > > 1: Documentation/leds/well-known-leds.txt
> > > 2: include/dt-bindings/leds/common.h
> > >=20
> > > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> >=20
> > Sorry for late review.
> >=20
> > Please update subject in patches 2-3. Instead of "sun50i-a64-pinephone:"
> > use "allwinner: pinephone:" (check commit history of sun50i-a64-pinepho=
ne.dtsi).
> > Also rgb -> RGB, led -> LED. Last, please reword commit message to excl=
ude
> > links and just say DT bindings documentation.
> >=20
> > Note that I'll merge patches 2-3 once patch 1 is merged.
>=20
> Would you like me to reword and resend the patches, or is it quicker
> for you to just do it when you apply them?

Since Ond=C5=99ej raised concerns, let's finish that discussion first. It's=
 possible
that this patch will be rejected. That would also mean new revision of patc=
hes.

Sadly, this means DT patches will miss v6.9 window.

Best regards,
Jernej

>=20
> Thanks for taking a look at this,
>  - Aren
>=20
> > Best regards,
> > Jernej
> >=20
> > > ---
> > > I can't find any documentation describing the indicator function, so
> > > it's definitely less specific than status, but besides that I'm not s=
ure
> > > how it compares. Please ignore this patch if it's not useful.
> > >=20
> > > (no changes since v1)
> > >=20
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi =
b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > index e53e0d4579a7..6d327266e6cc 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > @@ -61,7 +61,7 @@ led2: led-2 {
> > >  	multi-led {
> > >  		compatible =3D "leds-group-multicolor";
> > >  		color =3D <LED_COLOR_ID_RGB>;
> > > -		function =3D LED_FUNCTION_INDICATOR;
> > > +		function =3D LED_FUNCTION_STATUS;
> > >  		leds =3D <&led0>, <&led1>, <&led2>;
> > >  	};
> > > =20
> > >=20
> >=20
> >=20
> >=20
> >=20
>=20





