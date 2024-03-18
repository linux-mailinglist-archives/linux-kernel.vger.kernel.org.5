Return-Path: <linux-kernel+bounces-106166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CA87EA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7101C21189
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC086481B5;
	Mon, 18 Mar 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqclMs/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057839FF8;
	Mon, 18 Mar 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768656; cv=none; b=HqFMpc244GF8/mCFlsw9Dd9LfZRaqy3s5SzSdjQN+NjgpiagzlMtSM6BPysduNqn8bpaehL/ojX2w4cQKQqG4gkGx1sy+kNYYSyEZPiqegqitfeedXlvHm4AmCEcNjvkcMUOUtSJT3gU1iqteKoN8lAmiecXjuZ43gLzmOjVkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768656; c=relaxed/simple;
	bh=9Fc4MdmLlXNEnOvlrkuX3SM2n8OiLdq3X0zd5LtujCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7i03QBwEB6fh2ccr3HLaQh7V/QieJebai2J20rnfTzFsdOiTDkSsmls4H01iOs8FA0scbe8/zRBcL7St5hbsSmK1FySiWmLjdphwnfo4CDyq0xL9oCVES3+qhPoddtWo/O+frbB3Ftz7FI3c8Kgy/0FVdCxDiN+TRdm9EipdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqclMs/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5D9C433C7;
	Mon, 18 Mar 2024 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710768655;
	bh=9Fc4MdmLlXNEnOvlrkuX3SM2n8OiLdq3X0zd5LtujCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqclMs/DzIEOK7ZpEwUgIzoVU1UjeIdAZZQdx6vUjh0lzTWdigVBvpZmOlesultD5
	 JTkAUd9Pfse0PNMT4KOwhhsltIaS+gU5RreTQcUBhyH8ZHJTgjpgx7sqsN8RHuuveY
	 sNriNDMViTvF8HK/DqLXLbfe6iXTq9EnlQOhSCIQFdLdlUS6o/jl0HIK2dEoh32VzZ
	 h1n/0ieViBX9jibuxMJTowPxhqmHCzl01P8ZfrChyC/0CMImwwn7nOHfNCLVuDYe6x
	 nljETBFTEnkf8ghtUnwR69ixxtFuhvfglePyeZODASc98n15rwteIxYKNyJbpZVDqo
	 ZtXX5hnGlSU5A==
Date: Mon, 18 Mar 2024 13:30:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH 09/25] ASoC: meson: g12a-toacodec: add support for A1 SoC
 family
Message-ID: <143bb232-1ba8-4e91-92a7-bab7c14f6df0@sirena.org.uk>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-10-jan.dakinevich@salutedevices.com>
 <2a41e8b6-7e8a-4995-a1d7-c5d30e53c2d5@sirena.org.uk>
 <3ae535cf-9a89-4187-a761-8390d649b00b@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjWorJl0TaUMqWHd"
Content-Disposition: inline
In-Reply-To: <3ae535cf-9a89-4187-a761-8390d649b00b@salutedevices.com>
X-Cookie: Alaska:


--kjWorJl0TaUMqWHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 17, 2024 at 06:19:36PM +0300, Jan Dakinevich wrote:
> On 3/15/24 16:33, Mark Brown wrote:

> > If the maximum register is 0 how does the regmap have a stride?

> reg_stride inherited from existing code. Apparently, it was meaningless
> even before my modifications (the hardware has single register
> regardless of max_register declaration) and it should be dropped. But,
> is it okay to remove it in the same commit?

Sure.

--kjWorJl0TaUMqWHd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX4QgEACgkQJNaLcl1U
h9BLdQf/Zz1jN3+6EFmJI8/2S5KURnuXZVf/whz0eP6IHVV+novzn9bZzi9aDR8u
ivtJ5z3NMrKZpT3yKRb/iP42lcArTnbx8KtRbgkpBCvSW0xodc7pyVJqfkvIDPNg
ribamZQkNViB+vRZe+1M+lKpXGKZQT9VihxnkNjxjIBjjiDONfYP9zzHFNQorPlh
lZLfVCdNixkECtkZ8S2pC9SUMOTqVNHUNloEosl515koEkh5H3wWA4izpVAgFuCd
sAtcI63aM0UfO63qTzXy4qk4482W57UwJx6DuSSws6Y0DSjBpq7nw2gJw6MQb8SE
xTDZc6yggF0aEYdVMCor8vldLH2yxw==
=osK+
-----END PGP SIGNATURE-----

--kjWorJl0TaUMqWHd--

