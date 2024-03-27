Return-Path: <linux-kernel+bounces-121363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB888E6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B921C2C59E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86DE1386D5;
	Wed, 27 Mar 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4cYrqgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED812AAC3;
	Wed, 27 Mar 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546052; cv=none; b=rcxw3woJKrqZConO5pZhjM+icaYGmFWPaO52LYvYKZuaPvj0qO2sbHtWokg2mTd695el3Q/OnlPcfDYfIeQ2xY3x6zy1YSjWw4riaBvPj1DmcWeDPQGbeKZFRMD+7kZBR4fH0p21Rsi7mGgl4xGKqQXsnvwV8RWbA1qP2NzAjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546052; c=relaxed/simple;
	bh=+fnPEP5LofR/YkwTOOjws1iuVa2ieMZ1vJLvtYNQ7OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0gZNxTGWFaD0R6LGH5xYQvHD3PiAG+Wwz6tlVoe9ewcKhadzONDa1vZ5uo5wJIYAqdO/Cu+8ln1SLqQQg3299TUccLQbaU+BoRWbxoMZd5FJuDM6COk+vDO0OA44JKzqiWjJJiCV4qLUI/tB1YIA+tPKhuETMsbCVM6slhkkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4cYrqgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527BDC433C7;
	Wed, 27 Mar 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711546051;
	bh=+fnPEP5LofR/YkwTOOjws1iuVa2ieMZ1vJLvtYNQ7OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4cYrqgkZ5yR7qOyVmXAK6DNicMANTj9MoO3Ly2aMyd9olFbTRqMM410U7a1HbqBF
	 BBGyKztQYn+jgZ0gMdHhmWE/CQLavoPNnnA77UiTkS+Jingwh7g5AVE4tP4G4e+WFy
	 azkgCGC3Mk8wbHHnbmmKObNlVP5pDWzqdhqh+HAXPE8o+1l+Hlu8tswxiaVM1Ul+v3
	 UZIRARydgHnI7ECFVslwev4AIl3+vH0o85jzBa4zAD8XNfd936b14q//9bEplTNQEs
	 DOK3S7d/FoKpW3V3bjlb0IdnyLScR5VwaGAJ1kq+XFnDpPAL50yEJQi08FswygCuFA
	 RH7g1qmxJ7Dxw==
Date: Wed, 27 Mar 2024 14:27:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Constantino <dreaming.about.electric.sheep@gmail.com>, 
	1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi, tzimmermann@suse.de, 
	virtualization@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Message-ID: <20240327-cuddly-smooth-trogon-59c02d@houat>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
 <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
 <db4c8e74-5c79-49be-9781-a5d8669eccc1@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="odhn7ryspel32gtq"
Content-Disposition: inline
In-Reply-To: <db4c8e74-5c79-49be-9781-a5d8669eccc1@leemhuis.info>


--odhn7ryspel32gtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 20, 2024 at 04:25:48PM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 08.03.24 02:08, Alex Constantino wrote:
> > Fix OOM scenario by doing multiple notifications to the OOM handler thr=
ough
> > a busy wait logic.
> > Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") w=
ould
> > result in a '[TTM] Buffer eviction failed' exception whenever it reache=
d a
> > timeout.
> >=20
> > Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> > Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e=
402b9af@leemhuis.info
> > Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
> > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1054514
> > Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.co=
m>
> > ---
> >  drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> Hey Dave and Gerd as well as Thomas, Maarten and Maxime (the latter two
> I just added to the CC), it seems to me this regression fix did not
> maybe any progress since it was posted. Did I miss something, is it just
> "we are busy with the merge window", or is there some other a reason?
> Just wondering, I just saw someone on a Fedora IRC channel complaining
> about the regression, that's why I'm asking. Would be really good to
> finally get this resolved...

I've ping'd Gerd last week about it, but he couldn't remember the
details of why that patch was warranted in the first place.

If it works, I'd prefer to revert the original patch that we know used
to work instead of coming up with some less proven logic, which seems to
be quite different to what it used to be.

Alex, could you try reverting 5a838e5d5825c85556011478abde708251cc0776
and letting us know the result?

Thanks!
Maxime

--odhn7ryspel32gtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZgQeuAAKCRAnX84Zoj2+
dtzBAX9D2qc3cRTI5gt0TJbZn+B1KZluieFl8m0F3A4+AMDS3Evkhqnpw13peeHP
19X3+xUBgN+7f0zhgWoJGzvnglkgra50VOoD9JZHUkmxpgZHXMavpspIDYDdwpKe
xEgQ8lSVDQ==
=4Ivy
-----END PGP SIGNATURE-----

--odhn7ryspel32gtq--

