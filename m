Return-Path: <linux-kernel+bounces-37231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D483ACF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906E628ADD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66777654;
	Wed, 24 Jan 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beX/zhwz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BF18624
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109237; cv=none; b=QNoY0z4+NGESLSYcVQMAroNYfW7IWjvqF6IiC2mkc4apDE660PwKtTgDBsCazhJIiK/DgE6AzCnkj7ipP/xMkzKqSx/xn8ZCplq+IfKdsGszPxlE2wDGDYqBeyS6vgmeJTuL0cpgGhlLjeWESdyc0ugEY+gkXqfUNNrdpjZgtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109237; c=relaxed/simple;
	bh=/nlV2b76Bb766HvGp0us13c0PkmPQgNRUTW9LQNcXTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGEzCbbmwCtD/uBo8v1aeAgR0FXY3jvRXFpDME/5GBb+/lZIoivKgiPr+CFQGn7gMWHHcudXBYd3MmwQay2tYKBiw3F8zmfMi+V/uHT5RqW4ZOQ/dh3gcSjTZ+qYc9jpvJMmpjzv+aaJVp0jr6SGTnB9tqU713vQIsNpIcyY7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beX/zhwz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706109235;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmpPYmHl13Io6EkojaUZhZmn9ypUW1G8T5NB4u+9OLg=;
	b=beX/zhwzjdHetkXSJy1kSSY+Etp934ta7hLyJASZOg9VaF0NhJI+ogoRd1DEv1VF2dzRkH
	HZFZxCKKklDxTo+enmDQPy3BKJ4tPxRkbEqtrKjFpeOC9eqYeUlomomF5lXGXYzyjBuGoe
	YoK7P+H2paXJHPjuOSLSkMMJLWJaZeY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-XYbG9tAbMjColkppj4jB0g-1; Wed, 24 Jan 2024 10:13:53 -0500
X-MC-Unique: XYbG9tAbMjColkppj4jB0g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68086d6c953so77102416d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109233; x=1706714033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmpPYmHl13Io6EkojaUZhZmn9ypUW1G8T5NB4u+9OLg=;
        b=Nj3fuJBMIQZW7A33a1nzT4k8+yYe9i8TZJeosCkcQRrTGALVwbmx/4yoRhZDP8shvo
         x2G1TJFcNpaEo8DBsyqtFzkL/stdH3kb6EorlKewhKFvCuK2U/WQowLpT14T0kSjw+gk
         EylGMIzgmsOIa5g4C7xfXk1RZlyP5a4vDbOQGmDHPIoVTI4YRuFupltFneYM8I3TskTz
         FBM1ePm5ICJ3RbgK1sRvqsmPEpNuFRjNWxWwRUu4CMtV4rTcy3jNEGvHgNMXt3X/wyH9
         VvZiUhCsmYdSJ5DtuMLq28+ACGrwyT/YQFriLAEt0SQIDHUrZNNF9JEgLLx0iBJ43aum
         JrRw==
X-Gm-Message-State: AOJu0Yw4W3uCdux6q8D4lasVJ4RGCozqookOqrFdX3e3bX3sWqT3LP3D
	HFYcb8P4PY57q/SBhTNyyIjyORrP5LsJ3fOPgEZLDkMyQva5wOGCHRKOlmec2WP1mKZ9MIQEuXA
	/AzeRSIcrFY0am0xLA+zjZv9Iv7bu1z63hpo9sxReMzP6FE7ZcWWn+foJ9+U0AA==
X-Received: by 2002:ad4:5bcc:0:b0:681:99b:ea0 with SMTP id t12-20020ad45bcc000000b00681099b0ea0mr2636942qvt.54.1706109233175;
        Wed, 24 Jan 2024 07:13:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOrCqKRabSy51esnpYkStX9FYC3518F8eYJFX1zOlKRM3AgbDzTJsl87QnO68+09jDXkknnQ==
X-Received: by 2002:ad4:5bcc:0:b0:681:99b:ea0 with SMTP id t12-20020ad45bcc000000b00681099b0ea0mr2636921qvt.54.1706109232837;
        Wed, 24 Jan 2024 07:13:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cfc0f000000b0067f2559fd5esm4562012qvo.34.2024.01.24.07.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:13:52 -0800 (PST)
Message-ID: <86b9e255-9d19-44ee-b6c4-544507756183@redhat.com>
Date: Wed, 24 Jan 2024 16:13:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 24/82] KVM: arm64: vgic: Refactor intentional wrap-around
 calculation
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Reiji Watanabe <reijiw@google.com>, Ricardo Koller <ricarkol@google.com>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Quentin Perret <qperret@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-24-keescook@chromium.org>
 <86o7dc8gu5.wl-maz@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <86o7dc8gu5.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 11:49, Marc Zyngier wrote:
