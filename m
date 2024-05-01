Return-Path: <linux-kernel+bounces-165828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D18B921A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282F61F21E81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F2168AFC;
	Wed,  1 May 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNHY3byj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E54D9EF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605333; cv=none; b=ngzjkC8c3FHxiprMRA4YKLspgQA3e5H7MnXqzU1JB+J/bWGJNloZX3fjgrEgM/lffBJls83KxVGCsobO/lK1Il3UFZ8JdCtl4oZt/WY8X6el/9hgn04WQZTf5tNPDxSqr0fp6bJbzuavlqJMulkspiaun7rUclGBRkJ9RChdH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605333; c=relaxed/simple;
	bh=3AM2EWff9SwBfyQdM1iIgurVCO8gQYGt1lNkAfst2vM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2DgJ0VLpff+xLOCb4v1SWTuTYJFOf1nUFTF52MzOLsXjzu3GjzuYmfUVfivAIclODP8unQPb0pu4+jeGBJkjCUouHZI3SGfc6Sqd7GijCEp7uCW8+3tSbb3ywvvXKIV5tlbxOQzCOFzF3K1snuW9mZEJPjt3+A1bSl3hzSIVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNHY3byj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso569737276.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605330; x=1715210130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLsdIwymTCHMRiGzZhz/oYnmKJwch+ZfMdjTvC31E8w=;
        b=sNHY3byjO3koyPG2YQ+HHE8hcMBqJr/Z1+sayNL28W8riMusWbo0YsEDsqm36jR9of
         LRoNJq4mL64tnmhAPB0Kjhi+FVUY3OGzuEEnjxL0t7kFPeZUJH5S9G5bGik9rjUVwC8Y
         54IynVwEoLG7Vq1bYeLmi4Rkl2/2b/mHHeYQYuqMsw11Nq4oiLNre8zAxIvTHpC/evUz
         3gv0l/z8WYSPk6lgPQvWVzly2SAj0Vut/XnG99mUJp9kwkARSHvB3JvusUKAB2EJFlkQ
         MV73VVKLGOspzSQpEM0/jvYXe8Ds2/BaPaQZXF5KEgZTfhWg9GhOk9ccO2OaG9cLzt8L
         RmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605330; x=1715210130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLsdIwymTCHMRiGzZhz/oYnmKJwch+ZfMdjTvC31E8w=;
        b=mu35wtww0JySkWlVTDzLbqLtRw/nx382Ypcigj6W3/Th+DGOpliiY/sU/1mpf5B3Xv
         mFOXiXtrM3gK6IEGVYyeCiKCfI2fesEMtx63jCCZ1zBzdV8Wp6PtbG3cmGf5nxro6kTy
         wlP4VTFP63fdgLAcZuXtZ5qtL1z+eZCYJHX9XrTPqfj0WLdXvYPwgNktnyo59EQuyj34
         7abfSzWN7TgS6kUtfFuJ1EN6LpRq54Oe4WTvJxWZiChsVGwgEt8rAAnf4NVOqrZfZjJc
         z9TW5pp13RyS11a5qgCpxXb/wDngPGobe4mFF7iJavznzf9yzZ6D35RBxTaRhm4YC7Wu
         CkmA==
X-Forwarded-Encrypted: i=1; AJvYcCWu1XMNUcZctAJWZZ5j33cZKbeufBBRrmJi5N6eH2GdOqu80CDLHwN9o6JRi7c7V7QWzq7rqA8eulWpg3O3vGKwfzJK3+gic2srA6Z3
X-Gm-Message-State: AOJu0Yx/bIKiooSJneCu+Lfaw1nO6Bg2xiQB9DNRNw7Y6JIDibcaUE8s
	gYxl5pJK3e8ScdW01Ao9SHMqQHp77cJaKXJJoAbYgaye15eqvrUG1twDTwRoTAmWu8YBHBgCM3Y
	JGQ==
X-Google-Smtp-Source: AGHT+IH5Jbyvd3OHt3LMjFeRYVLdua5jhWirNWwQZU+zhsPQlAr4tntyRhPDF3UtZtz+lXOjBlBpJeVMz/c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100a:b0:dd9:2782:d1c6 with SMTP id
 w10-20020a056902100a00b00dd92782d1c6mr263457ybt.1.1714605330246; Wed, 01 May
 2024 16:15:30 -0700 (PDT)
Date: Wed, 1 May 2024 16:15:28 -0700
In-Reply-To: <20240219074733.122080-25-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-25-weijiang.yang@intel.com>
Message-ID: <ZjLNEPwXwPFJ5HJ3@google.com>
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
> @@ -696,6 +697,20 @@ void kvm_set_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
>  	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
> +	/*
> +	 * Don't use boot_cpu_has() to check availability of IBT because the
> +	 * feature bit is cleared in boot_cpu_data when ibt=off is applied
> +	 * in host cmdline.

I'm not convinced this is a good reason to diverge from the host kernel.  E.g.
PCID and many other features honor the host setup, I don't see what makes IBT
special.

LA57 is special because it's entirely reasonable, likely even, for a host to
only want to use 48-bit virtual addresses, but still want to let the guest enable
LA57.

> @@ -4934,6 +4935,14 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  
>  	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
>  
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +		vmcs_writel(GUEST_SSP, 0);
> +		vmcs_writel(GUEST_S_CET, 0);
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, 0);
> +	} else if (kvm_cpu_cap_has(X86_FEATURE_IBT)) {
> +		vmcs_writel(GUEST_S_CET, 0);
> +	}

Similar to my comments about MSR interception, I think it would be better to
explicitly handle the "common" field.  At first glance, code like the above makes
it look like IBT is mutually exclusive with SHSTK, e.g. a reader that isn't
looking closely could easily miss that both paths write GUEST_S_CET.

	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
		vmcs_writel(GUEST_SSP, 0);
		vmcs_writel(GUEST_INTR_SSP_TABLE, 0); 
	}
	if (kvm_cpu_cap_has(X86_FEATURE_IBT) ||
	    kvm_cpu_cap_has(X86_FEATURE_SHSTK))
		vmcs_writel(GUEST_S_CET, 0);

