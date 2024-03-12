Return-Path: <linux-kernel+bounces-100904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5774879F25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3381F22E82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2844C89;
	Tue, 12 Mar 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="1wkv9pDY"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC441236
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284111; cv=none; b=E+PX7+Xv1LT5m1fc0uWJZJXUial2raKHr+U8iPbY73z4TagRws9YR2D1DH5YqPiLErmk7flI4esqc9rKjcXIOwytjDQjMBRyK+kn/PNETQ8RT1Zsnj9B6GrWr4n+KH+5O/RND9cUjho+AVjRkQkpaQICLNCdhzSFHkPGAUUw0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284111; c=relaxed/simple;
	bh=PjTThnS897JBeeLLZ2v/9plHI69Lx4l02jlhaD0hgO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qv372B3F44KinqNWIh2A0a4EaTUXT5O+MuCp2x1fB48h6SRy/YN3xtZT7ReIv0x5t14eyzseGGYI+fhsUxlWf1fGc60Pg6FXKFyjatr+iy4FBSxflscwQko6kEwxpKOYDkODFwzsQbl9eUGyAdXwB4BlqwRzj4znjcIYXpmO1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wkv9pDY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dd8dc37495so31464765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710284109; x=1710888909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU95RMg0fdFREnYHW4aRlJKTf827qSXmLhHuHKLFqbs=;
        b=1wkv9pDYiSG5C8sSGQhoZX25SpnzlE63R6NIk9/Zpd1D84bbUgaSJkemcYRhM8ztrg
         5Y7M7eHvjPQ9M5Vxc+BdeYaz0gCu1waL2TT55sS3I72cC7BDdFAYQ6wVUrkbi1kQ3oUu
         nV9XFJ5EgWGw1VrMbhWOolJoRlHPLmqMGg+xvAMEYnAWJ377V8eHpYcgsU/9f0VNsFQG
         gXI4ue/sY4dGyS4oSXvgdQ2rHuMYoQLB4Q/DXEiQ9GXtsS2m9sshp3ch7wnsVxrLgwwM
         m43vB1P2X2m1htb+tfQXbSyJokXccALRxVlxIx/DKdYpJjRIMiIrk+eJ9xhPJsDh2+m/
         ztNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284109; x=1710888909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU95RMg0fdFREnYHW4aRlJKTf827qSXmLhHuHKLFqbs=;
        b=ACKB5mDkKTri+MIA6uTBe1xLkYo5DQFTw6pkIsYTmr8EUk1LzIAQi1AyvbkrqsMnp5
         sLC4ESnRZALjFjJjmKoDOJXPJ9IGfO+PdVouYIGa2tGiLCEiJzzEb5TTW54cIC4N4NOB
         1hRgnBWlquzNu02yIx9eJOuuHqPChUekk5gY4GIxMY2Do8C+ojL4OUv+gBiYwvhLO3xY
         xy+hsDFcWQqq7ELSQKkKAbTcPeqZpyEYIjGiIsCiG6US9jZlJIusXnIRbFrLjEcTRA0Y
         D0KJVIncWPeJcsZO+M6T7v57H1V1A7dAmbOLdAEFCcs/nVtgM9E8yolhQCqdBo05QRLO
         H2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVMnWL3Xx0tRf6CO8sWYA6CXN/79cIn01baLglS+48Kxh+Rxre6KrnMORHWDMnV3qy64G2NMvQEDucudEiJkzjvYsR38XL+t0C2v6oC
X-Gm-Message-State: AOJu0Yy02azwbA5HtS5qX0VWmTy9m0Kw3NZHgQZYTILzDhBbtq7OOq2r
	hnHFuCZBtYA6ORDmJe9+c2voCsoVDO05L7e7AYnY72fDsts//M/TdGG7opD3PpEpEljkLF0r1dI
	NDg==
X-Google-Smtp-Source: AGHT+IEsmFMb35JDWyUf7Z0C3Jb/NUl//hA1C6c4K7I8zAn8oJ3QRU6G6WKtQFWdJ+z8U/3qFn8KpL4ck2Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:244d:b0:1dd:a17f:e7d8 with SMTP id
 l13-20020a170903244d00b001dda17fe7d8mr25271pls.12.1710284109303; Tue, 12 Mar
 2024 15:55:09 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:55:07 -0700
In-Reply-To: <20240219074733.122080-21-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-21-weijiang.yang@intel.com>
Message-ID: <ZfDdS8rtVtyEr0UR@google.com>
Subject: Re: [PATCH v10 20/27] KVM: VMX: Emulate read and write to CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com, Aaron Lewis <aaronlewis@google.com>, 
	Jim Mattson <jmattson@google.com>, Oliver Upton <oupton@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

-non-KVM people, +Mingwei, Aaron, Oliver, and Jim

On Sun, Feb 18, 2024, Yang Weijiang wrote:
>  	case MSR_IA32_PERF_CAPABILITIES:
>  		if (data && !vcpu_to_pmu(vcpu)->version)
>  			return 1;

