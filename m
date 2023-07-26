Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC253763731
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjGZNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjGZNJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3812109
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690376905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avrBEUTuEMAIDicd1OwUA012koY+T/4dTdNNwPp3WGw=;
        b=Ye9OdI5EA43pf8Grwd3qSdMX/ps60UPAzU1e74LlDpf6AKhMkQAYyF3z06C96lDGZc05cg
        8rqlqO3uZOwuaJ8g2mwSXyXVoYPWSVysbtpRBTFGOBW+a2V1scBQABpWCXTlW/vmHzM+JS
        Wj0MxSpMrzUgDU7v4Bz/V1f4pWwgUjs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-S6HzD9NCPE68VJ1a_6osFw-1; Wed, 26 Jul 2023 09:08:24 -0400
X-MC-Unique: S6HzD9NCPE68VJ1a_6osFw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315af0252c2so3937071f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376903; x=1690981703;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avrBEUTuEMAIDicd1OwUA012koY+T/4dTdNNwPp3WGw=;
        b=d8XMj3z3+3qwLdI8Kmp2YU268Jm9ncmg02FBSQzg+QTuaWs/eMtLUG2CYkHtpRst3C
         bglHYgNH5as6q9NQOXg1OlfhMDmjT+InyPYZRA0KOT8NrTAFL9lvLDfyH3klJu+jHtSR
         65QVPoGHlAxzgVeWSWXvn/4IqG5FvtBFHqG/MJVeyDaaLQAMneh8Ibjo0qtOG51715v2
         CQYQpg4e17YoZAm5IYO0kV63RF4DYAQXUsGWHh6Vm7OFWl+5Onog6MC031rn/1BdOhgJ
         pOa/3Lv65FgNBpjdw1y8T3RXS/uWczbjv2x5z7CkJRgDkDowYsEYjFW2bhvxeCavagnJ
         upGw==
X-Gm-Message-State: ABy/qLZpXgLqc7nQSn31mMAFtAFvIFiebyNAR/P6s2jPkCkn3phT4qoW
        a5aJ1tywm0/9NNX7u+m8V+KRsmCryxC3fI8nmNiK3ymjTIQQyvNGvHRDzyUkj9xj13fsbfo3unC
        gjvVeYJDdseKFgEGKjKKOiP2XH8YkmvYr
X-Received: by 2002:adf:ec4d:0:b0:313:ecd3:7167 with SMTP id w13-20020adfec4d000000b00313ecd37167mr1273683wrn.42.1690376902867;
        Wed, 26 Jul 2023 06:08:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUkIfUehug4Ptv1ARzzTssnb/6d+JMTWFEK0q14fqtkTNQ62TNbqeKlGg8UAoh56+n2Q/6iQ==
X-Received: by 2002:adf:ec4d:0:b0:313:ecd3:7167 with SMTP id w13-20020adfec4d000000b00313ecd37167mr1273668wrn.42.1690376902441;
        Wed, 26 Jul 2023 06:08:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f600:a519:c50:799b:f1e3? (p200300cbc705f600a5190c50799bf1e3.dip0.t-ipconnect.de. [2003:cb:c705:f600:a519:c50:799b:f1e3])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b003143c9beeaesm19932371wrr.44.2023.07.26.06.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:08:21 -0700 (PDT)
Message-ID: <e0db053b-1808-9e67-020e-105dfc4caef1@redhat.com>
Date:   Wed, 26 Jul 2023 15:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Ross Zwisler <zwisler@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz> <20230719224821.GC3528218@google.com>
 <9ef757dc-da4b-9fa1-de84-1328a74f18a7@redhat.com>
