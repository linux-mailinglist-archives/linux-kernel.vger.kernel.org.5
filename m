Return-Path: <linux-kernel+bounces-167781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21A8BAF17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00D21F21B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674621A06;
	Fri,  3 May 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHtpp8aW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54574168DA;
	Fri,  3 May 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747185; cv=none; b=EQCW2vshsQozWu+8o/UgIOoy6rreBHmXjUYbcHM9VzcLp8GfMQTs8hbBg4q0t026xkIuIK5dEvAaj6eAAzQGNnjPURooQRtalt/i58YKUj/T4lz8SUs5Cp7ijJPcVdr7HzNsKw4HWHbR8oH+LVHRHMjGJWhGv3EAs0g0yMz/kxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747185; c=relaxed/simple;
	bh=crmrWVWqDYe1RC0chX9UhqYvAe5bPNAEZ5pSMdrlJns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkxCxxP5r2guGV1LlVYVWcSAtuGbTUo3uNpQhLOtkaQx1PsjU2xhrcOVxBrJV8Yc+WsP5mOCRE6QHj2fn1FO/v+zHJ9ltafXnh76D4NdBiHePQm+wDo98e+BqQpAkz0Tfkjoz51SIWyeqvTkNjCadNRGvjrjt2JMHMZ5FHr+plI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHtpp8aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3749C116B1;
	Fri,  3 May 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714747184;
	bh=crmrWVWqDYe1RC0chX9UhqYvAe5bPNAEZ5pSMdrlJns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHtpp8aWu7z/uZkDA0XYRKCvCDCh/qTV7J2O/xkkETrfYkh52o+P+K/RseqapzLgc
	 DWOKCly+UKNxtd7Mmj7heEFRdTtA5wU9wm5CkkgLBPqxDvWsb9JYPXy2qDuuFoGIJ5
	 95yJ3K14GQjNr7ZCylufH7pSWVczsZsBhysKK0RbOq0ip7eBRYwQe7ukOXyTBtfPnH
	 GHD1qntB/Ou6DhQ9fdRRrVReVDeCCsxrBd3A1DtuxkjKmKheVij2HIelnuOyNzR3mx
	 zRU9VKhA1pnoCAF9NTdEiwMRnIqHEej041B3uRpQQx27vDRuYcdFUWdmvXqd0ViAEL
	 PQSdd30xUJ7DA==
Date: Fri, 3 May 2024 15:39:38 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/4] KVM: arm64: Trap FFA_VERSION host call in pKVM
Message-ID: <20240503143937.GA18656@willie-the-truck>
References: <20240418163025.1193763-2-sebastianene@google.com>
 <20240418163025.1193763-3-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418163025.1193763-3-sebastianene@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Seb,

On Thu, Apr 18, 2024 at 04:30:23PM +0000, Sebastian Ene wrote:
> The pKVM hypervisor initializes with FF-A version 1.0. Keep the
> supported version inside the host structure and prevent the host
> drivers from overwriting the FF-A version with an increased version.
> Without trapping the call, the host drivers can negotiate a higher
> version number with TEE which can result in a different memory layout
> described during the memory sharing calls.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 43 ++++++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 320f2eaa14a9..023712e8beeb 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -58,6 +58,7 @@ struct kvm_ffa_buffers {
>  	hyp_spinlock_t lock;
>  	void *tx;
>  	void *rx;
> +	u32 ffa_version;
>  };

Why should this be part of 'struct kvm_ffa_buffers'? The host, proxy and
Secure side will end up using the same version, so a simple global
variable would suffice, no?

>  /*
> @@ -640,6 +641,39 @@ static bool do_ffa_features(struct arm_smccc_res *res,
>  	return true;
>  }
>  
> +static void do_ffa_version(struct arm_smccc_res *res,
> +			   struct kvm_cpu_context *ctxt)
> +{
> +	DECLARE_REG(u32, ffa_req_version, ctxt, 1);
> +	u32 current_version;
> +
> +	hyp_spin_lock(&host_buffers.lock);

Why do you need to take the lock for this?

> +	current_version = host_buffers.ffa_version;
> +	if (FFA_MAJOR_VERSION(ffa_req_version) != FFA_MAJOR_VERSION(current_version)) {
> +		res->a0 = FFA_RET_NOT_SUPPORTED;
> +		goto unlock;
> +	}

We won't have probed the proxy if the Secure side doesn't support 1.x
so I think you should just do:

  if (FFA_MAJOR_VERSION(ffa_req_version) != 1)
	...

> +	/*
> +	 * If the client driver tries to downgrade the version, we need to ask
> +	 * first if TEE supports it.
> +	 */
> +	if (FFA_MINOR_VERSION(ffa_req_version) < FFA_MINOR_VERSION(current_version)) {

Similarly here, I don't think 'current_version' is what we should expose.
Rather, we should be returning the highest version that the proxy
supports in the host, which is 1.0 at this point in the patch series.

> +		arm_smccc_1_1_smc(FFA_VERSION, ffa_req_version, 0,
> +				  0, 0, 0, 0, 0,
> +				  res);

Hmm, I'm struggling to see how this is supposed to work per the spec.
The FF-A spec says:

  | ... negotiation of the version must happen before an invocation of
  | any other FF-A ABI.

and:

  | Once the caller invokes any FF-A ABI other than FFA_VERSION, the
  | version negotiation phase is complete.
  |
  | Once an FF-A version has been negotiated between a caller and a
  | callee, the version may not be changed for the lifetime of the
  | calling component. The callee must treat the negotiated version as
  | the only supported version for any subsequent interactions with the
  | caller.

So by the time we get here, we've already settled on our version with
the Secure side and the host cannot downgrade.

That's a bit rubbish if you ask me, but I think it means we'll have to
defer some of the proxy initialisation until the host calls FFA_VERSION,
at which point we'll need to negotiate a common version between the host,
the proxy and Secure. Once we've done that, our FFA_VERSION handler will
just return that negotiated version.

Will

