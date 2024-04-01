Return-Path: <linux-kernel+bounces-127180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BD8947C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725EB1C22054
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E85730D;
	Mon,  1 Apr 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L0/osbP6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1056B89;
	Mon,  1 Apr 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014381; cv=none; b=QZmlQwkWuIbjDvvhfIWk/5qm2C+99kZx5EXzqPe8IyJHnbYZCDHJcGNUvDzumEj8yEzfqkgLao6QDOQAINXUeHydHxyyqlxfX/6RDwjm1RW8ivw9sfvas6Ct4x3yVSDEZuv/Qc/igXOzFdxFEn04923GvdjIcRXdroxxn+DwbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014381; c=relaxed/simple;
	bh=XrT8Zc+MIc5QsRMtn3u55h8rZpt1I7g+0BByqeu8h9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Hm4GW35GSjxW8vc7mfDNoSjeKQ3qDbFNdT3vmQzEKxjZnFURsrF88aMhnF+GPLSre79GeqYXcVOrHgo/4/OsbHECmeSmXlL9b5PNc7yQsdz6YVNvbgq7RHzLfhvVtQNQvQvScqF0pxvwk2SaLkyh3LlBDRAbRi9tC4MNaxWgFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=L0/osbP6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712014375;
	bh=59mICa2IHox9XLs87Vsm5NCsqztonbzUGO+e98ooKsM=;
	h=Date:From:To:Cc:Subject:From;
	b=L0/osbP6kf4hnBKCIVy5fx3ROz2bfF01ePD6dTAVAjdLhCbFlg2sfpZhKmQR9fTY+
	 h2BEx5G94hCf7WnhNqASKpvfp/FhckbOK9zQVYvK+ozrq25YvUu10v4GJUSDHsMSv2
	 4IVF00RQdjetLsUnpBJx6IGG6nMxJ35InEeZdZKrWCNGbOQ++h64epW7P7rdsy7PDj
	 lrWL6YcTuf09bPkHLgzapSJQnUNYFdZjCJmAvrUvi5FW9FOThyLmgOxsgDKD48xXMt
	 tzPVSncRsMbtZd+MwadClGPrqAySV3z6uN6AvDCCAKzmPwwNPejQCt3Ht8EuvojUqg
	 fvrVyVS4QG/RA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7nPL6ykPz4wcn;
	Tue,  2 Apr 2024 10:32:54 +1100 (AEDT)
Date: Tue, 2 Apr 2024 10:32:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Eric Dumazet <edumazet@google.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20240402103253.3b54a1cf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4cCA5Hw1boWFJmaQY2dnncK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4cCA5Hw1boWFJmaQY2dnncK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/ip_gre.c

between commit:

  17af420545a7 ("erspan: make sure erspan_base_hdr is present in skb->head")

from the net tree and commit:

  5832c4a77d69 ("ip_tunnel: convert __be16 tunnel flags to bitmaps")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/ipv4/ip_gre.c
index 57ddcd8c62f6,3c46a7fef8db..000000000000
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@@ -276,19 -279,14 +279,19 @@@ static int erspan_rcv(struct sk_buff *s
  	iph =3D ip_hdr(skb);
  	if (is_erspan_type1(gre_hdr_len)) {
  		ver =3D 0;
- 		tunnel =3D ip_tunnel_lookup(itn, skb->dev->ifindex,
- 					  tpi->flags | TUNNEL_NO_KEY,
+ 		__set_bit(IP_TUNNEL_NO_KEY_BIT, flags);
+ 		tunnel =3D ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
  					  iph->saddr, iph->daddr, 0);
  	} else {
 +		if (unlikely(!pskb_may_pull(skb,
 +					    gre_hdr_len + sizeof(*ershdr))))
 +			return PACKET_REJECT;
 +
  		ershdr =3D (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
  		ver =3D ershdr->ver;
 +		iph =3D ip_hdr(skb);
- 		tunnel =3D ip_tunnel_lookup(itn, skb->dev->ifindex,
- 					  tpi->flags | TUNNEL_KEY,
+ 		__set_bit(IP_TUNNEL_KEY_BIT, flags);
+ 		tunnel =3D ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
  					  iph->saddr, iph->daddr, tpi->key);
  	}
 =20

--Sig_/4cCA5Hw1boWFJmaQY2dnncK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLRCUACgkQAVBC80lX
0Gx0XQf9HXhr1nHFOqTHOJ8OYptgp7GXzTXCpZoEqPBYBLQ39wLFon1ufsFDT+Yb
Vk8X6DR7Ak4TFDmt/Flzb8xdEEspsIVumLmH+RCBC8mYToM/yJyldIMD89v2fmuk
uUK6dpM6WpNKsKUBasSIRMi3Uu0jryi7DvAmmP4DunKiRfpCxNwrDbljUu6sWRKk
x7lOxJhbw/ctBE6RiNLKG27jNrHR5UtCVg2zJp8hmo3mqkC8vLBxH/sRpV8K4Xxq
uZIZIkDeEN7kahTaK4RashI4hjfg+Et1tFIrAO/oFjeOBiuA2sxgTA0BqzrNxW1V
3XOTE8xhVeDjBeLGSzkt/ZbfHDK0lA==
=5j3D
-----END PGP SIGNATURE-----

--Sig_/4cCA5Hw1boWFJmaQY2dnncK--

