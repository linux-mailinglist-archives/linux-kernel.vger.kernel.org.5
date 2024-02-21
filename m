Return-Path: <linux-kernel+bounces-74145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548685D06D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C811C22645
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087243CF5D;
	Wed, 21 Feb 2024 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tjD4s9aj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97E3A27E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496486; cv=none; b=gx7yX/v/W1XiF8MHuTRS0EikoafrTi9IJ+vjBw64WJKnXYQdjDfatgnFvNRN+2dBYy2QfzXlD/JhT6PdvjZ0hZm27qrRze63kj94XUyU2m+8iTz18/vjdVIs9Mm7llLrevR4fmU4RzqrG2cgd40cxTLoJsWx7ZyjJaV1agu9C8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496486; c=relaxed/simple;
	bh=gX7KHInciv38nM5PUIPyHqMHG5OywB5O7Caz0hTTrT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiykzD6sYuYCir6kU79+5RZs1HFy9T7ze3k03Q+EbiNskXIn5V+6DTEWbSKUo+2F19xvHrIP5g/2JEuGG4WqUgy7K4Pi40jFozQD227Ay7JroazLJdrz7M4OFfFyk2K18ASuVjFFcEy7/RjXniSRHmDE8zheQ8dcSKaDDO/NoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tjD4s9aj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708496480;
	bh=nKyibOl+ZTy1QoSmUoL2WccZoRzifYwx7mjfckl50Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjD4s9ajy9eOvP4VzHG1NvjHeEv01xDnOauj9fCN81zKBfAxAxanPFi0UifA+WID4
	 CX6X8p6me6Wt6y5pkOjiTK0DidBcyEnsYvJaK+Qe+zjZxyUmmcUtcxwBogsHtdNG/p
	 Eg8KfD0L7IrGJlgPERDzkocm8Cmyl3+o/PwHro9inAlnwtUFPTK69zoeq5X20JgNBS
	 vBYoQlxLJ0jF/E99W1s19/pjR0kEbOEEvSuj3You4lFF46/37017TNdl2ZQUUJkJP2
	 dRaFwqb3QLB4F5tnCULCKAqoakNOo9mRulcUII7UIqd6tcHb1j16HYiKpiaQ7kaBEu
	 Ko+CecGFPbvEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfmPV0zt5z4wby;
	Wed, 21 Feb 2024 17:21:17 +1100 (AEDT)
Date: Wed, 21 Feb 2024 17:21:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>, Oded Gabbay
 <ogabbay@kernel.org>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Daniele
 Ceraolo Spurio" <daniele.ceraolospurio@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: skip building debugfs code for
 CONFIG_DEBUG_FS=n
Message-ID: <20240221172117.243799cf@canb.auug.org.au>
In-Reply-To: <ngu6vq5izal6suyr57p4vlxnrn4kxyii4ewdktxvw7k3uezlcz@6oevav3wpcjh>
References: <20240213134817.3347574-1-arnd@kernel.org>
	<877cj88lck.fsf@intel.com>
	<17209419-093b-4674-8b43-06c92312ef61@app.fastmail.com>
	<ngu6vq5izal6suyr57p4vlxnrn4kxyii4ewdktxvw7k3uezlcz@6oevav3wpcjh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F5A94gSepNQOsNsZBCFEmzQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F5A94gSepNQOsNsZBCFEmzQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Tue, 20 Feb 2024 23:29:54 -0600 Lucas De Marchi <lucas.demarchi@intel.co=
m> wrote:
>=20
> Looking at https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git/commit/?id=3D2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
> it seems we still don't have drm-xe-next branch in linux-next.
>=20
> Stephen, could you please add it? Or do I have to do something on my end
> before that?  This is the branch:
>=20
> https://gitlab.freedesktop.org/drm/xe/kernel drm-xe-next

Added from tomorrow.  Currently the only contact is yourself.  Do you
want anyone else (or a mailing list) as well?

Do you want the drm-xe-fixes branch included as well?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/F5A94gSepNQOsNsZBCFEmzQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVll0ACgkQAVBC80lX
0GwELQf/Q/n3K4HqKLq39MDQhZAAJUBm1YxvwNnirZMlCmqiK66yOw8Mt0c3ThO4
c61KtjDLov3dlY8sJ5Ho+E4j2z4Q62GPf+dIwwFaSTrNDg57qhBfo9J00ioJur2n
jzIF+kR38PSXCvIsblWTjV7GpGgp6fTLhULvVXnxs9Dc20NomGmaEtiyiN5M4kt0
tMYge3qsrS4d2CPy3wkDlSCWjrc4paWLwmTmZ2Uf+PlyAdgPtIzlvAz2uAGr6hFQ
oIN+q++HxtJExWkQuFhZU2QwjAVRHJXYblDtQdu5ePuj2wckNnRTWHX8ldHkNdSF
/BsXRvfeQCBnd1jkkTz0zyprAVdF0Q==
=K4kr
-----END PGP SIGNATURE-----

--Sig_/F5A94gSepNQOsNsZBCFEmzQ--

