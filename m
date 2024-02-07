Return-Path: <linux-kernel+bounces-56006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639184C4DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90036B25D11
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F771CD21;
	Wed,  7 Feb 2024 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YHXMuj+8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978771B94A;
	Wed,  7 Feb 2024 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286650; cv=none; b=vF/37eUw8ell2SAfBq7r41DAdYyVMJMuoO+icCEMb6yZdK4a3qPzYOZQCeVSy2bDhUYNIUyvmF5xoW4fbkaIWViH3dcKOcoqH6XfZiA2z+MAaD03tgafAXDETNbrbf9l7vuo19yw8vpqvxx+Wx/1VPOMHOcRyiRuvRC4Lhm6+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286650; c=relaxed/simple;
	bh=5A0X/bLBfe2LanBehWAIym1E+7OPRNPkXR6ux0g4ECk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YFQNIyTBgrWLaTZcN4iqVDVI0dpbgf3pDy8j3Cj/sAyEW00k+gpk9y0AGfMO7EN24fFvan4eCi2g5QhZUoNtGaT0u4zAYV6dSVVqa5AenlSHL0a3tYvUmcFdljF0rERpeFxpeDuNsxrD0+GK1OqrIrWzuuwihhGt7a3XMqIf6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YHXMuj+8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707286643;
	bh=+5kUxFiHt+cxT0M9QTQ3TdwQ7dw2TdyekbfCEjGcd0E=;
	h=Date:From:To:Cc:Subject:From;
	b=YHXMuj+82gVWC8X8VuHkx+T9lrW7iTnWRBaeF5kF033t/zA4k7ULdPQoqZl1vIU0a
	 Ol/MN3PAvbn9MRwWESTp8rUPwkXdA4zCLPFXRX7voBckU0Hc0RpNY94lv4MtByDBSS
	 HlF/ji8rvbpweBx4IaSS8J1QhkxqpYovkN0b8sWBP7a59BWI08GJbhqtmsOKfRAvYP
	 bU/BJP+rIrxutXhLlYtKo2IJmakJrI2cwqO8xWFNQ2Tfo2fw0/zdHRHaQMv3hiIrlZ
	 z/nt3IrgQrtWxTRN8TYDcLnWtaxcE7kYSuQxYMv3inXy3uX2tT+oSubAQ+cBRQVr6B
	 yGHV9fmn6nGdg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV8zP3sSYz4wd0;
	Wed,  7 Feb 2024 17:17:21 +1100 (AEDT)
Date: Wed, 7 Feb 2024 17:17:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20240207171719.7d15be34@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/da5j6.dKfOcG.XdRNIMLOqh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/da5j6.dKfOcG.XdRNIMLOqh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/gpu/rfc/index.rst:35: WARNING: toctree contains reference to =
nonexisting document 'gpu/rfc/xe'

Introduced by commit

  d11dc7aa98e5 ("drm/doc/rfc: Remove Xe's pre-merge plan")

--=20
Cheers,
Stephen Rothwell

--Sig_/da5j6.dKfOcG.XdRNIMLOqh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXDIG8ACgkQAVBC80lX
0GxMqwf6ApAQ/EyQEaEwhpn1vOhxL6EQRcOY6FzX8R6eCFJy66+blTy4zTJEM8CU
NdJDGe9MPjgLt3/kku0mynB9WbwvEN2w05FJV1vLcCggjw+S8RuHMUu2kuUOq+gE
0kyHU9Y94Fi8sd5jMR7KN6Piu8JO1LDneugmmHgsZMkgZt6KIXGgalBIbHA1rAgD
9coRkns9hQvNlcBw4UBY/E97OFnI/vK30YlrEXU0AVuHdSDspR9FTREybd3TC+Yu
oi2sqJSPsimgtFpBO829MSLV8PHIGK17xhgO8zom/Mx2cSHuQAqEP0WW7Xu4b+sJ
LTLsLZK1iNOS0ql9l26IZSJ+ZbN3Pw==
=oHb2
-----END PGP SIGNATURE-----

--Sig_/da5j6.dKfOcG.XdRNIMLOqh--

