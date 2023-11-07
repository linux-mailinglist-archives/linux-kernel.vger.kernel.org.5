Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588167E481F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjKGSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjKGSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:20:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B46E95
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699381208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIrX8yzdRcgaUlR140dceKARZTzBkQcALUFzRiLkSM4=;
        b=V7qo2Ib/awNTviZVa0Fw3FV+7E4L2/Umt4Kgiy/Txe4dvp2EvAIUCH/LRGzWu4DQxcrCin
        enVFqNK905Vp2ETxunC0z+WuckzRV6z0/oaBaUbgaI3eKOLG/3FvMdRxkexMmuLUdN0oKb
        prgL9M25OBc94lWKOsra3sL7KnQHsLI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-PDEGBE3VNseEn3CrtItnxQ-1; Tue, 07 Nov 2023 13:20:07 -0500
X-MC-Unique: PDEGBE3VNseEn3CrtItnxQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32de9f93148so3149027f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381206; x=1699986006;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIrX8yzdRcgaUlR140dceKARZTzBkQcALUFzRiLkSM4=;
        b=f6ap5o498VzlydKjH8xEzjdc3FP6amy4cbJ5eM7vkpjvfjhLycFI6H33hrricMf755
         qluHvfMBSvVWqjQUgc3e6iBkRFr54mVKqleQ6NztIbQ4hVyIhsbysG73QDOy1AycklZp
         uZWpVtlFS0y1Tg+UF8VbGFt6gbUrR9c4hB4B8zsNuzmWcDXN/iK8L2vOpYCFvDEzcPTE
         ALst2KWKwQLxEKX2g9fywtRDj0ijrWEZ1Rk8z1cnUwc/LQWPea5Dhbggz5gFBoNfGUTC
         L9hs7jz+I/1UXxjXz1JokJrB3BwhSAgrGSnPj27PMvpf/fLyR5LevD7Y5bWxRvBQldUH
         oHqw==
X-Gm-Message-State: AOJu0Yy2QG0R4tcGxmexz0GMKnZGhs7eICWYM16n+YFm/oG+2FHXV+Qj
        DB4/vgEGHQdzpTCiRR4tY/m39z43D7z6RUIWfUXb97Kza7SNwrYCNe53aLEQPaE8Co5KX9SqzNm
        3TOkAm6x0yGYIhJOMBcZn5W5h
X-Received: by 2002:adf:fd8d:0:b0:321:68fa:70aa with SMTP id d13-20020adffd8d000000b0032168fa70aamr28273903wrr.9.1699381206049;
        Tue, 07 Nov 2023 10:20:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGYfquYiUPbszRtdTWIZp3BhzaSiH9Sx0a3duijCjXrtvUiIEt23V3KyXLGrnPbGbaSlW5NA==
X-Received: by 2002:adf:fd8d:0:b0:321:68fa:70aa with SMTP id d13-20020adffd8d000000b0032168fa70aamr28273880wrr.9.1699381205719;
        Tue, 07 Nov 2023 10:20:05 -0800 (PST)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b003296b488961sm2984893wrj.31.2023.11.07.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:20:05 -0800 (PST)
Message-ID: <2b27196c2b5d10625e10ea73e9f270c7ef0bf5a0.camel@redhat.com>
Subject: Re: [PATCH 3/9] KVM: x86: SVM: Pass through shadow stack MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     nikunj@amd.com, John Allen <john.allen@amd.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de
Date:   Tue, 07 Nov 2023 20:20:03 +0200
In-Reply-To: <ZUkYPfxHmMZB03iv@google.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-4-john.allen@amd.com>
         <8484053f-2777-eb55-a30c-64125fbfc3ec@amd.com>
         <ZS7PubpX4k/LXGNq@johallen-workstation>
         <c65817b0-7fa6-7c0b-6423-5f33062c9665@amd.com>
         <874ae0019fb33784520270db7d5213af0d42290d.camel@redhat.com>
         <ZUkYPfxHmMZB03iv@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-06 at 08:45 -0800, Sean Christopherson wrote:
> On Thu, Nov 02, 2023, Maxim Levitsky wrote:
> > On Wed, 2023-10-18 at 16:57 +0530, Nikunj A. Dadhania wrote:
> > > On 10/17/2023 11:47 PM, John Allen wrote:
> > > In that case, intercept should be cleared from the very beginning.
> > > 
> > > +	{ .index = MSR_IA32_PL0_SSP,                    .always = true },
> > > +	{ .index = MSR_IA32_PL1_SSP,                    .always = true },
> > > +	{ .index = MSR_IA32_PL2_SSP,                    .always = true },
> > > +	{ .index = MSR_IA32_PL3_SSP,                    .always = true },
> > 
> > .always is only true when a MSR is *always* passed through. CET msrs are only
> > passed through when CET is supported.
> > 
> > Therefore I don't expect that we ever add another msr to this list which has
> > .always = true.
> > 
> > In fact the .always = True for X86_64 arch msrs like MSR_GS_BASE/MSR_FS_BASE
> > and such is not 100% correct too - when we start a VM which doesn't have
> > cpuid bit X86_FEATURE_LM, these msrs should not exist and I think that we
> > have a kvm unit test that fails because of this on 32 bit but I didn't bother
> > yet to fix it.
> > 
> > .always probably needs to be dropped completely.
> 
> FWIW, I have a half-baked series to clean up SVM's MSR interception code and
> converge the SVM and VMX APIs.  E.g. set_msr_interception_bitmap()'s inverted
> polarity confuses me every time I look at its usage.

100% agree. Any refactoring here is very welcome!

> 
> I can hunt down the branch if someone plans on tackling this code.

One of the things I don't like that much in the SVM msr's bitmap code
is that it uses L1's msr bitmap when the guest's msr interception is disabled,
and the combined msr bitmap otherwise.

This is very fragile and one mistake away from a CVE.

Since no sane L1 hypervisor will ever allow access to all its msrs from L2,
it might make sense to always use a dedicated MSR bitmap for L2.

Also since all sane L1 hypervisors do use a msr bitmap means that
dedicated code path that doesn't use it is not well tested.

On VMX if I am not mistaken, this is not an issue because either all
MSRS are intercepted or a bitmap is used.

> 

Best regards,
	Maxim Levitsky

