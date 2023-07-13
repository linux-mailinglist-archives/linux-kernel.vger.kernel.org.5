Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9C75279A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjGMPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjGMPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEE273B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689263008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLikHNWVNU/FNpgKCSfkRGEY/lyXivfIFOAmn8fr+kQ=;
        b=RnRJ9f2hV9KFiM7Xk5Ut3MOs/qpRGiSwWpoy0hme7Itvu49LgZiVbcXGHs4jOPgmH/jItQ
        aj3E5HLoL2tJ70y3YGtGtdF6tcQo4Txj/FQ5UbUKQAQAIziQbrnuZWh4mcMa4mZQL9FqCP
        aCvK8yNOpBllCvoi0aKecccHDj7AYEc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-tRcAHoETOw6FckLN5qqehg-1; Thu, 13 Jul 2023 11:43:26 -0400
X-MC-Unique: tRcAHoETOw6FckLN5qqehg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31596170243so622681f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263005; x=1691855005;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLikHNWVNU/FNpgKCSfkRGEY/lyXivfIFOAmn8fr+kQ=;
        b=BkedGY1XrvRfKWiwCgErd7VL7mxy89L4b56FnIdPAWTrrgj6T6mlNFEAgqx80ghRuI
         VV0l1gtjgJrIP4I2en8GUzU1wS9zhh+4AwfXMkHqN1y3ksab9qumGt1jtIy93R0tFzDJ
         ECRERQaQUa3epJMnE9gBYnq0OexhrNcrjG6Hta6ZqRG4DIcmEH0P2h7pCx/jgsD1mYc8
         140iTcGNHl0ZjFsNAUpgqWKXZU2Y743o7a05ZCnCnughnUX044lpgY8kei1qtn/tOESv
         UlRuXGzjf19Q2ZcNxOnpHz+zp9a2VrGYbEQEoTpfHDhNOIP9rbBCl+knm3dAHInFgVgw
         X4Kw==
X-Gm-Message-State: ABy/qLZ5thwdG7oTIKIHPjpXPMumAwgB2JP9W7DLWtGUaSDdz+sY22Dt
        vVmklhIwwlWLRPsG0VpsDmTSPGOTBkKFHYwXCP4derAClC4Hvtf9eFPveGGRlDr81jcJD27/Mb7
        HHSVzGm858G9UXVYi2x+H8gZo
X-Received: by 2002:adf:e681:0:b0:313:f4e2:901d with SMTP id r1-20020adfe681000000b00313f4e2901dmr2049831wrm.22.1689263004839;
        Thu, 13 Jul 2023 08:43:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1/YUAbO+tUpcHHd06mVmoTHYbiWHrgz1Hqa9kz78W45sfnOZ2occ1rxo5df7lIzOiCn/o3Q==
X-Received: by 2002:adf:e681:0:b0:313:f4e2:901d with SMTP id r1-20020adfe681000000b00313f4e2901dmr2049814wrm.22.1689263004497;
        Thu, 13 Jul 2023 08:43:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b002c70ce264bfsm8285044wru.76.2023.07.13.08.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:43:24 -0700 (PDT)
Message-ID: <de39c555-e092-8e57-43a4-7a2c56d1e66c@redhat.com>
Date:   Thu, 13 Jul 2023 17:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
 <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
 <87edleplkn.fsf@linux.ibm.com>
 <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
 <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
 <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
 <6cb5624ebf3039b18f5180262fc6383b402d26ea.camel@intel.com>
 <80c8654e-21fb-b187-3475-9a1410a53a4e@redhat.com>
 <b62572356db07ae0c3305ed03916b0ff40b14426.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b62572356db07ae0c3305ed03916b0ff40b14426.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 17:40, Verma, Vishal L wrote:
> On Thu, 2023-07-13 at 17:23 +0200, David Hildenbrand wrote:
>> On 13.07.23 17:15, Verma, Vishal L wrote:
>>> On Thu, 2023-07-13 at 09:23 +0200, David Hildenbrand wrote:
>>>> On 13.07.23 08:45, Verma, Vishal L wrote:
>>>>>
>>>>> I'm taking a shot at implementing the splitting internally in
>>>>> memory_hotplug.c. The caller (kmem) side does become trivial with this
>>>>> approach, but there's a slight complication if I don't have the module
>>>>> param override (patch 1 of this series).
>>>>>
>>>>> The kmem diff now looks like:
>>>>>
>>>>>       diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>>       index 898ca9505754..8be932f63f90 100644
>>>>>       --- a/drivers/dax/kmem.c
>>>>>       +++ b/drivers/dax/kmem.c
>>>>>       @@ -105,6 +105,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>               data->mgid = rc;
>>>>>        
>>>>>               for (i = 0; i < dev_dax->nr_range; i++) {
>>>>>       +               mhp_t mhp_flags = MHP_NID_IS_MGID | MHP_MEMMAP_ON_MEMORY |
>>>>>       +                                 MHP_SPLIT_MEMBLOCKS;
>>>>>                       struct resource *res;
>>>>>                       struct range range;
>>>>>        
>>>>>       @@ -141,7 +143,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>                        * this as RAM automatically.
>>>>>                        */
>>>>>                       rc = add_memory_driver_managed(data->mgid, range.start,
>>>>>       -                               range_len(&range), kmem_name, MHP_NID_IS_MGID);
>>>>>       +                               range_len(&range), kmem_name, mhp_flags);
>>>>>        
>>>>>                       if (rc) {
>>>>>                               dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>>>>>       
>>>>>
>>>>
>>>> Why do we need the MHP_SPLIT_MEMBLOCKS?
>>>
>>> I thought we still wanted either an opt-in or opt-out for the kmem
>>> driver to be able to do memmap_on_memory, in case there were
>>> performance implications or the lack of 1GiB PUDs. I haven't
>>> implemented that yet, but I was thinking along the lines of a sysfs
>>> knob exposed by kmem, that controls setting of this new
>>> MHP_SPLIT_MEMBLOCKS flag.
>>
>> Why is MHP_MEMMAP_ON_MEMORY not sufficient for that?
>>
>>
> Ah I see what you mean now - knob just controls MHP_MEMMAP_ON_MEMORY,
> and memory_hotplug is free to split to memblocks if it needs to to
> satisfy that.

And if you don't want memmap holes in a larger area you're adding (for 
example to runtime-allocate 1 GiB pages), simply check the size your 
adding, and if it's, say, less than 1 G, don't set the flag.

But that's probably a corner case use case not worth considering for now.

> 
> That sounds reasonable. Let me give this a try and see if I run into
> anything else. Thanks David!

Sure!

-- 
Cheers,

David / dhildenb

