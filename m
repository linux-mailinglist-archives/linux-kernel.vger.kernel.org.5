Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F6F76632B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjG1Eb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjG1EbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A41FFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690518633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqviSGXIb7Tqt0NEZdsJaNkD5vh2uKzL/1s+FdO+i5k=;
        b=fC0tkbKy1HiJRm1s8yUxNQuKVL3kcJ9Leo+yHNzZXURa9smmZoNqzfDdxuJDnotU0f6RMM
        EKGGZWdWnUtrgqjNR4saSztMBJf0hA+fjggWCtcXXTSYKAh1jrwOuHx/eY3W4MBcynoEkC
        Dks3bOmDDMpJdJzdQpCIgpqe8D3tyww=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-5yfqnNDgOIWvnri24YVGCA-1; Fri, 28 Jul 2023 00:30:32 -0400
X-MC-Unique: 5yfqnNDgOIWvnri24YVGCA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6fdb7eeafso14369881fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690518631; x=1691123431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqviSGXIb7Tqt0NEZdsJaNkD5vh2uKzL/1s+FdO+i5k=;
        b=MoT1EKgfgDMk342lAtd7NI3s/3h3a9WHnuDwlJJZYt3C8Ln/LLsHqmekX7+V05a6ZA
         GfrB9nB7G3u3dDM+m4Dz2P2RQgr5W23+EydFON4fEQ/ct6j7qB4rqDR1uQkuaSoArtsV
         cJkpRAVzP5nhLz2TudNDTQ0UwtdOjbSXrpnVfbqIv2m3mNJEJzMF/XwuhdHV8GAVu/cx
         5tISdr2qpo4Zhy5fiGcAiy/RfM7q4zxAI5EGC81dk1GAknkiztJenqqm+eoS/XH0ORFL
         v4EKg+0hl00TdNiZVUAOT7pGg0aD6Z3vfRfv+ddfb87t+VOL7FOg7d6hrw7uOR5I7h6r
         3AAw==
X-Gm-Message-State: ABy/qLZIpysaAqo6IIcHg3pJlVBp4DiPvzYcA7VOK/ENZi/cf/ofVThw
        lCgZjR2EYcq93rwl0K2ZP7Q42F9ASKLxG27BlS3947sDTTC1BJVMdezepGhuJ9Na1XfK0l5aU7N
        IGQ547I/U15hmU4PkCaP3EXc=
X-Received: by 2002:a2e:7410:0:b0:2b9:c55f:f24e with SMTP id p16-20020a2e7410000000b002b9c55ff24emr651096ljc.52.1690518630909;
        Thu, 27 Jul 2023 21:30:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPBGh2+4NUMNrZs/Y80pwXkiBchQVPupt4ninzotlZR03t/gk8gqwtImPmZPiAQiE/nZAs7A==
X-Received: by 2002:a2e:7410:0:b0:2b9:c55f:f24e with SMTP id p16-20020a2e7410000000b002b9c55ff24emr651087ljc.52.1690518630590;
        Thu, 27 Jul 2023 21:30:30 -0700 (PDT)
Received: from [192.168.1.86] (85-23-20-79.bb.dnainternet.fi. [85.23.20.79])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e7407000000b002b9342fcd62sm694944ljc.67.2023.07.27.21.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 21:30:29 -0700 (PDT)
Message-ID: <55750855-0029-b10f-3317-e6ae4d89d492@redhat.com>
Date:   Fri, 28 Jul 2023 07:30:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v1 4/6] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Content-Language: en-US
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-5-usama.arif@bytedance.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20230727204624.1942372-5-usama.arif@bytedance.com>
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

Hi,

On 7/27/23 23:46, Usama Arif wrote:

> For reserved memory regions marked with this flag,
> reserve_bootmem_region is not called during memmap_init_reserved_pages.
> This can be used to avoid struct page initialization for
> regions which won't need them, for e.g. hugepages with
> HVO enabled.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>   include/linux/memblock.h |  7 +++++++
>   mm/memblock.c            | 32 ++++++++++++++++++++++++++------
>   2 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f71ff9f0ec81..7f9d06c08592 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -47,6 +47,7 @@ enum memblock_flags {
>   	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>   	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>   	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't call reserve_bootmem_region for this region */
>   };
>   
>   /**
> @@ -125,6 +126,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> +int memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size);
>   
>   void memblock_free_all(void);
>   void memblock_free(void *ptr, size_t size);
> @@ -259,6 +261,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
>   	return m->flags & MEMBLOCK_NOMAP;
>   }
>   
> +static inline bool memblock_is_noinit(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_RSRV_NOINIT;
> +}
> +
>   static inline bool memblock_is_driver_managed(struct memblock_region *m)
>   {
>   	return m->flags & MEMBLOCK_DRIVER_MANAGED;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 4fd431d16ef2..3a15708af3b6 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -997,6 +997,22 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>   	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
>   }
>   
> +/**
> + * memblock_rsrv_mark_noinit - Mark a reserved memory region with flag MEMBLOCK_RSRV_NOINIT.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * For memory regions marked with %MEMBLOCK_RSRV_NOINIT, reserve_bootmem_region
> + * is not called during memmap_init_reserved_pages, hence struct pages are not
> + * initialized for this region.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_RSRV_NOINIT, 1);
> +}
> +
>   static bool should_skip_region(struct memblock_type *type,
>   			       struct memblock_region *m,
>   			       int nid, int flags)
> @@ -2113,13 +2129,17 @@ static void __init memmap_init_reserved_pages(void)
>   		memblock_set_node(start, end, &memblock.reserved, nid);
>   	}
>   
> -	/* initialize struct pages for the reserved regions */
> +	/*
> +	 * initialize struct pages for reserved regions that don't have
> +	 * the MEMBLOCK_RSRV_NOINIT flag set
> +	 */
>   	for_each_reserved_mem_region(region) {
> -		nid = memblock_get_region_node(region);
> -		start = region->base;
> -		end = start + region->size;
> -
> -		reserve_bootmem_region(start, end, nid);
> +		if (!memblock_is_noinit(region)) {
> +			nid = memblock_get_region_node(region);
> +			start = region->base;
> +			end = start + region->size;
> +			reserve_bootmem_region(start, end, nid);
> +		}
>   	}
>   }
>   

There's code like:

static inline void free_vmemmap_page(struct page *page)
{
         if (PageReserved(page))
                 free_bootmem_page(page);
         else
                 __free_page(page);
}

which depends on the PageReserved being in vmempages pages, so I think you can't skip that part?

--Mika


