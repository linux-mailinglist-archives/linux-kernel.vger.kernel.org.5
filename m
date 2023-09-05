Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185097931F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbjIEW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjIEW10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F86185
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693952796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P53xpZIm8SYrhpnm0HNoTp/sm01rAuTkQ8t2oErEkPI=;
        b=NCeeIw2K+Ola+33rD3jTZdKcxAQOZDY7T2NxyUbmPuRZQjAaUYHwy7g/ryjBdQx0s/79J2
        xJ/IVLemrE2DpVFnmNMMfjb5M897l3UzzjggzeLycG2sA5r6ipTxti63YKLJBeFf8Ikrlu
        jIYxn/Z3/4uck4mobJehs2ha3DbK5to=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-gmb15IJNN9Wzsz7tg_pb5g-1; Tue, 05 Sep 2023 18:26:35 -0400
X-MC-Unique: gmb15IJNN9Wzsz7tg_pb5g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68a3cae6e20so3409842b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693952794; x=1694557594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P53xpZIm8SYrhpnm0HNoTp/sm01rAuTkQ8t2oErEkPI=;
        b=lRjswRftgSgYjskxZ5Z66RTrv6GjEuNTzOFKssh58GT7fsDPBsBbuAtS7F58OMbRHJ
         Zwmx9NdXSuo+xSkZkuvz4hgBUHRR6ZShWIX1ha0qUf8jH4Y/csQEq6oX4INdWPMLXLU2
         OImfsN3WcvzIm8P4fU2DJYo4VOU/NrzVTuJ2h7ZID6nKuoI4HHMI6CwznOheU4d42eLB
         2M6brwUFbjojZdDMObA2MG4+jhT5QcI6UvX1ZSQzMEOI2vv+bl65BFSByv9x3+na8gIe
         c77V9fc4nXYuJWRK2sSM2sUEstDkX6lJcyQYyeISuHjZ0d/osJAsxUWjNACJ0GHCbXQc
         II5Q==
X-Gm-Message-State: AOJu0Yw+8BCybAGjl4+Z5xc8IWJF3J5oeTCfS6nXrLlKGET7fp/AGqxI
        lQqQBWqhmuTCKhG7z+NcnFAPzkQQ3JIK/X8CkO+5TeKqcfOXaNF4291SmfuU/5e/A7VKUN4oy4/
        LpQ+kdcJmTkxRCVAGwjyj2JxZ
X-Received: by 2002:a05:6a00:3004:b0:68a:667d:2294 with SMTP id ay4-20020a056a00300400b0068a667d2294mr12146781pfb.20.1693952794241;
        Tue, 05 Sep 2023 15:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWGLSbbVgl4oER7MTTjh+tIpR83rtWk1znrzrNTRird3DNTKYmXWbbdS1zxNOXBaAI2jhXrA==
X-Received: by 2002:a05:6a00:3004:b0:68a:667d:2294 with SMTP id ay4-20020a056a00300400b0068a667d2294mr12146768pfb.20.1693952793954;
        Tue, 05 Sep 2023 15:26:33 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id a30-20020a63705e000000b0056f8b44058csm9780336pgn.12.2023.09.05.15.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 15:26:32 -0700 (PDT)
Message-ID: <bfdafdc5-4abf-a387-0857-e8cb84e4b3d7@redhat.com>
Date:   Wed, 6 Sep 2023 08:26:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] KVM: arm64: Fix soft-lockup on relaxing PTE permission
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        qperret@google.com, ricarkol@google.com, tabba@google.com,
        bgardon@google.com, zhenyzha@redhat.com, yihyu@redhat.com,
        shan.gavin@gmail.com
References: <20230904072826.1468907-1-gshan@redhat.com>
 <ZPWPoEgBETeI1um1@linux.dev>
 <0f93a015-4f10-b53e-f67f-a84db43ca533@redhat.com>
 <ZPduJ08GKaKXwIhM@linux.dev>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZPduJ08GKaKXwIhM@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 04:06, Oliver Upton wrote:
> On Tue, Sep 05, 2023 at 10:06:14AM +1000, Gavin Shan wrote:
> 
> [...]
> 
>>>    static inline void __invalidate_icache_guest_page(void *va, size_t size)
>>>    {
>>> +	size_t nr_lines = size / __icache_line_size();
>>> +
>>>    	if (icache_is_aliasing()) {
>>>    		/* any kind of VIPT cache */
>>>    		icache_inval_all_pou();
>>>    	} else if (read_sysreg(CurrentEL) != CurrentEL_EL1 ||
>>>    		   !icache_is_vpipt()) {
>>>    		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
>>> -		icache_inval_pou((unsigned long)va, (unsigned long)va + size);
>>> +		if (nr_lines > MAX_TLBI_OPS)
>>> +			icache_inval_all_pou();
>>> +		else
>>> +			icache_inval_pou((unsigned long)va,
>>> +					 (unsigned long)va + size);
>>>    	}
>>>    }
>>
>> I'm not sure if it's worthy to pull the @iminline from CTR_EL0 since it's almost
>> fixed to 64-bytes.
> 
> I firmly disagree. The architecture allows implementers to select a
> different minimum line size, and non-64b systems _do_ exist in the wild.
> Furthermore, some implementers have decided to glue together cores with
> mismatched line sizes too...
> 
> Though we could avoid some headache by normalizing on 64b, the cold
> reality of the ecosystem requires that we go out of our way to
> accomodate ~any design choice allowed by the architecture.
> 

It seems I didn't make it clear enough. The reason why I had the concern
to avoid reading ctr_el0 is we read ctr_el0 for twice in the following path,
but I doubt if anybody cares. Since it's a hot path, each bit of performance
gain will count.

   invalidate_icache_guest_page
   __invalidate_icache_guest_page   // first read on ctr_el0, with your code changes
   icache_inval_pou(va, va + size)
   invalidate_icache_by_line
     icache_line_size               // second read on ctr_el0


>> @size is guranteed to be PAGE_SIZE or PMD_SIZE aligned. Maybe
>> we can just aggressively do something like below, disregarding the icache thrashing.
>> In this way, the code is further simplified.
>>
>>      if (size > PAGE_SIZE) {
>>          icache_inval_all_pou();
>>      } else {
>>          icache_inval_pou((unsigned long)va,
>>                           (unsigned long)va + size);
>>      }                                                          // parantheses is still needed
> 
> This could work too but we already have a kernel heuristic for limiting
> the amount of broadcast invalidations, which is MAX_TLBI_OPS. I don't
> want to introduce a second, KVM-specific hack to address the exact same
> thing.
> 

Ok. I was confused at the first glance since TLB isn't relevant to icache.
I think it's fine to reuse MAX_TLBI_OPS here, but a comment may be needed.
Oliver, could you please send a formal patch for your changes?

>> I'm leveraging the chance to ask one question, which isn't related to the issue.
>> It seems we're doing the icache/dcache coherence differently for stage1 and stage-2
>> page table entries. The question is why we needn't to clean the dcache for stage-2,
>> as we're doing for the stage-1 case?
> 
> KVM always does its required dcache maintenance (if any) on the first
> translation abort to a given IPA. On systems w/o FEAT_DIC, we lazily
> grant execute permissions as an optimization to avoid unnecessary icache
> invalidations, which as you've seen tends to be a bit of a sore spot.
> 
> Between the two faults, we've effectively guaranteed that any
> host-initiated writes to the PA are visible to the guest on both the I
> and D side. Any CMOs for making guest-initiated writes coherent after
> the translation fault are the sole responsibility of the guest.
> 

Nice, thanks a lot for the explanation.

Thanks,
Gavin




