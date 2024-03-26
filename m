Return-Path: <linux-kernel+bounces-118370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8388B9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B02C1F38C89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DF883CA5;
	Tue, 26 Mar 2024 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WIZW2SzY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD929B0;
	Tue, 26 Mar 2024 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711429940; cv=none; b=uGCCVU5EGoIzb1679RXu7nWtsNVP9OvQDClu2wNKLjrTB/Qx0MHOhnEMGOHoVfxzMiOHtJGTIczt23MCNsiFn51RtXzN/8rSHgIl2nN3Yc6qwfWVHWUfZk8ffXUNuDrgsQJOXzD9leZlWXkzzB8QVmd8zIPDOpo37shpUNJOHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711429940; c=relaxed/simple;
	bh=ERUqKAPU6C/RWKwBXMaZKbHaheNQ7cNTEaYfwrYBNtY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BZWiM5IwRteh+3tTmxLBRjAN4RwbBueGxxEs3PwppD9Wca6MDyT6qk+ZS72GyMkSUaO/qn/8nJ4lPwygU1cVL7GN4aHoiRuPLrkn+lRwXxLhtJRwyi92Ykr3G5nBY7xq62LG76aZRVX6AIRyCVyGE9ad32Yxe2JuBYDQx2eiZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WIZW2SzY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711429936;
	bh=lny3jrbC6XgEZG/JZJCH6Kp32eh40iJEAplAlnsOcwI=;
	h=Date:From:To:Cc:Subject:From;
	b=WIZW2SzYZqzbWZv7fEcxPH8qWJXx7mc/C8sWnGKA13Jvjl7QqoQN2Au8riyfKpDh6
	 oICxoP0VJpHKPlCt2y/u7ky5i50VLsBfqpTEvIcpfMWw8NaX3ScpSqeg1++sAd+7cv
	 YYKLKe0QhOIx1TNc/n+DdTOvzsFfoZ8ReLxE6IICRVVeLmzitmRxKcUUduKfVd5vjO
	 SZa79K4UUFULrJpCM0UQU23+1DmL/DUpHlTjtRu8Ril76mMp8A4NUp5eJmMg+/Kb8A
	 HLHiSHn5lj78YNxzr7qT6O0dehPBsKZALeaHju/kI+kz+6c2XI3nC2/kjWlwsMT9A6
	 yCfnu8PrFSU2w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3dG828hKz4wnr;
	Tue, 26 Mar 2024 16:12:16 +1100 (AEDT)
Date: Tue, 26 Mar 2024 16:12:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm-misc tree
Message-ID: <20240326161215.559b6366@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hM/ZIU5C/yDn0fCAy.94Q2E";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hM/ZIU5C/yDn0fCAy.94Q2E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced these warnings:

include/uapi/drm/panthor_drm.h:344: warning: Function parameter or struct m=
ember 'core_features' not described in 'drm_panthor_gpu_info'
include/uapi/drm/panthor_drm.h:344: warning: Function parameter or struct m=
ember 'pad' not described in 'drm_panthor_gpu_info'

Introduced by commit

  0f25e493a246 ("drm/panthor: Add uAPI")

--=20
Cheers,
Stephen Rothwell

--Sig_/hM/ZIU5C/yDn0fCAy.94Q2E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYCWS8ACgkQAVBC80lX
0Gx5WQf/WGVsdA3jyo4FbiK5FGKYIu7rgYqw8P3qqHNT1yxhFgFcser8YyTdhidh
8mQ3uOF/XllXbp/gWZzsbvE5wW3joR3sqAUJduI1wiAqKbO+9cSnGiRidivk9vG/
5woi791Ww+prKJAOzdubZ6lUbBlvPvHq9LC9ZgD8R9m19f6I4euqm9eeS7/Zu2KG
skDC3WWWTdIwgqioPKZsheaPPGEal+Q6jCDWKxMNvnUDns+2h9m+ufEg0GmYeOUr
ZW2fbyX8hydGF1/62taU1g+YociNyzCwfwbVJL6G0OGyhG1IxXnJlwX84Yrd8Ky2
aQNIuw52mOyEDs1f9faf4FN/HsMasg==
=6rk9
-----END PGP SIGNATURE-----

--Sig_/hM/ZIU5C/yDn0fCAy.94Q2E--