Ha, perfect, this is already in the diff context.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c0ed69353674..281c3fe728c5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1849,6 +1849,36 @@ bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
>  }
>  EXPORT_SYMBOL_GPL(kvm_msr_allowed);
>  
> +#define CET_US_RESERVED_BITS		GENMASK(9, 6)
> +#define CET_US_SHSTK_MASK_BITS		GENMASK(1, 0)
> +#define CET_US_IBT_MASK_BITS		(GENMASK_ULL(5, 2) | GENMASK_ULL(63, 10))
> +#define CET_US_LEGACY_BITMAP_BASE(data)	((data) >> 12)
> +
> +static bool is_set_cet_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u64 data,
> +				   bool host_initiated)
> +{

..

> +	/*
> +	 * If KVM supports the MSR, i.e. has enumerated the MSR existence to
> +	 * userspace, then userspace is allowed to write '0' irrespective of
> +	 * whether or not the MSR is exposed to the guest.
> +	 */
> +	if (!host_initiated || data)
> +		return false;

..

> @@ -1951,6 +2017,20 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
>  			return 1;
>  		break;
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_S_CET:
> +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) &&
> +		    !guest_can_use(vcpu, X86_FEATURE_IBT))
> +			return 1;

As pointed out by Mingwei in a conversation about PERF_CAPABILITIES, rejecting
host *reads* while allowing host writes of '0' is inconsistent.  Which, while
arguably par for the course for KVM's ABI, will likely result in the exact problem
we're trying to avoid: killing userspace because it attempts to access an MSR KVM
has said exists.

PERF_CAPABILITIES has a similar, but opposite, problem where KVM returns a non-zero
value on reads, but rejects that same non-zero value on write.  PERF_CAPABILITIES
is even more complicated because KVM stuff a non-zero value at vCPU creation, but
that's not really relevant to this discussion, just another data point for how
messed up this all is.

Also relevant to this discussion are KVM's PV MSRs, e.g. MSR_KVM_ASYNC_PF_ACK,
as KVM rejects attempts to write '0' if the guest doesn't support the MSR, but
if and only userspace has enabled KVM_CAP_ENFORCE_PV_FEATURE_CPUID.

Coming to the point, this mess is getting too hard to maintain, both from a code
perspective and "what is KVM's ABI?" perspective.

Rather than play whack-a-mole and inevitably end up with bugs and/or inconsistencies,
what if we (a) return KVM_MSR_RET_INVALID when an MSR access is denied based on
guest CPUID, (b) wrap userspace MSR accesses at the very top level and convert
KVM_MSR_RET_INVALID to "success" when KVM reported the MSR as savable and userspace
is reading or writing '0', and (c) drop all of the host_initiated checks that
exist purely to exempt userspace access from guest CPUID checks.

The only possible hiccup I can think of is that this could subtly break userspace
that is setting CPUID _after_ MSRs, but my understanding is that we've agreed to
draw a line and say that that's unsupported.  And I think it's low risk, because
I don't see how code like this:

	case MSR_TSC_AUX:
		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
			return 1;

		if (!host_initiated &&
		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP) &&
		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
			return 1;

		if (guest_cpuid_is_intel(vcpu) && (data >> 32) != 0)
			return 1;

can possibly work if userspace sets MSRs first.  The RDTSCP/RDPID checks are
exempt, but the vendor in guest CPUID would be '0', not Intel's magic string,
and so setting MSRs before CPUID would fail, at least if the target vCPU model
is Intel.

P.S. I also want to rename KVM_MSR_RET_INVALID => KVM_MSR_RET_UNSUPPORTED, because
I can never remember that "invalid" doesn't mean the value was invalid, it means
the MSR index was invalid.

It'll take a few patches, but I believe we can end up with something like this:

static bool kvm_is_msr_to_save(u32 msr_index)
{
	unsigned int i;

	for (i = 0; i < num_msrs_to_save; i++) {
		if (msrs_to_save[i] == msr_index)
			return true;
	}

	return false;
}
typedef int (*msr_uaccess_t)(struct kvm_vcpu *vcpu, u32 index, u64 *data,
			     bool host_initiated);

static __always_inline int kvm_do_msr_uaccess(struct kvm_vcpu *vcpu, u32 msr,
					      u64 *data, bool host_initiated,
					      enum kvm_msr_access rw,
					      msr_uaccess_t msr_uaccess_fn)
{
	const char *op = rw == MSR_TYPE_W ? "wrmsr" : "rdmsr";
	int ret;

	BUILD_BUG_ON(rw != MSR_TYPE_R && rw != MSR_TYPE_W);

	/*
	 * Zero the data on read failures to avoid leaking stack data to the
	 * guest and/or userspace, e.g. if the failure is ignored below.
	 */
	ret = msr_uaccess_fn(vcpu, msr, data, host_initiated);
	if (ret && rw == MSR_TYPE_R)
		*data = 0;

	if (ret != KVM_MSR_RET_UNSUPPORTED)
		return ret;

	/*
	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
	 * reports as to-be-saved, even if an MSRs isn't fully supported.
	 * Simply check that @data is '0', which covers both the write '0' case
	 * and all reads (in which case @data is zeroed on failure; see above).
	 */
	if (kvm_is_msr_to_save(msr) && !*data)
		return 0;

	if (!ignore_msrs) {
		kvm_debug_ratelimited("unhandled %s: 0x%x data 0x%llx\n",
				      op, msr, *data);
		return ret;
	}

	if (report_ignored_msrs)
		kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n", op, msr, *data);
	
	return 0;
}

