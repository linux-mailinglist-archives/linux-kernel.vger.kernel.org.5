Return-Path: <linux-kernel+bounces-127240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E003789487D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950F51F229E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE2C8801;
	Tue,  2 Apr 2024 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f/A3RYnB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B576FB5;
	Tue,  2 Apr 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017881; cv=none; b=gS1FUF1Dpjoyp6X9IZhg+rZeDa0nXsaa9FT7weGqPQ46/O1UcYENP57aO2DJd7sKMUiUivbA8hNuZpQi/fcTm5hc94xm8RDadlA2mw8s4yQZ7jRH/XM93lZ/kU4lgY1H2RCIRdU4Dpq0hIM2XqBoxzYPQBTIdbfv1+EIFw1u7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017881; c=relaxed/simple;
	bh=p/kYRXCG3EXldmhrwvxNFSPURefbLJ52Olitn6V1PFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hRpC+xSawT83b4Pvn8xDV2gvUm5nUARiIqY+eqV3btvRTCSF/CxvXEm2RRIDm0ch1KYSa1uXBuVxgwi4YtKYFddKahSa2DfkLy9QKWAoSCMDjCWp7dBA9zyaPekxqCU/raxKfVHiBouCpcNHIn5rIqURkb8AoLvK03aJoQGbdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=f/A3RYnB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712017877;
	bh=fZrvENVuJ9o11XvfUl1+MD5rilFuz8GnYSSSRU27Z2g=;
	h=Date:From:To:Cc:Subject:From;
	b=f/A3RYnBavwlL5rCX5HwtCxR7SCOxlvXz0lh4urozQypKM7+DsLmf+kZFweQQeko0
	 bfh7LdAjKnLo4JlShgF/D3dF3a7L/rYMhPFsni+RtrZ2WAsYnJzXLq1ahVN2joYigm
	 /t0yEPFOR3VUmXd0uwQshXd8oSOFCq+Qp4omeAfccmVIomF9KPxfHORh5bf9ogFS3a
	 8tLzg9LQuyjR1TMmz78ypJqwRIO3Ux3dt/OSroCMSLEvh+EBQ/e3vLMRa3pvLeBj8Q
	 OhD++FCnPt0CNYsDXaN26svo0f6AdNeMGKB40vA5J1BNqYjg2X591KOBhpn6gaJS1K
	 YjClfp82rFfTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7phh55b6z4wcn;
	Tue,  2 Apr 2024 11:31:16 +1100 (AEDT)
Date: Tue, 2 Apr 2024 11:31:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Damien Le Moal
 <dlemoal@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mfd tree with the pci tree
Message-ID: <20240402113116.70d6a885@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fA3L7O4dNU2PELsc/ffE9/0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fA3L7O4dNU2PELsc/ffE9/0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/mfd/intel-lpss-pci.c

between commit:

  5133224938b9 ("mfd: intel-lpss: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGAC=
Y")

from the pci tree and commit:

  e42199bf13d4 ("mfd: intel-lpss: Switch over to MSI interrupts")

from the mfd tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/fA3L7O4dNU2PELsc/ffE9/0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLUdQACgkQAVBC80lX
0GzDIAf9ESRcmKxSd5rjJ7XD2ySrZXXgVr3ITndM2xQrulH4evuq8qzdk5YKWAnq
YY+AKBWAG4OEx/pN6XwQp/GlT46cX988wtlb3tatO/GBBu4GQsTK8I2pW+viT2L3
puOqx5UMX+CiPYK+I38v3WQ/mXgvp9I6fEe7/7qvi3gZDolEG+lkL+55vAoxEw3N
CRJAZnLX0q1aEv5GwVwd4LTo+jJuuJkTvvFLR9Xtq+KMJrIwh1t32svDMgSlHzgG
SFlTAHLUCpMdoM6WdnYp7wIOi0LnSH/zWvG35y1aHuHdQ9yI+OUUwCa7uE+uZgbL
jZUYCp4lPcAVF6Y/VjO5VC4Xa3lgvQ==
=fq+a
-----END PGP SIGNATURE-----

--Sig_/fA3L7O4dNU2PELsc/ffE9/0--

