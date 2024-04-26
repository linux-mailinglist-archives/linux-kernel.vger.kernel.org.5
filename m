Return-Path: <linux-kernel+bounces-159512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC58B2F95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4641C22C73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20D13A260;
	Fri, 26 Apr 2024 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y0P6pXk9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6013A253;
	Fri, 26 Apr 2024 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107346; cv=none; b=rhT6G/0JrlvK/Rvc4yxMpUe7aTq767yF7PctUT0Y2T4TWi1byHAwI86ZFljIKTAvJ0kvdeqYYICocJYXx+2uTN5BhnjZ+Ww7NNi0rjioItOwPc1oh0SFFlgvxw39IEYwCkZm1RRhUXjPs9YsssOnavfD1SiJJc3SmyQKyVDWlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107346; c=relaxed/simple;
	bh=slhSmPP6A5dL+xFrf9Y3kg/yEYoJ1PgK9pg7XuwiRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ikhjNR+AtZ87O97GjC6SDSIanLXEpxaNwM092su94CuwVsY9I9V2ngq8wS3oFJt0n4KwwAR3QrFm6+5Gsc1dKlJgo+l1k0FHgTAVU/2O7bf1xtszXD57eUvPHQmGWPw0INus1AH+fHCzPMYg9JtXlli1DTJC6DY0euumKOhF9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Y0P6pXk9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714107342;
	bh=ZgfufWsYb1pKRnL2FziEaT74IVGiiNsUZRHPd8i0rGE=;
	h=Date:From:To:Cc:Subject:From;
	b=Y0P6pXk93TvLe9+Av9u/BOSgbUd8PFzpHvAZ9vuOkax5WrsX3NdZKoIbQZX4jWyV4
	 VInnc+H1+eu9T6lDU2IjdcBRR62R+zzg0sSAURtEHy5AuEvebd1Mc54bATCZrhSvES
	 bPcqc+B3bEU2ZiNdlUe27wxNf+8dmK164tj/8VN6JKiJQb78bj+WMTYpA9FAR8KOaO
	 MlrXZmQV1QTI58QKQnmdtjWZqtYFaJGuZzDUt3WVoILc8S7dao3Et5yFvomd4J8Muz
	 N+iRMPvAcUDmTzAADzrF2kIGFFfdMWGiKBvTjOyMt7UnjOuHJmD1dzjrRzapJ2wuw5
	 ZyB11Wha1/sDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQgQj3ghSz4wcd;
	Fri, 26 Apr 2024 14:55:41 +1000 (AEST)
Date: Fri, 26 Apr 2024 14:55:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the mm tree
Message-ID: <20240426145540.1593f8f4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5ixbUIkBKNp7xwV06/Sd0+1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5ixbUIkBKNp7xwV06/Sd0+1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got conflicts in:

  include/linux/kfifo.h
  lib/kfifo.c

between commit:

  a8372870a0ae ("kfifo: don't use "proxy" headers")

from the mm-nonmm-unstable branch of the mm tree and commit:

  d52b761e4b1a ("kfifo: add kfifo_dma_out_prepare_mapped()")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/kfifo.h
index 6b28d642f332,d613748de7ff..000000000000
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@@ -36,15 -36,11 +36,16 @@@
   * to lock the reader.
   */
 =20
 +#include <linux/array_size.h>
+ #include <linux/dma-mapping.h>
 -#include <linux/kernel.h>
  #include <linux/spinlock.h>
  #include <linux/stddef.h>
 -#include <linux/scatterlist.h>
 +#include <linux/types.h>
 +
 +#include <asm/barrier.h>
 +#include <asm/errno.h>
 +
 +struct scatterlist;
 =20
  struct __kfifo {
  	unsigned int	in;
diff --cc lib/kfifo.c
index 15acdee4a8f3,75ce9225548a..000000000000
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@@ -5,13 -5,14 +5,14 @@@
   * Copyright (C) 2009/2010 Stefani Seibold <stefani@seibold.net>
   */
 =20
 -#include <linux/kernel.h>
+ #include <linux/dma-mapping.h>
 -#include <linux/export.h>
 -#include <linux/slab.h>
  #include <linux/err.h>
 -#include <linux/log2.h>
 -#include <linux/uaccess.h>
 +#include <linux/export.h>
  #include <linux/kfifo.h>
 +#include <linux/log2.h>
 +#include <linux/scatterlist.h>
 +#include <linux/slab.h>
 +#include <linux/uaccess.h>
 =20
  /*
   * internal helper to calculate the unused elements in a fifo

--Sig_/5ixbUIkBKNp7xwV06/Sd0+1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrM8wACgkQAVBC80lX
0Gy9NAgApMpBJj/Cf+zFbey4dg/jd06Lu9A8Yx/rgjmDGql3CrAgwxdIdj5x9Reo
HJ3YEDqf4NcMxt9F4OyZo0qa/K69/0Fy2sfosNWEtZbhHTruU7shWTOOJwDUniDk
KF83Y8xaC/W2tF3IvGQREdnqjmCIdpbnD+RSgcbfXpxobxyWdgaHNE0XRkun7dWC
bY206eoKUBfKoZ7vQRq9o2lkbPH6zJV43ZClm4DCK3WSUFp6v3N68yQybuLpMxg+
mxjNG1UwIyVf3xcxbv1dqqez0lZMRISRf+7pduLDtKRU4tWwGhuVY4i03Ha84X3Q
i56VNAGEAk3kHC6b5rHMr5Ub3/6n0g==
=W0Pj
-----END PGP SIGNATURE-----

--Sig_/5ixbUIkBKNp7xwV06/Sd0+1--

