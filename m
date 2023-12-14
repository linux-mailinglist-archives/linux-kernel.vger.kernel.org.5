Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59CC813235
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573288AbjLNNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573277AbjLNNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:52:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36977128
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702561976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47QTLpQUD6l8Dml/WreIBJeaYCFjo5y0akXYerqAVwk=;
        b=I6KEN0tNiXe7PwSN+30VTWoUTyYPcXyYKkZtHGke+skoP644j78FrQU/dbHJ1pkdDNllRZ
        94KjUuZVI/aF6wVf6wG8NKI0P9xlSjMkxBfOG/ro1/WXnT6zLb6JU5M1W6kryvH8rzMWgw
        +4E6Ff4G3ZH/hF1bv9kqwAjmvQ7Uc5Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-LBMwZhwYOoycSHdoLWliYA-1; Thu, 14 Dec 2023 08:52:55 -0500
X-MC-Unique: LBMwZhwYOoycSHdoLWliYA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4257de8a5f4so104752531cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561974; x=1703166774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47QTLpQUD6l8Dml/WreIBJeaYCFjo5y0akXYerqAVwk=;
        b=nTeuXHUWxv+NGjC/sVT0CZZ+vh7eAqTrNb1Uk/ZdXGUAF/cMR5D0YpQi17EvWn53Do
         irFbUNv1sQ0aS/TzmkIisvJQv0Agnz8GUbgTdJXXTSU803F36JuQFVIZXtDhCZWkIsVm
         5LbF4No1t1DOQ1XW0eKC8HIWAWqdSP4i+4paevmpxqkhi00B1UukV40Lp9DUtR6j7r0k
         Vb64BR2kzxP8POfc9YUS14leqNJmaI3iqrW/Mow8LgjJVvnkvUzXZNmcxe01t5FmEU2N
         +KSbSX3MmZP4TBH9WrtOduel7bekQ8Ojyust+DV244UOH2iYG1bJaN4JInHP9Rk6Z7fU
         T1yg==
X-Gm-Message-State: AOJu0YyqXU2foIO87OWgV2owQu0pUM0fYfKFaNrUJvYZYdkagZU1l4Sq
        i5kgC0u3J/pthqzl5+0v+JcaE1iwTVVlCO6fKXW28vB4dANCQdtoUEQrXY/kEj87qPZSWqJpgCo
        2FkWhKU3/LIQWhgrq+QACVE6z
X-Received: by 2002:a05:622a:1352:b0:425:85b7:a784 with SMTP id w18-20020a05622a135200b0042585b7a784mr14471926qtk.53.1702561974442;
        Thu, 14 Dec 2023 05:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpWkcb1WNBFDGT8fdgkiTcGoAQitzYeJZ2HpypjaPY5jt72qe2FYW2BYR+o3li4uteK49vkQ==
X-Received: by 2002:a05:622a:1352:b0:425:85b7:a784 with SMTP id w18-20020a05622a135200b0042585b7a784mr14471902qtk.53.1702561974139;
        Thu, 14 Dec 2023 05:52:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ca25-20020a05622a1f1900b004259ba7bc08sm5760603qtb.42.2023.12.14.05.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:52:53 -0800 (PST)
Message-ID: <7b1c4163-31e8-490e-9f19-3abceeeb2d7d@redhat.com>
Date:   Thu, 14 Dec 2023 14:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] KVM: selftests: aarch64: Add invalid filter test
 in pmu_event_filter_test
Content-Language: en-US
To:     Shaoqin Huang <shahuang@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231129072712.2667337-1-shahuang@redhat.com>
 <20231129072712.2667337-6-shahuang@redhat.com>
From:   Eric Auger <eauger@redhat.com>
In-Reply-To: <20231129072712.2667337-6-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaoqin

On 11/29/23 08:27, Shaoqin Huang wrote:
> Add the invalid filter test to double check if the KVM_ARM_VCPU_PMU_V3_FILTER
> will return the expected error.
... in which situations? filter beyond the 16b event space or incorrect
action.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/pmu_event_filter_test.c       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> index 0e652fbdb37a..4c375417b194 100644
> --- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -7,6 +7,7 @@
>   * This test checks if the guest only see the limited pmu event that userspace
>   * sets, if the guest can use those events which user allow, and if the guest
>   * can't use those events which user deny.
> + * It also checks that setting invalid filter ranges return the expected error.
>   * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
>   * is supported on the host.
>   */
> @@ -197,6 +198,39 @@ static void for_each_test(void)
>  		run_test(t);
>  }
>  
> +static void set_invalid_filter(struct vpmu_vm *vm, void *arg)
> +{
> +	struct kvm_pmu_event_filter invalid;
> +	struct kvm_device_attr attr = {
> +		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
> +		.addr	= (uint64_t)&invalid,
> +	};
> +	int ret = 0;
> +
> +	/* The max event number is (1 << 16), set a range large than it. */
larger
> +	invalid = __DEFINE_FILTER(BIT(15), BIT(15)+1, 0);
doc says
must fit within the event space defined by the PMU
architecture (10 bits on ARMv8.0, 16 bits from ARMv8.1 onwards).

> +	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +
> +	ret = 0;
> +
> +	/* Set the Invalid action. */
> +	invalid = __DEFINE_FILTER(0, 1, 3);
> +	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +}
> +
> +static void test_invalid_filter(void)
> +{
> +	vpmu_vm = __create_vpmu_vm(guest_code, set_invalid_filter, NULL);
> +	destroy_vpmu_vm(vpmu_vm);
> +}
> +
>  static bool kvm_supports_pmu_event_filter(void)
>  {
>  	int r;
> @@ -228,4 +262,6 @@ int main(void)
>  	TEST_REQUIRE(host_pmu_supports_events());
>  
>  	for_each_test();
> +
> +	test_invalid_filter();
>  }

Eric

