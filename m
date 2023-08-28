Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11478A6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjH1Hit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjH1HiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F6103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C75263281
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBE7C433C7;
        Mon, 28 Aug 2023 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693208293;
        bh=TN7wbrdH1LLCxeTtgWlrErpBeefbe8IFjcDcJDLmDEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSS8T3rd6ZgEuKWd2MhhYQ+WddolJ03LE7uXp9cgN1nypR51eQpff7SMTGA1DgR2/
         VExGTDeVRgrXtpGyEDRLu7lQUOrkNOj6Cfy7KDKDfVC9M0CT4b8yxdmZGsrb4N7rOF
         zSE8lvQ/RdKQ2u1Aax3I3OSa2jRnDvlyUNI404Mhj45+th5XcHT0HhdrecJJd0Fwq2
         KiSVBF4oJYLgGFhPAKdQ97tzOxoS9ufgUH2UgC7h8MQLjqAsxUTY/W4Ip/9gdsL7+S
         SPfHYkLKkTJ+VYgmr6OShOTtk/oyH8gfkX9XepqdzWh1wWMjuPuwFNcIkt2tj4g8HM
         Q27IBYXKf6BSA==
Date:   Mon, 28 Aug 2023 10:37:39 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v3 2/4] memblock: pass memblock_type to memblock_setclr_flag
Message-ID: <20230828073739.GB3223@kernel.org>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-3-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825111836.1715308-3-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:18:34PM +0100, Usama Arif wrote:
> This allows setting flags to both memblock types and is in preparation for
> setting flags (for e.g. to not initialize struct pages) on reserved
> memory region.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/memblock.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index f9e61e565a53..43cb4404d94c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -896,10 +896,9 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>   *
>   * Return: 0 on success, -errno on failure.
>   */
> -static int __init_memblock memblock_setclr_flag(phys_addr_t base,
> -				phys_addr_t size, int set, int flag)
> +static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
> +				phys_addr_t base, phys_addr_t size, int set, int flag)
>  {
> -	struct memblock_type *type = &memblock.memory;
>  	int i, ret, start_rgn, end_rgn;
>  
>  	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
> @@ -928,7 +927,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>   */
>  int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG);
> +	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_HOTPLUG);
>  }
>  
>  /**
> @@ -940,7 +939,7 @@ int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
> +	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_HOTPLUG);
>  }
>  
>  /**
> @@ -957,7 +956,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>  
>  	system_has_some_mirror = true;
>  
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
> +	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_MIRROR);
>  }
>  
>  /**
> @@ -977,7 +976,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> +	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
>  }
>  
>  /**
> @@ -989,7 +988,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>  {
> -	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
> +	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
>  }
>  
>  static bool should_skip_region(struct memblock_type *type,
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
