Return-Path: <linux-kernel+bounces-35409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5983908C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A30A28D179
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0F5F842;
	Tue, 23 Jan 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LibUh6Yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE35F571;
	Tue, 23 Jan 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018032; cv=none; b=rN2EJP58E2kK5U9x8q5Tv7+uMB/yFm1NSoxx744BAXIRICW3MZN2mBdXjO1cCIHE9DX+5AZj+AWJFDpz1Uz4I4NsH6csPxtv4WyQ0cfR6V5wWKiG6efnCgo4F9m+BG3xlf/mONU8+7sNFSzCHRstx0OCsdZXdsOiB+kDs44jkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018032; c=relaxed/simple;
	bh=lHE5qALm5p12AB5xvDSRbe8fy7YDuNGo659MXcjmjg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHUr3vtv4H0XbANQH1A/A2gz/j+rz2UuTtuoym8vc5W1rFYE9AxHgRaOZ8chZ4XQa0QjRKviBO8umHuVoqSjshLApIxgKS6XJ5cTnRYJ+zlJdi2vd+1CniIU+kHXN5mjFih3rfMFPV90pHMghDcWmB9SrC/IZKa6/+euh9QllLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LibUh6Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF38C43394;
	Tue, 23 Jan 2024 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706018031;
	bh=lHE5qALm5p12AB5xvDSRbe8fy7YDuNGo659MXcjmjg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LibUh6YzFkdUMB5x2vFIMHn5ljzZklpQUEiBWgYGgCLS0iN+7E9H71pJJUTuv5v24
	 XktRUEpqulVCDQuLbUYwyHbKqRUkzsJ6EvqDBJLMUYicLRjtN3PTO2iPxcHKPuE9NT
	 /mi6gbNT+CZepyR04uxdX1R0Qz3/oap2nrbrMNGUYiSwbX5IkJCZUhlJN1jadvgi6l
	 wwx5DaglOxbrBFGyBdoMkNleEfepDSIeBJtxJaUsNxYpFZR/yGrOQBClykVKwTwsaZ
	 WFZGhKW8pgTMb7JKk9RMA7qvTqPtHZIqsjaC0eixb4XeTDfRe+3kIc/S/1Rruxfyew
	 hv2PShG0Npm4Q==
Date: Tue, 23 Jan 2024 13:53:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Message-ID: <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksPexoEfm+2lrFiK"
Content-Disposition: inline
In-Reply-To: <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
X-Cookie: Stay together, drag each other down.


--ksPexoEfm+2lrFiK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:26:04PM +0000, Christophe Leroy wrote:
> Le 23/01/2024 =E0 14:18, Mark Brown a =E9crit=A0:
> > On Tue, Jan 23, 2024 at 12:04:30PM +0100, Herve Codina wrote:

> >> Moving the SPI_CS_CNT_MAX value from 4 to 8 is not enough to handle my=
 case.
> >> Tested moving SPI_CS_CNT_MAX to 16 and it was ok.

> > OK, I've also heard 12 as a number which this would cover.

> By the way the comment in include/linux/spi/spi.h is confusing. This=20
> SPI_CS_CNT_MAX is really not the max number of CS supported per SPI=20
> device but the max number of CS supported per SPI controller.

Well, it's a combination of the comment being confusing and the
implementation being a bit broken - we simply shouldn't be limiting the
number of chip selects per controller, the per device limit is much more
reasonable.  So ideally the code would be changed to reflect the
comment.

--ksPexoEfm+2lrFiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvxOkACgkQJNaLcl1U
h9DsFgf/QUPZ739YoVwE9AXX/Fu7c+/pK0+faTgklg4rcrPdwL4KfG2hDxeSCIgO
VrIS2x9/tHUAm8Ghk7K5gh8CT8QpNm999loqbnAir3W0NUc2maVrLhXq7CLheFD8
qL4RXybqiojosu1HFZdmJTK7K+qgMxJ4sxXGc+yBk2Eh+wN7SBI5UH8YX7oLMoGx
+bUYOZ6PV52rx8ZxUp2t4AOk8y6lmeWv9aDvkkTl7mTk733N21TjOHvT9QIolcyM
WPK3SZ6/8WNu52LOFkkf2QeXrhAQ52jeiI1MXaKSfv9U0MxTG8074g6YiiBNzm4A
7GzfXCbs1EXXZ6Zs2feBR2DLcTSqFA==
=zIhb
-----END PGP SIGNATURE-----

--ksPexoEfm+2lrFiK--

