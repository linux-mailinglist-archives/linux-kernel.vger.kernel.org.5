Return-Path: <linux-kernel+bounces-141502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECA8A1F16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05751C22F15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD21401B;
	Thu, 11 Apr 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0kynmDk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED376205E2D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862465; cv=none; b=BoHo92ZT+ckrhyIBUV34U7OhOFHOhOZVPLhSMdbtPVFIM/MZwpM5BVdDZUE1n7Txd0+OFC0PibH8eFfj4rYDz785fSjMNUgZYlaQQYeNjtuLeorEmpScerVilQfrolvUuKwGMY/hkYoQt29cOZ90f59EcK1GNR0KcRSaxZRE07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862465; c=relaxed/simple;
	bh=K+2mLJIg465ypUQJI5giyc0VIu85pZleLQxiFXuwW4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZjsVP46GLdF7khUu1kmsHhYYkHVOWga0KWfmxJgOLA9Dd4k7Pd9LPxyIhNdUlzde+wCWitThz9a6YzyfcEyzunkpTIauqm5sJUoXDb0jYGRDWazCREX3yRAHznEsU7WGl2BkdgyGCDy7Z5E/l6djaMSyXyEoIjRazDCJHy+SQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0kynmDk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso256910276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712862462; x=1713467262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcJF+KC6MHAw0xXKqx6sflzbfRynihMrB3htgV72+eA=;
        b=f0kynmDkNZPv77oCffRn+KoJ3tdkglIylhkS65IiPp7z2BFEx/rE7+OWoeL6f/SwLy
         r6F5Bel9eLCxP/0EX5S4KJExzuH6LEsfCuGcckKZpC0YnaidqzO3kV4zdzz9Pny5CvqL
         BLTbC+nQaNAWBOLsqAzZD7q7agMKrv0peXCtC10BrdJstg8+me2ObLsvBJsyQChUSxjI
         +9OvKdG4NNoLTmYH3D74Y/GiCCcdhlaCXKOQqI80azuclLd/G6rhbRvwa4UFkpItjjBQ
         /lOfujifD5xEic3PMQO/Nu3O9oJXVzOMBNR4pooqy6ao+/auEQ6yqLfNDAAClrrXAXTX
         d56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862462; x=1713467262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcJF+KC6MHAw0xXKqx6sflzbfRynihMrB3htgV72+eA=;
        b=Xe0ve7enpXxqgPTDzDJYJ4E+nsFQxxdPMf2DKZva64HV3F3tQ5kQjRDLwrf0q0z+yv
         Qu09crNiQIlkd34HTf9orE3p3sgk/P6XXseGH1//tdrWeVnym+ytVJNXnrtK69yM4XL1
         5RsfRPOI/rocn8gIRbHjnHsbHyor/9QG38jA5vooOvu79cMel5VfLVmIoX+IpWEd47RG
         FruKy7ETpoDHYvXyuuNSVtjzz1N61yztAjSWh1Dlbc8Wlvdp6w50oOIcUXmo82DBSvT+
         VViN7j8lai2QKlCkeUmtse8amLtV41UFNRzp5umveV+uFJXt+BE1F8cE4idl2SD++2es
         0fnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ttF6bDYpsPPU4lNusYWm4F+v8+bSFavEJdlV7uWhsQ15kILJ6lMlWA1DIxhBG47HKwMUdgB53aPhKOEGNIuN18gOC/D7wmlsNs32
X-Gm-Message-State: AOJu0Yxms/JXIDSX0OU/v1sQpWp6uKAIKKbHoOJfcJqUJ74/SMUOJaBz
	cjtZXRa1jfBHLcQcd96pDCIIlf0nrwW/8lFhCvEk6xIyTVpXk7I7SVY9mhZaTtw/0avAt92NUTG
	XZA==
X-Google-Smtp-Source: AGHT+IHtU0YJeUQQHL8WAHyzgFdSIwlw2ajKFvDhlBylMFmOQHLdub7ugcHbYGeGD3LFpO+LpN625tYE5/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188f:b0:ddd:7581:1825 with SMTP id
 cj15-20020a056902188f00b00ddd75811825mr121974ybb.8.1712862462048; Thu, 11 Apr
 2024 12:07:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:07:40 -0700
In-Reply-To: <20240126085444.324918-6-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-6-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg0_B4ktNzQbWZZ@google.com>
Subject: Re: [RFC PATCH 05/41] KVM: x86/pmu: Register PMI handler for
 passthrough PMU
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
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> Add function to register/unregister PMI handler at KVM module
> initialization and destroy time. This allows the host PMU with passthough
> capability enabled switch PMI handler at PMU context switch time.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/x86.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c924075f6f1..4432e736129f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10611,6 +10611,18 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
>  
> +void kvm_passthrough_pmu_handler(void)

s/pmu/pmi, and this needs a verb.  Maybe kvm_handle_guest_pmi()?  Definitely
open to other names.

> +{
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> +
> +	if (!vcpu) {
> +		pr_warn_once("%s: no running vcpu found!\n", __func__);

Unless I misunderstand the code, this can/should be a full WARN_ON_ONCE.  If a
PMI skids all the way past vcpu_put(), we've got big problems.
 
> +		return;
> +	}
> +
> +	kvm_make_request(KVM_REQ_PMI, vcpu);
> +}
> +
>  /*
>   * Called within kvm->srcu read side.
>   * Returns 1 to let vcpu_run() continue the guest execution loop without
> @@ -13815,6 +13827,7 @@ static int __init kvm_x86_init(void)
>  {
>  	kvm_mmu_x86_module_init();
>  	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
> +	kvm_set_vpmu_handler(kvm_passthrough_pmu_handler);

Hmm, a few patches late, but the "kvm" scope is weird.  This calls a core x86
function, not a KVM function.

And to reduce exports and copy+paste, what about something like this?

void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
{
	if (!handler)
		handler = dummy_handler;

	if (vector == POSTED_INTR_WAKEUP_VECTOR)
		kvm_posted_intr_wakeup_handler = handler;
	else if (vector == KVM_GUEST_PMI_VECTOR)
		kvm_guest_pmi_handler = handler;
	else
		WARN_ON_ONCE(1);

	if (handler == dummy_handler)
		synchronize_rcu();
}
EXPORT_SYMBOL_GPL(x86_set_kvm_irq_handler);

