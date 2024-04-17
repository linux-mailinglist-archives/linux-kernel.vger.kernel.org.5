Return-Path: <linux-kernel+bounces-149297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CCB8A8F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F82828A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF58527B;
	Wed, 17 Apr 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bmbtJFC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976571734
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394823; cv=none; b=YLU2ONqVveM1ZtSZEeFTMMhdMr/oJyenV718S57t6qViktQ6qfjqqaRb8Oajkz6WxFV1YRKHmsy6yYQKfHV/U1tfziGxBRZl5EjOHYBQBDbOXoECZtL+WefLS46CY+u1kbRsxrszw6VHwwtMNezGlI8RwwwKJRyXtzBDYDdWbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394823; c=relaxed/simple;
	bh=jSyOnZL52ZqVwEzR7qnXau+1BNj/PByM/S+zvuIt55s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EtvM63q92D43rIXhCUsHAhsR1N2dA0IxYB8pcMQVk53MCKAmmqYnrwL7hX/hOoM8J1R/Q8rDXEkpjudgDcDL+t75Zo558JgNaVEvCA7zW68bgYjlqYpiVayv2ztq88vWkVB5pCMH2E/qb41XwGZX/hJWJwWW94Okl6Jzv/D3CQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bmbtJFC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61acc68c1bdso15724387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713394821; x=1713999621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4nCdNbCZqVRKbbSCp3PB5n/hRBdzB/PkmDJ8ZQ9Io8=;
        b=4bmbtJFCGf8ZLkBrpPOBBqpTz2+jBdpHCUP/AvYKloaIXe122ZlyHhB7A4JR5PWuEf
         Dwqbg8eMJjbncCEbaDln3VzYDHG3hy2GHhd9lLjYa7bQoIPlBP7dMsStqWlVG9O7a21/
         J4B2BGIpm/lsvba6sW4f+gL7EWoIQEszaUuB6BRdzEzP4m8tjSMsWcq6bxxJt8LwRmBI
         qCESsfY1uXEcslTxOtYxc+ChhkUnmPbz9dtf/jIND0ZNwGJbAgiZG4jybUl594wPjM3l
         FijdzthwBnI9HBM0eteF3dFf0hdMAPvckxSZbvxyb3g2isXN0B0U19TYfgGPWSOGG4m1
         S0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713394821; x=1713999621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4nCdNbCZqVRKbbSCp3PB5n/hRBdzB/PkmDJ8ZQ9Io8=;
        b=HWWTQGjyPyOS20cLyWE0IuEly4TqCDyaQJD4vWp4lTSMKqKAJ2MDAltTprd4C4XgE2
         2XNU5D3jk9JtY2c3eqR0mvZusdy9y9G4AEl9ky7SFCM0hPqCJilq/XmQtH8AjbPuUhZy
         eInvhAXoFYpp9j18IOgPzydvzYpaq9eUuh+GBJhclvixA0Ldr2HNZ3XPyEyvD+KEQtF6
         OsySskQ57EGSw6ib60aSwEcUeBmmQ7JqypkfmIbBRfNNt33FOsXbnrdDw5Uk7qtJDO8r
         c6eJS4ijVf1pOmxr8mTVPLMYz3iDAOXc2Xk4bFfI+SBajrpECiygWVkjfNqzJGE6uquK
         rsMA==
X-Gm-Message-State: AOJu0Yxn3Jw1jPW98W2e9CKM1Yf8APhImj80AD8fXc5X6JszIfGrmWmS
	WZtfFISONIDjOT5qxrNKn3Re3XE80J1ROhlIjuzSAT2tDNPT/IFRMQqMCVhQj8K6Td3mgMNo8Tf
	9rQ==
X-Google-Smtp-Source: AGHT+IEeNEsWHT8VERP4lM1dSYCHd0Yfs+VWW6MBBqn8/3TSXT4elHQ9+G8Z2MnLnKVQOPfuV4XfJB8cw18=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1001:b0:dda:c4ec:7db5 with SMTP id
 w1-20020a056902100100b00ddac4ec7db5mr152739ybt.4.1713394821463; Wed, 17 Apr
 2024 16:00:21 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:00:19 -0700