> On Tue, 23 Jan 2024 00:26:59 +0000,
> Kees Cook <keescook@chromium.org> wrote:
>> In an effort to separate intentional arithmetic wrap-around from
>> unexpected wrap-around, we need to refactor places that depend on this
>> kind of math. One of the most common code patterns of this is:
>>
>> 	VAR + value < VAR
>>
>> Notably, this is considered "undefined behavior" for signed and pointer
>> types, which the kernel works around by using the -fno-strict-overflow
>> option in the build[1] (which used to just be -fwrapv). Regardless, we
>> want to get the kernel source to the position where we can meaningfully
>> instrument arithmetic wrap-around conditions and catch them when they
>> are unexpected, regardless of whether they are signed[2], unsigned[3],
>> or pointer[4] types.
>>
>> Refactor open-coded unsigned wrap-around addition test to use
>> check_add_overflow(), retaining the result for later usage (which removes
>> the redundant open-coded addition). This paves the way to enabling the
>> wrap-around sanitizers in the future.
>>
>> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
>> Link: https://github.com/KSPP/linux/issues/26 [2]
>> Link: https://github.com/KSPP/linux/issues/27 [3]
>> Link: https://github.com/KSPP/linux/issues/344 [4]
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Zenghui Yu <yuzenghui@huawei.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Reiji Watanabe <reijiw@google.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Ricardo Koller <ricarkol@google.com>
>> Cc: Raghavendra Rao Ananta <rananta@google.com>
>> Cc: Quentin Perret <qperret@google.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.linux.dev
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/kvm/vgic/vgic-kvm-device.c |  6 ++++--
>>  arch/arm64/kvm/vgic/vgic-v2.c         | 10 ++++++----
>>  2 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
>> index f48b8dab8b3d..0eec5344d203 100644
>> --- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
>> +++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
>> @@ -18,17 +18,19 @@ int vgic_check_iorange(struct kvm *kvm, phys_addr_t ioaddr,
>>  		       phys_addr_t addr, phys_addr_t alignment,
>>  		       phys_addr_t size)
>>  {
>> +	phys_addr_t sum;
>> +
>>  	if (!IS_VGIC_ADDR_UNDEF(ioaddr))
>>  		return -EEXIST;
>>  
>>  	if (!IS_ALIGNED(addr, alignment) || !IS_ALIGNED(size, alignment))
>>  		return -EINVAL;
>>  
>> -	if (addr + size < addr)
>> +	if (check_add_overflow(addr, size, &sum))
>>  		return -EINVAL;
>>  
>>  	if (addr & ~kvm_phys_mask(&kvm->arch.mmu) ||
>> -	    (addr + size) > kvm_phys_size(&kvm->arch.mmu))
>> +	    sum > kvm_phys_size(&kvm->arch.mmu))
> nit: 'sum' doesn't mean much in this context. Something like 'end'
> would be much more descriptive.
>
>>  		return -E2BIG;
>>  
>>  	return 0;
>> diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
>> index 7e9cdb78f7ce..c8d1e965d3b7 100644
>> --- a/arch/arm64/kvm/vgic/vgic-v2.c
>> +++ b/arch/arm64/kvm/vgic/vgic-v2.c
>> @@ -273,14 +273,16 @@ void vgic_v2_enable(struct kvm_vcpu *vcpu)
>>  /* check for overlapping regions and for regions crossing the end of memory */
>>  static bool vgic_v2_check_base(gpa_t dist_base, gpa_t cpu_base)
>>  {
>> -	if (dist_base + KVM_VGIC_V2_DIST_SIZE < dist_base)
>> +	gpa_t dist_sum, cpu_sum;
> Same here: dist_end, cpu_end.
I do agree.
>
>> +
>> +	if (check_add_overflow(dist_base, KVM_VGIC_V2_DIST_SIZE, &dist_sum))
>>  		return false;
>> -	if (cpu_base + KVM_VGIC_V2_CPU_SIZE < cpu_base)
>> +	if (check_add_overflow(cpu_base, KVM_VGIC_V2_CPU_SIZE, &cpu_sum))
>>  		return false;
>>  
>> -	if (dist_base + KVM_VGIC_V2_DIST_SIZE <= cpu_base)
>> +	if (dist_sum <= cpu_base)
>>  		return true;
>> -	if (cpu_base + KVM_VGIC_V2_CPU_SIZE <= dist_base)
>> +	if (cpu_sum <= dist_base)
>>  		return true;
>>  
>>  	return false;
> With these nits addressed, and assuming you intend to merge the whole
> series yourself:
>
> Acked-by: Marc Zyngier <maz@kernel.org>
assuming above suggested changes,

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> 	M.
>


