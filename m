Return-Path: <linux-kernel+bounces-156070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10D8AFD89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7A11C22357
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06494C9F;
	Wed, 24 Apr 2024 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJw+/Dln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108044A32;
	Wed, 24 Apr 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920521; cv=none; b=ehkLg1Zajm/hYAba0E0tPYOWIH1VxulZV7ScRYSJPSqYP+pGaciJebU7SWNX8Ne8vOyft24YL2pAykujysOkmxY/gRC0Zpm4Vq+YOirU9d++OxrWodNFBDtzQSq85avtCrWRqA2XIx2gGceOsM9ObPjccM41EOV5ATofwAmNSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920521; c=relaxed/simple;
	bh=FG6WT1YIudhRBGBeLBsnxzzVAv9mMWRCM4eJusDUt6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlG8LuTLrLBnySZ2gFIAtSihx77AjWmCMIgn29UeW3wxvE7FjzBEvVj2H/GubuwPztb8zliIS0Pr/4MkYBuvdCjOrYzySbIjlSKyhxk+kQc7l2bMYYS8wGo0QgJDvI+SLiyOLmXSYbv9rop66Y3XlHpFyml9OlcUnWzgtrZnNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJw+/Dln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0612AC116B1;
	Wed, 24 Apr 2024 01:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713920520;
	bh=FG6WT1YIudhRBGBeLBsnxzzVAv9mMWRCM4eJusDUt6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJw+/DlnUJ6sU5ulqJ3i+B6KIgv36VvHxQcX4k3DAjuoyvM2+fDdI0wS5b87/bkmA
	 MR3k4UwTAgLgA9UQfO8TGOzTl/jXq2g1Aa5ApuuAcEPlQxrgmxCJ/kn7MKFioLrdAm
	 URtTduTjyHgDSnFcYa4d11LZNBXJedrD3yyISZjV6gnN21L8Na8sig4V6NwB5xnQku
	 Kq/zXEFBGRbhDv26wWnynS3RIEiFaVlfZhlUOKSwISgF7GWYQjhTuMJyR6LCRYeTka
	 lHqiwHHVloLhF01VNAJ0nv5/6cxsBCvIICN3SxOsy3Hgh4zjkuebq5jwvQaF1IUAZP
	 0RvUQw7Z+9Yhw==
Date: Wed, 24 Apr 2024 10:01:56 +0900
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-ID: <ZihaBGwVRpI9hV0B@finisterre.sirena.org.uk>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
 <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
 <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
 <D0RIXN4JG6ZA.4W4HN68M9U6I@bootlin.com>
 <20240423-epidemic-schedule-6fa9869b3e87@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5NS8qMoZHyi2Ue3W"
Content-Disposition: inline
In-Reply-To: <20240423-epidemic-schedule-6fa9869b3e87@spud>
X-Cookie: TANSTAAFL


--5NS8qMoZHyi2Ue3W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 06:23:16PM +0100, Conor Dooley wrote:
> On Tue, Apr 23, 2024 at 03:08:05PM +0200, Th=E9o Lebrun wrote:

> > Thanks for the pointer. I've created an issue over at b4 to see what
> > people think about this matter. Current behavior is not intuitive as a
> > young contributor.

> FWIW, given I see `having a more confident comment such as
> "(commit not applied)".` there, having (no commit info) doesn't mean
> that it wasn't applied always. Sometimes I've found that due to changes
> in the patch b4 could not detect that it was applied and reported (no
> commit info).

Right, it can't prove a negative - if it can't find the patch it could
be because it wasn't sent against current code and got changed
sufficiently in application to cause issues.

--5NS8qMoZHyi2Ue3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYoWgEACgkQJNaLcl1U
h9C8nwf+M6jC46HsJsqNP1PRY9pjRMyT3AQW0H3wNNL8oUBBSvB3W2bj24C58F0u
t+PFR0xaEVPfXCWG2GrCaBc3AE4ZhvbcDc+sjMo/HhEBt8AK8/UkVRdSClyfFAnE
LIuSQaYoFdI+rDDkKBtpdSXRYESKR/vEokl2r1b5fW14JYz28Olnih/T6p9sn/YW
2k/2AxFZfPRFENAb04cl7VGEdn2AJVWAL7nfmB8YgNobZ5xzaAyV+I9uDKNdSops
5SnImX5KnHXy8sXU6HJMSgwCM+ebaK/1VAQfSESj2debilGRNychlThh5r9nZI3J
EG+up4J2xk+r2lkix2Zzu8/eaZN2Ug==
=l1gO
-----END PGP SIGNATURE-----

--5NS8qMoZHyi2Ue3W--

