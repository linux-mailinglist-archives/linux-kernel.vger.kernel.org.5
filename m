Return-Path: <linux-kernel+bounces-86744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B786CA19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1FA28519C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A17E56F;
	Thu, 29 Feb 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa0GGqSL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F97E111
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212838; cv=none; b=g2B93rlTMrMAG2HfJ6arqvxo3zzlt3mJVdQOS9pp+SoljUN2ZpMruqN7USB3SCqijG8YEN133JFuLQxiuT+RpPFY3mSGzINZUVrD9C65JK4pu1BZhR18SmTXepGJjyCZF6qepXWE5CKPQALy2F0QClninfKTLSsgOu7T7K21tFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212838; c=relaxed/simple;
	bh=2mDKZoNhqA6KwiIyJMf1WwliOgLL4LslKSfwI69kzRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+RKUJ6EerFh3fptzupAwOiCCiqsv26+LdTpDegX/RAPssZikdDzaeZL5SD8ZcbErOgXMwTLkl7Lzfr8VSCQPMS2U+O02E9lUIO0E38arEUZ7aXLzkAWcmgdgoZiNySEkkX+bXY/IO/rf+a6Tq6aDFOVJRGG7nHPfdARPobBMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oa0GGqSL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709212835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8FPvNCThAzMGWf/6aelSKyJOfzZ8ye0pmRD0bMhP8w=;
	b=Oa0GGqSLUrGx7242d7RStPKaqW4W4hKFCaR2W6ijoG0M/S46oWM6k2hZfRmlN3mRRfgYWp
	XFLz2r3geD8vUAP3JmNTpq0dGi16MpVqHFkyv1L7SL09A4fTDPSlFShbctOQXtCZ8KqMPD
	MU/du6/hQvemjBR1Cbd9bB+UFm793vY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-PjWL3gDsO7yJYZ_4c0RDJA-1; Thu, 29 Feb 2024 08:20:33 -0500
X-MC-Unique: PjWL3gDsO7yJYZ_4c0RDJA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33e0d943844so233964f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212832; x=1709817632;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8FPvNCThAzMGWf/6aelSKyJOfzZ8ye0pmRD0bMhP8w=;
        b=ljEw4mL9SqBrig0kPEKezJIrQG6M9RtiugezEwcxPOV9N7xiOzCqjRdyl9reoQkJ9O
         53YzjksOgid8HlsFgc0f2JRfk0bY7Bl0FtGzGqlliYCLh0y3rWAB+dv8o2xhYxSB2ZKp
         ej2nH7pHqH6dDS6wOYwwRIKy/lFUicPGjSgFbLyYoc5STEfPhe6u5HeNEJjFoA5hRePC
         WfqkaZTNNF0YfjILW2QxlkM6y+ZsJzgh3Udf+MQ+9z9xXxeUDZg7GD6BUkXC8aXb0XE0
         cGWG6Lba+IDvKZ/WipKtmIzFDPD6KlTMzPqTlxQjXskQeul2blSA6+6GjiFjOekIq8cK
         qUlw==
X-Forwarded-Encrypted: i=1; AJvYcCW1RslIDDLYRfHN/otn2nClMb0Cz3gv0YDksXcDtt/SAlaTJFV2SiDmmvZdiuBXMd48JmP0R+q2Rju6YPboGCRfYFIjwJOdCmc/NOG6
X-Gm-Message-State: AOJu0YwFWh+qC4AHknqLKQ2VPTF5yWpzvWpMeoi2fWvXa4v/+TyvvZjN
	o+ZKZukNHMxSHK5qtyia5rSZELub5t/LTHYFxtHr3NbsqldNoy/QhLaf4aTxVXxmA4dbndGVlgC
	003/4AxZcBF3mNDmWSj1Dle9TxJkMzSCMmKvNgpyBLxF0G8cXK9BIQC5mOwn7xPSOnp7zlgusby
	aDBBHxHcDBP1pKhPeY7UG38LPx03dR7FATR7RtanlZqz8rGA==
X-Received: by 2002:adf:9c8d:0:b0:33e:90f:4f6f with SMTP id d13-20020adf9c8d000000b0033e090f4f6fmr1646318wre.14.1709212832700;
        Thu, 29 Feb 2024 05:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiuVF8842wUv3u08GXziRB44OGXBOBvG0f/dEr/pahBbe2rNRTTSWeFPE8Np93pekFUHFT4A==
X-Received: by 2002:adf:9c8d:0:b0:33e:90f:4f6f with SMTP id d13-20020adf9c8d000000b0033e090f4f6fmr1646293wre.14.1709212832208;
        Thu, 29 Feb 2024 05:20:32 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id g25-20020adfa499000000b0033d6c928a95sm1771693wrb.63.2024.02.29.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:20:31 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Li RongQing
 <lirongqing@baidu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: Use actual kvm_cpuid.base for clearing
 KVM_FEATURE_PV_UNHALT
In-Reply-To: <Zd_BY8Us6TYNBueI@google.com>
References: <20240228101837.93642-1-vkuznets@redhat.com>
 <20240228101837.93642-3-vkuznets@redhat.com> <Zd_BY8Us6TYNBueI@google.com>
