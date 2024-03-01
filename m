Return-Path: <linux-kernel+bounces-88278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D386DF8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53250285524
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DABE6BFA4;
	Fri,  1 Mar 2024 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MPJrHvWj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762C67E74;
	Fri,  1 Mar 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289849; cv=none; b=UDxmLRXcoCZIgx5+NKiCVu3dJ49oZzS658PpDfz7CQTKcJmD6wIGshk1QzBuxiTgmFgmY6yMugrW3n2UmLeb2vARZfqLGJgTsCmA4n2iXNZAfAqCkXy3AeG/Cym8cN4tvMaepbMKzpD1dc3t++354xMiCnIt2OCgmNn5k9P1etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289849; c=relaxed/simple;
	bh=MUAaVbY8hAyvVomzkTkUV8mACB46mqqy2aCXtcMPy5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaRXWd6F/dKEHnUOV2d+IgO80KEUjBNC79S+Ey9kzj8L8FnP3+C1ls7U72F1R9Pv9NT/m9AodKmSnQHoBuA3JbLDwm3iv+ruIy9d4LLdpYA/0QiXeBYDiB4sO0ovHjNxIpqSpizDIx2z+SwSus744tEy6Fw2BEIxJVV4ItCaD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MPJrHvWj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709289841;
	bh=MUAaVbY8hAyvVomzkTkUV8mACB46mqqy2aCXtcMPy5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MPJrHvWj27FyYmFtlNzCAC9IF1vERym2/2E4qPc/ctFzuw/IF9LDbsFJBVYKgtMBh
	 EidQ6WxQrMcY67kP7Oq2pUSHSzgh+avv+jTPbzbUMYeML6jyMtcWj9e/Ub54kD3j+8
	 Zgvde3WCYXV7+qFpCJfJYneuLc/X/XjrJO4VIqAu6AmUL0ZWO9/DOc3Y2Ifx9kyqeg
	 yRFlHrjqXoqBHxxODj6cSWmmnT8Db5HR7q9tJJHOI5QgSLiMXAu+59KvuAK9mSsW5q
	 hBi3uA9cQ1ZAdEgNpa+QcKFIYrUx1HcbaiH/gDutgOcbJZvUUDaKdtdUTmZ7Rh9lAk
	 Uu5h/zAnI2Ziw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmPpS1gQQz4wc6;
	Fri,  1 Mar 2024 21:44:00 +1100 (AEDT)
Date: Fri, 1 Mar 2024 21:43:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gow <davidgow@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins
 <brendanhiggins@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel
 Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kunit-next tree
Message-ID: <20240301214358.7fdecd66@canb.auug.org.au>
In-Reply-To: <CABVgOSmAmkOcY8hFnpPSgz5WZXFkez_BDGhKjBepbWFpKykfUg@mail.gmail.com>
References: <20240229152653.09ecf771@canb.auug.org.au>
	<be2e812c-3898-4be8-8a9d-e221acb837c3@linuxfoundation.org>
	<CABVgOSmAmkOcY8hFnpPSgz5WZXFkez_BDGhKjBepbWFpKykfUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+X+ZUG0wlkgfO96g6gv/m6o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+X+ZUG0wlkgfO96g6gv/m6o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Mar 2024 15:15:02 +0800 David Gow <davidgow@google.com> wrote:
>
> On Thu, 29 Feb 2024 at 23:07, Shuah Khan <skhan@linuxfoundation.org> wrot=
e:
> >
> > I can carry the fix through kselftest kunit if it works
> > for all. =20
>=20
> I'm happy for this to go in with the KUnit changes if that's the best
> way to keep all of the printk formatting fixes together.

I am pretty sure that the proper fix has been applied to the drm-fixes
tree today (in the merge of the drm-misc-fixes tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/+X+ZUG0wlkgfO96g6gv/m6o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhsW4ACgkQAVBC80lX
0Gz+Bwf/X7n+m/wDZxSYLCDkltJK1RqNF4UBMU+iiqKNsABv/hmcAecGfGZlCunX
9ASSYnaS1Mor0rsVyFmPxZwaGGcTIFhjc4NU97YDUh83F5U/CX5Sr8d4o3eHDWws
y/4xmpH/1eEmvqdUJWu4xb9srmcZg1obZCQ6ZtlwMfgvTt03sTBDmp8PZk2rpKOy
hnSJ1PSatQX+ABzWA5wWhDHtId3NYgZ5eLwyeCWx8DAQ+sTREXNvToHz18+ZEA9c
EIemv6cZivH8WiauOLqmh8ED1MKApeQUenHf46aLzxBGK6EwNFZXaxIMrHDC07nN
l41OgA40LcOAR0Kve6FwmRoeSXwKyQ==
=jdxI
-----END PGP SIGNATURE-----

--Sig_/+X+ZUG0wlkgfO96g6gv/m6o--

