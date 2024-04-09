Return-Path: <linux-kernel+bounces-137681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34F89E5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB78D282C52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F466158DBB;
	Tue,  9 Apr 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n2dljnVZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC996158D9B;
	Tue,  9 Apr 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703913; cv=none; b=mdXy/buMTb7NLJ4CtaXezRKmfUpfIrwv/CLTe1kOVSNzQXdJRT7d5OEdg1kFxSiIIjFjUWK0g7YvgbddxhTI+v+ncACLqDtxiM8DNPSsR2oJZ0zqWmZBK2+3Gw5bzeKly8NeL0U5xEXTPznzL0vRjz9Hyg3bpQQlaOirSblYoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703913; c=relaxed/simple;
	bh=6zF5YooyCsfpmE0BWmrEU0IfZ+u+69VzuF8AtWFfHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ONdORhUG8IOX4w+hqLYZTZDV0byFW/gMdFAc88gxqTlidTAggcD8pswXXdGKYvw1dLn9qW/aONIuU5+Mm6uJcslSyFJRU5GD8fyj+/jYARvpImsvM7KaLYcMCe/QdWo13QTneW/cDZBtB/9sD+7CFgg8E9aEM1mHmNVXOATZwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=n2dljnVZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712703902;
	bh=m4aSe3eXvdJ364oYuaB9qdyFtcfbMXUheiXw1fUAsao=;
	h=Date:From:To:Cc:Subject:From;
	b=n2dljnVZpPsB3lGuTlRECWPt3eg2LFOiqR5GIrb4TWxLSxXtauICVQjNiyXlcIrzU
	 F822Ws7C+2g4IRibYegwtDjHCUygddf/Dx9ugkKkzKZh09PAf4oMN6X1BMSewOGLea
	 v10hMTnQ68y4Xna4pM6OUatJi4QYWfw0VJkh4EkwMl3u9YbokVIWpG8yYl5vw1PGde
	 MFJLJN0abj/fHzP3DcW3QUxU5V9nxu1OY2/Tv6WVl0UZ1WtV1PPB0TUlg9F7YQQS+G
	 2W2ThuAeWOLtysJVwDXOGUbHVmwG1rhPmdOfgw29ui2BO/najHMvcNmB/tPXCEYoD/
	 6a6UtDI0ywLDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDhPT723Vz4wc5;
	Wed, 10 Apr 2024 09:05:01 +1000 (AEST)
Date: Wed, 10 Apr 2024 09:05:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the usb.current tree
Message-ID: <20240410090500.4018b9a0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PD4=+Su.GmnavOII5I9PHSi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/PD4=+Su.GmnavOII5I9PHSi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the net tree as a different commit
(but the same patch):

  fbdd90334a62 ("MAINTAINERS: Drop Li Yang as their email address stopped w=
orking")

This is commit

  eaac25d026a1 ("MAINTAINERS: Drop Li Yang as their email address stopped w=
orking")

in the net tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/PD4=+Su.GmnavOII5I9PHSi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYVyZwACgkQAVBC80lX
0GyA8AgAozQu1zovR4LIvcLiO4YXYKoMRXk2sDIh+OHD4atSqQS9li4uEV4PG+D/
hhKkpZazyJE4EQy2OMBBIOCZ6zqrE2pU2AuofukuJnMELF94frg3kfqc5PrC1dU7
zwIsqGOkvGnGBpfGQl/IYQnHxoICETqgWcUvUm00qP+o0XX2YJugmVWOUMrkV+sn
Ov+jA0DGLZR5jOILTlifjxisAaSc72yOBzJ3HPbeGB5b0+Vjd4q7QxJ+zY6tnKkL
+rdsJOSBEDR7IldC2ImXTHlhw00isWD0OA9x3OYu2Hbj9jNEM0JV/GVlxIR52EfF
y3+qnxD1KS7mkiOC+g4yI1YuPGFjGQ==
=vvpf
-----END PGP SIGNATURE-----

--Sig_/PD4=+Su.GmnavOII5I9PHSi--

