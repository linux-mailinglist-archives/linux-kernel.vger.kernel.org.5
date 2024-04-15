Return-Path: <linux-kernel+bounces-144504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F68A4731
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406A6B2178C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C81BC5C;
	Mon, 15 Apr 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iloX4UQs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990D1C36;
	Mon, 15 Apr 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150660; cv=none; b=MAaCk9PRsrL8EcqsrHs5M5FBA8gyV3I7m5sv5bukNM6HoqGFp7OclCOvcM7fcOIA2qMRmyxLG6d58WWtsPy7GnY1F4yhanI2eULq2OhtjV7vMw2cIGhlbammkUyV9pFsxXZ9ecrm5HZOwsfomOdOpEilWrA/zsqzwOaXf3VBh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150660; c=relaxed/simple;
	bh=2xbDomiE2fYJtnYXzFi1xEOb9zkKPcg78vF9lQ046v8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EmhPGMzQkwdrB4/my+kc7drHggrtel+l495UbkRSRwrRoW45KmlC+tEJ9z3+qMHQq811AeDvUYq2SbNDTbO6/fAupnA1s1hTi31CYRCzD6jrmHV8RESzMM2UT2FyIZpcHyLXB905bcie1Metnkqb2XrRiwPnQvQ9BXv9FVu5ZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iloX4UQs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713150654;
	bh=qSnf+d1n+OBKJUrMhpmC9CVNe7ddtIfDiIUXPowluKY=;
	h=Date:From:To:Cc:Subject:From;
	b=iloX4UQslnccIlH7yZB0igk1a4D0snDLRX0hg3aroFl5C0XJQbKbk6dkiuBi+Tfde
	 xCofm5iCSm2zTLHvge9eacGQd3M4dmbkzMT/Q2wvHR7zbzN3hXgEEeYZz/hAc/Qqh7
	 ud77vwUJqHfrKO+0u9oLBG2lO7WR2/bQPbtUMftDnXHv8VP5Qvp5Lx5VnF73l/xoa1
	 xTKltKf/D7+j/YgOdvpsJ52uHWetmNbeuWEX/zZtxVQACwCyDyJI6wjR/BXTh7Ww1A
	 G+5Nw8QWr94GuB6YynhyUF9v0gTlO8KPGjvWZljvFsksaIY5qGyroMoCrzJ+pSr2Qx
	 6tlW4a+M+8DvA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHscs5LyTz4wcb;
	Mon, 15 Apr 2024 13:10:53 +1000 (AEST)
Date: Mon, 15 Apr 2024 13:10:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Nikita Travkin <nikita@trvn.ru>,
 Simon Glass <sjg@chromium.org>
Subject: linux-next: manual merge of the drivers-x86 tree with the arm64
 tree
Message-ID: <20240415131053.10724106@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B3+yDKgiGJ4JZrgKQwZBM67";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/B3+yDKgiGJ4JZrgKQwZBM67
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  MAINTAINERS

between commit:

  7a23b027ec17 ("arm64: boot: Support Flat Image Tree")

from the arm64 tree and commit:

  363c8aea2572 ("platform: Add ARM64 platform directory")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index c62233533f1f,3fb0fa67576d..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3091,13 -3063,16 +3103,23 @@@ F:	drivers/mmc/host/sdhci-of-arasan.
  N:	zynq
  N:	xilinx
 =20
 +ARM64 FIT SUPPORT
 +M:	Simon Glass <sjg@chromium.org>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +S:	Maintained
 +F:	arch/arm64/boot/Makefile
 +F:	scripts/make_fit.py
 +
+ ARM64 PLATFORM DRIVERS
+ M:	Hans de Goede <hdegoede@redhat.com>
+ M:	Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
+ R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+ L:	platform-driver-x86@vger.kernel.org
+ S:	Maintained
+ Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
+ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drive=
rs-x86.git
+ F:	drivers/platform/arm64/
+=20
  ARM64 PORT (AARCH64 ARCHITECTURE)
  M:	Catalin Marinas <catalin.marinas@arm.com>
  M:	Will Deacon <will@kernel.org>

--Sig_/B3+yDKgiGJ4JZrgKQwZBM67
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcmr0ACgkQAVBC80lX
0GzAlgf8Cfg6Uqrf2Z+DdeyBq0Akv2mBMmwNKsx3FHAUEtiZcH2EzWx3vRRlfVMh
NlNgQXbPhoyyvFPqKorO/kxGla/PhHQ8lHWd1J0L00zXzzKhKuLz3Uck5NZKXew5
t0AdRB/rz9R1XMQgMTG305QzdutRd9LHAcmO0pWhNQaSskmgzaFlVn5E5SR+ugCx
WsSFWFjw7jj4jx6JykeLlqPzx5mR0m+drjQUNyM6yhhyQmNeupuA18aHWVYyMd4D
jLrREeypcvjdLL9KSZr73JfsR7DMUyAU7Glnza5XszM0a5ySee9AVTdCgELJ18TW
Ahw2UWXJUDY5mAUVypRKpz39pdPaiQ==
=HXo0
-----END PGP SIGNATURE-----

--Sig_/B3+yDKgiGJ4JZrgKQwZBM67--