In-Reply-To: <20240416201935.3525739-8-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416201935.3525739-1-pbonzini@redhat.com> <20240416201935.3525739-8-pbonzini@redhat.com>
Message-ID: <ZiBUg-81eIPUAy9P@google.com>
Subject: Re: [PATCH v2 07/10] KVM: VMX: Introduce test mode related to EPT
 violation VE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Paolo Bonzini wrote:
> @@ -4711,8 +4722,21 @@ static void init_vmcs(struct vcpu_vmx *vmx)
>  
>  	exec_controls_set(vmx, vmx_exec_control(vmx));
>  
> -	if (cpu_has_secondary_exec_ctrls())
> +	if (cpu_has_secondary_exec_ctrls()) {
>  		secondary_exec_controls_set(vmx, vmx_secondary_exec_control(vmx));
> +		if (vmx->ve_info) {
> +			vmcs_write64(VE_INFORMATION_ADDRESS,
> +				     __pa(vmx->ve_info));
> +		} else {
> +			/*
> +			 * Because SECONDARY_EXEC_EPT_VIOLATION_VE is
> +			 * used only for debugging, it's okay to leave
> +			 * it disabled.
> +			 */
> +			secondary_exec_controls_clearbit(vmx,
> +							 SECONDARY_EXEC_EPT_VIOLATION_VE);

As below, this is silly.

> +		}
> +	}
>  
>  	if (cpu_has_tertiary_exec_ctrls())
>  		tertiary_exec_controls_set(vmx, vmx_tertiary_exec_control(vmx));
> @@ -5200,6 +5224,12 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  	if (is_invalid_opcode(intr_info))
>  		return handle_ud(vcpu);
>  
> +	/*
> +	 * #VE isn't supposed to happen.  Block the VM if it does.
> +	 */

Doesn't need to be a multi-line comment.  Though I would just drop the comment,
the KVM_BUG_ON() makes it pretty darn clear #VE is unexpected.

> +	if (KVM_BUG_ON(is_ve_fault(intr_info), vcpu->kvm))
> +		return -EIO;
> +
>  	error_code = 0;
>  	if (intr_info & INTR_INFO_DELIVER_CODE_MASK)
>  		error_code = vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
> @@ -7474,6 +7504,8 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
>  	free_vpid(vmx->vpid);
>  	nested_vmx_free_vcpu(vcpu);
>  	free_loaded_vmcs(vmx->loaded_vmcs);
> +	if (vmx->ve_info)

free_page() handles '0', though hopefully this becomes a moot point.

> +		free_page((unsigned long)vmx->ve_info);
>  }
>  
>  int vmx_vcpu_create(struct kvm_vcpu *vcpu)
> @@ -7567,6 +7599,19 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
>  			goto free_vmcs;
>  	}
>  
> +	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_EPT_VIOLATION_VE) {
> +		struct page *page;
> +
> +		BUILD_BUG_ON(sizeof(*vmx->ve_info) > PAGE_SIZE);
> +
> +		/* ve_info must be page aligned. */
> +		page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +		if (page)

Can we please just treat this as an error.  The odds of us screwing up checks
against vmx->ve_info are higher than the odds of someone enabling KVM_INTEL_PROVE_VE
on a machine with such high memory pressure that a 4KiB allocation fails, all
subequent memory allocations succeeding, *and* caring that VM creation fails.

The pr_err() in the failure path is even more ridiculous.

> +			vmx->ve_info = page_to_virt(page);
> +		else
> +			pr_err("Failed to allocate ve_info. disabling EPT_VIOLATION_VE.\n");
> +	}
> +
>  	if (vmx_can_use_ipiv(vcpu))
>  		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id],
>  			   __pa(&vmx->pi_desc) | PID_TABLE_ENTRY_VALID);


