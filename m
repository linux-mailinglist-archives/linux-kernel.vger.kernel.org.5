Return-Path: <linux-kernel+bounces-108106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8588060D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D808D283B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F263BBD5;
	Tue, 19 Mar 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y30eCtPJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5303BBDC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880222; cv=none; b=WS8vqijLHBoPzvHqjoaFHzlhOttHRddgcEGjqBYKtKysxXytsARVlDLhY77QB5oqSzcqWZI36GfPLfLRQspNOk3164QU1z1Arp9HoPiuIgdu6Ur+iE4ZMKdK++rLMRFO9E6JFs/Iu8ts0/WPcrGDZ2CUaBYLcmBBnpuuGp0gCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880222; c=relaxed/simple;
	bh=IRIfD3+L1gRgBkauZWudIzMbGpwAbCl9haZpcCUCOZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kt3q3zDOgDI/UJKwicQ4ufs3x35dzvPNit6ugUCgPg/swfVgGm2gS+2+6DbGs3bGfYAFrL7SZ2uEYQMCltDZ7cxyfvhk4JnrizKf2LfzwoKfYHxwP8thUpTSOdtopYbg9Xij1OAdXyVTk4RAKyd8IeXX8fEHJtbJzWIwdmZBvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y30eCtPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710880218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJcKUBP5KtgpxkjAttKx3Lfn/GnCpsO3wNpLIAcoyKg=;
	b=Y30eCtPJ8n+BARXXHh7aNtIySAsY2ZoVI93vfqO9mDSCqaFEqULZj40HP7I4p134+Qpi6w
	gbyplvXPxzTdwd35twdIzHNMaSkG2YysI8QcLxLyVP+GrAY+/bHy4jEbEmRzQGLoAJKBek
	6A1rR8/ikyjkQXyUOKALnOI8objkuzo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-72OgGxrHPR-y4ikPGseNww-1; Tue, 19 Mar 2024 16:30:16 -0400
X-MC-Unique: 72OgGxrHPR-y4ikPGseNww-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6963cd45fddso5635396d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710880213; x=1711485013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJcKUBP5KtgpxkjAttKx3Lfn/GnCpsO3wNpLIAcoyKg=;
        b=hgc2Ksckzu5Kam7jNcStI5mpwwIomLp4I7Hw0J4SU+ASd3Dx/T/9H9Nfu7Yejg6Cas
         vTbDqx0In0TIE3QYG++lw+moinCbGwN9BeUHje8IFAOVUk/uDr6QW+rD6uI8BO/SooY6
         YeplAqHUNK53bRAC5dtkiwJiqTtBw9rXUItG1XsEDK6t+AMSDN07vtuo6DSCBiBY+Rq1
         sLAWXTKsUohjMBm8GbsgiHfXG/wBvYAk9+GP7HlmQATkwSUcKQXrd47stan9N6/v3CR9
         qvVDrTGW9pk5ii6kQX1yqHmpG84QbEDlhSlHA1xxHGbRonnNy2riZ274g1JMKTIKZVoR
         xjGg==
X-Forwarded-Encrypted: i=1; AJvYcCXlQ4yGOjvcB49PD4Y8qnTFszeRc+ottea4fZQ8pLJxuiQZN6cQzR+EakYsUWJtlsZdCOby3QQHSOeqvSRnTnhdJL6E0rFVP0ahDzdA
X-Gm-Message-State: AOJu0YwcGesKgmwF2cu0RobQZ1APmXFaW9z/VYzGgSJWpNxFklTrolnv
	dPbHWTst0mJVexteCY8r4RqsXX89Z4wWZ6iduJgWB3F1hxtMXftgbTuXM2CI3XV8Yh8o3NYqp2X
	KU+s763A5GPoxa0r8EB8l4NOivX8gSR2z6MikWcYXEjpg70H7CnGiw2f9AfDtIw==
X-Received: by 2002:a05:6214:20e9:b0:696:2134:95e5 with SMTP id 9-20020a05621420e900b00696213495e5mr6880936qvk.3.1710880213439;
        Tue, 19 Mar 2024 13:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Q8Bm9oZUORJeL5W/Q3SGx2NF/EAq09INGQaoFBMQT3hmjqIot8jrQhEf4vtzZp+fEQaMVw==
