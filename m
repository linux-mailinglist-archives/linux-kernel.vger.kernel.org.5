Return-Path: <linux-kernel+bounces-152621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708758AC19B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF0A1F21063
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB14595D;
	Sun, 21 Apr 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FogznuRx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4371BF20;
	Sun, 21 Apr 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713737471; cv=none; b=d6FdkwPPgfFwChNio8CY4A+E62zCwEGyZrJgw7J0W8ogp49DCaRsTMxP83RZmuCZPWYQLydQyvx/L4rR0JXjsgc2kMP3qK5DIdx4FJEGbvlycBZPOAhMkKij7Fb+vPbYknoshQgx3LM8jK+nbktHsSh+z8eLaR/g2T2oXWXNqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713737471; c=relaxed/simple;
	bh=fYLRo25oEOG/yAHjSrZrQrsvXZwnKsWphBXCWLdXLIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VUejZY4Zx1PY6K87LN/FC0y/rwxynClZplBUCig2Lx1nLtyNOEtL4Ij7HUHIyEBik4dxvNjQ8YzSSypFJbJLvPUHVcWjI9QiOX1xScNBZ+jmwB786kFog5EVhqGwiku/XGQl5KS32Ri4mYrDWt1B/tXLAZqQz56QA13dX7vDdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FogznuRx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713737459;
	bh=dhNk1WxQ40WFgo4FOZPYretiY0yHe56rP3vtHte1q8g=;
	h=Date:From:To:Cc:Subject:From;
	b=FogznuRxDp1jyYkJ2X7dDXKIkq0O808+BYfRyL9Rz2oaziqfIFldwKP4EHojm8TpG
	 HTi5DysU5ySKoI1XvfdlouEsfFyFExQCjDr9A52aWmC+M3EohjewDnbIDStCBFka88
	 Vz3b3ji0GGi8jMRVN1kppXau9/X1WCCJpN1sSlw4gJdV2vaHDGpKvDI8Nm+/yhatUN
	 xRK+qtwkRAbf2TeEGu7ytM9C21kksI6W4/r+ADdikM26ErOa5SckRj82YiELINUK5F
	 3ieVRpydOnB+bsUMTZWv/IQE6xHJbSMr2BSSJnhJcTrBsHxk4WBpND72+LtP0p93ld
	 pvzePa4ubeRoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN2db1Plhz4wck;
	Mon, 22 Apr 2024 08:10:59 +1000 (AEST)
Date: Mon, 22 Apr 2024 08:10:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Qiang Zhang
 <qiang4.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20240422081056.34e51e0a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q5iuYD_+XEUyP+eL5.==vR5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/q5iuYD_+XEUyP+eL5.==vR5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  20c9b0ca4082 ("bootconfig: use memblock_free_late to free xbc memory to b=
uddy")

This is commit

  89f9a1e876b5 ("bootconfig: use memblock_free_late to free xbc memory to b=
uddy")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/q5iuYD_+XEUyP+eL5.==vR5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYljvAACgkQAVBC80lX
0GyytggAhJ5xBIxTlgeaVdn/CByRUSjfTHtCD0urW9DrXzE5LVbmuzPM3gTjrCWh
doqYK0+pkuWe4U8ikY3GYxSgumA7hpTwpgc3G7UBzSfWocNcKMzKmXiyI3mb+Gtz
p4lFn1G8ezQTfEPcmzvkZzesvHLqSsytXyUIw3RI0jv+Wa1VCz50aj8OWwIQNepb
/6TqpyymIAN3Kd7l5Bl0J1bIpOH/bilZGGH4FrM+RL++nVZY/H2S1UrJFsOSf3yx
slQoAADY6RbmexVeOUTnziW0clgYbmOwxmjEbsnIneLM5wXHUEN38D02lbvLASXa
5Gm1+LD7uE0gxcoo1M5GwvERzZKosw==
=KuSn
-----END PGP SIGNATURE-----

--Sig_/q5iuYD_+XEUyP+eL5.==vR5--

