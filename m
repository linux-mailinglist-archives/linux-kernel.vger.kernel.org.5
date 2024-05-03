Return-Path: <linux-kernel+bounces-167803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E338BAF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313DB1C22314
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2BF48788;
	Fri,  3 May 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/px9BW4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD148CCC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748825; cv=none; b=XW9cCHaQ/YAHvZ1VMqoBBPPaGjZLoqwvjUfFe/GQ60rXqrr3ktvJhCoi+dyUH0sIPxppLrGndVnIq80JfCdPIs49FR6IlLI6/GuKL9FTweeRQU7ID1yXLOU88DuRQJPuVEBkz9QT3NLzoXbuTwokMl1kp/Z58lxVlMgUYCvFsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748825; c=relaxed/simple;
	bh=k9s24ntmSBOewn9Zrhb/0BIr0dPxZe+x4zy/XWS4LFU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fr6ypIlJVbkVSijbDzL4dQCdST9HlSTtM8oQVWV8wJic3WWkzxwSbUJhxeMEtpDlCFkT1pnotRuZbxJwXFS00PAHV3YiAx1XDhvT8vm6MIrsiHtaJkMVd42KkUo9wCAzoDyizf+BM/H9e1OEmW1F56mN9BwBED4PefvKdJuTzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/px9BW4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQPeshu6niEUNuSz35jaYgA/Ulg7rIGCZOHChBJq76g=;
	b=H/px9BW4BEV7vxu3at67Y8ZrABHb04fnXXxUugfM1sFBwDKVacxbnXY3ZsbB+rLgabfxix
	61dVIAa7BwG2gHBT55SU/A4N8VzQ3t1Mzg3Cduqv2v8mMyEihKhzyDPc6LQ4YBSC0YnaUc
	CFtu3jeiQLB/RfvNRoS3j2Ma77F/LJ4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-99TA8MUPMLm18LY02gF2Qg-1; Fri, 03 May 2024 11:07:01 -0400
X-MC-Unique: 99TA8MUPMLm18LY02gF2Qg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a0c9092176so89749986d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748821; x=1715353621;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQPeshu6niEUNuSz35jaYgA/Ulg7rIGCZOHChBJq76g=;
        b=VF0+hoZd53L4pKdJrClOpipDT24HWKCgIhNZgIx/Jd7BdXXahHUwpA0fP+B1EcDTzi
         IgCTb5xVOyIenf89tBtf6W+2XsAEUMbjcsyOKI34yRM0WyRoUsVBQs5d/tIpp9oBLbVw
         +AkVyNlX3QjDF9Dn9QvlBj31j3B6Jwmm14yO3PnTdKZVcKQhw1X+afNSusshNXZwldT6
         mYiOJRRtGHqI+3RcDoy608tLDKeiRlTyFmZg9zG1MhrgXwzCvD3aFLQBZsZxQX3BnSSR
         DqOYJZazQjxxhx0QyRjbEhlwJzKdXLVVx1GpNi137XPvSHyhQCaM3sxoRtrVY6z4mrM9
         n7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWlKJUltHUxiB0RIITnI9VlRfNucIUkZfUxZGSx0r0zqqaS1U4nZto8Xadtu8NodvAn+78104IFG2F9xtoUd5LnZU7J8JlglczVI8Sc
X-Gm-Message-State: AOJu0Yz4RI2n31z+9HdXDMXoIqZk5t1WNi+u5/EcDCq2OdOUT9rFRpJR
	HkV4/mCwxkYsNW7TFITk1cbrdmchEbGfuI2tfp0vdTshDwSzmx2TfAqiwKbcEvs4IFJK+2r+W+m
	zwnnzzYVEdXPejlJrk8QZGG2OLAXyGCBUxC/0eGGRHn7rpKHBi+d9Ce3PgIth8g==
X-Received: by 2002:a05:6214:1d28:b0:6a0:7e1b:94b2 with SMTP id f8-20020a0562141d2800b006a07e1b94b2mr3500219qvd.16.1714748820812;
        Fri, 03 May 2024 08:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE58nX1yMSsXx8T4M1bwWkbRW6TndZK2zPSzImpXTW1iQHJ+hiY0QElGI8RXi6FLWzqh7lbjg==
X-Received: by 2002:a05:6214:1d28:b0:6a0:7e1b:94b2 with SMTP id f8-20020a0562141d2800b006a07e1b94b2mr3500172qvd.16.1714748820323;
        Fri, 03 May 2024 08:07:00 -0700 (PDT)
Received: from rh (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id f19-20020ac84713000000b00437392f1c20sm1652949qtp.76.2024.05.03.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:07:00 -0700 (PDT)
Date: Fri, 3 May 2024 17:06:54 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/6] KVM: arm64: unify trap setup code
In-Reply-To: <ZjHmX_O7KTInLuL5@linux.dev>
Message-ID: <5c17b8e9-9281-f6ef-df71-11821e19b112@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com> <20240426104950.7382-3-sebott@redhat.com> <ZjHmX_O7KTInLuL5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 1 May 2024, Oliver Upton wrote:
> On Fri, Apr 26, 2024 at 12:49:46PM +0200, Sebastian Ott wrote:
>> There are 2 functions to set up traps via HCR_EL2:
>
> nitpick: these functions *calculate* the trap values, but do not
> actually set them up. HCR_EL2 doesn't get written to until further down
> the line on KVM_RUN.
>
>> +	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB)) {
>> +		vcpu->arch.hcr_el2 |= HCR_FWB;
>> +	} else {
>> +		/*
>> +		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
>> +		 * get set in SCTLR_EL1 such that we can detect when the guest
>> +		 * MMU gets turned on and do the necessary cache maintenance
>> +		 * then.
>> +		 */
>> +		vcpu->arch.hcr_el2 |= HCR_TVM;
>> +	}
>
> It seems to me like calling this once for the lifetime of a vCPU will
> break non-FWB behavior.
>
> Like the comment suggests, these traps are needed to catch the moment
> the S1 MMU is turned on and do cache maintenance to make sure D$ agrees
> with what the guest was doing before enabling the MMU.
>
> KVM_ARM_VCPU_INIT resets SCTLR_EL1, but it seems we'd miss setting
> HCR_TVM in that case.

Ugh, I didn't think about KVM_ARM_VCPU_INIT being called more than once.

But in that case don't we loose the changes done to hcr_el2 in the current
code? E.g.:

void kvm_init_sysreg(struct kvm_vcpu *vcpu)
{
..
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		vcpu->arch.hcr_el2 |= HCR_TTLBOS;
..
}

static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
{
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
..
}

Thanks,
Sebastian


