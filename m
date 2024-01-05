Return-Path: <linux-kernel+bounces-17344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3BB824BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69EE28799F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510102D611;
	Fri,  5 Jan 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TCmSXmbQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F92D601;
	Fri,  5 Jan 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704412810;
	bh=fKTT20mUaFZY3aDpSIBX+2Ae7sQrUaC79fPao4Mb0Fw=;
	h=Date:From:To:Cc:Subject:From;
	b=TCmSXmbQ7Y3+a9JsKY0i5cANtaJ7cT67pUSaPAWxiKxXX2AXU8Q/Jtb0ArC9l7r8q
	 6fuUbPawVMeksZb6SX/cdSMM0LV9DRMVwI2K22ErZPs1RnoC9mfVTi2XNYN7TgjJZM
	 r45lOjl18xgtyTKEi8vzf2c2lxDOE27HmGBYtz+qAlpy9U2yW+ZiMsoHQ57+EgnKYj
	 q7nCjBjxoMvM4AZLTMIJCKVo3/oqXY4crGyn79KhJPJabao7RT7ZApgQBWtOiv9uCL
	 nFEUlE38VJyosmKK25Iw4kU769waCsFqCYfpjkCnt/3vkY10k3Kxn4XoTKHBN84TmH
	 QVOT4PYmSXIkw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5k9P1dNMz4x1p;
	Fri,  5 Jan 2024 11:00:09 +1100 (AEDT)
Date: Fri, 5 Jan 2024 11:00:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jeffrey Layton <jlayton@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the nfsd tree with the nfsd-fixes tree
Message-ID: <20240105110007.3f932561@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4J7C/_dIb=E8/SkMhbC3zsY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4J7C/_dIb=E8/SkMhbC3zsY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfsd tree got a conflict in:

  fs/nfsd/nfsctl.c

between commit:

  76d296a82657 ("nfsd: drop the nfsd_put helper")

from the nfsd-fixes tree and commits:

  3a0b966ab40f ("SUNRPC: discard sv_refcnt, and svc_get/svc_put")
  9bf4b41b79a3 ("nfsd: rename nfsd_last_thread() to nfsd_destroy_serv()")

from the nfsd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfsd/nfsctl.c
index 87fed75808ff,cca1dd7b8c55..000000000000
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@@ -704,15 -707,12 +708,12 @@@ static ssize_t __write_ports_addfd(cha
  	if (err !=3D 0)
  		return err;
 =20
 -	err =3D svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMI=
T, cred);
 +	serv =3D nn->nfsd_serv;
 +	err =3D svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 =20
- 	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
- 		nfsd_last_thread(net);
- 	else if (err >=3D 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
- 		svc_get(serv);
 -	if (!nn->nfsd_serv->sv_nrthreads &&
 -	    list_empty(&nn->nfsd_serv->sv_permsocks))
++	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
+ 		nfsd_destroy_serv(net);
 =20
- 	svc_put(serv);
  	return err;
  }
 =20
@@@ -750,22 -748,18 +751,17 @@@ static ssize_t __write_ports_addxprt(ch
  	if (err < 0 && err !=3D -EAFNOSUPPORT)
  		goto out_close;
 =20
- 	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
- 		svc_get(serv);
-=20
- 	svc_put(serv);
  	return 0;
  out_close:
 -	xprt =3D svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
 +	xprt =3D svc_find_xprt(serv, transport, net, PF_INET, port);
  	if (xprt !=3D NULL) {
  		svc_xprt_close(xprt);
  		svc_xprt_put(xprt);
  	}
  out_err:
- 	if (!serv->sv_nrthreads && !nn->keep_active)
- 		nfsd_last_thread(net);
 -	if (!nn->nfsd_serv->sv_nrthreads &&
 -	    list_empty(&nn->nfsd_serv->sv_permsocks))
++	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
+ 		nfsd_destroy_serv(net);
 =20
- 	svc_put(serv);
  	return err;
  }
 =20

--Sig_/4J7C/_dIb=E8/SkMhbC3zsY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXRocACgkQAVBC80lX
0GxoLwf8CAznof5TpCGOMEYHE0qxsUY5kVk9I4YjG9oBj7zdEdV+qmMVWXJRH//t
PqgfRR3HtE3nGjzWvHzDpvlPtW0q2OzpHgtWPD7QRB6+qc+rv4jW7sdE7MFnXkP1
JvSzLdSaEuD/eSp3lH7u6/zSRCgE7Bu/zTPtk5Pj77Zv2BYE3jSlPoqXPznjkyor
6J8WyAMbHuhyBQiGVF8YSSgQ3FgyH+1ILK1KYG2vRtobf3XHzFhZFva+zlCLtKAr
bF8vLQRietvbjjg0F53rKs2fNHVb4sSAtG8iP9bO88hasNcQNlAUN22r0LVPbL6D
eNLLgQ2ovLPNLX+SVo4NFY5aQkALgg==
=1D7m
-----END PGP SIGNATURE-----

--Sig_/4J7C/_dIb=E8/SkMhbC3zsY--

