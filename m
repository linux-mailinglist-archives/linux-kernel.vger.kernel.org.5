Return-Path: <linux-kernel+bounces-83210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAE869046
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F612867A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AA145FF5;
	Tue, 27 Feb 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5IiFUeQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1352145FE5;
	Tue, 27 Feb 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036363; cv=none; b=WYm2cPEu2wlAYt21d+BNYfWvh2mr4/Mls2Es9yg8vUw3bde/QGsU3Y+iK9CWz5PrH0TUYpE0E7OFNaRyc4Uf2gB9BuuHvBT2dUgare2yaDSrRXHUJMze1HVMvKx/ndjAuxPoaYnBeOuDar+xiSzA+Ci3DY9KtaAPIlO7FrlHQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036363; c=relaxed/simple;
	bh=1jnYu+1dreShgBnY6P8ah6FUiK0jP61bmfktPpRRvmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz8FEr7BMBf2clwcfU+VNTaSCqLol1T6Q0UaR1OHAXstJ3P7SKjfqX4pra1XlFg1KWU/hX1ym2Xk0ICXE4KfeKURERsgDglUcF5msFp7iLV9hp7OQ2/5xTvFywOSwMLcH8fGTAMW3YLy9AFWqPRdOhXeIfzyMn63AQBI9NtlfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5IiFUeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E46C43394;
	Tue, 27 Feb 2024 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709036362;
	bh=1jnYu+1dreShgBnY6P8ah6FUiK0jP61bmfktPpRRvmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5IiFUeQpWpfrHlLc2NoShlUWivRGWBb02ed2045EnpQf/dC2htcPT5NrsxM8lFpV
	 N47cM+8V7lIakIuGdwZcLqyF1riY0p654CdGnY6rzdx7hJibhgoH4CkIIRp0iy4v9w
	 Oe8KfYt4DtJ/FvDTr1QndgRLXFJakS4UQMhgXuPUY0DXODWh6CL1jR8PTiRhlX/VFg
	 o2m5kr9c638k9ufQJsqJ2R1NqB5oCb/5DVys/DLwHHl5/TZNgCy5h5WJtlAHr3RROd
	 3vQJaA77HrwVrjZg5xKmSIMGJ73J9wB1ElnAq1YApR8xYEH8EDpuz/ZNBOZPynChyG
	 1DeUgq7/ziHdQ==
Date: Tue, 27 Feb 2024 12:19:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Reuse struct cpu_fp_state to track the
 guest FP state
Message-ID: <ce2b8cee-7ce0-4675-8b74-f455a206d7c8@sirena.org.uk>
References: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
 <20240226-kvm-arm64-group-fp-data-v1-2-07d13759517e@kernel.org>
 <Zd2KS3sVI-vPxurg@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bXSdeBv2ZD7+BSvR"
Content-Disposition: inline
In-Reply-To: <Zd2KS3sVI-vPxurg@linux.dev>
X-Cookie: Please go away.


--bXSdeBv2ZD7+BSvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 11:07:55PM -0800, Oliver Upton wrote:
> On Mon, Feb 26, 2024 at 08:44:11PM +0000, Mark Brown wrote:

> >       vcpu->arch.fp_owner = FP_STATE_FREE;

..

> > +	vcpu->arch.fp_state.st = &vcpu->arch.ctxt.fp_regs;
> > +	vcpu->arch.fp_state.fp_type = &vcpu->arch.fp_type;
> > +	vcpu->arch.fp_state.svcr = &vcpu->arch.svcr;
> > +	vcpu->arch.fp_state.to_save = FP_STATE_FPSIMD;

> I'm not too big of a fan of scattering the initialization in various
> places... Why can't we have a unified helper for priming cpu_fp_state once
> we know what we're dealing with?

> That can be called from either kvm_setup_vcpu() or kvm_vcpu_finalize_sve()
> depending on whether userspace signed up for SVE or not.

It's just reflecting the existing structure of the code, we already
split the initialisation between _create() and the SVE setup so this is
just following along from that.

I'm also happier with doing whatever initialisation we can prior to
userspace getting involved, it wouldn't be an issue currently but this
state is visible to userspace and it feels error prone to have it
partially initialised when we aren't compelled to like we are with the
configurability of the vector lengths.  Someone could too easily not
notice that there's a window where the state is not yet initialised but
userspace can try to access it when adding to the initisation function
during future work.

> > -		fpsimd_bind_state_to_cpu(&fp_state);
> > +		fpsimd_bind_state_to_cpu(&vcpu->arch.fp_state);

> Shouldn't we get rid of the fp_state local at this point? I'm pretty
> sure a compiler would emit a warning here...

Indeed, that was actually fixed locally - looks like that didn't make it
into what got sent out somehow.

--bXSdeBv2ZD7+BSvR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd00UACgkQJNaLcl1U
h9ARiQf/YV2qnlrSCbRjTcYCelWbG/zwBa4+nA9ifX2NDoLB0bzL1SrgZcF7IPhV
F8UvFLhSGVOorHSW/af9i5hCg0Vyp9cOVmgnZj5y39hskKWi9+LXtzOdoG3aVEUX
LrQtHVIqeNRYPPyKv2VP9hcDTsbbRKdRsFXD8AYz6jYRKFpDa5vCDfd1ne6xA71i
gqPhNQdhcvNGjLyDzBNBZ5yTBsdak7Ojpr401edQzXGl2EaH3qn58Hw0IU333YCq
EkbiNwly1sI3BNhg8lXVl5D9pfu1HLNEA3nghUY1C+q41OC41ZKL20TZeKrkn9oA
TEoFY5UKi3Ro0vi9EKdYIP5iReh1Bw==
=U2fu
-----END PGP SIGNATURE-----

--bXSdeBv2ZD7+BSvR--

