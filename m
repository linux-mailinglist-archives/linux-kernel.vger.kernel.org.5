Return-Path: <linux-kernel+bounces-55902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C157884C334
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EBB284055
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364510A08;
	Wed,  7 Feb 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T5iId62f"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512510940;
	Wed,  7 Feb 2024 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277261; cv=none; b=QlovSppfm7TSL/ms8zNAGvoDkWDuHRqIle/w7azJgLJP4areudPdW6CRxfQMojBuE216uHsKE37ijxVaW7IKAVRCpVs+r9cmCOl8WlxCcoV8gF7ODCmP2IhH02vlVO+k6GgZ7vszX8kVIxHWmKdCMpRtPZXerSTOxGIgJIwnkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277261; c=relaxed/simple;
	bh=LxANWH1vYw6dX5u5kdpD6briQQ/+vl5yKirDmVoDrTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=abtzxg7sLeCl0IeXw8UMr07/sQItOye0BACro8MSBOlpJToOykAF6t+bt7l7d6XmdIrEyNAJKfvFau8rVJEe5lzbK1kDvFmbZMMqKHMOoTLOTq8McY4XRygOJLdRwve9/6pKf4uLF5/A3kOuG7D/PWfeb6dridgvH3WyANcfanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=T5iId62f; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707277255;
	bh=Qhl9kvhzen4AmOWDzyusKX6ZmfZojpYJrrISVsS44IY=;
	h=Date:From:To:Cc:Subject:From;
	b=T5iId62fKtASAwGo8WF7Cmv8j8bF4l2Xw5yEWxvcKNPd+AlqnmGklaOaLTSeZM6aE
	 xXdwNveYOQzXMRq6O9KTzCtlLtsdym5/MbLmcpWwryJhEm3cWBdoP3hzmD2nlmnSp+
	 iUR7qYs9dedSG02ULzmzH7kzDXHEiYlH8mD4uNtuwWJEu2zKP/Rh2tZDc840/hFEnd
	 CzasDVWOFPva1R3UHhJRw/N/m355CApyf2kqNBjiQIxSFCDorRhZQRExQvRkgRNity
	 T9+u7dZcWY3Pdg6zK/akup+l9S5rSlhDi4h+kN+3Uc4G67gZ4hcdJOmqELoLFtVWjI
	 5DI0TZKlcMKrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV5Vt5Bq7z4wb0;
	Wed,  7 Feb 2024 14:40:54 +1100 (AEDT)
Date: Wed, 7 Feb 2024 14:40:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Hongyu Jin <hongyu.jin@unisoc.com>, "J. corwin Coburn"
 <corwin@hurlbutnet.net>, John Wiele <jwiele@redhat.com>, Matthew Sakai
 <msakai@redhat.com>, Michael Sclafani <vdo-devel@redhat.com>, Thomas
 Jaskiewicz <tom@jaskiewicz.us>, Yibin Ding <yibin.ding@unisoc.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20240207144053.1285b3e2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ockraJ+9.X3g.iZe0NhrfV.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ockraJ+9.X3g.iZe0NhrfV.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/md/dm-vdo/io-factory.c: In function 'read_ahead':
drivers/md/dm-vdo/io-factory.c:118:17: error: too few arguments to function=
 'dm_bufio_prefetch'
  118 |                 dm_bufio_prefetch(reader->client, block_number, rea=
d_ahead);
      |                 ^~~~~~~~~~~~~~~~~
In file included from drivers/md/dm-vdo/io-factory.h:9,
                 from drivers/md/dm-vdo/io-factory.c:6:
include/linux/dm-bufio.h:86:6: note: declared here
   86 | void dm_bufio_prefetch(struct dm_bufio_client *c,
      |      ^~~~~~~~~~~~~~~~~
drivers/md/dm-vdo/io-factory.c: In function 'position_reader':
drivers/md/dm-vdo/io-factory.c:182:24: error: too few arguments to function=
 'dm_bufio_read'
  182 |                 data =3D dm_bufio_read(reader->client, block_number=
, &buffer);
      |                        ^~~~~~~~~~~~~
include/linux/dm-bufio.h:64:7: note: declared here
   64 | void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
      |       ^~~~~~~~~~~~~

Caused by commit

  82da73bac1ee ("dm vdo: add deduplication index storage interface")

interacting with commit

  3be93545346e ("dm bufio: Support IO priority")

I have used the device-mapper tree from next-20240206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ockraJ+9.X3g.iZe0NhrfV.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXC+8UACgkQAVBC80lX
0GyE6Af9G3vxUowmQfD72icXaP4q1hZbiuTAVfxmav3iu1bwQsjIt/lLZu3/uwyP
JDFTqCwhmC/i8nb+if8iX/7DLSZNLdTOLQymSjaQWvwqr8kBgjcz6aFeVjp5yO+N
IzRNT68TXszvy6BREleZCjZ2DK4DEYES3EbxUBHD9UJQwYDFCiKPaP12cqgTUUld
f2YVdkcf73lhGrMaNOZFLK/kdM4UglsXJaapFpfvjDJWTtqe5aV+MNR7Ln+V7cjm
3vIByNYRw9S0tjPrxzn+sDlvishTLumaEsogPsFjGhyAuqYzzXQy754Jw2wzD5fM
8++mV3pIBpzyk4XAQZOg1le6zJhqjg==
=WV7u
-----END PGP SIGNATURE-----

--Sig_/ockraJ+9.X3g.iZe0NhrfV.--

