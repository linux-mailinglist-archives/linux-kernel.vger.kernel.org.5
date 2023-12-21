Return-Path: <linux-kernel+bounces-7716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59B481AC11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565B1B24124
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BE7484;
	Thu, 21 Dec 2023 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zku1rCNH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB463A1;
	Thu, 21 Dec 2023 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703121469;
	bh=ImrbhovL+zpeBkOo5ww6KMLF2TXyWi5NzTB91XFg0FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zku1rCNHdOHu2kfJq0PZb3nW1Wvv5o7zGzUt1VP0wwXSnYq1EhrS+yKiWmGUGmI2f
	 ZRIAGoqO5qYTdTxVPGcnVInh4htXbPr9nNwchIxbFD+tra2bkmFFOdsEELCzcuVNtq
	 jWrXgTiSouX39aZwiOGoIN2/1hMvmGAS/z+H+M/ggKrUSGfOpwLvVzDcEKIGsK6REY
	 cJSqdnClPzcOFqLvRDgoxBTkVKNYw603AOHpIC8WnVZYAz4vXAgwQiDButAv7yXS8U
	 mkqHjDFDXtyjQtAISBpsbs/qB46I2qVRoy2ERidDRcgcZOeoB1FqTE0hur4imw6Mgt
	 k3wJBHvTQKWhA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwXbx1DM4z4wd0;
	Thu, 21 Dec 2023 12:17:49 +1100 (AEDT)
Date: Thu, 21 Dec 2023 12:17:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Fabio Estevam <festevam@denx.de>, Zhang Rui <rui.zhang@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the thermal tree
Message-ID: <20231221121745.2771ab8a@canb.auug.org.au>
In-Reply-To: <c2a170ea-39e8-49bf-9aeb-60eb20a22454@linaro.org>
References: <20231219103457.4e034e9a@canb.auug.org.au>
	<68012fb93e0057f62c03a5d9b01237c4@denx.de>
	<c2a170ea-39e8-49bf-9aeb-60eb20a22454@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pwu/KAh5DGTsDjKpWgLYzm4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Pwu/KAh5DGTsDjKpWgLYzm4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, 19 Dec 2023 18:59:14 +0100 Daniel Lezcano <daniel.lezcano@linaro.or=
g> wrote:
>
> On 19/12/2023 03:10, Fabio Estevam wrote:
> >=20
> > On 18/12/2023 20:34, Stephen Rothwell wrote: =20
> >> Hi all,
> >>
> >> After merging the thermal tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> ERROR: modpost: "__hw_protection_shutdown"
> >> [drivers/platform/chrome/cros_ec_lpcs.ko] undefined!
> >>
> >> Caused by commit
> >>
> >> =C2=A0 726edaad90f6 ("thermal/core: Prepare for introduction of therma=
l >> reboot") =20
> >=20
> > Thanks for reporting.
> >=20
> > Daniel,
> >=20
> > Could you please squash the following fix to the commit above?
> >=20
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index 07eb6537ed8b..f814568525f1 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -1002,6 +1002,7 @@ void __hw_protection_shutdown(const char *reason,=
 > int ms_until_forced, bool shut
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (shutdown)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 orderly_poweroff(true);
> >  =C2=A0}
> > +EXPORT_SYMBOL_GPL(__hw_protection_shutdown); =20
>=20
> Yeah, I've done it

Forgot to push out?
--=20
Cheers,
Stephen Rothwell

--Sig_/Pwu/KAh5DGTsDjKpWgLYzm4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDkjkACgkQAVBC80lX
0GwiuQf/WHt1ViM+2dq8s9X1CmgWhoAFblnctgEGXTq8oeyjwtfvHKtGTJGKf3wS
AellQ835ruI8IH8HyHgnGF9z1oa6/zz8L0GbiwS9ttJrAsnQZ34JsU+wKnYYvj7a
1/dEeLE7UdQz1GlVe8z70Sf5FM8Xt5SdsTeVgjDsgayYiqGNT+R5qrGK3Cwx91O/
XIlcPXfqtpc4btmvcryrgnvKUEZQWDe5ghL9kbc5/hxwcC8wRo9Fxexg//RP/jCv
9zlQBf5FmcGSaX35rm9wZB63msPZicciP78ViRftkLH1yyNpKF0JrtCr8gdX2udA
nqB86w9hOuwFqavF1d1Nsx+i7+CFCg==
=6+mI
-----END PGP SIGNATURE-----

--Sig_/Pwu/KAh5DGTsDjKpWgLYzm4--

