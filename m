Return-Path: <linux-kernel+bounces-90935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBEF8706FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F77B21EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0214C634;
	Mon,  4 Mar 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1re9V+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224B482E2;
	Mon,  4 Mar 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569647; cv=none; b=SUEWiS+f1qgGx43mkAMIfWImFKUoroFAUkk4rwXDf2uW7lcEdar8TvS88Eg7M3hV7gFltmKaLEBBB9E/VUiis3glcsF5n1ay475Irvz7cgejc0LZcAVWXP5qEIr9QQR20d3C0tknLaWtLs6stPbzZelr5WXydxWC3Lp/CfToO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569647; c=relaxed/simple;
	bh=2Jb1vJn/xYd7ULjthjMCdzuXihA6/Atrjilwen7AQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOnC1NVtA8EGizvkCjcaefpJvCXMH2gkQ0oGptbPE4wKP2MrYz7eB4JytYLt30AL93gh7N4lkxAifejVUM/I6acHA5lWsKhnaooGKpBdHkRw9r67q8xikgZWlPV3b56TRA1tdcPcT4MZEyoz8CyOCS5od2z4XnuqT05ZTn1pcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1re9V+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E20CC433F1;
	Mon,  4 Mar 2024 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569647;
	bh=2Jb1vJn/xYd7ULjthjMCdzuXihA6/Atrjilwen7AQxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1re9V+kLVa6vGXJr3cQ/AT+HPrCsQDzi+BnkaaLsI+cie6mitgKvdT5y0Rw8UozW
	 3yIJwOCzVhXDC6amqPHXPdBWMRTzPF6KAFTH/FVd3G8RQMs/X/MY/zoXI7/ASuW7j/
	 9NPris8PYQIVlK0AojJKd7PavJvU25wsmgkBr1sbO6oG17Zd4+qtpwEjcxiEw8vxHp
	 QvVyjgK7KkVyj3IHHhVQTdsy4khskiUgz3HcX+66mxQTBfmcV7Dvyg17SUYmYtGh9p
	 qS/GUqUxCINUHv7Ds5CJZ0R7VVncTQOrmXpJFxIkQT17dWMoIH/Du31AlK3H7EBcB6
	 1FyUiki1hCupw==
Date: Mon, 4 Mar 2024 16:27:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: arm64: Reuse struct cpu_fp_state to track
 the guest FP state
Message-ID: <607a10e4-6678-4148-9d5e-ec030b742207@sirena.org.uk>
References: <20240229-kvm-arm64-group-fp-data-v2-0-276de0d550e8@kernel.org>
 <20240229-kvm-arm64-group-fp-data-v2-2-276de0d550e8@kernel.org>
 <86y1b027mc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D3tctJlyH4cuFut5"
Content-Disposition: inline
In-Reply-To: <86y1b027mc.wl-maz@kernel.org>
X-Cookie: He who hesitates is last.


--D3tctJlyH4cuFut5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 11:30:51AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > At present we store the various bits of floating point state individual=
ly
> > in struct kvm_vcpu_arch and construct a struct cpu_fp_state to share wi=
th
> > the host each time we exit the guest. Let's simplify this a little by
> > having a struct cpu_fp_state in the struct kvm_vcpu_arch and initialisi=
ng
> > this while initialising the guest.

> This structure is only useful to the physical CPU we run on, and does
> not capture anything that is related to the guest state. Why should it
> live in the vcpu structure, duplicating things we already have?

You were previously complaining that we were having to bind too much
floating point state each time we bind a guest to a CPU, the goal here
is to address this concern by filling in the structure at startup and
then reusing it.  As noted in the commit log given that this state
includes system registers there are difficulties in trying to rearrange
things so everything is in a single structure, I'm not sure that having
to special case the FP registers would be a win there. =20

> This is just making things even more opaque.

> If you need to add such a structure so that you can know what to
> save/restore on context switch, then attach it to the per-CPU data
> structure we already have.

I'm having a hard time understanding what you're thinking of here, this
is mainly about addressing whatever it is that's concering you but I'm
not sure I have a good handle on what that is other than just a general
concern that there's a lot of FP state which needs binding.  If we put
something in the per-CPU state without reorganising the data a lot it'll
look very similar to the code you were complaining about, the current
code is doing roughly what you suggest already.

Personally I'm not overly concerned about the current state of the
world and find it to be a reasonable tradeoff given what's going on,
this is trying to address your feedback.

--D3tctJlyH4cuFut5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXl9mkACgkQJNaLcl1U
h9BioAf+NfHQfn/tMxiACNNhF5eYbNjv53vdlckqwV5LSBzV/wXC/CjhKz/UJnaZ
1ewtyJ0dKGVdKWefX3V/gIl1tq1lpM6PBEVG2LrFIYj6NzF1cYn9LH0pFN+Icaey
cgZ9xPNOa2jImOVghBSxsedQ91CmJR2Z/Ye2IGU9ud+h1gs46/hhccE/PYhuggh/
/kt/GJVoSqJJncqUyBB/ETKSHgiJbJmiklNSg1RRAEKdd8zH62QABVlVeLf2XW+P
hJ3dN2GPJkqFae1ir9QLLD2eDb3iuFvsXr9PKmw8SN7ntOVyLq1JuLyG4mUeVAiM
qPGyqumFxtUakf5YFtKb8b7yea5vaA==
=1Ccq
-----END PGP SIGNATURE-----

--D3tctJlyH4cuFut5--

