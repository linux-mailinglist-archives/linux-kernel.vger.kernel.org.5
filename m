Return-Path: <linux-kernel+bounces-47425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E7844DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EFBB234A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C236652;
	Thu,  1 Feb 2024 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFeTbHsO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB57F4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746857; cv=none; b=mhAVM7nN/Wudd0rjXILYuT/k7t2NtFA7svAbSVa2w16ErrInqAq9zmU/chJJdPNyn9lrWAhamVhxEyblvovtnTtuEgtiFVSTw7PSzVxskLShzXwh+h9hPxAW+WJKOHkncu7pSHbc021d4aX7PaQ0QfoAqzmWsXrFWps6RcNVRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746857; c=relaxed/simple;
	bh=vPtpnLaleP3MgQmoDyqqaoE5DCMRkDO/XbE6A+o6ZGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iTKtNq5W3hzTcoKca6lVSbJKCKT1/tMvc1DnUpgDBKDLeoRv9rW0q1HkPvj4UBzBmrjqCihZs46EkYHJDizKINh72dNhBcJgqEQUrNy476k88MeforTqMel2Uz+ev8dMMX+DDYcyjqTD/lfd/hhICedQhwOKcWTTRcrzHbopKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFeTbHsO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60404484c23so7381607b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746854; x=1707351654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1PMHYRH7qb67G88ys4k0o39fe/edxcv9FM2T4EKaqk=;
        b=AFeTbHsOsKi0IdFmI4ZHqHMqsZQrVeacIQd1k/xRKGIHIzMtd0fGZV0dv6RVKFWPzp
         NfIdcY1+/yq9AB4JCtHAOXqOYfJAaUJhQh17mNlm+GBau9Nw5FuY9+Crtdpv1OGhgpBP
         k+BZqbQWQNyD3KVftXmFrnVXGnLT0Cj4H/5emXpjY8cPtNjsovulp9yHl1OYFhkeejBn
         BbguLsmNpBvN1fPIPaCakGvjv2KBMzTN3vWR37OpWUu70Y4rokHViV3Q98fA/oMd4091
         5LqxDxF5jTSU9lj4QvFxrOBaasgXia7QUfavSW+h58reOnEjQa2HKuIPFA9h+ovDgXAa
         9F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746854; x=1707351654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1PMHYRH7qb67G88ys4k0o39fe/edxcv9FM2T4EKaqk=;
        b=lYaVpWQg63wVXgKD3LWLdNvEYMacQxYZjurs4U8HyHnbrT4Q/oh+bG5bMqAlTn0+9f
         3pEJ9eY0U5UQcNgMA3K9YdnwbYpT/MzaL/002IlMee1Lt4NXXw65dgtUMpBMciQpuyJF
         +jGR+4rWvtR17n8B/vSqIyMpw140NsgYGZAQ/eqPu8JjWxGsx5Y2Er5QBh3PZNBvaAiU
         VjqdnaIWrp+ToJvMNMxG1VZwUJIGfQIMkDtSrurHyoRFjXjEIYVf/Ew1HDUUwe2shw9q
         lmoenIVkv12hnZUU+q7jFGWUjVJUy1vNM7uG8bgIk3LjbDRoq2YX2Vlaq7Ik69ynztJ2
         oa3A==
X-Gm-Message-State: AOJu0Yw+dJzGfaC3sjnc65WRjRQZAu5saHMLT03wcZCYsu7GuZNu9Mg4
	mPp3gyWTKDWa5FkWnOYYr264NBa8Vp0kk5rsqPXjr8zcT05oJ6IdsUR+1wE/VLGsqBXz0l7nvLg
	Wvg==
X-Google-Smtp-Source: AGHT+IH80WQPe2gC0t41s8elGGKjfDMTRtXWW//0TOVmoyUvyUr43Ya/wSrUFZF+r6Z3Ca0w0TJIfiQeiMA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:f85:b0:5ff:9315:7579 with SMTP id
 df5-20020a05690c0f8500b005ff93157579mr690348ywb.6.1706746854726; Wed, 31 Jan
 2024 16:20:54 -0800 (PST)
