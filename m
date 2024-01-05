Return-Path: <linux-kernel+bounces-17360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86B824C43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDCB1C21EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B181FA3;
	Fri,  5 Jan 2024 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lKJ0KuPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B523A6;
	Fri,  5 Jan 2024 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704416111;
	bh=8TrWvylCAPZ2BiUDABrg29fW1pEG9DML2Obb3DxuN1o=;
	h=Date:From:To:Cc:Subject:From;
	b=lKJ0KuPoPuQMvyN0atkOY5V2TOfP4L2rdbKErPIs3elna1teRJC+PaCnV9J2wO8/P
	 mTeZbY9Md4x8Ys0I9mcjeD0g3GmEGqOf4Ka2JK2I6xK1JG9emCt2GYErmaqh+PdaEz
	 +Ex+fXTj/Mk8t8Vzs+ofSduKQ+F/aVNZ8ymNEtNGf83qBHLr0Gp+HFqY/w1PbXdJTV
	 zsWfCULSdwL4qD0D03OsoNJQ89y/zwbb5W6IoQ9GbU2GldnFVveVP9mYdeuEfkQjxw
	 l37fZLAFRhXhYi1GQqfGi+LxTl1sLF2U+SYMO8ovZb+G+7ne/YajNuhb2vDyg6zihM
	 izscRmY0HpaMQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5lNt58sQz4x1x;
	Fri,  5 Jan 2024 11:55:10 +1100 (AEDT)
Date: Fri, 5 Jan 2024 11:55:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Chan <michael.chan@broadcom.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20240105115509.225aa8a2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rt2RrppPJEEeCHLheu3xs91";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rt2RrppPJEEeCHLheu3xs91
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/broadcom/bnxt/bnxt.c

between commit:

  e009b2efb7a8 ("bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters=
()")

from the net tree and commit:

  0f2b21477988 ("bnxt_en: Fix compile error without CONFIG_RFS_ACCEL")

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

diff --cc drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e1f1e646cf48,8f10ab4d4a43..000000000000
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@@ -13081,30 -14088,18 +14090,16 @@@ static void bnxt_cfg_ntp_filters(struc
  				if (rc)
  					del =3D true;
  				else
- 					set_bit(BNXT_FLTR_VALID, &fltr->state);
+ 					set_bit(BNXT_FLTR_VALID, &fltr->base.state);
  			}
 =20
- 			if (del) {
- 				spin_lock_bh(&bp->ntp_fltr_lock);
- 				hlist_del_rcu(&fltr->hash);
- 				bp->ntp_fltr_count--;
- 				spin_unlock_bh(&bp->ntp_fltr_lock);
- 				synchronize_rcu();
- 				clear_bit(fltr->sw_id, bp->ntp_fltr_bmap);
- 				kfree(fltr);
- 			}
+ 			if (del)
+ 				bnxt_del_ntp_filter(bp, fltr);
  		}
  	}
 -	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))
 -		netdev_info(bp->dev, "Receive PF driver unload event!\n");
+ #endif
  }
 =20
- #else
-=20
- static void bnxt_cfg_ntp_filters(struct bnxt *bp)
- {
- }
-=20
- #endif /* CONFIG_RFS_ACCEL */
-=20
  static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned i=
nt table,
  				    unsigned int entry, struct udp_tunnel_info *ti)
  {

--Sig_/rt2RrppPJEEeCHLheu3xs91
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXU20ACgkQAVBC80lX
0Gwg/Qf9GX4MQ+uLcAc+deNFVMi7ZVCclDpzYzXt8kGQN10cSdXeLVRvozjzWIfT
ZU+SULmostQaubrPXSlb/7tyAsU/+sRkvUe3+z1llmaWdPaaHuCzaoi6BBuuTWYh
tq3s/osd+e/82/DG5tM54NBvuLH0sCsUttlyNNue7MsbGIcPyTljtTTp8yPltc23
mOmBZKjjXIBhN33vUN5ZswsduE2P4Gj8elSm2UbD7cObPXi/5BhLLYxtQdo/9ug0
e4K8HE4dXUY/kXvYhETE0q/ECn7ismKt4lQKme6L6oAY+cb7vMC2s5mde5QQxfSo
a5tJVGGrgzxQQ/dFop1Ey2hVjcrvrA==
=4a2U
-----END PGP SIGNATURE-----

--Sig_/rt2RrppPJEEeCHLheu3xs91--

