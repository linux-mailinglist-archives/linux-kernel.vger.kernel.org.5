Return-Path: <linux-kernel+bounces-164874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95A8B844B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAFA1C22567
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF111CB8;
	Wed,  1 May 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/i4naH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004610A03
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529999; cv=none; b=CILjFEXAEiBL8kFQCHqwWEOO5k+EGKRAS7Xy1Yij92jRhubRJSNtjZhsrMJCCu/hs/jU1Zru4w2Qan0P4eU36pC7saHvd7u0yIPXaXP9/Temo7psa2PfGBDyH4hsmhd9lyIVgFvU3IMVg81Ng19RI61eT8yOabYcifvjbh1Ym50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529999; c=relaxed/simple;
	bh=d4l0plIEwSkOSPfsbpj0KDgwPaucxoLBhI3GOdwITVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3wUMpSBDwY1jiVyzPlfEIpkPPCVWqt633qrEirymWbjT5dFlR4ufBzXDVrusEB7cCVg07DeL1vGSZPhI8/SK3mYAVEyqa7xu+sJmmkk4DQJ3uasVvGbK5v/NUyBvRMTIgXFBVvZBHMo2szZ9I2Ovla3ZMj6MzScK3hL34aZwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/i4naH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8ABC2BBFC;
	Wed,  1 May 2024 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529998;
	bh=d4l0plIEwSkOSPfsbpj0KDgwPaucxoLBhI3GOdwITVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/i4naH31BD0sip+9LManrjFKNs3L+U4Xx2fb50ojN/VNqeR3O6wcecYSmGj4ThYi
	 TR5gUIBub0hmXVAS43OvbqRi3rxaEercQyO3fFuGwqBBeo0YqvI7zg2m7HJL7jm4ms
	 3FGIaIi2IULERRtc/bbfHZFrAG8Pv2xpFEG2IH1jAvduttHw2q6dUy7QUBBRRi4rcb
	 zFPhcwxCyM4wiwS5x+Geo9TuWo7SXm9bkD26TP+xtMshWC9o/nyFOX+lUoGEXoiXyn
	 noGgBmlb9DrHWcnv+NqBtJCxCkgs/ARIo4ilavG2q6WyVGa47NT7RjhEBLya3WCGRA
	 hGUkiL0EGvcZw==
Date: Wed, 1 May 2024 11:19:56 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 3/4] regulator: rtq2208: Fix invalid memory access
 when devm_of_regulator_put_matches is called
Message-ID: <ZjGmzMX4M8U89DD4@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <a1e19b4026d7fea27526ba94c398500a3826b282.1714467553.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czeicd9U4V0WsrTG"
Content-Disposition: inline
In-Reply-To: <a1e19b4026d7fea27526ba94c398500a3826b282.1714467553.git.alina_yu@richtek.com>
X-Cookie: lisp, v.:


--czeicd9U4V0WsrTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 05:58:26PM +0800, Alina Yu wrote:
> In this patch, a software bug has been fixed.
> rtq2208_ldo_match is no longer a local variable.
> It prevents invalid memory access when devm_of_regulator_put_matches
> is called.

Fixes should generally go at the start of the series, that way they can
be merged without any spurious dependencies on later work.

--czeicd9U4V0WsrTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxpswACgkQJNaLcl1U
h9D+Nwf/W0bujO/uX7pH6B7EJosDpE+x/XUnqgwxFQ/xP8YtOya9ujF1OPvdXKE8
ApWgcbbJdO9H8qQorNq8Lxn2F0islbbzUS5Z4+WqVrHCRFLghC6R/mI6eQzwatCH
FmtOWh0h5asynsAH7kRmc4aBPSOk4wKhcfHHXbMHafubbWMYHBckhn0DSgFcbr4A
mXDvB497KviRA71lGJszSBhtbpKE6gviiuEwOj2XnNs+pC0FFwCpDfr81gU4wFeo
tjJgCk6pJAUfjGKY1V0m6S+ode+dqzjJucnCB6sUPcu+gPlhLTVHf3UZ8b5uhdt4
d14fojTh8JiqXPc+HOgt3d9INevTdA==
=1jA+
-----END PGP SIGNATURE-----

--czeicd9U4V0WsrTG--

