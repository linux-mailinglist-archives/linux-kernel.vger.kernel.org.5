Return-Path: <linux-kernel+bounces-143740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A18A3CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A80D1C20C08
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292E41A85;
	Sat, 13 Apr 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geJIEv8C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A513ADA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713016255; cv=none; b=gJ1jThzyzOgSffSzJ8GkN57/loSdHmA2X/IbXOWZkY8w0o7CWIGPysVQb6vPrk1xGRIIJltQLcYG/FSUwmB9ht73ZaxFtteDuTl+XODhS5JsMvPEEi7+fEh1fkcta24eeB0j0jz4bKV7jF3pC5BKK0+wPznk+KH9gaXV9wxiTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713016255; c=relaxed/simple;
	bh=/Wp4z41l7GSq00qi0B0zQ/9gstNhaoH4/qJW/M6a1wo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cm6+PrDgk+vbRUHBlalousjVh0XpnPwUQuiEeJag7wIfGSjyZLq3eHX5+ID0lB3iJDdSJPy9smbYAUmBYroCOluX8gXjIXTvgAlbcKb2fqqolOnq0Ny7i0vSr7IFewDjuP9UPMx8LH3tNZ28N7ZmxYFwvm525BUaT41EamodiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geJIEv8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713016252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfxneuIcungA17hPOHjxsVd+stn+fj302KPTrsVQwYQ=;
	b=geJIEv8CJSPkABp3kbWhuAh1mQb55IQ9Q2e9Q7dU1hN3E/OxV2zC2uatzeEo0NNOeOlI2x
	Ras0fwUiipLeoZLtuYjqoebcuK9+1mkSYaVUZqS+HjRBObHTZ/OdSRIpO9FDAh0LDOFkht
	AVkI+ZMEXRZgVL3Gqw9+DVaHTweUDeI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-9lqkt3RVM92KAIWI6gKfuQ-1; Sat, 13 Apr 2024 09:50:50 -0400
X-MC-Unique: 9lqkt3RVM92KAIWI6gKfuQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6156cef8098so32677487b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713016248; x=1713621048;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfxneuIcungA17hPOHjxsVd+stn+fj302KPTrsVQwYQ=;
        b=QpN/bn8aeMgkF/B95W40tRu5zb56RamdGL92e3xvSqf8AEVlDM1HJfa+wQL1APtMo2
         PmDtCysjMhKZ8KRXJrV1Sllc7eINs1aK4fEEJH7lx6wLuQBQvB3nEkownhhGgH8wDGTe
         aPkJZyiUQtdnBzpKohTpppjrL6sIyrbuCBu0wbmHC8md42oHVMGLckZv0dW3KKXfgjKp
         A0N2+pMO/Sxz2cu205ThBHab+mxC1S/6Oq4763en2ETG/LozD6cyGPuCyBPVpScMo36q
         i+EY5N6A91o4WdYeRlWFHH/GlljTkoqz4YuA1NEt6lNpGR3PQsSMmO6J2qXJAbVCrODx
         8Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCWNTFAwTDhyEjNB5kWWf3mIgE0P4u7aY2NR5b9LdgAuU/iXshVqgb6gKzS5KIQL9H0ZwJc88GCs+POeLqw0h+KuqQmc/8APnE83hf02
X-Gm-Message-State: AOJu0YwNYUTfBEG/8Mtax1wQSOQHdm/ZqRWzyRFif4oGkKDIGauJGHK/
	YmjryJCNU1iTalBJCs2bYueN/ifjKSWeswvlZZdvs+61tB8Mnu1q/UaIVJy/hH+UHL/p5sRKseS
	we/b97DOcAYJc1cyXle/UJ7+FZxrMKWYu7vNrJASVWzDQtdkKzjDVmKmVcKfltEVcWBa6UQ==
X-Received: by 2002:a0d:e613:0:b0:61a:b2a9:dc58 with SMTP id p19-20020a0de613000000b0061ab2a9dc58mr600963ywe.23.1713016248295;
        Sat, 13 Apr 2024 06:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUU/wcGG0i7VtyjxL8D1hG4jyIwIOMO8Z4XazdFkI8fzm6vh/yKwcin2u0V4sV9EmroouIjA==
X-Received: by 2002:a0d:e613:0:b0:61a:b2a9:dc58 with SMTP id p19-20020a0de613000000b0061ab2a9dc58mr600943ywe.23.1713016248009;
        Sat, 13 Apr 2024 06:50:48 -0700 (PDT)
Received: from rh (p200300c93f06ef00707ff2f902cfda41.dip0.t-ipconnect.de. [2003:c9:3f06:ef00:707f:f2f9:2cf:da41])
        by smtp.gmail.com with ESMTPSA id eu11-20020ad44f4b000000b0069b110a644csm3691725qvb.129.2024.04.13.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:50:47 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:50:42 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/4] KVM: arm64: add emulation for CTR_EL0 register
