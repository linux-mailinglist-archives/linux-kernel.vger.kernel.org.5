Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B87CE51E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjJRRnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJRRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:43:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1105210E0;
        Wed, 18 Oct 2023 10:42:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937EC2F4;
        Wed, 18 Oct 2023 10:42:59 -0700 (PDT)
Received: from [10.57.67.203] (unknown [10.57.67.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10BE03F5A1;
        Wed, 18 Oct 2023 10:42:14 -0700 (PDT)
Message-ID: <b4dc423b-a658-449f-9c6d-1502685a2f1b@arm.com>
Date:   Wed, 18 Oct 2023 18:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Content-Language: en-GB
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
 <20231017202505.340906-7-rick.p.edgecombe@intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231017202505.340906-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-17 21:25, Rick Edgecombe wrote:
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> 
> DMA could free decrypted/shared pages if set_memory_decrypted() fails.
> Use the recently added free_decrypted_pages() to avoid this.
> 
> Several paths also result in proper encrypted pages being freed through
> the same freeing function. Rely on free_decrypted_pages() to not leak the
> memory in these cases.

If something's needed in the fallback path here, what about the 
cma_release() paths?

Thanks,
Robin.

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>   include/linux/dma-map-ops.h | 3 ++-
>   kernel/dma/contiguous.c     | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index f2fc203fb8a1..b0800cbbc357 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -9,6 +9,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/pgtable.h>
>   #include <linux/slab.h>
> +#include <linux/set_memory.h>
>   
>   struct cma;
>   
> @@ -165,7 +166,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>   static inline void dma_free_contiguous(struct device *dev, struct page *page,
>   		size_t size)
>   {
> -	__free_pages(page, get_order(size));
> +	free_decrypted_pages((unsigned long)page_address(page), get_order(size));
>   }
>   #endif /* CONFIG_DMA_CMA*/
>   
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index f005c66f378c..e962f1f6434e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -429,7 +429,7 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>   	}
>   
>   	/* not in any cma, free from buddy */
> -	__free_pages(page, get_order(size));
> +	free_decrypted_pages((unsigned long)page_address(page), get_order(size));
>   }
>   
>   /*
