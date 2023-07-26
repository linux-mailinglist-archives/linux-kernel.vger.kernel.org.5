Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF576346D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGZLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGZLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B94AC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E859061A6D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E195C433C7;
        Wed, 26 Jul 2023 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690369308;
        bh=E9Nptia/LKz60/XHD5d/zhhnmMiksgZ3DAeI9Q4oeaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHN9Tt5r+ufFlJiEtRTftRJM4y3eXwbo4n8rhYaootGrDHqyk/IqAQBJkXRdMhy+D
         qTLii4YgzJFefLZfLuWR/NdTpSZR1lMjy8KcSm4L/2TWx6yd5A6Ab8vdG7W9P+Jn0b
         Msw0zEnXTTXFQ34UfegBqoa+fqxL3A9Cw94S/nnmuN9JT2PsGuKB+GdPmtHO2JC82L
         FTBQmVPYjXxoSK0r8QnBiwnd9RBiQLXLPsfbxafQu8zkqMSAxEABQDRyJWGNlU+zMU
         g9juIJUkV42hO4VvCYh8/q3ly25barX0HmBImE1S5sNcf+2H4QWV+ujgX826Ymg0mZ
         yYP61TSRVid4Q==
Date:   Wed, 26 Jul 2023 14:01:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
Subject: Re: [RFC 2/4] mm/memblock: Add hugepage_size member to struct
 memblock_region
Message-ID: <20230726110113.GT1901145@kernel.org>
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
 <20230724134644.1299963-3-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724134644.1299963-3-usama.arif@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:46:42PM +0100, Usama Arif wrote:
> This propagates the hugepage size from the memblock APIs
> (memblock_alloc_try_nid_raw and memblock_alloc_range_nid)
> so that it can be stored in struct memblock region. This does not
> introduce any functional change and hugepage_size is not used in
> this commit. It is just a setup for the next commit where huge_pagesize
> is used to skip initialization of struct pages that will be freed later
> when HVO is enabled.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  arch/arm64/mm/kasan_init.c                   |  2 +-
>  arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
>  arch/powerpc/platforms/pseries/setup.c       |  4 +-
>  arch/powerpc/sysdev/dart_iommu.c             |  2 +-
>  include/linux/memblock.h                     |  8 ++-
>  mm/cma.c                                     |  4 +-
>  mm/hugetlb.c                                 |  6 +-
>  mm/memblock.c                                | 60 ++++++++++++--------
>  mm/mm_init.c                                 |  2 +-
>  mm/sparse-vmemmap.c                          |  2 +-
>  tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
>  11 files changed, 56 insertions(+), 38 deletions(-)
> 

[ snip ]

> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f71ff9f0ec81..bb8019540d73 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -63,6 +63,7 @@ struct memblock_region {
>  #ifdef CONFIG_NUMA
>  	int nid;
>  #endif
> +	phys_addr_t hugepage_size;
>  };
>  
>  /**
> @@ -400,7 +401,8 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>  				      phys_addr_t start, phys_addr_t end);
>  phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
>  				      phys_addr_t align, phys_addr_t start,
> -				      phys_addr_t end, int nid, bool exact_nid);
> +				      phys_addr_t end, int nid, bool exact_nid,
> +				      phys_addr_t hugepage_size);

Rather than adding yet another parameter to memblock_phys_alloc_range() we
can have an API that sets a flag on the reserved regions.
With this the hugetlb reservation code can set a flag when HVO is
enabled and memmap_init_reserved_pages() will skip regions with this flag
set.

>  phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
>  
>  static __always_inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
> @@ -415,7 +417,7 @@ void *memblock_alloc_exact_nid_raw(phys_addr_t size, phys_addr_t align,
>  				 int nid);
>  void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
>  				 phys_addr_t min_addr, phys_addr_t max_addr,
> -				 int nid);
> +				 int nid, phys_addr_t hugepage_size);
>  void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
>  			     phys_addr_t min_addr, phys_addr_t max_addr,
>  			     int nid);
> @@ -431,7 +433,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
>  {
>  	return memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
>  					  MEMBLOCK_ALLOC_ACCESSIBLE,
> -					  NUMA_NO_NODE);
> +					  NUMA_NO_NODE, 0);
>  }
>  
>  static inline void *memblock_alloc_from(phys_addr_t size,

-- 
Sincerely yours,
Mike.
