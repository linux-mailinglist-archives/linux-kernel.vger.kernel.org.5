Return-Path: <linux-kernel+bounces-89028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F586E9A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5CC1C21904
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AF73B1AB;
	Fri,  1 Mar 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OLlRCv3g"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9077E1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321556; cv=none; b=C2U956v7Nrs20SFCW1lWUJifh02LvxozooE8qvcGcsWlTb/hDrTeHG8loItYR1ordTONv7xRdPAaeC/EpAczRIZuyLTLf7G02CJfw8MzWz8zKig7zcSUaFFr+eaLuFxcBDivo/uizdSMkAC1jQgPrDbHZm8yu80ApHACg9Mm4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321556; c=relaxed/simple;
	bh=LcvQwGjoQUP23QWtLhT8uHbzlcZ07DcLEO7OqTNEdog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj+Sw9LNgpZMfC06Mbz3IDeH2uQ6em6CzYlm7zHJOXUxoT1gm4vEqxSydeNAUSr+RcUU37hWFuneOY9kEQmLFnv+fLLFN4t1cqLAjp6la65bDhNQWwxxFYc2cN+xosxxvQRVPkDER+ach1/qBGhgWvmKlvj6ENlhNCKPT6pzwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OLlRCv3g; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 19:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709321553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HzaS0m3kgMmQ46iSjHCEmGWFSVwIK1lU48lUWC7x/9I=;
	b=OLlRCv3g39EBv5iR5AVvmplHOaKcHumVgJ+yTHRb96rvEhBl1BvSh+EZ4Ty2oVwQKvhWIs
	TPgPKoPXmy4Z488b3SBF+Xv2kYKvSlCQFamzQrnSADaBPqjEco6IThlw2IBE+wdyRiLIEG
	I2c1P/rUyoHO4sPA1h+bMrQIcP+AsWM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Only save S1PIE registers when dirty
Message-ID: <ZeItTLQxdxxICw01@linux.dev>
References: <20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 06:05:53PM +0000, Mark Brown wrote:
> Currently we save the S1PIE registers every time we exit the guest but
> the expected usage pattern for these registers is that they will be
> written to very infrequently, likely once during initialisation and then
> never updated again.  This means that most likely most of our saves of
> these registers are redundant.  Let's avoid these redundant saves by
> enabling fine grained write traps for the EL0 and EL1 PIE registers when
> switching to the guest and only saving if a write happened.
> 
> We track if the registers have been written by storing a mask of bits
> for HFGWTR_EL2, we may be able to use the same approach for other
> registers with similar access patterns.  We assume that it is likely
> that both registers will be written in quick succession and mark both
> PIR_EL1 and PIRE0_EL1 as dirty if either is written in order to minimise
> overhead.
> 
> This will have a negative performance impact if guests do start updating
> these registers frequently but since the PIE indexes have a wide impact
> on the page tables it seems likely that this will not be the case.
> 
> We do not need to check for FGT support since it is mandatory for
> systems with PIE.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> I don't have a good sense if this is a good idea or not, or if this is a
> desirable implementation of the concept - the patch is based on some
> concerns about the cost of the system register context switching.  We
> should be able to do something similar for some of the other registers.

Is there any data beyond a microbenchmark to suggest save elision
benefits the VM at all? The idea of baking the trap configuration based
on what KVM _thinks_ the guest will do isn't particularly exciting. This
doesn't seem to be a one-size-fits-all solution.

The overheads of guest exits are extremely configuration dependent, and
on VHE the save/restore of EL1 state happens at vcpu_load() / vcpu_put()
rather than every exit. There isn't a whole lot KVM can do to lessen the
blow of sharing EL1 in the nVHE configuration.

Looking a bit further out, the cost of traps will be dramatically higher
when running as a guest hypervisor, so we'd want to avoid them if
possible...

-- 
Thanks,
Oliver

