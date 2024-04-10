Return-Path: <linux-kernel+bounces-139448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C590A8A0381
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFDE287D99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3217745;
	Wed, 10 Apr 2024 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Bp4CzHNE"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB632629C;
	Wed, 10 Apr 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788933; cv=none; b=Zbczs5EFIC5lg5eDiXpcg3sJkRXIh7sjFK3/omHUbHIHcvMcyV+Ybd0eXAdk7pyGsNn3RNhpCqytBwc8MC9Z7MFgiDLDn1Eq7D7jQw15xXsHqM2yVmWkjxLePwA/BA4/PWXBwnPmz/kpNQ3DwO2uokWJSTp+LCo5smGNcvAHoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788933; c=relaxed/simple;
	bh=50pj4Nx8ZyIs9Ah52P70ERpaXuyZGbI/i2NNrXS9olc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n1ZFcFzml9rOICQ/i8uZQrKB0jJo9rWHiTiN8BPodgnzG7F4tVclxUzWJNpcrgIZVFzKGumbqjyxaE95C1dvKxgn3Xm5a6bl2BwAGlW598ZerHCuhanzo9wFh78yNQLAcNVZhWWMTVWQ5PJge25H+l5N5u9yb6nwM+rgmpqCoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Bp4CzHNE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712788926;
	bh=Q2SsuTrAGoRt9Xal2JN80k4d9A0UXPX8wyMhBLpD4qY=;
	h=Date:From:To:Cc:Subject:From;
	b=Bp4CzHNES9OPMJkRfBf32bm5CaFJiyWSHxvD3jOP/CweoCKxzkJAW4ZBsA2nu8eP2
	 gLm8YPwjot21Qp2K8/KtBWm8k2jUZdI58jhMBK9vynVNaE9Jl52HCBJkllAluStjzB
	 o7s1YzxaNTxbLI/rKkIq81pbo7JKkZi+3qZ9tk/dcRMlpRfS5J1VBlHmxlvlHq32Sm
	 PmT7iiTlaJUax4eVOb5R7SiJ6a30D8WeTHFdE5XTU7EjvyUvpjq4/ngqxZykt6QGGn
	 /Q8sXVwy2461w0TlxJV1AyUnEGsNKc2ZUA4gc8qSOu0M/qSmE1Av2Y71R/s/XIey3d
	 WyahwdUIotCRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFHrY6Gymz4wqM;
	Thu, 11 Apr 2024 08:42:05 +1000 (AEST)
Date: Thu, 11 Apr 2024 08:42:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net tree
Message-ID: <20240411084204.0d82fb04@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2xAgszze_szggfSWGWvYUY1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2xAgszze_szggfSWGWvYUY1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: drivers/net/ethernet/realtek/r8169_main.o: in functio=
n `rtl_remove_one':
r8169_main.c:(.text+0x62e4): undefined reference to `r8169_remove_leds'

Caused by commit

  19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")

I have used the net tree from next-20240410 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2xAgszze_szggfSWGWvYUY1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXFbwACgkQAVBC80lX
0GxzuQf/etTjADKncB+DqgBucpBNkX+2Ob++7plEiNukyk9ns8ooeL2AxbUD292p
z1TaIiPEbxhp320ap/TfUU2zbXjwybHnntv3rfhBFjYolvi+r9CbUOtFu7USDjpc
Mm1T7ft7aSJxj9wRv4XYiSFgjEeWM8XTC/7dFP3WZ3XOaiuEaOP8MYs9bRahmwHX
ro/WCTmRBBuduR4R2+YgwiWOME/IGL1xlU8/djBon1CPmRyFgvF/xiLLmeyX5Dx4
uf2I5GwLk64G7EfTYapUheEdj0qcANW3XAkFEoPjqUAyAYWm4OUS4UbfO98bQRyu
a6tLDRS/Dlkl0rxT8rer3aMXQ0U0Vg==
=qxKD
-----END PGP SIGNATURE-----

--Sig_/2xAgszze_szggfSWGWvYUY1--

