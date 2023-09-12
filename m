Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B979D27E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjILNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjILNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE21010D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694525875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8XuT8Agjw2qdGWvR9xAnHz2rWjvijMwo4L1Kk5WWDI=;
        b=d8fGSIVRFzcVgxx2SgakZIalQwNi9e8NDaOHoKMJktDqIm9k1TeX8q9U8gXAgNP1qPzrEE
        3vCMxeYYoBCmsQ133qZq4MuEgeq2vtlO4bNTzZ1E+8C+FRZf30HxKmGHgFYpm9yWFHYblp
        U6KQ1b/nnrRAzF9LsyPHJuXasKgIT7o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Mv3rquVLOK6w74aE-6jbGg-1; Tue, 12 Sep 2023 09:37:54 -0400
X-MC-Unique: Mv3rquVLOK6w74aE-6jbGg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31f46ccee0fso2652587f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525872; x=1695130672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8XuT8Agjw2qdGWvR9xAnHz2rWjvijMwo4L1Kk5WWDI=;
        b=tbJ5CaRcBqvrdcMHmhTq0L0zIb7svPk/zKPINmKndYKr/PWGkE6wkiBa+bNRbdZeMe
         +WeEoYG14s8WBpmWb2+i1PKIH1YCEsYnWvTcpL2A12+ydVmI30eGjhqtY5U7BFepr77E
         wymMspzvwTgPUaxfb6WmmEiIxgt389hrl+Qoo5ut46kUwbP0hjXUNmw67eLh8qLVx0Ko
         v2ek7g0eMlrywzu8PPCBDvSDAZLFjpWqypBOKOpEmGVe1mu06lxYDlhCyvA55xZBj2Ln
         ekVKWKiIerA3QOtycKssDViwwbeAlEx0DTvgCHKY7K0TT7mWlbPKZKPLWI0WAFATiZy5
         82jA==
X-Gm-Message-State: AOJu0Yxx5tOOwHZYHzPmmg+cLzcJqNUiqHu+gFyNgjwhVFKVIHP5HjTz
        2U2ZCDNCljEqMn+LBvb9cfPx0oUejiXLZPZx+FqCuyjf4hPglMzpzNTX/P2YEgzqkOZ2NT5LgZQ
        e+ns8+HHSX3A7CycCamyvoYp8
X-Received: by 2002:a5d:61c4:0:b0:31f:a869:f6 with SMTP id q4-20020a5d61c4000000b0031fa86900f6mr1973650wrv.24.1694525872626;
        Tue, 12 Sep 2023 06:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8+Up7033Ajwqs9kI8D/hF334kV6WYoYuW+S7k+HUmg+gQQNdn7nadj2oIeu507pibA+TW9g==
X-Received: by 2002:a5d:61c4:0:b0:31f:a869:f6 with SMTP id q4-20020a5d61c4000000b0031fa86900f6mr1973633wrv.24.1694525872240;
        Tue, 12 Sep 2023 06:37:52 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id t15-20020adff04f000000b0031434c08bb7sm12829847wro.105.2023.09.12.06.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:37:51 -0700 (PDT)
Message-ID: <e95c3a61-45bf-40f7-1f5a-67e1b7e64db4@redhat.com>
Date:   Tue, 12 Sep 2023 15:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
To:     "Huang, Kai" <kai.huang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
References: <cover.1692096753.git.kai.huang@intel.com>
 <a64122a6-0be1-8263-4629-8cae0c013305@redhat.com>
 <f94aa81502421f169806c1349efb28c74878ea46.camel@intel.com>
 <BL1PR11MB5978F08618A3E2389618F33CF7F1A@BL1PR11MB5978.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <BL1PR11MB5978F08618A3E2389618F33CF7F1A@BL1PR11MB5978.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 02:57, Huang, Kai wrote:
>>> +#include <asm/tdx.h>
>>> 
>>> #include <asm-generic/asm-prototypes.h>
>>> 
>> Thanks Paolo!
>> 
>> I never met this issue, not even from LKP.  Do you happen to know
>> which Kconfig option can trigger this?  Or would you mind sharing
>> your .config?
> (replying via outlook due to some networking issue of my home
> network)
> 
> After digging, this is due to exporting __seamcall*() assembly
> functions while MODVERSIONS is enabled.
> 
> This series itself doesn't cause this warning.
> 
> I didn't export them in this series because I would like to leave to
> KVM patches when we are sure we need to export them.
> 
> E.g., I have seamcall*() wrappers to retry running out of entropy,
> and we may have concern exporting __seamcall*() low level functions
> directly and may wish to export higher level wrappers.
> 
> So I think the fix should be with the patch that truly exports those
> __seamcall*().  I'll talk to Isaku on this to get his idea.

Ah indeed it's not caused by your patches, but rather by the Isaku's KVM 
TDX support ("KVM: TDX: Add C wrapper functions for SEAMCALLs to the TDX 
module").  The fix is just to squash the #include into his patch.

Paolo

