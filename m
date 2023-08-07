Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774AF771AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHGHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjHGHAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8E10EB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691391608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8w13UDAjUg9gQzrgRKLvfg4Q0tp4kZabqTik6diwOQc=;
        b=UlQvRdC2pYcmvv7bhcM0JdsZ2G+NLiwlgMYauExXlKfGspzHuBmmP+Q+uRynaUXBB1zIoC
        1NezKPg+gjgzMJJzvS0OliOA95uARRyatIlH0mix0wUc9t8Znbph/uYk9ZQaWh7yQPSkGA
        QOg3KhaOszqWI2B0oHU7vUQ3agGbnqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-kiUmsXE5OIm6BJMz7rBf2w-1; Mon, 07 Aug 2023 03:00:07 -0400
X-MC-Unique: kiUmsXE5OIm6BJMz7rBf2w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe11910e46so19396865e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 00:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391605; x=1691996405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8w13UDAjUg9gQzrgRKLvfg4Q0tp4kZabqTik6diwOQc=;
        b=YWDXqMgRnZgfVAugA11VvEchx0I2qigYUlJuqI3dLHU4NQ/jCb7Eru4WsqltcprjGc
         fUnopoqtIOaoPezfSADMgFd3y2illOQTHtlBtctOCiOckIoltSLJWyknrKqB9UrBQ3kw
         lrYDbxx8w1rNNYBR6dp2Um/yoD0aDjCYAKnf+DqrBDCPXbr8qYawc2XNjtS8hkScuHST
         P3865Fj5QEUk7o2r2I+XJOBFhHxZh92mgKsU2LDL4Auj+jiGUNQEQMmR2rc9IQvrNhuM
         SysNxgiAg1eMF1i8PeFtNJ4VGbSCwEJ4MfeVYwbPi8qur9yJk7p+C75NR3Ty6gH2iHet
         VKgg==
X-Gm-Message-State: AOJu0YwGp+47NqGZfxI8CQamejFkTqfVb70ww4hW1DnI6y83DkLslARp
        cP1O2fQfWzDplNku9tNOlGimGJ8PqomVErxoGnbv0vLvRXh2+7K5HjsXAq4dGXQR+QeIVXei+iH
        t28FoH77Q1Nu2HlBy/6ITxi7THyV5w7M9
X-Received: by 2002:a05:600c:8516:b0:3fe:21f1:aba8 with SMTP id gw22-20020a05600c851600b003fe21f1aba8mr4511363wmb.12.1691391605740;
        Mon, 07 Aug 2023 00:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXA/1pcCbnxb2mNf1raj8LhNon6DCNBrYFXKxuOvkbCfnDI5g6W1KLbQQ18AOdhMHSUY7LA==
X-Received: by 2002:a05:600c:8516:b0:3fe:21f1:aba8 with SMTP id gw22-20020a05600c851600b003fe21f1aba8mr4511341wmb.12.1691391605398;
        Mon, 07 Aug 2023 00:00:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c228900b003fe13c3ece7sm14192796wmf.10.2023.08.07.00.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:00:04 -0700 (PDT)
Message-ID: <da8692bd-b0a7-4f53-8600-ac3fb277b3a1@redhat.com>
Date:   Mon, 7 Aug 2023 09:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 11/19] KVM:VMX: Emulate read and write to CET MSRs
Content-Language: en-US
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chao Gao <chao.gao@intel.com>
Cc:     peterz@infradead.org, john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        binbin.wu@linux.intel.com
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-12-weijiang.yang@intel.com>
 <ZMyJIq4CgXxudJED@chao-email> <ZM1tNJ9ZdQb+VZVo@google.com>
 <7df23a0d-e2a6-71a7-7641-6363f4905f5c@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <7df23a0d-e2a6-71a7-7641-6363f4905f5c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/23 10:44, Yang, Weijiang wrote:
>> Similar to my suggestsion for XSS, I think we drop the waiver for 
>> host_initiated
>> accesses, i.e. require the feature to be enabled and exposed to the 
>> guest, even
>> for the host.
>
> I saw Paolo shares different opinion on this, so would hold on for a 
> while...

It's not *so* different: the host initiated access should be allowed, 
but it should only allow writing zero.  So, something like:

> +static bool kvm_cet_is_msr_accessible(struct kvm_vcpu *vcpu,
> +                      struct msr_data *msr)
> +{

bool host_msr_reset =
	msr->host_initiated && msr->data == 0;

and then below you use host_msr_reset instead of msr->host_initiated.

> +        if (msr->index == MSR_KVM_GUEST_SSP)
> +            return msr->host_initiated;
> +
> +        return msr->host_initiated ||
> +            guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);

This can be unified like this:

return
	(host_msr_reset || guest_cpuid_has(vcpu, X86_FEATURE_SHSTK)) &&
	(msr->index != MSR_KVM_GUEST_SSP || msr->host_initiated);

> +    }
> +
> +    if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
> +        !kvm_cpu_cap_has(X86_FEATURE_IBT))
> +        return false;
> +
> +    return msr->host_initiated ||
> +        guest_cpuid_has(vcpu, X86_FEATURE_IBT) ||
> +        guest_cpuid_has(vcpu, X86_FEATURE_SHSTK); 

while this can simply use host_msr_reset.

Paolo

