Return-Path: <linux-kernel+bounces-56276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102B84C83B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1456528613F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC025558;
	Wed,  7 Feb 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJQ+BKBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBE25551
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300299; cv=none; b=cav0RuCRiCuTAzs/3wlIPD7UF034PaQJVeJeKSs/gjWDrxOyYK1yJG3eR7D3kpe7e9u/LjgNzbNSeRi/Tmst+EseT+WpYmRiDRoEM778pSIltFZVQTDNHMgfp1S08r2+QapZ2P/iLLYLiLInP3Tx3iEGq0+HsHEIcwTmRL2uX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300299; c=relaxed/simple;
	bh=c9owOFKEHg/15Y5rEifsSuiIn2++EhMgrhTc/2WLrAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnkD2fCg9sOsaVUOJNkJ+NGogYqx1RgRJqv9L/MDnQPM61P8MihX+HhGVSykoGK7n974n4Pg5B6TQOAYI8SFTF53W/764d/XoyJFu9gRznNekCo0+MBsHz2ouyrAjCnmSDNSQG8L6t/fOzNvsyEEX5gCCkJD8zgXwKiKYTt/GHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJQ+BKBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6437AC433C7;
	Wed,  7 Feb 2024 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707300298;
	bh=c9owOFKEHg/15Y5rEifsSuiIn2++EhMgrhTc/2WLrAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJQ+BKBlYisIv9rlYGiPHJ1eDOrbk8YAiowvwMfTdOkhYHmfIj/Dd85SaSyM57x0p
	 W9dCaQAGZyiiYEm/u7o+6Krqf3lQovdMYqvyG4Jss15GIDT6gVMKEEBFxomN417wGI
	 g9c3tQRLQz3Qe6Xy0pUgsEx80l2vUgt39tCIEYmm2gFTrnhkaL4d9Snev9P0FnvHU1
	 E+tRjuENvu5s9TdwdsayvR5FNCpNrRFws9srx1gIp9X8XUeacZQn1n80nzb9loTaSx
	 P5+An/3EHXeq/023J7at2Y0VPvr+mlVoforMORZFSBqxYs0vqA4JAxC45ZdvXUaehz
	 28uNUqMYfdq2w==
Date: Wed, 7 Feb 2024 10:04:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] arm64/sve,sme: Refine scalable regset sizes at boot
Message-ID: <ZcNVyMyiFB3Nndth@finisterre.sirena.org.uk>
References: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y9PDNhe0Uomjhdbu"
Content-Disposition: inline
In-Reply-To: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
X-Cookie: You might have mail.


--y9PDNhe0Uomjhdbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:27:20PM +0000, Dave Martin wrote:

> index a5dc6f764195..5c2f91f84c31 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1189,6 +1189,7 @@ void __init sve_setup(void)
>  		pr_warn("%s: unvirtualisable vector lengths present\n",
>  			info->name);
> =20
> +	arch_ptrace_sve_init(sve_vq_from_vl(info->max_vl));
>  	sve_efi_setup();
>  }

This will only get run if the system actually supports SVE since the
first thing that sve_setup() does is to exit if the system does not
support SVE.  That means that the size limiting will only be done on
systems that have SVE, but since we unconditionally register all our
regsets if the system doesn't have SVE it will end up with a maximally
sized SVE regset registered which doesn't seem ideal.  As I mentioned in
the other thread we should probably just not be registering unsupported
regsets with the core, that would avoid the issue without a change to
this patch.

A similar issue applies for SME.

--y9PDNhe0Uomjhdbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDVcQACgkQJNaLcl1U
h9BkmQf/bBDAnFa1sBRZ8U05li4P4BrsbtNXMBo9oY74OuyanGqrdX2+XX5gwjPV
n4BkGz+FZp3ohyLcSicInqv8G6tOy1gKfAjaJJ8k9/5sYeZBFSKMO8Kaq4kUbYhI
m6aW/vgm1z0TfoILbqG/CVec1iDHDAIYvcy2MVlQE5JPTz8a95VBxGAxdCSU3dyE
UHG0jvBtlziVED5CX4URXAwbjScJPnC+d6sse/E9oTxoKo34BMYYhJvsXapBIsBH
I11UWrjgmihvqoFjBuhOnTi3EccIHQW6VHbDmzVvf7U9Y4ePEoc6wGxl9B7i7zXu
8Nhl/nvAyloidJh5sBsSzhUqMvOkqA==
=LBbl
-----END PGP SIGNATURE-----

--y9PDNhe0Uomjhdbu--

