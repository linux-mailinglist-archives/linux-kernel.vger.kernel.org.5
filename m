Return-Path: <linux-kernel+bounces-99307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556C0878651
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8030F1C22358
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1844DA0F;
	Mon, 11 Mar 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaLFNKXc"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41643AD6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178144; cv=none; b=GilecorKrxUXm1+XP1JXTplfz6BQuA5dIio3VtjTC98BD7a+hyVRELs6ywm0El5e9PXquiKxx/Y6yrDPukvkHRXacg5+B/FWe6/wSHMzFgIwRP3iewKI+xfBSA0mRuFGkdCOazRwPXtO4QCYUuVmgr47Ro0BTB5XbybrL2h/dBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178144; c=relaxed/simple;
	bh=okoRSz7afbgkoAWXF3XbX78+I1I2fLE58zcbTZyYFWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j9M9llKJBwYsgEKfyD9zAGZcxevqr5p4bvxjUouaa+Crz5xp+zcVqbfd12+gkwt/L5iZDm4ivJZrv2/ewTlsWvQ+Sz7b75H27ABOaUityUOjuXh22i29LWFcZrG1oehXadhR1XoH/9+JzYzrVMCAeB0hK9vAO0q6O6X4emWPUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaLFNKXc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e678cd2f25so2271417b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710178142; x=1710782942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEO05PXkfOjTelHZtHuMuwrOVNRkyWhZ+54h8qYt70s=;
        b=EaLFNKXcXeIut69WO1erXmMTQpeKOVAuJ9HiSFsV7Gp4O9NxAuhM2JllOYg7BkyfTq
         DIA7QJwetxY7K2NSnhZ1qOJpoGgzj4lyq9lp6KiJyccCXfpXMQMwJgu7ynNB77/QEwjL
         ke5F9gWfKVaZVrixv1A+v9TbUgkkJ5VSE65joVhlhEDvNubElFLAUIYI1wC7jGHZ7nZD
         vS7hJRd/vOqLVN1Mpe5c6wE4M+JQKLy9k3svXYDUGwJs4LScUMhN1ku7vfinKcBGVZ/t
         V9T1y4TxenhUqys6x6HjyCirwhGAV44xNu03IAfFejafjpsss/4P55yL4ozwS4V4ky3M
         0N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178142; x=1710782942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEO05PXkfOjTelHZtHuMuwrOVNRkyWhZ+54h8qYt70s=;
        b=XVlV1EaJQvZIILYRBfwLXxe7XU+mGhEEC882VeOud/Yy7+1Ys7IKTjZ/kWpebc/S60
         +Ic3Ok9fvBEkC+GjHfvV8ykqg6kQIwQRtxJsaFDHBwWVCdoPJW7CTa2pOMPRsC7c4mSC
         7YeHkr9Xio2TFM0tidvhAx7tlfAEupRcEMYLBI5jDdHsaMuIl25EVIWK6GCt6UqdXw+c
         UAWKGDKqeNPiK22MYaNJGc5qJat+1bFzmkO64479DHstCdwCu1xyneFeNXU78sGbVYeL
         HWceYxVoBQnkYDLiGZXLpHUHxANGMn3+oW1EhD0btSrjax/+zleB9Z9ZmpL+DbEhofrU
         yvbw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Kib0GFrQJF/K4Zn1auncLuYrpJlyH9l6rtYj1Ev89JeFTsIsDgJV3DXrsavZ5j0+vF91QcH4GMTL+scjwIFjK6CwSXrfP1UIyvkP
X-Gm-Message-State: AOJu0YxfBXCd5IsDaKLXnyLpjcyrNAtWuS4jwA4YFrZjJd7R+HHxRTTI
	HeWZNVVHu5CcOMp/aK9xTxtNzj4dO73uH++468zXGIbkyxyP6Qgjiv6TLG+mQcDwTecDJVV9zdM
	4AA==
X-Google-Smtp-Source: AGHT+IH/xE2HJF5m/JJewVXuvpdu6o9k/r/j+nQP8U7Ed7EnvWNFWwESSVs39yzjTHjITgxx1z/ymyTWhqY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2291:b0:6e5:94b0:68be with SMTP id
 f17-20020a056a00229100b006e594b068bemr642052pfe.2.1710178142646; Mon, 11 Mar
 2024 10:29:02 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:29:01 -0700
In-Reply-To: <7b7dd4d56249028aa0b84d439ffdf1b79e67322a.1709288671.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com> <7b7dd4d56249028aa0b84d439ffdf1b79e67322a.1709288671.git.isaku.yamahata@intel.com>
Message-ID: <Ze8_XfMN_mZBabKP@google.com>
Subject: Re: [RFC PATCH 5/8] KVM: x86/mmu: Introduce kvm_mmu_map_page() for
 prepopulating guest memory
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, David Matlack <dmatlack@google.com>, 
	Federico Parola <federico.parola@polito.it>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 01, 2024, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Introduce a helper function to call kvm fault handler.  This allows
> a new ioctl to invoke kvm fault handler to populate without seeing
> RET_PF_* enums or other KVM MMU internal definitions.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/mmu.h     |  3 +++
>  arch/x86/kvm/mmu/mmu.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 60f21bb4c27b..48870c5e08ec 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -183,6 +183,9 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
>  	__kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
>  }
>  
> +int kvm_mmu_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> +		     u8 max_level, u8 *goal_level);
> +
>  /*
>   * Check if a given access (described through the I/D, W/R and U/S bits of a
>   * page fault error code pfec) causes a permission fault with the given PTE
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e4cc7f764980..7d5e80d17977 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4659,6 +4659,36 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  	return direct_page_fault(vcpu, fault);
>  }
>  
> +int kvm_mmu_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> +		     u8 max_level, u8 *goal_level)
> +{
> +	struct kvm_page_fault fault = KVM_PAGE_FAULT_INIT(vcpu, gpa, error_code,
> +							  false, max_level);
> +	int r;
> +
> +	r = __kvm_mmu_do_page_fault(vcpu, &fault);
> +
> +	if (is_error_noslot_pfn(fault.pfn) || vcpu->kvm->vm_bugged)
> +		return -EFAULT;

This clobbers a non-zero 'r'.  And KVM return -EIO if the VM is bugged/dead, not
-EFAULT.  I also don't see why KVM needs to explicitly check is_error_noslot_pfn(),
that should be funneled to RET_PF_EMULATE.

> +
> +	switch (r) {
> +	case RET_PF_RETRY:
> +		return -EAGAIN;
> +
> +	case RET_PF_FIXED:
> +	case RET_PF_SPURIOUS:
> +		*goal_level = fault.goal_level;
> +		return 0;
> +
> +	case RET_PF_CONTINUE:
> +	case RET_PF_EMULATE:

-EINVAL woud be more appropriate for RET_PF_EMULATE.

> +	case RET_PF_INVALID:

CONTINUE and INVALID should be WARN conditions.

> +	default:
> +		return -EIO;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kvm_mmu_map_page);

Unnecessary export.

> +
>  static void nonpaging_init_context(struct kvm_mmu *context)
>  {
>  	context->page_fault = nonpaging_page_fault;
> -- 
> 2.25.1
> 

