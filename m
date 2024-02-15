Return-Path: <linux-kernel+bounces-67378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659C4856AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219AC289909
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE9136672;
	Thu, 15 Feb 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRi71hB4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F712882C;
	Thu, 15 Feb 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017177; cv=none; b=HRvmRyk0l0nNbG5Iwe/7U42AnM40ebMieKSZNxABhgixVVzbbwc51h+OiYRg20tIO19QEp1DVgy7igqMtHMGWN0XVtysavwY0OjYt91xyf/6RUBv4GksWM20eXDWWqckvLqkTVeLAERfMtRoS4uV4JObd17UnkhnftEanPhUnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017177; c=relaxed/simple;
	bh=pk5Mt+RImQXUgBvMKAZepH41L3RMj9FKexYkzEU54nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVWB7rkkaJrrt+1WpkuBqw94fuji9yl0bqYsnyz/83ezx92euzLHpbhRksCWjFdENdEFk2W4OskNm4XkDmio7im3/NpifaOJaGeir4Fx5lHRpb40ZDuuh6BhAuRz/FaJx+b/pmLpnPx+TXpbfrHmMfoZyzxZ53eoxeo/d/oPSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRi71hB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9E1C433F1;
	Thu, 15 Feb 2024 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708017176;
	bh=pk5Mt+RImQXUgBvMKAZepH41L3RMj9FKexYkzEU54nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRi71hB4J37HDQh3t1ZfohcSCokTMBTIWFlXk8unUCZGAcnbgcFAYuiLZDhQSHFXj
	 hxT+sMSSa2T7IKUkyx7sMVbr5h3zjN/ggkblR69V4kg7xZzVEX0XWnHoIpww+EM64f
	 A/IKw8J0A4lekCriXehJQD7MMFAJLD5unYXKPBQw7v1i5jMUSFLktChLwDH/olDmr6
	 CSUZZqPuqBvJ7A4Wk6rpL/Vmhtlp2D1ikj2A+r1ja3TPU7uhZn0ER6svRLkWUeWRSX
	 tp1lzO4k5PRCYHeyCQPLN1SV82Rn1Ywh92tYhNObqXrzSMmHq0Ei9DTSfRNleeWcss
	 5jDYkHp02pV+Q==
Date: Thu, 15 Feb 2024 17:12:50 +0000
From: Conor Dooley <conor@kernel.org>
To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc: Manojkiran Eda <manojkiran.eda@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"zev@bewilderbeest.net" <zev@bewilderbeest.net>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH] Add eSPI device
 driver (flash channel)
Message-ID: <20240215-probable-gimmick-83d5dcbc4729@spud>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
 <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
 <20240214-yoyo-platinum-dcd0e7e16a22@spud>
 <TYZPR06MB6640F82C539F0B17BCDCC55E914D2@TYZPR06MB6640.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jYXpxHj7B0OPYCKZ"
Content-Disposition: inline
In-Reply-To: <TYZPR06MB6640F82C539F0B17BCDCC55E914D2@TYZPR06MB6640.apcprd06.prod.outlook.com>


--jYXpxHj7B0OPYCKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 01:56:00AM +0000, ChiaWei Wang wrote:
> >=20
> > On Wed, Feb 14, 2024 at 11:34:31AM +0000, ChiaWei Wang wrote:
> > > We appreciate that you are willing to help on the open source contrib=
ution.
> > > However, please co-work with Aspeed before submitting drivers of Aspe=
ed
> > HW.
> > > Otherwise, a misleading driver on the community are going to bring to=
ns of
> > customer issues to Aspeed.
> >=20
> > It may not apply in this particular case as Aspeed did write the origin=
al driver
> > and it is polite to work with previous authors when respinning a patchs=
et, but in
> > general there is no need to work with a hardware vendor before writing =
drivers
> > for their hardware.
> >=20
> > Blocking a driver because that company might receive more support reque=
sts
> > is not the kernel's problem.
>=20
> I agree with that and Aspeed will not refuse to support.
>=20
> However, in this case, the authors, IBM, and Aspeed already have discussi=
on (at least 4 times) before and foresee "issues" on practical eSPI SAFS us=
e.
> If there is already a known issue of the driver, why ignoring the previou=
s discussion and push it?
> A compromise is to ask for driver renaming to espi-mafs to avoid confusio=
n.
> Otherwise we need to explain, again, why the driver does not fulfill the =
SAFS expectation.

To be clear, in case you misunderstood, I was making a general point and
not about this particular patchset.

--jYXpxHj7B0OPYCKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5GEgAKCRB4tDGHoIJi
0q6qAQCwK7ClX6/ipMYZ/2VmkvC0xZdaAiUrt57wlJ0DcnoxoAD+OADevy96or/y
yayrHHRwjY2W37V1/RxOp8h0jhl17QU=
=71+s
-----END PGP SIGNATURE-----

--jYXpxHj7B0OPYCKZ--

