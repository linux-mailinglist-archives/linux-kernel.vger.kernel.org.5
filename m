Return-Path: <linux-kernel+bounces-121779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5288ED93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3442C2A2CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0D14F126;
	Wed, 27 Mar 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbKfIGdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013214386C;
	Wed, 27 Mar 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562597; cv=none; b=QAQqHLa4+VkF+Xgnd7M5kqAJQzTvCabp+VpPcskPFS3R2mrMTqQGJ0e0h/vAiwxAcGM4ohEsEWAHW0u3Elvufs8nPUGcq6Jb7GQ6yVTXfy47EyTGo93ieGOQH1So7/TN6AweyP5lgzJ0vNDCJYBW3v+zRamieV82aZR3cqTTvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562597; c=relaxed/simple;
	bh=0O8XCY11WB9l5WV+H/o+LxwXGJuiHlEDHBA2DM0WnNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUVKRIvecp1N1UzE8GckzsGTd19H4K1ud1Uaciina12o+CEHSzjYQSXTgrJ/JvZ0ebJHRw7AMAqqM5t+VL7RGRxOCSpy6dm3uo8o1WoJg0k5IYRDrthEFvSBBbshST5Gu6/kUbf8DzKyQj1syYnUIWBKH1Knoy1MlnJsBAPhqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbKfIGdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8FBC433C7;
	Wed, 27 Mar 2024 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562596;
	bh=0O8XCY11WB9l5WV+H/o+LxwXGJuiHlEDHBA2DM0WnNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbKfIGdymFcXCV4gfFbDa95Uq9FJ5xB6pOYGVLZYOn9MoYlCbWkgzyyTMaWGK+Jmu
	 lWXVTGJ0TCUHbYf0uJimJ0scqKUxYXJ/jdb08X5UeYV0iUpkj9+0Tjbwir1SIO+LhY
	 N6+9aH5PaTWhHaLZo4DNHBy1a70e9zt9dHYIUuYfJTjpri8nOjcYRgW6VhJOSLVTCJ
	 sJymvBS9NJVlVdRkuedfQtYogCa9EQC4ISQlkI0zJvRwi0WwcTxo287SBxGCMPuDdq
	 vaAB6IfTkgxrdaRK0nXMCQ7en/W/YXaE3lRkALcV48jwu0bpeOfizgnFFa5b8TxRxI
	 yEqVCvdk1Fotw==
Date: Wed, 27 Mar 2024 18:03:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H_v1_1=2F2=5D_dt-bindings?= =?utf-8?Q?=3A?= media: starfive: Match
 driver and yaml property names
Message-ID: <20240327-unlucky-bulge-2bf99a8649be@spud>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
 <20240119-despair-festival-59ab2d4d896b@wendy>
 <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <20240119-preamble-calm-7724e17fcebc@wendy>
 <BJXPR01MB0662E6EEEEF888BD90A1FCE5F275A@BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn>
 <20240122-uncivil-almost-631137081fd9@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zzCqoLyA9q69ODhP"
Content-Disposition: inline
In-Reply-To: <20240122-uncivil-almost-631137081fd9@spud>


--zzCqoLyA9q69ODhP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 08:24:51AM +0000, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 01:33:56AM +0000, Changhuang Liang wrote:
> >=20
> > > On Fri, Jan 19, 2024 at 12:57:22PM +0000, Changhuang Liang wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now
> > > > the content is safe
> > > >
> > > > Hi , Conor
> > > >
> > > > > =E4=B8=BB=E9=A2=98: Re: [PATCH v1 1/2] dt-bindings: media: starfi=
ve: Match driver
> > > > > and yaml property names
> > > > >
> > > > > On Fri, Jan 19, 2024 at 02:06:38AM -0800, Changhuang Liang wrote:
> > > > > > Drop some unused properties for clocks, resets and interrupts f=
or
> > > > > > StarFive JH7110 camera subsystem.
> > > > >
> > > > > What do you mean "unused"?
> > > > >
> > > > > Do these clocks etc exist but are not used by the driver?
> > > > >
> > > > > Or do they not exist at all?
> > > > >
> > > > > The two are very different!
> > >=20
> > > > These clocks etc exist but are not used by the driver.
> > >=20
> > > That's not an acceptable reason for removing them from the binding. I=
f they
> > > exist, they should be documented, regardless of whether the driver ma=
kes use
> > > of them. NAK.
> >=20
> > If so, how to avoid the warning of dtbs_check.
>=20
> By also adding the clocks, resets and interrupts to the dts.

Going through patchwork stuff now that the merge window is done. I'm
gonna mark the dts patch as changes requeted. The binding (and dts)
should describe all of the clocks the hardware has, whether or not you
choose to use them all in software does not matter. Can you please
resend the dts patch, with all of the clocks, resets and interrupts
present?

Thanks,
Conor.

--zzCqoLyA9q69ODhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRfXwAKCRB4tDGHoIJi
0qQXAQDfBiXwvtzOzuvMjituCroQrHpvVV9xsdNonK911KyCSwEA799G/wBfPBYb
V3sbl2B9KISp0AvY5FbPCNrcFvvq8Qg=
=gcwu
-----END PGP SIGNATURE-----

--zzCqoLyA9q69ODhP--

