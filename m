Return-Path: <linux-kernel+bounces-146430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A08A6524
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736202843D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE157D086;
	Tue, 16 Apr 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fLbbpvtq"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D46EB76;
	Tue, 16 Apr 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252681; cv=none; b=SMo2Imf2CfqPQCaZCHLVvn3B+VlwQKYhrj7GphWdIV0hBYSJRKZRYTymCe+L59a1/5fj3XaJ0w/egqDrkE5ty1/jc3DGZXcwrrUl6O963nl9B2WZwEwWc9sC8H/l6Qty5LIBEsG+0zRvgpMCeXVp97NMlEeU+ouqtckI7CC0pSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252681; c=relaxed/simple;
	bh=AVvgrdwgUlFcyOqJC1cNpEHtXM6gzqbA1VoxF+YYTOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QuQj4Pf728yOWP+4Eg5Vr20AFiAiMHCQOFMa1Z1Ez2OOg7SxEHLVepTTH93o9aQpJ76j+9Rvx2PdWwsjFwfSIPYVmy/hl7FUhlnqLWjcUGiUKHj5de9AZuMgadxgA2Ap29Wm6bM4Usl446Rf2jjpCzmQo8S5/mBEjWZY/5fFT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fLbbpvtq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713252675;
	bh=eOK/bCV7IyfygWV9u4shyKXmqc9QPsYNWN/ruKFTjn0=;
	h=Date:From:To:Cc:Subject:From;
	b=fLbbpvtqB5ohUbohD+5h0tTJFVqVyLEOJdJziboW0356r5MKQEkZqAbhfp1clFcey
	 +LFSNWb/hV47tZfyzxiREouTRd8su67dnHBgW0YXkQp+6EQIRAImVZHmcSYOXOy6Sy
	 XY1P4Oah3eKDhVuyBtMAD7Z4vNJIOReRqUCfFddPv2tFC29c1RjnZZBPJKbydbUUw7
	 dIA4aYJTpwDvp6VwKYJgau6N4GkEOtNrqv3njMgYDwG4+AlfBn+zDp7VrZ93GoFNKa
	 VHsbVO+3AHpfc4t+3/DDIzDEompn2pt96XO+efd7SziDDnB3lbNp4MyEe/CXJ/m3CL
	 gpdwArMAPLmDA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJbLp6YNdz4wnv;
	Tue, 16 Apr 2024 17:31:14 +1000 (AEST)
Date: Tue, 16 Apr 2024 17:31:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm-misc tree
Message-ID: <20240416173112.04579e40@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jKM7rW28KcV_xG8kmBaV5Jf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jKM7rW28KcV_xG8kmBaV5Jf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/drm_fb_dma_helper.c:166: warning: Excess function parameter=
 'drm_scanout_buffer' description in 'drm_fb_dma_get_scanout_buffer'
drivers/gpu/drm/drm_fb_dma_helper.c:166: warning: Function parameter or str=
uct member 'sb' not described in 'drm_fb_dma_get_scanout_buffer'
drivers/gpu/drm/drm_fb_dma_helper.c:166: warning: Excess function parameter=
 'drm_scanout_buffer' description in 'drm_fb_dma_get_scanout_buffer'

Introduced by commit

  879b3b6511fe ("drm/fb_dma: Add generic get_scanout_buffer() for drm_panic=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/jKM7rW28KcV_xG8kmBaV5Jf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYeKUAACgkQAVBC80lX
0Gw/Ugf9GCtTwfsqYN6Q9KQJP18BmL2JZH5PKYqdWlunZ5miF5JWklZFbmtc/c+y
3OSqOq9JJEQYZjENLc8JuaiRfljIzOWXa8rDPY5ozXTIRaJYaWcEJcBeoQtkgUvM
fyfM6hxh6NvtxZ+m4p5UxPt+rJloNc/I2QADH91xkLzD2SaXBR7Cby35sSj37K3S
SVx52L7Kia/A3DCb6QRzYEBPvY+waP2geLe+UJk8e049itVjYFvzV9bZjT0phRj1
dMZ+KraFIktK8AhJsi5Z9HdKi8liTgfxMMMMGgioR6OZ+ZxMPU/IdfFLuY6xDKap
sIzKNEQ3ExRB1BpsOZoRKA/EXx0FTg==
=NNr4
-----END PGP SIGNATURE-----

--Sig_/jKM7rW28KcV_xG8kmBaV5Jf--