In-Reply-To: <86edb9sgy0.wl-maz@kernel.org>
Message-ID: <7cc16dc9-6eef-59f9-d019-8b5dea6a4254@redhat.com>
References: <20240405120108.11844-1-sebott@redhat.com> <20240405120108.11844-4-sebott@redhat.com> <86edb9sgy0.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 13 Apr 2024, Marc Zyngier wrote:

> On Fri, 05 Apr 2024 13:01:07 +0100,
> Sebastian Ott <sebott@redhat.com> wrote:
>>
>> CTR_EL0 is currently handled as an invariant register, thus
>> guests will be presented with the host value of that register.
>> Add emulation for CTR_EL0 based on a per VM value.
>>
>> When CTR_EL0 is changed the reset function for CLIDR_EL1 is
>> called to make sure we present the guest with consistent
>> register values.
>
> Isn't that a change in the userspace ABI? You are now creating an
> explicit ordering between the write to CTR_EL0 and the rest of the
> cache hierarchy registers. It has the obvious capacity to lead to the
> wrong result in a silent way...

Yea, that's why I've asked in the cover letter if userspace would be
ok with that. I thought that this is what you suggested in your reply
to the RFC. 
(https://lore.kernel.org/linux-arm-kernel/20240318111636.10613-5-sebott@redhat.com/T/#m0aea5b744774f123bd9a4a4b7be6878f6c737f63)

But I guess I've got that wrong.

Do we have other means to handle the dependencies between registers?
Allow inconsistent values and do a sanity check before the first
vcpu_run()?

>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 72 ++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 64 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 4d29b1a0842d..b0ba292259f9 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1874,6 +1874,55 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>>  	return true;
>>  }
>>
>> +static u64 reset_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
>> +{
>> +	vcpu->kvm->arch.ctr_el0 = 0;
>> +	return kvm_get_ctr_el0(vcpu->kvm);
>
> I'd expect the cached value to be reset instead of being set to
> 0. What are you achieving by this?

The idea was that kvm->arch.ctr_el0 == 0 means we use the host value and
don't set up a trap.

>> +}
>> +
>> +static int get_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>> +		   u64 *val)
>> +{
>> +	*val = kvm_get_ctr_el0(vcpu->kvm);
>> +	return 0;
>> +}
>> +
>> +static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding);
>> +
>> +static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>> +		   u64 val)
>> +{
>> +	u64 host_val = read_sanitised_ftr_reg(SYS_CTR_EL0);
>> +	u64 old_val = kvm_get_ctr_el0(vcpu->kvm);
>> +	const struct sys_reg_desc *clidr_el1;
>> +	int ret;
>> +
>> +	if (val == old_val)
>> +		return 0;
>> +
>> +	if (kvm_vm_has_ran_once(vcpu->kvm))
>> +		return -EBUSY;
>> +
>> +	mutex_lock(&vcpu->kvm->arch.config_lock);
>> +	ret = arm64_check_features(vcpu, rd, val);
>> +	if (ret) {
>> +		mutex_unlock(&vcpu->kvm->arch.config_lock);
>> +		return ret;
>> +	}
>> +	if (val != host_val)
>> +		vcpu->kvm->arch.ctr_el0 = val;
>> +	else
>> +		vcpu->kvm->arch.ctr_el0 = 0;
>> +
>> +	mutex_unlock(&vcpu->kvm->arch.config_lock);
>> +
>> +	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
>> +	if (clidr_el1)
>> +		clidr_el1->reset(vcpu, clidr_el1);
>> +
>> +	return 0;
>
> No check against what can be changed, and in what direction? You seem
> to be allowing a guest to migrate from a host with IDC==1 to one where
> IDC==0 (same for DIC). How can that work? Same for the cache lines,
> which can be larger on the target... How will the guest survive that?

Shouldn't this all be handled by arm64_check_features() using the safe
value definitions from ftr_ctr? (I'll double check that..)

>> @@ -4049,6 +4102,9 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
>>  			vcpu->arch.hcrx_el2 |= (HCRX_EL2_MSCEn | HCRX_EL2_MCE2);
>>  	}
>>
>> +	if (vcpu->kvm->arch.ctr_el0)
>> +		vcpu->arch.hcr_el2 |= HCR_TID2;
>
> Why trap CTR_EL0 if the values are the same as the host?

For values same as host vcpu->kvm->arch.ctr_el0 would be zero and
reg access would not be trapped.

> I really dislike the use of the value 0 as a such an indication.

OK.

> Why isn't this grouped with the traps in vcpu_reset_hcr()?

I was under the impression that vcpu_reset_hcr() is called too early
to decide if we need to set up a trap or not (but lemme double check
that).

Thanks,
Sebastian


