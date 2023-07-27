Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD10765015
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjG0Jnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjG0Jng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73F2D5A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690450918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfjeYG5xLJPz3EzsvfUrell+1AE3g43fvMdVtQbwndE=;
        b=gNNNXxwhhT23prUow+C3vO4+lhmK8GHuuBDBpXJpagcPlqURosdRISOnVYwjrlU8NLLgyF
        ISagFA7z5OpaezCzwYQCmpNMekM8n8ALNAQGg10n/vBoNDH3gpoDkWJFBLaYD/dKk/YRmS
        5Go2EeClmPqS2+kAbV7rtGV6wFUfs7E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-rYNgnKO9PkyVvgZwHtCzRw-1; Thu, 27 Jul 2023 05:41:57 -0400
X-MC-Unique: rYNgnKO9PkyVvgZwHtCzRw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b97f342349so6727111fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690450916; x=1691055716;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfjeYG5xLJPz3EzsvfUrell+1AE3g43fvMdVtQbwndE=;
        b=U483lFjP+cKA6mIncChuaia+kk5tqosibMqndoNK2V8yv+P3qS+lKejDyAR2z5B84W
         njiyA5CXT5bDnncATfRSdDPZNGLiDJdmLUOeJUW6Fb9/fxpIm6V+ZecM7hnALfRkUxSY
         rskpE+brNMpPq2eoyF+Wy65h0iO9Q/JPrgJYp6nThVjGEKy7e4Q1MazHw4SK5RkxDhTV
         hnwxHDCFZ2SS3QYIB4e1Nkm3D8/38BL629NKlzvw84g8Za3dyftYalyxSwYzJV+gT7jP
         uy7HnYxvOrdYlaDROrJH5VjPImlZ1MMm0Yu5GR5Jh5jsA7bsTSY61C14k/4tw18Walyj
         3OkQ==
X-Gm-Message-State: ABy/qLbg5iBpgAd1sgn4NU17jGA+AFy8poBTLFQaK916xxMagv9rbIOW
        0iff+GkDswX9O3iFa/1hZnnMIRINDXCDii6jknIImOnPF+gGCJwXWQXFfWe5tWVDziHJNRbKmpC
        XBkPXUOKP/rHS/G99krUBNDy4UdZN0eEn
X-Received: by 2002:a05:6512:682:b0:4fb:893e:8ffc with SMTP id t2-20020a056512068200b004fb893e8ffcmr1295652lfe.17.1690450915784;
        Thu, 27 Jul 2023 02:41:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFTA2HgUm2brJFZAzFf71G9fcrl+Wse+RnzoN0k15ro+yXgQPkF4mKy0Vtx8+KdllBcgmErYA==
X-Received: by 2002:a05:6512:682:b0:4fb:893e:8ffc with SMTP id t2-20020a056512068200b004fb893e8ffcmr1295623lfe.17.1690450915287;
        Thu, 27 Jul 2023 02:41:55 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003fc00212c1esm1338797wmk.28.2023.07.27.02.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:41:54 -0700 (PDT)
Message-ID: <73db2622-4985-2f93-a118-d7d249094239@redhat.com>
Date:   Thu, 27 Jul 2023 11:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz> <20230719224821.GC3528218@google.com>
 <9ef757dc-da4b-9fa1-de84-1328a74f18a7@redhat.com>
 <ZMIoQIS1t53XE4Kw@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMIoQIS1t53XE4Kw@dhcp22.suse.cz>
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

