Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7357580F1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjLLQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjLLQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D6DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702397257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=AX13QLp52fxcEAzzU06zAooOoCuVylV9op9xhQpaESU=;
        b=g6S3izP7wh8QdM2k4Vev+3POgqHdPa5eMS8miZXI0kYsoCeujCoICbtq3S/KJ/nptkcpnC
        /g7ly9ddR4fQViHoJIRHE86fOAQ/IO13MbH1pWvnQbBnE4YDeBbFrGAEfV9ZU+Rp679c24
        2nStODO7eghpAXSUx74DDnA7SEI0T4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-yogPRukdNaaySHAw5DHcJQ-1; Tue, 12 Dec 2023 11:07:34 -0500
X-MC-Unique: yogPRukdNaaySHAw5DHcJQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c1d2b1559so42133105e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397252; x=1703002052;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AX13QLp52fxcEAzzU06zAooOoCuVylV9op9xhQpaESU=;
        b=Zdrlc2dG1fT/iWu/+wS+17DVupN3tgHgs9hHZXydBJJoLPZvSuE+YO+/oMivjyxqTA
         mH8YfsdPn4v9kyGNPb0EnqFQvCmJAwAU4GmRkM4r/wg4a82cnBr+vcSJ/VUyhnBCsqaC
         TTLnxr3caapxqtJ39mMn7OsOW0RFKlDQFBPHlV190+2lzFYqtV1MH1gKOk9HpFwcHjB1
         M5daulq3e0d1NN19S8FhxY32DvWBqOJm83n4lj2KG7K32RSoVrAB/84Pk116n6Eozlwi
         yp0Ewqli2xxrlLxhsK9r2xqnN3Z0KR6oV51L1+8BNF+Dhp2iYnuA16ml2bBpTK6NQBIy
         UEDg==
X-Gm-Message-State: AOJu0Yx8ntxcSIEehcMdBJ0FZ10oGKZhTWb8e25OXz3RNQO+retxZMK7
        9G2nLGfYIlxbBzLDdGJgE4GOg6PxasBDAtk8NBy6odtjmk8sKR8UfJ2JtlfgOp/75Hf0RPqNvbM
        CBaephOnTs/gcKHqfaZCunjZo4Of4i3a6
X-Received: by 2002:a05:600c:4507:b0:40c:5a4:b0dc with SMTP id t7-20020a05600c450700b0040c05a4b0dcmr3068542wmo.113.1702397252406;
        Tue, 12 Dec 2023 08:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjMQpzQc5MhAj09eWUFTjXsAB04BjM7/TN5+rFoi67i9ZNVTdke0Lk83q2ohgUcY7xbEkJsA==
X-Received: by 2002:a05:600c:4507:b0:40c:5a4:b0dc with SMTP id t7-20020a05600c450700b0040c05a4b0dcmr3068536wmo.113.1702397252048;
        Tue, 12 Dec 2023 08:07:32 -0800 (PST)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c154900b0040c4be1af17sm5548133wmg.21.2023.12.12.08.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:07:31 -0800 (PST)
Message-ID: <4a26883e-1acf-421a-9055-07ba9fea783c@redhat.com>
Date:   Tue, 12 Dec 2023 17:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: x86: use a uapi-friendly macro for BIT
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dionna Glaze <dionnaglaze@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20231207001142.3617856-1-dionnaglaze@google.com>
 <ZXh78TApz80DAWUb@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZXh78TApz80DAWUb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 16:27, Sean Christopherson wrote:
>> -#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS BIT(0)
>> +#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS _BITUL(0)
> It's not just BIT(), won't BIT_ULL() and GENMASK_ULL() also be problematic?  And
> sadly, I don't see an existing equivalent for GENMASK_ULL().

BIT_ULL() is easy enough, as you point out:

@@ -550,7 +550,7 @@ struct kvm_pmu_event_filter {
         (GENMASK_ULL(7, 0) | GENMASK_ULL(35, 32))
  #define KVM_PMU_MASKED_ENTRY_UMASK_MASK                (GENMASK_ULL(63, 56))
  #define KVM_PMU_MASKED_ENTRY_UMASK_MATCH       (GENMASK_ULL(15, 8))
-#define KVM_PMU_MASKED_ENTRY_EXCLUDE           (BIT_ULL(55))
+#define KVM_PMU_MASKED_ENTRY_EXCLUDE           (_BITULL(55))
  #define KVM_PMU_MASKED_ENTRY_UMASK_MASK_SHIFT  (56)

  /* for KVM_{GET,SET,HAS}_DEVICE_ATTR */

And I'll squash it into Dionna's patch since she has already a conversion
for KVM_EXIT_HYPERCALL_LONG_MODE.  For the others, I'll send a patch.

Paolo

