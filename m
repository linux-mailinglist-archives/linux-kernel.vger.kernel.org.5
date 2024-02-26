Return-Path: <linux-kernel+bounces-80434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C534866868
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45146281AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC119470;
	Mon, 26 Feb 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="izpYQFOR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504E17BB9;
	Mon, 26 Feb 2024 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916270; cv=none; b=Ys+K/Jg//kN5lS/r2i3xRnrwomeif5kEg+iTjt5mcocqebf+Oq1+wXB30LOjlHTG8gvE9ZXTYMzFvak1dkWmkSySgtZZRfShFbaw0HpGgL7TjpDOEsDidfP4xWO7Yuqr3+a+DyYVF5yhOHKUjDLM2IhwPV8jNuAB/E++LEDke7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916270; c=relaxed/simple;
	bh=sf0KuPewUZdF8qwi9t9dgOKKjG4aN33ww+ZjUC4PqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nAeG55bi21dPts44COTL3hk6UGz86wvjQA/yVLUWmbuF5+BBMUiYGU8bmYvB5aZ/xrCbRT9wWiD+dmQQ+ETzBPiKquDln1+0evssuZxSaR6B44L8snjW1CZqi4tc15P5O0c6flpc75KEY+OS5sZSsccf8PLWuNZnYRUMvA9CnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=izpYQFOR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708916266;
	bh=MIBBx6GI1McT+ipBiqM/URogFUQRYQ2StmjJeyQkKFY=;
	h=Date:From:To:Cc:Subject:From;
	b=izpYQFOR/IbI+5PtE9V9CKOrVm6RblRIfkkXotuQjU/i2BmOVeprc1T+32SVa1wf2
	 Icb/zi4ezbwpAAz83Ox6yykn0ZPeQXO4Mmtv70RbVezkGCulxgs7W/qojwyZa2Qep6
	 35H3ws7KguLHWE74KhZ6bKWgo6vYUa2zPkgQAoBTJ4dyi9tei24d9ipP8IwIHClZNb
	 cLJHVv1Vsb+yCFu1zBoxxuqeJe+wWIQEVSRauXVDpexK7kyxRLgiWsU4pVjTS9JrH8
	 kbWhXVORO/jAV7TXRaDvtw6dZHmiknRu5zYmplhRr6h0KMYRTeSzrlI6x6eB2f1KvZ
	 yEbv8C5bwEtoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjlfK69tlz4wcC;
	Mon, 26 Feb 2024 13:57:45 +1100 (AEDT)
Date: Mon, 26 Feb 2024 13:57:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Nikhil V <quic_nprakash@quicinc.com>
Subject: linux-next: manual merge of the rcu tree with the pm tree
Message-ID: <20240226135745.12ac854d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4gv1_Pr=DbHejtL+I7uOn.=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4gv1_Pr=DbHejtL+I7uOn.=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commit:

  3fec6e5961b7 ("PM: hibernate: Support to select compression algorithm")

from the pm tree and commit:

  600716592a3a ("doc: Add EARLY flag to early-parsed kernel boot parameters=
")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/kernel-parameters.txt
index c503770e8f0b,3f894fbb4916..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -1753,18 -1749,7 +1754,18 @@@
  				(that will set all pages holding image data
  				during restoration read-only).
 =20
 +	hibernate.compressor=3D 	[HIBERNATION] Compression algorithm to be
 +				used with hibernation.
 +				Format: { lzo | lz4 }
 +				Default: lzo
 +
 +				lzo: Select LZO compression algorithm to
 +				compress/decompress hibernation image.
 +
 +				lz4: Select LZ4 compression algorithm to
 +				compress/decompress hibernation image.
 +
- 	highmem=3Dnn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
+ 	highmem=3Dnn[KMG]	[KNL,BOOT,EARLY] forces the highmem zone to have an ex=
act
  			size of <nn>. This works even on boxes that have no
  			highmem otherwise. This also works to reduce highmem
  			size on bigger boxes.

--Sig_/4gv1_Pr=DbHejtL+I7uOn.=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXb/ikACgkQAVBC80lX
0GwQWAf7B+7G0prf44SGgzsLu+Bb6kk3pV+R6mR573pVFBIZnBuySykCFvucCeGR
hbBpdNKOQA6wG9C7Dm/HqnYGdJZb0NrxYJyMR/4rH2giAbpROE6Okyy8QmT/C82E
Taf4rXpOiacEIfuy5FhtDN0NF8BbeznMq3MaOc1shWzHbn0VuA5dNrIfJIJE6MSm
5hQ9h+DGnGI2jzvAJTxNqXMXbw/VUPfYLUFxOTOlcdTu20x7uziIqPXjf2V9j+Md
z6lnRjwxPwNz5tybZQ81eMvG6xVauEWjMTOF8d5LSrj01PnVwuvLcAkmHTYiMG8W
MuEnHX7vKIvAtqRNg18v7tSV5c5CVA==
=fcfT
-----END PGP SIGNATURE-----

--Sig_/4gv1_Pr=DbHejtL+I7uOn.=--

