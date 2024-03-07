Return-Path: <linux-kernel+bounces-94852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620AC8745F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E520628179F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876963A5;
	Thu,  7 Mar 2024 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ltpJub++"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206846AF;
	Thu,  7 Mar 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777435; cv=none; b=S5eGhOBXUqkIMpEbFb+0Ryur2qTcgemCJn6MlYAjdo0nhbrJJiEaVkd3HVUOnI5yGigrwHJMla+uMWGz17x2vtjmc4rE8AKhLy38GgymE3YtCnFYuv/4Od7jBoOQ/P2j65JMwAfIXP+LJfep+4Wye/wXYY3P7sTJ71TxBzN6D0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777435; c=relaxed/simple;
	bh=MojI5XOENWoQXlhGpmQMRKuFP/opvVsRYgCk9gXhyB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=it48lqeW3hZZHA9mFcPs6oDgC9kOfQbM2mdTtjhLJhqjgOy8jCTXwWzrzqAiGc8wBsWCdZnCDTL0SOA0WC1W3l1P7ELo4aBQRV0QSlqsWHS616xuxiTsgxuSENG9wNR7ZA0e3ecmOsrWfub7A81Rnze7JbUWoqr1DXLCR+zX3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ltpJub++; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709777429;
	bh=aBC5lNlYQfzlwFaWA0idshYy9P2JYbt9Zw+CpC/ldcE=;
	h=Date:From:To:Cc:Subject:From;
	b=ltpJub++viAVgQpYOh1ttxr8ZbOLpl+tcVJqlwLV7b+RW312Eyc36mFq/hAfD9Qp7
	 7qSfXlLiBBGK8mvu09QBy10AjXytMpyV0gyrvOHcL8zVTa9Q856YOxVTUQPKw5oRkU
	 qXuuic/xlKBXO6bRL6oKsDZdt4wByjuYdylp9PO7n+0KhvyF/HFDfIv7RJ+nf67d4H
	 ZP1CdadB+0E0/hY/u27nwSsUBXoB6TOE4Ovyu7qOpAnHXZ0wZLkhxJ3kCkB41AN9VS
	 R2w8xQ1PmvcZi/xmVHVOSJf2MQu69yd31LCoGq99iAtJ+LY+Rfpq/nJgCqc+iRfqIL
	 p6SfX33zU9aMQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqt780clSz4wcC;
	Thu,  7 Mar 2024 13:10:28 +1100 (AEDT)
Date: Thu, 7 Mar 2024 13:10:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Animesh Manna <animesh.manna@intel.com>,
 Imre Deak <imre.deak@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes
 tree
Message-ID: <20240307131027.66be2266@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gBe8YFdyBRsQQ7vG967EwEz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gBe8YFdyBRsQQ7vG967EwEz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_dp.c

between commit:

  984318aaf7b6 ("drm/i915/panelreplay: Move out psr_init_dpcd() from init_c=
onnector()")

from the drm-intel-fixes tree and commit:

  e60cff453b82 ("drm/i915/dp: Enable DP tunnel BW allocation mode")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/display/intel_dp.c
index 94d2a15d8444,6ece2c563c7a..000000000000
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@@ -5699,9 -5702,13 +5702,16 @@@ intel_dp_detect(struct drm_connector *c
  		goto out;
  	}
 =20
+ 	ret =3D intel_dp_tunnel_detect(intel_dp, ctx);
+ 	if (ret =3D=3D -EDEADLK)
+ 		return ret;
+=20
+ 	if (ret =3D=3D 1)
+ 		intel_connector->base.epoch_counter++;
+=20
 +	if (!intel_dp_is_edp(intel_dp))
 +		intel_psr_init_dpcd(intel_dp);
 +
  	intel_dp_detect_dsc_caps(intel_dp, intel_connector);
 =20
  	intel_dp_configure_mst(intel_dp);

--Sig_/gBe8YFdyBRsQQ7vG967EwEz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpIhMACgkQAVBC80lX
0GxBvQf7BmI0o7dg07Jqo6rgMQ9Ay2p8WMp/6yyo8Jwhyb5JmFYD87E2QNv9HHfT
HgoVX1Mb+jk665Q/obBnEcW1Hcp/sZuli4SU0FVufMV0DGCz/va+z8k2DhRTxgvq
oDwInGOeOksje6o31zYGtvcbkZ4CA9/GAaOIN+h/U+eNqALRgMS5p6GAMfZUCOl/
XipVMUDj8oqzgkeKY5rSop1lj0hF+Oi4NJSP4Z4W00+M/zB3QbyT4WzYRbLcloWH
UWBFoyOUzo/ShztOMcR/cBOIDSiwWc/VQum4259wUwPJvIXqaipIXhTrNMgBMTx3
m2UTeFGeAXW8d7sKGANRay06i4PH+Q==
=14RR
-----END PGP SIGNATURE-----

--Sig_/gBe8YFdyBRsQQ7vG967EwEz--

