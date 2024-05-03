Return-Path: <linux-kernel+bounces-167893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507F8BB0C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C33286D79
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC91553B3;
	Fri,  3 May 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJct072P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1826155389;
	Fri,  3 May 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753281; cv=none; b=W1MvsG2anzaXWDAMFMaJn5QfHOjsQzPxLtaNPwwgr2EfgePRLmD6LhXqpcV77AIlz+ShcBFrVTOkjJZUb7cNQfJU77GXEHnOOPEwAh5gUJO6qISUbJLbKkiZjyD9Et9BvJkxME2OE8b3ZuIMw8H7kx2rCo1S7owRlyTdszxPziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753281; c=relaxed/simple;
	bh=Lz8Dfx2dl/7yUWkxrmyt1Th6CVmp9ESvVhwFYnUUsZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG5PS0pnmojxhhEsXS82AeFSubgRTP5fzrqiQAqZzR5hoRDmnvcPdwfQ9bJnpmPAFtz+VRhPm6R3cbWBk3/4KXWzABbajIASMSMKygl3lNZ0VglXNgHArYLMiqJr9iCdTktu85m4w8XKwMqVZ1UuSHj7ZtVid8QlCBqfAJRX3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJct072P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20578C116B1;
	Fri,  3 May 2024 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714753281;
	bh=Lz8Dfx2dl/7yUWkxrmyt1Th6CVmp9ESvVhwFYnUUsZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJct072PuFfEVWjF1jCII4plYNJ/fIbCmlYCxh/t2nihXtGekEqxlX7bI0Xy0MHUF
	 9ZJrKu38VCQXhbzw2fbtNQoJZvvgC9AxUlcpodNXFzGh0w0H+HlZLBS0p7ed5sE0jB
	 qleNWtSdyB131RYfPM5Sn7wLgkr9lZnkJfTz0URGe6GFk6da1L4NG7jNu+vOKr1XpK
	 5BXclFM1A6A98kdSnlx5zAPOTG43PerMRXouWHkqGF4G0uMKvJjuM1sXm48vKhJD6w
	 dnJI+yxofuEsGA51vYA5dGKJAMxxy+IG8oBkzapTZErm5N99LqN2psikYqiY8OoZu2
	 UYqtSvNSZD2Qw==
Date: Fri, 3 May 2024 17:21:14 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/4] KVM: arm64: Trap FFA_VERSION host call in pKVM
Message-ID: <20240503162114.GA18789@willie-the-truck>
References: <20240418163025.1193763-2-sebastianene@google.com>
 <20240418163025.1193763-3-sebastianene@google.com>
 <20240503143937.GA18656@willie-the-truck>
 <ZjUCyGoptCcIoGpU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUCyGoptCcIoGpU@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, May 03, 2024 at 03:29:12PM +0000, Sebastian Ene wrote:
> On Fri, May 03, 2024 at 03:39:38PM +0100, Will Deacon wrote:
> > On Thu, Apr 18, 2024 at 04:30:23PM +0000, Sebastian Ene wrote:
> > > The pKVM hypervisor initializes with FF-A version 1.0. Keep the
> > > supported version inside the host structure and prevent the host
> > > drivers from overwriting the FF-A version with an increased version.
> > > Without trapping the call, the host drivers can negotiate a higher
> > > version number with TEE which can result in a different memory layout
> > > described during the memory sharing calls.
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 43 ++++++++++++++++++++++++++++++++---
> > >  1 file changed, 40 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > index 320f2eaa14a9..023712e8beeb 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > @@ -58,6 +58,7 @@ struct kvm_ffa_buffers {
> > >  	hyp_spinlock_t lock;
> > >  	void *tx;
> > >  	void *rx;
> > > +	u32 ffa_version;
> > >  };
> > 
> > Why should this be part of 'struct kvm_ffa_buffers'? The host, proxy and
> > Secure side will end up using the same version, so a simple global
> > variable would suffice, no?
> > 
> I prefer keeping it here as we will have more clients in the future /
> different VMs and each one of them will have its own version and its own
> pair of buffers.

We can add that when we need to. Let's keep it simple for now, as the
idea of the proxy having to support multiple versions of the spec at
once sounds terrifying to me. I don't think we're going to want to
re-marshall the data structures between the 1.0 and 1.1 formats, are we?

