Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E212778FA5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjIAI7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjIAI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:59:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A98C210D4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:59:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16CFCFEC;
        Fri,  1 Sep 2023 02:00:05 -0700 (PDT)
Received: from [10.57.5.33] (unknown [10.57.5.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA863FBD2;
        Fri,  1 Sep 2023 01:59:25 -0700 (PDT)
Message-ID: <195129eb-6bf1-3321-de62-2963765496f3@arm.com>
Date:   Fri, 1 Sep 2023 09:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dma/pool: trivial: add semicolon after label
 attributes
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Chunhui He <hchunhui@mail.ustc.edu.cn>
Cc:     hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
 <20230829151216.GA4211@lst.de> <d5ef27f1-9e6d-5e3c-b7ea-4b0abca623ed@arm.com>
 <20230831.115937.924195103727242070.hchunhui@mail.ustc.edu.cn>
 <f3bec3b9-e938-bea4-f89f-b0b698c4e302@arm.com>
In-Reply-To: <f3bec3b9-e938-bea4-f89f-b0b698c4e302@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-01 09:56, Robin Murphy wrote:
> On 2023-08-31 12:59, Chunhui He wrote:
>>
>> On Tue, 29 Aug 2023 16:28:05 +0100, Robin Murphy 
>> <robin.murphy@arm.com> wrote:
>>> On 29/08/2023 4:12 pm, Christoph Hellwig wrote:
>>>> On Tue, Aug 29, 2023 at 03:22:22PM +0100, Robin Murphy wrote:
>>>>> AFAICS, what that clearly says is that *C++* label attributes can be
>>>>> ambiguous. This is not C++ code. Even in C11, declarations still
>>>>> cannot be
>>>>> labelled, so it should still be the case that, per the same GCC
>>>>> documentation, "the ambiguity does not arise". And even if the
>>>>> language did
>>>>> allow it, an inline declaration at that point at the end of a function
>>>>> would be downright weird and against the kernel coding style anyway.
>>>>>
>>>>> So, I don't really see what's "better" about cluttering up C code with
>>>>> unnecessary C++isms; it's just weird noise to me. The only thing I
>>>>> think it
>>>>> *does* achieve is introduce the chance that the static checker brigade
>>>>> eventually identifies a redundant semicolon and we get more patches to
>>>>> remove it again.
>>
>> Inline declaration is a GNU C extension, so the ambiguity may arise.
>> Adding ';' makes the compiler easier to parse correctly, so I say
>> "better". The commit 13a453c241b78934a945b1af572d0533612c9bd1
>> (sched/fair: Add ';' after label attributes) also says the same.
> 
> And that commit was also wrong. Nobody suggested C11 doesn't support 
> inline declarations - it demonstrably does - the fact in question is 
> that *attributes* on declarations is a C++ thing and not valid in C:

Argh, sorry, s/attributes/labels/

/me goes to make more coffee...

Robin.

> ~/src/linux$ git diff
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 1acec2e22827..e1354235cb9c 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -137,7 +137,8 @@ static int atomic_pool_expand(struct gen_pool *pool, 
> size_t pool_size,
>          dma_common_free_remap(addr, pool_size);
>   #endif
>   free_page: __maybe_unused
> -       __free_pages(page, order);
> +       int x = order;
> +       __free_pages(page, x);
>   out:
>          return ret;
>   }
> ~/src/linux$ make -j32
>    CALL    scripts/checksyscalls.sh
>    CC      kernel/dma/pool.o
> kernel/dma/pool.c: In function ‘atomic_pool_expand’:
> kernel/dma/pool.c:140:2: error: a label can only be part of a statement 
> and a declaration is not a statement
>    140 |  int x = order;
>        |  ^~~
> make[4]: *** [scripts/Makefile.build:243: kernel/dma/pool.o] Error 1
> make[3]: *** [scripts/Makefile.build:480: kernel/dma] Error 2
> make[2]: *** [scripts/Makefile.build:480: kernel] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/home/robmur01/src/linux/Makefile:2032: .] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> 
> Thanks,
> Robin.
> 
