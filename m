Return-Path: <linux-kernel+bounces-143733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFB8A3CC3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF33F282266
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC73EA76;
	Sat, 13 Apr 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9SUDrHg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D31C2A5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013542; cv=none; b=fFUH0BOVZFD6fgs2mocmzWUBl08xmnngUpIpKAW8YT8MxoyQEg8ZY3TwNqS84ylw1f9XVvikw6iI+Rf+e6Ntqf0N1+pq0UbAQ1b8xHJjWn8SCzL1QuXSrE7gZQv2GUx1HiMjyjVKG29CiQeWMPWNFnzweXsJcTfJnRMDlS8Kx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013542; c=relaxed/simple;
	bh=9mQps6gBriAa691971K8dp+F7qu3ElBTZlsuuOPGNuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YKzibZIeqQIeXy1vIMIuFKHagigU299aRVFdK17sp3r4/YLl4+c8mgfKeqEuV8kcRE+xhtq7jI+F7xXCnRoUdV/4cBocOyqd4lt/gTt6yhIBqYZwXH15M8Yr/kF/weqIQfY+aqX3Vlxtux+0BihNJ12tkwFyEzKRpxjZxkvHT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9SUDrHg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713013538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjC/r8afP2Rq17fs73k7VkcEwW9IeRku59pv+b0GDdk=;
	b=E9SUDrHgjujbIK6V4uLxulC/qGN2i7ZI2x+VISFPUaqzzgaQX0jWr1ZZUbBbT2ygsytljd
	J6Ol9WW5RA8T8FQLlZbjDMUZU0eqthQ8Y1AxXh/Y5vVs6pE59ojvfeezH0QygVjKsnCvQW
	oWGRn3e3SbPxBul9uRz9bimVdqeZtmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-_BoiXWH_O5STI0cNsjwTKA-1; Sat, 13 Apr 2024 09:05:33 -0400
X-MC-Unique: _BoiXWH_O5STI0cNsjwTKA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416a844695dso9429775e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713013532; x=1713618332;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjC/r8afP2Rq17fs73k7VkcEwW9IeRku59pv+b0GDdk=;
        b=NVwIjssUtJyyj3XaiN0wR20KczwjlVwHJQLXI+hNPr9n4CshsqC3mEoXk0XrJzVNEo
         cARTK31idJRu3tIbtOtvAY0HaP9pEzXsFGqvrg3gEkqFbbBnDZoiN2HArsbQm8GEgGLT
         NwIWUOSdn8pY0Nao4dUq6s9tAUoE1BcHt2ky2nM4T9YAanZsSuUTPld9G74ZoN/Fvx8m
         llFafifzMxwH19V3edj8czZ7SluKsvAioeW7t2ebpuETEvbYs09qs44ViYb0A7uX/hzH
         xYI+jaAO5jYpDcJwFW+hLESgUunU+HSCRv4ZTFymKj+yvxNwWfLpWIC7IgI/igkrB7Up
         e56A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/GP/raT9cvd+OkkkyxLM+a9THCyf9vRNN2nAkiR2GSVuICrWXMw55BWXUj1Vi7Vbof6ZaFa/vVMA+EOHyebNA2wOnhNVvq1wE8dl
X-Gm-Message-State: AOJu0YyjExC6Y3CLaRXAVV/RjGXAcEOnRywoDL4RbbSoL9pbm049Xs2p
	XAu7eXncN8/bWFZpeKdwvkCWLJ6Zp4QYCbf6FuC+cCutwfPh31OaabW1Hf2rhJzd5g2//Djg+ez
	AevQ2PakuB3vg3zvjdQarnUtaTM4xN2Os2nGOCn0Ve/qXwyGytG/viQgMIVJEYg==
X-Received: by 2002:a05:600c:5818:b0:414:60fe:8f2b with SMTP id jz24-20020a05600c581800b0041460fe8f2bmr4636646wmb.18.1713013532597;
        Sat, 13 Apr 2024 06:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMW4dxiTvS7n2eWbssZJ0Xn/PGf10S4HVEPbaYyCkOe5omKF1qw+lfUNoMszIeJDG2JRMtxQ==
X-Received: by 2002:a05:600c:5818:b0:414:60fe:8f2b with SMTP id jz24-20020a05600c581800b0041460fe8f2bmr4636624wmb.18.1713013532067;
        Sat, 13 Apr 2024 06:05:32 -0700 (PDT)
Received: from rh (p200300c93f06ef00707ff2f902cfda41.dip0.t-ipconnect.de. [2003:c9:3f06:ef00:707f:f2f9:2cf:da41])
        by smtp.gmail.com with ESMTPSA id z17-20020a05600c0a1100b00416b8da335esm8914249wmp.48.2024.04.13.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:05:31 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:05:30 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/4] KVM: arm64: maintain per VM value for CTR_EL0
In-Reply-To: <86frvpshno.wl-maz@kernel.org>
Message-ID: <7e9c8367-6e9e-e36b-934e-170c90522134@redhat.com>
References: <20240405120108.11844-1-sebott@redhat.com> <20240405120108.11844-3-sebott@redhat.com> <86frvpshno.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 13 Apr 2024, Marc Zyngier wrote:
> On Fri, 05 Apr 2024 13:01:06 +0100,
> Sebastian Ott <sebott@redhat.com> wrote:
>>
>> In preparation for CTR_EL0 emulation maintain a per VM for this
>> register and use it where appropriate.
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h |  1 +
>>  arch/arm64/kvm/sys_regs.c         | 22 +++++++++++++++-------
>>  2 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 9e8a496fb284..481216febb46 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -318,6 +318,7 @@ struct kvm_arch {
>>
>>  	/* PMCR_EL0.N value for the guest */
>>  	u8 pmcr_n;
>> +	u64 ctr_el0;
>>
>>  	/* Iterator for idreg debugfs */
>>  	u8	idreg_debugfs_iter;
>
> Please consider the alignment of the fields. This leaves a 7 byte hole
> that could be avoided (yes, I'm on a mission to reduce the size of the
> various structures, because they are absolute pigs).

OK.

>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 131f5b0ca2b9..4d29b1a0842d 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -215,13 +215,21 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>>  #define CSSELR_MAX 14
>>
>> +static u64 kvm_get_ctr_el0(struct kvm *kvm)
>> +{
>> +	if (kvm->arch.ctr_el0)
>> +		return kvm->arch.ctr_el0;
>
> Is this relying on some bits not being 0?
>
>> +
>> +	return read_sanitised_ftr_reg(SYS_CTR_EL0);
>
> Why isn't the shadow value always populated?

The idea was for kvm->arch.ctr_el0 being non zero only if userspace
set it up to differ from the host value. So it can be used to decide
if we need to set up a trap for the reg access (without comparing it
to the host value again).

Thanks,
Sebastian


