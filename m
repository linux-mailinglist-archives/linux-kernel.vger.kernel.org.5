Return-Path: <linux-kernel+bounces-82570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E905868674
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CD4287061
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2936EAEB;
	Tue, 27 Feb 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BdjqxmC+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481644C61;
	Tue, 27 Feb 2024 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998933; cv=none; b=MPevJixgwCQ8CKCDseCSNvc9XYlcPMiS+TKMCpTNDyQ0KOYDhChV/iURY+eGXuhOZRHhmjEzGvkpN7Z1zcGo6HEU48bKfcNtunsPxTp0PNGSxJ8p/B53Fo7qWJA9eqxkHrteD0tZWZeWsW9qyYNn0bx9o59nbT74HE0sDNwR0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998933; c=relaxed/simple;
	bh=BWrd9Qh+hL+ZeFRguFEk0ZiDbHwsQAQcAlomtJ8uW1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WzRm8wocgc70NJ1M739r9cUsl/AZsaqmJblExdMrkw1C63Grv1R5gkqleRCVhdIXMB81v2fNVHfk0lRK651axH6tdzNOzEZ+cpBHIwqJd7MEBPHtdw7HnmHehSijftkqqzw3FNVdWhX5ymf8lkAAixHlP3X8gKdY2hoHkUjuDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BdjqxmC+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708998923;
	bh=tqyLFCX2gqO9vfzTyThgx3dUIOjnJmNJJQN1IhNoSs4=;
	h=Date:From:To:Cc:Subject:From;
	b=BdjqxmC+yaLrov2u1aw8maOKLM5zNmQR/lOUWWi3BgXtRZYKG9J/9TLo3jxH2eE5J
	 sLYJIMHlnFfzNkQUXP9OzNM/sTNSZByErvlHWcAbZuKNqU+2ilKqLcesiTw5KsPJ5p
	 PiCFXWUhCm5/V5eQSFIc1XiC3sjxEqNQyWna6kw9jNP1DvHATxCYkZ290b2IjcIQPQ
	 bO/cncwg/ifmgH+7rB21ynVN/Kip50KxloRFmViez6uEZqZfYXKgCwnMoqa9v8XxA5
	 L8AsXIGbbXgoFrw8HwV1rtdy+yRzBcyyBswPr5n/S8IQjR09GyA2TaoFncpllY5zMU
	 HU/0+KnpTqYwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkLCv1ysqz4wb1;
	Tue, 27 Feb 2024 12:55:23 +1100 (AEDT)
Date: Tue, 27 Feb 2024 12:55:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20240227125522.2bdbe6be@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AgTXETjkATY5b=42YbiLEti";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AgTXETjkATY5b=42YbiLEti
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commit:

  5c5682b9f87a ("x86/cpu: Detect real BSP on crash kernels")

from the tip tree and commit:

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
index fd1519ee44a0,3f894fbb4916..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -1099,7 -1101,16 +1100,7 @@@
  			Disable TLBIE instruction. Currently does not work
  			with KVM, with HASH MMU, or with coherent accelerators.
 =20
- 	disable_ddw	[PPC/PSERIES]
 -	disable_cpu_apicid=3D [X86,APIC,SMP]
 -			Format: <int>
 -			The number of initial APIC ID for the
 -			corresponding CPU to be disabled at boot,
 -			mostly used for the kdump 2nd kernel to
 -			disable BSP to wake up multiple CPUs without
 -			causing system reset or hang due to sending
 -			INIT from AP to BSP.
 -
+ 	disable_ddw	[PPC/PSERIES,EARLY]
  			Disable Dynamic DMA Window support. Use this
  			to workaround buggy firmware.
 =20
@@@ -1744,18 -1749,7 +1745,18 @@@
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

--Sig_/AgTXETjkATY5b=42YbiLEti
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXdQQoACgkQAVBC80lX
0GyZywgApSoMdJxnRv2YaP4MCebjPSZuurSrO6+8ip6XpjRiGg/cK7SJdj8UdaUL
ATAJaoyf59Zn8TbqD2XmohKXKLU71g+lb/5o9dlo8wUIgxQ7Nb4a4XFSQh/N5iCn
Gk44QFk+QzGMJRaoiVst9b54nvV9iiOzd5BWjJ7wh/aznu6Tf3+UsnhAnOaJOxyg
6EfEJHNpz3LIAxwQ3Rk6ebOPjGzoDR4YNxr4JbVD0hqLd+osEFHM3L6DrJQqIU5V
Pn6H2DQrFjKi4OuQ2iFauks3M5IdR4nhkRHGzxa8RI7OPjxpBSjaMbELUt5dz6mx
3/DZlUpKr4RGmikWsO70KoX5MB2CqQ==
=a0bD
-----END PGP SIGNATURE-----

--Sig_/AgTXETjkATY5b=42YbiLEti--

