Return-Path: <linux-kernel+bounces-58154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867884E1F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C583282698
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79357763FC;
	Thu,  8 Feb 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VBGy007K"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F51762D4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398819; cv=none; b=fCPgEFn+fyGCVj5bJXymJlUXYgGHJ45FzlfRiY/crZ1wQ2CUCbFdLrMa2UpN9ob5D5r6XmanCVExGiCZv4OHF/Qqu/oUtS5jBEQ1KiUUlXMujTYlMDuvbVLoXSTnRfxhpp+jEJ2uXAQWyzOfm3RwU/cJnxnn8g1N2VLLeKUwJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398819; c=relaxed/simple;
	bh=5fxbUGZah/XsMcnEnBfdysHvy+J7i//kpOs0yPAueaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOcCITSoWf8aSKoOT+80VobVFNWPdxOKOo1K2loiJOtZOR7a9tJsTgRCynD+5yfp5blT9SJ+3iXzycDr/6NMG3xwfuVtJ2kM3V4KKQSy457LolcuaBeNetG3JdkonZHd99/Jbn5ZGcPvy6h35EF1TViZP7SRoJVGekQJUQW2rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VBGy007K; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Feb 2024 13:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707398815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms5mFNmc1YMSRaq/hZ06PJ/xdlihfdaV0iwPXV9EUh0=;
	b=VBGy007K7zBFgwgCxeFZ4SXk6PdZiZTc0tqb3bI2yQMJ7Z2A+kGk90xpqHkE9gimClA3RS
	X/7EJvUS9J4SRcNS+Bx+l/1gh/zZBcvKHb6xnQ5dItLai7Ke9fS5K/4LrgY6EDqAD5tMVm
	U6G4BKNaFadn1bI1zuZfy9erbnfSf28=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: ankita@nvidia.com
Cc: jgg@nvidia.com, maz@kernel.org, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	reinette.chatre@intel.com, surenb@google.com, stefanha@redhat.com,
	brauner@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	mark.rutland@arm.com, alex.williamson@redhat.com,
	kevin.tian@intel.com, yi.l.liu@intel.com, ardb@kernel.org,
	akpm@linux-foundation.org, andreyknvl@gmail.com,
	wangjinchao@xfusion.com, gshan@redhat.com, ricarkol@google.com,
	linux-mm@kvack.org, lpieralisi@kernel.org, rananta@google.com,
	ryan.roberts@arm.com, aniketa@nvidia.com, cjia@nvidia.com,
	kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
	acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
	danw@nvidia.com, kvmarm@lists.linux.dev, mochs@nvidia.com,
	zhiw@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/4] kvm: arm64: set io memory s2 pte as normalnc for
 vfio pci device
Message-ID: <ZcTWnDBfAtMriXqp@linux.dev>
References: <20240207204652.22954-1-ankita@nvidia.com>
 <20240207204652.22954-4-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207204652.22954-4-ankita@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 08, 2024 at 02:16:51AM +0530, ankita@nvidia.com wrote:
> @@ -1557,10 +1559,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (exec_fault)
>  		prot |= KVM_PGTABLE_PROT_X;
>  
> -	if (device)
> -		prot |= KVM_PGTABLE_PROT_DEVICE;
> -	else if (cpus_have_final_cap(ARM64_HAS_CACHE_DIC))
> +	if (device) {
> +		/*
> +		 * To provide VM with the ability to get device IO memory
> +		 * with NormalNC property, map device MMIO as NormalNC in S2.
> +		 */

nit: the comment doesn't provide anything of value, the logic is rather
straightforward here.

> +		if (vfio_allow_wc)
> +			prot |= KVM_PGTABLE_PROT_NORMAL_NC;
> +		else
> +			prot |= KVM_PGTABLE_PROT_DEVICE;
> +	} else if (cpus_have_final_cap(ARM64_HAS_CACHE_DIC)) {
>  		prot |= KVM_PGTABLE_PROT_X;
> +	}
>  
>  	/*
>  	 * Under the premise of getting a FSC_PERM fault, we just need to relax
> -- 
> 2.34.1
>

-- 
Thanks,
Oliver

