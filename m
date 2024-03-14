Return-Path: <linux-kernel+bounces-103308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B703187BDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4772BB222FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31625CDDD;
	Thu, 14 Mar 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRVIonD2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6D5BAFC;
	Thu, 14 Mar 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423329; cv=none; b=cvdhBeI1yziNcrT/cbi01xHhjQLfOOZStzwqz4ppt/Jxoz2lGhcWm0c4UHnqqlvCPv45UmciIZTZsyq3efBf7fEw9bd05b2CvUSHBJteR0QMxk+mv27Id5NF29UWKkplb74Xg4U0H+Ab0a2LPHSxoSJitEIKudeZmyXNWYcAtuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423329; c=relaxed/simple;
	bh=ZBWof+Ltt0YZVUZlvq3aDlNQeUR35EM6F2BhEIiTShs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf5iAFtSgLvLHIp3lgY3/yX9fSg6fnf4n2bOJpZ9/ZXMt0BJAxWwKJ3wS+qnhzM2Li3gT1ukkkXPI7hCZI8K0Ye+dVIVcr+LsRbkqCBmFmG2CJtxHmEa8TRgZtUf8wh2JOOKOQSCvW+eJJ68peYBCW3mGsDqfphafo/faQFJaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRVIonD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B373C433F1;
	Thu, 14 Mar 2024 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710423328;
	bh=ZBWof+Ltt0YZVUZlvq3aDlNQeUR35EM6F2BhEIiTShs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRVIonD2xnshphJrR5rqhbwcw0eOUMESaatovZUH9sDSpvGQbin0wBU4uAMHTWJEj
	 f1Oexrv6hwMnyR+WpJ58EplFnlx0uAPXTAxALM6baI1ZRrsTURV6G48Ifuw8i5+Fsb
	 D09Vu5My4j8R2jbYQeOxKdaY3I36Z4/LJU1xfDb4PwxhgLJryGIqnSgeC7xqh9teC8
	 HKgSrYGtgvU43qvCNCdi7VKrqPj7POop0ojiOT/dCZtENEnAjm3bCVrM8yoQYfyNAJ
	 vl4+ZWi/WTkWm//+rzVGA8LevtVQr3EKDEH3PNMaLhqnXPrIrZndnpt4AWJwRadKi8
	 SQmm4LKuZbHxw==
Date: Thu, 14 Mar 2024 13:35:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Harald Mommer <Harald.Mommer@opensynergy.com>,
	virtio-dev@lists.oasis-open.org,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
Message-ID: <741fb34d-f94f-49ca-8f98-a59993d2f8aa@sirena.org.uk>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
 <4ca0392d-a9c0-477f-99a6-4245230e6d9a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kYeBDGM67pMmD88l"
Content-Disposition: inline
In-Reply-To: <4ca0392d-a9c0-477f-99a6-4245230e6d9a@quicinc.com>
X-Cookie: WYSIWYG:


--kYeBDGM67pMmD88l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 05:17:50PM +0800, Haixu Cui wrote:
>=20
> Hello,
>=20
>     Please refer to my comments in virtio_spi_probe function.
>=20
> On 3/4/2024 11:43 PM, Harald Mommer wrote:
> > From: Harald Mommer <harald.mommer@opensynergy.com>
> >=20
> > This is the virtio SPI Linux kernel driver.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--kYeBDGM67pMmD88l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXy/RoACgkQJNaLcl1U
h9BjaQf7BiSr5NdqpFYcyxO3IJATI/zRyOCorULXlam1aLwtl9xCPaELrbtQF0AX
zv1hc5JjEeKf6yIUU8S8HR4F3LjG2RXur8Ro2YxkS/GepJdYAbHPdFQVele/9X2k
/5idDQLGLg9qJ47ciQ+4NO9kO7ajAbvG5ROsg18NQ7qVx5H+OhGOasoPXNXRnhRJ
2r2eIwLqyvsM38ePCUoxzivJ4+LtnZ49xk5diNt7kgwjpA0w8xdc652renuOVzrl
4XbS/NLww2wYNZ/Urj82ov3Yaj7OX/MBBiOzfAx6BFIqlLFSFD/E14unCVWyE+vF
ZFoAi8eQXg/onZmFnaDZKBYJjo/zUQ==
=YmiI
-----END PGP SIGNATURE-----

--kYeBDGM67pMmD88l--

