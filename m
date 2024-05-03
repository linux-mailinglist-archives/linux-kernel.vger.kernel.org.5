Return-Path: <linux-kernel+bounces-167800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05818BAF56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE582846B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E5448788;
	Fri,  3 May 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHgsbqhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723871BF24;
	Fri,  3 May 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748483; cv=none; b=f+n2tIxZ7GMSH/3/m1wE9fv8xrOUnR2Z/mhK7r98SVHO4/Xh0H2Jioc6iPHvznd8rmRWs4xJsU0Q6tvCLg3dUNgEWDLb7jDXRJZL3Bu+nkqp+JoFkNWRocxw2rej0HjGDcE5nO9M7yNm/PGdK8AqD52OJJvnkO5BT4pRHiZkN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748483; c=relaxed/simple;
	bh=UXXUMTs3xuoh35OPltFV2PaGUabtM91G4z1H+6ANXqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucLI/M10a4HdtHkV4BzMUf15WyCYQQJOYnTQXIwj5kfbJD5RjX1vnQg20yALnF2Z/P4L8HoTgECI72rXajLBT1irq1OmMG7Y4pVE5HOQ3EmvO1cdZYD8QMCQB5H39hoEJk6ZTPokf9kBcqzAljZu9ja0fE6x8cT5do2HeQolzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHgsbqhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F87C116B1;
	Fri,  3 May 2024 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714748483;
	bh=UXXUMTs3xuoh35OPltFV2PaGUabtM91G4z1H+6ANXqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHgsbqhfhhnWXt7vZEq/n3A1dRZyUltjDpSXa3bsBvFJodtas18PnkKRMEsFBCt5M
	 pQgCTY7uYcfQ0Yzi5RaIbOTGiOL0p9EQu/8n0JySlanhTSbU13ozsG17wfSfhbpcPl
	 8dNTB/hv2LdNudWXK5sC8C5iBEFR60B9Bs0+NwUwCucjz+ivfvAanNUvQ6L2+kjiM2
	 6IpS/xhzto24IeMVWxXP08xWIB7x14R5hUM1aKVnIh1+YDsV5yqgN8mlP4/HbtV2Vc
	 Bubs2zNjvEG6jcfYFCDUoLrKboifhW8QU45Pi0ER5IFrgGEFhbcN/LeJHNZUsXoR6t
	 7xOmbYjkcCz6Q==
Date: Fri, 3 May 2024 16:01:16 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/4] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <20240503150114.GB18656@willie-the-truck>
References: <20240418163025.1193763-2-sebastianene@google.com>
 <20240418163025.1193763-4-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418163025.1193763-4-sebastianene@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 18, 2024 at 04:30:24PM +0000, Sebastian Ene wrote:
> Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
> and copy the response message back to the host buffers. Save the
> returned FF-A version as we will need it later to interpret the response
> from the TEE.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 023712e8beeb..d53f50c73acb 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -674,6 +674,49 @@ static void do_ffa_version(struct arm_smccc_res *res,
>  	hyp_spin_unlock(&host_buffers.lock);
>  }
>  
> +static void do_ffa_part_get(struct arm_smccc_res *res,
> +			    struct kvm_cpu_context *ctxt)
> +{
> +	DECLARE_REG(u32, uuid0, ctxt, 1);
> +	DECLARE_REG(u32, uuid1, ctxt, 2);
> +	DECLARE_REG(u32, uuid2, ctxt, 3);
> +	DECLARE_REG(u32, uuid3, ctxt, 4);
> +	DECLARE_REG(u32, flags, ctxt, 5);
> +	u32 off, count, sz, buf_sz;
> +
> +	hyp_spin_lock(&host_buffers.lock);
> +	if (!host_buffers.rx) {
> +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);

This should be FFA_RET_BUSY per the spec.

> +		goto out_unlock;
> +	}
> +
> +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> +			  uuid2, uuid3, flags, 0, 0,
> +			  res);
> +
> +	if (res->a0 != FFA_SUCCESS)
> +		goto out_unlock;
> +
> +	count = res->a2;
> +	if (!count)
> +		goto out_unlock;
> +
> +	if (host_buffers.ffa_version > FFA_VERSION_1_0) {

The spec says that the size field is populated based on the flags
parameter. Why aren't you checking that instead of the version number?

> +		buf_sz = sz = res->a3;
> +		if (sz > sizeof(struct ffa_partition_info))
> +			buf_sz = sizeof(struct ffa_partition_info);

I don't think this is right, as if the payload really is bigger than
'struct ffa_partition_info' we'll truncate the data (and you don't
adjust res->a3 afaict).

Can't we just copy the whole thing back to the host? We're not
interpreting the thing, so we can just treat it like a stream of bytes.

> +	} else {
> +		/* FFA_VERSION_1_0 lacks the size in the response */
> +		buf_sz = sz = 8;

Can you define that as a constant in arm_ffa.h, please? It's the size of
a 1.0 partition info structure.

> +	}
> +
> +	WARN_ON((count - 1) * sz + buf_sz > PAGE_SIZE);

We should bounds-check against 'KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE' and
return an error (FFA_RET_ABORTED) if the size is over that.

> +	for (off = 0; off < count * sz; off += sz)
> +
> +		memcpy(host_buffers.rx + off, hyp_buffers.rx + off, buf_sz);

I think this is wrong if bit 0 of 'flags' is set to 1. In that case, I
think you just get back the number of partitions and that's it, so we
shouldn't be going near the mailboxes.

Will

