Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E580E94E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjLLKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjLLKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7225BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702377583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zE+kaYHKbfi52ZrgmcrCj/fN/75AkohML4TX96iwLs=;
        b=DB3iziglJR39DobJwRcdNlrOKTBURY5WnpZhvwu1NK1XW3xcIKjgunlUo7AsIbIwetjsGy
        9eHl2Jtq9KC1nV/uRN1H1swcop3cv05bvXFjrOlU08PtSUr/Z7aKHzxA9kDRK9PL0ceBpK
        VvG7ovJ/sG76CFq2w3/NKXyE4OP7Svg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-MY0XgqheNP2TPbetD-aUFw-1; Tue, 12 Dec 2023 05:39:42 -0500
X-MC-Unique: MY0XgqheNP2TPbetD-aUFw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50df8e031f2so2361003e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377580; x=1702982380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zE+kaYHKbfi52ZrgmcrCj/fN/75AkohML4TX96iwLs=;
        b=tXQsiH/vbmDeG/6UvpxnlQ5zHJ459x0TE85TlpJqZ9hljHuOiRhYEaAy3vRLL+pvAf
         Xffky9SU9brDhac++Dn9DC6dsQ9RbJe4PviAIfcfWztUfv3F5P8EWG5cYBQzAGotRGmt
         OculJgkjpfF2rP/W69TblBvxL1zfCSsRAvqY6tjOI7ptXGGPkxp0qLkCErwETF9SxAv2
         jPp2MrtcPDXU2EqIXEZMnqmGvFZKJEm+9mAMf7EDRsfdeV4BNkGZ2X2wnxg2ptREEwyi
         c0I2AXHQ3r3wO1rFgrxn8nHknA/ge99jVTJqkKwAMqPO1AVidlV7zoC+NQOhoap+vJ6t
         qYWQ==
X-Gm-Message-State: AOJu0YwmlZRppCZYZFtBBO/yXOn6B/2BC9aGN8LTnoOC6dX0NbAaItwh
        4couTvyV2NkEQrFr1i5XHW6d4HA7rGydDhGcUaI90EGWrmCqJj5/JUEbjBAETv++/2WeRwSzjLy
        ImMNyfz1hFlZ0zMBXlk6jASPK
X-Received: by 2002:ac2:55b2:0:b0:50b:f881:8627 with SMTP id y18-20020ac255b2000000b0050bf8818627mr1010502lfg.109.1702377580663;
        Tue, 12 Dec 2023 02:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5+ZfcUkPdFD8mGJYXluwd2s6gyvHtpKB4oC8M/QPBLHm0ss1UoX2crhgPXwwH6ipyoJH2Ww==
X-Received: by 2002:ac2:55b2:0:b0:50b:f881:8627 with SMTP id y18-20020ac255b2000000b0050bf8818627mr1010496lfg.109.1702377580255;
        Tue, 12 Dec 2023 02:39:40 -0800 (PST)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id a9-20020a5d5709000000b003332aa97101sm10509764wrv.38.2023.12.12.02.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 02:39:39 -0800 (PST)
Message-ID: <184e253d-06c4-419e-b2b4-7cce1f875ba5@redhat.com>
Date:   Tue, 12 Dec 2023 11:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: fix supported_flags for aarch64
To:     Sean Christopherson <seanjc@google.com>,
        Shaoqin Huang <shahuang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20231208184628.2297994-1-pbonzini@redhat.com>
 <ZXPRGzgWFqFdI_ep@google.com>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZXPRGzgWFqFdI_ep@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/23 03:29, Sean Christopherson wrote:
> On Fri, Dec 08, 2023, Paolo Bonzini wrote:
>> KVM/Arm supports readonly memslots; fix the calculation of
>> supported_flags in set_memory_region_test.c, otherwise the
>> test fails.
> 
> You got beat by a few hours, and by a better solution ;-)
> 
> https://lore.kernel.org/all/20231208033505.2930064-1-shahuang@redhat.com

Better but also wrong---and my patch has the debatable merit of more
clearly exposing the wrongness.  Testing individual architectures is bad,
but testing __KVM_HAVE_READONLY_MEM makes the test fail when running a new
test on an old kernel.

This scenario of course will fail when the test detects a bug, but readonly
memory is just new functionality (think of the case where RISC-V starts
defining __KVM_HAVE_READONLY_MEM in the future).  For new functionality,
the right thing to do is one of 1) skip the whole test 2) skip the individual
test case 3) code the test to adapt to the old kernel.  The third choice is
rarely possible, but this is one of the cases in which it _is_ possible.

So, the only good way to do this is to get _all_ supported_flags from
KVM_CHECK_EXTENSION(KVM_CAP_USER_MEMORY2).  We can change the value returned
by KVM_CHECK_EXTENSION because KVM_CAP_USER_MEMORY2 has not been included in
any released kernel.  Calling KVM_CHECK_EXTENSION subsumes

         supported_flags |= KVM_MEM_READONLY;
         if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) & KVM_MEMORY_ATTRIBUTE_PRIVATE)
                 supported_flags |= KVM_MEM_GUEST_MEMFD;

and v2_only_flags would be defined as

         const uint32_t v2_only_flags = ~(KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY);

(not guaranteed to work in the future, but good enough since new KVM_MEM_*
flags are a very rare occurrence).  Then, the test checks that the supported
flags are consistent with the value returned by KVM_CHECK_EXTENSION.

Shaoqin, would you give it a shot?

Thanks,

Paolo

> 

>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/set_memory_region_test.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
>> index 6637a0845acf..dfd1d1e22da3 100644
>> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
>> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
>> @@ -333,9 +333,11 @@ static void test_invalid_memory_region_flags(void)
>>   	struct kvm_vm *vm;
>>   	int r, i;
>>   
>> -#ifdef __x86_64__
>> +#if defined __aarch64__ || defined __x86_64__
>>   	supported_flags |= KVM_MEM_READONLY;
>> +#endif
>>   
>> +#ifdef __x86_64__
>>   	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
>>   		vm = vm_create_barebones_protected_vm();
>>   	else
>> -- 
>> 2.39.1
>>

