Return-Path: <linux-kernel+bounces-102346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B387B107
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2B9293895
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA36EB40;
	Wed, 13 Mar 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/dUXMnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07A60BB2;
	Wed, 13 Mar 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353953; cv=none; b=PdE7QYFVohsh3aOpN/uyEXWqbsVVjYpeF1L6GpY0T/JvsjUI6xFH/wBDPQfRFXmZcLNsd8yFYo0vy8hyZnD6/GRlbAw40bG0JEgsN8K+DhEgEP4k0O+zsP2At7DfdjZ6UvI7MvCeYr8o680HvHPUygjvUcJ2idyQ0Y9hjjXggAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353953; c=relaxed/simple;
	bh=jcQ51BbBPMa4cDIwbdORtxDz4pgEYRzkZCsa/H28N1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJKKx0zVUYxn4M0Brgad6pjSoSARh7M25GC4hCTE0/Py6KwkvJ3Eenv7h8muBiiZmTMt6e2WC31XVS04Q9PjBnW1XY+akaqhiXK65NmmWcsZ1l3LpmQqrjZKWsy6wWk/A1c6Lgfd0SC+wZP7UXvY7HFJUjiJjUBXSRjP4apYgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/dUXMnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F642C433C7;
	Wed, 13 Mar 2024 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710353952;
	bh=jcQ51BbBPMa4cDIwbdORtxDz4pgEYRzkZCsa/H28N1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/dUXMnzuKsdgZGgLI2cg3PsYl4zc+t94S+hGf2obk79UtydDsaOkSTkpVoKQaV34
	 xWeQ2m5kSrnNUBZdFa0+LfRRK3Bi6B0qontxBrPOZL43Ry/LHCZeSyPngaItsDp9l6
	 dHCCuzOhP8NDA55cXZNXsnmJAgbfC71/L2lWJqmzLT8AaDJP8InPxAM6UJVTxSBjag
	 QjtD4IS2q8Jl0htrHwHxYNslFkrn72fc/u5lCKPFluPQw5UAXK3UN4n3IVRYF9itjL
	 SVy5BKPS++vJyuwYgzuIE3RRqQB1yjiggCNjaIgsOFaAZhAM1dy1h/e4LmHFrgbseh
	 /hRPlWoAG0ATg==
Date: Wed, 13 Mar 2024 18:19:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Butcher <adam@jessamine.co.uk>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	linux-imx@nxp.com, benjamin@bigler.one, stefanmoring@gmail.com,
	carlos.song@nxp.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-imx: fix off-by-one in mx51 CPU mode burst
 length
Message-ID: <4879c575-7101-4c4a-9e23-0e4961d46b9b@sirena.org.uk>
References: <30b2a315b36e1ee16c0217b32b95a605@jessamine.co.uk>
 <41a7e7e46baa40ce28ad0dcb2ee455df.squirrel@webmail.plus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fy8kL3rfaji1NWgs"
Content-Disposition: inline
In-Reply-To: <41a7e7e46baa40ce28ad0dcb2ee455df.squirrel@webmail.plus.net>
X-Cookie: It's later than you think.


--Fy8kL3rfaji1NWgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 06:13:54PM -0000, Adam Butcher wrote:
> From: Adam Butcher <adam@jessamine.co.uk>
>=20
> [Apologies, rubbish mailer corrupted the previous re-addressed post]

Please put administrative stuff like this after the --- so that it
doesn't end up in the changelog.  Hopefully none of the tooling gets
confused by having the same thing posted twice with two different
contents...

--Fy8kL3rfaji1NWgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx7hoACgkQJNaLcl1U
h9DbjAf8Dmlockcel5V/shGKmKzMCtwiM64jEm/LHQpgf3kK2LJVnrFENHX8sP0x
8f1NmwNRJfvCJpaCq2VIj0KjFIkMXonti7e0zchsz9TAAetQq3osljH2lCQuaiYN
Lil/iwKb5lrcYVEE8h7CXcu8WOK/bRX2PXUFvYVjTZ6FIQQk1yk7b6M5zyGn+oXM
0oC2wcic/rNhE1siZpZHD3rlSCzt/HsdGxYlmPwDcWUr+ORYXYc5v+NOmV0iHwQ2
dJTQkpbuTfDmz9GZT1eXEYInNaonNt3326QrJEgAvBsDK06dIt0hVYuUQAv7w6/W
7+5MbzAaO7gVYvscSEC+HVe86C7ajQ==
=4X+3
-----END PGP SIGNATURE-----

--Fy8kL3rfaji1NWgs--

