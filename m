Return-Path: <linux-kernel+bounces-54134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F984AB57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9691F259A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AE6FB1;
	Tue,  6 Feb 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MF8CPSuC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FC539A;
	Tue,  6 Feb 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181204; cv=none; b=FmW40wnjqlcrr6RnaWp+NaP2R1NBRfZu58hNk8NTH/5ilsTXEFr3Z0dAEvMIkD0Y6HGQkh0rSjt94x3w2LJJ6QZmcTjwTvCFZTvilVeFmh2wOb1dpy4ufxPqkRmCOt75pj7vm59ixRD326WMxFMvk59ErA8W5M4mp61Q5dSN4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181204; c=relaxed/simple;
	bh=pvr9OkLDytfZuT3AyoRYzRgHcW9tIdCf2sKbD8K4j+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i2x0Mqw3c8jwo6DCfkGvOob/MFEKISCLHfW7P/LuQu1kCRsXTbduBAppxLct6P7pYWFSQbQB2axZYZosg7YnfCSUWsuEXc7x8Fs0KY74oG3DZfLIo1kwmuhOrWLjRtfRt1HM0dLUyNaHlV/X14cv9n0lxqDvYLXffbAZjakDM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MF8CPSuC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707181198;
	bh=mcAAzoOAVGZzLS4NHfKVIUOk1ulVMJKUzquzS0Sq5Ck=;
	h=Date:From:To:Cc:Subject:From;
	b=MF8CPSuCd68GJjC8r+H8/Bmx9jzNzZwz7Hx15htJt5eohVABMsur7DU+1pWb1Ls92
	 J7Yun2ixb7rQTOqsXnglA/kJgVZQMykfaB5PFwt5pMMNLMrzvcDqkLjRqAL4x3Qcz6
	 J0jofEtekEB5U/k9DOnQUcHXnESaT6hjjweQnsKp0l4Ub4tPk5I4zLmGj8xIAa55Aw
	 TXtImetwMyvp5+geBN6Q49MsHCCwjupJXL45ZFkuiU+ZY/QdkW0ZcqxqW4NiyIEkQ4
	 3z/QkFM7wEeaGQMY9hQ6yXEVnZF5LHRbHVLyjjhELCEGmKwr4jLHCCAKpARx9bzrLS
	 vZg+uVlA7KFzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTPzd3NNVz4wp3;
	Tue,  6 Feb 2024 11:59:57 +1100 (AEDT)
Date: Tue, 6 Feb 2024 11:59:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Inki Dae
 <inki.dae@samsung.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>, Robert
 Foss <rfoss@kernel.org>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20240206115956.4570e9b1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tPTwWSbcHW7JIIhlh82ZBYM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tPTwWSbcHW7JIIhlh82ZBYM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/bridge/samsung-dsim.c

between commit:

  ff3d5d04db07 ("drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE")

from Linus' tree and commit:

  b2fe2292624a ("drm: bridge: samsung-dsim: enter display mode in the enabl=
e() callback")

from the drm-misc tree.

I fixed it up (see below, please check) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/bridge/samsung-dsim.c
index 6a10aa5c85f5,f9d85fe1df7e..000000000000
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@@ -1498,6 -1526,11 +1503,8 @@@ static void samsung_dsim_atomic_disable
  	if (!(dsi->state & DSIM_STATE_ENABLED))
  		return;
 =20
 -	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
 -		samsung_dsim_set_stop_state(dsi, true);
 -
+ 	samsung_dsim_set_display_enable(dsi, false);
+=20
  	dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
  }
 =20

--Sig_/tPTwWSbcHW7JIIhlh82ZBYM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBhIwACgkQAVBC80lX
0GzXoAgAjOU5PMyBhdNjxCGyusGWHf/88xGF2bb6y76E2cLHxWZmxOv/ayFBxgL9
2Sbbt44esyXM5DqMjeVXV8BxlOHKgXho2e4IwjQWSYqRL5sgv/ht2p3/4mD19KMM
jZ44WmMPe+j9O1AYhrgqVLspl/81Jw+WvvEbuAHdNO4BrFTqrl3Ukwep6d1Vqc4v
Ea6lci6qf+daL2U+ESCA6nHhNHM6Yn7kE0xliG7rQSX81u2MEAJVzdZou4RYhqzI
xYP/mU1oIVFiZkz4P1xUK/2uggpbt6F0a1OHzxyDEPQwCveaPAmwsbh1P21IJB0u
Ykh4PJBWNwddUdEtUwy1sncIOnausw==
=gUMH
-----END PGP SIGNATURE-----

--Sig_/tPTwWSbcHW7JIIhlh82ZBYM--

