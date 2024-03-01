Return-Path: <linux-kernel+bounces-89134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18AC86EAF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902CF1F24995
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9756B9C;
	Fri,  1 Mar 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm8rbWmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701A20DCD;
	Fri,  1 Mar 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327612; cv=none; b=gGcCTUtcdgJOSpA8VGzvPjatkD8CJ78r+HRyMBw6TGm/ynCBxSexeyXYK7m//d4z5nbToWTkEJKUBezX2Uy9kIrDDbITPMTQfBFldojSO7vfnLLjWMH8oQpbUlAYymAXtPh6nFxOu4v9xtMr/Bolic3i10AuIk+7fJXrjIGIymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327612; c=relaxed/simple;
	bh=1WDHBEDvkTsJ8GXPJTt2btAiD+HC62L7my6p+2cyqug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSdYgIt6kA4XPRCOvw5lNf4Y2p68fCJTPa3Pr1tYmt3ganvo1axWl+ZhxCOQ70nlkJfG7x+W6zA57OCJwbcveYoU7crTfF+dPJ+knGb8P7+GP9YxkfVNq1VEs9XjUTFzatTE7+1vpgrcOAIjCeUOYIFQaxJuj1kLDnOb4FvDKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm8rbWmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A3C433F1;
	Fri,  1 Mar 2024 21:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709327611;
	bh=1WDHBEDvkTsJ8GXPJTt2btAiD+HC62L7my6p+2cyqug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hm8rbWmjRmZH5rvjYulWD5DcaIiyg3aGeAIOqqt0MYx29zKaWfKpRfTKvMUGl9goQ
	 zaHEMyzXPe/bnNDs4cdnXmjxoC0xkeBJx8rExrEUftsrPsuCmG7PykdTIDYrOi0ObH
	 xWbn3gQHPBURmbLs1eyKbTlzdYmvrwSB9OvvqY8L9Lr7QKLHNb69atirTnGxJ7FamN
	 rZ86C8kum35aiJaHWeDOs/0Tdyvz2RubW3+hXmB7EBZnOLzH1szkd3GhX/3EwfXkx1
	 uZh6lP77qtIIZ5okigHc9dJ2ntI2n8vi7xT9n43QtpnVR/yKtVl9vnY5TKHsE7Q6ti
	 3ydX0qWfUiTRQ==
Date: Fri, 1 Mar 2024 21:13:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Only save S1PIE registers when dirty
Message-ID: <562f5e62-c26c-41d9-9ab9-aac02c91c7ae@sirena.org.uk>
References: <20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org>
 <ZeItTLQxdxxICw01@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tCYQ/jJS3BIUwGub"
Content-Disposition: inline
In-Reply-To: <ZeItTLQxdxxICw01@linux.dev>
X-Cookie: Schizophrenia beats being alone.


--tCYQ/jJS3BIUwGub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 07:32:28PM +0000, Oliver Upton wrote:
> On Fri, Mar 01, 2024 at 06:05:53PM +0000, Mark Brown wrote:

> > I don't have a good sense if this is a good idea or not, or if this is a
> > desirable implementation of the concept - the patch is based on some
> > concerns about the cost of the system register context switching.  We
> > should be able to do something similar for some of the other registers.

> Is there any data beyond a microbenchmark to suggest save elision
> benefits the VM at all? The idea of baking the trap configuration based
> on what KVM _thinks_ the guest will do isn't particularly exciting. This
> doesn't seem to be a one-size-fits-all solution.

No, and as I said above I'm really not confident about this.  There's no
hardware with these registers yet as far as I know so I don't know how
meaningful any benchmark would be anyway, and as you suggest even with a
benchmark a new guest could always come along and blow performance up
with a change in access patterns.

> The overheads of guest exits are extremely configuration dependent, and
> on VHE the save/restore of EL1 state happens at vcpu_load() / vcpu_put()
> rather than every exit. There isn't a whole lot KVM can do to lessen the
> blow of sharing EL1 in the nVHE configuration.

> Looking a bit further out, the cost of traps will be dramatically higher
> when running as a guest hypervisor, so we'd want to avoid them if
> possible...

Indeed, but OTOH I got some complaints about adding more system register
switching in __sysreg_save_el1_state() for one of my other serieses that
specifically mentioned nested virt and there don't seem to be a huge
range of other options for reducing what we're doing with context
switching without using traps to figure out what's in use, especially in
the nVHE case.  I figured I'd send the patch so the idea could be
considered.

--tCYQ/jJS3BIUwGub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXiRPYACgkQJNaLcl1U
h9Dfuwf/bgBH01WZBV1RX0Vk8R30mTChMdhuVWMiQhutnkILMJwYVIpKOzni84N+
wdMI7nOMHwqFa1XrlzB8Cgmukf//RTNSXEV0RAKT+a8xwzZMhd8LpU6iTUqDX2Au
Mmlrc7A5zHPEsWmSyit1+417x5g9Ki/dAC8yk7IpzgC/PJVc/0uqjHqmd3c2vzuc
vQQww4Iv9hVYlM/eAOmt8cl5+TOenP+VDEiHJ4HM8st5UD08RFu1w04VBsvmOw5S
WxZXwRknDVscRutJixjhF9+jtWO9LbNWriH92Qor73z4fixi6II7ID2afKaWrCnl
gSSUfnaTNmUoOzlL6Ax/ytrFsotx/w==
=MPnZ
-----END PGP SIGNATURE-----

--tCYQ/jJS3BIUwGub--

