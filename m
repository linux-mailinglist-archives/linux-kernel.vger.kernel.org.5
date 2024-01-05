Return-Path: <linux-kernel+bounces-18065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B482582E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F032859D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811DA31A61;
	Fri,  5 Jan 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQupj9bP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D531725;
	Fri,  5 Jan 2024 16:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7DDC433C8;
	Fri,  5 Jan 2024 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704472266;
	bh=YT9ZNsftjsycktRUoMx3FX1B6YamDKgCzg0gW9xnfVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQupj9bPOLfSV/imoIA13iDeCckcijw1deztSvdocxs1xVihtorHvStLiudzww0wF
	 /3BvLq9M/0S8cavZgW7kZNv5Ron2CyidElOrjYUuYJ8N7hxtSVXBWQwURwMrmZnysr
	 +GPnNAznJa0vGtWabLjDPxwKcGBDqP5aHkr7415XOtHXdliKrqU1l3U6rFqU4JKNEB
	 90MY3scEOqM+wdW6WTvsAncUR+pI2za5DtrKc/2+CP3j8/8kXJQcOlU8ss6gtkrtsO
	 xAEisIeleZW4aPLjb+yfiHJbQLCMDB0vFY19Qvx0vf/wTYrgxPEJXYnrUMyD8ifKgb
	 k1GQfAtEEj5pQ==
Date: Fri, 5 Jan 2024 16:31:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: qcom_smd: Keep one rpm handle for all vregs
Message-ID: <b5a2f511-2758-452d-b6ac-399262b3734d@sirena.org.uk>
References: <20231227-topic-rpm_vreg_cleanup-v2-1-04c79c4f9166@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SHKddNeScMT9u6b/"
Content-Disposition: inline
In-Reply-To: <20231227-topic-rpm_vreg_cleanup-v2-1-04c79c4f9166@linaro.org>
X-Cookie: Your step will soil many countries.


--SHKddNeScMT9u6b/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2024 at 09:18:37PM +0100, Konrad Dybcio wrote:

> -	rpm = dev_get_drvdata(pdev->dev.parent);
> -	if (!rpm) {
> +	smd_vreg_rpm = dev_get_drvdata(pdev->dev.parent);
> +	if (!smd_vreg_rpm) {
>  		dev_err(&pdev->dev, "Unable to retrieve handle to rpm\n");
>  		return -ENODEV;
>  	}

It'd be slightly more robust to have a check here that we do get the
same RPM back if the variable is already set, just on the off chance
that something changes in some future system and we do end up with a
second RPM somehow.

--SHKddNeScMT9u6b/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYLsQACgkQJNaLcl1U
h9BhJwf+LNWnV7aYSMGzS9p2rabLoDUBs3Oa3nH9VheBdPCnj+3+D5SWTxGHdGud
87tmCpZqyfU0BuIkjYMtvSdd9YjYLFOGBCSQKA2yTXaOpwyza7YpDxI8HXzXaZwS
FZNX4keO8YbHzSIA5MUn0cx+ilemlombBlFpFXaASR+Mijs8haY6uGfMW/9H0w2k
c5hfwRGAoa/UVnwbdDtNZkSF9UUvi27H8/j1EPICaxm/MMkuse2qliuehRQkIbCq
B2JwOfnvRB5v/OQp5LbRzGyGGcdIhz/j5w/RNs2K9Cz9ImvD1c1a3l6EQTlEFuQN
CQNM2vAUtDebYaOrvTjRNtPqse5XVQ==
=3e40
-----END PGP SIGNATURE-----

--SHKddNeScMT9u6b/--

