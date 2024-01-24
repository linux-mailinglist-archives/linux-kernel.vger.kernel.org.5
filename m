Return-Path: <linux-kernel+bounces-37712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06083B442
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2491C21F10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C7135409;
	Wed, 24 Jan 2024 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K12E1atQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4381350FB;
	Wed, 24 Jan 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132986; cv=none; b=mrY7+V7Xbzf2W8xGv6wAARbAmgirdA+KNKZHkD5Cn+XjimHmEbHZC6RVn1ANF2WL4yy5WVa5KGnkJPqygR0/1ZOW9ILwpiAq9F9gkc8UJI4F98H6T7lCRQBpC3cLpylxOooWC6OKkUjQ7UGNTjQYURopxOBERSEggTwJCvXko4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132986; c=relaxed/simple;
	bh=MKg2ZgMaCUbFS1Y/fuLD3dW/JooHkDcS/BaaGyTK7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCQ0MtNu4CZVWuFgkgnya3ZtEXH2i6tO2qHqQGI7aFPJwMQ1fBDcHzquNjjKKcRcFGgQnkr2P+iFSx+y0wd0nwi+R5RwxpTNjy2KPMSG8EZIixKUXOY4GWapyDy2GE/tJGxC6nuXDKtDJJQWM9UwMJYKAJEojPXXoRfMzIWkclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=K12E1atQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706132980;
	bh=MKg2ZgMaCUbFS1Y/fuLD3dW/JooHkDcS/BaaGyTK7KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K12E1atQl6pUvDUxmOw3WTjlXw9iy4WtacOimQPvv+xZu18+NKkTw4bT7dN32fUpC
	 tQ5AW13XTtnEdgdgt7ax/kEyrq3nLhET/ZsAaxe+SbuMIVqGWa8NPbhG9PnWk2XpoV
	 48un1A7ieQe6+IqE95lJHJQtPoYGpQqn6nLlFR2GwXps5sRa2gAAgZVUAC5tTVkj22
	 GIO/d+zDLXVw+mSlBvvfbr5Otz1l5DA5PSojaDjVSQ6lNygZB7MxIwF/MyPP9enWzN
	 NaMa9NAfFGNn+VDTyJGsgtHFCE+5ymqI3UvH+d+mLuKMXMW0I9vSSFcpMRtRBIDx0E
	 YyCAN+bpTBHGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKyKX1Fc2z4wbh;
	Thu, 25 Jan 2024 08:49:35 +1100 (AEDT)
Date: Thu, 25 Jan 2024 08:49:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, David Miller
 <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hector Martin <marcan@marcan.st>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Jean Delvare <jdelvare@suse.de>, Lee Jones
 <lee@kernel.org>, Micah Morton <mortonm@chromium.org>, Pavel Machek
 <pavel@ucw.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: linux-next: trees being removed
Message-ID: <20240125084935.3f3f7685@canb.auug.org.au>
In-Reply-To: <CAOg9mSQ0GBrRbBWtcNad1vSU+H5vZq6akcCQVDnUS-iw9yWGFg@mail.gmail.com>
References: <20240124130101.428c09a3@canb.auug.org.au>
	<CAOg9mSQ0GBrRbBWtcNad1vSU+H5vZq6akcCQVDnUS-iw9yWGFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S5snyCkhsxN_RNr.9WWoMRh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/S5snyCkhsxN_RNr.9WWoMRh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Wed, 24 Jan 2024 10:41:50 -0500 Mike Marshall <hubcap@omnibond.com> wrot=
e:
>
> We are active with Orangefs, both on the userspace
> side and in the kernel... I might only run xfstests to
> make sure we're not regressing as kernel code
> changes through numerous development cycles,
> but we do intend to continue contributing in the
> future...

OK, restored.

If you just do a fast forward merge of v6.8-rc1^0, the I won't bother you
for another year :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/S5snyCkhsxN_RNr.9WWoMRh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxhe8ACgkQAVBC80lX
0GwMpwgAo3Bkcb0GypxJ1emvkWnWl2C8mrKDIwBh94lCqxYke3HmfCLOm1tZU1+N
ZtSjdhmUiEC7reaGG2S/8KYEzhAlqoCVss9HA+vgX0yLWzIA69ycpLHpZ82F/yl4
S1r2n628KhreZzKqRV11peJ0r7C9gIId5dr8jQwY4K3LcuON8fVdhmfJPVSmB9cT
438sPhwSStGbZbdbm+RaG2dp046JV5n1PNWwduzkiC2n9eheK7NZJjr4MDT8t5jV
z53hfJ1hLaur6VgOMRrsJMJbVeqJsLCAppBc8Ad3vEHvzOeMxvQXBAXs1cEwIoTM
Ut15ECi0nkuIESSR18M4Xau8MeohaQ==
=UXGh
-----END PGP SIGNATURE-----

--Sig_/S5snyCkhsxN_RNr.9WWoMRh--

