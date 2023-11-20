Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17307F10DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjKTKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjKTKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:53:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027B85;
        Mon, 20 Nov 2023 02:53:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6966BC433C7;
        Mon, 20 Nov 2023 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700477635;
        bh=HhF2KIDMcbbUUAZtfLMLqJsElj3AalZ+cqqnLIVIAng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fg6mfCLgufySQN6C9npx9P6b4RQCgtDXcdGM7+LeV2vo75d3dQQz2mKYMPXT/Uh5u
         VrJ2/Uj3Ewc3rAq6bud1QRZFN7juG3uUHgRJyyyWM1irohx/bXivzpeybcz4IoL4U7
         c1UrnWuC/2/ypX5BbEUi9fYxxPNmu9Eus/uIMuBs=
Date:   Mon, 20 Nov 2023 11:53:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/memory_hotplug: add missing mem_hotplug_lock
Message-ID: <2023112041-kelp-properly-2b6e@gregkh>
References: <20231120102734.2001576-1-sumanthk@linux.ibm.com>
 <20231120102734.2001576-2-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120102734.2001576-2-sumanthk@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:27:32AM +0100, Sumanth Korikkar wrote:
> >From Documentation/core-api/memory-hotplug.rst:
> When adding/removing/onlining/offlining memory or adding/removing
> heterogeneous/device memory, we should always hold the mem_hotplug_lock
> in write mode to serialise memory hotplug (e.g. access to global/zone
> variables).
> 
> mhp_(de)init_memmap_on_memory() functions can change zone stats and
> struct page content, but they are currently called w/o the
> mem_hotplug_lock.
> 
> When memory block is being offlined and when kmemleak goes through each
> populated zone, the following theoretical race conditions could occur:
> CPU 0:					     | CPU 1:
> memory_offline()			     |
> -> offline_pages()			     |
> 	-> mem_hotplug_begin()		     |
> 	   ...				     |
> 	-> mem_hotplug_done()		     |
> 					     | kmemleak_scan()
> 					     | -> get_online_mems()
> 					     |    ...
> -> mhp_deinit_memmap_on_memory()	     |
>   [not protected by mem_hotplug_begin/done()]|
>   Marks memory section as offline,	     |   Retrieves zone_start_pfn
>   poisons vmemmap struct pages and updates   |   and struct page members.
>   the zone related data			     |
>    					     |    ...
>    					     | -> put_online_mems()
> 
> Fix this by ensuring mem_hotplug_lock is taken before performing
> mhp_init_memmap_on_memory(). Also ensure that
> mhp_deinit_memmap_on_memory() holds the lock.
> 
> online/offline_pages() are currently only called from
> memory_block_online/offline(), so it is safe to move the locking there.
> 
> Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  drivers/base/memory.c | 18 +++++++++++++++---
>  mm/memory_hotplug.c   | 13 ++++++-------
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f3b9a4d0fa3b..8a13babd826c 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -180,6 +180,9 @@ static inline unsigned long memblk_nr_poison(struct memory_block *mem)
>  }
>  #endif
>  
> +/*
> + * Must acquire mem_hotplug_lock in write mode.
> + */
>  static int memory_block_online(struct memory_block *mem)
>  {
>  	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> @@ -204,10 +207,11 @@ static int memory_block_online(struct memory_block *mem)
>  	if (mem->altmap)
>  		nr_vmemmap_pages = mem->altmap->free;
>  
> +	mem_hotplug_begin();
>  	if (nr_vmemmap_pages) {
>  		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	}
>  
>  	ret = online_pages(start_pfn + nr_vmemmap_pages,
> @@ -215,7 +219,7 @@ static int memory_block_online(struct memory_block *mem)
>  	if (ret) {
>  		if (nr_vmemmap_pages)
>  			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
> -		return ret;
> +		goto out;
>  	}
>  
>  	/*
> @@ -227,9 +231,14 @@ static int memory_block_online(struct memory_block *mem)
>  					  nr_vmemmap_pages);
>  
>  	mem->zone = zone;
> +out:
> +	mem_hotplug_done();
>  	return ret;
>  }
>  
> +/*
> + * Must acquire mem_hotplug_lock in write mode.
> + */
>  static int memory_block_offline(struct memory_block *mem)
>  {
>  	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> @@ -247,6 +256,7 @@ static int memory_block_offline(struct memory_block *mem)
>  	if (mem->altmap)
>  		nr_vmemmap_pages = mem->altmap->free;
>  
> +	mem_hotplug_begin();
>  	if (nr_vmemmap_pages)
>  		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
>  					  -nr_vmemmap_pages);
> @@ -258,13 +268,15 @@ static int memory_block_offline(struct memory_block *mem)
>  		if (nr_vmemmap_pages)
>  			adjust_present_page_count(pfn_to_page(start_pfn),
>  						  mem->group, nr_vmemmap_pages);
> -		return ret;
> +		goto out;
>  	}
>  
>  	if (nr_vmemmap_pages)
>  		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
>  
>  	mem->zone = NULL;
> +out:
> +	mem_hotplug_done();
>  	return ret;
>  }
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1b03f4ec6fd2..c8238fc5edcb 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1129,6 +1129,9 @@ void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
>  	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
>  }
>  
> +/*
> + * Must be called with mem_hotplug_lock in write mode.
> + */
>  int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		       struct zone *zone, struct memory_group *group)
>  {
> @@ -1149,7 +1152,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
> -	mem_hotplug_begin();
>  
>  	/* associate pfn range with the zone */
>  	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
> @@ -1208,7 +1210,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	writeback_set_ratelimit();
>  
>  	memory_notify(MEM_ONLINE, &arg);
> -	mem_hotplug_done();
>  	return 0;
>  
>  failed_addition:
> @@ -1217,7 +1218,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
>  	memory_notify(MEM_CANCEL_ONLINE, &arg);
>  	remove_pfn_range_from_zone(zone, pfn, nr_pages);
> -	mem_hotplug_done();
>  	return ret;
>  }
>  
> @@ -1863,6 +1863,9 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  	return 0;
>  }
>  
> +/*
> + * Must be called with mem_hotplug_lock in write mode.
> + */
>  int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  			struct zone *zone, struct memory_group *group)
>  {
> @@ -1885,8 +1888,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
> -	mem_hotplug_begin();
> -
>  	/*
>  	 * Don't allow to offline memory blocks that contain holes.
>  	 * Consequently, memory blocks with holes can never get onlined
> @@ -2027,7 +2028,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  
>  	memory_notify(MEM_OFFLINE, &arg);
>  	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
> -	mem_hotplug_done();
>  	return 0;
>  
>  failed_removal_isolated:
> @@ -2042,7 +2042,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>  		 reason);
> -	mem_hotplug_done();
>  	return ret;
>  }
>  
> -- 
> 2.41.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
