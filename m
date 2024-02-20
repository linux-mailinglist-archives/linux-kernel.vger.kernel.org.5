Return-Path: <linux-kernel+bounces-73756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8585CA91
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115A31C21B82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71669152E10;
	Tue, 20 Feb 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VXpgYBhe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD967C72;
	Tue, 20 Feb 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467425; cv=none; b=uAXzXMbmXNGpzoohucBvc0Wwl6zFgtIqfhCPn/O+HOanoxaxbdi5ysgQiE/EbZ5yVZaV//n7jjFBB05xTinVtBeTkGMsG7Nv1ds8PIIfsT0wOCEQD2H3L9f1cmr87KQbviyeFqgIhfpUKWR98UebkmFk7PTPKalROoE8E4TNGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467425; c=relaxed/simple;
	bh=YkjJomkwAbyilvCZ+dd7xJ2p1jNCwzNzJDmAAUwoVU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ADmkmiC8N5ITqnCFhN4N8UU+Hrui0/1VcioIQ0aDECcmxNYspy3Os7d/LesFiV5lv7oK/3A/WHOCAa6YalFoZOnRW83gvuP1zfX6lcDaikbe9p8Uj0uW8DZyWWKo0jhUOwBVwPRDrSh5DrxQSnUhKc6V+XZC+lzb+bgw7hHyK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VXpgYBhe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708467418;
	bh=MSV4s90BpjRSKLoKbRaEbAIXDqzjjF4XClQSmwPKAR8=;
	h=Date:From:To:Cc:Subject:From;
	b=VXpgYBhex2o2FnruV5bneTXRDInXqsX0RLCJuVpDR9YO67fmd7AKV90HiL/og5cKU
	 FCo4HACr4asFYWJVplLipquo1iAClskjE3fRx/NxUB5M4nnJxvOKSn8XnXQRXqZMFh
	 vDVWzsyUK3MP2a0uLNWiwWS63N6g8tb/7cjud11rm5XvxyLYoL6CjxEp6UHxsy+O/c
	 izSGW3+GjjkY+3f0h/E7dZTZKv5NsU3FRSKpDP/c2HcgRaOLeOIc8vg6OwOZ7ib7X7
	 9JJRvJAtzXrRB1pD7ikpLd0pdLFRXNqcziqFpkWp5FK/d1KNlBnsHOvEM98tKrh6tI
	 K3oCDWEcEYbag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfYfd74Bsz4wcC;
	Wed, 21 Feb 2024 09:16:57 +1100 (AEDT)
Date: Wed, 21 Feb 2024 09:16:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Matthew Auld <matthew.auld@intel.com>
Subject: linux-next: manual merge of the drm-misc-fixes tree with Linus'
 tree
Message-ID: <20240221091655.2937adbd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F8R60ml85Z6nr7dU8JqHvdy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F8R60ml85Z6nr7dU8JqHvdy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc-fixes tree got a conflict in:

  drivers/gpu/drm/tests/drm_buddy_test.c

between commit:

  fca7526b7d89 ("drm/tests/drm_buddy: fix build failure on 32-bit targets")

from Linus' tree and commit:

  335126937753 ("drm/tests/drm_buddy: fix 32b build")

from the drm-misc-fixes tree.

I fixed it up (I just used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/F8R60ml85Z6nr7dU8JqHvdy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVJNcACgkQAVBC80lX
0Gysqwf/ef0qLJRLq8wnSElTxLDdQIYFArrCQI+ln5O8MTFlwqGAjuoxb1t8o0Zr
E9WcMGK5hNHzyhTt5cshF0sjU3MlV9FkPosxitExE6qOT8IwlIsBykFP/7KgjX+Q
GPp/vqWBGLbm2R4w0LvwTGWfKZFZ3Ht84bsND4w1CMr69TW3ors5sMBDcT7MIYQZ
7V8rr4dScDRI3m7Dyv4za7dRBBnd4DxWzIZ5Mt3YEMVYiKVh34JJMW5fqQfF+UAf
BzX1IY90r9EPyiHB6kD66KYAILOPQ3o0j4V10d0LE0UuViowWfNJqPtgqJeTRCiy
ik3IwvL2ymLi9/rwVfUu6thvlobtEA==
=VuOE
-----END PGP SIGNATURE-----

--Sig_/F8R60ml85Z6nr7dU8JqHvdy--

