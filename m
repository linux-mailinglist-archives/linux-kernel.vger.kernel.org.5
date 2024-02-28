Return-Path: <linux-kernel+bounces-85855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F6386BC49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125B41C2244A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58572910;
	Wed, 28 Feb 2024 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZcPJ/yRM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CA13D2E3;
	Wed, 28 Feb 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163706; cv=none; b=eGIYf10a/r6F0ZBqV6ZhW1A/K6oI8xBh1KleHPUh84IKnTFcFPmgSnJZbZ/f8RMVIIn1MHPg8Dr0aGFZDEwEhEFCK/p/QSeZhxk5BHfW/tJQG+fL/+l5VL2ztO/UrTdKu+sF+OGLNcRUWbjx36/37ozoWz2fOtDJI9Og7+O81AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163706; c=relaxed/simple;
	bh=z61fUCMZnjjhj9QdNocZxM5xyU0sgalhNqu/6eVFFw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eJkHvMI9334vk7Y8GRrfbDYwhB+zrgr3prGFcdzWWPsL1SsAo1s7wBNaOT/qwcbcndcb0XptlGwVCHqkjgoKBLWLt8vC2wI4XfjsQfRERUkNVNg1aEtNojvIfES9GFvzxnlZJEpB2G2YQiyT6yDx4XNHe4TKLEQBnejXd4LYoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZcPJ/yRM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709163701;
	bh=9D6/S4ytWozDqPCtOD7mHgpuDETYo/cvVZTssRszGoo=;
	h=Date:From:To:Cc:Subject:From;
	b=ZcPJ/yRMb3IPJBTpPr/klnRVqYcdCJmhXFGf9tr3pJEL76SbU0EBAEpJnvtiAlIWw
	 TG2S6LF+Erx3ZV4N8cUDzKZcVTfivIVSRgBB9L1gwlGA4B2iDFJKxFzQEzQEmr1TeM
	 2W216PT4mnmOSk4oFR+rXb+aZF+LLQDpa7WXIaEjjzUwtRIwDZEzBdj8tal3m5X4MN
	 ZKVEMhkxeevbsnhm/6adEAwSSHHaq3/6rHlWsE7dozTWs+v7argdUuI6bhsQ6bfOCY
	 xS8FqBFhR+tVsH+EYBoJX00AQyUxTDUED57EtMFFmgHOznRk+NmhlOSXoxEJ6otOYF
	 OgqG1XCYyBSTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TlW8j0WB0z4wcb;
	Thu, 29 Feb 2024 10:41:41 +1100 (AEDT)
Date: Thu, 29 Feb 2024 10:41:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the f2fs tree
Message-ID: <20240229104140.2927da29@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GpWvX.Cj0lAD8MvDECNps63";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GpWvX.Cj0lAD8MvDECNps63
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/f2fs/super.c

between commit:

  5fa6a97d2784 ("f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup")

from the f2fs tree and commit:

  512383ae4910 ("f2fs: port block device access to files")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/super.c
index 09ffdd554f9c,09e82624eff5..000000000000
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@@ -4206,9 -4265,9 +4206,9 @@@ static int f2fs_scan_devices(struct f2f
  			} else {
  				FDEV(i).start_blk =3D FDEV(i - 1).end_blk + 1;
  				FDEV(i).end_blk =3D FDEV(i).start_blk +
 -					(FDEV(i).total_segments <<
 -					sbi->log_blocks_per_seg) - 1;
 +						SEGS_TO_BLKS(sbi,
 +						FDEV(i).total_segments) - 1;
- 				FDEV(i).bdev_handle =3D bdev_open_by_path(
+ 				FDEV(i).bdev_file =3D bdev_file_open_by_path(
  					FDEV(i).path, mode, sbi->sb, NULL);
  			}
  		}

--Sig_/GpWvX.Cj0lAD8MvDECNps63
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXfxLQACgkQAVBC80lX
0GyAsQf/a50gfQPcayNMWMeXSkK8TVukXrl/SkmUN9s9c/Z9Ycyf+NCyNP1iOo9U
oLn7M1lksGbck7d+ZeEzQuWLSi81MHGrVD25Dogr8Pl9EXE6vnRm+/vAHxa4UXCr
pfX3wdOa2jexUXBi5CSaW+3XCa4lGIRPYOxohEVGr02j+LYzoOMwsh+5pHkWvKsf
ywlUOalFkY53px9l9+5HXAUDteDbrzdJOQzz8yfr3bMcN91q16w6yaZdNnEPdAYZ
NPHYxjxiGxNxyuk3CdR//crQocWkHW0VRurO6SS9GTMA8DY0i9l0ac5bLgmKVx5F
ZXkXosXoaZiw0bkb0T8TF5bqTb1YPg==
=5o7i
-----END PGP SIGNATURE-----

--Sig_/GpWvX.Cj0lAD8MvDECNps63--

