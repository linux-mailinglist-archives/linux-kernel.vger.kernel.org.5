Return-Path: <linux-kernel+bounces-35378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE8838FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51E71F2A69D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6495F57C;
	Tue, 23 Jan 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9PNHl5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBE5F843;
	Tue, 23 Jan 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015918; cv=none; b=TmCb5+UWp70MqkX0iToUepOPeoTTnxWzZNhk4tRdPKbXMfcCOME3lpjEV3fke5rCAkLdVDvYd2PDMd809LMlaBRKybRfE6CIrqXCACrOdbijvPw914uyD6h2bIZjvOXdCSkD59gp6azwq80czDCIQrLAyNhu9NS2pgp8EBw7o6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015918; c=relaxed/simple;
	bh=jUJmr3MKh6GfPKXCSJQP/oiQo6FM8QOB3DRCAQ7dhvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOrM4SyzpaRaVxXyqRTIJpFvvID5n2lkpzrtZ9x6ouAR8BXhWQ2b7gNwO/dLBthSKFLk2HaHxdZQEEfdC4ccPWGvNdYVLlhUmls6JNd3rzQD3p5seWxBF1DpeoriSBrhXAciYRukRnNwlqDZ2F3aP53XJwVeKtBO0f2DfFDan58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9PNHl5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E53C433B1;
	Tue, 23 Jan 2024 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015917;
	bh=jUJmr3MKh6GfPKXCSJQP/oiQo6FM8QOB3DRCAQ7dhvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9PNHl5uVDroQEmiOaUiH4WKTpMTFESXOG/S+wQ+6d/EJe0n3LMCflFEHURPQWGO/
	 yiN2R/STCysUUVRKaflexpIsU/nORKz6NHPcuYra+NB2gNVjgtAUudB+0J3K9uD7yP
	 /DTkSPq/zUJ6X9dbsY31BUkrYnMd2g5Q2OCwMuY2iUOc/QxL78+UllLg4EYGk7Q6bF
	 KF7TVu716yQC5nKjo+DoO1lo3mpcLJTGb+CkW3WgAAnBvvnaSdDCfHEogwCPsEhXCz
	 43fe0u6/RpQ7nB5iyCVIkZhKEp9JyGEzMrFvKsYp1KC9WLyjk+s17y49B8s1Gb7UrP
	 mzmH/ylLTyhvw==
Date: Tue, 23 Jan 2024 13:18:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Message-ID: <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ziouRJqsRP9cN+2H"
Content-Disposition: inline
In-Reply-To: <20240123120430.75c7ace0@bootlin.com>
X-Cookie: Stay together, drag each other down.


--ziouRJqsRP9cN+2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 12:04:30PM +0100, Herve Codina wrote:

> Moving the SPI_CS_CNT_MAX value from 4 to 8 is not enough to handle my case.
> Tested moving SPI_CS_CNT_MAX to 16 and it was ok.

OK, I've also heard 12 as a number which this would cover.

--ziouRJqsRP9cN+2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvvKgACgkQJNaLcl1U
h9Ca9Qf/VRAuvAamqF9wP1bYygsVMfbG82jkiem0hOXJ8ZdbHzSLJvvHNsiGhzju
fszh1i51JBrcu2UnYhMmk5enZnvazTFMqYEuvmgBQZBvixGTNqMwftJ+oWap0+9B
359t7nP/rnvpnI0CINMkV0LVxRvHX4v7HuAotnVgPL2mJCNzVyKKcy9HEaLasejz
eAgpTSNOLka3wKHag5CB0JMdq4gqN+4Fvrmonr1s9QJV/yZ6wsNtD3oxgwD+Eh3h
mNVGPMg0Ttr28pag2AkY9g/nQkHkFB9j3/V6rYCNiTb5ltWCGz8Ha36o8nwRGrCi
Xfzk4O2mmfpSrsdYhE85R/5v7CRU6w==
=N01d
-----END PGP SIGNATURE-----

--ziouRJqsRP9cN+2H--

