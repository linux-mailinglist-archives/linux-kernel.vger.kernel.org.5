Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9AD7DE4D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjKAQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjKAQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:46:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85679101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:46:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af9ad9341fso73658417b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698857165; x=1699461965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TK6zRbNRnaaGZQru6tpn4DJQzZiGHhIaVNTtMzEhwHs=;
        b=GbmChK2++j9Z0JUs0KsrZHv0aPtsBHfQ0LvOKWrnYyC+OIcBG/jf0zqKdDGrmK1dkR
         lEoqiLdsmhTrvJzGEtUBgACUoyQko7v1lYUAwq61Z0S8BQZI5VFhr9Bp6t9nmB2sCFK6
         4VHft0h0xIwFXgELuGQTNBblAB8Nysjmzz4+gZPi01nbB8+lN+MTgZIAny0qcxYfz2ru
         rIy5oTNyaWUUxA97ABomiUqQO1LiYLGGXbtB15VA9Qn/gLJjd2voWNeyhOp/H5Kajepr
         Ngw8wDy4Nerq8zm8YywlCqJjyjm1WmSjnAPPtJKFkkkICxYDI3Cf0KM5bf3N4vhrjfnc
         r/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857165; x=1699461965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TK6zRbNRnaaGZQru6tpn4DJQzZiGHhIaVNTtMzEhwHs=;
        b=JtTXFyTgZtfAcuWBr0+j6G6b1uYhpbx/PldG77PMxIdVShY6A/ks8guGRXY2Rkjf6+
         YoB4x7HN2vr7MIGF4BE/4v3fYwbpsnqRCfYXe4+0QYP2v6N6lSaHxJPmkXPFLPFLlRFP
         SKI44leE1E7QNSj22+Zh1C/AuSWN7iOJ1XMh8kSWzVYptcWW6y0IkK3Uz92BlDVXpTsH
         0izUuPpJlLt30a4/QpNZgaR8G1Z2UbN1UFFbXTYKsY8XqJkv7v7OgATmW6Iiv8ZKlo+t
         Pdm72KLyzt7jRHs2BboFOGhUKikahgf9T9SYXTawClsUGvaHzx+M6yWE8wI/GCkKhE8d
         GeAA==
X-Gm-Message-State: AOJu0Yxs6xTheDvi8gTDbMU8lhdgFZRqOMmV2ScNS5CcEzb0F+Z3yonD
        T6KRCNX8CG1y9ZEP2x1nD1UJrXcozB0=
X-Google-Smtp-Source: AGHT+IHtwh3c3DNIaPCk1TA9eY4hLxblw7bOvi/N9yqoqPx/PUA0Lv0gE6u8JTy7Iy5AmtVcGWneKurXYr8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:abcd:0:b0:da0:42f3:6ce4 with SMTP id
 v71-20020a25abcd000000b00da042f36ce4mr277219ybi.7.1698857165733; Wed, 01 Nov
 2023 09:46:05 -0700 (PDT)
Date:   Wed, 1 Nov 2023 09:46:04 -0700
In-Reply-To: <20231101112934.631344-1-paul@xen.org>
Mime-Version: 1.0
References: <20231101112934.631344-1-paul@xen.org>
Message-ID: <ZUKAzGzEts262FqC@google.com>
Subject: Re: [PATCH v3] KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023, Paul Durrant wrote:
> @@ -3231,12 +3245,15 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
>  	vcpu->hv_clock.flags = pvclock_flags;
>  
>  	if (vcpu->pv_time.active)
> -		kvm_setup_guest_pvclock(v, &vcpu->pv_time, 0);
> +		kvm_setup_guest_pvclock(v, &vcpu->pv_time, 0, false);
> +
>  	if (vcpu->xen.vcpu_info_cache.active)
>  		kvm_setup_guest_pvclock(v, &vcpu->xen.vcpu_info_cache,
> -					offsetof(struct compat_vcpu_info, time));
> +					offsetof(struct compat_vcpu_info, time),
> +					xen_pvclock_tsc_unstable);
>  	if (vcpu->xen.vcpu_time_info_cache.active)
> -		kvm_setup_guest_pvclock(v, &vcpu->xen.vcpu_time_info_cache, 0);
> +		kvm_setup_guest_pvclock(v, &vcpu->xen.vcpu_time_info_cache, 0,
> +					xen_pvclock_tsc_unstable);
>  	kvm_hv_setup_tsc_page(v->kvm, &vcpu->hv_clock);
>  	return 0;

