Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D927CD5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjJRHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjJRHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CBBC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697615527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RHU5Hd39FUrVAV5loRQ1RiePBE82/byfLGhIqj8tiII=;
        b=b7+pqYhvqbLisqItcn5tyjs12Ug9UXQucYwVC8X2NkMVPKzOqsSphqemLXaxRKAKailVhx
        a8UjAP9rs++YMveImQeNmCmNPlX9s+Fe189pd1dDDr3gRSWs8JBNJbYd/cbc2b0NGewG95
        Gvl0QvqczuspCB5JxOMLC294Jn/9rU4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-eBPrSne1PKufKvPDpHavoA-1; Wed, 18 Oct 2023 03:52:04 -0400
X-MC-Unique: eBPrSne1PKufKvPDpHavoA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32db9cd71d7so1351071f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615523; x=1698220323;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHU5Hd39FUrVAV5loRQ1RiePBE82/byfLGhIqj8tiII=;
        b=nh2oWdGlK7pz45qd+B7VaErD6TduoGxmJ40s4zM4AuJ8f0nCmvBxllG1oQ/Yp785gX
         qXwFAY/ZYsiuu70n0PPlkgc9xW6sqMYb5+Ym9Vc4CsHSxY6ki2MroAjRahblIS2A0Ref
         34N0qZbjFPiGiql08NlSXAdtvZgtc2HRHyfA2yi/0KV49tzLVOYYbehWeGACC/dVX0nv
         mdI4bs2qsecmuMOemvckLjI3xZoC3l27MQYWyQCU9zbCsPyIuIU8neuTS6L2HYfweNHh
         ixlZTNne+EZEa6arVkw6Z5gXVOVWcu3hdczTDj36dBzdad0+tuTr5FVamACthTXuM17a
         ewWg==
X-Gm-Message-State: AOJu0Yx0hMKmYr5gYh3ee52EJqhKHxnEnAh7fKUp127uyUIJ6GT+VVTD
        3USqI0jZlVOnCvbAYEvDfF+INPGQuJ3pFK+CdopS1+YalxIcxJHnVGd48JPsk+GGmr2Oa/hDIn3
        qBEnLkEIAUdF+fHbP2nJ44kv8
X-Received: by 2002:a05:6000:b90:b0:32d:c76f:299e with SMTP id dl16-20020a0560000b9000b0032dc76f299emr3762795wrb.19.1697615522870;
        Wed, 18 Oct 2023 00:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQkhmtCUMSZwDH9L0u+eMmT0hnvuPZIJdkFV3319moRmx057s+D42w02GTuO9Exs8Q8EZUCw==
X-Received: by 2002:a05:6000:b90:b0:32d:c76f:299e with SMTP id dl16-20020a0560000b9000b0032dc76f299emr3762765wrb.19.1697615522319;
        Wed, 18 Oct 2023 00:52:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:d300:5c7b:51ce:e3ef:6e01? (p200300cbc70ad3005c7b51cee3ef6e01.dip0.t-ipconnect.de. [2003:cb:c70a:d300:5c7b:51ce:e3ef:6e01])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c499100b0040772138bb7sm939078wmp.2.2023.10.18.00.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:52:01 -0700 (PDT)
Message-ID: <e4386b0a-325e-4757-a993-dcf9fec220c3@redhat.com>
Date:   Wed, 18 Oct 2023 09:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     osalvador@suse.de, dan.j.williams@intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20231014152532.5f3dca7838c2567a1a9ca9c6@linux-foundation.org>
 <a46cf10b-d852-c671-ee20-40f39bdbceac@redhat.com>
 <994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.23 15:38, Charan Teja Kalla wrote:
