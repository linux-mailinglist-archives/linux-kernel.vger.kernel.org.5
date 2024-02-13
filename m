Return-Path: <linux-kernel+bounces-63568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6BF85317E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D20EB24EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6255C04;
	Tue, 13 Feb 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak3yK6jg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA955C03;
	Tue, 13 Feb 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830026; cv=none; b=ty2bBEj7p3n5qwIG4NRCde6HGV/EvLmeEouJWPbw1w0GjnfXLrdeLPpr8UIVHKr4dZLvBhRrZFqS+i49/VDzS7ZIuX/KoEHNFPTXq3VvH5hphAdz/l3xeKWB9CJpwLrCgqJEx0XahCRch4ex+9UV9ZGy/a93UN8gITClV4XWkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830026; c=relaxed/simple;
	bh=z+9VSgqO5bthw9m2XPCSK750+TzphWPWfMm9vhOdbVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5UB/tXUfX76X19Vn5CkEVyStd6ydHm4pgaNMDxwK9dAD41rxcP/fge7sohiGSFL0N7aKbvulSdveGieK/9n3O72o7+N7vTkr9ClijnjrceAXsSyN1pAYDBleuBXa19YBNBUkMHhly/nQ0Qs8nXntd2q35HcUj/xuQKd9wRRvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak3yK6jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06392C433F1;
	Tue, 13 Feb 2024 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707830025;
	bh=z+9VSgqO5bthw9m2XPCSK750+TzphWPWfMm9vhOdbVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak3yK6jg5ez+EnZN1BYr8fbMDwG+r1nhj8JYieuyIXy0OtGNubN2/EutkqCv7+6dz
	 /OacWbN+f3qKkzQ2lkZ4ZPoy/WoZ+JwGHY8qEjwUJ+WrX0Q5Zi1ouackNHWAv47/O8
	 TcOhPc6ATO+nq+aZfAplPZrsNvDCYgsq6jY8x/WmCOo38ymKjNguIqnh+9I2lzpLlu
	 qILRKspMGdEZuHbhWVhzLSCaCR/vb8A/5Kmi34uIpsROXXWSjTwGuS59X1UyaagixO
	 +llSf+vRCCzvnb9Tw4JgQluuT+y7shRrsh8wd3dK6dO65U7OmaUucJRiNRJEUnuT4c
	 o3DNJirvEYsLQ==
Date: Tue, 13 Feb 2024 13:13:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?G=E1bor?= Stefanik <netrolller.3d@gmail.com>,
	rdbabiera@google.com, amitsd@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tpcm: Fix issues with power being removed
 during reset
Message-ID: <3a09ea3b-3a42-4fce-85f8-f8408a4a2206@sirena.org.uk>
References: <20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org>
 <CAPTae5LOresaK3Epd4R_ifpx2kw21tubQDENg4OMrhJWsar-oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wNzrdL2IZ5232/Er"
Content-Disposition: inline
In-Reply-To: <CAPTae5LOresaK3Epd4R_ifpx2kw21tubQDENg4OMrhJWsar-oA@mail.gmail.com>
X-Cookie: Does not include installation.


--wNzrdL2IZ5232/Er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 02:09:16AM -0800, Badhri Jagan Sridharan wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> While HI-Zing CC pins disrupts power for batteryless devices, not
> Hi-Zing CC pins would prevent clean error recovery for self powered
> devices which is why "usb: typec: tcpm: fix cc role at port reset" was re=
verted.
> Please note that the breakage in error recovery behavior is a
> regression as well.
> Hi-Zing CC pins would make the port partner recognize it as disconnect
> and will result in bringup the connection back cleanly.
>=20
> How about leveraging "self-powered" device tree property and Hi-Zing
> CC pins only when using "self-powered" ?
> This should help devices which don't have batteries while NOT regressing
> the error recovery behavior for the self powered devices.

I don't super care so long as the boards I care about continue to
function, I submitted this patch because the only response to my report
about the rk3399-roc-pc having been broken in mainline was a
confirmation that the failure was expected.  As I noted in the commit
log checking if there is an alternative power source does seem like a
viable option here, I am not particularly familiar with this code.

--wNzrdL2IZ5232/Er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLawQACgkQJNaLcl1U
h9DeBgf9HO4xYfg24xt/Jvbh1Le5gyPcZnCGlzA0xrtgv4g1unnklA5uQ/EfFen6
hbGufKQ5/sRQ3gCxUve350Vaq/ynTH5EM6gkTLCmiYNp2KFBejcFq88+Zb8ekOMy
Tnzd4GVwHFVxQczjK8kKnjvXwiqnJBg08Dcq3i8dp3GrvxYir+Q79gRV6nHbzZvb
Toa3WxY51eRZE+1iKGK31Zeb0lmwnqHZ9LY9jmUEpZO+gzoX/FGKdyoo31ZkiIlP
NFkkQmYKc+iMN8trojxI6rguRMu8zvZpZbrm8Gx69+9rPmIEAunXbDVbV0pcj9uf
cR4Zl/H4+6Gud2N5FIi2O3Z2oZwZeQ==
=oW47
-----END PGP SIGNATURE-----

--wNzrdL2IZ5232/Er--