Organization: Red Hat
In-Reply-To: <9ef757dc-da4b-9fa1-de84-1328a74f18a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.23 10:44, David Hildenbrand wrote:
> On 20.07.23 00:48, Ross Zwisler wrote:
>> On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
>>> On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
>>> [...]
>>>> I do think that we need to fix this collision between ZONE_MOVABLE and memmap
>>>> allocations, because this issue essentially makes the movablecore= kernel
>>>> command line parameter useless in many cases, as the ZONE_MOVABLE region it
>>>> creates will often actually be unmovable.
>>>
>>> movablecore is kinda hack and I would be more inclined to get rid of it
>>> rather than build more into it. Could you be more specific about your
>>> use case?
>>
>> The problem that I'm trying to solve is that I'd like to be able to get kernel
>> core dumps off machines (chromebooks) so that we can debug crashes.  Because
>> the memory used by the crash kernel ("crashkernel=" kernel command line
>> option) is consumed the entire time the machine is booted, there is a strong
>> motivation to keep the crash kernel as small and as simple as possible.  To
>> this end I'm trying to get away without SSD drivers, not having to worry about
>> encryption on the SSDs, etc.
> 
> Okay, so you intend to keep the crashkernel area as small as possible.
> 
>>
>> So, the rough plan right now is:
>>   > 1) During boot set aside some memory that won't contain kernel
> allocations.
>> I'm trying to do this now with ZONE_MOVABLE, but I'm open to better ways.
>>
>> We set aside memory for a crash kernel & arm it so that the ZONE_MOVABLE
>> region (or whatever non-kernel region) will be set aside as PMEM in the crash
>> kernel.  This is done with the memmap=nn[KMG]!ss[KMG] kernel command line
>> parameter passed to the crash kernel.
>>
>> So, in my sample 4G VM system, I see:
>>
>>     # lsmem --split ZONES --output-all
>>     RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
>>     0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
>>     0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
>>     0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
>>     0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
>>     
>>     Memory block size:       128M
>>     Total online memory:       4G
>>     Total offline memory:      0B
>>
>> so I'll pass "memmap=256M!0x130000000" to the crash kernel.
>>
>> 2) When we hit a kernel crash, we know (hope?) that the PMEM region we've set
>> aside only contains user data, which we don't want to store anyway.
> 
> I raised that in different context already, but such assumptions are not
> 100% future proof IMHO. For example, we might at one point be able to
> make user page tables movable and place them on there.
> 
> But yes, most kernel data structures (which you care about) will
> probably never be movable and never end up on these regions.
> 
>> We make a
>> filesystem in there, and create a kernel crash dump using 'makedumpfile':
>>
>>     mkfs.ext4 /dev/pmem0
>>     mount /dev/pmem0 /mnt
>>     makedumpfile -c -d 31 /proc/vmcore /mnt/kdump
>>
>> We then set up the next full kernel boot to also have this same PMEM region,
>> using the same memmap kernel parameter.  We reboot back into a full kernel.
>>
>> 3) The next full kernel will be a normal boot with a full networking stack,
>> SSD drivers, disk encryption, etc.  We mount up our PMEM filesystem, pull out
>> the kdump and either store it somewhere persistent or upload it somewhere.  We
>> can then unmount the PMEM and reconfigure it back to system ram so that the
>> live system isn't missing memory.
>>
>>     ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
>>     daxctl reconfigure-device --mode=system-ram dax0.0
>>
>> This is the flow I'm trying to support, and have mostly working in a VM,
>> except up until now makedumpfile would crash because all the memblock
>> structures it needed were in the PMEM area that I had just wiped out by making
>> a new filesystem. :)
> 
> 
> Thinking out loud (and remembering that some architectures relocate the
> crashkernel during kexec, if I am not wrong), maybe the following would
> also work and make your setup eventually easier:
> 
> 1) Don't reserve a crashkernel area in the traditional way, instead
> reserve that area using CMA. It can be used for MOVABLE allocations.
> 
> 2) Let kexec load the crashkernel+initrd into ordinary memory only
> (consuming as much as you would need there).

Oh, I realized that one might be able to place the kernel+initrd 
directly in the area by allocating via CMA.

-- 
Cheers,

David / dhildenb

