Return-Path: <linux-kernel+bounces-164945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C470B8B854F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ED21F23575
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0E481B3;
	Wed,  1 May 2024 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y9SeVoLN"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C345C10;
	Wed,  1 May 2024 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541332; cv=none; b=UgNWsmRcnLA/1VxXS39KS0AGdxFCRy5VCwPdU6/WKllbrAuPpmMnjy19fJXip6QNX3bJxBzW9bJDZip5IYSVBepQCnmPwvqJKuCRUbW2YOc87YHZfg6Twb5atQKEzeGeSMAY3zM1vw1iNZtw2o2a8Eouq2bRzcWz4vR0245d+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541332; c=relaxed/simple;
	bh=3bPyfozDstmDwZLV/ukzH1VbLQqxYqjZIzAj2hMugxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Zj3hOVzPBhQPASYiZNc07Nb1H3cbT95MHbvLNS/RqrOiSqqGWHMeqVRuNLBXPi+pZ/O0J9lWix3O5sXM8SZ72o/OThJwRiIGQGq+1KRC8PIDdgRNLHXWkFR8ULT1rPF31O8VypADdMCnQ3uYin/4XiS9zkSTtGzWPnECFWX6spw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Y9SeVoLN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714541328;
	bh=7iCiIxpOc6gBOG6oc53IQAt5L1pLTD4S8r3Fd/+jfGo=;
	h=Date:From:To:Cc:Subject:From;
	b=Y9SeVoLNkuwKMSixdOVwOUEDImRD1Q1+nHe0e//Lo88IRUfMPbNmOFJSkzyme1NEP
	 brneucKVgQQ+xV2i/4KoTI+GR81VbCCMF5yXJUXcvMUXUyjFRW+QTuBK77h3FXSzYq
	 cldiFAr7jhZT3srgrW7OOqParjMo6APLg5nHI/tDEA4aYFOmWrX6MWJmiyiigccAzp
	 tGnTiCl7EqTmcHlVK9ymPwssX3ywfwie2rJEoxJdJLMLvHO3JH35Xb8v66GhZnEe3T
	 jJjOpP2wEBe9IpuFpjz6xrHRqsOfeJK7CdahjSNHOFOK5C/LK3numEOpWEbsx8ynvD
	 VpGZhd+PyFjtQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTlwb29y4z4x0t;
	Wed,  1 May 2024 15:28:46 +1000 (AEST)
Date: Wed, 1 May 2024 15:28:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Nicolas Bouchinet
 <nicolas.bouchinet@ssi.gouv.fr>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the slab tree
Message-ID: <20240501152846.311be492@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dZ+1.=a=9al1OJivYkBYJTL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dZ+1.=a=9al1OJivYkBYJTL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the slab tree, today's linux-next build (x86_64
allmodconfig) failed like this:

mm/slub.c: In function 'slab_free_hook':
mm/slub.c:2187:25: error: implicit declaration of function 'get_info_end' [=
-Werror=3Dimplicit-function-declaration]
 2187 |                 inuse =3D get_info_end(s);
      |                         ^~~~~~~~~~~~
mm/slub.c: In function 'maybe_wipe_obj_freeptr':
mm/slub.c:3872:14: error: implicit declaration of function 'freeptr_outside=
_object' [-Werror=3Dimplicit-function-declaration]
 3872 |             !freeptr_outside_object(s))
      |              ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  7f39e23ed8dd ("mm/slub: avoid zeroing outside-object freepointer for sing=
le free")

$ grep CONFIG_SLUB_DEBUG .config
$

I have used the slab tree from next-20240430 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/dZ+1.=a=9al1OJivYkBYJTL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYx0w4ACgkQAVBC80lX
0Gyq5wgAiD/Wy9xaBsjDyaTUstXKWq5pQBwbuPWJlsCVitTF1wElG3f4WcY7SkGH
/AjOH/ZSHF/FyQfID14/ccQ9a7DWlhVF1X0J9KGSoJLra8eCI3Ui4GiHug5rRQdi
ZkRIw2Lf6L8nKj63BZhCvfUpoxashC8SUOUD8losZ/itoveGfB9PY8xC/6wLHSxE
dQrE6R+kJC3cEa7hz56XdizasDmlpxQNKaBfMEG16ZWGZ8wbI2Eh3qFqlWlm1ndn
TTu3yYUJmoEJhyIl8ZVBnimtMhSK7Qt37qEBLs060ICiYMzScI8jON14US0dr17m
IopkuNEgukrsfu96V6/z5CBFCbkyEg==
=Hnlj
-----END PGP SIGNATURE-----

--Sig_/dZ+1.=a=9al1OJivYkBYJTL--

