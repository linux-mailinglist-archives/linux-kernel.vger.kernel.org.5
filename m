Return-Path: <linux-kernel+bounces-157877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B08B17ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195CB1C22C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC4A50;
	Thu, 25 Apr 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B12pKhcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CE36E;
	Thu, 25 Apr 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004388; cv=none; b=selQ3jwt9TaEU1c5rfWs2f+HX29aYDllbNjIMq3GT94VaNx3vw0zwWOp8isZ81weFHElG1RN2+H8u3JeU8h3u1HfRgEY0XdZmNWW5BBn2WudLm0QXd5d+sokbZKqO/+mkuXYqY0r3Dhn3+mIT1jLx9xv2QMfnsKoigK7+prhN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004388; c=relaxed/simple;
	bh=WnfatMnZ7DsLt4qQJGNxgG9a1O4mRAFq+EIPLHMRPjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M883PzJFUuT6XEMBl1RI2PDwBVf6UKZdu58QfrKP1n200jMwiecX6GSxw4cs5UnJgmiX3NaPt7I8Rb1RbMm80AkZPYzr/rf+m3uty4Aurvrtw3BpQ7cT+QSWvwDA/0fbw5GJnQ3cjS+D7Aql+5gW2ys18S5+NsvydkRZtVXuwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B12pKhcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B560DC113CD;
	Thu, 25 Apr 2024 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714004387;
	bh=WnfatMnZ7DsLt4qQJGNxgG9a1O4mRAFq+EIPLHMRPjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B12pKhcSOVyl0Kn+T+f6WWram1wTQgJh2g3Mt7jQtw2z7GKyj5rvgKimEmyK5jt/l
	 51BWmKrDJFSBCjeYzf2kbYDGP7adaTOuBiR6C0rUSYvd5g0f9I+6QS1SlmtNz/BeKo
	 eeBGGLvg+FMbwvJR/ApJXiey1kVNNLj4i1h/7EziTy+UOJWcaIj315e66U6uHLMqot
	 rOlbNLQGHOx4oL0afYbLfGKGl5sXR17FJeHTEs5X+7tx+cmbKfh9JIMC5AQYRzrKkO
	 Knp6xoJbSAfVIF/rt/hldrj24pMXS6LKG3N31QwIBE5fIPEtAB+kCRkexhZom1vjMs
	 7Ua/8vJmLXpKg==
Date: Thu, 25 Apr 2024 09:19:44 +0900
From: Mark Brown <broonie@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Conor Dooley <conor@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
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
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-ID: <ZimhoF_Rm4J-Hx9k@finisterre.sirena.org.uk>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
 <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
 <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
 <D0RIXN4JG6ZA.4W4HN68M9U6I@bootlin.com>
 <20240423-epidemic-schedule-6fa9869b3e87@spud>
 <ZihaBGwVRpI9hV0B@finisterre.sirena.org.uk>
 <20240424-calm-wolverine-of-drama-0349dc@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UrurdvMxrDj/5aGL"
Content-Disposition: inline
In-Reply-To: <20240424-calm-wolverine-of-drama-0349dc@lemur>
X-Cookie: TANSTAAFL


--UrurdvMxrDj/5aGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 03:53:03PM -0400, Konstantin Ryabitsev wrote:

> In general, though, I prefer to push people in a different direction --=
=20
> we really shouldn't be fixing up people's patches, because this=20
> misattributes the code to the wrong author. Instead, we really should=20
> either ask senders to send an updated revision, or make the changes in=20
> merge commits instead.

I don't do that - if this triggers with any of my stuff it's either that
the patch was dropped or git am did something.

--UrurdvMxrDj/5aGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYpoZ8ACgkQJNaLcl1U
h9AxPgf/RptDzTx87oUXDhc4KhKk/qu0/0AIepdP4sOQY7OhdavtITZyL3rSZ7rM
tIFcViQ/jr2q2LahPE1XeVIPqdrBYjG3g5JILHoShFJtkuaRxQhQLdHhKsKhR45c
g8OFDixkwiyPYCHpO9Op7T14EGE1xEwIVn9I8n1GZrk3TbEuT+70PnCQiNvrO4S2
CAURaYRm3pUijyf8nzcO80/DWsPnegcZEifupJ5cGtv1YNMlUJ//zZt0wW2lSLX3
nGcY17EwktRboYV3hGWUigM1D80NcUxpIyjQMYjKUkdW92R2Zr+ODWUTF2Q0fUE8
hI1hASm7LlERmBgHIp+gT7jeNPGLMg==
=czej
-----END PGP SIGNATURE-----

--UrurdvMxrDj/5aGL--

