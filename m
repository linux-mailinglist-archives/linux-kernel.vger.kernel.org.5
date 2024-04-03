Return-Path: <linux-kernel+bounces-130710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7A897BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9491C2224B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C0156979;
	Wed,  3 Apr 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VmHgH3jw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D15156242;
	Wed,  3 Apr 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185844; cv=none; b=tHup5OE0+cTbM02dtmsRh3rGS7ZLd0i1z+gHz7VKv6ioggTZK4vFa1+O+DV2Myb423faYP7Yv9U44RG88gO2lwSDtwF8ceTij4NQsojlrR0oPSfxY9NOUf8se3bPgpktESGow31y42E36Y35iIJST6DMOXvdJtyRF7/BF+Kndr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185844; c=relaxed/simple;
	bh=1I+HTpvXfWtLfZM1gjU0dplOuRDyxFkAd+/Ve5XDssg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gv/LqCJiLR2L1ic5HP1/DultH967Fgj7HMEwCrEz/+mj/INcVCpv/gJfWyeCcQxP8hPky1lFnhhRnYnpPtyl5emiSM8ZszLcfKUX1hCOu3uo5f3mk5vyp6IOnkM3cmwwFX1/w+jv7nU/JbD6O6KqZx6SPpIxuY+wexa7d5rDS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VmHgH3jw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712185840;
	bh=Pw0D8m4HIoLYHCCmuhM3473u0QPNsLozboMFXtkMvk4=;
	h=Date:From:To:Cc:Subject:From;
	b=VmHgH3jw54d6SZqX4oDuK3NAX5iADMTiUF3a20yCqopxCdOt3+ooLpcgVmnSTRXeN
	 HDu5j9+raEO13Tf+JCk/oBNXfE+xwnM0at8IYMacWnLRzxGIxMi1esxoU8TqsUbZpp
	 Wre7hmeZ3wrHhJat0RiV1Zb5Ceu/oC/A//iao+pF1bf5yCe1ZfRgWJ3anMkhA94RP+
	 dxD255915C8NN3nfhz1sSCsgpN3sYaezpOa/b4yAqzQ43sYFY6w7VLUJP8+2j4EmGr
	 CBlWnPydyYHGRuTnjSgwpCSxUw0SK3U3aiqCXhjiOnq/t7gTnzI3nJAxcmTTQ1ic54
	 o8cm+OIn0rL1w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V90pk4zptz4wcQ;
	Thu,  4 Apr 2024 10:10:38 +1100 (AEDT)
Date: Thu, 4 Apr 2024 10:10:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20240404101038.11486a24@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tQE5pCoJAP_pNRB//fc1v1=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tQE5pCoJAP_pNRB//fc1v1=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm and v9fs trees as different
commits (but the same patches):

  0e74485c814a ("nilfs2: fix out-of-range warning")
  528aa74c091d ("9p: Clean up a kdoc warning.")

These are commit

  93df85cc09a2 ("nilfs2: fix out-of-range warning")

from the mm-non-mm-unstable branch of the mm tree and commit

  7013482ff594 ("9p/trans_fd: remove Excess kernel-doc comment")

from the v9fs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/tQE5pCoJAP_pNRB//fc1v1=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYN4e4ACgkQAVBC80lX
0GyF0ggAmqlnEBXPrUzXqg7HuaFYGJYdRPgJLnf+85XpVX6Jc3vQUWhKcN6M1NRO
NvyB9rKVTQ1q3fNMbKegd8us7RvqYkjUGCriey2IG6/czD4+6AzZWKvGGLVz5rGM
Zi5y/pXWM6DyqBBlk6A8oSFlunjvlvze8PX5TPMxhn872JX5evkyzs58DOLTDXVy
yogm5rqZ5m4avtSCeIfuSB9/AMWSX1RXCZEKq94PLpmS0yx0cYtgWkIgT4E67Z+s
9aeJP+eoISsZGU745jSrEgtuYxWNCrxBrg89/yag3XozIFpKQOSrwz0jeNMfPu6+
qDa2V09JzB+fhVLmm43zVuGNUy8Uaw==
=ibaD
-----END PGP SIGNATURE-----

--Sig_/tQE5pCoJAP_pNRB//fc1v1=--

