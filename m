Return-Path: <linux-kernel+bounces-77761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6718F8609EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994F01C214D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9E1118D;
	Fri, 23 Feb 2024 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rKNURIUA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89BEAD2;
	Fri, 23 Feb 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663005; cv=none; b=PhiGy9lTzTKGtTKF0N+gX2JAD63QCylovTOwzogePv54jsvcq7S+QtcGIKeJ02WR69FStAcozDPjVocTi4CVsqCXL4XhaUenrWyzFSN8fChWu7AyrXT6WrX4KC3vVaXbTioNaUTZHND3f4u9wG5tcI5IALfXUObs9Rh5ZbpQ8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663005; c=relaxed/simple;
	bh=/FyjzMk6/1+QlLgjUrBq4h7dcYzZb2xLEL+3ICH2UhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mq//SFj70p7NA3goCaBBt6FsHcs5quhDFXOq2x8wbZA5RaJ962GFVMyLEKpm+kZf0YLSgJ7HzREB+mlKRZ57pMrs6miY/V3XBvKKIgqpFnjqlPvn0ROBqLy3sgTEMQqndMKJJ3Av32Sy6+suV1T/Z5ATVKXuNsTDIPloiTraBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rKNURIUA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708663000;
	bh=h2FyDHHxJrZbIdFI4oPYrRtlgmcQ6ZJ0mwEOJXqzeCA=;
	h=Date:From:To:Cc:Subject:From;
	b=rKNURIUArkXH2hb9+yJKBlzBCSy2bVj5UCWtgVohauxb/i+W18U0KCmVnu//Yuuy6
	 tNEVFP7vp6Z03QAojPcq59gaIZkd8nrDAlqEoTMvtnvdFhG22pER1pOHsu8U5qc3ka
	 TSY/AONZBsLwxECgArS9Hbsvf6sPJzC6ZenZgnTVfmc8yg+h8UtjrZcm6QbxHJbK2c
	 Z1FaRhgAdBGrSLktD30FU9XZQ3XwrfdPmVJauGQ3X0qevK5aG6qgAp/XP6Gy+/P6kf
	 pDFZZUocDHFAc1TFfd9muOSz9PoJUrkbJ1e9uOiAzchNUuO28q9uXlV+nvzcXxLHKE
	 4eCmI4gVdtjTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tgxzq1f3xz4wcF;
	Fri, 23 Feb 2024 15:36:39 +1100 (AEDT)
Date: Fri, 23 Feb 2024 15:36:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Darrick J. Wong" <djwong@kernel.org>, David Chinner
 <david@fromorbit.com>
Cc: <linux-xfs@vger.kernel.org>, Chandan Babu R <chandanbabu@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the xfs tree
Message-ID: <20240223153636.41358be5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SqI874M6Z23o3JjKW/QTqey";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/SqI874M6Z23o3JjKW/QTqey
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the xfs tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/core-api/mm-api:130: mm/shmem.c:2155: WARNING: Inline emphasi=
s start-string without end-string.
Documentation/core-api/mm-api:130: mm/shmem.c:2156: WARNING: Inline emphasi=
s start-string without end-string.

Introduced by commit

  d7468609ee0f ("shmem: export shmem_get_folio")

--=20
Cheers,
Stephen Rothwell

--Sig_/SqI874M6Z23o3JjKW/QTqey
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXYINQACgkQAVBC80lX
0Gy6Ywf+LUwcLue/f/XGLbpFZOziQf5znp5r/1uBbjhFeTX4LKYa2fYRf9ZNZXpM
TXs1Mexiq7mQwizGj8Hs+yG6dAke5HhYnWsMGT6eM9w9Ik0vC0RNR6lP3y0/Yn5C
DkPnJHDpVDgmK3gf6VNvHfu0T1ZNCsPQgh76iOoraq/PV8x82w8S4TY5Vdlq+bpx
rda16KzaBejgJytI5nFiBlao87BqeTEchCAilNMwUPDbXXe7ylQ2juy2F0m+6BtA
EEkBwGuVOYDWdeC+pI98mCJHuhO/X2KIaGwtMMLsPKupKo5zwZUSkSxpfMlKNJA2
yrgF0+zv+Iy1W2GwH2kYQ5RsgqkDUw==
=rzkb
-----END PGP SIGNATURE-----

--Sig_/SqI874M6Z23o3JjKW/QTqey--

