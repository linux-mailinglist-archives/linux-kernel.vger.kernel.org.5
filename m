Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8E7E6540
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjKII0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjKII0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:26:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3567A273E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699518349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=odt/5xMXbjMgZlXR9oRA3wdW/adm1/gNuEpMj2VBGmk=;
        b=JqYgyJ4mTafQAwU/hKRh//7IdyoYz4dnnrAg3UT9aSjVItRgL/Tsq9GUqYeQ4cYstp1B7I
        QOr2kGxnfBv0LLFiZpEb/HzzPQDFsyRtBeOmqZXpUkMViG/ltwXW76hMxQJWX0w8Y1jSmL
        aq9rS8Q3Ql4PHEbTFGGjmEMz12fLYDQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-bNE-_IY1OoS05ZvqPMs7LQ-1; Thu, 09 Nov 2023 03:25:48 -0500
X-MC-Unique: bNE-_IY1OoS05ZvqPMs7LQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso415584a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699518347; x=1700123147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odt/5xMXbjMgZlXR9oRA3wdW/adm1/gNuEpMj2VBGmk=;
        b=eRmI2U6pXemCSFiHiLuZFASFodD1aryAgqQOngcjiwW5K173R79fzTIaoefJuvxCja
         jwnAb/fr+jgzUIxp04f4pU4NeJwb1MBHVq/t1H2PyLvpY4W1+eetelgqWnHux4gESPHf
         upgxGx4lx3hKDCXKKW7piHKs5F/A2eYMw2knFuee1XbR9hzXxLsninZgMIdZZJpkBB5Y
         6+tQV5S4kh9S4E21gdZwdBptIS+0mn8kRZ4Ul+khYDrc5b0eshQfN9GNX91veXbVNI8l
         F2PaHS4wukEnbUcriMnY1uBRBrv12NnpJot0l9Z5cbt3cNKwN8atWBAkvDAaLwYeYx5l
         N0zw==
X-Gm-Message-State: AOJu0YyRaF1YYRd9PPgTMyR5tp6GKJxDdRQdU1ITBirtcoVsEo4VLp/S
        fXDDDTkJovalr4OX1+xrlNBHlKddcCkSaNFfT5sfv5q/ThAdkJysYr/8T4Hr/nlk8pmhm2Gjfdp
        wfYGPqlfOuiUPdVGEJ/AbKVua
X-Received: by 2002:a50:9f4e:0:b0:540:ccde:5 with SMTP id b72-20020a509f4e000000b00540ccde0005mr3348770edf.37.1699518346873;
        Thu, 09 Nov 2023 00:25:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc/8h7txNeYrJdeIJbeZLdKa5Ej0cD8Q6TYT5qVu8zzxOyeTh4hQuHi7CupWqz8J3PkKtaWg==
X-Received: by 2002:a50:9f4e:0:b0:540:ccde:5 with SMTP id b72-20020a509f4e000000b00540ccde0005mr3348751edf.37.1699518346536;
        Thu, 09 Nov 2023 00:25:46 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm8007819edj.96.2023.11.09.00.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 00:25:45 -0800 (PST)
Message-ID: <143f5411-9fc0-4e88-9e35-6f3679b6f930@redhat.com>
Date:   Thu, 9 Nov 2023 09:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
Content-Language: en-US
To:     Anish Moorthy <amoorthy@google.com>
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu, brauner@kernel.org,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, dmatlack@google.com, isaku.yamahata@gmail.com,
        isaku.yamahata@intel.com, jarkko@kernel.org,
        kirill.shutemov@linux.intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        liam.merwick@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
        michael.roth@amd.com, mpe@ellerman.id.au, oliver.upton@linux.dev,
        palmer@dabbelt.com, paul.walmsley@sifive.com, qperret@google.com,
        seanjc@google.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, wei.w.wang@intel.com,
        willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com,
        yu.c.zhang@linux.intel.com
References: <CAF7b7mrGYuyjyEPAesYzZ6+KDuNAmvRxEonT7JC8NDPsSP+qDA@mail.gmail.com>
 <20231108233723.3380042-1-amoorthy@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231108233723.3380042-1-amoorthy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 00:37, Anish Moorthy wrote:
> On Wed, Nov 8, 2023 at 9:00 AM Anish Moorthy <amoorthy@google.com> wrote:
>>
>> This commit breaks the arm64 selftests build btw: looks like a simple oversight?
> 
> Yup, fix is a one-liner. Posted below.
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> index eb4217b7c768..08a5ca5bed56 100644
> --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> @@ -705,7 +705,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   
>   	print_test_banner(mode, p);
>   
> -	vm = ____vm_create(mode);
> +	vm = ____vm_create(VM_SHAPE(mode));

Yes, this is similar to the s390 patch I sent yesterday 
(https://patchew.org/linux/20231108094055.221234-1-pbonzini@redhat.com/).

Paolo

