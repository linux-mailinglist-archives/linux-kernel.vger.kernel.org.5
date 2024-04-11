Return-Path: <linux-kernel+bounces-141646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AC8A2126
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70990283C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A623BBDF;
	Thu, 11 Apr 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+JETiTv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F539FFD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872453; cv=none; b=QuuzJdDbhc9Iy65zRV51Ta1FbCx/16KXMMv/ckc4PJLaci2ZavjoSZN96WFgtCQUq5v2N4LsNJAtU9AIkxK/+mfl99lLPbadQHosnjyEDKaFZ8WJw6C1Uyr7Y1mAXHRArLJX8CUcBQeM7y2iHyNr58LI/ZlvFM0a4GliBUwF9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872453; c=relaxed/simple;
	bh=dMv2efYh9t5qbiHodN5CHCg9ZWvNG1WjJJvX3ETmegY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNTEENyElcxLvw2WTc6sKXezdEXZBI4dvUBxb8724ky42lIcl9LGysb5IiyTd7Ht/2nkbiOzMh39fXSTV+9rHOLE2rOl5w9Itnr4LhXRHaI0QJ79iLZL0y7afvFsQh0fqAnk3eGaii256LyPJPCERZi+R2uS7w/FgBmSJInL0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+JETiTv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e44b8ebf43so2545085ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872451; x=1713477251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWEYeWMnUY3BOgV5tOpNO4uTAlbf0LGTh8Nxy6R0vPg=;
        b=N+JETiTvLgRdnYXZloB5a8GQDp5sBA/FbroybV8zXfTswz7BzN+wLW8A0/ijCf/XmV
         qHe5lDM6EjyIRwGB/IWYqyns8h9a9OmHlXDOjs+NoYDOS/Lg/RP0jblpUFxLVMZD0WXR
         Kqn5IWm940+yNgBMUMRncnLiVAjXCUJNC9gStQwW4GqQ7Jzit9QFc9Zx1cIA2C6ujW5A
         LnqyQYHqpqg79EeOoe+A+3hxsHYO4XRfLw0T1oR6UKpztX+ZvN9iTTczjLlIP4OJaI8p
         0Qk8Qg8U0NvroiCP9J/S+i5uHSx24c8oNAaGJcYIyTB5bYhDJisZIEd907+U+objGB++
         OziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872451; x=1713477251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWEYeWMnUY3BOgV5tOpNO4uTAlbf0LGTh8Nxy6R0vPg=;
        b=cSQjdf9RtgybMQJVHcdwI+Sut6Vs/bAfetm5/WuZTiqif9xm31QLmiiW/gusR6fTjV
         +0o89NoyevKqTgvZpbDNAvPWgKJVWaaX8tuLgujg3IEOTz26AVrh/SPLbcF9q3ASRdCH
         yS7GRcnIRl7Q9ygzlaI49MJP/HXJLBiDkwc/UpEKvQVX3rNYKcPENH7ueVpjcFjxZDSs
         oI6iyWuXy7LbekfcxbA2qduThaPjZne74Zqglec6IZwN4SyXTR0HK2Q+ooJqMZ+doGCk
         p+6Hcnnls1mvebgxKCz1rqeWlxtY5TnnOnEoecfcpDRRryipSZM2LzvLEyX9dFHKtkJg
         E4wA==
X-Forwarded-Encrypted: i=1; AJvYcCWEXbZb6tmU/38ReyDVcFLP3a0qJTx1tKZ8FecctMgb3mMraasHRdoQznxhLxHRWZgb/J8tqHUe7e9UI+DnxJIiKgDhDRYMV/OP53NA
X-Gm-Message-State: AOJu0YyBSiMkR9uehyWAOYGLD7ZeZ0OGk7xHSHXatxZxVeeNtJfQsO26
	kN0q72c4vVCmmRDqUOfx1P3tmQb9d2uoKzw4BE+/OqFhpAg29X2Y01uknEXzh/t+PrURoWE07wc
	7Mw==
X-Google-Smtp-Source: AGHT+IE+4lhp+CVIvIL7jXc6IL4yCLOEq6e22oEzOBveayKBILIDUtN2lWLL1X94+Jx8CVt7uNuSRPz9m7A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:a4e:b0:1e2:881c:8ddc with SMTP id
 mn14-20020a1709030a4e00b001e2881c8ddcmr1730plb.12.1712872451257; Thu, 11 Apr
 2024 14:54:11 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:54:09 -0700
In-Reply-To: <20240126085444.324918-29-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-29-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhcAT7XiLHK3ZNQ@google.com>
Subject: Re: [RFC PATCH 28/41] KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at
 VM boundary
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> +static void save_perf_global_ctrl_in_passthrough_pmu(struct vcpu_vmx *vmx)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(&vmx->vcpu);
> +	int i;
> +
> +	if (vm_exit_controls_get(vmx) & VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL) {
> +		pmu->global_ctrl = vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
> +	} else {
> +		i = vmx_find_loadstore_msr_slot(&vmx->msr_autostore.guest,
> +						MSR_CORE_PERF_GLOBAL_CTRL);
> +		if (i < 0)
> +			return;
> +		pmu->global_ctrl = vmx->msr_autostore.guest.val[i].value;

As before, NAK to using the MSR load/store lists unless there's a *really* good
reason I'm missing.

And we should consider adding VCPU_EXREG_GLOBAL_CTRL so that we can defer the
VMREAD until KVM actually tries to access the guest value.