Date: Wed, 31 Jan 2024 16:20:53 -0800
In-Reply-To: <97bb1f2996d8a7b828cd9e3309380d1a86ca681b.1705965635.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <97bb1f2996d8a7b828cd9e3309380d1a86ca681b.1705965635.git.isaku.yamahata@intel.com>
Message-ID: <Zbrj5WKVgMsUFDtb@google.com>
Subject: Re: [PATCH v18 064/121] KVM: TDX: Create initial guest memory
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com, gkirkpatrick@google.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 22, 2024, isaku.yamahata@intel.com wrote:
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 4cbcedff4f16..1a5a91b99de9 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -591,6 +591,69 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
>  	return 0;
>  }
>  
> +static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn,
> +			    enum pg_level level, kvm_pfn_t pfn)
> +{
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> +	hpa_t hpa = pfn_to_hpa(pfn);
> +	gpa_t gpa = gfn_to_gpa(gfn);
> +	struct tdx_module_args out;
> +	hpa_t source_pa;
> +	bool measure;
> +	u64 err;
> +	int i;
> +
> +	/*
> +	 * KVM_INIT_MEM_REGION, tdx_init_mem_region(), supports only 4K page
> +	 * because tdh_mem_page_add() supports only 4K page.
> +	 */
> +	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
> +		return -EINVAL;
> +
> +	/*
> +	 * In case of TDP MMU, fault handler can run concurrently.  Note
> +	 * 'source_pa' is a TD scope variable, meaning if there are multiple
> +	 * threads reaching here with all needing to access 'source_pa', it
> +	 * will break.  However fortunately this won't happen, because below
> +	 * TDH_MEM_PAGE_ADD code path is only used when VM is being created
> +	 * before it is running, using KVM_TDX_INIT_MEM_REGION ioctl (which
> +	 * always uses vcpu 0's page table and protected by vcpu->mutex).
> +	 */

Most of the above is superflous.  tdx_mem_page_add() is called if and only if
the TD is finalized, and the TDX module disallow running vCPUs before the TD is
finalized.  That's it.  And maybe throw in a lockdep to assert that kvm->lock is
held.

> +	if (KVM_BUG_ON(kvm_tdx->source_pa == INVALID_PAGE, kvm)) {
> +		tdx_unpin(kvm, pfn);
> +		return -EINVAL;
> +	}
> +
> +	source_pa = kvm_tdx->source_pa & ~KVM_TDX_MEASURE_MEMORY_REGION;
> +	measure = kvm_tdx->source_pa & KVM_TDX_MEASURE_MEMORY_REGION;
> +	kvm_tdx->source_pa = INVALID_PAGE;
> +
> +	do {
> +		err = tdh_mem_page_add(kvm_tdx->tdr_pa, gpa, hpa, source_pa,
> +				       &out);
> +		/*
> +		 * This path is executed during populating initial guest memory
> +		 * image. i.e. before running any vcpu.  Race is rare.

How are races possible at all?

> +		 */
> +	} while (unlikely(err == TDX_ERROR_SEPT_BUSY));
> +	if (KVM_BUG_ON(err, kvm)) {
> +		pr_tdx_error(TDH_MEM_PAGE_ADD, err, &out);
> +		tdx_unpin(kvm, pfn);
> +		return -EIO;
> +	} else if (measure) {
> +		for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
> +			err = tdh_mr_extend(kvm_tdx->tdr_pa, gpa + i, &out);
> +			if (KVM_BUG_ON(err, &kvm_tdx->kvm)) {
> +				pr_tdx_error(TDH_MR_EXTEND, err, &out);
> +				break;
> +			}
> +		}

Why is measurement done deep within the MMU?  At a glance, I don't see why this
can't be done up in the ioctl, outside of a spinlock.

And IIRC, the order affects the measurement but doesn't truly matter, e.g. KVM
could choose to completely separate tdh_mr_extend() from tdh_mem_page_add(), no?

> +static int tdx_init_mem_region(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
> +{
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> +	struct kvm_tdx_init_mem_region region;
> +	struct kvm_vcpu *vcpu;
> +	struct page *page;
> +	int idx, ret = 0;
> +	bool added = false;
> +
> +	/* Once TD is finalized, the initial guest memory is fixed. */
> +	if (is_td_finalized(kvm_tdx))
> +		return -EINVAL;
> +
> +	/* The BSP vCPU must be created before initializing memory regions. */
> +	if (!atomic_read(&kvm->online_vcpus))
> +		return -EINVAL;
> +
> +	if (cmd->flags & ~KVM_TDX_MEASURE_MEMORY_REGION)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&region, (void __user *)cmd->data, sizeof(region)))
> +		return -EFAULT;
> +
> +	/* Sanity check */
> +	if (!IS_ALIGNED(region.source_addr, PAGE_SIZE) ||
> +	    !IS_ALIGNED(region.gpa, PAGE_SIZE) ||
> +	    !region.nr_pages ||
> +	    region.nr_pages & GENMASK_ULL(63, 63 - PAGE_SHIFT) ||
> +	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
> +	    !kvm_is_private_gpa(kvm, region.gpa) ||
> +	    !kvm_is_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT)))
> +		return -EINVAL;
> +
> +	vcpu = kvm_get_vcpu(kvm, 0);
> +	if (mutex_lock_killable(&vcpu->mutex))
> +		return -EINTR;

The real reason for this drive-by pseudo-review is that I am hoping/wishing we
can turn this into a generic KVM ioctl() to allow userspace to pre-map guest
memory[*].

If we're going to carry non-trivial code, we might as well squeeze as much use
out of it as we can.

Beyond wanting to shove this into KVM_MEMORY_ENCRYPT_OP, is there any reason why
this is a VM ioctl() and not a vCPU ioctl()?  Very roughly, couldn't we use a
struct like this as input to a vCPU ioctl() that maps memory, and optionally
initializes memory from @source?

	struct kvm_memory_mapping {
		__u64 base_gfn;
		__u64 nr_pages;
		__u64 flags;
		__u64 source;
	}

TDX would need to do special things for copying the source, but beyond that most
of the code in this function is generic.

[*] https://lore.kernel.org/all/65262e67-7885-971a-896d-ad9c0a760907@polito.it

