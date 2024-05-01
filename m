Return-Path: <linux-kernel+bounces-165760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE48B90C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E61F223A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF91649C6;
	Wed,  1 May 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNsxmEtY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B21607BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596232; cv=none; b=Fgh0KmHB7GEcNLbw/edtqqOPouIYVeh31vrmyFeyucpo6qfELz1/lRX7svb7O2hcIJ7I0cA8TU2g3SPTGyZrr3C5p2N/xFYBuKSICESa48CzHwrl0qZ5w886jrHGxDVssxMrzLrLUvSHexvEq49RInM7wjlWAAuN4wFuAwGoAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596232; c=relaxed/simple;
	bh=EWkPfvYUijAMAeefowRafTalqnHwX1yDrtcNupf7HM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqzAm5IGi+IppbvuNZoo37KlfQ8e2d5NmUlO7LE5GRbZuCf+ucplbB/eIyMw4Mrs183LmndIPzupNAGfG2oq+Jm+Jkm8NHNXPko7Sikl7+UdujB/XNwAGJ/RR9+IFr3PStWOr2/o4KKAPMjDbwIJvSTo6gtOXhNGZe5gspprqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNsxmEtY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de615257412so4653484276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714596230; x=1715201030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wRtOM25SVNugBVgm3ldBixvc/1V5aLfWAERA/zS9+NI=;
        b=zNsxmEtYOFCgTGBa1z15p1uAwePRROXYIvhW3J7TFg041TqymR2mDu5+xxoV1BpciF
         eEzKF8zZr/LiKmJUW7wgqTbn/gZkBXAzjoHn4ZhDhGJxnKsh2iI1MIwwT4p9ZwBdirO0
         Cl6wwiiXyXCMOY5o7aB+6ycFPyF2KztbPTZC6qkIY6mVcj+HKRviSVo4lJwj02y5IrMS
         6zAtqWYziM9yS8Ms24hXB9KDS05QoADjBBrGN8Sbwq6i9LHLIOmS5AklGcG+hhXHIHlN
         Qc71Re76JWbfMtdPtPUjsn2JXejjs2bMgohN1n5nAHT7ZSaBXZ6IMKaXKQcYin897Qg+
         ZZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596230; x=1715201030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRtOM25SVNugBVgm3ldBixvc/1V5aLfWAERA/zS9+NI=;
        b=JpCY205JaIV4vzA3e3KrllvaZZZ8G7aDdSv7dETLN5dv0kc8DAn6onR5Ws2S4VPXoD
         i1tkgN+T9dENLOOAn3F4Gl/5/au5dyzwVivvh8jx2W/a6tbBtCyuDYueaEf1m6IcgjA5
         QPtUsQcCzaOSig2qIfTIhgCeeH0K3SRA6ypdvgc3IQK7nDsrJzeiIXFh3QM0SnYzHlt0
         7q+CQJcfAghUM5KjjNF3NSzWHnjNFjllAhNry1Hn7M41s59Dk+HzCR+wtkNRvyXkU7QU
         OBbzMpXHVImVrtpHgE91YT6bQVCsAaeM5alWhjZxXpgycc4EZFR0VBJY8OWTwekDiVvK
         rVRA==
X-Forwarded-Encrypted: i=1; AJvYcCUUDV9j6FrzTkwthneJNrikPDWQ3m/aLB2zCUIRzax68S/VIhbZxDCO3jtyG8oCEBsESB4m599ee8lQDHg9fs8rxraZ0wgH2g7LnlZm
X-Gm-Message-State: AOJu0YxOS8dVnXFHp2AfgNYINIlmDsrG/igLe3lA8/W+PTLuSkVzm+G+
	oapIYJKPpY0pvFV8W4BZWkeD5dDrlWvhfKr6e4FRF4iQpqHEWBkG3UWACpKQ0xXhaTww3f9VW0q
	25g==
X-Google-Smtp-Source: AGHT+IHkvvRyR4ZOFfRZbvHxisjAesK2LtdhCRlJFAR3MmJzlIQfXGNakxdxfoHY0k35gPGuOg9STWf3aHI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f0b:b0:de5:2325:72dc with SMTP id
 et11-20020a0569020f0b00b00de5232572dcmr988315ybb.5.1714596230054; Wed, 01 May
 2024 13:43:50 -0700 (PDT)
Date: Wed, 1 May 2024 13:43:48 -0700
In-Reply-To: <20240219074733.122080-14-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-14-weijiang.yang@intel.com>
Message-ID: <ZjKphDaJ5Bq-jTVx@google.com>
Subject: Re: [PATCH v10 13/27] KVM: x86: Refresh CPUID on write to guest MSR_IA32_XSS
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9eb5c8dbd4fb..b502d68a2576 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3926,16 +3926,23 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		}
>  		break;
>  	case MSR_IA32_XSS:
> -		if (!msr_info->host_initiated &&
> -		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> +		/*
> +		 * If KVM reported support of XSS MSR, even guest CPUID doesn't
> +		 * support XSAVES, still allow userspace to set default value(0)
> +		 * to this MSR.
> +		 */
> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES) &&
> +		    !(msr_info->host_initiated && data == 0))

With my proposed MSR access cleanup[*], I think (hope?) this simply becomes:

		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
			return KVM_MSR_RET_UNSUPPORTED;

with no comment needed as the "host && !data" case is handled in common code.

[*] https://lore.kernel.org/all/20240425181422.3250947-1-seanjc@google.com

