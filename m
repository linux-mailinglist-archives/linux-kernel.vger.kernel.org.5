Return-Path: <linux-kernel+bounces-67043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C728856540
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B32C1F29A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D9131E25;
	Thu, 15 Feb 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzl+ntlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AC130E40;
	Thu, 15 Feb 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005719; cv=none; b=jn0BHbRLDV8+VELwKLAIv+F5Pciib5+VpQIDYPKsVbWhTldACOoFhzoiVOShB6YuKc9JkeX7LgI73g13L3KB1SjcpGp5tE36VE1HFUeZVCceUqvJOg/XgakNceN/O+FdezELnI+LpVkPXK/1AxoZFnl9lDECmxE3I623s/KDxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005719; c=relaxed/simple;
	bh=bLg41PBwIDfC4cOMyvGi417/i5cujID83zbmEWIwlIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlxoemJbP3zd+szDEpkuYST20RbiSnkGo5vGvrl8zQ888GS48+difW3FcfV3nX+6XphyH+lEunn97NvYIk+k8OHAVuRw0XdYa2WbjmyrpubIgE0C4ykcuphoBdbR76h2dz2jxcVwzLBBhA0+LjyinQZ9dTPcratQBlwhmeDer9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzl+ntlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6713C433F1;
	Thu, 15 Feb 2024 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708005719;
	bh=bLg41PBwIDfC4cOMyvGi417/i5cujID83zbmEWIwlIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fzl+ntlYyRi/vtCED9/HzdjjUKeMuLr9Xu3bOqrjQ5gWQIM4YQ/D9HvtIVwT1LquD
	 lRSotN4e6LZO7GdACZBD7qw95AA985TpebHFOL7Hv4ozL0zXnkzq772LDollgNmgTC
	 FoG+w5AZlRJaSLuqCig0fykzd7jDyjGHa4VFwKEltF7TlZnPJCehNdNm4aOy2LLoyO
	 cnCxuUTUl9IxPdRIIuR1oSuflBUmLySWf2kKVGLDPRlDRwfhCyr00V51ZxdGtphzUI
	 vlQl0YVDLzs4SzH/FHM3ZfJQABlIly8uolOh3rSIqbceXeLlaThopuCq4l+2ZW3gkj
	 JO9aBgk9l/VnQ==
Date: Thu, 15 Feb 2024 15:01:55 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
Message-ID: <Zc4ZU0BsXkVgFZ3p@lore-desk>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
 <87v86qc4qd.fsf@toke.dk>
 <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
 <Zc4Tht2TAkFOhq9Y@lore-desk>
 <15766d46-162c-4c99-84a0-7a4bc60c3289@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MN2cs1CvNJYC3dkc"
Content-Disposition: inline
In-Reply-To: <15766d46-162c-4c99-84a0-7a4bc60c3289@intel.com>


--MN2cs1CvNJYC3dkc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Thu, 15 Feb 2024 14:37:10 +0100
>=20
> >> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> >> Date: Thu, 15 Feb 2024 13:05:30 +0100
> >>
> >>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> >>>
> >>>> Now that direct recycling is performed basing on pool->cpuid when se=
t,
> >>>> memory leaks are possible:
> >>>>
> >>>> 1. A pool is destroyed.
> >>>> 2. Alloc cache is emptied (it's done only once).
> >>>> 3. pool->cpuid is still set.
> >>>> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
> >>>> 5. Now alloc cache is not empty, but it won't ever be freed.
> >>>
> >>> Did you actually manage to trigger this? pool->cpuid is only set for =
the
> >>> system page pool instance which is never destroyed; so this seems a v=
ery
> >>> theoretical concern?
> >>
> >> To both Lorenzo and Toke:
> >>
> >> Yes, system page pools are never destroyed, but we might latter use
> >> cpuid in non-persistent PPs. Then there will be memory leaks.
> >> I was able to trigger this by creating bpf/test_run page_pools with the
> >> cpuid set to test direct recycling of live frames.
> >=20
> > what about avoiding the page to be destroyed int this case? I do not li=
ke the
>=20
> I think I didn't get what you wanted to say here :s

My assumption here was cpuid will be set just system page_pool so it is jus=
t a
matter of not running page_pool_destroy for them. Anyway in the future we c=
ould
allow to set cpuid even for non-system page_pool if the pool is linked to a
given rx-queue and the queue is pinned to a given cpu.

Regards,
Lorenzo

>=20
> Rewriting cpuid doesn't introduce any new checks on hotpath. Destroying
> the pool is slowpath and we shouldn't hurt hotpath to handle it.
>=20
> > idea of overwriting the cpuid field for it.
>=20
> We also overwrite pp->p.napi field a couple lines below. It happens only
> when destroying the pool, we don't care about the fields at this point.
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> >>
> >>>
> >>> I guess we could still do this in case we find other uses for setting
> >>> the cpuid; I don't think the addition of the READ_ONCE() will have any
> >>> measurable overhead on the common arches?
> >>
> >> READ_ONCE() is cheap, but I thought it's worth mentioning in the
> >> commitmsg anyway :)
> >>
> >>>
> >>> -Toke
>=20
> Thanks,
> Olek

--MN2cs1CvNJYC3dkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc4ZUwAKCRA6cBh0uS2t
rIttAP9o5h37WPKS26lffxdmH29qGnoV/x0d8qqUkHSo3YRIyAD+MTT6z4V3J8bb
fhu+Znf8NbyvyQVE13nMFnBjRxKKBw8=
=bjmB
-----END PGP SIGNATURE-----

--MN2cs1CvNJYC3dkc--

