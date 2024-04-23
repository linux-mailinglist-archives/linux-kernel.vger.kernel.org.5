Return-Path: <linux-kernel+bounces-155993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97CC8AFC70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D229288026
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3736B0D;
	Tue, 23 Apr 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqSM9wpL"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E21C687
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913979; cv=none; b=ALtTioqnAfy45ZBIP+hWIutQrnJPJq+ukFUXx8yof2F5heHIsdxNV2rUFyvYvr1vO1CsiyLCeIoO+iM+5utgeJzhi0IDy5+NniQhq6CxH70n41OwL2OupULvgfvsIJCGaBNeitXsL64itFdLH0fBEhKOhG1S5T67wJhPywuZwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913979; c=relaxed/simple;
	bh=sCpL9Ppk/ORzgqDDGhuPamN44HwVbG4fiKQNU+9M14g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cXa3IQUAe90xQlbJUdFtUIW0zurwpKt1K0XZvy6kcGZqnHRaZP57u4lzF/mXVaA8o/ZX8wx40GfPvnAEutmMRFUhdovOeTRwzFISdTeGhGvyl0a70MyDIUGED/5A1TNuO/JcWbCc+NfR+Zdp6zwO9/h+VRmjtf/MuIM7jwuWYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqSM9wpL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2a1619cfcso2781905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713913978; x=1714518778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uezg6+/4AiQv/6erEn8oKEVi+a/EdVmsvmMSGq8YULU=;
        b=SqSM9wpLd8s4WuzKJLGjc3Ddv7mzCh5PxYlt5cMRUWTpxifmimGqJwPpmp3YPtKW0I
         dNp0YMvl4TQdFBorRvtK47FAQxla23Xbpgzh+4Fx+ry9mJv7eTIws6oBIYhillmNTn99
         8VrAbxHunf1EV/wY6xMCmb6c2zLZURMtdySy2Onp9n9as1bednrGNF2uWfX6oCBVcBmI
         kNKK2Ast3HBR/95ixbILYYhK25Y+Ssgd58sU6nVJ3B30K6+vcZGcLfC5ry9xvXUz9OwM
         Da/CPwaq77TCTBtjAAtVQcXIrHezolPOlMW0l5vABdruMsSIH1SLM5tg6uyzPLMa1Nk+
         OT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713913978; x=1714518778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uezg6+/4AiQv/6erEn8oKEVi+a/EdVmsvmMSGq8YULU=;
        b=cb4EPVVMKZcVAOfCHNYqWLDwKySTdHBnwDXmLdVWkZ6ze07SglUqvQQB/zFW4QVOGJ
         BVgjlZKme52L4jfjgj8ZC7xvLpOAzB0UMpTFqNtYhDZ0D1HQAn45F5XR58GZmq7Medhg
         uKZgpbEENpUVjE8ye5f/1mtDVgnRKOhqt0Wtv6F6gnYqMBwczcDIZdrbVXKtV/3+NVMd
         CkBwlhNIGmmTBuVhqw8qgPQczdfs9acXjW97MASkx7T7wnGbDICtLPXuyOEBE7mBvvoe
         a6FlghZ/QVTUSB4jC/PMPMFmjvIBlBG8XPuspwGXZ1kz4mQbgY3gxnIzjYwbSAiWv0Xj
         Q0lA==
X-Gm-Message-State: AOJu0YyV/gGBNu5EtSbRNWXzRuB3srqxFXLAw7bmzQTRLramG/vMv+wk
	ZHo3KrUuDZvjyY6G4IBjWvl8zS/LrAhuLNS6IJxqirv0EKXq6s2cElfhZw1S0r49X5+0NW1S61f
	PRQ==
X-Google-Smtp-Source: AGHT+IE0R0KIqo8KD6RKKMpmgCRO+v6AuiFd4g6GW8XJGF/tKYJjL3fXfzwcdFarKqjKdhtz5eYejHKnoc0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5cd:b0:1e5:5c69:fcd7 with SMTP id
 u13-20020a170902e5cd00b001e55c69fcd7mr65483plf.5.1713913977816; Tue, 23 Apr
 2024 16:12:57 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:12:56 -0700
In-Reply-To: <20240409133959.2888018-6-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-6-pgonda@google.com>
Message-ID: <ZihAeH4PXSUtT4hM@google.com>
Subject: Re: [PATCH 5/6] Add is_sev_enabled() helpers
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 09, 2024, Peter Gonda wrote:
> Add helper functions for guest code to check the status of SEV and
> SEV-ES.

Why?  The names are super ambiguous, e.g. they could just as easily mean "is SEV
enabled in KVM" or "is SEV enabled in CPUID".  And if an assert fires because
is_sev_es_enabled() returns false, the user will get a _worse_ error message because
all they'll know is _something_ in is_sev_es_enabled() failed, not which MSR bit
came back 'bad.

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/sev.h    |  3 +++
>  tools/testing/selftests/kvm/lib/x86_64/sev.c        | 11 +++++++++++
>  tools/testing/selftests/kvm/x86_64/sev_smoke_test.c |  5 ++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> index bfd481707f67..691dc005e2a1 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -106,4 +106,7 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>  	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
>  }
>  
> +bool is_sev_enabled(void);
> +bool is_sev_es_enabled(void);
> +
>  #endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index 27ae1d3b1355..5b3f0a8a931a 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -189,3 +189,14 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
>  
>  	return vm;
>  }
> +
> +bool is_sev_enabled(void)
> +{
> +	return rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED;
> +}
> +
> +bool is_sev_es_enabled(void)
> +{
> +	return is_sev_enabled() &&
> +	       rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED;
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 026779f3ed06..1d84e78e7ae2 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -16,8 +16,7 @@
>  static void guest_sev_es_code(void)
>  {
>  	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
> -	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
> -	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
> +	GUEST_ASSERT(is_sev_es_enabled());
>  
>  	/*
>  	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
> @@ -30,7 +29,7 @@ static void guest_sev_es_code(void)
>  static void guest_sev_code(void)
>  {
>  	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SEV));
> -	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
> +	GUEST_ASSERT(is_sev_enabled());
>  
>  	GUEST_DONE();
>  }
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

