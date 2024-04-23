Return-Path: <linux-kernel+bounces-154514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85EE8ADD01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F5E1C21B16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FEC20328;
	Tue, 23 Apr 2024 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oubPctsr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1D1C2AD;
	Tue, 23 Apr 2024 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848397; cv=none; b=vA4sg/02XEExtmUZjVfLb6exqRPeIMfBKApYchcps2328s0C8jPzpC1Ejnvx/r84taT8aza7oAqLWL5vaJGy89WapJBtvBfc/t4uzd96b90hGtBA7FWxI4vmNz2S+CRB1RhQJsw7Yt33nnyAV48eutgvgJvJjJJ5CiLO7OOjViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848397; c=relaxed/simple;
	bh=7jJWUwl43UaD/hIQsTXYJbvkxYmDGotowJp1+7Ux1n4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BK8+hP0RUSfv7VoXZmyWxKRxixXKJg57Dis3OXamABd9UvqxZLirAGTzHZ0F7PHXJOYq5cJZvja6OzMTaRTaAgPw2VqerYcWvx3IkccT6yHfNFE8bwvu1dgyiE+Qi+zq+92sfDsJGIIa0v3t10q7bjG2P3CzfkOkpfii8UdZdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oubPctsr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713848389;
	bh=BHtfamlsUXKbZJ/+GFWP2iJMX/S6L6L4JZ7x8U/w8hY=;
	h=Date:From:To:Cc:Subject:From;
	b=oubPctsriA8mVPolEPm2FdXwVgKvebTuF+v2A6DNa0h5jJ292NRQOcUOp239KMEPJ
	 Y1n5vXiCYUnpi0GsGCcnU7/SxTaTaBi+Q6ZldSF9AMKbgI1oC0Rm225FwHhqyIBPcw
	 1pTNDDH8ciW6J8vvA6Z3JwmMVQ0xmXhFkPDljEkamXni8vA5sDcsmb/4DB1CnB7kuC
	 j62gAHJ2pm7VfvQztIs38Mu9mhqgJQH29Ud4jvIW0D/7ngR0N5dFH7HRf0jzIKuq4l
	 Wz53bKxdDxgp85irZV6/J88iOqyiVOftIb153/KHXPDFvPU2AQbcQax0GTGKZZ4Fef
	 y+EquiYId94wg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNqfs1Chlz4wcC;
	Tue, 23 Apr 2024 14:59:48 +1000 (AEST)
Date: Tue, 23 Apr 2024 14:59:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the vhost tree with the mm tree
Message-ID: <20240423145947.142171f6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gw+FJAQxC/QjwB9ySYibKD.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gw+FJAQxC/QjwB9ySYibKD.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/virtio/virtio_mem.c

between commit:

  c22e503ced5b ("fix missing vmalloc.h includes")

from the mm-unstable branch of the mm tree and commit:

  4ba509048975 ("virtio-mem: support suspend+resume")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/virtio/virtio_mem.c
index e8355f55a8f7,6d4dfbc53a66..000000000000
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@@ -21,7 -21,7 +21,8 @@@
  #include <linux/bitmap.h>
  #include <linux/lockdep.h>
  #include <linux/log2.h>
 +#include <linux/vmalloc.h>
+ #include <linux/suspend.h>
 =20
  #include <acpi/acpi_numa.h>
 =20

--Sig_/gw+FJAQxC/QjwB9ySYibKD.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYnQEMACgkQAVBC80lX
0Gx7Zgf6A+7fSdSlZ2oaudv5lV+rR5Qk41xtA6uESL9Ubx3w/yvptWR24avAW7Rh
DABRUi0XJFnNzr2/gZO1M3xzZEH8tO4OG540PFU83xu3p26/31dfkr7AhIDrIS/s
DplqESSgMe3/yWC8kLfDZSSr4CDnt6qOGy8xzNQqW97X0e94VD5ZjfHOC9gt4nOU
Ghr4OlQCL81ggDWsclviediGMcjbAYagTGIIHZQUG7ZEr+4iMwf5/3ZLopcuCmMP
6iK+LLC39GL6dn/7kDhlUB8blkYM2Ns8pqrAQizlEHMgMdvcUaRsGpdKTSU4Ckmn
ImM6Dqtj7zWcDg8nNpPAtMjk2sVQNA==
=XLid
-----END PGP SIGNATURE-----

--Sig_/gw+FJAQxC/QjwB9ySYibKD.--

