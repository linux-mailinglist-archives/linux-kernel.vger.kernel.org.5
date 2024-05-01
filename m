Return-Path: <linux-kernel+bounces-164975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C38B85B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A8DB222B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E394D131;
	Wed,  1 May 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ai3adrx8"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9283A1AB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546280; cv=none; b=IeuJaO8oP04ZmpwVHG0dG1YL3MO/ooNK4Wr3ap5C7//jC7YC1+nnRppBPHaUqQAoNt0mT9XcP8YYtlyQvrdO4sEd9RO8FpMy0tNExIPPavhMy8duUgY2JDtz9BuoPywHXA5RFHGtbVptlTYQQWZDHt152TR3Bxw1Sn3Wxt3TfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546280; c=relaxed/simple;
	bh=SireIWA+TEphRA7LVA2Cy7B/RDfmWBPVxRODIiZM74o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPQ9niPh7vKVFfb86nOWoZA7vqsFN7S1gJarvOs2ACYYODvz55n+KSLr9nmWWwG4OpSZCUWPHa7DvBhWF+ZPIitA0ZWVyAO4tCCCTMcocmRo8B52qdSa7sMuXW7c8tgB8cmO+pAqhj1p1KRw3nTLnSGqrB7txH/h7x0qpZDUANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ai3adrx8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 06:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714546276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWi8bLLKtBukGh8G8zTTjC/3eWfwrHWDi/RHw99/oFY=;
	b=Ai3adrx8ClVvRwCA5urG/wBGSd0ZhpkPcliTI60FIvrx2jdMTcNTcAPxsu/H5gFxBmbKct
	WekqzR6yVfJLEqbAbu94jAWErnYXS1SV3YjuwOsusm1bkYZTEYOziCbwNY+whcWNh9JDRt
	P+Mfa/SaYLqy2nox9/YFZIiaU7wSGhg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/6] KVM: arm64: unify trap setup code
Message-ID: <ZjHmX_O7KTInLuL5@linux.dev>
References: <20240426104950.7382-1-sebott@redhat.com>
 <20240426104950.7382-3-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426104950.7382-3-sebott@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 12:49:46PM +0200, Sebastian Ott wrote:
> There are 2 functions to set up traps via HCR_EL2:

nitpick: these functions *calculate* the trap values, but do not
actually set them up. HCR_EL2 doesn't get written to until further down
the line on KVM_RUN.

> +	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB)) {
> +		vcpu->arch.hcr_el2 |= HCR_FWB;
> +	} else {
> +		/*
> +		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
> +		 * get set in SCTLR_EL1 such that we can detect when the guest
> +		 * MMU gets turned on and do the necessary cache maintenance
> +		 * then.
> +		 */
> +		vcpu->arch.hcr_el2 |= HCR_TVM;
> +	}

It seems to me like calling this once for the lifetime of a vCPU will
break non-FWB behavior.

Like the comment suggests, these traps are needed to catch the moment
the S1 MMU is turned on and do cache maintenance to make sure D$ agrees
with what the guest was doing before enabling the MMU.

KVM_ARM_VCPU_INIT resets SCTLR_EL1, but it seems we'd miss setting
HCR_TVM in that case.

-- 
Thanks,
Oliver

