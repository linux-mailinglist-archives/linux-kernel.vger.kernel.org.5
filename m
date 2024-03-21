Return-Path: <linux-kernel+bounces-110791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C28863FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CE7282C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FB1E534;
	Thu, 21 Mar 2024 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mi9caf5U"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A11B592;
	Thu, 21 Mar 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064200; cv=none; b=sLk5NP2nrdCsohDC1PZ+QsE1y2l3NLctOctekDz4qqCUWi8UaBH0HpcuisyszqdJwD9Cjv7zYdWN8ecqUtrC0IDPb5hNGB4C2OyH9dZUAH/8co3YLem1wRzLGxgzbz0z/GXeGd07FN7X/iCT0WCb7Xc1saG7kD8Kpcf6SSXa4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064200; c=relaxed/simple;
	bh=OwpVjP4EKcHrqCeXPfM9n9fMWG8L9IxEPGZNiGIxyDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCD2D2b2XLzsiK6y4bw9RtewGBgxkcLfF7faXpHuobYCw4dxDPdtyYYhnmwt5TegtSK+3sErV0tYKkYQN6Ib/mzMtgho3z8js1b3fYNENYOsYRo+7S03r1OiuHtq/lFe1tVWUQi56OAAMSLCOQVX7gky9uCn3N3x7vRv7+zV8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mi9caf5U; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711064196;
	bh=sE2v+5hFjssx1T9PeXN8GgSIYFGKmapOhxgFi9leNB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mi9caf5UljrxW0cx7LOUmeyFY4H3FFGvv92U9kBopPh0faI2Daw53garEDU5GM/IA
	 u53nnLyzMwswOI50setKcUpaj8C+X232kJVJelO/IlR2kwFGcC0uNNBLcBKpn/QK0t
	 igXkYYeWiUZ9gOjNIzl28YOe3bTdDVTWJ2D7xKw66/PJdF34nsOu6ki1quQ1Y8SBEH
	 qNGTvKtcu0fxw5lGMBDJGHxSJNaPAznBONZT31aJi7zRFDq5SBtKsqZiSdafbJVesU
	 84bE5pKbIpdjTGEd7RlIDz3KEefP2ACwUjhgeHQ9l5EVmpem/rELD5CyOhEsTiROxg
	 kDqKhFLqekvGQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V120h5NMsz4wc3;
	Fri, 22 Mar 2024 10:36:36 +1100 (AEDT)
Date: Fri, 22 Mar 2024 10:36:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20240322103636.020aa9d2@canb.auug.org.au>
In-Reply-To: <ZfzAKMlYY7IkWXUg@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
	<ZfzAKMlYY7IkWXUg@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KSBLV9_v.I5NXBSvO6XGhra";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/KSBLV9_v.I5NXBSvO6XGhra
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, 21 Mar 2024 20:18:00 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
> Ok, maybe I opened perf-tools-next for the next merge window too early?

Yeah.

> For this merge window I think Namhyung is switching to perf-tools,
> right?

Hopefully.  That branch is for bugs fixes, I think.

> From your reaction I think I made a mistake and should have opened
> perf-tools-next for v6.10 stuff only when the v6.9-rc1 gets released...

The top of my daily linux-next release report says

"Please do not add any v6.10 material to your linux-next included branches
until after v6.9-rc1 has been released."

(I did forget this message for few days this merge window, sorry).

--=20
Cheers,
Stephen Rothwell

--Sig_/KSBLV9_v.I5NXBSvO6XGhra
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX8xIQACgkQAVBC80lX
0GyopQf9FtRidrf5iH1yPM8sI9JZW7Vx/1GNAAvId+wmPeWkxIo3fWB908aG5cXG
EZA+fgHZ9oV3whUdJB4i6H1xAZQGYooy1ng2acCGzx0nFmQIGtUiZjQzcULGswuR
8Kg4oUD5sQgsf6HqJ9iVyCIEL5hrmY94hisDnpN2j3FLrdNDrCKvM3kVcgWxDvL5
TFrRCFlnNuUg7jHc/FzoVt0hrnururs3WNxBZkKbw+zXPOTimMJvMOQwGIxhMaQZ
p2Sd3mz8re+XH+QmoW4jQxlJ7io5+d2VEMTnfr3S34583yxdUKJuG0hE5PhfwYLW
PEnEEEAJsJIloVAd5n7F8lmtARXJVA==
=w+TI
-----END PGP SIGNATURE-----

--Sig_/KSBLV9_v.I5NXBSvO6XGhra--

