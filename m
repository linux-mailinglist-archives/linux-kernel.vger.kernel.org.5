Return-Path: <linux-kernel+bounces-106343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8541187ECC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BD6B21893
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29B52F77;
	Mon, 18 Mar 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW5D+Bib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB553383;
	Mon, 18 Mar 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777307; cv=none; b=iL4xGelzCpmW69T306NbQ6CE9l/qfz3vfwu3/UodeKsRJzJ1DnWDwa1T7tTqCffvJe3msXVsngDKUCVV8ZpyLlqzqZbgMcnrhv3UsacBsFDsKQb94xDK7/jlTTc0BikEIvyACuvSGalCf/v7wTAu/a7waTd0V26265sfMdf+29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777307; c=relaxed/simple;
	bh=dn4Mk0NAISKw4/N13srMplC75+6kBOMmaf/XVYCYjlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDdWGo4RBmFuuCM+YWYBKIDNOLdb4hqvYjEJKKlHynE3jsIr04OE2no1ZkzkN9EQVRm6GWRwzYBP3htaU9kFaZYho9O/0YqN1TKdD1F5SK4lqWf99hLtW/uHVqF6zmh1xnvMy9CCutJjIXI6NisRD4++BYQKBkRjUkLMHan3yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW5D+Bib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0061BC433F1;
	Mon, 18 Mar 2024 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710777307;
	bh=dn4Mk0NAISKw4/N13srMplC75+6kBOMmaf/XVYCYjlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nW5D+BibDvQ6CgkuaG5ja16EmbJb6gy4ZFh3o11fxMI3HJFmIVNuMQhf/SqiF24W3
	 Oe0Gj4mYcMAHmXdESGRQjhKx4kT5ThENJfMNSGUZDch4O9ZG8VPMXrGzhrUGlKobk/
	 c/CAgRQv/FfQbEhFHFE+rE/VUmGX2cy3tVC1q5wiy7rmMC0wWavMv9qix9oqc7kxWW
	 uhfd++K0br97L3gFBx0GvQiQwWSHmHB41OE++axTSkg/0m6Iy7tpg8UP/SZvE1c+aB
	 0xLNP8peByPusiYS94wkmcfhbRN5BDMI8ojovbOUmDEhVrEn7rab3kHmci0+jI1aTM
	 CZEOw3gEB/qsg==
Date: Mon, 18 Mar 2024 15:55:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Butcher <adam@jessamine.co.uk>
Cc: benjamin@bigler.one, carlos.song@nxp.com, s.hauer@pengutronix.de,
	shawnguo@kernel.org, stefanmoring@gmail.com, kernel@pengutronix.de,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst
 length
Message-ID: <98914a36-e5dc-4f44-bf3e-c237d803a7e8@sirena.org.uk>
References: <20240313210258.5990-1-adam@jessamine.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZRYg3tMygsCO1ry3"
Content-Disposition: inline
In-Reply-To: <20240313210258.5990-1-adam@jessamine.co.uk>
X-Cookie: I have become me without my consent.


--ZRYg3tMygsCO1ry3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 08:58:19PM +0000, Adam Butcher wrote:
> From: Adam Butcher <adam@jessamine.co.uk>
>=20
> 992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
> corrects three cases of setting the ECSPI burst length but erroneously
> leaves the in-range CPU case one bit to big (in that field a value of
> 0 means 1 bit).  The effect was that transmissions that should have been
> 8-bit bytes appeared as 9-bit causing failed communication with SPI
> devices.

This doesn't apply against current code, please check and resend.

--ZRYg3tMygsCO1ry3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX4Y9UACgkQJNaLcl1U
h9D0rAf+JpjGh4Vbmsuza2/SGG1M7Z9mIQpkMqQka+4SaFM/nAs+PyG6FHosvFa4
Xz1KYIYK77xzsT3IVzXQJ/jfZ0uG//slbbWPV2og6oispMvAnizMFAC/6uk/R3rd
K4p6iCXc0KjXhiPmilRBbEPCDqNS6g68STCisQLPJiJCQE+ANV8CPsDJG9F3qnQx
uWrqddeU1T9KyOpCZVBcJOOe/o1KEbZfD2gV7vODWSypox5NRt0VIEN3fNc33Jhc
+8tFddLlA5DcsBkupP4aSLH1+5efhSawcCouisMjJRiL5Cdbv6V+uoUo/5jeap4i
ul49WCy/f3b6bXdkDNzVWIvoA7y9mQ==
=YpBk
-----END PGP SIGNATURE-----

--ZRYg3tMygsCO1ry3--

