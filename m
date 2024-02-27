Return-Path: <linux-kernel+bounces-83595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62B869C08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550BE28D8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE68149E03;
	Tue, 27 Feb 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik/9Iehb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5582149DF3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051150; cv=none; b=SK4ApVVLoTiMvQGMmRpjHnamqMFYjTVYe1mREzV8vilPw5mBLnfFFsIsvNuHUjCG8PWuhJe92szC/C9RXkh6fEOmKOa3uHdYnWz5FEsVbiAWyHKK9ccu1bRwEoXrbvDietSfaD5a0FYmsWuUlaBgdEbaA1XsbNSxE+11ePtvcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051150; c=relaxed/simple;
	bh=TwJ9tw8RWadZtfx4XZWclfYeDuU89AP3djIFCqgZk40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn0UtFSq7MktMCSqQRiKeDXENv4qXAJN2SUfEbkL9621ZX840VLjLv7kvDZQ2mOJICSWzjMjNzgKQxVjfDIeGaAsLdLNsO+i6X9m13xHJUm+FvpHWwaainC3MWQ65Ocko7IHT9xHKvkIOTewHBka5ULxoMZBCapmKfs+YcxKlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik/9Iehb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE0C43399;
	Tue, 27 Feb 2024 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051149;
	bh=TwJ9tw8RWadZtfx4XZWclfYeDuU89AP3djIFCqgZk40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik/9IehbG84rkjbsM5IKBay6L4asRtyIK4hohM7bYF3vPGWRIc/LE9UKE+TOFn2tk
	 1kJnMqtDn+rkouzMM0wQE5oe9HRfYziMnJgBGOX3S8a8eF3gFxjoWv4w+VgXI+uGUx
	 4ru9K6aoSr48GcjpkImtai8/Pr03xu8nWsG5e5jS6nEicdf66OHVqf7DkggcarTZ9Y
	 dxhPPLigcjpBP+2WJlVTDTM2YzZXpZ+z2+VaV3OwjgE+Cc+31tmaz3+UCzlMR22v6o
	 pHKIAgHUnJGuYnpolm7wUmg9Sm0AaC+Kf8WqoTS/moInSvSZrADJYUF9VJcZgusDnU
	 QYCclljk7i4yg==
Date: Tue, 27 Feb 2024 17:25:46 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/test/shmem: set a DMA mask for the mock device
Message-ID: <ut2c26ig4e6pbtvszmfm34h4ev3oflwkz3mwkjtqaxlpethwfk@w3bnhg4iw4mn>
References: <20240226110028.28009-1-marpagan@redhat.com>
 <d65v7jy4natx22lacw6awmg6iecfr2hqk3puuz3qem5dfsvj2x@hh6vp265hm5p>
 <03915b45-94f6-4863-8b11-d0e9dbd0283a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tlwdh5nyakxrjjyg"
Content-Disposition: inline
In-Reply-To: <03915b45-94f6-4863-8b11-d0e9dbd0283a@redhat.com>


--tlwdh5nyakxrjjyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 04:48:51PM +0100, Marco Pagani wrote:
>=20
> On 2024-02-26 12:26, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Mon, Feb 26, 2024 at 12:00:27PM +0100, Marco Pagani wrote:
> >> Set a DMA mask for the mock device to avoid warnings generated in
> >> dma_map_sgtable().
> >>
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >=20
> > I've submitted last week this patch:
> > https://lore.kernel.org/all/20240221125324.718192-1-mripard@kernel.org/
> >=20
> > Which should be equivalent, but fixes the issue for all users in the
> > tree.
>=20
> Hi, thanks for letting me know. Fixing this issue for all DRM tests that =
were
> using platform devices through the helpers makes perfect sense to me. I'm=
 a
> little more thoughtful about setting the mask for all KUnit tests that us=
e fake
> devices since there may be specific use cases. Just one curiosity: why se=
tting
> the default mask manually instead of using one of the dma_set_*() functio=
ns?

I think the (well, mine at least) expectation is that a kunit device is
a device that can be used in all reasonable contexts. Setting up the
device to be able to use any DMA-related function (or functions that use
a DMA-related function) makes total sense to me.

But it's a discussion worth having I think, so it would make sense to
raise this point with the kunit maintainers if you feel like it.

Maxime

--tlwdh5nyakxrjjyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZd4NCgAKCRDj7w1vZxhR
xZ4CAQCcNmBJJDTGi+MxZl1jfrDVmne9K9B9qaLLqBPB1CQWNgEAiFN54hD4kHil
62wFp/FuTUoo21Ua0wrq3nbEqpU+1Qg=
=Y9s/
-----END PGP SIGNATURE-----

--tlwdh5nyakxrjjyg--