> Thanks Andrew/David,
> 
> On 10/16/2023 1:53 PM, David Hildenbrand wrote:
>>>> The below race is observed on a PFN which falls into the device memory
>>>> region with the system memory configuration where PFN's are such that
>>>> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL]. Since normal zone start and
>>>> end pfn contains the device memory PFN's as well, the compaction
>>>> triggered will try on the device memory PFN's too though they end up in
>>>> NOP(because pfn_to_online_page() returns NULL for ZONE_DEVICE memory
>>>> sections). When from other core, the section mappings are being removed
>>>> for the ZONE_DEVICE region, that the PFN in question belongs to,
>>>> on which compaction is currently being operated is resulting into the
>>>> kernel crash with CONFIG_SPASEMEM_VMEMAP enabled.
>>>
>>> Seems this bug is four years old, yes?  It must be quite hard to hit.
>>
>>  From the description, it's not quite clear to me if this was actually
>> hit -- usually people include the dmesg bug/crash info.
> 
> On Snapdragon SoC,  with the mentioned memory configuration of PFN's as
> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL],  we are able to see bunch of
> issues daily while testing on a device farm.
> 
> I note that from next time on wards will send the demsg bug/crash info
> for these type of issues. For this particular issue below is the log.
> Though the below log is not directly pointing to the
> pfn_section_valid(){ ms->usage;}, when we loaded this dump on T32
> lauterbach tool, it is pointing.
> 
> [  540.578056] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  540.578068] Mem abort info:
> [  540.578070]   ESR = 0x0000000096000005
> [  540.578073]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  540.578077]   SET = 0, FnV = 0
> [  540.578080]   EA = 0, S1PTW = 0
> [  540.578082]   FSC = 0x05: level 1 translation fault
> [  540.578085] Data abort info:
> [  540.578086]   ISV = 0, ISS = 0x00000005
> [  540.578088]   CM = 0, WnR = 0
> [  540.579431] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS
> BTYPE=--)
> [  540.579436] pc : __pageblock_pfn_to_page+0x6c/0x14c
> [  540.579454] lr : compact_zone+0x994/0x1058
> [  540.579460] sp : ffffffc03579b510
> [  540.579463] x29: ffffffc03579b510 x28: 0000000000235800 x27:
> 000000000000000c
> [  540.579470] x26: 0000000000235c00 x25: 0000000000000068 x24:
> ffffffc03579b640
> [  540.579477] x23: 0000000000000001 x22: ffffffc03579b660 x21:
> 0000000000000000
> [  540.579483] x20: 0000000000235bff x19: ffffffdebf7e3940 x18:
> ffffffdebf66d140
> [  540.579489] x17: 00000000739ba063 x16: 00000000739ba063 x15:
> 00000000009f4bff
> [  540.579495] x14: 0000008000000000 x13: 0000000000000000 x12:
> 0000000000000001
> [  540.579501] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffffff897d2cd440
> [  540.579507] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
> ffffffc03579b5b4
> [  540.579512] x5 : 0000000000027f25 x4 : ffffffc03579b5b8 x3 :
> 0000000000000001
> [  540.579518] x2 : ffffffdebf7e3940 x1 : 0000000000235c00 x0 :
> 0000000000235800
> [  540.579524] Call trace:
> [  540.579527]  __pageblock_pfn_to_page+0x6c/0x14c
> [  540.579533]  compact_zone+0x994/0x1058
> [  540.579536]  try_to_compact_pages+0x128/0x378
> [  540.579540]  __alloc_pages_direct_compact+0x80/0x2b0
> [  540.579544]  __alloc_pages_slowpath+0x5c0/0xe10
> [  540.579547]  __alloc_pages+0x250/0x2d0
> [  540.579550]  __iommu_dma_alloc_noncontiguous+0x13c/0x3fc
> [  540.579561]  iommu_dma_alloc+0xa0/0x320
> [  540.579565]  dma_alloc_attrs+0xd4/0x108
> 
>>>> Fix this issue by the below steps:
>>>> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
>>>> b) RCU protected read side critical section will either return NULL when
>>>> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
>>>> c) Synchronize the rcu on the write side and free the ->usage. No
>>>> attempt will be made to access ->usage after this as the
>>>> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.
>>
>>
>> This affects any kind of memory hotunplug. When hotunplugging memory we
>> will end up calling synchronize_rcu() for each and every memory section,
>> which sounds extremely wasteful.
>>
>> Can't we find a way to kfree_rcu() that thing and read/write the pointer
>> using READ?ONCE?WRITE_ONCE instead?
> 
> I am inspired to use the synchronize_rcu() because of [1] where we did
> use it in offline_page_ext(). And my limited understanding is that, a
> user can trigger the offline operation more often than the unplug operation.

In theory yes. In practice there are not many use cases where we do that.

Further, page_ext is already not used that frequently (page owner, 
young, idle tracking only), especially in most production (!debug) 
environments.

> 
> I agree here that there is a scope to use kfree_rcu() unlike in [1]. Let
> me check for a way to use it.

Exactly, if we could use that, it would be ideal.

-- 
Cheers,

David / dhildenb

