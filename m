Return-Path: <linux-kernel+bounces-18009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAD8256F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C144B230DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20062E652;
	Fri,  5 Jan 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NujSl3xE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2332E642;
	Fri,  5 Jan 2024 15:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3430C433CA;
	Fri,  5 Jan 2024 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704469541;
	bh=yv8MBekVbDikHe5aq99nS92UsxwHIOnDrh/0Ck2Muzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NujSl3xEeaaCZBTEzp9qVN6acpUr4FeN4YhlCdUuTKCv2FbGmWxjek7VqsIGHItYi
	 DeUf8B9sA4ntBeFsuYHhz4sxAchtu9IDt7tT9yZjm9mk+1SM44OTJadZqlP+s6CDg8
	 zS1x1lzEqaQjNTvqBiE31PHLrAz3src2prMSNeHCF6gh09xLiC3KRrhlm3bYOlZ0FD
	 RjVPFMgaNPXVCA/XR+4a9hBDw0ynnX5oDIpyWFjF0G0Q2dPyvQahhwfXKXCbX2Mwot
	 Yz5jQuD0jtdecAvwbanHljTLUkFLet+G/HoTdhwfSLYZl/T+H5qJ8jAEW55LEKl4rV
	 4v9haR95mEHOQ==
Date: Fri, 5 Jan 2024 15:45:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-ID: <50ecc7bb-50ac-4846-8a6e-fad9148c948f@sirena.org.uk>
References: <2024010549-erasure-swoop-1cc6@gregkh>
 <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>
 <2024010554-unreached-colony-96dd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bv1yTkyu7qVkQm0"
Content-Disposition: inline
In-Reply-To: <2024010554-unreached-colony-96dd@gregkh>
X-Cookie: Your step will soil many countries.


--6bv1yTkyu7qVkQm0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 04:05:18PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 05, 2024 at 02:55:01PM +0000, Mark Brown wrote:

> > Whatever makes the driver core able to handle this doesn't seem to be in
> > mainline yet - what's the story there?

> Odd, what errors are you seeing when you build?  I have had to fix up a
> few subsys_* calls for this type of thing, but I don't see spi_bus_type
> being used in those that I saw in my local tree.  Did I miss something
> else?

> Maybe just wait for after 6.8-rc1, it builds properly here locally :)

It's this on an x86 allmodconfig:

/build/stage/linux/sound/soc/rockchip/rk3399_gru_sound.c:471:29: error: ini=
tialization discards =E2=80=98const=E2=80=99 qualifier from pointer target =
type [-Werror=3Ddiscarded-qualifiers]
  471 |                 .bus_type =3D &spi_bus_type,
      |                             ^
cc1: all warnings being treated as errors

so not actually a core thing, I have to confess I didn't notice where
the assignment was when I glanced at the errors.

--6bv1yTkyu7qVkQm0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYJCEACgkQJNaLcl1U
h9DyRgf8DBjFxXexCUv44GDWyzkgSGPee89+Wgegym/pmJRwVwIWtMSiXy7tnD5b
Xt6efZmoF+WSJEQIK0Pl+QnPd+7+np5XNrJYtU3zUKv/o6NjEA8TkQNIFXlhXNAd
+5toRMolz0+C3q/UgedOB7qW8rGjn6sirdw2lPq8WnFE/1q4tcd1KOVtpvqkh6+G
lPgpYgBwfXhbk/PAXDNz8fcCP113PcxcWxvgI8OsQ6lJ+LxkEYAokUlnvPtgYLni
zI3ZU3KgpQq3mzanWYL0rAGWfN8Newi+Wrw4jG5X0kBytUdUurBRcdovHq4edObx
rIF+i9/YwrZd7DzbU9vrV4pY865/+g==
=5xdW
-----END PGP SIGNATURE-----

--6bv1yTkyu7qVkQm0--

