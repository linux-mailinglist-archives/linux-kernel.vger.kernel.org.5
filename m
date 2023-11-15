Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EEE7EC751
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjKOPbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKOPbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2EC2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700062302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/U++RP8J87fTpffNLluzx5XIExdTU9ynmak8Mre+P4=;
        b=Qt27BkML2PP1cPd/8aCgLA5uH6LBroIvaAaul0bsKeiH0E27NYXWy6Sfyuz/QqYxVr7l5w
        tcoVV1skG7SEh4AFL8bxGjcKcIOPGZiu+bkZmekvxbYZcTBItlatYzGxWCxFq9PsAHlOHi
        FGxT5r+bWKw9Jw5Ef71daNlxJX+juko=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-IB_CvwHtO5eKr723_VPx4w-1; Wed, 15 Nov 2023 10:31:41 -0500
X-MC-Unique: IB_CvwHtO5eKr723_VPx4w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bdc140103bso1690483b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062300; x=1700667100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/U++RP8J87fTpffNLluzx5XIExdTU9ynmak8Mre+P4=;
        b=XZzU2DIGZ12DEJHtKkEXAX8PB1f2mATWOW+zrOdWtmIyygzIzYaEtme7AtkgY4jego
         UD3p26ehB9HR7LtNttNMG8esZ2zJe7NYXj2QoUdmM5nxcFcnhms62imLS10wxVShEUl9
         wn1cJlhdNnZasF5rXzUaD7aWGGJgurC9GMJXhzsQRVNdVYOlE8xBdONj8f+7SJYQireV
         JY1hbo0mjeVU8UuOjS5VA9HgSFHHeAbig8Co4ItkNI0+amj3A/PHY0KaLyhOjK0pYAgV
         LsbNCdIcz9JGyapz2zn0WKebzNhKELYolmZTNUsIWHFfqeGmUAubTJkV9WV604EGLGuq
         pqNw==
X-Gm-Message-State: AOJu0YwR/PcCgHBaQuQGfxcm4mdoPwP1DJO1JJz0sFlEFszR1casHvWm
        oQrDX2BAO6oRwH9zGDsCAMNRKRpgQRBlVDxa4XPQj+Lf5tNfHAugzF4UF6LuP3TE7mYX7dkxNMY
        WVVpdnFg8VJlD/p137V4rJHTG
X-Received: by 2002:a05:6a00:6894:b0:6c0:81a3:fe4c with SMTP id hr20-20020a056a00689400b006c081a3fe4cmr2631600pfb.3.1700062299857;
        Wed, 15 Nov 2023 07:31:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6wTglBWhG4nljh27JjPWJF2LXSzDl20T4s5YweTj0uHIb6TdJ4bD03xIAZOHx+3l4vNETfQ==
X-Received: by 2002:a05:6a00:6894:b0:6c0:81a3:fe4c with SMTP id hr20-20020a056a00689400b006c081a3fe4cmr2631564pfb.3.1700062299414;
        Wed, 15 Nov 2023 07:31:39 -0800 (PST)
Received: from [10.72.112.25] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a6558cc000000b0058ee60f8e4dsm1174195pgu.34.2023.11.15.07.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 07:31:39 -0800 (PST)
Message-ID: <f3f467bf-40d7-dd4d-7ee1-eef95eeed36d@redhat.com>
Date:   Wed, 15 Nov 2023 23:31:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Content-Language: en-US
To:     kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231115104757.15710-1-shahuang@redhat.com>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231115104757.15710-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 18:47, Shaoqin Huang wrote:
> The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
> value, define it in one place to make the code clean.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   tools/testing/selftests/kvm/aarch64/arch_timer.c   | 3 ---
>   tools/testing/selftests/kvm/aarch64/vgic_irq.c     | 3 ---
>   tools/testing/selftests/kvm/dirty_log_perf_test.c  | 3 ---
>   tools/testing/selftests/kvm/include/aarch64/vgic.h | 3 +++

Oops. Forget the kvm/aarch64/vpmu_counter_access.c. I will update a new one.

>   4 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 274b8465b42a..818854007bfd 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -59,9 +59,6 @@ static struct test_args test_args = {
>   
>   #define msecs_to_usecs(msec)		((msec) * 1000LL)
>   
> -#define GICD_BASE_GPA			0x8000000ULL
> -#define GICR_BASE_GPA			0x80A0000ULL
> -
>   enum guest_stage {
>   	GUEST_STAGE_VTIMER_CVAL = 1,
>   	GUEST_STAGE_VTIMER_TVAL,
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index 2e64b4856e38..a48aff110fb6 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -19,9 +19,6 @@
>   #include "gic_v3.h"
>   #include "vgic.h"
>   
> -#define GICD_BASE_GPA		0x08000000ULL
> -#define GICR_BASE_GPA		0x080A0000ULL
> -
>   /*
>    * Stores the user specified args; it's passed to the guest and to every test
>    * function.
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index d374dbcf9a53..4971e8f77a0a 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -22,9 +22,6 @@
>   #ifdef __aarch64__
>   #include "aarch64/vgic.h"
>   
> -#define GICD_BASE_GPA			0x8000000ULL
> -#define GICR_BASE_GPA			0x80A0000ULL
> -
>   static int gic_fd;
>   
>   static void arch_setup_vm(struct kvm_vm *vm, unsigned int nr_vcpus)
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
> index 0ac6f05c63f9..9dbb342fd808 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/vgic.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
> @@ -33,4 +33,7 @@ void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu);
>   
>   #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
>   
> +#define GICD_BASE_GPA		0x08000000ULL
> +#define GICR_BASE_GPA		0x080A0000ULL
> +
>   #endif // SELFTEST_KVM_VGIC_H

-- 
Shaoqin

