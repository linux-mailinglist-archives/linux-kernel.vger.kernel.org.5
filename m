Return-Path: <linux-kernel+bounces-165854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E378B9265
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179C21C21002
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5E168B1A;
	Wed,  1 May 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uSEOjapK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F34D5BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606497; cv=none; b=me2Q9GvvONBTuR7qFkbXoa0XP6E0i/8gzaeht2EW7fo/fpD81kyCH7AGz48YTKRDU1lOeg4qVTSX+324xR0JmnFNfK+X9eMSKhUkrm6xKcwYKHQlzTQ5/uffpgvat3zPf3bluknRN3wgTcnYOBPHSl2VFSvY4XTtPlXtzQhtfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606497; c=relaxed/simple;
	bh=cmg5ombo2+E108T+B8HGQWpNl7y2fndkiQ0TRQW1pto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/9YBeuxpgcG6Ho1KpCMFoWJ3QjjBMwFViGsvu0dWrGoUrxSOhmzD5J2ACQCkiTKCqalgtp7Jj+m3GXF6Ej0hn+JbxVLRpJYftayIrnuITuaXLIVcUws2xKrriRsK4XuBITfjVw/WmI5ybtKXa1U1UIbav0+TEGnhGmbcirdONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSEOjapK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61df903af62so34815577b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714606495; x=1715211295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQJqxc+lvi4niEeN7+w6OaI+bGgWHi17//EOTNci/0A=;
        b=uSEOjapKYsQGXTB+5nYufs2o/v7/cOQCJ75OyNc2xIx174+kgeuBR+weaCcSyNSiSH
         Qtcbc0fVMBYD0U24XoGhtdYrSsH2TlyFaIOHf9WeIcQK6gnFonOL9F3RSiL38qhG/8x8
         yRnG/kOLPjzSqK0uLlD3LFw7McKc2CSUUKbEqNFIKToMIqS7YOozBSKnRVaZGvNLOX8I
         wZGUzHgMbSKGpDyjafEOmmkDQAdXubPGo/2PGGAmRZcOfQm7RDwggZ874Gs/ltp21pXE
         LOVaa6Mw9PmzO+ol6ZqTtIlPUV90rP8KMzEtTD9KRj4gN/+An8V2Q2kLfWq6nrvR4bqB
         v9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714606495; x=1715211295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQJqxc+lvi4niEeN7+w6OaI+bGgWHi17//EOTNci/0A=;
        b=HrZrCmha+oHOI8QztwAtJodiiXsTR65I3aYHX6KWB3CAGN/ndwkBaG6NZcDjYH17wI
         v8kt3ndE2ZellE7OIc5nFuzwT17/hAHP82m9PayLf5m8En5KEHSbZ7ELM4GC1nnmrGZa
         kDqxB070CQgQNOpeVhn6y66FPWe/Lt9M2GEhF+97A6+5Wyal0SQ7mitNGo6EC4MF38cI
         kZhMjpccwVcOvgjG7jOF0gUsSQtLr7EbvSolyinfCULExD9tVO9AQN5TeGE2AbCUlaAA
         zy3LvufQbQtkyvEQ7a6m9M1Pjpu/1erczGegRK0SEFo5VEgWJ3ZEROEFuY/XboFFfhFO
         TCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVcDmX8vl0xOe9rnB7tPrXxcCagMlll+47gTxLSI6izZPUj0Unhxhb0QVVzOF8qK+xUTL+5EHzpE9oRQ+IuNnUlpSoe7wnCmRbDZapA
X-Gm-Message-State: AOJu0YxpJ+z8FDxAnih716HC/LEjRr76o/m9iQxtyROx8kucwBgyFzlP
	3xQJiFUE20vAKuJYfORV2jyRCz4gyOSDr+p4NVMsi4mcTQuWuW8k8ybryMzfbJkqzAF6D/8Vt9J
	cwg==
X-Google-Smtp-Source: AGHT+IFHBs070SjkQ6MZ513umVgzARseu57FPy78r3YifTI1JE3eDVZ40dsi3yaOYDlXF0exAkKhP4t6KW0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4b13:b0:61b:eac7:37f5 with SMTP id
 ip19-20020a05690c4b1300b0061beac737f5mr92895ywb.9.1714606495617; Wed, 01 May
 2024 16:34:55 -0700 (PDT)
Date: Wed, 1 May 2024 16:34:54 -0700
In-Reply-To: <20240219074733.122080-25-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-25-weijiang.yang@intel.com>
Message-ID: <ZjLRnisdUgeYgg8i@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> @@ -665,7 +665,7 @@ void kvm_set_cpu_caps(void)
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
>  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
>  		F(CLDEMOTE) | F(MOVDIRI) | F(MOVDIR64B) | 0 /*WAITPKG*/ |
> -		F(SGX_LC) | F(BUS_LOCK_DETECT)
> +		F(SGX_LC) | F(BUS_LOCK_DETECT) | F(SHSTK)
>  	);
>  	/* Set LA57 based on hardware capability. */
>  	if (cpuid_ecx(7) & F(LA57))
> @@ -683,7 +683,8 @@ void kvm_set_cpu_caps(void)
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
>  		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
>  		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16) |
> -		F(AMX_TILE) | F(AMX_INT8) | F(AMX_BF16) | F(FLUSH_L1D)
> +		F(AMX_TILE) | F(AMX_INT8) | F(AMX_BF16) | F(FLUSH_L1D) |
> +		F(IBT)
>  	);

..

> @@ -7977,6 +7993,18 @@ static __init void vmx_set_cpu_caps(void)
>  
>  	if (cpu_has_vmx_waitpkg())
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
> +
> +	/*
> +	 * Disable CET if unrestricted_guest is unsupported as KVM doesn't
> +	 * enforce CET HW behaviors in emulator. On platforms with
> +	 * VMX_BASIC[bit56] == 0, inject #CP at VMX entry with error code
> +	 * fails, so disable CET in this case too.
> +	 */
> +	if (!cpu_has_load_cet_ctrl() || !enable_unrestricted_guest ||
> +	    !cpu_has_vmx_basic_no_hw_errcode()) {
> +		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
> +		kvm_cpu_cap_clear(X86_FEATURE_IBT);
> +	}

Oh!  Almost missed it.  This patch should explicitly kvm_cpu_cap_clear()
X86_FEATURE_SHSTK and X86_FEATURE_IBT.  We *know* there are upcoming AMD CPUs
that support at least SHSTK, so enumerating support for common code would yield
a version of KVM that incorrectly advertises support for SHSTK.

I hope to land both Intel and AMD virtualization in the same kernel release, but
there are no guarantees that will happen.  And explicitly clearing both SHSTK and
IBT would guard against IBT showing up in some future AMD CPU in advance of KVM
gaining full support.

