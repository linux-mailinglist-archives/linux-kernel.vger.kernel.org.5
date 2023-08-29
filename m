Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38CB78C85E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjH2PM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjH2PMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:12:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA741BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:12:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7405D6732D; Tue, 29 Aug 2023 17:12:16 +0200 (CEST)
Date:   Tue, 29 Aug 2023 17:12:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chunhui He <hchunhui@mail.ustc.edu.cn>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma/pool: trivial: add semicolon after label
 attributes
Message-ID: <20230829151216.GA4211@lst.de>
References: <20230826085317.69713-1-hchunhui@mail.ustc.edu.cn> <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:22:22PM +0100, Robin Murphy wrote:
> AFAICS, what that clearly says is that *C++* label attributes can be 
> ambiguous. This is not C++ code. Even in C11, declarations still cannot be 
> labelled, so it should still be the case that, per the same GCC 
> documentation, "the ambiguity does not arise". And even if the language did 
> allow it, an inline declaration at that point at the end of a function 
> would be downright weird and against the kernel coding style anyway.
>
> So, I don't really see what's "better" about cluttering up C code with 
> unnecessary C++isms; it's just weird noise to me. The only thing I think it 
> *does* achieve is introduce the chance that the static checker brigade 
> eventually identifies a redundant semicolon and we get more patches to 
> remove it again.

Agreed.  Even more importantly that attribute looks rather questionable
to start with as it can be dropped by just moving the #endif a little:

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1acec2e228273f..da03c4a57cebe3 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -135,8 +135,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
+free_page:
 #endif
-free_page: __maybe_unused
 	__free_pages(page, order);
 out:
 	return ret;
