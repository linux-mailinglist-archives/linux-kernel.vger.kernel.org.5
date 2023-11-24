Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5852D7F7B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjKXSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9211BC2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700849057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=wtlnunH2yprur8muH+SUwlX3z2UI3HfpRsjd2wOAwPQ=;
        b=MsQnQSKq5CgOP2vDbw/smi8d1cIiwMAXTB4ZVTrDF/liEMN5YYipiUTW3gP55k5KjROU4s
        +MZHbZbt6E4iXihvUqHqCYeqEsSXCUjN1ZIY914qBp34Y+mMiCMPSxdHkcvfxYhHlQ6rOB
        zOuSba5iajFQmQsCqf+3GUndqBOwzek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-UdL2q99BNF2Bn_dflcLYiQ-1; Fri, 24 Nov 2023 13:04:16 -0500
X-MC-Unique: UdL2q99BNF2Bn_dflcLYiQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332ee20a40fso183249f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849055; x=1701453855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtlnunH2yprur8muH+SUwlX3z2UI3HfpRsjd2wOAwPQ=;
        b=Lm16GXaFZsgSmzOBMe7nH9twSMuOkSqOiumjV+9gFQPsc0XQVmFeyUPVi6Tl9YgR36
         kWeDu1Y59Y5paGly0dPDZ5rGdls5AqKgOWFB/7NDm39QGf52D+ejGBg8jtmwDumhSERH
         +xmJPJgatxWDQye8bfZz94uDA6M3tclJC27/B6mnkmO8Km3xkmoie9/WLZYVH+JXwKd3
         4miWeE4ZG8qOFZS04leJHkjL7msE34MBBDOyG9kQ78S8pZNXwvvbXAJxBtbn+gCmYoEZ
         gLoMPuyoIqf1z7kkcleV9dUyoNqJRz7kuUBdYcBggvwmNuPnBmtMnPsnczcB8GQdMbJK
         w6ng==
X-Gm-Message-State: AOJu0YxAMnsD991eLRTzFzLCc4U8gordFl3S5OAvY8FDK3BHgPB4cBQF
        vaRhblOextJgyQtX4omuvJgSyloXjSWnDe8kf8rkulUEfFJLhqqQ9bI8ihVvMQui4HO+mIz+DSw
        gq/1U+sesO6S5mcEANuJt2uxk
X-Received: by 2002:a5d:4f07:0:b0:32d:bf28:4519 with SMTP id c7-20020a5d4f07000000b0032dbf284519mr2574473wru.38.1700849055191;
        Fri, 24 Nov 2023 10:04:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZIOcPku4rSJ+fhdH/Pym7rimjmEuQFgYy+iFLK+1OH35/9JYQS4zQYWhN40Q/4L6R6HfGSw==
X-Received: by 2002:a5d:4f07:0:b0:32d:bf28:4519 with SMTP id c7-20020a5d4f07000000b0032dbf284519mr2574433wru.38.1700849054721;
        Fri, 24 Nov 2023 10:04:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000025700b00332ce0d7300sm4851696wrz.92.2023.11.24.10.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:04:14 -0800 (PST)
Message-ID: <98a8f9b9-79d6-4df1-8625-d6d65fc9b9f2@redhat.com>
Date:   Fri, 24 Nov 2023 19:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm/memory_hotplug: introduce mhp_flag
 MHP_OFFLINE_INACCESSIBLE
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
 <20231123092343.1703707-2-sumanthk@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231123092343.1703707-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.23 10:23, Sumanth Korikkar wrote:
> Introduce MHP_OFFLINE_INACCESSIBLE mhp_flag to mark the hotplugged
> memory block as inaccessible during the memory hotplug addition phase.
> With support for "memmap on memory", the altmap is prepared at this
> stage. Architectures like s390 anticipate that memmap should not be
> accessed until memory is physically accessible and is accessible only
> when it enters the memory hotplug onlining phase using the memory
> notifier.  Introduce the flag to inform the memory hotplug
> infrastructure that the memory remains inaccessible until the memory
> hotplug onlining phase begins.
> 
> Implementation considerations:
> mhp inaccessible flag is initially set in altmap. This is useful in
> arch_add_memory(). When the memory block device is added, the mhp
> inaccessible information is passed to memory_block. The flag is used in
> subsequent patch to avoid accessing memmap during memory hotplug
> addition phase.
> 
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   drivers/base/memory.c          |  2 ++
>   include/linux/memory.h         |  1 +
>   include/linux/memory_hotplug.h | 10 ++++++++++
>   include/linux/memremap.h       |  1 +
>   mm/memory_hotplug.c            |  3 ++-
>   5 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8a13babd826c..51915d5c3f88 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -774,6 +774,8 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
>   	mem->state = state;
>   	mem->nid = NUMA_NO_NODE;
>   	mem->altmap = altmap;
> +	if (altmap)
> +		mem->inaccessible = altmap->inaccessible;
>   	INIT_LIST_HEAD(&mem->group_next);
>   
>   #ifndef CONFIG_NUMA
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index f53cfdaaaa41..655714d4e65a 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -67,6 +67,7 @@ struct memory_group {
>   struct memory_block {
>   	unsigned long start_section_nr;
>   	unsigned long state;		/* serialized by the dev->lock */
> +	bool inaccessible;		/* during memory addition phase */

Is that really required? After all, the altmap is stored in the memory 
block and accessible there.

>   	int online_type;		/* for passing data to online routine */
>   	int nid;			/* NID for this memory block */
>   	/*
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7d2076583494..8988cd5ad55d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -106,6 +106,16 @@ typedef int __bitwise mhp_t;
>    * implies the node id (nid).
>    */
>   #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
> +/*
> + * Mark the hotplugged memory block as inaccessible during the memory hotplug
> + * addition phase. With support for "memmap on memory," the altmap is prepared
> + * at this stage. Architectures like s390 anticipate that memmap should not be
> + * accessed until memory is physically accessible and is accessible only when
> + * it enters the memory hotplug onlining phase using the memory notifier.
> + * Utilize this flag to inform the memory hotplug infrastructure that the
> + * memory remains inaccessible until the memory hotplug onlining phase begins.
> + */
> +#define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))

I'd suggest to squash all 3 patches. Then we can properly document here:

/*
  * The hotplugged memory is completely inaccessible while the memory is
  * offline. The memory provider will handle MEM_PREPARE_ONLINE /
  * MEM_FINISH_OFFLINE notifications and make the memory accessible.
  *
  * This flag is only relevant when used along with MHP_MEMMAP_ON_MEMORY,
  * because the altmap cannot be written (e.g., poisoned) when adding
  * memory -- before it is set online.
  *
  * This allows for adding memory with an altmap that is not currently
  * made available by a hypervisor. When onlining that memory, the
  * hypervisor can be instructed to make that memory available, and
  * the onlining phase will not require any memory allocations, which is
  * helpful in low-memory situations.
  */


Cheers,

David / dhildenb

