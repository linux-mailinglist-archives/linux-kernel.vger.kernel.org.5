Return-Path: <linux-kernel+bounces-91451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D08711A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C6C2825C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A841FB4;
	Tue,  5 Mar 2024 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FrAXEqr1"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8A10E4;
	Tue,  5 Mar 2024 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598407; cv=none; b=Akv8V+9xILZ1MKChGNRFk4VqCbUBgRnpjsOzwMKSQaThitccmHEtxbFkaiv2uvn76dp56SUqExjwC01ezydmQ6RWUBmHa74fSmAn71Wlbd4bxbGxxigPA20PUnrlbG8oPLwjl93pFbTrFK7RxObovH0RcHD12Fbhl5R3XeSrefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598407; c=relaxed/simple;
	bh=krO1kIHKX/xI7ueJfFd6M5pkrZWuBiDhL+7b5CCcB2k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o5AVCEeD9G7XfD0SDbqQxMkAUV35D5ljUjKVUFlsaDV+H9wLhlrd6sNMPZ+HBTDPtG9JSqUTud5oAwfGUO1EgUhaICbKkIX9tOo7LgMk5fhb1cH2EaOsnkie9IFxM+azwlWP+UVKJqHH0DpTDn1kZhnHV4sURWYq5YLRBmdz6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FrAXEqr1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709598403;
	bh=8JmmGRblLviPY3vGl6YRexBFOxlOArzv6ntkM8GxRqc=;
	h=Date:From:To:Cc:Subject:From;
	b=FrAXEqr1y3lgVK8CRgIMB8SgzBwMWHgRHFOlbs/aqI3dbXyRoovqzQVwlpc9PsoVU
	 EJKT0fXE86FUfkW21w8YXrCjU/2lwOaPhX5blmggR1lx9w6PJMPhng0PonqXj9GD5E
	 EmcNThUxuCe31glvD74s68nzTlOzbTykRSOJh+DIMZq+pVWwsx+jbCXEPlyamzT6WH
	 8yk2sMMnhcsnLsy45R2X/jlmEbrYwhJh1IJTWDQZJyxkTRPVeH83VvM6EIDLV25JFG
	 wt5n8ho76YG0D2N838r1ZrKxf7TxftwMiahfhE3VuDlcW5Jl5ZB659L9Xs1Nt3gVp3
	 5JRviHuy7Dj4Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpbwL0Y5Cz4wc8;
	Tue,  5 Mar 2024 11:26:42 +1100 (AEDT)
Date: Tue, 5 Mar 2024 11:26:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Networking <netdev@vger.kernel.org>, Alex Elder <elder@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: linux-next: manual merge of the net-next tree with the pm tree
Message-ID: <20240305112641.6248c6fd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PtrpKQJkd6+R8z.2d0yv6Mo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/PtrpKQJkd6+R8z.2d0yv6Mo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ipa/ipa_smp2p.c

between commit:

  c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")

from the pm tree and commit:

  5245f4fd28d1 ("net: ipa: don't save the platform device")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ipa/ipa_smp2p.c
index cbf3d4761ce3,aeccce9fab72..000000000000
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@@ -91,8 -90,7 +90,7 @@@ static void ipa_smp2p_notify(struct ipa
  	if (smp2p->notified)
  		return;
 =20
- 	dev =3D &smp2p->ipa->pdev->dev;
- 	smp2p->power_on =3D pm_runtime_get_if_active(dev) > 0;
 -	smp2p->power_on =3D pm_runtime_get_if_active(smp2p->ipa->dev, true) > 0;
++	smp2p->power_on =3D pm_runtime_get_if_active(smp2p->ipa->dev) > 0;
 =20
  	/* Signal whether the IPA power is enabled */
  	mask =3D BIT(smp2p->enabled_bit);

--Sig_/PtrpKQJkd6+R8z.2d0yv6Mo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmZsEACgkQAVBC80lX
0GwcJAf+MoMxPVMBLY5erdgoXg5CFIShShkpA/chIJDy+ImTgnd+nOBIUQjP9EdW
jJNjU1Xq6cZDeJ2I8k3O0haW041BgGVQkvcstwmYxt5/YwNuo7KvZdCzioWpgTRz
qv825HrFgYJQANqcTKdQvAhz7A943WjWjU2ByorbGFKyhyBASLZRCT1swQriDMzq
8dND96qPyqXdwImNgQSPN/eFJqHDl5ljfwKYgd6xBQOhAx+o2BP74XrHKjNPVXI8
CdNT/ePNfmh6VNmiTcaoCYBdYcSQsbhztrbEiXokIC6d+HXsYbfB60ipcfF1PIDD
YQQz40PTkEc/zz17cA0CgTPrnmUbjg==
=9lTA
-----END PGP SIGNATURE-----

--Sig_/PtrpKQJkd6+R8z.2d0yv6Mo--

