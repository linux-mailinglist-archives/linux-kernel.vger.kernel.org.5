Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE2763083
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGZIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjGZIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD204C0D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690361066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lL0ygifzgSDKujqi7KQAvSTuQ2XO7Cnzt9tFycfXrQ=;
        b=SulJ4g9H6ThpqYMHGX2vwQF+ilhCkphjI+iTPA+eRsJcHu04JyVhd1idHiv0V2fGAnRmW1
        kUqe3kBcD1/huvOWd5OA54htITvQddlySGK/rwdFiaq9IzFdmeiEk4J5j5YpVCanWJlmxn
        aq0rCuMopGOO8AfDKlrL7WZhXZiItvw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-wxmvDuBaMsuMzkPMFoK6nA-1; Wed, 26 Jul 2023 04:44:24 -0400
X-MC-Unique: wxmvDuBaMsuMzkPMFoK6nA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9525b64d2so54537311fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361063; x=1690965863;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lL0ygifzgSDKujqi7KQAvSTuQ2XO7Cnzt9tFycfXrQ=;
        b=aojcqct8RoKeeQTT2cEvopWQGfAyOZT5PgrZKL8sUgNLpwP5wRHvokfa3FYaQH6WwN
         wBWrRFlFuyY6HPPNaO6E4RgiH2MWwSjPDrliS6ZKNlMs3fSEhRZs/bQNqypE+PoZ75g3
         zWPr0GMo1gG+cHd1nq/HqdCThUw8OgLp6BjZqKSBq2lA/jnwnUk0T3a8HGwdJFbow1h8
         /aAr0ZvGi3AluX/g1afPohbsKrY3jrzqq9miH+7+K8Z1GBbQmWQw8/4oERGfcfcQCHgb
         yZsXY/Zl1Qk3NemYhfAC8MP9idn+DA3N7MEI8Rh0AoyKgDpZL+UD77P0DUKwf5nHWTPl
         NGSw==
X-Gm-Message-State: ABy/qLYmL+glvZg3Fd3UbPmjiPFmrZSmkT2E85+tEjtjo4ipGerImMjw
        oLuphtHeVnwa4Mq/XV+AcEB0iXH949Z54Dlk2ISwRE/XWEOhJCXfEarEuBHPplYSmZ4w0w7cO73
        /ZKDUdgGX0EB/23Er4WiOAc3U
X-Received: by 2002:a2e:8395:0:b0:2b6:cd12:24f7 with SMTP id x21-20020a2e8395000000b002b6cd1224f7mr884486ljg.44.1690361063239;
        Wed, 26 Jul 2023 01:44:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGivoMJb3rHOFMuAoAgPn0XW9Wzaq8qlmesjJLgbyq+3Zktg6DeOrVA+y6Ym22wjs8s+JGDkg==
X-Received: by 2002:a2e:8395:0:b0:2b6:cd12:24f7 with SMTP id x21-20020a2e8395000000b002b6cd1224f7mr884474ljg.44.1690361062737;
        Wed, 26 Jul 2023 01:44:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f600:a519:c50:799b:f1e3? (p200300cbc705f600a5190c50799bf1e3.dip0.t-ipconnect.de. [2003:cb:c705:f600:a519:c50:799b:f1e3])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c229800b003fbcdba1a52sm1395286wmf.3.2023.07.26.01.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:44:22 -0700 (PDT)
Message-ID: <9ef757dc-da4b-9fa1-de84-1328a74f18a7@redhat.com>
Date:   Wed, 26 Jul 2023 10:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ross Zwisler <zwisler@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz> <20230719224821.GC3528218@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
In-Reply-To: <20230719224821.GC3528218@google.com>
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

