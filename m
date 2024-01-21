Return-Path: <linux-kernel+bounces-32189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF068357E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476311F2190E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CA38DE6;
	Sun, 21 Jan 2024 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUmQzfNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E457383B8;
	Sun, 21 Jan 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705871732; cv=none; b=Ymhtzb1Mnw1j4ZFCEmVaXQDfn5j9wTqSIT9bBIJy8hBTVCBrciohx2p/EtcRy26bKi0PNZvZ/lVuHV7xsfMEeFAoNMhTKTqNI7c6nDGCRV8EoYMiwuYKBbvZ+Yn8CyGeTKs927o6XhkVf71ccMqs20nPwAUuIYPteMuO6+xxfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705871732; c=relaxed/simple;
	bh=kpFY2RXVxwUhXk4eqhD0utH+s2JevbcgTonbpZsQyvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0uwzpNuYBTgzNCYo2uo3Isoih6vZodymwO6J+IMDO7unVsUijdhODig6mvjV3Fru4omIePvhYNzp+slOLFbf53jhzwdLiqnNp3CrcQE69x8Bx1cmJCDVi+c4LnOcLhlNMNws49EYH9jXmNNDQElmwlJ7BCm4SCEzA/WcJH9O38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUmQzfNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3723C433C7;
	Sun, 21 Jan 2024 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705871731;
	bh=kpFY2RXVxwUhXk4eqhD0utH+s2JevbcgTonbpZsQyvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUmQzfNE5I476xwm15KvhWPBP+M6mlMealJoyw1XtxiG6Yy5zlZ3WeOGe47eQmy7b
	 tFy5f8Jwl9GEjM6jI8ebZVaSu2z3bQjFzx1yFFlufOZP40a4bc4zOZEmcx5lln1F7S
	 REv+swQPS+/xra7QSSyTUC+aJbURXZr3P62O02R8ccwMmKL3wgCEltsFSqeq6GlLfE
	 O9Ww5VwTsLJ+AxbWMglQ0+2iLnfhPlEzrnv6/0rH6ahcnSy8IQEh6PiOpKyVI7Ok3/
	 fO7C4DZ3HoeUzkyY+Om7H3wbYn1W9zy4yufYp64gWZ8oM2OQCv8ftDeXWO6gqw6TRp
	 UTbxPzcQGeZdw==
Date: Sun, 21 Jan 2024 21:15:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Michael Walle <michael@walle.cc>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	tudor.ambarus@linaro.org, pratyush@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sbinding@opensource.cirrus.com, lee@kernel.org,
	james.schulman@cirrus.com, david.rhodes@cirrus.com,
	rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Message-ID: <Za2JcHQNipO2qK60@finisterre.sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
 <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
 <ec7e7972-d48d-4a47-bd03-eec0c4334471@roeck-us.net>
 <9806d99fab46c928f337b30b21057b3e@walle.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jaYudf2Qatjg9XbQ"
Content-Disposition: inline
In-Reply-To: <9806d99fab46c928f337b30b21057b3e@walle.cc>
X-Cookie: You might have mail.


--jaYudf2Qatjg9XbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 21, 2024 at 07:06:31PM +0100, Michael Walle wrote:

> Given that, that the rest of this series is under discussion (and esp.
> whether
> it is the correct way to do it) it might make sense to just revert the
> picked
> patches.

The API change in the patch is a pain out of tree due to the way it's
easy to add new things that miss the helpers without it so I'd rather
keep it in if possible.  The underlying implementation does need some
TLC though.

--jaYudf2Qatjg9XbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWtiW0ACgkQJNaLcl1U
h9BQswf9GyF3//21FvfdPQIKhkExHr2h2cGzlMrSSeuagdoyh+dlJPQXC4C/poic
vpt9904btt6ubjlnpp3LJhtEFky7nLQQiRCYUMXZoLJwZ556Ixk0GQQ844SMI5h0
Frz9fUTXkKW24um3wXkfWA1KHEK2obOTAZzlP6KqnHmkwzRMWbEvWGG9OXGXmNL1
HwWa+Sw/HmdcYUo1gYwUY/Sy7SDTw4/vJDTwQMxiC/uPNd60FrRC7Ia6qBP+vUD2
QzwRmme2U+gfLbWSzrkYYPqGsKYQYddgz0Y1BMspZ1Ptvw00somMsz4zMqxOIKQN
K0Ao5bjbuOFXpRh6EulWQonrG0tLCA==
=Na53
-----END PGP SIGNATURE-----

--jaYudf2Qatjg9XbQ--

