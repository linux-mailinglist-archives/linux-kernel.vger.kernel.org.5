Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E62811320
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378895AbjLMNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjLMNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6FDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702474836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=PNirHn6/OZsuqFtt8Eb6deeVCs13sDXE1XT0REAHHTw=;
        b=h6+E8lO0HIa6G6+aP/9ZcKES6OSycd1vPAmWNUmSKrdHDhzvNeog2CvPx0mngw548gujUs
        8ytsKmFMMidSfrxFwrf2XGaKyN2bSyy4P/OeNQERqh5UD4csRB8UDULySHlC75TUZjmjoK
        JHWzz5w5WyL1CC30aVyRHZix7/Hec1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-NL4Yn6-aOIqQXbPxmCcrxQ-1; Wed, 13 Dec 2023 08:40:34 -0500
X-MC-Unique: NL4Yn6-aOIqQXbPxmCcrxQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b554730c5so48463495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474833; x=1703079633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNirHn6/OZsuqFtt8Eb6deeVCs13sDXE1XT0REAHHTw=;
        b=ElyS4s63kwXWqbc6QVoZahtVEdt/2eONx8WiVTipWVyIkFYqMfQAFjpZfz549yNrrU
         41FaaVdOwYr3gtXlswzopymOP4fVXfHDp9auXuiIQaictr7BnvFDzTqna4azo30Zb+oY
         HFMZxBDzb/hvmTg+cBky4OX8Nd1MYDZApJwZvl9cjqZmCkxyXuOUN0Dg6IeyGvGYg2c9
         8/AM8AHvHUeHZ+KMWKremCoi3Ar1XxcgiyGKW+Xn0yznlcbmL6eSo/P6eSckNANYU8Yg
         L+kL6GT2ch1jUSipPxPA/c7vHeJRMAdEnPUDyVM4TsaoYRdNCq8djONmhXiShylDjeQR
         kU0g==
X-Gm-Message-State: AOJu0YxJTFj16ghSruIX0101EpPgzX9Q7S4gXBE9/8N6e2/Yy6g1kZAb
        fqrVSi6fErbRY5+gyZFpobD32/TTYbANKh69oBWVGcS700rSlw5OLbcE0m2vwQcXZRgFv5TS1HL
        s32IUtLu/x1tsmTH6nXJY4BOU
X-Received: by 2002:a05:600c:c2:b0:40c:3107:8ece with SMTP id u2-20020a05600c00c200b0040c31078ecemr4109776wmm.183.1702474833308;
        Wed, 13 Dec 2023 05:40:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1h7UutvBRbc7jMJ/c8rmqoT/vD1LAgB7X2jBiBtjuxrUfMyT5uunnmuCX5sNyFlW2KJ384g==
X-Received: by 2002:a05:600c:c2:b0:40c:3107:8ece with SMTP id u2-20020a05600c00c200b0040c31078ecemr4109759wmm.183.1702474832889;
        Wed, 13 Dec 2023 05:40:32 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id mm15-20020a1709077a8f00b00a1b6ec7a88asm7794237ejc.113.2023.12.13.05.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:40:31 -0800 (PST)
Message-ID: <9ac2311c-9ccc-4468-9b26-6cb0872e207f@redhat.com>
Date:   Wed, 13 Dec 2023 14:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/50] x86/cpufeatures: Add SEV-SNP CPU feature
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, seanjc@google.com, vkuznets@redhat.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
        nikunj.dadhania@amd.com, pankaj.gupta@amd.com,
        liam.merwick@oracle.com, zhi.a.wang@intel.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-5-michael.roth@amd.com>
 <0b2eb374-356c-46c6-9c4a-9512fbfece7a@redhat.com>
 <20231213131324.GDZXmt9LsMmJZyzCJw@fat_crate.local>
 <40915dc3-4083-4b9f-bc64-7542833566e1@redhat.com>
 <20231213133628.GEZXmzXFwA1p+crH/5@fat_crate.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231213133628.GEZXmzXFwA1p+crH/5@fat_crate.local>
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

On 12/13/23 14:36, Borislav Petkov wrote:
>> Sure, I only queued it because you gave Acked-by for 05/50 and this is an
>> obvious dependency.  I would like to get things in as they are ready
>> (whenever it makes sense), so if you want to include those two in the x86
>> tree for 6.8, that would work for me.
>
> It doesn't make sense to include them into 6.8 because the two alone are
> simply dead code in 6.8.

Why are they dead code?  X86_FEATURE_SEV_SNP is set automatically based 
on CPUID, therefore patch 5 is a performance improvement on all 
processors that support SEV-SNP.  This is independent of whether KVM can 
create SEV-SNP guests or not.

If this is wrong, there is a problem in the commit messages.

Paolo

> The plan is to put the x86 patches first in the next submission, I'll
> pick them up for 6.9 and then give you an immutable branch to apply the
> KVM bits ontop. This way it all goes together.