> > > @@ -640,6 +641,39 @@ static bool do_ffa_features(struct arm_smccc_res *res,
> > >  	return true;
> > >  }
> > >  
> > > +static void do_ffa_version(struct arm_smccc_res *res,
> > > +			   struct kvm_cpu_context *ctxt)
> > > +{
> > > +	DECLARE_REG(u32, ffa_req_version, ctxt, 1);
> > > +	u32 current_version;
> > > +
> > > +	hyp_spin_lock(&host_buffers.lock);
> > 
> > Why do you need to take the lock for this?
> > 
> 
> Because we interpret the host buffer content based on the version that we
> end up setting here and each time we are accessing these buffers we are
> protected by this lock.

I think that's indicative of a broader issue, though, which is that you
allow for the version to be re-negotiated at runtime. The spec doesn't
allow that and I don't think we should either.

> > > +	/*
> > > +	 * If the client driver tries to downgrade the version, we need to ask
> > > +	 * first if TEE supports it.
> > > +	 */
> > > +	if (FFA_MINOR_VERSION(ffa_req_version) < FFA_MINOR_VERSION(current_version)) {
> > 
> > Similarly here, I don't think 'current_version' is what we should expose.
> > Rather, we should be returning the highest version that the proxy
> > supports in the host, which is 1.0 at this point in the patch series.
> 
> We already report the highest version that the proxy supports on line:
> `res->a0 = current_version;`
> 
> 'current_version' is assigned during proxy initialization.
> This check allows us to downgrade the supported ffa_version if the Host
> requested it and only if TF-A supports it.

I don't think we want the host negotiating directly with the Secure side,
though, do we? 'current_version' is initialised to whatever the Secure
side gives us, so if we had something like:

  1. Proxy initialises, issues FFA_VERSION(1.0)
  2. Secure implements 1.2 and so returns 1.2 but remains in 1.0
     compatability mode for the data structure formats.
  3. The host issues FFA_VERSION(1.1)
  4. The code above then issues FFA_VERSION(1.1) to Secure and it
     switches over to the 1.1 data structures

Did I get that right?

I really think we need to settle on a single version for the host,
hypervisor and Secure and then stick with it following a single
negotiation stage.

> > > +		arm_smccc_1_1_smc(FFA_VERSION, ffa_req_version, 0,
> > > +				  0, 0, 0, 0, 0,
> > > +				  res);
> > 
> > Hmm, I'm struggling to see how this is supposed to work per the spec.
> > The FF-A spec says:
> > 
> >   | ... negotiation of the version must happen before an invocation of
> >   | any other FF-A ABI.
> 
> I think that is a bit vague in my opinion but what I get is that the first call
> executed should always be the get version ff-a call.
> 
> > 
> > and:
> > 
> >   | Once the caller invokes any FF-A ABI other than FFA_VERSION, the
> >   | version negotiation phase is complete.
> >   |
> >   | Once an FF-A version has been negotiated between a caller and a
> >   | callee, the version may not be changed for the lifetime of the
> >   | calling component. The callee must treat the negotiated version as
> >   | the only supported version for any subsequent interactions with the
> >   | caller.> 
> > So by the time we get here, we've already settled on our version with
> > the Secure side and the host cannot downgrade.
> 
> At this stage I think the spec didn't take into account that there can be a hypervisor
> in between.

Well, that's what the spec says and I think we need to follow it. I can
well imagine that the Secure side won't allow the version to be
re-negotiated on the fly and I don't think we'd want that in the proxy,
either.

> > That's a bit rubbish if you ask me, but I think it means we'll have to
> > defer some of the proxy initialisation until the host calls FFA_VERSION,
> > at which point we'll need to negotiate a common version between the host,
> > the proxy and Secure. Once we've done that, our FFA_VERSION handler will
> > just return that negotiated version.
> 
> We are already doing this when the ARM driver is built as an external
> module. If it is not as an external module and is builtin we have a
> bigger issue because it loads before pKVM at subsys_initcall. This means
> that we won't trap FFA_MAP* and other setup calls.

Sorry, I don't follow. hyp_ffa_init() issues FFA_FEATURES immediately
after FFA_VERSION, so we terminate the negotiation right away.

Will