Please rebase, this conflicts with commit ee11ab6bb04e ("KVM: X86: Reduce size of
kvm_vcpu_arch structure when CONFIG_KVM_XEN=n").  I can solve the conflict, but
I really shouldn't have to.

Also, your version of git should support --base, which makes life much easier for
others when non-trivial conflicts are encountered.  From maintainer-kvm-x86.rst:

 : Git Base
 : ~~~~~~~~
 : If you are using git version 2.9.0 or later (Googlers, this is all of you!),
 : use ``git format-patch`` with the ``--base`` flag to automatically include the
 : base tree information in the generated patches.
 : 
 : Note, ``--base=auto`` works as expected if and only if a branch's upstream is
 : set to the base topic branch, e.g. it will do the wrong thing if your upstream
 : is set to your personal repository for backup purposes.  An alternative "auto"
 : solution is to derive the names of your development branches based on their
 : KVM x86 topic, and feed that into ``--base``.  E.g. ``x86/pmu/my_branch_name``,
 : and then write a small wrapper to extract ``pmu`` from the current branch name
 : to yield ``--base=x/pmu``, where ``x`` is whatever name your repository uses to
 : track the KVM x86 remote.

> @@ -4531,7 +4548,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		    KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL |
>  		    KVM_XEN_HVM_CONFIG_SHARED_INFO |
>  		    KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL |
> -		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND;
> +		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
> +		    KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE;
>  		if (sched_info_on())
>  			r |= KVM_XEN_HVM_CONFIG_RUNSTATE |
>  			     KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG;
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 40edf4d1974c..7699d94f190b 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1111,9 +1111,12 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
>  
>  int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
>  {
> +	bool update_pvclock = false;
> +
>  	/* Only some feature flags need to be *enabled* by userspace */
>  	u32 permitted_flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL |
> -		KVM_XEN_HVM_CONFIG_EVTCHN_SEND;
> +		KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
> +		KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE;
>  
>  	if (xhc->flags & ~permitted_flags)
>  		return -EINVAL;
> @@ -1134,9 +1137,19 @@ int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
>  	else if (!xhc->msr && kvm->arch.xen_hvm_config.msr)
>  		static_branch_slow_dec_deferred(&kvm_xen_enabled);
>  
> +	if ((kvm->arch.xen_hvm_config.flags &
> +	     KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE) !=
> +	    (xhc->flags &
> +	     KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE))
> +		update_pvclock = true;

Rather than a boolean and the above, which is a bit hard to parse, what about
taking a snapshot of the old flags and then doing an XOR?

	/* Only some feature flags need to be *enabled* by userspace */
	u32 permitted_flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL |
		KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
		KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE;
	u32 old_flags;

	if (xhc->flags & ~permitted_flags)
		return -EINVAL;

	/*
	 * With hypercall interception the kernel generates its own
	 * hypercall page so it must not be provided.
	 */
	if ((xhc->flags & KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL) &&
	    (xhc->blob_addr_32 || xhc->blob_addr_64 ||
	     xhc->blob_size_32 || xhc->blob_size_64))
		return -EINVAL;

	mutex_lock(&kvm->arch.xen.xen_lock);

	if (xhc->msr && !kvm->arch.xen_hvm_config.msr)
		static_branch_inc(&kvm_xen_enabled.key);
	else if (!xhc->msr && kvm->arch.xen_hvm_config.msr)
		static_branch_slow_dec_deferred(&kvm_xen_enabled);

	old_flags = kvm->arch.xen_hvm_config.flags;
	memcpy(&kvm->arch.xen_hvm_config, xhc, sizeof(*xhc));

	mutex_unlock(&kvm->arch.xen.xen_lock);

	if ((old_flags ^ xhc->flags) & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE)
		kvm_make_all_cpus_request(kvm, KVM_REQ_CLOCK_UPDATE);

	return 0;
