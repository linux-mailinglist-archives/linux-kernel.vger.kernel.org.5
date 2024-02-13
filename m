Return-Path: <linux-kernel+bounces-64543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFED854021
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3538628DF11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B663110;
	Tue, 13 Feb 2024 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pCbF0zTK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C562A02;
	Tue, 13 Feb 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867025; cv=none; b=Zl6AmSeRwiXEWw9xLKUr4h5OVHyJnSFLnqxyqIT8nLO6BNDOb26GK1PiwLyUgrpLsEhgahG9PlrOA9l1jFHOuce0cyeEwD1bGLzShjY+DAcMgughYNLgUtRIEaSXIQu2YRvk42Ase2n3lm/Ix7FqS42TrXYdNpWqNHvbZPWmDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867025; c=relaxed/simple;
	bh=tBCl0jWLRkN/MadVKH56rgtBZN2CTSGsYrQR/Y5aZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Tq0A+0wOIFzzJTWZFXeG0HG0Jok5uNtPbvct3gMDGiwS79kjy9oMsfTnXTEGSmeKkdcXaghd6DtB12UTtWrT03P/a6LIThf0THc+jLDxSDmzWploioTnnOEFpyEX20S9KRHhs2xCwSJSLYme0TBPZG6EczcHKdUr/WgXwLY3UXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pCbF0zTK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707867012;
	bh=KUZSxNr3xB4zN0904cbczi0hkdWBqZu7Pp/ST+wPnRw=;
	h=Date:From:To:Cc:Subject:From;
	b=pCbF0zTKq3BOWUaFMJfoFD4F7IGO0XytcU9m3dSSHRz/wZd71mY52f1KUvQACQFal
	 7pnG2xhptNVVBk+m2030LRTzKHspZL5jBmLYcce7d2xk++wSvLTMKe2fK9/bh1gebI
	 YdbSvxjrRNh8R0dDGndNF4g24xESjQ+luwcpRTpmF7ak8NHKV6eMY5oFCnkeRHt8hI
	 lJChcqalG5FZk4l1mkKXpyK9WeOkXo9Z4Mkvga4h163Q5Fz2bHWzzOTOzC/Fhn7aq7
	 exXG5ROBfm7a6mI0vqtLBs4V/Gi+74CMv3LXwxQQ9pbHW1BFcQD/AkpGNQP1pqyFe7
	 r/8kU4So73dlA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZHcM1GQlz4wc4;
	Wed, 14 Feb 2024 10:30:10 +1100 (AEDT)
Date: Wed, 14 Feb 2024 10:30:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: linux-next: manual merge of the pm tree with the pci-current tree
Message-ID: <20240214103008.0bb12069@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CjylUucKiAPUPy98I.Dpp4t";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CjylUucKiAPUPy98I.Dpp4t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  drivers/pci/pci.c

between commit:

  41044d536068 ("PCI: Fix active state requirement in PME polling")

from the pci-current tree and commit:

  c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/pci.c
index a532bf597e57,cb51c4079013..000000000000
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@@ -2361,36 -2522,29 +2361,36 @@@ static void pci_pme_list_scan(struct wo
  		if (pdev->pme_poll) {
  			struct pci_dev *bridge =3D pdev->bus->self;
  			struct device *dev =3D &pdev->dev;
 -			int pm_status;
 +			struct device *bdev =3D bridge ? &bridge->dev : NULL;
 +			int bref =3D 0;
 =20
  			/*
 -			 * If bridge is in low power state, the
 -			 * configuration space of subordinate devices
 -			 * may be not accessible
 +			 * If we have a bridge, it should be in an active/D0
 +			 * state or the configuration space of subordinate
 +			 * devices may not be accessible or stable over the
 +			 * course of the call.
  			 */
 -			if (bridge && bridge->current_state !=3D PCI_D0)
 -				continue;
 +			if (bdev) {
- 				bref =3D pm_runtime_get_if_active(bdev, true);
++				bref =3D pm_runtime_get_if_active(bdev);
 +				if (!bref)
 +					continue;
 +
 +				if (bridge->current_state !=3D PCI_D0)
 +					goto put_bridge;
 +			}
 =20
  			/*
 -			 * If the device is in a low power state it
 -			 * should not be polled either.
 +			 * The device itself should be suspended but config
 +			 * space must be accessible, therefore it cannot be in
 +			 * D3cold.
  			 */
 -			pm_status =3D pm_runtime_get_if_active(dev);
 -			if (!pm_status)
 -				continue;
 -
 -			if (pdev->current_state !=3D PCI_D3cold)
 +			if (pm_runtime_suspended(dev) &&
 +			    pdev->current_state !=3D PCI_D3cold)
  				pci_pme_wakeup(pdev, NULL);
 =20
 -			if (pm_status > 0)
 -				pm_runtime_put(dev);
 +put_bridge:
 +			if (bref > 0)
 +				pm_runtime_put(bdev);
  		} else {
  			list_del(&pme_dev->list);
  			kfree(pme_dev);

--Sig_/CjylUucKiAPUPy98I.Dpp4t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXL+4AACgkQAVBC80lX
0GxorAf9EfEqMCVJVb8TqWHS5bC2IMANFydH3wDCtEx3H181jUlGPm5/ILxIn3+f
ONcRv8FVGwEJWSiVDkPS/dLg/q0gcbz46khaxpC1GN3n+1+BJCmJPNuVIftSL3bh
j7si/FsmxUVsa0Ji3ySIf40JvJwyD3dVOVJRAjK60E/TOz4dQ2hAzuJGAg1VSNMF
e5RxDK0QaagWrGrw02vVydvfKiXxX1XjnEb8KeCR0KB5QVG9VrEkhENB+vdxWvr0
s6DABfEKsZzOrrNTDxMoxJmc3SSeyrWmHqzUz8P79LFOA24hEcbjRsp9YAjKShXu
sxjfT5eJlpax6C3pjqfkUInLiFWcNw==
=a//M
-----END PGP SIGNATURE-----

--Sig_/CjylUucKiAPUPy98I.Dpp4t--

