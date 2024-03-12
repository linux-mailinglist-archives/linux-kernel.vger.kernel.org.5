Return-Path: <linux-kernel+bounces-99819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC2E878DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA77B21966
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13DC2E9;
	Tue, 12 Mar 2024 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ed8UlyuJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AC7462;
	Tue, 12 Mar 2024 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217989; cv=none; b=bmRLgDGYXzHo316GfHwgC6tWQo+h59xHfcA0LBc2pIlmb6rGgVhqPf/oAFzTKW8uiB9c3GQrCpladQwTKSst9oiu1H0o8wqMemEqWVm78EmhRmjWRb5cT1WV0jJCuFL5S1YAboN/twU4Ue7DikM+RG5KqbldamKKfkVMI2epzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217989; c=relaxed/simple;
	bh=j10oimAmH99TKiSge0C9cHnviNfEql0dxrU5u+XIto0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EUnDdvqZDhTmB4GZL6BrEzKb7zJ+88ZgFfyBpbycXFRP1GP5vl/3b/9r0rb1IMFP5SZwnXUdVW4oXgl7JJpci+dZO8xMFOmVstD/JtaQ/d7+7YiS7Bt6PEp9Ero6suD5rNuVG0g8uFB9SRv7Wr6N/w2pPzQlRe0sAWih2VgLlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ed8UlyuJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710217985;
	bh=R1Ew1RMSsnn7l4BfDZxroQxwWR1kGGi0NbcoiTKG4mg=;
	h=Date:From:To:Cc:Subject:From;
	b=ed8UlyuJSE4sN34qEHlYDelE65FS7gGb9n6fIJ5nuD+vOvnOPCTFAHhOuXl3QxbFj
	 k57QxSElJkDmJMUUBSWzu6Jph+kZ31KG1urrXpVSDxJqMzXUJ4yenw+WZ6p7aflezj
	 zBRzj6EGtaJi6XVTKFPWCJ+JPeDRSlEskcxSb4eUP/fkcVuOVR0GAPqo21HObpLvS0
	 S0/frrnM+ZSkXCjW+cU2imAlrWDJ+tmmcn4gJE3zmTrknCWNc6iztyMKl/eB5h+I7y
	 JDVDiGrQiFxHKRvXmgO1tYJ0y+G5OptCbaxeEX56bz7lH+epSlo2+PGEYzqa64JHaV
	 382AGyoA9RRZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv13P3LN7z4wb2;
	Tue, 12 Mar 2024 15:33:05 +1100 (AEDT)
Date: Tue, 12 Mar 2024 15:33:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20240312153304.0ef1b78e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6adXpQBl2.BU2arPGWaxwX_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6adXpQBl2.BU2arPGWaxwX_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/networking/multi-pf-netdev.rst:94: ERROR: Unexpected indentat=
ion.
Documentation/networking/multi-pf-netdev.rst:106: ERROR: Unexpected indenta=
tion.

Introduced by commit

  77d9ec3f6c8c ("Documentation: networking: Add description for multi-pf ne=
tdev")

--=20
Cheers,
Stephen Rothwell

--Sig_/6adXpQBl2.BU2arPGWaxwX_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv2wAACgkQAVBC80lX
0GxPZwf+Lw5n3KKQ1nysC0NYi29VAn8dDaVvFyoJDccMm1A+EzXr8x7174ZZu6YY
PzKX3dL+D+q3+T6UZApcOK0UMbxHGM3itqm3Grw0aatpY5gQ4URPRoW5DpGK8k3T
cRz4/SjCSpytjl/3k6pvEMe+QeFUhzkbya7bVRoIVqf5juSk30WZcX989CjTRcBl
hjpZuLZqD+zpvCoaD7LOd/0mAS+x9RLMs5HvCDGc6beg9ExTJFnMca/gcUENlMsQ
/TKXtAJ23fsN99hOZXXkIGfauUonckE859vz7YPvCotyeKOl6ZTyvIpKNCyglLRO
WIEXOyEuGyL0j7nPLzJhv2ovmUcDrg==
=IIu8
-----END PGP SIGNATURE-----

--Sig_/6adXpQBl2.BU2arPGWaxwX_--

