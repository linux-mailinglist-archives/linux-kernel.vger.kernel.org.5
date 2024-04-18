Return-Path: <linux-kernel+bounces-149407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230B8A90BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DA0283ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453C424B4A;
	Thu, 18 Apr 2024 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rcaZKQ35"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255F1A5A2;
	Thu, 18 Apr 2024 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404056; cv=none; b=Xd/L/GQtuUJoWuBWPVAAPsM8ni9BDUh+Uxc9l46QTmqLirUtHE4JV9D6qZwioj2OnYrcchpwhI/EHnJpNE/VT9YAP8Cy8NQN0NjDbMLY4Rjxp4OwAMa6gGHBMbTtLybIAKAX+HVJMozzRKsSi+vJC1KG43rtGnt17S9tGD94E5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404056; c=relaxed/simple;
	bh=40bi0vrhk3vA+zYhVlSbaVcJKKZcL8qD8xwjiiHiDdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OYAWqfIYIDpQsWFyda940fE7kI+7FIqW2lZfsX1B1TgjTZQmZ1QsWCAYar8Ts8nmynA6M5etdUCkEo9+hmlyxjsmTkXYaKkpOsGBErXWT5TgxB7e1r6xntYGj9EbONeXhqIlV3+a+BGYJpsC9X8nHHgnUOH7TQbDgThG6ViWjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rcaZKQ35; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713404049;
	bh=nPXlTkU93bQ4+Q1L6del9DzlcYprWJaUtG5tpvstX4M=;
	h=Date:From:To:Cc:Subject:From;
	b=rcaZKQ35lYQC5WF8rfULBgf+9tNcqZ/zSuYcK37Jrt3VdM8ffgcshMO052eLEG2Uk
	 A89FykxuPuGsRz68QbxYjCY7GN5t7HclpICl8baqgbV9AElO/6+ScnLUbi+o7CRG5D
	 yYjETNs9G8asN8zpefcpwoT8z0XrXQEe2dPrlgUhYgOxY0XnUqsOVHxe4YmSZj6/Wc
	 ABIQ4XJEPHkt62ePScJWvYM2BhIAWhD+tXWekY6TYYcl/HCk06LWVdRQaJCMPuYLfX
	 1KO6nYpkAUCJorC6Wy02M457h7pdndYTLS82VrAE/i0+X8SDid6L5dnecxp4F4Ti7u
	 IpSukqePfj74A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKgKr3dRsz4x1x;
	Thu, 18 Apr 2024 11:34:06 +1000 (AEST)
Date: Thu, 18 Apr 2024 11:34:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: Networking <netdev@vger.kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, "Kory Maincent (Dent Project)"
 <kory.maincent@bootlin.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the stm32 tree
Message-ID: <20240418113403.06e5ceed@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dK=CpwLGHY4MIi=f.grU+VL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dK=CpwLGHY4MIi=f.grU+VL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/of/property.c

between commit:

  6a15368c1c6d ("of: property: fw_devlink: Add support for "access-controll=
er"")

from the stm32 tree and commit:

  93c0d8c0ac30 ("of: property: Add fw_devlink support for pse parent")

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

diff --cc drivers/of/property.c
index dfdda94834d5,cc064151853e..000000000000
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@@ -1252,7 -1252,7 +1252,8 @@@ DEFINE_SIMPLE_PROP(backlight, "backligh
  DEFINE_SIMPLE_PROP(panel, "panel", NULL)
  DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
  DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 +DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-con=
troller-cells")
+ DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 =20

--Sig_/dK=CpwLGHY4MIi=f.grU+VL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYgeIsACgkQAVBC80lX
0GyK2gf9F8PsfK2iumwz8tvEIJtyQYl1aDLpokl2QDXys/AAVMjSOZEK4P8aHHea
WcDdJgjx4CowEHdBsvFRPDRf7ku7D9n1GWhpzmVrkEMrSgl+n/245C7IdbLQcFO8
P/R5aP82LJZy9r1c52Rbd1o03z2v9bZKJ4e8Y4cxkQzcqv+Bbne+TKI2zHgW8Yy6
rcYQxI8xvaJK2bFIUJlBqUtFi47db7Ib5TMRtgs2dIKNm8Ly+zYJVRRccWewBlXW
pkLkGK4826hjOfPSLmhofn/0dfqQA2AH4A0QJU6nKcdxtKzVJ29+/AY1pH3TVK6c
5Say36uPL9DZ5TxMH+wksle6bl4/FA==
=e2O8
-----END PGP SIGNATURE-----

--Sig_/dK=CpwLGHY4MIi=f.grU+VL--

