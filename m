Return-Path: <linux-kernel+bounces-135346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84889BF49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57371C21FF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B660762CD;
	Mon,  8 Apr 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfnYN5dG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDB73528;
	Mon,  8 Apr 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580194; cv=none; b=s4SYEfJt5D0e9ngMvSi/WiNqe/4Kx0Gg6C4vabdNoM4roUEvUkEjKwbsT+vxkTDSa2vT8hRiqfCkd/xfDCdMJ7IGzz5ZnWOA28KlV+yXT0K3vDrefCvEzhouyI+NAYnxy71r57pnwc+JpvJXvBSRKcCxCploFVzj4S1MJFERvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580194; c=relaxed/simple;
	bh=o/n/XAccFgkV88Qr6FGsWOys2YM7DrCPsQ3Jhs046CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni8NfMjaSWAJJkCoztRDWiz77ci3H5ln0fsq8XcG6ToG6aI5Ijf5i6w+oU/18ZeaevvJRKaeDLTWKLbNr65rSmNLTcheAJk/yNs/g8JuLlrlIBKZtXBa49S9drN/I8+5/MNb/y5Qhij2x0ylP+JTb5G3QFYzdVoQYjFKUW/lXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfnYN5dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524EFC43390;
	Mon,  8 Apr 2024 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712580194;
	bh=o/n/XAccFgkV88Qr6FGsWOys2YM7DrCPsQ3Jhs046CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfnYN5dG9atj25XdUli0yLnXOk6I6s2dpUmII/5SkH8ba38vp7aNeHO2xbJqK+fps
	 sJ9NLYw8oXcjFWoI+4AIF+DC/PgfSq66WgXrFYFAMAhjOFA78jTi8Znq4ACGF+nwk/
	 T4UG8o25SS0L2scTMoCVtdeRrtV9UmJeH/PIo14w0s8MYhScGevnfZXkuwDNU3+hkk
	 yCn96Q95g1T5k5WnMPgPfJK+Cg9EVo+mnTfxo+KnDLn6PnF2lcml+8YQu/x4Unblw/
	 DQvI7O4qlrhfmqCkil47MVQjOQ76zZbhJdRbc9DtDjfjGSmKW/u3zVkHPgHGauS/KN
	 g49JeLf3Sh8mg==
Date: Mon, 8 Apr 2024 13:43:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-card: Fix a reversed if condition
Message-ID: <25771b56-8564-42c1-9a2d-408d91f23618@sirena.org.uk>
References: <155bb76e-dc57-4a5c-b0eb-acee5ebde9f4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UBthYBJrUXVgQDT2"
Content-Disposition: inline
In-Reply-To: <155bb76e-dc57-4a5c-b0eb-acee5ebde9f4@moroto.mountain>
X-Cookie: Drive defensively.  Buy a tank.


--UBthYBJrUXVgQDT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 10:38:02AM +0300, Dan Carpenter wrote:

>  	ret =3D snd_soc_register_card(priv->card);
> -	if (!ret)
> +	if (ret)
>  		return ret;
> =20
>  	return 0;

Clearly a better fix here would just be to remove the conditional
entirely.

--UBthYBJrUXVgQDT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT5lwACgkQJNaLcl1U
h9BdVgf9Gspq62woabsu/dxrXY/4ffmusjwWnUNxtVs9udrENILi2P80owdU/EAZ
/bEa1yhMg3mZrA0JkXwUkWwDE0ZEeH+e2mSmSsfxDiwlkgGhvuHo61fyuU/mql+n
0v4LLqn9eOcT+B5+m+CU5cKkmUY2+zo7j5k06McNS+NK39PxXJxNX6OEZfTB+mTK
JSQqCDkYV7R8UXe0WNIE2IkfrMcSMP7EHVt8itGe0P3J+1WtqR/ch/CmkrIZtYyn
ca8u3XpfLWyiLu+lON4vs0QzLvTN1b2UId7XS+gZO4SteUiv3NqUOuABKl6Kgkoh
Cz7Es53alHDgiEFj1/TZ8VkvzmhaRQ==
=I361
-----END PGP SIGNATURE-----

--UBthYBJrUXVgQDT2--

