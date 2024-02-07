Return-Path: <linux-kernel+bounces-56250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4784C7E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E04282BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11421107;
	Wed,  7 Feb 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J162WSTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D1224CC;
	Wed,  7 Feb 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299419; cv=none; b=ATNJB3FzSBwaLu+IF2aMMwsjpDguXMeyi/SgnCIgbbLxvDsl25LnREHXxKjIqn1ptjm2m1HO79lMXfh193tRWngDyCOPservv24MpqJbvQEXpBxRLdKWmdegVGRa3IqBRGkT7lZerOGvornzUesWCqydLLQo0jYDqbZd2+d9Sds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299419; c=relaxed/simple;
	bh=M1ta89V8AB5yJhhSl1CeMPbzafjggbkHhxGqO2RD4Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G164sePLLLbEr4y/pjdWMP4O97EWvXOpERmKR9+vmNKnsyiqae5qdICkPFkrfP7TJj1GGFTFVCixG56xvw9NXNIX/icMqxqdSYcwpCY5PtqmGxArSNCeGwiPFBz1J/7BgEp9nB9DaAZzPTqA2sqjGlQZtSQ1bjZyfgRo6m+FXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J162WSTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC6DC43390;
	Wed,  7 Feb 2024 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299419;
	bh=M1ta89V8AB5yJhhSl1CeMPbzafjggbkHhxGqO2RD4Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J162WSThIE3H02LQNVV2E9du8wM6DKtdvi7z8HYBDqXzzUm1Ndln/9jywJHBVaE71
	 85YZ9j3CIjAbBpTZh92GkwpLp/VKVT20WACgj+loL1CFPgCQTzUlJ3fJ+3YnFmLP6V
	 m7oajI341msnA4nCcRg/MrDBCVepUYwmTWtKDZsx6tUeisCUZ5DWPAsvmkL+PvdPFN
	 7ahey9M0Eimtecpvqf/pg7LBfAffhNTeV6K0V+/ENJ8iUJ+OUIsfjD8cUo8NPywEQa
	 iQ9bZupe5F/YRS7dEETqeUzqecB310HLGUEcVheuXpNNjaIxnMlQJhnV+sTuFDzkGz
	 4HkDDeCw9kvzg==
Date: Wed, 7 Feb 2024 09:50:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Apurva Nandan <a-nandan@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <ZcNSWPucn6Vg43Wu@finisterre.sirena.org.uk>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
 <ZcD6yqc+o62x2AjA@finisterre.sirena.org.uk>
 <20240207083902.mzkcsqf3tbwkkxd2@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8hJZUwphHllQZKzw"
Content-Disposition: inline
In-Reply-To: <20240207083902.mzkcsqf3tbwkkxd2@dhruva>
X-Cookie: You might have mail.


--8hJZUwphHllQZKzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 02:09:02PM +0530, Dhruva Gole wrote:
> On Feb 05, 2024 at 15:12:10 +0000, Mark Brown wrote:

> > Please place fixes at the start of serieses so that they don't end up
> > with spurious dependencies on other changes and can more easily be
> > applied as fixes.

> Didn't really understand the comment here, aren't the 1,2 and 3 patches
> fixes and the last one the non-fix? Thus fixes are indeed placed at
> start of this series right?

Patch 1 is a rename, this is obviously cosmetic and not a bug fix.

--8hJZUwphHllQZKzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDUlcACgkQJNaLcl1U
h9DIXwf+J/u1u4AZtGji0lT2UBDnRwkuZLPS4tvXyX/lFxCWUMX4z0ZXqer0/8Sj
A4YryZnYd9LkGj350WVwq5UwPTGs2XyXOlenM7I57li0+vLOpzV4neBXROX5PGw/
03FSh3Qfx6t9Y3TYki26NPEyObj1NTZ3lXw6FQrAHMSLZV09PxbL3C+MY15GKJhx
Pw6dzSoX8loijGLYDKxNKCGTKldou/JeL2v4HDq4uetGbQM0nlFm4R4nhg21Ohkz
vijLB0G0bjq384zAko4p8BXX7fkXOAl8vYJ/4PsiNeIrokUWf63B8a8P5eI2BUMi
lAJEkXO2jyuzLqqwNTclcQaKCxN7Cg==
=GIf5
-----END PGP SIGNATURE-----

--8hJZUwphHllQZKzw--