X-Received: by 2002:a05:6214:20e9:b0:696:2134:95e5 with SMTP id 9-20020a05621420e900b00696213495e5mr6880899qvk.3.1710880213108;
        Tue, 19 Mar 2024 13:30:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id q15-20020a056214194f00b0069183f7fc99sm5075947qvk.144.2024.03.19.13.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 13:30:12 -0700 (PDT)
Message-ID: <b140af6e-7594-48c6-8021-800cd1d0f2c7@redhat.com>
Date: Tue, 19 Mar 2024 21:30:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] KVM: selftests: aarch64: Add helper function for
 the vpmu vcpu creation
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, Oliver Upton
 <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev
Cc: James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240229065625.114207-1-shahuang@redhat.com>
 <20240229065625.114207-2-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240229065625.114207-2-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 2/29/24 07:56, Shaoqin Huang wrote:
> Create a vcpu with vpmu would be a common requirement for the vpmu test,
> so add the helper function for the vpmu vcpu creation. And use those
> helper function in the vpmu_counter_access.c test.
> 
> Use this chance to delete the meaningless ASSERT about the pmuver,
> because KVM does not advertise an IMP_DEF PMU to guests.
> 
> No functional changes intended.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/vpmu_counter_access.c         | 33 ++++---------------
>  .../selftests/kvm/include/aarch64/vpmu.h      | 29 ++++++++++++++++
>  2 files changed, 36 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> index 5f9713364693..e068a0a7a43b 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> @@ -16,6 +16,7 @@
>  #include <processor.h>
>  #include <test_util.h>
>  #include <vgic.h>
> +#include <vpmu.h>
>  #include <perf/arm_pmuv3.h>
>  #include <linux/bitfield.h>
>  
> @@ -426,18 +427,8 @@ static void guest_code(uint64_t expected_pmcr_n)
>  /* Create a VM that has one vCPU with PMUv3 configured. */
>  static void create_vpmu_vm(void *guest_code)
>  {
> -	struct kvm_vcpu_init init;
> -	uint8_t pmuver, ec;
> -	uint64_t dfr0, irq = 23;
> -	struct kvm_device_attr irq_attr = {
> -		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
> -		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
> -		.addr = (uint64_t)&irq,
> -	};
> -	struct kvm_device_attr init_attr = {
> -		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
> -		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
> -	};
> +	uint8_t ec;
> +	uint64_t irq = 23;
>  
>  	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
>  	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> @@ -449,27 +440,17 @@ static void create_vpmu_vm(void *guest_code)
>  					guest_sync_handler);
>  	}
>  
> -	/* Create vCPU with PMUv3 */
> -	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
> -	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
> -	vpmu_vm.vcpu = aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_code);
> +	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
>  	vcpu_init_descriptor_tables(vpmu_vm.vcpu);
> +
>  	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
>  					GICD_BASE_GPA, GICR_BASE_GPA);
>  	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
>  		       "Failed to create vgic-v3, skipping");
>  
> -	/* Make sure that PMUv3 support is indicated in the ID register */
> -	vcpu_get_reg(vpmu_vm.vcpu,
> -		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
> -	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), dfr0);
> -	TEST_ASSERT(pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
> -		    pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP,
> -		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
> -
>  	/* Initialize vPMU */
> -	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
> -	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
> +	vpmu_set_irq(vpmu_vm.vcpu, irq);
> +	vpmu_init(vpmu_vm.vcpu);
>  }
>  
>  static void destroy_vpmu_vm(void)
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> new file mode 100644
> index 000000000000..0dfcc7ab1c4d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <kvm_util.h>
> +
> +static inline struct kvm_vcpu *vm_vcpu_add_with_vpmu(struct kvm_vm *vm,
> +						     uint32_t vcpu_id,
> +						     void *guest_code)
> +{
> +	struct kvm_vcpu_init init;
> +
> +	/* Create vCPU with PMUv3 */
> +	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> +	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
> +
> +	return aarch64_vcpu_add(vm, 0, &init, guest_code);
> +}
> +
> +static void vpmu_set_irq(struct kvm_vcpu *vcpu, int irq)
> +{
> +	kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +			    KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
> +}
> +
> +static void vpmu_init(struct kvm_vcpu *vcpu)
> +{
> +	kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +			    KVM_ARM_VCPU_PMU_V3_INIT, NULL);
> +}
> +
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