Date: Thu, 29 Feb 2024 14:20:30 +0100
Message-ID: <87h6hrmmox.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Feb 28, 2024, Vitaly Kuznetsov wrote:
>> @@ -273,6 +273,7 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>>  				       int nent)
>>  {
>>  	struct kvm_cpuid_entry2 *best;
>> +	struct kvm_hypervisor_cpuid kvm_cpuid;
>>  
>>  	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
>>  	if (best) {
>> @@ -299,10 +300,12 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>>  		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
>>  		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
>>  
>> -	best = __kvm_find_kvm_cpuid_features(vcpu, entries, nent);
>> -	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
>> -		(best->eax & (1 << KVM_FEATURE_PV_UNHALT)))
>> -		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
>> +	kvm_cpuid = __kvm_get_hypervisor_cpuid(entries, nent, KVM_SIGNATURE);
>> +	if (kvm_cpuid.base) {
>> +		best = __kvm_find_kvm_cpuid_features(entries, nent, kvm_cpuid.base);
>> +		if (kvm_hlt_in_guest(vcpu->kvm) && best)
>> +			best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
>> +	}
>>  
>>  	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
>>  		best = cpuid_entry2_find(entries, nent, 0x1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
>
> Not now, as we need a minimal fix, but we need to fix the root problem, this is
> way to brittle.  Multiple helpers take @vcpu, including __kvm_update_cpuid_runtime(),
> before the incoming CPUID is set.  That's just asking for new bugs to
> crop up.

Yes, I'm all for making this all more robust but I think it would be
nice to have a smaller, backportable fix for the real, observed issue first.

>
> Am I missing something, or can we just swap() the new and old, update the new
> in the context of the vCPU, and then undo the swap() if there's an issue?
> vcpu->mutex is held, and accessing this state from a different task is wildly
> unsafe, so I don't see any problem with temporarily having an in-flux state.
>

I don't see why this approach shouldn't work and I agree it looks like
it would make things better but I can't say that I'm in love with
it. Ideally, I would want to see the following "atomic" workflow for all
updates:

- Check that the supplied data is correct, return an error if not. No
changes to the state on this step.
- Tweak the data if needed.
- Update the state and apply the side-effects of the update. Ideally,
there should be no errors on this step as rollback can be
problemmatic. In the real world we will have to handle e.g. failed
memory allocations here but in most cases the best course of action is
to kill the VM.

Well, kvm_set_cpuid() is not like that. At least:
- kvm_hv_vcpu_init() is a side-effect but we apply it before all checks
are complete. There's no way back.
- kvm_check_cpuid() sounds like a pure checker but in reallity we end up
mangling guest FPU state in fpstate_realloc()

Both are probably "no big deal" but certainly break the atomicity.

> If we want to be paranoid, we can probably get away with killing the VM if the
> vCPU has run and the incoming CPUID is "bad", e.g. to guard against something
> in kvm_set_cpuid() consuming soon-to-be-stale state.  And that's actually a
> feature of sorts, because _if_ something in kvm_set_cpuid() consumes the vCPU's
> CPUID, then we have a bug _now_ that affects the happy path.
>
> Completely untested (I haven't updated the myriad helpers), but this would allow
> us to revert/remove all of the changes that allow peeking at a CPUID array that
> lives outside of the vCPU.

Thanks, assuming there's no urgency, let me take a look at this in the
course of the next week or so.

>
> static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>                         int nent)
> {
> 	int r, i;
>
> 	swap(vcpu->arch.cpuid_entries, e2);
> 	swap(vcpu->arch.cpuid_nent, nent);
>
> #ifdef CONFIG_KVM_HYPERV
> 	if (kvm_cpuid_has_hyperv(vcpu)) {
> 		r = kvm_hv_vcpu_init(vcpu);
> 		if (r)
> 			goto err;
> 	}
> #endif
>
> 	r = kvm_check_cpuid(vcpu);
> 	if (r)
> 		goto err;
>
> 	kvm_update_cpuid_runtime(vcpu);
>
> 	/*
> 	 * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
> 	 * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> 	 * tracked in kvm_mmu_page_role.  As a result, KVM may miss guest page
> 	 * faults due to reusing SPs/SPTEs. In practice no sane VMM mucks with
> 	 * the core vCPU model on the fly. It would've been better to forbid any
> 	 * KVM_SET_CPUID{,2} calls after KVM_RUN altogether but unfortunately
> 	 * some VMMs (e.g. QEMU) reuse vCPU fds for CPU hotplug/unplug and do
> 	 * KVM_SET_CPUID{,2} again. To support this legacy behavior, check
> 	 * whether the supplied CPUID data is equal to what's already set.
> 	 */
> 	if (kvm_vcpu_has_run(vcpu)) {
> 		r = kvm_cpuid_check_equal(vcpu, e2, nent);
> 		if (r)
> 			goto err;
> 	}
>
> 	vcpu->arch.kvm_cpuid = kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE);
> #ifdef CONFIG_KVM_XEN
> 	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
> #endif
> 	kvm_vcpu_after_set_cpuid(vcpu);
>
> 	kvfree(e2);
> 	return 0;
>
> err:
> 	swap(vcpu->arch.cpuid_entries, e2);
> 	swap(vcpu->arch.cpuid_nent, nent);
> 	return r;
> }
>

-- 
Vitaly


