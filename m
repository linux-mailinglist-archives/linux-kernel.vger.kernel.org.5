Return-Path: <linux-kernel+bounces-52880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADA849DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E511286069
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A612C859;
	Mon,  5 Feb 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJu5utXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCA2C6B2;
	Mon,  5 Feb 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145935; cv=none; b=GF8n/iqAqtDq5nHpng92QVa1OxyTsw+y3OER3Mlty60NeQyleaYIxkBBa01QtRGm/T7DL/0toT9KrYQn9vlljnmgHdTWHqR/GQ00eDizWAmgPWfce4sS5Ji8yo/DMqkKpSBv/wYhWf26GCaFTNGLdV210Dz5t2Tjw3R66/VtyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145935; c=relaxed/simple;
	bh=5H8U2s8sxkPgAP0CEtiqkR+kDtyMBSLYUju/2rUteGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnZq4D14+UMXsIqghmy+AGaoKpwbLUrb5Eo8qiKrqCGGgkJpHLIXmPzE0aVYaLIHvF7Hq6weZ/+6SkFkJzPJ7kE2lBRbd6o8HHsyKpq9d/LMdCp8r4mw2QMv0iq8QEdxCMX4Z2Yx1PFr4hWxOpBe/HA6NYa3SnsRhNl3oaleyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJu5utXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E15C43390;
	Mon,  5 Feb 2024 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707145934;
	bh=5H8U2s8sxkPgAP0CEtiqkR+kDtyMBSLYUju/2rUteGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJu5utXosnVRMOlcxFwUY7MZwzXvK31M33fxvYsmMhR7V9H5Pk7VuW2TpohuaVDNo
	 8XTwfhmnH6CSgzJFzlY6xgNTiGrV9ytpdlR3KhyVBikmjB8HDVGEPC8BCg5X8sbZ6i
	 Js42Zcv+aWIfhIj/7sh5Y3CUtR4xYVQV3o+rQX93atZD+aWXbOhzJVyyG81cvtj2Yq
	 ANG3QWgUit5pSuYDR5REHLChCAMQbc6AGdwLyCP+YhpUvbBlHzZ+OxNZRXkhofAGCk
	 CelhVzehpbFp+qy1nzpwzMi3gFAWlGorDq7YdGxwALxOrbkMWQS5Jr1VAc8c4pJoet
	 BP3dyGzq0ufeg==
Date: Mon, 5 Feb 2024 15:12:10 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Apurva Nandan <a-nandan@ti.com>, Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <ZcD6yqc+o62x2AjA@finisterre.sirena.org.uk>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+uhCJxiPCY2G8BG8"
Content-Disposition: inline
In-Reply-To: <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
X-Cookie: You might have mail.


--+uhCJxiPCY2G8BG8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 03:57:30PM +0100, Th=E9o Lebrun wrote:
> dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> controller. Neither embed the other; this lead to memory corruption.
>=20
> On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().

Please place fixes at the start of serieses so that they don't end up
with spurious dependencies on other changes and can more easily be
applied as fixes.

--+uhCJxiPCY2G8BG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXA+skACgkQJNaLcl1U
h9Br2Af+IML/4cSLO5Z+eiyFrEeWD5eTxDuA+9NYjzuwi7DYscVI3Rb0kbq+LwYE
0aSMKVOV66iXYqmEZ0+hWfonkZnD3WD7CqRJQ3Tp6yJKMc/GseDor4mqc5qv8mQG
dlEws4QRZJL8608KYcFHtw3lsJIYXLNt/bDBEbDJQX3adxRz8SV+jjRqihXDO8A6
nxPDAKbDYbHhGu6Celc9dOxwFAa9g+86/pk7ARZNCPXleKnwDpQaF3gd3T5DSuge
7oUz3xQSiVBXkafd8uWmjbfYyckF5xEwWD09ckuQQ8K2ZrDYXn1lnYUlBQerc+Dv
OZR70PQxyvWSso2Z2EH89yx+SbB1mg==
=wk0H
-----END PGP SIGNATURE-----

--+uhCJxiPCY2G8BG8--

