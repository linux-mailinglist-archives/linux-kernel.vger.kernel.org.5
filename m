Return-Path: <linux-kernel+bounces-156222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A038AFFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E80B22D39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185E13C3F8;
	Wed, 24 Apr 2024 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hv2umyKP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADC2E62F;
	Wed, 24 Apr 2024 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930047; cv=none; b=QUYmqm9dnstBJUDXI8wLK7iXHTfeh2dtFZ+z0EtoxAwtheNeXz1Ma91GCbgYpqLxfpRufiu2CRLuk/AhsrfCt8BJ5Emqdw340PU4qeBjFoBEnHPYykDIU4OpjPWc206quPX+wbWZzL7+DoVVP8J/CPqUeGip8+zzymMD53TI/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930047; c=relaxed/simple;
	bh=TSoe9AjLh2xT47kF4u9KjUP/QLLrWb9YhK9iLQNESSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cjeXAxel3YXBXx8AfOBDq9jT3ZHw5HFWhGPOQdlJO44Rl1OuaY6TG4BpbkDz7endKg7D2wCP4ep/gBjUJaNXCX7f0u+OnHaQDnqfk6V0cNw02Jz0Re9vtfu034azs/IT5rS6L8wmtNjludNn+uV5FgObSA0QKkp17ZTFv9XzMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hv2umyKP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713930041;
	bh=bG/fMaEnCOyIuDV9RDHJi6dZU9qMJoxcxKKp0+w5cuA=;
	h=Date:From:To:Cc:Subject:From;
	b=hv2umyKPKmGBQ2UiODimtoNErCcQVXFeas716MXEMiWmY0OPH9+CDXatq7my4A2pF
	 NLX1F8bzLJcV6kPFQE0iY7F3CwZ0xILlQ83nqFNCHcwhnGtcTx08728QXlCnrgiKEU
	 VdAtU2v4yVNbH8jdRo8oNxE7za9BU58MZxzWoPGgXAEYZVLkxXHrcj++W9YQY/a4dR
	 95I1xDj09o37lBrhy81cB1x83s0LB7yAQ4u8HKPizcpirJe06j4RHZaDepU1OaLvbl
	 d/gX6A6Pa1m6gBij5avlo/RUxMVVJpfmvig79/kHpJCD9Z8TLXB0yQH615fL/VPnTQ
	 oKlhKneppUx4Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPPs34PySz4wcp;
	Wed, 24 Apr 2024 13:40:39 +1000 (AEST)
Date: Wed, 24 Apr 2024 13:40:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@st.com>
Cc: Networking <netdev@vger.kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, "Kory Maincent (Dent Project)"
 <kory.maincent@bootlin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Saravana Kannan <saravanak@google.com>
Subject: linux-next: manual merge of the devicetree tree with the net-next,
 stm32 trees
Message-ID: <20240424134038.28532f2f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6VHmicBbB41m5RkaUQo4PEu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6VHmicBbB41m5RkaUQo4PEu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  drivers/of/property.c

between commits:

  6a15368c1c6d ("of: property: fw_devlink: Add support for "access-controll=
er"")
  93c0d8c0ac30 ("of: property: Add fw_devlink support for pse parent")

from the net-next, stm32 trees and commit:

  669430b183fc ("of: property: fw_devlink: Add support for "power-supplies"=
 binding")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/of/property.c
index aaf3ce74f85c,4ede45001025..000000000000
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@@ -1252,8 -1242,7 +1242,9 @@@ DEFINE_SIMPLE_PROP(backlight, "backligh
  DEFINE_SIMPLE_PROP(panel, "panel", NULL)
  DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
  DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 +DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-con=
troller-cells")
 +DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
+ DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 =20
@@@ -1359,7 -1348,7 +1350,8 @@@ static const struct supplier_bindings o
  	{ .parse_prop =3D parse_backlight, },
  	{ .parse_prop =3D parse_panel, },
  	{ .parse_prop =3D parse_msi_parent, },
 +	{ .parse_prop =3D parse_pses, },
+ 	{ .parse_prop =3D parse_power_supplies, },
  	{ .parse_prop =3D parse_gpio_compat, },
  	{ .parse_prop =3D parse_interrupts, },
  	{ .parse_prop =3D parse_regulators, },

--Sig_/6VHmicBbB41m5RkaUQo4PEu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYofzYACgkQAVBC80lX
0Gw/oAf/fKyulU2sd1RYcf+U2zsRb/N+YJjBdkPTI3QXWtAlU1N3guosEac4kGLV
uFipdLF85Ou+WQytSq03sVea+yhBCNfAv52kmvsn2NFYvgBwOnxqAonxAqyh6yWP
KaTfKZlnpUHJ8BuO1c/dJ8VimdJF+6PrEr3DWrGpleTeN1HXxIK1j9rA2WcBdpx8
rTSsaEZcivP+i98PfzhplBgMCbPdM7Bk4606cEv7beQ3f/3p0l+NKP6iZ4MQqYzZ
DhQFf/x+S2DBIrAIK6D2TZXzSg5qC91jjwcnEfbrdZrfbWZA7vNSyW3XpknuzE4R
RQ4hWgeLy8j1OrJSiJw7mDPTAgpp1g==
=TABj
-----END PGP SIGNATURE-----

--Sig_/6VHmicBbB41m5RkaUQo4PEu--

