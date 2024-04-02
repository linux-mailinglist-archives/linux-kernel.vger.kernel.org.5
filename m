Return-Path: <linux-kernel+bounces-128532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528CD895C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBCC1C2309F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAF15B553;
	Tue,  2 Apr 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYKQgqT2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E415B548
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084417; cv=none; b=X9pERJTi+egoisOOAkq3hnJl44W7s48joLZY5GAXQkDiHH+zeCOPyoslGNLksyBlFQysdMsiRl/TH70YUqbHKFTRcfRJnycNSGUEEsLr3fxgDSeKa3ptocsEN9BSuPCHt3jm8K5jyYSBn98QRLNaqqTlzpZ2Xp85Ss1zypR3c9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084417; c=relaxed/simple;
	bh=I0RjLeKvxJTLrh86G1bZ2yttPUGCTB1oUQj9pnfEm+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFGEChgoIPv/0AVxoWMklSqtqEJe5MJCF2Ovm1CJgCy0JzLxM1RSLv85RfQRx257w7Yrosc/jEJcZS/MGAvJ0rjHg6qw4+jp6g46oyeeXWP2B51Fe7v7akNIMG00C2wix9eVFk+Mi1I7XOlsBbSUUBZYpAu/RCvPbIPJQ7DzVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYKQgqT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8856C433C7;
	Tue,  2 Apr 2024 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712084417;
	bh=I0RjLeKvxJTLrh86G1bZ2yttPUGCTB1oUQj9pnfEm+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYKQgqT2kvfcKMG1DuFoeibTRhfGivOP9F98VlaH3zvgp7SEiO+nkdEGExuWblQP+
	 CAquClbZWAfAHAaNsmAdVze7WguRsOju4xBeGLguEt5H5muz3BiAD7epQsufkltdCq
	 eAjhhnix4qhAn/hh5wkJxXQeMlg3y5sU3ciZzRbdrVquZ7+AF647NxVQgtWiLOx5d6
	 XNFmgd3GqkKWsasutoCvmFrwgTSFAQHjKdoNntDUGCfCOrROa0dL9SQM1d6cEagNGd
	 U3nik7k7pXU1zkzQcezNGv+mgnXDy62qbGH5n17nKsor7sEjej0eMKDZGRqQ/sLuDu
	 rFXMRWWBRklpw==
Date: Tue, 2 Apr 2024 20:00:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Vineet Gupta <vineetg@rivosinc.com>, Will Deacon <will@kernel.org>,
	Andrew Waterman <andrew@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Dave Martin <Dave.Martin@arm.com>
Subject: Re: ARM SVE ABI: kernel dropping SVE/SME state on syscalls
Message-ID: <d78b800f-669c-4fa1-9e48-f01d69f08ae0@sirena.org.uk>
References: <bc21c53f-23b9-4596-b757-fc7707f91f24@rivosinc.com>
 <ZgxKXy6r0X7Whu5U@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YNznzJAAiYA0oAGE"
Content-Disposition: inline
In-Reply-To: <ZgxKXy6r0X7Whu5U@FVFF77S0Q05N>
X-Cookie: Knowledge is power.


--YNznzJAAiYA0oAGE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2024 at 07:11:43PM +0100, Mark Rutland wrote:
> On Wed, Mar 27, 2024 at 05:30:00PM -0700, Vineet Gupta wrote:

> > If I'm reading the arm64 code correctly, SVE state is unconditionally
> > (for any syscall whatsoever) dropped in following code path:

> > el0_svc
> >     fp_user_discard

Yes.

> Surely you *must* save/restore VTYPE in the signal frame? Otherwise the signal
> handler can't make any syscall whatsoever, or it's responsible for saving and
> restoring VTYPE in userspace, which doesn't seem right.

The signal handler would also be unable to use any instructions that
affect the vector state (we've got SVE based memcpy() implementations on
arm64...), and there would be issues with anything that returns to a
context other than the one where the signal was originally deliverered.

> > How do you guys handle this for SVE/SME ? One way would be to not do the
> > discard in rt_sigreturn codepath, but I don't see that - granted I'm not
> > too familiar with arch/arm64/*/**

> IIUC this works on arm64 because we'll save all the original state when we
> deliver the signal, then restore that state *after* entry to the rt_sigreturn()
> syscall.

Yes, that's it exactly.  All the process state including the SVE and SME
state is written into the signal frame along when the signal is
delivered, then on signal return we restore everything from the signal
frame overwriting any changes that happened while the signal handler was
running including the effects of entering the kernel to do the signal
return.

> > Other thing I wanted to ask is, have there been any perf implications of
> > this ABI decision: as in if this was other way around, userspace (and/or
> > compilers) could potentially leverage the fact that SVE/SME state would
> > still be valid past a syscall - and won't have to reload/resetup etc.

> I believe Mark Brown has made some changes recently to try to avoid some of
> that impact. He might be able to comment on that.

The optimisation work I've been doing has all been around avoiding
enabling traps when we discard the SVE state rather than to do with the
discarding of SVE state, the initial implementation for SVE disabled
traps very eagerly which wasn't ideal.

For arm64 our PCS specifies that the SVE specific state becomes unknown
over any standard function call, this means that any optimisation in
userspace that relied on state being preserved would need to be outside
the PCS which would be *relatively* niche though it's definitely
something that could be done especially for non-C code.  The advantage
is that we can stop saving and restoring the full SVE state for
processes that have stopped using SVE, avoiding overhead there.  The
kernel ABI basically models syscalls as C function calls, though it is
stricter in that it specifies the values after a syscall rather than
allowing them to be undefined which does impose a small performance
overhead.

Our SME ABI similarly follows the PCS for standard C functions.  Our
standard PCS for SME requires that functions be called with SME disabled
so when we exit streaming mode over syscall we're just enforcing that,
we will preserve ZA (the matrix register) since it is controlled
separately and that's broadly how the PCS works.

--YNznzJAAiYA0oAGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMVboACgkQJNaLcl1U
h9DIEQf/VAmj4Tl4pzYhdQuF4W1Q2utS6FbdB9duKy3TDDhYEcDYBvySmAxK8Oj/
VAJT2rpBj0VwkB+azR/pGdLzvD9f6gcH2yWP1TVS/Q0bfYWwVJ1CuGpNqyXjD3eV
xu6n7uKiNuCezF+w9x4d8KEAADCA3smQdkNLVQOVp5vobxMReSGNpHwuLxChwJNG
D+P6Hes7SAXOY/qYOClaCGRHWcXmHnTu8loJhk+6xTF/Oqit0R7whmOPxb1LOlgB
Ec6HpwXefFtfIThgS46gmPR6yPxyBdLNsFCL5rwdessjz+wfe+hkfwTHsXpsVy7E
ELsWfZUYOYlzbuBOSsLVuqryVWwqBA==
=CB25
-----END PGP SIGNATURE-----

--YNznzJAAiYA0oAGE--

