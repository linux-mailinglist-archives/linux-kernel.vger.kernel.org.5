Return-Path: <linux-kernel+bounces-66995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5108564B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DB0B243F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59B130E24;
	Thu, 15 Feb 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1e/2dlz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012712FF7F;
	Thu, 15 Feb 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004234; cv=none; b=tMVHMT/pXj+zQc65LYji7SkUCkS+Jcwmw4IKOYAkrENY58dxbtTtr3pWTtkgCvOeD+Crs0mrz+b/Ux82I8zYVV8btj4KhxtrOhJvjKLlbh7+Xl/q7vuegTzpM7lemq9dDhal2yOvH6Orf1Lxb0zb5lC0c2hlD8JvKo3GMKEx4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004234; c=relaxed/simple;
	bh=PFVxtk7+DZ0DWAk3Wc+rdZQ+V9hnlPmccXAlqx5M7eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jND8xivFnD5gg0Yy0KodKllxWqDb2Bmtruk42LgYrPPkKQGZVdab8gvMQ1Fct3Bl5nSz+17dDtstr2EnsYe3CySbckdViNd7FRk+Ze1hOr0jf3PKSgL1Zqe6qDVlmuLCURgdIGS+EIabPMfibxLvcwTSfBhd4TvFuT1jeS2rlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1e/2dlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BCDC433C7;
	Thu, 15 Feb 2024 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004234;
	bh=PFVxtk7+DZ0DWAk3Wc+rdZQ+V9hnlPmccXAlqx5M7eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1e/2dlz+50J6jjmgBIN2URUTZmnc7ALcdTSep8FsCPgGRXiqVXjl56plOSsa/KNI
	 cqiE0wvyF9OIFjSYsjxZmyalEAo5zkmZxWEAgKH0rtMCmwutb5YOz8Ky/ieebDD7GD
	 lyp1UgYX/iJrdSFGDzzoo5Su0p0ucadd8TKNsp4Ybbxyc1ZuL6qNA6E6SzYzHyTtvf
	 tnQqhvjWIJgUdDkXfDzN67YkP16WScFIk3xKlo3+SQEQ5ZqaOc059N4Mruat2t5EcC
	 4nRILszRrDisu93gYIg/K45KMDHqWopKEneSp8qnYsDDw5Sy4e+Kv7bRZ6Y7TM1XNh
	 NQKGKhq+/dTNw==
Date: Thu, 15 Feb 2024 14:37:10 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
Message-ID: <Zc4Tht2TAkFOhq9Y@lore-desk>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
 <87v86qc4qd.fsf@toke.dk>
 <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JwdDwmzJQxeHUrty"
Content-Disposition: inline
In-Reply-To: <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>


--JwdDwmzJQxeHUrty
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> Date: Thu, 15 Feb 2024 13:05:30 +0100
>=20
> > Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> >=20
> >> Now that direct recycling is performed basing on pool->cpuid when set,
> >> memory leaks are possible:
> >>
> >> 1. A pool is destroyed.
> >> 2. Alloc cache is emptied (it's done only once).
> >> 3. pool->cpuid is still set.
> >> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
> >> 5. Now alloc cache is not empty, but it won't ever be freed.
> >=20
> > Did you actually manage to trigger this? pool->cpuid is only set for the
> > system page pool instance which is never destroyed; so this seems a very
> > theoretical concern?
>=20
> To both Lorenzo and Toke:
>=20
> Yes, system page pools are never destroyed, but we might latter use
> cpuid in non-persistent PPs. Then there will be memory leaks.
> I was able to trigger this by creating bpf/test_run page_pools with the
> cpuid set to test direct recycling of live frames.

what about avoiding the page to be destroyed int this case? I do not like t=
he
idea of overwriting the cpuid field for it.

Regards,
Lorenzo

>=20
> >=20
> > I guess we could still do this in case we find other uses for setting
> > the cpuid; I don't think the addition of the READ_ONCE() will have any
> > measurable overhead on the common arches?
>=20
> READ_ONCE() is cheap, but I thought it's worth mentioning in the
> commitmsg anyway :)
>=20
> >=20
> > -Toke
> >=20
>=20
> Thanks,
> Olek

--JwdDwmzJQxeHUrty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc4ThgAKCRA6cBh0uS2t
rMKzAQCWGs8izokKKobJ1o5bjr0dNcsLSO9pBKgU1pZJzetrwQEA6Vm0zCDsUzog
/Eh2aXqvy9gf0llzRVEpBYYSeLz0zgA=
=r6Tb
-----END PGP SIGNATURE-----

--JwdDwmzJQxeHUrty--

