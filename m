Return-Path: <linux-kernel+bounces-13950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D482157E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C8E1F214D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5EE566;
	Mon,  1 Jan 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g/4OIVud"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942DE542;
	Mon,  1 Jan 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704146895;
	bh=JRJV7ElX1rFWpuMu0jxb+JP+5jXn4iWDgasR8SjPBR8=;
	h=Date:From:To:Cc:Subject:From;
	b=g/4OIVudulbA6rz+YktAcBt+UiCTpml1fEgJrjwfoKDRmozz+PetIukmkd46rC0qm
	 JwRN9iZe5a0jKC1vlTI0G3IfOs2T9oef0HCPahpZzrqIAWCzpp5pvfBx94opjva4dz
	 4jNeNKQrOuXwWanJZGXPZOKODuh7lttMH2oRrjbgkNnIjKEDG3RdGJaIa9VRb96UV1
	 W7yqZ8ZKXjpu/6YPlvXpYaAOARL/y1BvtB8GbZ/cRqWSlBNXmDT02Byy/ksKHEvfEg
	 Q8UP2Igab7AhVyezPmQarvJY77mxbdhG1obJQuNvityo5w7fxPvYOk7BwbNBP2WYMx
	 qx2dPGG/J1Lwg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3qqf21Xhz4wny;
	Tue,  2 Jan 2024 09:08:13 +1100 (AEDT)
Date: Tue, 2 Jan 2024 09:08:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mips tree with the mm-nonmm-stable
 tree
Message-ID: <20240102090812.4243eb88@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fZjx__JmfJNt+gu7.ewxQtS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fZjx__JmfJNt+gu7.ewxQtS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/kernel/traps.c

between commit:

  ec47b986e53e ("mips: fix tlb_init() prototype")

from the mm-nonmm-stable tree and commit:

  8e1803900ef1 ("MIPS: Remove unused shadow GPR support from vector irq set=
up")

from the mips tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/mips/kernel/traps.c
index c58c0c3c5b40,c1b2b18b0505..000000000000
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@@ -2152,11 -2120,8 +2120,6 @@@ void *set_vi_handler(int n, vi_handler_
  	return (void *)old_handler;
  }
 =20
- void *set_vi_handler(int n, vi_handler_t addr)
- {
- 	return set_vi_srs_handler(n, addr, 0);
- }
 -extern void tlb_init(void);
--
  /*
   * Timer interrupt
   */

--Sig_/fZjx__JmfJNt+gu7.ewxQtS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTN8wACgkQAVBC80lX
0Gx1CAf+IR1LIlgHlyn3zRBuAeco8OLQE0QwpSBPVlyvKJhYUBbME2bUN4xUqzy7
xY5+sIVIfDuRo1z5I9+bDAlADEF+F5S0B5hcR+b3QyIOTEdoO9ZxWSorIABmpiQI
Sg+zTEXPh+6YXx2Joymv0cQfHZFKSAv7TXbzPc+fv9amdtmBpFYXkyT5R2rd1I81
y4qSPjrfuS/adFVr3shMbzgFakqxophk4MdqID/g39XWUWt0RP4eZulFw3KbWZ9v
p3afnJrzoU6q/pDIC6KHTdTQvqpoDLt2TtKUkt7Y7qhMkv02F7kX8u5oRXUcnprk
vg1pcJJ3lh8ZiWNhbj27nwODgRGq7A==
=p0Ql
-----END PGP SIGNATURE-----

--Sig_/fZjx__JmfJNt+gu7.ewxQtS--

