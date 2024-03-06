Return-Path: <linux-kernel+bounces-94673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A888742EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A87B23088
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969791BC4B;
	Wed,  6 Mar 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkwYtSyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDB1C6A1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765068; cv=none; b=XXUE/NuUkfsFyAmOOGdxxuAu6Dqv9iSp+p7G5H+zMTX8/ohP3N50TIH657RVBc7P3RqW15tri2sCIAr/HWl3SSHCSL3/5eDAHKnFr9hrg0dH1E4u9wistG0AvgrpqhSE+DkV1RUprwend/rr67Yn+v/r4J2cGOwFgvVpF/kup+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765068; c=relaxed/simple;
	bh=a2UX1TpwzNRrKOHg66g1kPeFUJh/I+u22ob6piRQG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjvGszMAAU8acVIu7bI/hFyh98AxwZ45+jGbbVCa2KUqalpjiNpgmwK2u11yMyzEaWHcynT2BBsnHFPAin0SJqnokUJbBUN/mtvVKmbKiP108v7l9wIOKo6KXgr1SoQZfZsrmXZbYtN23HOELPzsyfzBzGAJ92OZIonCmxwS8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkwYtSyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F9CC433F1;
	Wed,  6 Mar 2024 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709765068;
	bh=a2UX1TpwzNRrKOHg66g1kPeFUJh/I+u22ob6piRQG9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkwYtSyw32aIKJNqnwoBbEZaBt0BUqa3ca2bQmMOmEMbL3jEa6uvnU+WAWdv3rDCU
	 9lT/B70s1dObC5AbkAGDZQ3gJVBRFTpMvHfbcs6bUsOqShhT5FcAUmhOcGmFKITQ6J
	 VPPNXVzZnVMUTJFKdXdfph1ecRbNo+Cf06brNjxtVM69mjESVY0rW8IMA5fcK3mH+l
	 Tv+Gln/jejj3RO3mw2QNu3nN+xqD1DbjWFdx0Rhgle4BI8W9UeFKWtOZMNYQbRsV0A
	 H8ThdlpDyi+mbFML5vWBgC41MZNoln38yn9lCzoK00WqAHFDSbLVIu8+I5sDMQd4Yg
	 eknYNuiWRnbSg==
Date: Wed, 6 Mar 2024 22:44:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Dave Martin <dave.martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Message-ID: <b734ea8c-af4c-4dc2-8d96-2f08d3d780ea@sirena.org.uk>
References: <20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org>
 <Zei7-0RMCpiWw49e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wIiEGiyPO53cvUgL"
Content-Disposition: inline
In-Reply-To: <Zei7-0RMCpiWw49e@arm.com>
X-Cookie: Have at you!


--wIiEGiyPO53cvUgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 06:54:51PM +0000, Catalin Marinas wrote:
> On Mon, Jan 22, 2024 at 07:42:14PM +0000, Mark Brown wrote:

> > This indicates that there should be some useful benefit from reducing t=
he
> > number of SVE access traps for blocking system calls like we did for non
> > blocking system calls in commit 8c845e273104 ("arm64/sve: Leave SVE ena=
bled
> > on syscall if we don't context switch"). Let's do this by counting the
> > number of times we have loaded FPSIMD only register state for SVE tasks
> > and only disabling traps after some number of times, otherwise leaving
> > traps disabled and flushing the non-shared register state like we would=
 on
> > trap.

> It looks like some people complain about SVE being disabled, though I
> assume this is for kernels prior to 6.2 and commit 8c845e273104
> ("arm64/sve: Leave SVE enabled on syscall if we don't context switch"):

> https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1999551/comments/52

Yes, from a user perspective this is a case where they're running what
they see as a perfectly standard instruction and finding that it might
take thousands of cycles longer than you'd expect it to while we take a
trip through EL1.  If this happens frequently then it becomes much
harder to justify using SVE, especially for things that run for a short
time or which don't have an overwhelming performance advantage over a
non-SVE implementation.

> I assume we may see the other camp complaining about the additional
> state saving on context switch.

Yes, in the case where things get preempted that's an issue for tasks
that are mostly FPSIMD only otherwise we'd be better off just never
disabling SVE after it's been enabled and we had to allocate the
storage.

> Anyway, I don't see why we should treat blocking syscalls differently
> from non-blocking ones (addressed by the commit above). I guess the
> difference is that one goes through a context switch but, from a user
> perspective, it's still a syscall. The SVE state is expected to be
> discarded and there may be a preference for avoiding the subsequent
> fault.

To me this is purely about the fault behaviour, the fact that this is
related to the state saving/loading is more of an implementation detail
than=20

> > I pulled 64 out of thin air for the number of flushes to do, there is
> > doubtless room for tuning here. Ideally we would be able to tell if the
> > task is actually using SVE but without using performance counters (which
> > would be substantial work) we can't currently tell. I picked the number
> > because so many of the tasks using SVE used it so frequently.

> So I wonder whether we should make the timeout disabling behaviour the
> same for both blocking and non-blocking syscalls. IOW, ignore the
> context switching aspect. Every X number of returns, disable SVE
> irrespective of whether it was context switched or not. Or, if the
> number of returns has a variation in time, just use a jiffy (or other
> time based figure), it would time out in the same way for all types of
> workloads.

I think of those approaches a time based one seems more appealing -
we're basically just using the number of times we needed to reload the
state as a proxy for "has been running for a while" here since it's
information that's readily to hand.  It would penalize tasks that spend
a lot of time blocked.

I'd still be inclined to only actually check when loading the state
simply because otherwise you can't avoid the overhead by doing something
like pinning your sensitive task to a CPU so it never gets scheduled
away which seems like a reasonable thing to optimise for.  That would
mean a task that is only ever context switched through preemption would
never drop SVE state but I think that if your task is using that much
CPU the cost of saving the extra state on context switch is kind of in
the noise.

--wIiEGiyPO53cvUgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXo8ccACgkQJNaLcl1U
h9Chkgf+KgmqB2YYVHrDMVzjg4E5AitT19Z1A5tgiTtVSBf/Ns4VcBGUBcJkQisT
/JtSIjP1/rfOOh4A5vyqQ33U9MO96/ZG2jtzyuWJHcqGADJU+5QM59l7pOffQhIv
onso5OXaRATktbFwk410kBzJdHwRu7gAWAqBuk7yald3iz/eeMDn7331w1pTwPTu
bLG3ofEyZioMbveDJ6to+5smMT/6rIKD9lSnYvg5+qpvURs06r6AYKDIaARR383Q
itMhGRgHq9U2xlp4yR1K8z0ANpNinRWem/L6VuqS1svrCF2oMcicnQ8OauooXba4
naho8Phpynq0g5tCHCxCQiZ1IuhWGg==
=QnM7
-----END PGP SIGNATURE-----

--wIiEGiyPO53cvUgL--

