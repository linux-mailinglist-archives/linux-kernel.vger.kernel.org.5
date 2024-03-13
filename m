Return-Path: <linux-kernel+bounces-102281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1D87B027
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1612E1F2AF02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA86519D;
	Wed, 13 Mar 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6iOwws+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864C47A6F;
	Wed, 13 Mar 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351617; cv=none; b=S2MLt9HfzJWFLXKZpBaJSS84VTOI9Z5sxK0HEo5k3VG7K9jYyzNdQkYjqU4lqnaytR/oe7zH9miW1tv1W/3Xtuo17VARBkvAM2/wX/rJnYWCqdlP1c6RPZmPgeDcdUbc4G1sL8+7E1zU+c1lFPNbvUPAvCrgBwi8jnWPKCnvfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351617; c=relaxed/simple;
	bh=tUQlTIAd9zU8ZTFePqPCTyVR4NP6xLSNEMqxtaPHCVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od75+9okwmT5J7gxvpDQZAuPsK8mowv0N9vfNNzaYDU53G771jjcg+6kJpm4zSzNq/uJJ36WKSr1y7gfsWysYxSKh8JdvuJvtjaad/HmPxko/ngOeQ18Q6mfdQVvGXopkQ4EHLpXlY/IVdhG3kATHPcEQoZZhfd4EYuveojur5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6iOwws+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F1DC433C7;
	Wed, 13 Mar 2024 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710351616;
	bh=tUQlTIAd9zU8ZTFePqPCTyVR4NP6xLSNEMqxtaPHCVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6iOwws+UvSeGTEvnPdkAZG3XEUvuQB4ECG4wRyrKS+An6n3M77FvEnpNHHSsdoAS
	 /5BZjTgZOCgtgbLeNI7wOQ6u2XY/V36QB+s/ILVm6AuD+muELOUfiD14tZkKAT0s76
	 DqXLn4y5WimKWCx16tHn3Q+Pq4xC7qctexYlZew5whIOzgO3wIYUv4gq5s5H/ZhV8/
	 mSr5tUkrcZtzIraVqLcugwzlb3Nm+68lS5JT/TE1kCMovJn3NeXAAa04Z/Po64HenO
	 zcszU0/A1zMlXry0R8amFNwXHu/OqiApedYDz1VM6nbFKn1XDguWFK243EECFnL5rs
	 N5vhUBMAjFFbQ==
Date: Wed, 13 Mar 2024 17:40:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-spi@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
Message-ID: <7109907f-baf3-47e2-b33f-3403e1299176@sirena.org.uk>
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
 <CZSSWP7A9UM7.1R20796VHLU0F@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c25yVvKkvrfIyDqD"
Content-Disposition: inline
In-Reply-To: <CZSSWP7A9UM7.1R20796VHLU0F@kernel.org>
X-Cookie: It's later than you think.


--c25yVvKkvrfIyDqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2024 at 06:33:43PM +0100, Michael Walle wrote:

> FWIW in next, there is commit
> e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op() calls")
> that probably will conflict with this one.

Indeed, this doesn't apply - please fix and resend.

--c25yVvKkvrfIyDqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx5PsACgkQJNaLcl1U
h9Bd8wf9HzT8NPFCZoqC/eQp75wLJM0cfYy8K/vUMHO0rL+TO73BxjhPZyI3Gg6y
xzP9jD82bWE0R/TnGLx428Oo7aljdE2WO7WSD9Zx9qAybiY5zynO7OsvagDn4UwP
kt7UuxYbZtIhYaFgQ/f9gh55nq1UKP3ihjfI6+8fP4xRCCMYISamwaJYFFZc4iA7
rc8Fdi5TeNp516b9juF9j1fWkepm47TByTVtFg0S5xv9cgnl8J8Gkn2J8bDIORWE
hx0t2Xr0GfuOOodaw7BT0j1gdUM/OJLSOc11lKy6Aeb+ZuHThY4MljEHSGG3vFTy
SjatvA9NYwJMFZhpXZe2njCm7nvpZw==
=b6ub
-----END PGP SIGNATURE-----

--c25yVvKkvrfIyDqD--

