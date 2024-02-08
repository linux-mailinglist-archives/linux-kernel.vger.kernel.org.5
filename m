Return-Path: <linux-kernel+bounces-58152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC584E1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9FB24504
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9877628;
	Thu,  8 Feb 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tvi1paTT"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086E76416
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398709; cv=none; b=k7sjPqWx8+19O/mdxPY5UmlpqZwC4Sx0Tsc5Bwr9Yhg4PPy5QplXPcu7QEBkZuOBQRdNAw4doNfNZ8MYxmhgrKG6NuulKn/Pe9zwuQxpsS/2ObZGqGRY3IItmVh1ECTVIxqUSji3j328MCnOjNoZ9Qy1oxkZrS4kgBz56/pYa4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398709; c=relaxed/simple;
	bh=zDFq8JwWXF7RSRVmF1+WH9VzX61GkH5t4YUYqcHQ/1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzlXhnFKgGGYA3CK0mOUzLnFLG3hNqysT6S/shJbnN+HGX14mIb5Ed17iHrNF/W2qeS6ViG9vvUf2ggfe0KkiG37DdvZGniNv/bMwJQlaVjJxYIMDyf7NZatWMb9OPLbhIpOZFs4xOevZeerZU32N/MSsBORJfxuq189U8OqEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tvi1paTT; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Feb 2024 13:24:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707398704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lGdYQhRSSfN0dykRkya8P4upBClWyVoqhyocRgWZ8E=;
	b=Tvi1paTTnVNkLWQ4FgCp0lp4590qKyU+DMW/1tenbAuA71NOiHdT0sIcFrHjZZt6+qnifI
	OGwMwmpbvxHwN3YvP4Eb1gWO9mMevwVbdsnC658WCysAX7SkPT2Rjxj3cs1498TfKkffbf
	f0PZpFefakmGx/dYyp3yTn8u6VLlMLg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: ankita@nvidia.com, jgg@nvidia.com, maz@kernel.org, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	reinette.chatre@intel.com, surenb@google.com, stefanha@redhat.com,
	brauner@kernel.org, will@kernel.org, mark.rutland@arm.com,
	alex.williamson@redhat.com, kevin.tian@intel.com,
	yi.l.liu@intel.com, ardb@kernel.org, akpm@linux-foundation.org,
	andreyknvl@gmail.com, wangjinchao@xfusion.com, gshan@redhat.com,
	ricarkol@google.com, linux-mm@kvack.org, lpieralisi@kernel.org,
	rananta@google.com, ryan.roberts@arm.com, aniketa@nvidia.com,
	cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
	vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
	jhubbard@nvidia.com, danw@nvidia.com, kvmarm@lists.linux.dev,
	mochs@nvidia.com, zhiw@nvidia.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/4] kvm: arm64: introduce new flag for non-cacheable
 IO memory
Message-ID: <ZcTWK6TksvugSlI-@linux.dev>
References: <20240207204652.22954-1-ankita@nvidia.com>
 <20240207204652.22954-2-ankita@nvidia.com>
 <ZcTQi0wWZgvl05LB@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcTQi0wWZgvl05LB@arm.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 08, 2024 at 01:00:59PM +0000, Catalin Marinas wrote:
> On Thu, Feb 08, 2024 at 02:16:49AM +0530, ankita@nvidia.com wrote:
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index c651df904fe3..2a893724ee9b 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -717,15 +717,28 @@ void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> >  static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot prot,
> >  				kvm_pte_t *ptep)
> >  {
> > -	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
> > -	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, DEVICE_nGnRE) :
> > -			    KVM_S2_MEMATTR(pgt, NORMAL);
> > +	kvm_pte_t attr;
> >  	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
> >  
> > +	switch (prot & (KVM_PGTABLE_PROT_DEVICE |
> > +			KVM_PGTABLE_PROT_NORMAL_NC)) {
> > +	case 0:
> > +		attr = KVM_S2_MEMATTR(pgt, NORMAL);
> > +		break;
> > +	case KVM_PGTABLE_PROT_DEVICE:
> > +		if (prot & KVM_PGTABLE_PROT_X)
> > +			return -EINVAL;
> > +		attr = KVM_S2_MEMATTR(pgt, DEVICE_nGnRE);
> > +		break;
> > +	case KVM_PGTABLE_PROT_NORMAL_NC:
> > +		attr = KVM_S2_MEMATTR(pgt, NORMAL_NC);
> > +		break;
> 
> Does it make sense to allow executable here as well? I don't think it's
> harmful but not sure there's a use-case for it either.

Ah, we should just return EINVAL for that too.

I get that the memory attribute itself is not problematic, but since
we're only using this thing for MMIO it'd be a rather massive
bug in KVM... We reject attempts to do this earlier in user_mem_abort().

If, for some reason, we wanted to do Normal-NC actual memory then we
would need to make sure that KVM does the appropriate cache maintenance
at map / unmap.

-- 
Thanks,
Oliver