On 27.07.23 10:18, Michal Hocko wrote:
> On Wed 26-07-23 10:44:21, David Hildenbrand wrote:
>> On 20.07.23 00:48, Ross Zwisler wrote:
>>> On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
>>>> On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
>>>> [...]
>>>>> I do think that we need to fix this collision between ZONE_MOVABLE and memmap
>>>>> allocations, because this issue essentially makes the movablecore= kernel
>>>>> command line parameter useless in many cases, as the ZONE_MOVABLE region it
>>>>> creates will often actually be unmovable.
>>>>
>>>> movablecore is kinda hack and I would be more inclined to get rid of it
>>>> rather than build more into it. Could you be more specific about your
>>>> use case?
>>>
>>> The problem that I'm trying to solve is that I'd like to be able to get kernel
>>> core dumps off machines (chromebooks) so that we can debug crashes.  Because
>>> the memory used by the crash kernel ("crashkernel=" kernel command line
>>> option) is consumed the entire time the machine is booted, there is a strong
>>> motivation to keep the crash kernel as small and as simple as possible.  To
>>> this end I'm trying to get away without SSD drivers, not having to worry about
>>> encryption on the SSDs, etc.
>>
>> Okay, so you intend to keep the crashkernel area as small as possible.
>>
>>>
>>> So, the rough plan right now is:
>>>   > 1) During boot set aside some memory that won't contain kernel
>> allocations.
>>> I'm trying to do this now with ZONE_MOVABLE, but I'm open to better ways.
>>>
>>> We set aside memory for a crash kernel & arm it so that the ZONE_MOVABLE
>>> region (or whatever non-kernel region) will be set aside as PMEM in the crash
>>> kernel.  This is done with the memmap=nn[KMG]!ss[KMG] kernel command line
>>> parameter passed to the crash kernel.
>>>
>>> So, in my sample 4G VM system, I see:
>>>
>>>     # lsmem --split ZONES --output-all
>>>     RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
>>>     0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
>>>     0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
>>>     0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
>>>     0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
>>>     Memory block size:       128M
>>>     Total online memory:       4G
>>>     Total offline memory:      0B
>>>
>>> so I'll pass "memmap=256M!0x130000000" to the crash kernel.
>>>
>>> 2) When we hit a kernel crash, we know (hope?) that the PMEM region we've set
>>> aside only contains user data, which we don't want to store anyway.
>>
>> I raised that in different context already, but such assumptions are not
>> 100% future proof IMHO. For example, we might at one point be able to make
>> user page tables movable and place them on there.
>>
>> But yes, most kernel data structures (which you care about) will probably
>> never be movable and never end up on these regions.
>>
>>> We make a
>>> filesystem in there, and create a kernel crash dump using 'makedumpfile':
>>>
>>>     mkfs.ext4 /dev/pmem0
>>>     mount /dev/pmem0 /mnt
>>>     makedumpfile -c -d 31 /proc/vmcore /mnt/kdump
>>>
>>> We then set up the next full kernel boot to also have this same PMEM region,
>>> using the same memmap kernel parameter.  We reboot back into a full kernel.
>>>
>>> 3) The next full kernel will be a normal boot with a full networking stack,
>>> SSD drivers, disk encryption, etc.  We mount up our PMEM filesystem, pull out
>>> the kdump and either store it somewhere persistent or upload it somewhere.  We
>>> can then unmount the PMEM and reconfigure it back to system ram so that the
>>> live system isn't missing memory.
>>>
>>>     ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
>>>     daxctl reconfigure-device --mode=system-ram dax0.0
>>>
>>> This is the flow I'm trying to support, and have mostly working in a VM,
>>> except up until now makedumpfile would crash because all the memblock
>>> structures it needed were in the PMEM area that I had just wiped out by making
>>> a new filesystem. :)
>>
>>
>> Thinking out loud (and remembering that some architectures relocate the
>> crashkernel during kexec, if I am not wrong), maybe the following would also
>> work and make your setup eventually easier:
>>
>> 1) Don't reserve a crashkernel area in the traditional way, instead reserve
>> that area using CMA. It can be used for MOVABLE allocations.
>>
>> 2) Let kexec load the crashkernel+initrd into ordinary memory only
>> (consuming as much as you would need there).
>>
>> 3) On kexec, relocate the crashkernel+initrd into the CMA area (overwriting
>> any movable data in there)
>>
>> 4) In makedumpfile, don't dump any memory that falls into the crashkernel
>> area. It might already have been overwritten by the second kernel
> 
> This is more or less what Jiri is looking into.
> 

Ah, very nice.

-- 
Cheers,

David / dhildenb

