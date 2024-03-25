Return-Path: <linux-kernel+bounces-116370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA77889D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E673B2BC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2D67A15;
	Mon, 25 Mar 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NqP+UceA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D97146A8C;
	Mon, 25 Mar 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329909; cv=none; b=VK3WV6bwsviI/tJn8+fs2uJmJ9ky7QAhf6toz8KAOmqwJUmqMkwXhTwq16QXaArqmahEbcTAuTgaR37EALYxZDcledwqHRBCiCb6QkC7J3m3zcmY5QGSPEgj9Wg7jApy6tHh3PBZqbN2f6xQFjVQ+EeOWahDJaeAuFgnUQ0x7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329909; c=relaxed/simple;
	bh=keIIY2IUuYnvaEopcTWmMshYievXvR6LXzeGqOWYBMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O6NrScIYRG8U0Q0+dwuid+p2+v2zMIIKekTEQB6UwPA9o3Jof/3/PReOQRUgaEPFbrRFeNf/Ex5Dq1P5L8eisIOHQ3qLJVKS33DbPxEU5bgMAgryJQKcIRtTwsg51BO5sghwDtqLG8PY5p62imC5Yxk2v66/1FkwjnFWkCy4/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NqP+UceA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711329905;
	bh=k1+5E0R2OutmX+sLafgyTQpS5WVt45x2jbVIdUzu1LU=;
	h=Date:From:To:Cc:Subject:From;
	b=NqP+UceAE1jMFnGmXP5YQZt9uehCnibRLB8pYu8Ki6Zge8IVdYw/KnpNW8YlrDyHH
	 e/n7mW2u+zP4wEQ5IOJdxsttVi3cNCsPJorudjwXm2eRWAW70SFTo1Druv/PcTv0Ne
	 oN3dBQTUpWt5eP4sLl7Vo/3eokIwJdJsL3aYY16Mk1dvvXXiC0+xRY6WEMkDwhNFl+
	 6tPrc5dMWQag7uCy1x2oZhqMnpOIUX7dlxSMI+FK8JjvztArXVnhMo+R1SkS5nLxp2
	 yQRI1DE7f0g+tyjwHH9LVjYofToIfqUnvqGXJ92Pmfofi/Lk8c4sQcpk4awDYzpDEj
	 EK7vQK1qm0IOQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2wGS61fRz4wcd;
	Mon, 25 Mar 2024 12:25:04 +1100 (AEDT)
Date: Mon, 25 Mar 2024 12:25:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240325122504.6f46a5ae@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+1N7hoIm+V=s3ZXe=KBerLT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+1N7hoIm+V=s3ZXe=KBerLT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/filesystems/proc.rst:958: WARNING: Title underline too short.

allocinfo
~~~~~~~

Introduced by commit

  d08b311b6d49 ("lib: add allocation tagging support for memory allocation =
profiling")

from the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+1N7hoIm+V=s3ZXe=KBerLT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYA0nAACgkQAVBC80lX
0Gw7cAf8D8PvqlbGsW2ablwJbapHqjqYZHYd+9AuCdIE404IHkOjlFcXZ/4bEbIJ
7j5KuT2/BlawIFlGWFPXRSOQuj+lxl0RS2RTvhoZfmO6EomSMEOxClhq3w31FuwO
w0QOGySuWTFOc3cA2ABmM60aId6U9RZ6boRxwHHtuHCW7JJENVTgDJg1EnoX3J5j
SQpgm3tVO+4O9qIDFsKKLMC1LHeslJ7OGCAdY/DyhF9YKm75mVImOllsZPYVjuaY
5SAKB2n2ThTIahvIMss4j1jBNqwZD/GyNDo5MYw2qxi3TIhZTpsmaizJjBvBWPUB
1dP85YnY4a/Pz5zkilMlKjzBLTghBQ==
=NU8c
-----END PGP SIGNATURE-----

--Sig_/+1N7hoIm+V=s3ZXe=KBerLT--

