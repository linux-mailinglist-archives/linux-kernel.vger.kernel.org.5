Return-Path: <linux-kernel+bounces-132223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD768991A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A489D281CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90156138499;
	Thu,  4 Apr 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oqNl4EF3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E7130A7F;
	Thu,  4 Apr 2024 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271228; cv=none; b=iM/fJAqfPMTrUspl2rmV165KwmERQrxm6178AjWQSLKS00HOBjYp4x29RmwyEBBPo+Wavuludm4NrrwAgBE3TDodE/1OPMNGKLuHhNBPhsxllpMwxNFqCWs6Iey9CUM0Nu49vjOXB/ikEqw13ePh6Gprm8rD8Rl7bsOfEBvb2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271228; c=relaxed/simple;
	bh=lB7VIc1UDgy5beP3ZaV6Pge777JUNcbKW1396NoRPa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lBNZfi9iw6MDO8rPKbJpPW8XFjjdSJD99CoCe6gDtJW3kXym8XG/f4UhW9MZAjsxDak+7UiXh9LOA+nDblXvac5v6bgr+0I9CzqVQsxWv6dQpI+DXZMqn/6GsRtjZITDCF/nd5Ux/iUAcNo7c3GcikI3/39BJT8u9tMw1K3ttVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oqNl4EF3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712271224;
	bh=zaN6z3Nqzi65xDY40DZ/y/txzO2mV7dLJS1hPkYB6Ko=;
	h=Date:From:To:Cc:Subject:From;
	b=oqNl4EF30KMp+eULWFdwvwoIXG++75XldIMmlvEriK/H4GqvsAxzXCBF47At/wqkV
	 9UKg9SZ4g98ZCUS26y1ZkvhH9lB/2dVMyFpM8SqtT0J24GhZ6nmPoeT7QkhLOMwzqM
	 +dhM9LbbWOG51bYLhwAj1Zf0VVdSw0jHh6TyCwg3W/+Q4hHY3pnKPk/RdHrw1M9ugH
	 JdQthVSQvGEYv0fsO7uuQmPc3KDFQG7QvfXYjMjq5OMdULlJv5PUMx2gYw/6XgJG0I
	 25MMu6SRRRORcwyYPCSmHafXdSvN8d4TUqKW6eDifZ+we4gYZPyHqID/rAKwMUeoWp
	 JJfWuEcfAyq9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9cNl2TR9z4wyl;
	Fri,  5 Apr 2024 09:53:43 +1100 (AEDT)
Date: Fri, 5 Apr 2024 09:53:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trondmy@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nfs tree
Message-ID: <20240405095341.3a9f0d95@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8n7krLoyLB2GWSTEmJ.3RDV";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8n7krLoyLB2GWSTEmJ.3RDV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nfs tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

fs/nfs/inode.c: In function 'nfs_net_init':
fs/nfs/inode.c:2434:13: error: assignment to 'int' from 'struct proc_dir_en=
try *' makes integer from pointer without a cast [-Werror=3Dint-conversion]
 2434 |         err =3D rpc_proc_register(net, &nn->rpcstats);
      |             ^
cc1: all warnings being treated as errors

Caused by commit

  f290a586e31f ("nfs: Handle error of rpc_proc_register() in nfs_net_init()=
")

I have used the nfs tree from next-20240404 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8n7krLoyLB2GWSTEmJ.3RDV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYPL3UACgkQAVBC80lX
0GxeBAf/bQgRlytBJHdnvnYobOmT35C6/7BxgC+3uHiKckkc59egEovQy/nUoTm0
kuUJYNfSPFqYDcfSWWNBWBD9qQlOkIlN/nPugtCY8T+7IJj45o7SMJFC4eOvM1Ny
cqBTI0ObSmO7lMEqvPE6uJoP5emOxrIHcNE6f1NJpGLhxrHOgqXUe9uTTr5JntN4
s6+cbfV2NXzHTlWks+qlwcg62DkDfGtjw0p0hCzx4XaQr5N6DUQA5hTf+BtRk828
mcButWbx7Kzt3cZ9bY7eZwUVuctHf7IiFvLOJPSF33QU1WApwl7lPtc6g7A0D2wk
FcSzpYT43YEIWhVQE1+1sid3RWLlMw==
=Qhvt
-----END PGP SIGNATURE-----

--Sig_/8n7krLoyLB2GWSTEmJ.3RDV--

