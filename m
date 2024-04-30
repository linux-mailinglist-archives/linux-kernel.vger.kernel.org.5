Return-Path: <linux-kernel+bounces-164757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39F8B821C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1AF1C22883
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BB1BED88;
	Tue, 30 Apr 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c0giV2Mw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8212C819;
	Tue, 30 Apr 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513849; cv=none; b=gZyJs+IepAxdDNW1ZueZD5j/WmPK+wuXKfOiYcZzALPfdrLq/ou/bQNh62TzfKv0AHWEwn+FxkUR74/v4+fRJP9tclZAgG8JPLBF+6ulIAsVvR3wNf6VBkYqsMkVsuxz8XxadIciVkNRgqulSySAjkEPAjFqkvQeJXmcn52Pv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513849; c=relaxed/simple;
	bh=3NArsFz1r3qJL4k5KNQHEJM0bqpeHXpcBhedsCuAE9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=r3JvfR80EkoDq3uh9Dr6tWr4M6UC4Lv0i4COZyEcx5Z19D+sd3I9zvfd0bF1yslG+DMHvcuI8s1qtIY0Env/GClr7N9fWJ5VArEy1snsiZ4J3NXqLdmRMFXN0I+lLXhZaWtGZR3YseaWVKzb/f4az00vli6QOxdvquRyPZvTB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=c0giV2Mw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714513842;
	bh=izLQXcgdiQIl7LmXWmU0D4rabKJ1+kBtoVNVdbdY8Ho=;
	h=Date:From:To:Cc:Subject:From;
	b=c0giV2Mw+ze0gE4XDc/Hj7Xphxab7OWIl2/E5H8dfW48Tq8NAFr1T3fL0HunSScdF
	 Vn9XfWBIDJtpvwWHNe4TyZoM4cyphfY2NBmTFwBHQk0+H8LvUevHSVOq+Lcg2qqyiZ
	 9mBxhDP1Vi2ZCiMvK2yogfRjMaDHFgcK/TDgc8om9D0JcXsDQOYc2qerqMpWAXD7XC
	 N1qdLQh40MlBTKoJXShJ38Urn9C847pdNeRjCWdcfQp49HzrBNf3lkADA6g6pyTYmp
	 29LyEUtilceJ+FswyfOpbFF18ri1UMDh94DfTXUtWycuCn1orp9k0OAsloU+ix1O0r
	 pJ219AtpNBajQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTYm13WKHz4wxt;
	Wed,  1 May 2024 07:50:41 +1000 (AEST)
Date: Wed, 1 May 2024 07:50:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>, Luiz Augusto von Dentz
 <luiz.von.dentz@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20240501075038.2d07189b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TZpu60kwxol+ZwW_+rbEiIM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TZpu60kwxol+ZwW_+rbEiIM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  91708e8a4376 ("Bluetooth: msft: fix slab-use-after-free in msft_do_close(=
)")

Fixes tag

  Fixes: 9e14606d8f38 ("Bluetooth: disable advertisement filters during sus=
pend")

has these problem(s):

  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

Maybe you meant

Fixes: bf6a4e30ffbd ("Bluetooth: disable advertisement filters during suspe=
nd")

or

Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by address=
 filter")

--=20
Cheers,
Stephen Rothwell

--Sig_/TZpu60kwxol+ZwW_+rbEiIM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxZ64ACgkQAVBC80lX
0GzG5wgAkYSE8k16stSKYX8VtpHiYMGqlsm/WMvb10yJItZVXBbcdu0g/LbmAQxm
ki0LWW8L5p85gqDi+w0fYRc0zdZceJkEqpbujM3FQ+pCPyDkZs3diL9PJAC4DWO5
rjXUb9rYqUbLSmQelWXfp+LY+Tgm3Wqnp7y2iEd1kRe82Bm02gP0IUh/fCWQ0ubD
gic9HRG3wRoyd8ftJXh12hos1mufyUbBnO9btLjkh4rVMp7DvZcY8YZST6NwmBQ6
F/0/QXZRZ+3fBmZ8pK8xKSpeCG/CWXgHB/x0y7mnfBpR5AybySxM4oGSwhKhjkre
to9kLbJusRUfulX1RNXBCfri/IIqPg==
=zBSp
-----END PGP SIGNATURE-----

--Sig_/TZpu60kwxol+ZwW_+rbEiIM--

