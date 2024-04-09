Return-Path: <linux-kernel+bounces-137422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74289E1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8056A1F23EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC3156869;
	Tue,  9 Apr 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E75Csnkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC970156654;
	Tue,  9 Apr 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684900; cv=none; b=h11J0OPo4WKnpmY/fYk6mxqvnqwq3bPEDb+BC0hDylHoV6gPb4p1JbvYxPuC7Lrp/8yGh1ATsF5dNBFvw2U8JGxG84uyVOMhKNghInjyNXf/zJHEjnScn8/jUE3ajFGzH+lmEUxSUf0GQlspxmfMDfE/gontqsaEFFEtF/tU5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684900; c=relaxed/simple;
	bh=T1ts7OBezpDX1l3zC/ma8yJQU+ib46TGhv7XGiFfxsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7juY0V4DHLQJruXYz1K+aWbIyXaiADbs0kJQAIGUXvJZkfq7QqhRfObDUXZ4S6gESz+zLszEuVwk2z6bOcJtV/zcuMAw9GxW390ju6f5zI5R4jTj+O5Jy62+12QNLYAXHuh40rV+HHcMagpSqu6jcw/iCTvzXYlfn47b1jANLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E75Csnkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C5FC433F1;
	Tue,  9 Apr 2024 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712684899;
	bh=T1ts7OBezpDX1l3zC/ma8yJQU+ib46TGhv7XGiFfxsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E75CsnkxoyKTGMeI3DFPW8gUNblbx8SOICY2Ewjk8kx2VM7HGdJqPbawO6I6uL6yF
	 rw6YpQVkf3KSHGNbGjQ5DupOHzk1IxeRnIGlfQISCTLph3INkoCQuxBwe89fF+SbCS
	 n0iMFIPjIyGH0kHbRVqoM6Zw3ityImCfHpJxph/C5UZb+Yd3Rgk5nIQQEw7sBbVK0c
	 i/jDyEW/CGi2f2txKMAIW+07B6upDwM/11FZmPU3o02ujkxYyZc2z9nl0iPcQeYvMU
	 1idtnwthACLQCbEZOPl8kph6TrSdDsvlOnmeOWHGJ5nBQq3NxQj7oXqRNaeE2IiYT/
	 8fJi4EebacMIA==
Date: Tue, 9 Apr 2024 18:48:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	yen-mei.goh@keysight.com, jeremie.dautheribes@bootlin.com
Subject: Re: [PATCH] spi: omap2-mcspi: Ensure that CS is correctly asserted
 when switching from MULTI mode to SINGLE mode
Message-ID: <7a41b650-b135-40cd-bf55-ee4aeea74fe6@sirena.org.uk>
References: <20240409-fix-omap2-mcspi-v1-1-f2b881ae196d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/y6lk1pcp514/q67"
Content-Disposition: inline
In-Reply-To: <20240409-fix-omap2-mcspi-v1-1-f2b881ae196d@bootlin.com>
X-Cookie: I'm also against BODY-SURFING!!


--/y6lk1pcp514/q67
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 07:25:33PM +0200, Louis Chauvet wrote:
> The OMAP2 support features a "multi" mode, where the controller
> automatically sets the Chip Select (CS) when necessary. This mode allows
> for shorter delays between CS selection and word content, but the CS is
> always deasserted at the end.

This breaks the build due to updating for modern names, please rebase
and resend:

/build/stage/linux/drivers/spi/spi-omap2-mcspi.c: In function =E2=80=98omap=
2_mcspi_prepare_message=E2=80=99:
/build/stage/linux/drivers/spi/spi-omap2-mcspi.c:1274:17: error: =E2=80=98m=
aster=E2=80=99 undeclared (first use in this function)
 1274 |                 master->last_cs =3D -1;
      |                 ^~~~~~
/build/stage/linux/drivers/spi/spi-omap2-mcspi.c:1274:17: note: each undecl=
ared identifier is reported only once for each function it appears in

--/y6lk1pcp514/q67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVf10ACgkQJNaLcl1U
h9A1Igf/YSzPA9Bx/GW38yBrwUgX9b2IscA1Kc14awzmcWCkn/mmsU3r3VEgF5nE
+m5BUKJO8KCdNV2UnCWAyEbVK/YS5YLOohUfvEiI8ubM745yayR58taNl5SqNr1T
yUFahLcXtjs/O4s1K0o88qkGwfEv8UaZkVyOPoFTencSMkUEz7k+/pacmZWR8dyY
03TQayRQ3ecIJF0an1hVtvAyIan74VaSNuLZetj1RkwW7RiJXxVFwIoA9plugS0p
SSm72iMN584GvGwDb/kvnZNuv4M1PvTpZUKxM7H4Hr2KgIxUy2qWKb629ZHOOSvS
0j3YdrHEayE0BgHtuGmlnHF510laVA==
=+E91
-----END PGP SIGNATURE-----

--/y6lk1pcp514/q67--