On 20.07.23 00:48, Ross Zwisler wrote:
> On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
>> On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
>> [...]
>>> I do think that we need to fix this collision between ZONE_MOVABLE and memmap
>>> allocations, because this issue essentially makes the movablecore= kernel
>>> command line parameter useless in many cases, as the ZONE_MOVABLE region it
>>> creates will often actually be unmovable.
>>
>> movablecore is kinda hack and I would be more inclined to get rid of it
>> rather than build more into it. Could you be more specific about your
>> use case?
> 
> The problem that I'm trying to solve is that I'd like to be able to get kernel
> core dumps off machines (chromebooks) so that we can debug crashes.  Because
> the memory used by the crash kernel ("crashkernel=" kernel command line
> option) is consumed the entire time the machine is booted, there is a strong
> motivation to keep the crash kernel as small and as simple as possible.  To
> this end I'm trying to get away without SSD drivers, not having to worry about
> encryption on the SSDs, etc.

Okay, so you intend to keep the crashkernel area as small as possible.

> 
> So, the rough plan right now is:
>  > 1) During boot set aside some memory that won't contain kernel 
allocations.
> I'm trying to do this now with ZONE_MOVABLE, but I'm open to better ways.
> 
> We set aside memory for a crash kernel & arm it so that the ZONE_MOVABLE
> region (or whatever non-kernel region) will be set aside as PMEM in the crash
> kernel.  This is done with the memmap=nn[KMG]!ss[KMG] kernel command line
> parameter passed to the crash kernel.
> 
> So, in my sample 4G VM system, I see:
> 
>    # lsmem --split ZONES --output-all
>    RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
>    0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
>    0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
>    0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
>    0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
>    
>    Memory block size:       128M
>    Total online memory:       4G
>    Total offline memory:      0B
> 
> so I'll pass "memmap=256M!0x130000000" to the crash kernel.
> 
> 2) When we hit a kernel crash, we know (hope?) that the PMEM region we've set
> aside only contains user data, which we don't want to store anyway.  

I raised that in different context already, but such assumptions are not 
100% future proof IMHO. For example, we might at one point be able to 
make user page tables movable and place them on there.

But yes, most kernel data structures (which you care about) will 
probably never be movable and never end up on these regions.

> We make a
> filesystem in there, and create a kernel crash dump using 'makedumpfile':
> 
>    mkfs.ext4 /dev/pmem0
>    mount /dev/pmem0 /mnt
>    makedumpfile -c -d 31 /proc/vmcore /mnt/kdump
> 
> We then set up the next full kernel boot to also have this same PMEM region,
> using the same memmap kernel parameter.  We reboot back into a full kernel.
> 
> 3) The next full kernel will be a normal boot with a full networking stack,
> SSD drivers, disk encryption, etc.  We mount up our PMEM filesystem, pull out
> the kdump and either store it somewhere persistent or upload it somewhere.  We
> can then unmount the PMEM and reconfigure it back to system ram so that the
> live system isn't missing memory.
> 
>    ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
>    daxctl reconfigure-device --mode=system-ram dax0.0
> 
> This is the flow I'm trying to support, and have mostly working in a VM,
> except up until now makedumpfile would crash because all the memblock
> structures it needed were in the PMEM area that I had just wiped out by making
> a new filesystem. :)


Thinking out loud (and remembering that some architectures relocate the 
crashkernel during kexec, if I am not wrong), maybe the following would 
also work and make your setup eventually easier:

1) Don't reserve a crashkernel area in the traditional way, instead 
reserve that area using CMA. It can be used for MOVABLE allocations.

2) Let kexec load the crashkernel+initrd into ordinary memory only 
(consuming as much as you would need there).

3) On kexec, relocate the crashkernel+initrd into the CMA area 
(overwriting any movable data in there)

4) In makedumpfile, don't dump any memory that falls into the 
crashkernel area. It might already have been overwritten by the second 
kernel


Maybe that would allow you to make the crashkernel+initrd slightly 
bigger (to include SSD drivers etc.) and have a bigger crashkernel area, 
because while the crashkernel is armed it will only consume the 
crashkernel+initrd size and not the overall crashkernel area size.

If that makes any sense :)

-- 
Cheers,

David / dhildenb

