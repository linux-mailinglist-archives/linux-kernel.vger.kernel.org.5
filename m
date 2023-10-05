Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2B7BA832
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJERin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjJERiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC655B5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696523950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WISPcUyc6/8JXsab4emUirEp7hxAg5ZRqVv76lYd0R4=;
        b=ghsHFHcxN7771H02q08ErYo2iFuLAJqw8COeD8eKjVH+4X3i5cOg2WoCqhfPRR7gSPrtLh
        8NHqDW4hgLWDxgp2CY5rspirVQfkKY619WvJR4KUXmKvoKrS26zMahMY+mBQKJHV7647+N
        OfuE5PRcxTSMTwMc40m5Ed6hDtKW43g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-1jnbd0YrM1umTn6aBRwncg-1; Thu, 05 Oct 2023 12:38:59 -0400
X-MC-Unique: 1jnbd0YrM1umTn6aBRwncg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51bee352ffcso971963a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523938; x=1697128738;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WISPcUyc6/8JXsab4emUirEp7hxAg5ZRqVv76lYd0R4=;
        b=iChYDcKDiRrllR9xwNg/4U0MOgGa/0C8GI1z2DlKpQY02i6IRiqtWNKnW2x+X0j2XY
         OdO1opV3GAgLT1WUlK0/5TcHJNzzhGfzta/3cyanX6m2lCbX3HWxXq/xIJ5Ntp/UemZD
         MjArsgqGLjEWgzUQQvs5nUCetMfZFdP5CMdYbK/TvrfkeuRRdYNEBGVDoHpcCw7xPqy9
         Zy6A9QBw7+zxDj77CwVcwC4+Uy5+m33NkeP59uY6LQ/DXWYH1l2B3MMug6lMEr8ov9FU
         c7wkREc/KJkgkHUTMu79A46Heu0E0aphez2NXMr6DCERNUqVJChtlZ7HDafwBMs/ykFu
         3+FA==
X-Gm-Message-State: AOJu0Yx2jyUbexlW6gmVAqO0Gi3M/ea+2M1NDyj3AuJ/s5CxqjYUW0f4
        aadPtlsMu5FuhDf+EWDFp7Q39xHdBgmSySEYy1Pc2kIoumEcWXFBICRW+62d+EccjPB4SKuQhJk
        dboTXPlrNajhHwTlV9dTwU/CH
X-Received: by 2002:a50:ef0a:0:b0:532:b5cb:114a with SMTP id m10-20020a50ef0a000000b00532b5cb114amr5797660eds.23.1696523938413;
        Thu, 05 Oct 2023 09:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbJldDtMmM5T3wp0IZ8FveTUE6+RV6JImrJTLq8TrNyjdUf5OW+y6XzcWUPz5QuGc3o8aprw==
X-Received: by 2002:a50:ef0a:0:b0:532:b5cb:114a with SMTP id m10-20020a50ef0a000000b00532b5cb114amr5797637eds.23.1696523938049;
        Thu, 05 Oct 2023 09:38:58 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id d5-20020a50fe85000000b0053498aa4f41sm1299607edt.48.2023.10.05.09.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 09:38:57 -0700 (PDT)
Message-ID: <8c810f89-43f3-3742-60b8-1ba622321be8@redhat.com>
Date:   Thu, 5 Oct 2023 18:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Jim Mattson <jmattson@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20231004002038.907778-1-jmattson@google.com>
 <01009a2a-929e-ce16-6f44-1d314e6bcba5@intel.com>
 <CALMp9eR+Qudg++J_dmY_SGbM_kr=GQcRRcjuUxtm9rfaC_qeXQ@mail.gmail.com>
 <20231004075836.GBZR0bLC/Y09sSSYWw@fat_crate.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86: KVM: Add feature flag for AMD's
 FsGsKernelGsBaseNonSerializing
In-Reply-To: <20231004075836.GBZR0bLC/Y09sSSYWw@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 09:58, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 07:44:51PM -0700, Jim Mattson wrote:
>> The business of declaring breaking changes to the architectural
>> specification in a CPUID bit has never made much sense to me.
> How else should they be expressed then?
> 
> In some flaky PDF which changes URLs whenever the new corporate CMS gets
> installed?
> 
> Or we should do f/m/s matching which doesn't make any sense for VMs?

Nothing *needs* to be done other than documenting this retroactive 
change to what constitutes architectural behavior.  It's not a CPUID 
that can be queried to change behavior; the user can use CPUID to 
diagnose that something has broken, but the broken program cannot know 
in the first place that the CPUID bit exists.

I agree with Jim that it would be nice to have some bits from Intel, and 
some bits from AMD, that current processors always return as 1.  Future 
processors can change those to 0 as desired.

Intel did something similar with VMX.  They have a bunch of bits for 
which we don't know the meaning, but we know it is something that "right 
now always causes vmexits".  Even if in the future you might be able to 
disable it, the polarity of the bit is the same as for all other vmexit 
controls.

Paolo

