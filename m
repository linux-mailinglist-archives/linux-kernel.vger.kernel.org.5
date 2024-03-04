Return-Path: <linux-kernel+bounces-90713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3488703BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F75AB21A99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90953FB1C;
	Mon,  4 Mar 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVKjIS5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E583FB0F;
	Mon,  4 Mar 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561485; cv=none; b=qY66+8a2oL7vLlKJiVuKb409cykPiUaeJ/zwtWUUhQNGa6miZUO4VuFTF3bxISQRa2gD28ymaZ9u/EsWKq9CzMOGnO/2u4/nkS0oSuNDuHn2YIv3mEtG44pvzOrx1F6oAYZbirW61trvZbeg3CV0FityvSBC6szR30U2es+/jNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561485; c=relaxed/simple;
	bh=4qkqdnC5JCKu1qMrA7/8TvywV+K8nU+gGRgycU+OSEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdSshjm6PJ645wCCSuwBuWKydA8nWGA0TbX3ESpudZ929c5uFNfppjkaqAIgCSYHpnRhl2l09Iwaekr63sovBeBCqfDVSk9HXtbmRA12kZRU63UHlauJsTo46N47xe1L4EvTDuWeM588OCc3DMP4wtuRNn0xXamOIa/UVEd1n+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVKjIS5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F0C433C7;
	Mon,  4 Mar 2024 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709561484;
	bh=4qkqdnC5JCKu1qMrA7/8TvywV+K8nU+gGRgycU+OSEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVKjIS5CQPUIFdzhkJEEfbSeD2napSrNcHoqx7djKRhgYy8B3S0/n9cg9tMxss57Q
	 ZHtjeDs4DV7AjxJCZEwU7EwgdeyZ4D5Ma6+9QApqtnGKr14oMkC4COnURu2r10ISX+
	 Q+lYfUysf8Mv0O7jnukKzJVibVjFyur0tc9CSq7BGdnIi6Vbfgm5TK98z3j1dcw7RF
	 WMEg3pcU8cck3s+oVjq35AOfNvadp5yDrVlo0G619Yb2eWSuAUSZIGuOD8t65Zo4XO
	 eUgrfLJcH35RCVzpS86hB8fu8cE8ukbYwUjWCR5lxxOZyZ7ndYS0bh7XvcYMK0jq2U
	 F7hkcfkAnQ2uQ==
Date: Mon, 4 Mar 2024 14:11:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Only save S1PIE registers when dirty
Message-ID: <50c5cdd2-fceb-44c4-aff1-dc98180161a1@sirena.org.uk>
References: <20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org>
 <ZeItTLQxdxxICw01@linux.dev>
 <562f5e62-c26c-41d9-9ab9-aac02c91c7ae@sirena.org.uk>
 <86zfvh0vy5.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cctRBvfI3WDSvlur"
Content-Disposition: inline
In-Reply-To: <86zfvh0vy5.wl-maz@kernel.org>
X-Cookie: He who hesitates is last.


--cctRBvfI3WDSvlur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 02, 2024 at 10:28:18AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Mar 01, 2024 at 07:32:28PM +0000, Oliver Upton wrote:

> > > The overheads of guest exits are extremely configuration dependent, and
> > > on VHE the save/restore of EL1 state happens at vcpu_load() / vcpu_put()
> > > rather than every exit. There isn't a whole lot KVM can do to lessen the
> > > blow of sharing EL1 in the nVHE configuration.

> > > Looking a bit further out, the cost of traps will be dramatically higher
> > > when running as a guest hypervisor, so we'd want to avoid them if
> > > possible...

> > Indeed, but OTOH I got some complaints about adding more system register

> Complains from whom? I can't see anything in my inbox, so it my
> conclusion that these "issues" are not serious enough to be publicly
> mentioned.

This was you saying that adding more registers to be context switched
here needed special explanation, rather than just being the default and
generally unremarkable place to put context switching of registers for
EL0/1.

> If anything, I'm actually minded to remove existing instances of this
> stupid trapping, such as PAuth, which is entirely pointless.

That one was part of why it appeared that this sort of thing was what
you were asking for.  Especially given that there's nothing I can see
explaining why this would be deferred it's really unclear, I'd expect it
to be likely that those registers will be quite frequently accessed if
pointer authentication is in use.  Either it needs more explanation of
why it's special or it does seem like it should be removed.

--cctRBvfI3WDSvlur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXl1oYACgkQJNaLcl1U
h9Bxhwf9H0fdcBwZ1Dv0xGnPekH29kMx6tmaWXKPFQ4jBbmSiUuwkyfZR0dfRiRF
HU3MTaJelMwXN3sv2aFNF6obe0ftM2OPLUa6Tp7mUbBM2Hx7FLBgpA1iG1uXjrLS
gSYk2OfggzWJcxkAT9agSNAKuBTX6LorOD4B362KzZ6r6ah6H0sdL94YVLk2hOnd
nA3J+bibVC1hNTZ/WK7kx4TKcQzDme5dwkrpkU1WKo6pVLqxT9v0J0NbOtaX422x
zcxRGNlEU10j7t1aJMz8p9nNhja7qY8nD0UtAhGFUeL6hJ9oqfrZ9q8bqRIlgVX4
tL8PkznbMxZkZadkS+mAa8x2HMN+sg==
=8t3C
-----END PGP SIGNATURE-----

--cctRBvfI3WDSvlur--

