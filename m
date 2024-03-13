Return-Path: <linux-kernel+bounces-100985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964A87A076
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948921C21B51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B712F35;
	Wed, 13 Mar 2024 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fdZhuLf6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8058F61;
	Wed, 13 Mar 2024 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291481; cv=none; b=ZyHY7YmPpJaukZeBzMjl6RnFPHVtncl96Fasc5n6P+QrOhaFR7lxBQ9uNpd05tdqXXQM9z6uvh5GkbcQnpE4thEIGc+6UdI+0jYkIh6zzHTosjaUM37aXa0yD/RRA75Qgl9XAz+N31f6aJoIYaTjsaxlBlUP+AicoG/VvM8SLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291481; c=relaxed/simple;
	bh=z8YYzN2gZCm6QRJjFH2HLsqFoMBdgH4m1IlqLZ7rCS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ExaF9k7SBboN2fG2znfW/1wq2WqsBB8+bUGwR9xUJttu22lAP6bGAKYw0DCAiXKC6Yo8uK+aPDUvqoPyd92xdtEjAoIXYhIK+jZSbgu3cGZWZphvtyYDcsdScQCfDGMYxcTCiPgTTEXlc9Tls3NN1TWaCFIllbLia0YmM1pidAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fdZhuLf6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710291474;
	bh=u+UT7fns9W2mUZzIbsCdXkJaDwtFBocLMd9qUaNKNK0=;
	h=Date:From:To:Cc:Subject:From;
	b=fdZhuLf6d2QbhreshmuVSnbKlEAc7xQKQeOx+pJh2KPzE7igJosoNf2BdfxJDmCgX
	 nI5TFgpq5LmGv6O37BzeKi1waEqonZJStYGSIBL9xUgC/foiVtJyledpZ0gE5+V+VR
	 WQtxVAwxppcqoEHpRZCEfyd6Ejliub7yu4URV5kD18Deq3oDVbXbfbmQSLqc1wklqv
	 Kez4kVhsmUkSLszOb70Qz1IFqzXzBacEL/aOxWZQ2FZ153qGUqWKrwZeLTNhTk5bel
	 w142D8gAzHL0KcEc/MRhtEkQut9AqC8lKZRCaFMht0Hu8vetWqfhPPylee4ACMPqSC
	 n6B0AWm4aP+MQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvXDd1g6Mz4wx5;
	Wed, 13 Mar 2024 11:57:52 +1100 (AEDT)
Date: Wed, 13 Mar 2024 11:57:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@google.com>, Barry Song <v-songbaohua@oppo.com>,
 Linux Crypto List <linux-crypto@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20240313115751.36b01158@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pEpBEmTvEMreNxq9yb47kWI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pEpBEmTvEMreNxq9yb47kWI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from mm/zswap.c:30:
include/crypto/acompress.h: In function 'acomp_is_async':
include/crypto/acompress.h:124:16: error: implicit declaration of function =
'crypto_comp_alg_common'; did you mean 'crypto_tfm_alg_name'? [-Werror=3Dim=
plicit-function-declaration]
  124 |         return crypto_comp_alg_common(tfm)->base.cra_flags &
      |                ^~~~~~~~~~~~~~~~~~~~~~
      |                crypto_tfm_alg_name
include/crypto/acompress.h:124:43: error: invalid type argument of '->' (ha=
ve 'int')
  124 |         return crypto_comp_alg_common(tfm)->base.cra_flags &
      |                                           ^~
include/crypto/acompress.h:126:1: error: control reaches end of non-void fu=
nction [-Werror=3Dreturn-type]
  126 | }
      | ^
cc1: some warnings being treated as errors

Caused by commit

  86464db929ca ("crypto: introduce: acomp_is_async to expose if comp driver=
s might sleep")

from the mm-unstable branch of the mm tree interacting with commit

  2beb81fbf0c0 ("crypto: remove CONFIG_CRYPTO_STATS")

from the crypto tree.

I have reverted these commits from the mm-unstable branch for today:

  86464db929ca ("crypto: introduce: acomp_is_async to expose if comp driver=
s might sleep")
  791f798331bc ("mm/zswap: remove the memcpy if acomp is not sleepable")

I will stop merging the -unstable parts of the mm tree from tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/pEpBEmTvEMreNxq9yb47kWI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXw+g8ACgkQAVBC80lX
0GwN1gf/Z9bhPozr10QDiOQn/NmWbZAocaJhHllkJWsK3mjoWahO4JnFhpfwqmo0
hVfizUv2KIB8cwXtNoNrJD5LwjeCRw+GjVtNqARxm89DRuj3M6XGnFal0wXj1hqu
UWGNJZHWwUchnaVr+/pEiU5FPkb2wGps236A9YIvl8Fsw45LTNr1pDs7XLOx8MhU
1xusarOJfkM/Xv2kEM8sZTC5xJ6/9HuCh5PuwRW//Hyl3RZSiRgisBfJmAmrp8Oj
3tt+AnD+7SsHlQPak8SjIZci6zrGu2dusH0bzsEC01RHJfQ7XTEzPOHlhv5y1ygc
Io4bc7vs1fJPcTFdaZPMenqe8zpxpA==
=0+3t
-----END PGP SIGNATURE-----

--Sig_/pEpBEmTvEMreNxq9yb47kWI--

