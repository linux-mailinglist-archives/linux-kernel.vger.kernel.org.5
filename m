Return-Path: <linux-kernel+bounces-6321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A148981972F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03FA1C2491C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F9311C90;
	Wed, 20 Dec 2023 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CFdT8pli"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70931170D;
	Wed, 20 Dec 2023 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703043083;
	bh=UBtZorlYXl/IJVSycyYe3PVIAIR0pBLPK3G7YkM7tMw=;
	h=Date:From:To:Cc:Subject:From;
	b=CFdT8pli7RnNAV/8imDlVb3+cfeSccSjoekz/MvekqZ5SbjmL9I8D9MWtWcjYICVc
	 tQUS7usFg+8ZtJRNEc8sAmxzcxyUQGVwBuI9RPYUOp2Sv6nk9aODGrMMYh8mUb1Fy5
	 Q8l3pqfhyw45C8OylCg2Rxrbl+zBMdfllh7y0EJOhiaxsXM5cTrYsgs2wPpw9ORS1t
	 2YXgTfJ/Q5RPM5zdVtyeoVW6UfxXsQ2Kb1fUOvVFD8YS/az79XH/+IUvxolWGeB4Rf
	 N4wQRL2qwqd9EVMqJkYVC+Yas9mAJD0dc5eSjEBFxesZFPzo2FmeiOYW00Vbcsx7s0
	 IBgyWxQApjOhg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvzcV6gbYz4wd6;
	Wed, 20 Dec 2023 14:31:22 +1100 (AEDT)
Date: Wed, 20 Dec 2023 14:31:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfio tree
Message-ID: <20231220143122.63337669@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C7OMmRpPzb=BIZY3jjFxCNL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/C7OMmRpPzb=BIZY3jjFxCNL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfio tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/vfio/pci/virtio/main.c:550:6: warning: no previous prototype for 'v=
irtiovf_pci_aer_reset_done' [-Wmissing-prototypes]
  550 | void virtiovf_pci_aer_reset_done(struct pci_dev *pdev)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  eb61eca0e8c3 ("vfio/virtio: Introduce a vfio driver over virtio devices")

It should probably be static.

--=20
Cheers,
Stephen Rothwell

--Sig_/C7OMmRpPzb=BIZY3jjFxCNL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCYAoACgkQAVBC80lX
0Gx9pAf/RTRjfluj/tIi2R8Da90i4lEfbMYZRZQlD/OzNBQX0FuVvKsALzEPEpqO
NNeTuvAy4PkBXp6Ib/U7NGmCCy+/pEpUVIpQcAnJVbp+6ZZ+EIDgWHdzhFJYVJ3B
ohCJ7/Y0pjIsjbTSIr8q9OIx7NNJ8Ceb1q6geU7KuyTnMIXJWMD861HJk//KMVi1
WDP4p7TCjhGarg6k4CeBA3i/AyvLa3OtyFCapHcLD3XZgflWIMTgFHoGqqrxkg3O
BK0XzEguGgUR5pRI6jMKVCtrItqyh8M8InbHp7rtwTsB5LIbiAlFYzRNY3YhhjGG
MG9CPLSspGzzARMH95a8NHCw77ejDw==
=SVy/
-----END PGP SIGNATURE-----

--Sig_/C7OMmRpPzb=BIZY3jjFxCNL--

