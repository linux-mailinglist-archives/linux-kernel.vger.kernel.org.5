Return-Path: <linux-kernel+bounces-87150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3C86D044
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEF31C212FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624C67E64;
	Thu, 29 Feb 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWa47QdA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A84AED8;
	Thu, 29 Feb 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226792; cv=none; b=IprbyrYyK2zRanfBWh4bFbkOwdYiFenTCr5Wrzkr4IJxx4aZYHrlkkhyM5X+gFHDDnQHXv8bL4Ql5VFWD3MrjD+G6fFdudWFnj1noa0f9cb1VsG+aWF76VDDgJO33FEpegsvuyVf4F/CQGJEbCUxGAl+IkIyKupMHL3y/NjTxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226792; c=relaxed/simple;
	bh=nM5maH2+iNjefCZwpxImht6QajZQX9eoc3g9Gu3mbGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgAfCSB+wih7vImQVNnXWHBQLSthz/woNPl2GIlOihtNwUkb7oMKLB+SrSdqT85OM4HJJjdqzB1vCbqC7IAdJsCwVrAZiBJjwrKXKCNrwxoGnX43kSLzYFuXBUP3dVexLAJXjUEe7HeT2rzwOU17N4YzDfEk7H+Lt5ncSBd2GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWa47QdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69766C433F1;
	Thu, 29 Feb 2024 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709226792;
	bh=nM5maH2+iNjefCZwpxImht6QajZQX9eoc3g9Gu3mbGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWa47QdA3UVpHPxkDksYCqpuMO6/qTGaZ0JWREya6miGCyDzKDUmansLIqEr6/jRW
	 +uuTZJRJyGq+eLjvPdwzLtM7x7CEHScKZeWV7pyqFuZyBEVkL1a4skBzd32jCUgXp6
	 MtAUW3FqsmaO5auGsCBFrYBsknceEaHdP2mPOQ8bQV9JvWT0xggdS32YdKuzmj0sBc
	 wbyCSnAj2I86JrEujnO61mysUN6y9/zM6AhR2goCfbu1nRQ745SVI74LOI0JUXNWop
	 a4K5Z8fPSHLbo8qDivbd3y46OZ+07wVFVvUvAyktxTS2nhabEcfh9yZWkfq36IMKcw
	 ar9xRcNeHkQWA==
Date: Thu, 29 Feb 2024 17:13:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Will Deacon <will@kernel.org>,
	catalin.marinas@arm.com, oleg@redhat.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.6 21/21] arm64/sve: Lower the maximum
 allocation for the SVE ptrace regset
Message-ID: <05cbeae5-cd40-45a9-9b4f-68b9b20a6839@sirena.org.uk>
References: <20240229154946.2850012-1-sashal@kernel.org>
 <20240229154946.2850012-21-sashal@kernel.org>
 <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AguQ/ip/azlDhTFg"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com>
X-Cookie: Marriage is the sole cause of divorce.


--AguQ/ip/azlDhTFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 29, 2024 at 08:51:09AM -0800, Doug Anderson wrote:

> As I mentioned [1], there's a hidden dependency here and without it
> the patch doesn't actually do anything useful in kernel 6.6 nor kernel
> 6.1. Maybe the right answer is to backport this with the hardcoded
> value of "16" for those older kernels? Maybe Mark has a better
> suggestion?

Your suggestion should be fine.

--AguQ/ip/azlDhTFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXguyIACgkQJNaLcl1U
h9CKIQf9E1N2oM+hr793lWZt35KNPBB/uEReGAKXgs5f9FrX7yCa6pRwbwlMlqdZ
f//MVoW+AX7viQOtXfsALzPWxz04ePVz048cc447zHr/ma270G0lJCa2fdiycP+p
CsGX/lhB5/EGoWJqweiiQImpL2aFpC9v+h7f5hbqNX1vzziibmDnGPh4QOatTZ/z
lbLzAzvmDGH30A9PqUPcsJ03suqLRoGPQWTzykwnYmwLIMaNpwEdQhvn9C9Yizuu
B9s+X2lAzuHT8kkJ7XL97K8hqktWFJ2QzeLoF/kbhvi/DFJpp7HPjivRdULU4fS4
ykQtyyFepTmtOD/XL/3FGdmRyV0geA==
=jo0J
-----END PGP SIGNATURE-----

--AguQ/ip/azlDhTFg--

