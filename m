Return-Path: <linux-kernel+bounces-90986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A481787080B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328DB1F22C43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B4260277;
	Mon,  4 Mar 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soX6GgBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6F39AF1;
	Mon,  4 Mar 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572174; cv=none; b=Nq8DVVcMR/dD1o5V3HMG3z6oKSW7RvzhEfdD/sbqHKSHfDd2vHvpMVc0E/n4AEf7wvXM4O/m9abygI6HJia4Tp8RTfFs/esWkJuYKZcRTsKy2PJcQDZ8xekCe8FoqZeioPJ/TwzpXbuOHF/zsTTKqBPgKR6AbY/xLglnE2hha2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572174; c=relaxed/simple;
	bh=tfmse9oyNlqgI6AiSd09oH+NFlRIxN1x6Z2RuuIvkJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge0QC0LPJuSuz77yGJ3ApokEkym+WzFqyW45Zw7sXcOGc6bMvl7fGTPLI5o4L2XbYiU+sxyGfxx694FAWUnKJ8nZ870CAta8TkghjPIN+zq0DWwDRIZDoJF34QCExPm3iWSID49ZDK0SKelgIN614RA+AGIAqUIFUieu3zu2a0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soX6GgBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40226C43394;
	Mon,  4 Mar 2024 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572174;
	bh=tfmse9oyNlqgI6AiSd09oH+NFlRIxN1x6Z2RuuIvkJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soX6GgBTFRn0lOQXRrK5UP+eWYLdnSfFrX3QatoCn7QWM7mdc/yW6Ut+6YLGvcclh
	 j9i3rcu07+okBT+LA+7buYESrjxWgumdkSNx2cZfqD09nUJ/mvQET8gZxFj8Q+fSk+
	 Jk+OYius5IXzHXACJ4oBiBlL4MFb6pcMcKe7aonL43HXQ7eAtQjO/PheqtLRLczcZc
	 toH5tJ/+5bd559zsD5CWr3lRBW4sEoWj18n90DTdVLRAqXHQ00meZEMTs7REVtOjaA
	 EB9dH+DjpB8WLpDpP1b2K0h6U7N5gOK+Dl6pZlsJMWBXZLCTsdQa0jviFzcOoujuYQ
	 KxzCxAaIo2UoQ==
Date: Mon, 4 Mar 2024 17:09:29 +0000
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
Message-ID: <dfae9e6e-080b-4724-a660-39febc7ab1b9@sirena.org.uk>
References: <20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org>
 <ZeItTLQxdxxICw01@linux.dev>
 <562f5e62-c26c-41d9-9ab9-aac02c91c7ae@sirena.org.uk>
 <86zfvh0vy5.wl-maz@kernel.org>
 <50c5cdd2-fceb-44c4-aff1-dc98180161a1@sirena.org.uk>
 <86v86212p4.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rwhc8ntAFC1zcQn8"
Content-Disposition: inline
In-Reply-To: <86v86212p4.wl-maz@kernel.org>
X-Cookie: He who hesitates is last.


--Rwhc8ntAFC1zcQn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 02:39:19PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Mar 02, 2024 at 10:28:18AM +0000, Marc Zyngier wrote:

> > > Complains from whom? I can't see anything in my inbox, so it my
> > > conclusion that these "issues" are not serious enough to be publicly
> > > mentioned.

> > This was you saying that adding more registers to be context switched
> > here needed special explanation, rather than just being the default and
> > generally unremarkable place to put context switching of registers for
> > EL0/1.

> What I remember saying is that it is wrong to add extra registers to
> the context switch without gating them with the VM configuration.
> Which is a very different thing.

You said both things separately.  This is specifically addressing your
comment:

| For the benefit of the unsuspecting reviewers, and in the absence of a
| public specification (which the XML drop isn't), it would be good to
| have the commit message explaining the rationale of what gets saved
| when.

which did not seem obviously tied to your separate comments about using
your at the time still in flight patches to add support for parsing
features out of the ID registers, it seemed like a separate concern.

> What I want to see explained in all cases is why a register has to be
> eagerly switched and not deferred to the load/put phases, specially on
> VHE. because that has a very visible impact on the overall performance.

I'm confused here, the specific register save/restores that you were
asking for an explanation of are as far as I can tell switched in
load/put (eg, the specific complaint was attached to loads in
__sysreg_restore_el1_state() which for VHE is called from=20

	__vcpu_load_switch_sysregs()
	kvm_vcpu_load_vhe()
	kvm_arch_vcpu_load()

which is to my understanding part of the load/put phase).  This should
be true for all the GCS registers, the explanation would be something
along the lines of "these are completely unremarkable EL0/1 registers
and are switched in the default place where we switch all the other
EL0/1 registers".

--Rwhc8ntAFC1zcQn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXmAEgACgkQJNaLcl1U
h9BJnQf9GzikoCtIUvJKBD40CKqUtV+C7nWo/dWWawV9xkNjDtFlpXhMxVi5UlDL
6UnXNkN0QsYZK5DLUDzp3BH0G4eQifz6OLz4E59kyDsh05xGBPnfe4ypOSL6/SxH
hfvk4bqe55sqkaxu0adUhQtNVUylPWzmcdNllm5blLz8et2KbEnCo7PCjjC9XJ5/
bSpl+1SDgWhPslAblxLJtSwId8uJrM0I+u1QLQ5ogR9Mb/op9K2/6yLNmRSTPd/6
dmcrgYD7xm0c26XU371QR/YN23HfBe8BeCWr2le79ixv+UA4Lf/ounlQhHutdX3m
5RQ6vtPIHfESdaSFXm2PRfDym54b/g==
=u/Yn
-----END PGP SIGNATURE-----

--Rwhc8ntAFC1zcQn8--

