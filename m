Return-Path: <linux-kernel+bounces-156054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564B8AFD49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB05B22972
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28574A1A;
	Wed, 24 Apr 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C3BXl+N9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763533C5;
	Wed, 24 Apr 2024 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918293; cv=none; b=Wi3ALOtbFAefsTPFb5WvmbRlFlgxuGO6/hmJKXIg8QDhYNCMbYDEZvOYOioFLlBlP37LDM7nu5iR40p8OV93iBtnUdHPbg6eARDzQuHWRY3ROftPUP5GLHncYBm1tPIhe9EDvLtfHtcfavlO4QuG7s4kYG6BPW3bbbCpYJlJk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918293; c=relaxed/simple;
	bh=Hx3p7+3TCBQduqhIYgBl8QZ2nKm09MxHxEIEJyHdl3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WhwHXgA+a+aU0Hih0thOgC1XXvOxisoLMGGvdHksWqoptehLKHYePxV8HFazMON5uhv0fpOGtKfTA8TY6Rz/g06K1+uI1xmnLD9zXUOpCRyok6Dw4dCq1lDEyAAYK+LP+STss6RbgzSDGY44qn+4b7Et4bwFMQA885jonsj9vLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=C3BXl+N9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713918288;
	bh=U3SOtusvmd84hF84AvW6A0kWswMHfAYL7qBK/KcxP+Y=;
	h=Date:From:To:Cc:Subject:From;
	b=C3BXl+N9C/PIfSA1KIqUOAdMXffNBzCAA5ZRg4ToYtexz86N8vpq1hN7TcenywHYS
	 7LdxsRiWeMI7BfoK0cP1AokSv7Kjz47i8NESPqbadGZg2Oep49s/cwgZI/cSzoKcOs
	 5gLfn9IQq0MbIYm+dFTXAiQxHc8k/RZsaWgi0RIze5MNtyBEvVg3kzn3Us+j3ILmpG
	 T1AQVvCh3M9l9kDGT9f8TpIu7SQA9loROZEK297IZcIm6c5MwcvYFf5OYxtUQD6JaC
	 QmoTrrYTFFzO2Wc5woymj1ILT+/n+Ljc4QXbt7l7mST2s7q9k8SnvNdFlHbWMQmJIb
	 HbSqXL8xqoZiw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPKW22Rvqz4wcd;
	Wed, 24 Apr 2024 10:24:46 +1000 (AEST)
Date: Wed, 24 Apr 2024 10:24:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, Gao Xiang
 <hsiangkao@linux.alibaba.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the
 erofs-fixes tree
Message-ID: <20240424102445.53ba5ba2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N1u+FRH.WI+P0e8==UOgtKr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N1u+FRH.WI+P0e8==UOgtKr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/erofs/super.c

between commits:

  ab1bbc1735ff ("erofs: get rid of erofs_fs_context")
  569a48fed355 ("erofs: reliably distinguish block based and fscache mode")

from the erofs-fixes tree and commit:

  e4f586a41748 ("erofs: reliably distinguish block based and fscache mode")

from the vfs-brauner tree.

I fixed it up (I think - I used the former version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/N1u+FRH.WI+P0e8==UOgtKr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYoUU0ACgkQAVBC80lX
0Gzy0gf+JDT9ihmacsMjGGeyfSgZi59ayg2Rg0fouFtDJn/R2sDE3xyxpmPbtG/C
lqT8KXq3s/IIc6zvacaHL2YH28ro1tL4IiRuIxYdC7OUxzz4eCaqjNYINjng88up
4puCAFYjICOOKXJCIxg4CbaL9C27NA8XVCXuX5mECmXiD1kBUvEMEnajui7cXj1v
Mp+1ST90Qn1d4tSWfFPzdCYuk8F7AuwdJkOH3UnwUn1MlXkjGZ/rkV98bTfKqeUS
LBqdLz8865MAt7jo+eU3ajLDFl9YetkKwdfdEgNe4himfeO4VIsFxZSv1Zez7tHq
fSKA25qcu+tK/AEXcKRsHB3xmunxFQ==
=WZfC
-----END PGP SIGNATURE-----

--Sig_/N1u+FRH.WI+P0e8==UOgtKr--

