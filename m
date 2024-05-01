Return-Path: <linux-kernel+bounces-165026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D88B86C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C833F1F23965
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279864E1D2;
	Wed,  1 May 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1E3ayFI"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CEEED6
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551318; cv=none; b=BrV0/B1eRrjXj2mYojVKj9N2/TDlbXNzEp3vmkSpT+vt8hcH8ELqTXuZn7lzrZIKYYKKRmRBHtGXJpSN6582euEFbXVrdmqzYyIhUs6gIpkpIC36hieXU5j4tvyeIyFtziu+F6JccHkFSiYfwg0kWaZV+yuiUeo31tvvCu97oH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551318; c=relaxed/simple;
	bh=4ciaMAZP77y9T0hSwCT5HN16fyGvxComklGARNHhQdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE6xGAIkoyVRLCTMiSFD3m8+9ekI7auSd08GIjqQWNh7iSW/n0vnwRbWE2upwg5lPlPOsdr7OEq4o4OlJvAe6Xz0j+JEmzARH7eYe4c93m8xtWWKUcZTKC0ZDMnH9cDuOhLhiQDt2uZBe94nmkrH6Kg5DHp024fm2xk1r6yYO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1E3ayFI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 08:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714551314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TSsx32/ply0qM4GB61tWhNu0UvneClxiNJiY3Z5qlaI=;
	b=t1E3ayFIe3f4752O8dHB//FsppPZyNcvHUnynnhfdbKS7VEKvngjuZv+iBN7BQ7AlqYPIH
	tSYIFgV3BfRxYHkWb08Zp5qTNC4BYiMtY4MYW1AT+lGsvE2Sb6fZ2pJlKk4IiJmsfUEAdd
	ImeLonVITPJw+xyS/F0RBD3HZ0aMD04=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/6] KVM: arm64: add emulation for CTR_EL0 register
Message-ID: <ZjH6DcedmJsAb6vw@linux.dev>
References: <20240426104950.7382-1-sebott@redhat.com>
 <20240426104950.7382-5-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426104950.7382-5-sebott@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 12:49:48PM +0200, Sebastian Ott wrote:
> CTR_EL0 is currently handled as an invariant register, thus
> guests will be presented with the host value of that register.
> 
> Add emulation for CTR_EL0 based on a per VM value. Userspace can
> switch off DIC and IDC bits and reduce DminLine and IminLine sizes.
> 
> When CTR_EL0 is changed validate that against CLIDR_EL1 and CCSIDR_EL1
> to make sure we present the guest with consistent register values.
> Changes that affect the generated cache topology values are allowed if
> they don't clash with previous register writes.

Sorry I didn't speak up earlier, but I'm not sold on the need to
cross-validate userspace values for the cache type registers.

KVM should only be concerned about whether or not the selected feature
set matches what hardware is capable of and what KVM can virtualize. So
in the context of the CTR and the cache topology, I feel that they
should be _separately_ evaluated against the host's CTR_EL0.

Inconsistencies between fields in userspace values should be out of
scope; userspace shares the responsibility of presenting something
architectural, especially if it starts modifying ID registers. Otherwise
I'm quite worried about the amount of glue required to plumb exhaustive
consitency checks for registers, especially considering the lack of
ordering.

Marc, I know this goes against what you had suggested earlier, is there
something in particular that you think warrants the consistency checks?

> +static u64 reset_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
> +{
> +	vcpu->kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	return vcpu->kvm->arch.ctr_el0;
> +}
> +

We definitely do not want this value to change across a vCPU reset, it
should be handled like the other ID registers where they only get reset
once for the VM lifetime.

-- 
Thanks,
Oliver

