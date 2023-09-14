Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C279FBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjINGNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjINGNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:13:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E45DF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85377C433C8;
        Thu, 14 Sep 2023 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694672009;
        bh=hxjVQjecSSBe4DgtU67qykRXre0HLHIWQ7IopGfkXIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMZ42zVuZeVBPvF/ovSnME9MEwonKV0Q8UIOkcNbr3tfciVQbjrR4AkwdJeT4gTxe
         xAHTUJGLWfpECZvE5RC6RTKQkZxWi3Jyq8SAUnb5IFTiw3+sVapzz0DNEJBmq0A81E
         OV6wLOsAtH2exc5S2F2VmxKlyOJ+CddmobuQpEmKuN8iSRbFOe4AApDxkFpJ2RpERU
         Wz3uaszxFyEPyAVBEARffhTgwURrUHL8F8bfk83wLtZ46sDU02Y077crT1DL9Y9Zrx
         PHA+vEhOuHpaemgoV8q2AjasocHfOlVWkjxEz/+S4C5BSSVoGxpcwxrzSEv6WTc2AD
         8kUYtQbb9D7pw==
Date:   Thu, 14 Sep 2023 09:12:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, open list <linux-kernel@vger.kernel.org>,
        "open list:MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH] memblock tests: Fix compilation errors.
Message-ID: <20230914061254.GB3303@kernel.org>
References: <tencent_6F19BC082167F15DF2A8D8BEFE8EF220F60A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6F19BC082167F15DF2A8D8BEFE8EF220F60A@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:32:56PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> This patch fix the follow errors.
> 
> commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region()") pass nid
> parameter to reserve_bootmem_region(),
> 
>     $ make -C tools/testing/memblock/
>     ...
>     memblock.c: In function ‘memmap_init_reserved_pages’:
>     memblock.c:2111:25: error: too many arguments to function ‘reserve_bootmem_region’
>     2111 |                         reserve_bootmem_region(start, end, nid);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~
>     ../../include/linux/mm.h:32:6: note: declared here
>     32 | void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
>        |      ^~~~~~~~~~~~~~~~~~~~~~
>     memblock.c:2122:17: error: too many arguments to function ‘reserve_bootmem_region’
>     2122 |                 reserve_bootmem_region(start, end, nid);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~
> 
> commit dcdfdd40fa82("mm: Add support for unaccepted memory") call
> accept_memory() in memblock.c
> 
>     $ make -C tools/testing/memblock/
>     ...
>     cc -fsanitize=address -fsanitize=undefined  main.o memblock.o \
>      lib/slab.o mmzone.o slab.o tests/alloc_nid_api.o \
>      tests/alloc_helpers_api.o tests/alloc_api.o tests/basic_api.o \
>      tests/common.o tests/alloc_exact_nid_api.o   -o main
>     /usr/bin/ld: memblock.o: in function `memblock_alloc_range_nid':
>     memblock.c:(.text+0x7ae4): undefined reference to `accept_memory'
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Applied, thanks!

> ---
>  tools/include/linux/mm.h          | 2 +-
>  tools/testing/memblock/internal.h | 4 ++++
>  tools/testing/memblock/mmzone.c   | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
> index a03d9bba5151..2bc94079d616 100644
> --- a/tools/include/linux/mm.h
> +++ b/tools/include/linux/mm.h
> @@ -29,7 +29,7 @@ static inline void *phys_to_virt(unsigned long address)
>  	return __va(address);
>  }
>  
> -void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
> +void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
>  
>  static inline void totalram_pages_inc(void)
>  {
> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
> index fdb7f5db7308..f6c6e5474c3a 100644
> --- a/tools/testing/memblock/internal.h
> +++ b/tools/testing/memblock/internal.h
> @@ -20,4 +20,8 @@ void memblock_free_pages(struct page *page, unsigned long pfn,
>  {
>  }
>  
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +}
> +
>  #endif
> diff --git a/tools/testing/memblock/mmzone.c b/tools/testing/memblock/mmzone.c
> index 7b0909e8b759..d3d58851864e 100644
> --- a/tools/testing/memblock/mmzone.c
> +++ b/tools/testing/memblock/mmzone.c
> @@ -11,7 +11,7 @@ struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
>  	return NULL;
>  }
>  
> -void reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
> +void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid)
>  {
>  }
>  
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.
