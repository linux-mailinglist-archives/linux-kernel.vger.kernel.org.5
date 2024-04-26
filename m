Return-Path: <linux-kernel+bounces-159441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B388B2EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AE11C22523
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB19F1C3E;
	Fri, 26 Apr 2024 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j3eU+Xvx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A161860;
	Fri, 26 Apr 2024 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098163; cv=none; b=p2dnjibi7gw7w/GUX8T6ODdwaFzf4dhQUj+Oa4cSiiEzkHctoAWeI9LjkAQqXn2ZOvvqF2eGR0E1geG7WMhTTxNYz0BUEBUjD5JTw+1MdoDU6uHNyBZlQHbrXd1l25i2iTJ2qUczVq1sauEqfaOvB4/Fwqla8Lk+Fowjgn6P3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098163; c=relaxed/simple;
	bh=SGYmgklzXAXHDbnGapUv+OP9t2fZ8HQN2L78VH8xfWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRFxKqYqIoJkFaPzo8pKhIBl9owfiOsyAXhEuMq3drsmwJi+1pQrTxbv0TKrWpJHYHBqu5H5e/O1wngJhUBstahJeG4A2bFd588hWPt40Hrk2Mpp91tRBXIbHT6UFp6ojCxaSueRWbZc/Plkr3o257YfCneQrELVlpTr6FuV9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j3eU+Xvx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714098158;
	bh=vCi5NeIBjIy/G8fUon9n+kNojGUZtoR7sj43GA36g60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3eU+XvxnnnBhJkXi7EnOId35O122bgrQY0ZQmU2k4hPAkmBVVjRHeCR0yroLrDEq
	 9RccHQg7qhAeN/FzLk0Z8efnuaCu9WaETxfzzOfr8a/NdrHVv75ibG2i/Zm/xR/iZk
	 EAgehT/JElJ2FBrg52Mh4spCMB+Rz70/Y7J1wAxS1RuOOAiVY+3wJqKr1UldMvi3Sl
	 XwT9n+c+lpADJx5XjsVkuEXNioTaY4ra4ZLMGIE8cb9J2f/JGf4xPZdt3XuiSQLkY6
	 Z1FPTt516h3xvTUiNz1HIFYuKG4DJyld9PnbnBoeQnfscbRwjHqbsKoa1f+rABaj7b
	 39B0mq+wp5iWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQc2632xMz4wbr;
	Fri, 26 Apr 2024 12:22:38 +1000 (AEST)
Date: Fri, 26 Apr 2024 12:22:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-msm-lumag tree
Message-ID: <20240426122237.4991a706@canb.auug.org.au>
In-Reply-To: <20240409120108.2303d0bd@canb.auug.org.au>
References: <20240409120108.2303d0bd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mQ9A.ugvWxqRpGSq+vfTx6V";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mQ9A.ugvWxqRpGSq+vfTx6V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Apr 2024 12:01:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the drm-msm-lumag tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> lxml not found, skipping validation
>=20
> (lots of these)
>=20
> Introduced by commit
>=20
>   8f7abf0b86fe ("drm/msm: generate headers on the fly")

I am still seeing these wanrings.  The above commit is now commit

  0fddd045f88e ("drm/msm: generate headers on the fly")

in the drm-msm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/mQ9A.ugvWxqRpGSq+vfTx6V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrD+0ACgkQAVBC80lX
0GyoeAf/ZQiUldJfOSBDK3hKj1htCY86Ecb/9rOgzmwtwNowLgPIlBSair75Q7LL
9GdCPCJ9PYy41tb4jJ4B4JMlRfaH8XhgV71B6wEH32OsvEhjn73eAXINBlLDwpLB
8Rr85E+D7HUjOR7qTR0yKry/3cXhM4L4SAVHsdpW8l3TfWVwIgNTAN6P4ByYUUvc
EYu95wLoPFKiJ08Zm8RDXZSfnT0++DdxAVeuBgbOcBpg6fL2gkIf03eR6SuxKTkG
3fG3D7YUHbXNa1R/dXs/c5OXdXPRBsHlwtCQlCyR46rZkW71dkzA3nj88hXp6WOO
EbYZ5GljqwIzTO62vPMEnLduuuNEPA==
=uvM2
-----END PGP SIGNATURE-----

--Sig_/mQ9A.ugvWxqRpGSq+vfTx6V--

