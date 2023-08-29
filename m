Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2414778C896
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbjH2P23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbjH2P2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:28:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D451132
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:28:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 043A92F4;
        Tue, 29 Aug 2023 08:28:51 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0FB73F738;
        Tue, 29 Aug 2023 08:28:10 -0700 (PDT)
Message-ID: <d5ef27f1-9e6d-5e3c-b7ea-4b0abca623ed@arm.com>
Date:   Tue, 29 Aug 2023 16:28:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dma/pool: trivial: add semicolon after label
 attributes
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chunhui He <hchunhui@mail.ustc.edu.cn>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230826085317.69713-1-hchunhui@mail.ustc.edu.cn>
 <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com> <20230829151216.GA4211@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230829151216.GA4211@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 4:12 pm, Christoph Hellwig wrote:
> On Tue, Aug 29, 2023 at 03:22:22PM +0100, Robin Murphy wrote:
>> AFAICS, what that clearly says is that *C++* label attributes can be
>> ambiguous. This is not C++ code. Even in C11, declarations still cannot be
>> labelled, so it should still be the case that, per the same GCC
>> documentation, "the ambiguity does not arise". And even if the language did
>> allow it, an inline declaration at that point at the end of a function
>> would be downright weird and against the kernel coding style anyway.
>>
>> So, I don't really see what's "better" about cluttering up C code with
>> unnecessary C++isms; it's just weird noise to me. The only thing I think it
>> *does* achieve is introduce the chance that the static checker brigade
>> eventually identifies a redundant semicolon and we get more patches to
>> remove it again.
> 
> Agreed.  Even more importantly that attribute looks rather questionable
> to start with as it can be dropped by just moving the #endif a little:
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 1acec2e228273f..da03c4a57cebe3 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -135,8 +135,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   remove_mapping:
>   #ifdef CONFIG_DMA_DIRECT_REMAP
>   	dma_common_free_remap(addr, pool_size);
> +free_page:
>   #endif
> -free_page: __maybe_unused
>   	__free_pages(page, order);
>   out:
>   	return ret;

Oh, indeed - I hadn't really looked at the context itself. My 
non-exhaustive grep skills show a couple of hundred instances of 
label-above-#endif vs. three (!) instances of __maybe_unused, so ack to 
making that cleanup to just remove the question entirely.

Cheers,
Robin.
