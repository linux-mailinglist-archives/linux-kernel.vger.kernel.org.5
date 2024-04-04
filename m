Return-Path: <linux-kernel+bounces-132130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F4899008
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F2828937C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13F13BC0A;
	Thu,  4 Apr 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C16XOPFc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517912DD9B;
	Thu,  4 Apr 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265777; cv=none; b=PazpdNd187PBBYNMsb+6L+UcoTS+n3nEHrzPntWMuZn3GeCDTCZE7JbclvVdqQRnXt/MQ+G9iQjTKn7GLuMMbVKjD63MhO6tnr5SakJC580Vvg+pvOl90t+hvM9SqgaquLlS6JX2XJcMjk13HVZSprlh9v4+XnxqeFI0yT5szuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265777; c=relaxed/simple;
	bh=rIO7RiRPDq+k3n0/SLUar4PSqPI1e24ngMzDAoiYJpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aYust3r8/VcTzygvBF6dfgUL9ak1YXpWq74gK8AHD3bBTD6eT9RTIv5DhnjDEmoyDjeznM2QMre0IpW47JJr6/vhb75uoy4edorjIbma2zSP3BGem5OLYqlc4ZRccfDn5O6nIkZmKTYwQvtfdNVKuLwydQM3BDwEfwMKosxMRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=C16XOPFc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712265772;
	bh=38P+zYGFMcPTcXJryge5OAB4c4qWAdYh4T/ILFqnM0A=;
	h=Date:From:To:Cc:Subject:From;
	b=C16XOPFcQ61kGQeInt1DSpq76WsCl5gu112yo+Wkx1aMuZeh/VJOPU+lTLHs2Pu4S
	 Vl73Aqf/pWot8sLwtUs8TfePMRqEDFXJVkQNvyIT5lM2MEUKwxadB/8BbWKE8md5oU
	 spxKE1U7UUtb3T//h8i4SJ/nmvcwj4Epwc1sWIQeCurJshBAsiCvwbDVr1o31uAG92
	 /n/xZIJqeS2jL3PbY94P0AZxf1Z7eIt5tHfUpiX//JDTn55Ra8StTXFWtL5Csev3VY
	 aiIAssmLrPbX6Cban3044mJLzc9PIF1aC/FAvkvN7eHSSYrF0B84fT5KPUhzBgPPt1
	 qATXUpgG73nTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9ZMv3Ycwz4wc5;
	Fri,  5 Apr 2024 08:22:50 +1100 (AEDT)
Date: Fri, 5 Apr 2024 08:22:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Networking <netdev@vger.kernel.org>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net tree with the mm-hotfixes tree
Message-ID: <20240405082247.177638cf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wu_=e+S0FwX5G._gSarN6D=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Wu_=e+S0FwX5G._gSarN6D=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net tree got a conflict in:

  MAINTAINERS

between commit:

  ba74dd4f0460 ("MAINTAINERS: change vmware.com addresses to broadcom.com")

from the mm-hotfixes tree and commit:

  fa84513997e9 ("ptp: MAINTAINERS: drop Jeff Sipek")

from the net tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wu_=e+S0FwX5G._gSarN6D=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYPGicACgkQAVBC80lX
0GydGAf/dOx1xO2dm4EYRytGjFb52JemaTVgMeKqvTIoczDzUnbOgnph/KChF7jg
ofXam6zRFb1CbtXfwkKWb+msnAbdVdjGLamf8Ikxo4HG9aLXdWcoxris1GfH+vja
YlbpWvHNilmArzQ/Frs0D8tEinl/ohR4SUL7k2JnBgKSMErxlWF0zFQH496JYEvv
3Ck+1hrHFi37YSb7DrEwaOAsqq0cGfoUpyHpo5zn6DxYm+Rhy46uHlJ1SBCaHUYg
MujhxHFOPr+4DaPeyLVfqBXJYfEYqVPxjG4mFc51ghS68W8zeyeiB65uFBzDBuUQ
EseShsUVldDGaKOXkiuYRA1DpRyMHA==
=s6ZW
-----END PGP SIGNATURE-----

--Sig_/Wu_=e+S0FwX5G._gSarN6D=--

